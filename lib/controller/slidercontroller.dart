import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/slider.dart';
import '../service/slider_service.dart';

class SliderController extends GetxController {
  SliderService _sliderService = SliderService();
  var sliderList = <Slider>[].obs;
  var isLoading = true.obs;
  var box = GetStorage();

  // @override
  // void onInit() {
  //   fechSliders();
  //   super.onInit();
  // }

  // Future<bool> fechSliders() async {
  //   try {
  //     isLoading(true);
  //     var sliders = await _sliderService.fetchSliders();
  //     if (sliders.length != 0) {
  //       sliderList.value = sliders;
  //       isLoading(false);
  //       return true;
  //     } else {
  //       isLoading(true);
  //       return false;
  //     }
  //   } catch (err) {
  //     throw (err);
  //   }
  // }

  @override
  void onInit() {
    fechSliders();
    if(box.read('carouselData') != null) {
      sliderList.assignAll(box.read('carouselData'));
    }
    super.onInit();
  }

  void fechSliders() async {
    try{
      isLoading .value= true;
      update();

      List<Slider> _data = await _sliderService.fetchSliders();
      if(_data !=[]){
        sliderList.assignAll(_data);
        box.write('carouselData', _data);
      }
    }finally{
      isLoading.value = false;
      update();
      
    }
  }
}
