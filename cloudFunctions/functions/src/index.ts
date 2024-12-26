/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import { auth } from "firebase-admin";
import { initializeApp } from "firebase-admin/app";
import { DocumentReference, getFirestore } from "firebase-admin/firestore";
import { CallableRequest, onCall } from "firebase-functions/v2/https";

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

initializeApp();

interface CoordinatorData {
  name: string;
  email: string;
  password: string;
  districtId: string;
}

interface District {
  name: string;
}

interface FamilyData {
  name: string;
  contact: string;
  address: string;
  districtId: string;
}

const isAdmin = async (data: CallableRequest) => {
  const adminDoc = await getFirestore()
    .collection("admins")
    .doc(data?.auth?.uid || "")
    .get();
  return adminDoc.exists;
};

const isCoordinator = async (data: CallableRequest) => {
  const coordinatorDoc = await getFirestore()
    .collection("coordinators")
    .doc(data?.auth?.uid || "")
    .get();
  return coordinatorDoc.exists;
};

interface User {
  permission: "admin" | "coordinator" | "volunteer";
  uid: string;
  name?: string;
  family?: {
    name: string;
    address: string;
    contact: string;
  };
  district?: {
    id: string;
    name: string;
  };
}

export const getCurrentUser = onCall(async (data, context) => {
  const user: User = {} as User;
  if (!data.auth) return user;
  user.uid = data.auth.uid;
  if (await isAdmin(data)) {
    user.permission = "admin";
  } else if (await isCoordinator(data)) {
    user.permission = "coordinator";
    const coordinatorDocument = await getFirestore()
      .doc(`coordinators/${data.auth.uid}`)
      .get();

    const district: DocumentReference = coordinatorDocument.data()?.district;
    console.log("district", (await district.get()).data()?.name);
    user.district = {
      id: district.id,
      name: (await district.get()).data()?.name,
    };
  } else {
    const volunteer = await getFirestore()
      .collection("volunteers")
      .doc(data.auth?.uid)
      .get();

    console.log("family data", volunteer.data()?.family);

    user.permission = "volunteer";
    user.family = volunteer.data()?.family;
  }

  return user;

  //return volunteer data
});

export const createCoordinator = onCall<CoordinatorData>(
  async (data, context) => {
    if (await isAdmin(data)) {
      const newCoordinator = await auth().createUser({
        email: data.data.email,
        password: data.data.password,
        displayName: data.data.name,
      });

      const district = await getFirestore()
        .collection("districts")
        .doc(data.data.districtId)
        .get();
      await getFirestore()
        .collection("coordinators")
        .doc(newCoordinator.uid)
        .set({ displayName: data.data.name, district: district.ref });
    }
  }
);

export const createDistrict = onCall<District>(async (data, context) => {
  if (await isAdmin(data)) {
    await getFirestore().collection("districts").add({ name: data.data.name });
  }
});

export const getDistricts = onCall(async (data, context) => {
  if (await isAdmin(data)) {
    const districts = await getFirestore().collection("districts").get();
    return districts.docs.map((doc) => ({ ...doc.data(), id: doc.id }));
  }
  throw new Error("Unauthorized");
});

//Don't touch this function. trust me bro, it works.
export const getFamilies = onCall(async (data, context) => {
  if ((await isAdmin(data)) || (await isCoordinator(data))) {
    const districtRef = getFirestore().doc(`districts/${data.data.districtId}`);

    const districtFamilies = await getFirestore()
      .collection("districtFamilies")
      .where("district", "==", districtRef)
      .get();

    const promises: Array<Promise<void | number>> = [];
    const families: any[] = [];

    districtFamilies.docs.forEach((doc) =>
      promises.push(
        doc
          .data()
          .family.get()
          .then((data: any) => families.push({ ...data.data(), id: data.id }))
      )
    );

    await Promise.all(promises);

    return families;
  }
  throw new Error("Unauthorized");
});

export const createVolunteer = onCall(async (data, context) => {
  if ((await isAdmin(data)) || (await isCoordinator(data))) {
    const newVolunteer = await auth().createUser({
      email: data.data.email,
      password: data.data.password,
      displayName: data.data.displayName,
    });
    await getFirestore()
      .collection("volunteers")
      .doc(newVolunteer.uid)
      .set({
        displayName: data.data.displayName,
        family: getFirestore().doc(`families/${data.data.familyId}`),
      });

    await getFirestore()
      .collection("districtVolunteers")
      .add({
        volunteer: getFirestore().doc(`volunteers/${newVolunteer.uid}`),
        district: getFirestore().doc(`districts/${data.data.districtId}`),
      });
  }
});

export const createFamily = onCall<FamilyData>(async (data, context) => {
  if ((await isAdmin(data)) || (await isCoordinator(data))) {
    const newFamily = await getFirestore().collection("families").add({
      name: data.data.name,
      address: data.data.address,
      contact: data.data.contact,
    });

    await getFirestore()
      .collection("districtFamilies")
      .add({
        family: newFamily,
        district: getFirestore().doc(`districts/${data.data.districtId}`),
      });
  }
});

export const createVisit = onCall(async (data, context) => {
  if (!data.auth) return;

  const volunteerDocument = await getFirestore()
    .collection("volunteers")
    .doc(data.auth.uid)
    .get();
  const familyRef = volunteerDocument.data()?.family;

  const newVisit = await getFirestore()
    .collection("visits")
    .add({
      family: familyRef,
      visitDate: new Date(data.data.dateTime),
      attendees: [volunteerDocument.ref],
    });
  return newVisit;
});

// export const scheduleVisitNotification = onCall(async (data, context) => {
//     await getFirestore()
//         .doc("visits/{visitId}")
//         .onCreate(async (snap, context) => {
//             const data = snap.data();
//             const visitTime = new Date(data.timeStamp).getTime();
//             const oneDayBefore = visitTime - 24 * 60 * 60 * 1000;

//             if (oneDayBefore > Date.now()) {
//                 const attendees = data.attendees; // Array of ref/volunteers
//                 const familySnap = await data.family.get(); // Get family details
//                 const familyData = familySnap.data();

//                 for (const attendeeRef of attendees) {
//                     const attendeeSnap = await attendeeRef.get();
//                     const attendeeData = attendeeSnap.data();

//                     if (attendeeData.email) {
//                         const payload = {
//                             notification: {
//                                 title: "תזכורת לפגישה",
//                                 body: `יש לך פגישה עם משפחת ${familyData.name} מחר`,
//                             },
//                             data: {
//                                 visitId: context.params.visitId,
//                                 familyName: familyData.name,
//                             },
//                         };
//                         await admin.messaging().sendToDevice(attendeeData.deviceToken, payload);
//                     }
//                 }
//             }
//             return null;
//             }
//     });
