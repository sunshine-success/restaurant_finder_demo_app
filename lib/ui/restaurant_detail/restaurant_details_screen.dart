import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:restaurant_finder_app/resources_manager/color_manager.dart';
import 'package:restaurant_finder_app/resources_manager/styles_manager.dart';

import '../../constants/constants.dart';
import '../../model/restaurants_model.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final RestaurantModel restaurant;

  const RestaurantDetailsScreen({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        body: RestaurantDetailContentBody(restaurant: restaurant),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              elevation: 0,
              expandedHeight: MediaQuery.of(context).size.height * 0.4,
              floating: false,
              pinned: true,
              title: Text(
                restaurant.name,
                style: getRegularStyle(
                  fontSize: 18.sp,
                  color: Colors.white,
                ),
              ),
              leading: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: grayColor.withOpacity(0.4),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Material(
                    type: MaterialType.transparency,
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(12),
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        color: blackColor,
                      ),
                    ),
                  ),
                ),
              ),
              flexibleSpace: _flexibleSpace(),
              backgroundColor: Colors.white,
            )
          ];
        },
      ),
    );
  }

  Widget _flexibleSpace() {
    return FlexibleSpaceBar(
      centerTitle: true,
      collapseMode: CollapseMode.pin,
      background: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Hero(
              tag: restaurant.id,
              child: Image.network(
                restaurant.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: -3,
            left: 0,
            right: 0,
            child: Container(
              height: 20.sp,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(50),
                ),
              ),
              child: Center(
                child: Container(
                  width: 30.sp,
                  height: 10.sp,
                  decoration: BoxDecoration(
                    color: grayColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20.sp),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10.sp,
            right: 20.sp,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(10.sp),
                child: AnimatedCrossFade(
                  firstChild: Icon(
                    Icons.favorite,
                    color: primaryColor,
                    size: 20,
                  ),
                  secondChild: Icon(
                    Icons.favorite_border,
                    color: primaryColor,
                    size: 20,
                  ),
                  crossFadeState: CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 200),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RestaurantDetailContentBody extends StatelessWidget {
  final RestaurantModel restaurant;

  const RestaurantDetailContentBody({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.sp),
                Text(
                  restaurant.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: getBoldStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 5.sp),

                // Ratings
                Row(
                  children: [
                    Text(
                      restaurant.rating.toString(),
                      style: getRegularStyle(
                        fontSize: 15.sp,
                        color: ColorManager.grey,
                      ),
                    ),
                    SizedBox(width: 8.sp),
                    RatingBar(
                      initialRating: restaurant.rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      ignoreGestures: true,
                      itemCount: 5,
                      itemSize: 13,
                      ratingWidget: RatingWidget(
                        full: const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        half: const Icon(
                          Icons.star_half,
                          color: Colors.amber,
                        ),
                        empty: const Icon(
                          Icons.star_border,
                          color: Colors.amber,
                        ),
                      ),
                      onRatingUpdate: (rating) {
                        debugPrint(rating.toString());
                      },
                    ),
                    Text(
                      " (${restaurant.totalRatings.toString()})",
                      style: getRegularStyle(
                        fontSize: 15.sp,
                        color: ColorManager.grey,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.sp),

                // Location
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: primaryColor,
                      size: 15.sp,
                    ),
                    SizedBox(
                      width: 5.sp,
                    ),
                    Expanded(
                      child: Text(
                        (restaurant.location.isNotEmpty
                                ? "${restaurant.location}, "
                                : "") +
                            restaurant.city,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: getRegularStyle(
                          fontSize: 15.sp,
                          color: ColorManager.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.sp),

                // Timing
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      color: primaryColor,
                      size: 15.sp,
                    ),
                    SizedBox(
                      width: 5.sp,
                    ),
                    Expanded(
                      child: Text(
                        restaurant.hours,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: getRegularStyle(
                          fontSize: 15.sp,
                          color: ColorManager.grey,
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.sp),
                  child: Divider(
                    color: blackColor.withOpacity(0.5),
                  ),
                ),

                // Description
                Text(
                  "Description",
                  style: getBoldStyle(
                    fontSize: 17.sp,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10.sp),
                Text(
                  restaurant.description,
                  style: getRegularStyle(
                    fontSize: 15.sp,
                    color: blackColor,
                  ),
                ),
                SizedBox(height: 20.sp),

                // Menu chip
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Menus",
                      style: getBoldStyle(
                        fontSize: 17.sp,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5.sp),
                    Wrap(
                      spacing: 8.sp,
                      children: List<Widget>.generate(
                          restaurant.menuList.length, (int index) {
                        return Stack(
                          children: [
                            Chip(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              label: Text(
                                restaurant.menuList[index],
                                style: getRegularStyle(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                ),
                              ),
                              shadowColor: Colors.grey[60],
                              backgroundColor: Colors.grey.withOpacity(0.25),
                            ),
                          ],
                        );
                      }),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
