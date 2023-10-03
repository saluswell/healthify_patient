import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:healthifi_patient/src/dashboardSection/providers/search_provider.dart';
import 'package:provider/provider.dart';

import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import '../../authenticationsection/Models/userModelDietitian.dart';
import '../services/home_services.dart';
import '../widgets/search_widget.dart';

class SearchCarProviderScreen extends StatefulWidget {
  const SearchCarProviderScreen({Key? key}) : super(key: key);

  @override
  State<SearchCarProviderScreen> createState() =>
      _SearchCarProviderScreenState();
}

class _SearchCarProviderScreenState extends State<SearchCarProviderScreen> {
  HomeServices homeServices = HomeServices();

  List<UserModelDietitian> searchedContact = [];

  List<UserModelDietitian> contactList = [];

  bool isSearchingAllow = false;
  bool isSearched = false;
  List<UserModelDietitian> contactListDB = [];

  void _searchedContacts(String val) async {
    print(contactListDB.length);
    searchedContact.clear();
    for (var i in contactListDB) {
      var lowerCaseString = i.userName.toString().toLowerCase() +
          " " +
          i.userName.toString().toLowerCase() +
          i.userName.toString();

      var defaultCase = i.userName.toString() +
          " " +
          i.userName.toString() +
          i.userName.toString();

      if (lowerCaseString.contains(val) || defaultCase.contains(val)) {
        searchedContact.add(i);
      } else {
        setState(() {
          isSearched = true;
        });
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Search Care Providers",
          style: fontW5S12(context)!.copyWith(
              fontSize: 14,
              color: AppColors.whitecolor,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          Consumer<SearchProvider>(builder: (context, searchProvider, __) {
            return IconButton(
                onPressed: () {
                  setState(() {
                    searchProvider.selectedFilter = null;
                  });
                },
                icon: Icon(
                  Icons.refresh,
                  color: AppColors.whitecolor,
                ));
          })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 1, right: 10),
              child: SizedBox(
                height: 55,
                child: Card(
                  elevation: 3,
                  color: AppColors.appLightColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: TextFormField(
                    enabled: true,
                    onChanged: (val) {
                      _searchedContacts(val);
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15, top: 13),
                        border: InputBorder.none,
                        hintText: "Search here",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                        suffixIcon: Icon(Icons.search)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Consumer<SearchProvider>(builder: (context, searchProvider, __) {
              return Padding(
                padding: const EdgeInsets.only(left: 5),
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
                      itemCount: searchProvider.filterList.length,
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
                                        searchProvider.filterList[index].text
                                    ? AppColors.darkAppColor.withOpacity(0.8)
                                    : AppColors.appLightColor),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Container(
                                    height: 32,
                                    width: 32,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: searchProvider.selectedFilter ==
                                                searchProvider
                                                    .filterList[index].text
                                            ? AppColors.appLightColor
                                            : AppColors.darkAppColor),
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Image.asset(searchProvider
                                          .filterList[index].icon
                                          .toString()),
                                    )),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    searchProvider.filterList[index].text
                                        .toString(),
                                    style: fontW5S12(context)!.copyWith(
                                        fontSize: 11,
                                        color: searchProvider.selectedFilter ==
                                                searchProvider
                                                    .filterList[index].text
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
              height: 10,
            ),
            Consumer<SearchProvider>(builder: (context, searchProvider, __) {
              return StreamProvider.value(
                  value: homeServices.streamFilter(
                      selectedType: searchProvider.selectedFilter == null
                          ? "null"
                          : searchProvider.selectedFilter.toString()),
                  initialData: [UserModelDietitian()],
                  builder: (context, child) {
                    contactListDB = context.watch<List<UserModelDietitian>>();
                    List<UserModelDietitian> list =
                        context.watch<List<UserModelDietitian>>();
                    return list.isEmpty
                        ? Center(
                            child: Padding(
                            padding: const EdgeInsets.only(top: 100.0),
                            child: Text("No Data Found!",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13)),
                          ))
                        : list[0].userId == null
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 50.0),
                                  child: SpinKitPulse(
                                    color: Colors.blue,
                                  ),
                                ),
                              )
                            : list.isEmpty
                                ? Center(
                                    child: Text("No Data Found!",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13)),
                                  )
                                : searchedContact.isEmpty
                                    ? isSearched == true
                                        ? Center(
                                            child: Text("No Data Found!",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13)),
                                          )
                                        : Container(
                                            // height: 550,
                                            // width: MediaQuery.of(context).size.width,

                                            child: Expanded(
                                            child: ListView.builder(
                                                itemCount: contactListDB.length,
                                                shrinkWrap: true,
                                                padding: EdgeInsets.only(),
                                                itemBuilder: (context, i) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8),
                                                    child:
                                                        SearchDietitiansWidget(
                                                      userModel: list[i],
                                                    ),
                                                  );
                                                }),
                                          ))
                                    : Container(
                                        child: Expanded(
                                        child: ListView.builder(
                                            itemCount: searchedContact.length,
                                            shrinkWrap: true,
                                            padding: EdgeInsets.only(),
                                            itemBuilder: (context, i) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8),
                                                child: SearchDietitiansWidget(
                                                  userModel: searchedContact[i],
                                                ),
                                              );
                                            }),
                                      ));
                  });
            })
          ],
        ),
      ),
    );
  }
}
