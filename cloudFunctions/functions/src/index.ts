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
import { getFirestore } from "firebase-admin/firestore";
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
      .set({ displayName: data.data.name });
  }
});

export const createFamily = onCall<FamilyData>(async (data, context) => {
  if ((await isAdmin(data)) || (await isCoordinator(data))) {
    await getFirestore().collection("families").doc().set({
      name: data.data.name,
      address: data.data.address,
      contact: data.data.contact,
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
    .doc()
    .set({
      family: familyRef,
      visitDate: new Date(data.data.dateTime),
      attendees: [volunteerDocument.ref],
    });
  return newVisit;
});
