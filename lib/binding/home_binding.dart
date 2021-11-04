import 'package:bdelect/controller/user_controller.dart';

import '../controller/brandcontroller.dart';
import '../controller/categoryController.dart';
import '../controller/product_name_controller.dart';

import 'package:get/get.dart';

import '../controller/groupcontroller.dart';
import '../controller/productcontroller.dart';
import '../controller/slidercontroller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put<ProductController>(
    //   ProductController(),
    //   permanent: true,
    // );
    Get.lazyPut(() => ProductController(), fenix: true);
    Get.put<SliderController>(
      SliderController(),
      permanent: true,
    );
    // Get.lazyPut(() => SliderController(), fenix: true);
    Get.put<GroupController>(
      GroupController(),
      permanent: true,
    );
    // Get.lazyPut(() => GroupController(), fenix: true);
    Get.put<BrandController>(
      BrandController(),
      permanent: true,
    );
    // Get.lazyPut(() => BrandController(), fenix: true);
    Get.put<CategoryController>(
      CategoryController(),
      permanent: true,
    );
    // Get.lazyPut(() => CategoryController(), fenix: true);
    Get.put<ProductNameController>(
      ProductNameController(),
      permanent: true,
    );
    // Get.lazyPut(() => ProductNameController(), fenix: true);
    Get.put<UserController>(
      UserController(),
      permanent: true,
    );
    // Get.lazyPut(() => UserController(), fenix: true);
  }
}
