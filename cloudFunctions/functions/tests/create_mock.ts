// TODO: create mock db for tests.

const mockEntities = require("./mock_entities.json");
import { auth } from "firebase-admin";
import { initializeApp } from "firebase-admin/app";
import { getFirestore } from "firebase-admin/firestore";
import { logger } from "firebase-functions";
import { CoordinatorData, District } from '../src/index';

initializeApp();

function getRandomDistrictFromJson(): string {
    const names = mockEntities.districts.map((district: District) => district.name);
    const randomName = names[Math.floor(Math.random() * names.length)];
    return randomName;
}

logger.info('Creating districts..')
mockEntities.districts.forEach(async (district: District) => {
    console.log(district)
    await getFirestore().collection("districts").add({ name: district.name });
});


logger.info('Creating coordinators..')
mockEntities.coordinators.forEach(async (coordinator: CoordinatorData) => {

    const newCoordinator = await auth().createUser({
        email: coordinator.email,
        password: coordinator.password,
        displayName: coordinator.name,
    });
    const randomDistrict = getRandomDistrictFromJson()
    const districtsSnapshot = await getFirestore()
        .collection("districts")
        .where("name", "==", randomDistrict)
        .get();
    const district = districtsSnapshot.docs[0].data();
    await getFirestore()
        .collection("coordinators")
        .doc(newCoordinator.uid)
        .set({ displayName: district.name, district: district.ref });
});
