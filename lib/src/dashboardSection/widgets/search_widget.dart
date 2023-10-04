import 'package:flutter/material.dart';

import '../../../common/helperFunctions/navigatorHelper.dart';
import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import '../../../common/widgets/cacheNetworkImageWidget.dart';
import '../../authenticationsection/Models/userModelDietitian.dart';
import '../screens/doctorDetails.dart';

class SearchDietitiansWidget extends StatelessWidget {
  final UserModelDietitian userModel;

  const SearchDietitiansWidget({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              toNext(
                  context: context,
                  widget: DoctorDetails(
                    userModel: userModel,
                  ));
            },
            child: Container(
              height: 150,
              //width: 230,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CacheNetworkImageWidget(
                                  height: 45,
                                  width: 45,
                                  imgUrl: userModel.profilePicture.toString(),
                                  radius: 7),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Dr " + userModel.userName.toString(),
                                    style: fontW5S12(context)!.copyWith(
                                        fontSize: 15,
                                        color: AppColors.blackcolor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    userModel.userType.toString(),
                                    style: fontW5S12(context)!.copyWith(
                                        fontSize: 12,
                                        color: AppColors.lightdarktextcolor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    userModel.professionalInformationModel!
                                        .qualfications
                                        .toString(),
                                    style: fontW5S12(context)!.copyWith(
                                        fontSize: 12,
                                        color: AppColors.lightdarktextcolor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: userModel.isVerified == true
                                ? Column(
                                    children: [
                                      Icon(
                                        Icons.verified_rounded,
                                        color: AppColors.appcolor,
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "Verified",
                                        style: fontW5S12(context)!.copyWith(
                                            fontSize: 12,
                                            color: AppColors.lightdarktextcolor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Icon(
                                        Icons.verified_rounded,
                                        color: AppColors.redcolor,
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "Not Verified",
                                        style: fontW5S12(context)!.copyWith(
                                            fontSize: 12,
                                            color: AppColors.lightdarktextcolor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                          )
                          // Column(
                          //   children: [
                          //     IconButton(
                          //         onPressed: () {},
                          //         icon: Icon(
                          //           Icons.favorite,
                          //           color: AppColors.appcolor,
                          //         )),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Experience",
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 11,
                                    color: AppColors.blackcolor,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                userModel.professionalInformationModel!
                                        .yearofExperience
                                        .toString() +
                                    " Years",
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 11,
                                    color: AppColors.lightdarktextcolor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Container(
                            height: 30,
                            width: 1,
                            color: AppColors.lightdarktextcolor,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Country",
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 11,
                                    color: AppColors.blackcolor,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_sharp,
                                    size: 13,
                                    color: AppColors.darkAppColor,
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    userModel.personalInformationModel!.country
                                        .toString()
                                        .toUpperCase(),
                                    //" 5(42)",
                                    style: fontW5S12(context)!.copyWith(
                                        fontSize: 11,
                                        color: AppColors.lightdarktextcolor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  // Consumer<SearchProvider>(
                                  //     builder: (context, searchProvider, __) {
                                  //   return Text(
                                  //     searchProvider.calculateAverageRating(
                                  //         userModel.userId.toString()).toString(),
                                  //     //" 5(42)",
                                  //     style: fontW5S12(context)!.copyWith(
                                  //         fontSize: 11,
                                  //         color: AppColors.lightdarktextcolor,
                                  //         fontWeight: FontWeight.w500),
                                  //   );
                                  // }),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            height: 30,
                            width: 1,
                            color: AppColors.lightdarktextcolor,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "State/Province",
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 11,
                                    color: AppColors.blackcolor,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Row(
                                children: [
                                  Text(
                                    userModel.personalInformationModel!.province
                                        .toString()
                                        .toUpperCase(),
                                    //" 5(42)",
                                    style: fontW5S12(context)!.copyWith(
                                        fontSize: 11,
                                        color: AppColors.lightdarktextcolor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
