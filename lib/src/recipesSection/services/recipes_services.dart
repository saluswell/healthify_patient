import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../common/utils/firebaseUtils.dart';
import '../models/recipes_model.dart';

class RecipesServices {
  ///Create Page
  Future createRecipe(RecipesModel recipesModel) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection(FirebaseUtils.recipes).doc();
    return await docRef.set(recipesModel.toJson(docRef.id));
  }

  /// show list of pending and approved articles  from admin
  Stream<List<RecipesModel>> streamRecipes(
      {required String mealTypeFilter,
      required String conditions,
      required String selectedDietType}) {
    //  try {
    if (conditions != "null") {
      return FirebaseFirestore.instance
          .collection(FirebaseUtils.recipes)
          .where("conditions", arrayContains: conditions)
          //  .where("userID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          //.where("isApprovedByAdmin", isEqualTo: isApprove)
          .snapshots()
          .map((list) => list.docs
              .map((singleDoc) => RecipesModel.fromJson(singleDoc.data()))
              .toList());
    } else if (mealTypeFilter != "null") {
      return FirebaseFirestore.instance
          .collection(FirebaseUtils.recipes)
          .where("meals", arrayContains: mealTypeFilter)
          //  .where("userID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          //.where("isApprovedByAdmin", isEqualTo: isApprove)
          .snapshots()
          .map((list) => list.docs
              .map((singleDoc) => RecipesModel.fromJson(singleDoc.data()))
              .toList());
    } else if (selectedDietType != "null") {
      return FirebaseFirestore.instance
          .collection(FirebaseUtils.recipes)
          .where("dietTypes", arrayContains: selectedDietType)
          //  .where("userID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          //.where("isApprovedByAdmin", isEqualTo: isApprove)
          .snapshots()
          .map((list) => list.docs
              .map((singleDoc) => RecipesModel.fromJson(singleDoc.data()))
              .toList());
    } else {
      return FirebaseFirestore.instance
          .collection(FirebaseUtils.recipes)
          //  .where("meals", arrayContains: mealTypeFilter)
          //  .where("userID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          //.where("isApprovedByAdmin", isEqualTo: isApprove)
          .snapshots()
          .map((list) => list.docs
              .map((singleDoc) => RecipesModel.fromJson(singleDoc.data()))
              .toList());
    }
  }

  Future<List<RecipesModel>> getRecipes() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(FirebaseUtils.recipes)
          .get();

      List<RecipesModel> recipes = [];

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        final data = doc.data();

        if (data != null && data is Map<String, dynamic>) {
          // Now, you can safely use data as a Map<String, dynamic>
          final recipesModel = RecipesModel.fromJson(data);
          recipes.add(recipesModel);
        } else {
          // Handle the case where data is not in the expected format
          print('Data is not a valid Map<String, dynamic>');
        }
      }

      return recipes;
    } catch (e) {
      // Handle errors here
      print("Error fetching recipes: $e");
      return [];
    }
  }
}
