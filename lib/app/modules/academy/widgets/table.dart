import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidapartners/app/modules/profile/models/academy_model.dart';

import '../controllers/academy_details_controller.dart';

class SimpleTable extends StatelessWidget {
  final AcademyDetailsController controller;

  const SimpleTable({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.academyDataModel.amenities != null) {
      List<TableRow> tableRows = List.empty(growable: true);

      List<Amenities> amenitiesList = [];
      for (var data in controller.academyDataModel.amenities!) {
        print(data);
        amenitiesList.add(data);
      }
      print(controller.academyDataModel.amenities);
      print(amenitiesList);
      if (amenitiesList.isNotEmpty) {
        tableRows = _buildTableRows(amenitiesList);
      } else {
        tableRows.add(
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(''),
                  ),
                ),
              ),
            ],
          ),
        );
      }

      return Table(
        defaultColumnWidth: FlexColumnWidth(0.5),
        children: tableRows,
      );
    }

    return Container(); // Return an empty container if metaData is null
  }

//   List<TableRow> _buildTableRows(List<String> amenitiesList) {
//     List<TableRow> rows = [];
//     for (int i = 0; i < amenitiesList.length; i += 3) {
//       List<Widget> cells = [];
//       for (int j = i; j < i + 3 && j < amenitiesList.length; j++) {
//         cells.add(
//           TableCell(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Center(
//                 child: Text(amenitiesList[j]),
//               ),
//             ),
//           ),
//         );
//       }
//       rows.add(TableRow(children: cells));
//     }
//     return rows;
//   }
// }

  List<TableRow> _buildTableRows(List<Amenities> amenitiesList) {
    List<TableRow> rows = List.empty(growable: true);
    int numItems = amenitiesList.length;
    //int numRows = (numItems / 3).ceil(); // Calculate number of rows needed

    for (int i = 0; i < numItems; i += 2) {
      print(amenitiesList[i]);
      if (i + 2 <= numItems) {
        rows.add(TableRow(children: [
          TableCell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    amenitiesList[i].image ?? "" ,
                    height: 15.h,
                    width: 15.w,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "assets/aminities/wifi.png",
                        height: 15.h,
                        width: 15.w,
                      );
                    },
                  ),
                  Container(
                    // width: 70.w,
                    padding: EdgeInsets.only(left: 4.w),

                    child: Center(
                      child: Text(amenitiesList[i].displayName ?? "Rest Room"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          TableCell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.network(
                    amenitiesList[i+1].image ?? "",
                    height: 15.h,
                    width: 15.w,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "assets/aminities/wifi.png",
                        height: 15.h,
                        width: 15.w,
                      );
                    },
                  ),
                  Container(
                    // width: 70.w,
                    padding: EdgeInsets.only(left: 4.w),

                    child: Center(
                      child:
                          Text(amenitiesList[i + 1].displayName ?? "Rest Room"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // TableCell(
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Row(
          //       children: [
          //         Image.asset(
          //           "assets/aminities/${amenitiesList[i + 2].enumName}.png",
          //           height: 15.h,
          //           width: 15.w,
          //           errorBuilder: (context, error, stackTrace) {
          //             return Image.asset(
          //               "assets/aminities/wifi.png",
          //               height: 15.h,
          //               width: 15.w,
          //             );
          //           },
          //         ),
          //         Container(
          //           width: 70.w,
          //           child: Center(
          //             child: Text(
          //                  amenitiesList[i + 2].displayName ?? "Rest Room"),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ]));
      } else if (i + 1 <= numItems) {
        rows.add(TableRow(children: [
          TableCell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.network(
                    amenitiesList[i].image ?? "",
                    height: 15.h,
                    width: 15.w,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "assets/aminities/wifi.png",
                        height: 15.h,
                        width: 15.w,
                      );
                    },
                  ),
                  Container(
                    // width: 70.w,
                    padding: EdgeInsets.only(left: 4.w),

                    child: Center(
                      child: Text(amenitiesList[i].displayName ?? "Rest Room"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // TableCell(
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Row(
          //       children: [
          //         Image.asset(
          //           "assets/aminities/${amenitiesList[i + 1].enumName}.png",
          //           height: 15.h,
          //           width: 15.w,
          //           errorBuilder: (context, error, stackTrace) {
          //             return Image.asset(
          //               "assets/aminities/wifi.png",
          //               height: 15.h,
          //               width: 15.w,
          //             );
          //           },
          //         ),
          //         Container(
          //           width: 70.w,
          //           child: Center(
          //             child: Text( amenitiesList[i + 1].displayName ?? "Rest Room"),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          TableCell(child: SizedBox.shrink())
        ]));
      }
      //   else {
      //     rows.add(TableRow(children: [
      //       TableCell(
      //         child: Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Row(
      //             children: [
      //               Image.asset(
      //                 "assets/aminities/${amenitiesList[i].enumName}.png",
      //                 height: 15.h,
      //                 width: 15.w,
      //                 errorBuilder: (context, error, stackTrace) {
      //                   return Image.asset(
      //                     "assets/aminities/wifi.png",
      //                     height: 15.h,
      //                     width: 15.w,
      //                   );
      //                 },
      //               ),
      //               Container(
      //                 width: 70.w,
      //                 child: Center(
      //                   child: Text( amenitiesList[i].displayName ?? "Rest Room"),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //       TableCell(child: SizedBox.shrink()),
      //       TableCell(child: SizedBox.shrink())
      //     ]));
      //   }
    }
    // for (int i = 0; i < numRows; i++) {
    //   List<Widget> cells = [];

    //   // Calculate the start and end index for this row
    //   int start = i * 3;
    //   int end = (i + 1) * 3;

    //   // Ensure end doesn't exceed the length of the list
    //   if (end > numItems) {
    //     end = numItems;
    //   }

    //   // Add cells for this row
    //   for (int j = start; j < end; j++) {
    //     cells.add(
    //       TableCell(
    //         child: Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Center(
    //             child: Text(amenitiesList[j]),
    //           ),
    //         ),
    //       ),
    //     );
    //   }

    //   // If the row has fewer than 3 cells, add empty cells to make up 3 cells
    //   while (cells.length < 3) {
    //     cells.add(
    //       TableCell(
    //         child: Container(), // Empty container for additional cell
    //       ),
    //     );
    //   }

    //   rows.add(TableRow(children: cells));
    // }

    return rows;
  }
}
