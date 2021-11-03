import 'package:bdelect/model/group.dart';
import '../service/group_service.dart';
import 'package:get/get.dart';

class GroupController extends GetxController {
  GroupService _groupService = GroupService();
  var groupList = <Group>[].obs;
  @override
  void onInit() {
    fechGroups();
    super.onInit();
  }

  Future<bool> fechGroups() async {
    try {
      var groups = await _groupService.fetchGroup();
      if (groups.length != 0) {
        groupList.value = groups;
        return true;
      } else {
        return false;
      }
    } catch (err) {
      throw (err);
    }
  }

  Group fechGroupById(var id) {
    var _productGroup = groupList.firstWhere(
      (element) => element.id == id,
    );
    return _productGroup;
  }
}
