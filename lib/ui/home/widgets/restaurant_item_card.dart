import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:restaurant_finder_app/resources_manager/string_manager.dart';

import '../../../model/restaurants_model.dart';
import '../../../resources_manager/color_manager.dart';
import '../../../resources_manager/styles_manager.dart';

class RestaurantItemCard extends StatelessWidget {
  const RestaurantItemCard({Key? key, required this.model}) : super(key: key);
  final RestaurantModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50.sp,
          width: 50.sp,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            image: DecorationImage(
              image: NetworkImage(model.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 15.sp),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                style: getBoldStyle(
                    color: ColorManager.textColorPrimary, fontSize: 17.sp),
              ),
              SizedBox(height: 8.sp),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5.sp),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                    child: Icon(Icons.star, size: 15.sp, color: Colors.white),
                  ),
                  SizedBox(width: 8.sp),
                  Text(
                    model.rating.toString(),
                    style: getBoldStyle(
                        color: ColorManager.textColorPrimary, fontSize: 15.sp),
                  ),
                  SizedBox(width: 5.sp),
                  Text(
                    '(${model.totalRatings.toString()}+)',
                    style: getBoldStyle(
                        color: ColorManager.textColorPrimary, fontSize: 15.sp),
                  ),
                ],
              ),
              SizedBox(height: 8.sp),
              Text(
                'Avg Cost : Rs. ${model.averageCostForTwo.toString()}',
                style: getBoldStyle(
                    color: ColorManager.textColorPrimary, fontSize: 15.5.sp),
              ),
              SizedBox(height: 8.sp),
              Text(
                model.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: getRegularStyle(
                    color: ColorManager.grey, fontSize: 15.5.sp),
              ),
              SizedBox(height: 8.sp),
              Text(
                model.city,
                style: getRegularStyle(
                    color: ColorManager.grey, fontSize: 15.5.sp),
              ),
              SizedBox(height: 20.sp),
              model.freeDelivery
                  ? Container(
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.sp),
                        color: Colors.purple.withOpacity(0.15),
                      ),
                      child: Text(
                        StringManager.txtFreeDelivery,
                        style:
                            getBoldStyle(color: Colors.purple, fontSize: 12.sp),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        )
      ],
    );
  }
}
