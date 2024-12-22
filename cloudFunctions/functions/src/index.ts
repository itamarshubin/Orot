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

interface UserData {
  name: string;
  email: string;
  password: string;
}

interface District {
  name: string;
}

const isAdmin = async (data: CallableRequest) => {
  const adminDoc = await getFirestore()
    .collection("admins")
    .doc(data?.auth?.uid || "")
    .get();
  return adminDoc.exists;
};

const isCoordinator = async (data: CallableRequest<UserData>) => {
  const coordinatorDoc = await getFirestore()
    .collection("coordinators")
    .doc(data?.auth?.uid || "")
    .get();
  return coordinatorDoc.exists;
};

export const createUser = onCall<UserData>(async (data, context) => {
  if ((await isAdmin(data)) || (await isCoordinator(data))) {
    console.log("good");
  } else {
    console.log("bad");
  }
});

export const createCoordinator = onCall<UserData>(async (data, context) => {
  if (await isAdmin(data)) {
    const newCoordinator = await auth().createUser({
      email: data.data.email,
      password: data.data.password,
      displayName: data.data.name,
    });

    await getFirestore()
      .collection("coordinators")
      .doc(newCoordinator.uid)
      .set({ displayName: data.data.name });
  }
});

export const createDistrict = onCall<District>(async (data, context) => {
  if (await isAdmin(data)) {
    await getFirestore().collection("districts").add({ name: data.data.name });
  }
});
