import 'package:flutter/cupertino.dart';

import '../models/filter_model.dart';

class SearchProvider extends ChangeNotifier {
  String? selectedFilter;

  String? selectedCategory;

  List<SearchModel> filterList = [
    SearchModel("assets/Images/nutritionist.png", "Dietitian", false),
    SearchModel("assets/Images/personaltrainer.png", "Fitness Trainer", false),
    SearchModel("assets/Images/physican.png", "Physician", false),
    SearchModel("assets/Images/nurse.png", "Behavior Coach", false),
  ];

  ///---------------Specific Category Filter-------------------

  List<SearchModel> categoryFilterList = [
    SearchModel("assets/Images/star.png", "Rating", false),
    SearchModel("assets/Images/portfolio.png", "Experience", false),
    SearchModel("assets/Images/location.png", "Near by", false),
    SearchModel("assets/Images/heart.png", "Most Favourite", false),
  ];
}
