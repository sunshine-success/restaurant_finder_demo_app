import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:restaurant_finder_app/model/restaurants_model.dart';
import 'package:restaurant_finder_app/resources_manager/color_manager.dart';
import 'package:restaurant_finder_app/resources_manager/string_manager.dart';
import 'package:restaurant_finder_app/resources_manager/styles_manager.dart';
import 'package:restaurant_finder_app/ui/home/widgets/restaurant_item_card.dart';
import 'package:restaurant_finder_app/ui/restaurant_detail/restaurant_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<RestaurantModel> restaurants = [];

  TextEditingController searchController = TextEditingController();
  List<RestaurantModel> searchResult = [];

  @override
  void initState() {
    super.initState();
    loadRestaurantData();
  }

  Future<void> loadRestaurantData() async {
    // load json file
    // and setData to list
    final String data =
        await rootBundle.loadString('assets/dummy_restaurants.json');
    final List<dynamic> jsonList = json.decode(data);
    setState(() {
      restaurants =
          jsonList.map((json) => RestaurantModel.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorManager.primary,
        title: Text(
          StringManager.txtRestaurantFinderApp,
          style: getRegularStyle(
            fontSize: 17.sp,
            color: Colors.white,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // build SearchTextFormField
              SizedBox(height: 15.sp),
              searchTextFormFieldWidget(),

              SizedBox(height: 20.sp),
              Text(
                StringManager.txtRestaurant,
                style: getBoldStyle(
                    color: ColorManager.textColorPrimary, fontSize: 18.sp),
              ),
              SizedBox(height: 5.sp),
              Text(
                StringManager.txtRecommendationRestaurant,
                style:
                    getRegularStyle(color: ColorManager.grey, fontSize: 15.sp),
              ),
              SizedBox(height: 15.sp),
              searchResult.isNotEmpty || searchController.text.isNotEmpty
                  ? buildSearchResultWidget()
                  : buildRestaurantsListWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRestaurantsListWidget() {
    return restaurants.isEmpty
        ? Center(
            child: Text(
              StringManager.txtNoRestaurantsFound,
              style: getBoldStyle(color: Colors.black, fontSize: 15.5.sp),
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = restaurants[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 2.5.h),
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => RestaurantDetailsScreen(
                            restaurant: restaurant,
                          ),
                        ),
                      );
                    },
                    child: RestaurantItemCard(model: restaurant)),
              );
            },
          );
  }

  Widget buildSearchResultWidget() {
    return searchResult.isEmpty
        ? Center(
            child: Text(
              StringManager.txtNoResultsFound,
              style: getBoldStyle(color: Colors.black, fontSize: 15.5.sp),
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: searchResult.length,
            itemBuilder: (context, index) {
              final restaurant = searchResult[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 2.5.h),
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => RestaurantDetailsScreen(
                            restaurant: restaurant,
                          ),
                        ),
                      );
                    },
                    child: RestaurantItemCard(model: restaurant)),
              );
            },
          );
  }

  Widget searchTextFormFieldWidget() {
    return TextFormField(
      autofocus: false,
      controller: searchController,
      onChanged: (val) => onSearchTextChanged(val),
      decoration: InputDecoration(
        suffixIcon: searchController.text.isEmpty
            ? const SizedBox()
            : InkWell(
                child: const Icon(Icons.close, color: Colors.black),
                onTap: () {
                  FocusScope.of(context).unfocus();
                  searchController.clear();
                  onSearchTextChanged('');
                },
              ),
        contentPadding: EdgeInsets.symmetric(horizontal: 15.sp),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.sp),
          borderSide: BorderSide(
            width: 3.sp,
            color: Colors.red,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.sp),
          borderSide: BorderSide(
            width: 3.sp,
            color: Colors.red,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.sp),
          borderSide: BorderSide(
            width: 3.sp,
            color: Colors.red,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.sp),
          borderSide: BorderSide(
            width: 3.sp,
            color: Colors.red,
          ),
        ),
        hintText: StringManager.txtSearch,
        hintStyle: getRegularStyle(
          color: ColorManager.grey,
          fontSize: 15.sp,
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    // local Search Logic
    // based on entered City it will store element to searchResultList

    searchResult.clear();
    for (var element in restaurants) {
      if (element.city.contains(text) ||
          element.city.toLowerCase().contains(text.toLowerCase())) {
        searchResult.add(element);
      }
    }
    setState(() {});
  }
}
