import 'package:flutter/cupertino.dart';
import 'package:healthifi_patient/common/helperFunctions/showsnackbar.dart';
import 'package:healthifi_patient/src/reviewsSection/services/review_services.dart';

import '../../reviewsSection/models/review_model.dart';
import '../models/filter_model.dart';

class SearchProvider extends ChangeNotifier {
  String? selectedFilter;

  String? selectedCategory;

  List<SearchModel> filterList = [
    SearchModel("assets/Images/nutritionist.png", "Dietitian", false),
    SearchModel("assets/Images/personaltrainer.png", "Fitness Trainer", false),
    SearchModel("assets/Images/physican.png", "Physician", false),
    SearchModel("assets/Images/nurse.png", "Behavior Coache", false),
  ];

  ///---------------Specific Category Filter-------------------

  List<SearchModel> categoryFilterList = [
    SearchModel("assets/Images/star.png", "Rating", false),
    SearchModel("assets/Images/portfolio.png", "Experience", false),
    //SearchModel("assets/Images/location.png", "Near by", false),
    // SearchModel("assets/Images/heart.png", "Most Favourite", false),
  ];

  ReviewServices reviewServices = ReviewServices();

  double? averageRatingVar;
  int? reviewslength;

  String? selectedCity;

  String? selectedState;

  String? selectedCountry;

  calculateAverageRating(String userId) async {
    List<ReviewModel> reviewModelList =
        await reviewServices.getReviewsListOfSpecificCareProvider(userId);
    var averageRating = calculateAverageRatingFunction(reviewModelList);
    dp(msg: "average rating ", arg: averageRating);
    reviewslength = reviewModelList.length;
    averageRatingVar = averageRating;
    notifyListeners();
    return averageRating;
  }

  double calculateAverageRatingFunction(List<ReviewModel> reviewList) {
    if (reviewList.isEmpty) {
      return 0.0; // Return 0 if the list is empty to avoid division by zero
    }

    double totalRating = 0.0;
    for (var review in reviewList) {
      totalRating += review.reviewStars!;
    }

    double averageRating = totalRating / reviewList.length;
    return averageRating;
  }
}
