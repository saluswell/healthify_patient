import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:healthifi_patient/src/dashboardSection/services/home_services.dart';
import 'package:provider/provider.dart';

import '../../../common/helperFunctions/navigatorHelper.dart';
import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import '../../authenticationsection/Models/userModelDietitian.dart';
import '../providers/search_provider.dart';
import '../widgets/dietitan_card_widget.dart';
import 'doctorDetails.dart';

class CategoryWiseCareProviders extends StatefulWidget {
  final String userType;

  const CategoryWiseCareProviders({Key? key, required this.userType})
      : super(key: key);

  @override
  State<CategoryWiseCareProviders> createState() =>
      _CategoryWiseCareProvidersState();
}

class _CategoryWiseCareProvidersState extends State<CategoryWiseCareProviders> {
  HomeServices homeServices = HomeServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Search " + widget.userType.toString(),
          style: fontW5S12(context)!.copyWith(
              fontSize: 14,
              color: AppColors.whitecolor,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          Consumer<SearchProvider>(builder: (context, searchProvider, __) {
            return IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.refresh,
                  color: AppColors.whitecolor,
                ));
          })
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Consumer<SearchProvider>(builder: (context, searchProvider, __) {
            return Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Container(
                height: 110,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        // Number of columns in the grid
                        crossAxisSpacing: 10.0,
                        // Spacing between columns
                        mainAxisSpacing: 10.0,
                        // Spacing between rows
                        mainAxisExtent: 160),
                    itemCount: searchProvider.categoryFilterList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            searchProvider.selectedFilter =
                                searchProvider.filterList[index].text;
                            // searchProvider.filterList[index].isSelected =
                            //     true;
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: searchProvider.selectedFilter ==
                                      searchProvider
                                          .categoryFilterList[index].text
                                  ? AppColors.darkAppColor.withOpacity(0.8)
                                  : AppColors.appLightColor),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Container(
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: searchProvider.selectedFilter ==
                                              searchProvider
                                                  .categoryFilterList[index]
                                                  .text
                                          ? AppColors.appLightColor
                                          : AppColors.darkAppColor),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      searchProvider
                                          .categoryFilterList[index].icon
                                          .toString(),
                                      color: AppColors.whitecolor,
                                    ),
                                  )),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  searchProvider.categoryFilterList[index].text
                                      .toString(),
                                  style: fontW5S12(context)!.copyWith(
                                      fontSize: 11,
                                      color: searchProvider.selectedFilter ==
                                              searchProvider
                                                  .categoryFilterList[index]
                                                  .text
                                          ? AppColors.whitecolor
                                          : AppColors.blackcolor,
                                      fontWeight: FontWeight.w600),
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
          SizedBox(
            height: 15,
          ),
          StreamProvider.value(
              value: homeServices.streamCategoryWise(userType: widget.userType),
              initialData: [UserModelDietitian()],
              builder: (context, child) {
                List<UserModelDietitian> dietitansList =
                    context.watch<List<UserModelDietitian>>();
                return dietitansList.isEmpty
                    ? Center(
                        child: Padding(
                        padding: EdgeInsets.only(top: 90),
                        child: Text("No ${widget.userType.toString()} found!",
                            style: TextStyle(
                                // fontFamily: 'Gilroy',
                                color: AppColors.blackcolor,
                                // decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Axiforma',
                                fontSize: 13)),
                      ))
                    : dietitansList[0].userId == null
                        ? const SpinKitSpinningLines(
                            size: 45,
                            color: AppColors.appcolor,
                          )
                        : Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                padding: const EdgeInsets.only(),
                                physics: const ScrollPhysics(),

                                // physics:
                                //     const NeverScrollableScrollPhysics(),
                                itemCount: dietitansList.length,
                                itemBuilder: (_, i) {
                                  //  print(dietitansList[i]..toString());
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: InkWell(
                                      onTap: () {
                                        toNext(
                                            context: context,
                                            widget: DoctorDetails(
                                              userModel: dietitansList[i],
                                            ));
                                      },
                                      child: DietitiansCardWidget(
                                        userModel: dietitansList[i],
                                      ),
                                    ),
                                  );
                                }),
                          );
              }),
        ],
      ),
    );
  }
}
