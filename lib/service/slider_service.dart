import '../model/slider.dart';

import '../repository/repository.dart';

class SliderService {
  Repository _repository = Repository();
  SliderService() {
    _repository = Repository();
  }
  // getSlider() async {
  //   return await _repository.httpGet('slider');
  // }

  Future<List<Slider>> fetchSliders() async {
    try {
      var response = await _repository.httpGet('slider');
      List<Slider> sliderLists = [];
      if (response.statusCode == 200) {
        var jsonString = response.body;
        sliderLists = sliderFromJson(jsonString);
        return sliderLists;
      } else {
        return [];
      }
    } catch (err) {
      throw err;
    }
  }
}
