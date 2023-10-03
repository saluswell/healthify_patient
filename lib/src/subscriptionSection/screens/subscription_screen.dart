import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../common/helperFunctions/navigatorHelper.dart';
import '../../../common/utils/appcolors.dart';
import '../../../common/utils/enums.dart';
import '../../../common/utils/themes.dart';
import '../../../common/widgets/button_widget.dart';
import '../../authenticationsection/Models/userModel.dart';
import '../../authenticationsection/services/userServices.dart';
import '../providers/subscription_provider.dart';
import 'add_card_inforamtion_screen.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  // SubscriptionService subscriptionService = SubscriptionService();
  UserServices userServices = UserServices();

  @override
  void initState() {
    context.read<SubscriptionProvider>().getSubscriptionProductsProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SubscriptionProvider>(
        builder: (context, subscriptionProvider, __) {
      return LoadingOverlay(
        isLoading: subscriptionProvider.isLoading,
        progressIndicator: const CircularProgressIndicator(
          color: AppColors.appcolor,
        ),
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "Subscription",
                style: fontW5S12(context)!.copyWith(
                    color: AppColors.whitecolor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
            ),
            body: subscriptionProvider.subscriptionProductsModel == null
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.appcolor,
                    ),
                  )
                : StreamProvider.value(
                    value: userServices.fetchUserRecord(
                        FirebaseAuth.instance.currentUser!.uid),
                    initialData: UserModel(),
                    builder: (context, child) {
                      UserModel model = context.watch<UserModel>();
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 30),
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: subscriptionProvider
                                    .subscriptionProductsModel!.data!.length,
                                itemBuilder: (context, index) {
                                  var data = subscriptionProvider
                                      .subscriptionProductsModel!.data![index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 10),
                                    child: Container(
                                      //  height: 200,
                                      //height: 170,
                                      width: MediaQuery.of(context).size.width,
                                      child: Card(
                                        color: AppColors.darkAppColor
                                            .withOpacity(0.9),
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 1,
                                              color: AppColors.whitecolor),
                                          borderRadius:
                                              BorderRadius.circular(13),
                                        ),
                                        elevation: 4,
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(data.name.toString(),
                                                style: fontW5S12(context)!
                                                    .copyWith(
                                                        color: AppColors
                                                            .whitecolor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 17)),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text("Features",
                                                style: fontW5S12(context)!
                                                    .copyWith(
                                                        color: AppColors
                                                            .whitecolor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14)),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              height: 140,
                                              child: ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  // gridDelegate:
                                                  //     SliverGridDelegateWithFixedCrossAxisCount(
                                                  //   mainAxisExtent: 30,
                                                  //   crossAxisSpacing: 0.5,
                                                  //
                                                  //   mainAxisSpacing: 5,
                                                  //   crossAxisCount:
                                                  //       1, // Number of columns in the grid
                                                  // ),
                                                  itemCount:
                                                      data.features!.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10,
                                                              left: 40),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: 7,
                                                            width: 7,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            13),
                                                                color: AppColors
                                                                    .whitecolor),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                              data
                                                                  .features![
                                                                      index]
                                                                  .name
                                                                  .toString(),
                                                              style: fontW5S12(
                                                                      context)!
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .whitecolor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          12)),
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                                index == 0
                                                    ? "\$80 / Monthly"
                                                    : "\$20 / Monthly",
                                                style: fontW5S12(context)!
                                                    .copyWith(
                                                        color: AppColors
                                                            .whitecolor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 17)),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            if (model.planName == basicPlan &&
                                                index == 1) ...[
                                              CommonButtonWidget(
                                                  buttonHeight: 50,
                                                  textfont: 13,
                                                  bordercolor:
                                                      AppColors.redcolor,
                                                  backgroundcolor:
                                                      AppColors.redcolor,
                                                  text: "UnSubscribe",
                                                  onTap: () {
                                                    subscriptionProvider
                                                        .cancelSubscriptionProvider(
                                                            model.subscriptionID
                                                                .toString());
                                                  }),
                                            ] else if (model.planName ==
                                                    premiumPlan &&
                                                index == 0) ...[
                                              CommonButtonWidget(
                                                  buttonHeight: 50,
                                                  textfont: 13,
                                                  bordercolor:
                                                      AppColors.redcolor,
                                                  backgroundcolor:
                                                      AppColors.redcolor,
                                                  text: "UnSubscribe",
                                                  onTap: () {
                                                    subscriptionProvider
                                                        .cancelSubscriptionProvider(
                                                            model.subscriptionID
                                                                .toString());
                                                  }),
                                            ] else ...[
                                              CommonButtonWidget(
                                                  buttonHeight: 50,
                                                  textfont: 13,
                                                  text: "Subscribe",
                                                  onTap: () {
                                                    toNext(
                                                        context: context,
                                                        widget:
                                                            AddCardInformation(
                                                          productsDatum:
                                                              subscriptionProvider
                                                                  .subscriptionProductsModel!
                                                                  .data![index],
                                                          planPrice: index == 0
                                                              ? "80"
                                                              : "20",
                                                        ));
                                                  }),
                                            ],
                                            const SizedBox(
                                              height: 30,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          )
                          // ElevatedButton(
                          //     onPressed: () {
                          //       // subscriptionService.subscriptions();
                          //     },
                          //     child: Center(
                          //       child: Text("Subscribe"),
                          //     ))
                        ],
                      );
                    })),
      );
    });
  }
}
