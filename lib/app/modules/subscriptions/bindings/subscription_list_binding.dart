import 'package:get/get.dart';
import 'package:tidapartners/app/modules/subscriptions/controllers/subscriptions_list_controller.dart';

class SubscriptionListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubscriptionListController>(
      () => SubscriptionListController(),
    );
  }
}