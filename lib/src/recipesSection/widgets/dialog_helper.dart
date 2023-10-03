import 'package:flutter/material.dart';
import 'package:healthifi_patient/src/recipesSection/providers/recipes_provider.dart';
import 'package:provider/provider.dart';

import '../../../common/helperFunctions/navigatorHelper.dart';
import '../../../common/helperFunctions/showsnackbar.dart';
import '../../../common/utils/appcolors.dart';
import '../../../common/widgets/button_widget.dart';

class DialogHelper {
  static showMealTypeDialog() {
    showGeneralDialog(
        context: navstate.currentState!.context,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(navstate.currentState!.context)
            .modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return StatefulBuilder(builder: (context, setStateInsideDialog) {
            return Material(
              color: Colors.transparent,
              child: Consumer<RecipesProvider>(
                  builder: (context, recipesProvider, __) {
                return Center(
                    child: Container(
                        width: MediaQuery.of(
                              navstate.currentState!.context,
                            ).size.width -
                            60,
                        height: MediaQuery.of(
                              navstate.currentState!.context,
                            ).size.height -
                            420,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(13)),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text("Select Meal Type",
                                style: TextStyle(
                                    // fontFamily: 'Gilroy',
                                    color: AppColors.blackcolor,
                                    // decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Axiforma',
                                    fontSize: 13)),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 180,
                              child: ListView.builder(
                                  itemCount: recipesProvider.mealType.length,
                                  padding: EdgeInsets.only(),
                                  itemBuilder: (context, index) {
                                    var data = recipesProvider.mealType[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: InkWell(
                                        onTap: () {
                                          recipesProvider
                                              .updateMealTypeFilter(data);
                                          dp(msg: "tap filter", arg: "");
                                        },
                                        child: Container(
                                          height: 45,
                                          width:
                                              MediaQuery.sizeOf(context).width,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(9),
                                              border: Border.all(
                                                  width: 2,
                                                  color: recipesProvider
                                                              .selectedMealTypeFilter ==
                                                          data
                                                      ? AppColors.darkAppColor
                                                      : AppColors
                                                          .appLightColor),
                                              color: recipesProvider
                                                          .selectedMealTypeFilter ==
                                                      data
                                                  ? AppColors.darkAppColor
                                                  : AppColors.appLightColor),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(data,
                                                    style: TextStyle(
                                                        // fontFamily: 'Gilroy',
                                                        color: recipesProvider
                                                                    .selectedMealTypeFilter ==
                                                                data
                                                            ? AppColors
                                                                .whitecolor
                                                            : AppColors
                                                                .blackcolor,
                                                        // decoration: TextDecoration.underline,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Axiforma',
                                                        fontSize: 11)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: CommonButtonWidget(
                                        buttonHeight: 45,
                                        horizontalPadding: 0,
                                        //hoorizonatalPadding: 0,
                                        text: "Reset",
                                        textfont: 13,
                                        onTap: () {
                                          recipesProvider.clearMealTypeFilter();
                                          Navigator.maybePop(context);
                                        })),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: CommonButtonWidget(
                                        buttonHeight: 45,
                                        horizontalPadding: 0,
                                        bordercolor: AppColors.darkAppColor,
                                        backgroundcolor: AppColors.darkAppColor,
                                        textfont: 13,
                                        text: "Apply",
                                        onTap: () {
                                          Navigator.maybePop(context);
                                        }))
                              ],
                            )
                          ],
                        )));
              }),
            );
          });
        });
  }

  ///------------------------------show recipe conditions dialog filter -----------------

  static showRecipeConditionsDialog() {
    showGeneralDialog(
        context: navstate.currentState!.context,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(navstate.currentState!.context)
            .modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return StatefulBuilder(builder: (context, setStateInsideDialog) {
            return Material(
              color: Colors.transparent,
              child: Consumer<RecipesProvider>(
                  builder: (context, recipesProvider, __) {
                return Center(
                    child: Container(
                        width: MediaQuery.of(
                              navstate.currentState!.context,
                            ).size.width -
                            60,
                        height: MediaQuery.of(
                              navstate.currentState!.context,
                            ).size.height -
                            220,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(13)),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text("Select Conditions",
                                style: TextStyle(
                                    // fontFamily: 'Gilroy',
                                    color: AppColors.blackcolor,
                                    // decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Axiforma',
                                    fontSize: 13)),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 350,
                              child: ListView.builder(
                                  itemCount:
                                      recipesProvider.recipeConditions.length,
                                  padding: EdgeInsets.only(),
                                  itemBuilder: (context, index) {
                                    var data =
                                        recipesProvider.recipeConditions[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: InkWell(
                                        onTap: () {
                                          recipesProvider
                                              .updateConditionFilter(data);
                                          dp(msg: "tap filter", arg: "");
                                        },
                                        child: Container(
                                          height: 45,
                                          width:
                                              MediaQuery.sizeOf(context).width,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(9),
                                              border: Border.all(
                                                  width: 2,
                                                  color: recipesProvider
                                                              .selectedConditionFilter ==
                                                          data
                                                      ? AppColors.darkAppColor
                                                      : AppColors
                                                          .appLightColor),
                                              color: recipesProvider
                                                          .selectedConditionFilter ==
                                                      data
                                                  ? AppColors.darkAppColor
                                                  : AppColors.appLightColor),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(data,
                                                    style: TextStyle(
                                                        // fontFamily: 'Gilroy',
                                                        color: recipesProvider
                                                                    .selectedConditionFilter ==
                                                                data
                                                            ? AppColors
                                                                .whitecolor
                                                            : AppColors
                                                                .blackcolor,
                                                        // decoration: TextDecoration.underline,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Axiforma',
                                                        fontSize: 11)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: CommonButtonWidget(
                                        buttonHeight: 45,
                                        horizontalPadding: 0,
                                        //hoorizonatalPadding: 0,
                                        text: "Reset",
                                        textfont: 13,
                                        onTap: () {
                                          recipesProvider
                                              .clearConditionFilter();
                                          Navigator.maybePop(context);
                                        })),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: CommonButtonWidget(
                                        buttonHeight: 45,
                                        horizontalPadding: 0,
                                        bordercolor: AppColors.darkAppColor,
                                        backgroundcolor: AppColors.darkAppColor,
                                        textfont: 13,
                                        text: "Apply",
                                        onTap: () {
                                          Navigator.maybePop(context);
                                        }))
                              ],
                            )
                          ],
                        )));
              }),
            );
          });
        });
  }

  ///------------------------------show diet type  dialog filter -----------------

  static showDietTypeDialog() {
    showGeneralDialog(
        context: navstate.currentState!.context,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(navstate.currentState!.context)
            .modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return StatefulBuilder(builder: (context, setStateInsideDialog) {
            return Material(
              color: Colors.transparent,
              child: Consumer<RecipesProvider>(
                  builder: (context, recipesProvider, __) {
                return Center(
                    child: Container(
                        width: MediaQuery.of(
                              navstate.currentState!.context,
                            ).size.width -
                            60,
                        height: MediaQuery.of(
                              navstate.currentState!.context,
                            ).size.height -
                            220,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(13)),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text("Select Diet Type",
                                style: TextStyle(
                                    // fontFamily: 'Gilroy',
                                    color: AppColors.blackcolor,
                                    // decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Axiforma',
                                    fontSize: 13)),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 350,
                              child: ListView.builder(
                                  itemCount: recipesProvider.dietTypes.length,
                                  padding: EdgeInsets.only(),
                                  itemBuilder: (context, index) {
                                    var data = recipesProvider.dietTypes[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: InkWell(
                                        onTap: () {
                                          recipesProvider
                                              .updateDietTypeFilter(data);
                                          dp(msg: "tap filter", arg: "");
                                        },
                                        child: Container(
                                          height: 45,
                                          width:
                                              MediaQuery.sizeOf(context).width,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(9),
                                              border: Border.all(
                                                  width: 2,
                                                  color: recipesProvider
                                                              .selectedDietTypeFilter ==
                                                          data
                                                      ? AppColors.darkAppColor
                                                      : AppColors
                                                          .appLightColor),
                                              color: recipesProvider
                                                          .selectedDietTypeFilter ==
                                                      data
                                                  ? AppColors.darkAppColor
                                                  : AppColors.appLightColor),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(data,
                                                    style: TextStyle(
                                                        // fontFamily: 'Gilroy',
                                                        color: recipesProvider
                                                                    .selectedDietTypeFilter ==
                                                                data
                                                            ? AppColors
                                                                .whitecolor
                                                            : AppColors
                                                                .blackcolor,
                                                        // decoration: TextDecoration.underline,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Axiforma',
                                                        fontSize: 11)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: CommonButtonWidget(
                                        buttonHeight: 45,
                                        horizontalPadding: 0,
                                        //hoorizonatalPadding: 0,
                                        text: "Reset",
                                        textfont: 13,
                                        onTap: () {
                                          recipesProvider.clearDietTypeFilter();
                                          Navigator.maybePop(context);
                                        })),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: CommonButtonWidget(
                                        buttonHeight: 45,
                                        horizontalPadding: 0,
                                        bordercolor: AppColors.darkAppColor,
                                        backgroundcolor: AppColors.darkAppColor,
                                        textfont: 13,
                                        text: "Apply",
                                        onTap: () {
                                          Navigator.maybePop(context);
                                        }))
                              ],
                            )
                          ],
                        )));
              }),
            );
          });
        });
  }
}
