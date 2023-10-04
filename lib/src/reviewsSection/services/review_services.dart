import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../common/helperFunctions/getUserIDhelper.dart';
import '../../../common/utils/firebaseUtils.dart';
import '../../apppointmentsSection/models/appointmentModel.dart';
import '../models/review_model.dart';

class ReviewServices {
  ///Create Review
  Future createReview(ReviewModel reviewModel) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection(FirebaseUtils.reviews).doc();
    return await docRef.set(reviewModel.toJson(docRef.id));
  }

  /// Stream dieitian reviews
  Stream<List<ReviewModel>> streamReviewsList() {
    //  try {
    return FirebaseFirestore.instance
        .collection(FirebaseUtils.reviews)
        .where("reviewRecieverID", isEqualTo: getUserID())
        //.where("isApprovedByAdmin", isEqualTo: isApprove)
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) => ReviewModel.fromJson(singleDoc.data()))
            .toList());
  }

  /// Stream dieitian reviews
  Stream<List<ReviewModel>> streamSpecificDoctorReviewsList(String userID) {
    //  try {
    return FirebaseFirestore.instance
        .collection(FirebaseUtils.reviews)
        .where("reviewRecieverID", isEqualTo: userID)
        //.where("isApprovedByAdmin", isEqualTo: isApprove)
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) => ReviewModel.fromJson(singleDoc.data()))
            .toList());
  }

  Future<List<ReviewModel>> getReviewsListOfSpecificCareProvider(
      String userID) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(FirebaseUtils.reviews)
          .where("reviewRecieverID", isEqualTo: userID)
          // .where("dietitianID", isEqualTo: userID)

          //.where("isApprovedByAdmin", isEqualTo: isApprove)
          .get();

      final reviewList = querySnapshot.docs
          .map((singleDoc) => ReviewModel.fromJson(singleDoc.data()))
          .toList();

      return reviewList;
    } catch (e) {
      // Handle errors here
      print("Error fetching reviews: $e");
      return []; // Return an empty list or handle the error as needed
    }
  }

  /// update timeslots updated
  Future UpdateReviewStatusOfDietitan(
      AppointmentModel appointmentModelNew, String appointmentID) async {
    return await FirebaseFirestore.instance
        .collection(FirebaseUtils.appointments)
        .doc(appointmentID)

        //.where("userID", isEqualTo: date)
        .update({
      "isReviewGivenByPatient": true,
    });
  }
}
