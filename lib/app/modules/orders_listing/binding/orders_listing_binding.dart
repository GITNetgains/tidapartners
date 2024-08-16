import 'package:get/get.dart';
import 'package:tidapartners/app/modules/orders_listing/controller/orders_listing_controller.dart';




class OrdersListingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrdersListingController>(
      () => OrdersListingController(),
    );
  }
}