import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthifi_patient/src/dashboardSection/screens/search_care_providers_screen.dart';
import 'package:healthifi_patient/src/dashboardSection/screens/view_all_dietitans.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../common/helperFunctions/navigatorHelper.dart';
import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import '../../../common/widgets/cacheNetworkImageWidget.dart';
import '../../../res.dart';
import '../../authenticationsection/Models/userModel.dart';
import '../../authenticationsection/Models/userModelDietitian.dart';
import '../../authenticationsection/services/userServices.dart';
import '../../notificationSection/screens/notificationListScreen.dart';
import '../providers/search_provider.dart';
import '../services/home_services.dart';
import '../widgets/dietatianDetaislwidget.dart';
import 'category_wise_care_providers.dart';
import 'doctorDetails.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "HomeScreen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserServices userServices = UserServices();
  HomeServices homeServices = HomeServices();

  int activeindex = 0;
  final urlImages = [
    Res.freshdiet,
    Res.dietimaegthree_unsplash,
    Res.kitchenfit,
    Res.dietimage
  ];

  @override
  void initState() {
    _initFcm();
    super.initState();
  }

  Future<void> _initFcm() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseMessaging.instance.subscribeToTopic('USERS');
    FirebaseMessaging.instance.getToken().then((token) {
      FirebaseFirestore.instance.collection('deviceTokens').doc(uid).set(
        {
          'deviceTokens': token,
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamProvider.value(
            value: userServices
                .fetchUserRecord(FirebaseAuth.instance.currentUser!.uid),
            initialData: UserModel(),
            builder: (context, child) {
              UserModel model = context.watch<UserModel>();
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 45,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          model.profilePicture == null
                              ? Container(
                                  height: 37,
                                  width: 37,
                                  decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          fit: BoxFit.cover,
                                          image:
                                              AssetImage(Res.articelsImagepng)),
                                      borderRadius: BorderRadius.circular(13)),
                                )
                              : CacheNetworkImageWidget(
                                  height: 37,
                                  width: 37,
                                  imgUrl: model.profilePicture.toString(),
                                  radius: 7,
                                ),
                          // InkWell(
                          //   onTap: () {
                          //     toNext(context: context, widget: MyProfileScreen());
                          //   },
                          //   child: Image.asset(
                          //     Res.articelsImagepng,
                          //     height: 37,
                          //     width: 37,
                          //   ),
                          // ),
                          InkWell(
                            onTap: () {
                              toNext(
                                  context: context,
                                  widget: const NotificaionsListScreen());
                            },
                            child: SvgPicture.asset(
                              Res.notificationbell,
                              height: 30,
                              width: 30,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Hi ${model.userName.toString().toUpperCase()}",
                          style: fontW5S12(context)!.copyWith(
                              fontSize: 15,
                              color: AppColors.blackcolor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Keep yourself",
                          style: fontW5S12(context)!.copyWith(
                              fontSize: 26,
                              color: AppColors.blackcolor,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "fit and healthy",
                          style: fontW5S12(context)!.copyWith(
                              fontSize: 26,
                              color: AppColors.appcolor,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // ElevatedButton(
                      //     onPressed: () {
                      //
                      //       NotificationServices().pushBroadCastNotification(
                      //           title: 'Appointment Update!',
                      //           body: 'Sohaib booked an appointment with you',
                      //           department: 'USERS');
                      //     },
                      //     child: const Center(
                      //       child: Text("send"),
                      //  )),
                      InkWell(
                        onTap: () {
                          toNext(
                              context: context,
                              widget: SearchCarProviderScreen());
                        },
                        child: SizedBox(
                          height: 60,
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: TextFormField(
                              enabled: false,
                              decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: 15, top: 19),
                                  border: InputBorder.none,
                                  hintText: "Search Care Providers...",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  suffixIcon: Icon(Icons.search)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                          height: 135,
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13)),
                          child: CarouselSlider.builder(
                            itemCount: urlImages.length,
                            options: CarouselOptions(
                              viewportFraction: 1,
                              autoPlay: false,
                              aspectRatio: 2.0,
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) =>
                                  setState(() => activeindex = index),
                            ),
                            itemBuilder: (context, index, realIdx) {
                              return Container(
                                //    height: 80,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(urlImages[index])),
                                    borderRadius: BorderRadius.circular(13)),
                                //
                                // child: Center(
                                //     child: Image.asset(urlImages[index],
                                //         fit: BoxFit.cover, width: 1000)),
                              );
                            },
                          )),
                      const SizedBox(
                        height: 20,
                      ),

                      buildIndicator(),
                      const SizedBox(
                        height: 15,
                      ),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "What Care Provider are you looking for?",
                          style: fontW5S12(context)!.copyWith(
                              fontSize: 15,
                              color: AppColors.blackcolor,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Consumer<SearchProvider>(
                          builder: (context, searchProvider, __) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Container(
                            height: 160,
                            child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        // Number of columns in the grid
                                        crossAxisSpacing: 10.0,
                                        // Spacing between columns
                                        mainAxisSpacing: 10.0,
                                        // Spacing between rows
                                        mainAxisExtent: 160),
                                itemCount: searchProvider.filterList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      toNext(
                                          context: context,
                                          widget: CategoryWiseCareProviders(
                                            userType: searchProvider
                                                .filterList[index].text
                                                .toString(),
                                          ));
                                    },
                                    child: Container(
                                      height: 80,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: AppColors.appLightColor),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  color: AppColors.darkAppColor
                                                      .withOpacity(0.9)),
                                              child: Center(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Image.asset(
                                                    searchProvider
                                                        .filterList[index].icon
                                                        .toString()),
                                              )),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: 80,
                                              child: RichText(
                                                textAlign: TextAlign.start,
                                                text: TextSpan(
                                                  text: searchProvider
                                                      .filterList[index].text
                                                      .toString(),
                                                  style: fontW5S12(context)!
                                                      .copyWith(
                                                          fontSize: 12,
                                                          color: AppColors
                                                              .blackcolor,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Available Dietitians",
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 17,
                                  color: AppColors.blackcolor,
                                  fontWeight: FontWeight.w700),
                            ),
                            InkWell(
                              onTap: () {
                                toNext(
                                    context: context,
                                    widget: ViewAllDietitians());
                              },
                              child: Text(
                                "View All",
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 14,
                                    color: AppColors.appcolor,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      StreamProvider.value(
                          value: homeServices.streamAllDietitans(),
                          initialData: [UserModelDietitian()],
                          builder: (context, child) {
                            List<UserModelDietitian> dietitansList =
                                context.watch<List<UserModelDietitian>>();
                            return dietitansList.isEmpty
                                ? Center(
                                    child: Column(
                                    children: [
                                      SizedBox(
                                        height: 35,
                                      ),
                                      Text("No Dietitians found!",
                                          style: TextStyle(
                                              // fontFamily: 'Gilroy',
                                              color: AppColors.blackcolor,
                                              // decoration: TextDecoration.underline,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Axiforma',
                                              fontSize: 13)),
                                      SizedBox(
                                        height: 35,
                                      ),
                                    ],
                                  ))
                                : dietitansList[0].userId == null
                                    ? const SpinKitSpinningLines(
                                        size: 45,
                                        color: AppColors.appcolor,
                                      )
                                    : SizedBox(
                                        height: 150,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            padding: const EdgeInsets.only(),
                                            physics: const ScrollPhysics(),

                                            // physics:
                                            //     const NeverScrollableScrollPhysics(),
                                            itemCount: dietitansList.length,
                                            itemBuilder: (_, i) {
                                              //  print(dietitansList[i]..toString());
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                child: InkWell(
                                                  onTap: () {
                                                    toNext(
                                                        context: context,
                                                        widget: DoctorDetails(
                                                          userModel:
                                                              dietitansList[i],
                                                        ));
                                                  },
                                                  child:
                                                      PopularDietitiansWidget(
                                                    userModel: dietitansList[i],
                                                  ),
                                                ),
                                              );
                                            }),
                                      );
                          }),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       "Fitness Trainers",
                      //       style: fontW5S12(context)!.copyWith(
                      //           fontSize: 17,
                      //           color: AppColors.blackcolor,
                      //           fontWeight: FontWeight.w700),
                      //     ),
                      //     InkWell(
                      //       onTap: () {
                      //         toNext(
                      //             context: context,
                      //             widget: ViewAllFitnessTrainers());
                      //       },
                      //       child: Text(
                      //         "View All",
                      //         style: fontW5S12(context)!.copyWith(
                      //             fontSize: 14,
                      //             color: AppColors.appcolor,
                      //             decoration: TextDecoration.underline,
                      //             fontWeight: FontWeight.w700),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // StreamProvider.value(
                      //     value: homeServices.streamAllFitnessTrainers(),
                      //     initialData: [UserModelDietitian()],
                      //     builder: (context, child) {
                      //       List<UserModelDietitian> dietitansList =
                      //           context.watch<List<UserModelDietitian>>();
                      //       return dietitansList.isEmpty
                      //           ? Center(
                      //               child: Column(
                      //               children: [
                      //                 SizedBox(
                      //                   height: 35,
                      //                 ),
                      //                 Text("No Fitness Trainers found!",
                      //                     style: TextStyle(
                      //                         // fontFamily: 'Gilroy',
                      //                         color: AppColors.blackcolor,
                      //                         // decoration: TextDecoration.underline,
                      //                         fontWeight: FontWeight.w700,
                      //                         fontFamily: 'Axiforma',
                      //                         fontSize: 13)),
                      //                 SizedBox(
                      //                   height: 35,
                      //                 ),
                      //               ],
                      //             ))
                      //           : dietitansList[0].userId == null
                      //               ? const SpinKitWave(
                      //                   color: AppColors.appcolor,
                      //                   size: 25,
                      //                 )
                      //               : SizedBox(
                      //                   height: 150,
                      //                   child: ListView.builder(
                      //                       shrinkWrap: true,
                      //                       scrollDirection: Axis.horizontal,
                      //                       padding: const EdgeInsets.only(),
                      //                       physics: const ScrollPhysics(),
                      //
                      //                       // physics:
                      //                       //     const NeverScrollableScrollPhysics(),
                      //                       itemCount: dietitansList.length,
                      //                       itemBuilder: (_, i) {
                      //                         //  print(dietitansList[i]..toString());
                      //                         return Padding(
                      //                           padding: const EdgeInsets.only(
                      //                               right: 5),
                      //                           child: InkWell(
                      //                             onTap: () {
                      //                               toNext(
                      //                                   context: context,
                      //                                   widget: DoctorDetails(
                      //                                     userModel:
                      //                                         dietitansList[i],
                      //                                   ));
                      //                             },
                      //                             child:
                      //                                 FitnessTrainerHomeCardWidget(
                      //                               userModel: dietitansList[i],
                      //                             ),
                      //                           ),
                      //                         );
                      //                       }),
                      //                 );
                      //     }),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ),
              );
            }));
  }

  Widget buildIndicator() => Align(
        alignment: Alignment.center,
        child: AnimatedSmoothIndicator(
          activeIndex: activeindex,
          count: urlImages.length,
          effect: WormEffect(
              dotHeight: 9, dotWidth: 9, activeDotColor: AppColors.appcolor),
        ),
      );
}
