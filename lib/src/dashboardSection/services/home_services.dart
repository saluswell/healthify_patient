import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../common/utils/firebaseUtils.dart';
import '../../../common/utils/textutils.dart';
import '../../authenticationsection/Models/userModelDietitian.dart';

class HomeServices {
  Stream<List<UserModelDietitian>> streamAllDietitans() {
    return FirebaseFirestore.instance
        .collection(FirebaseUtils.users)
        .where("UserType", isEqualTo: TextUtils.Dietitian)
        //.where("PersonalInformationModel.title", isEqualTo: "Dietitian")
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) => UserModelDietitian.fromJson(singleDoc.data()))
            .toList());
  }

  Stream<List<UserModelDietitian>>? streamCategoryWise(
      {required String userType}) {
    if (userType == TextUtils.Dietitian) {
      return FirebaseFirestore.instance
          .collection(FirebaseUtils.users)
          .where("UserType", isEqualTo: TextUtils.Dietitian)
          //.where("PersonalInformationModel.title", isEqualTo: "Dietitian")
          .snapshots()
          .map((list) => list.docs
              .map((singleDoc) => UserModelDietitian.fromJson(singleDoc.data()))
              .toList());
    } else if (userType == TextUtils.Physician) {
      return FirebaseFirestore.instance
          .collection(FirebaseUtils.users)
          .where("UserType", isEqualTo: TextUtils.Physician)
          //.where("PersonalInformationModel.title", isEqualTo: "Dietitian")
          .snapshots()
          .map((list) => list.docs
              .map((singleDoc) => UserModelDietitian.fromJson(singleDoc.data()))
              .toList());
    } else if (userType == TextUtils.fitnessTrainer) {
      return FirebaseFirestore.instance
          .collection(FirebaseUtils.users)
          .where("UserType", isEqualTo: TextUtils.fitnessTrainer)
          //.where("PersonalInformationModel.title", isEqualTo: "Dietitian")
          .snapshots()
          .map((list) => list.docs
              .map((singleDoc) => UserModelDietitian.fromJson(singleDoc.data()))
              .toList());
    } else if (userType == TextUtils.NursePractitioner) {
      return FirebaseFirestore.instance
          .collection(FirebaseUtils.users)
          .where("UserType", isEqualTo: TextUtils.NursePractitioner)
          //.where("PersonalInformationModel.title", isEqualTo: "Dietitian")
          .snapshots()
          .map((list) => list.docs
              .map((singleDoc) => UserModelDietitian.fromJson(singleDoc.data()))
              .toList());
    }
    return null;
  }

  Stream<List<UserModelDietitian>> streamFilter(
      {required String selectedType}) {
    if (selectedType != "null") {
      return FirebaseFirestore.instance
          .collection(FirebaseUtils.users)
          .where("UserType", isEqualTo: selectedType)
          //.where("PersonalInformationModel.title", isEqualTo: "Dietitian")
          .snapshots()
          .map((list) => list.docs
              .map((singleDoc) => UserModelDietitian.fromJson(singleDoc.data()))
              .toList());
    } else {}
    return FirebaseFirestore.instance
        .collection(FirebaseUtils.users)
        .where("UserType", isNotEqualTo: TextUtils.Patient)
        // .where("UserType", isEqualTo: TextUtils.fitnessTrainer)
        // .where("UserType", isEqualTo: TextUtils.NursePractitioner)
        // .where("UserType", isEqualTo: TextUtils.Physician)
        //.where("PersonalInformationModel.title", isEqualTo: "Dietitian")
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) => UserModelDietitian.fromJson(singleDoc.data()))
            .toList());
  }

  Stream<List<UserModelDietitian>> streamAllFitnessTrainers() {
    return FirebaseFirestore.instance
        .collection(FirebaseUtils.users)
        .where("UserType", isEqualTo: TextUtils.fitnessTrainer)
        //  .where("PersonalInformationModel.title", isEqualTo: "Fitness Trainer")
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) => UserModelDietitian.fromJson(singleDoc.data()))
            .toList());
  }
}
