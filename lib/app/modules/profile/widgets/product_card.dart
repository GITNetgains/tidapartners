import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/models/details_model.dart';
import '../../home/widgets/universal_button.dart';

class ProductCard extends StatelessWidget {
  final DetailsModel data;
  final Function()? onPressed;

  const ProductCard({super.key, required this.data, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
          margin: EdgeInsets.symmetric(vertical: 8.dg, horizontal: 10.0.dg),
          child: ListTile(
              visualDensity: VisualDensity(horizontal: -4.0),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  data.imagePath,
                  height: 60.h,
                  width: 60.h,
                  cacheHeight: 100,
                  cacheWidth: 100,
                ),
              ),
              title: Text(
                data.name.length > 20
                    ? "${data.name.substring(0, 17).capitalize}..."
                    : data.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                data.location.length > 30
                    ? "${data.location.substring(0, 27).capitalizeFirst}..."
                    : data.location,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
              trailing: IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.arrow_forward_ios,
                ),
              )
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     GestureDetector(
              //       child: Icon(CupertinoIcons.pencil),
              //       onTap: () {},
              //     ),
              //     UniversalButton(
              //       name: 'View Details',
              //       function: () {},
              //       fontSize: 10.sp,
              //     )
              //   ],
              // ),
              )),
    );
  }
}
