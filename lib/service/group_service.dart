import '../model/group.dart';
import '../repository/repository.dart';

class GroupService {
  Repository _repository = Repository();
  GroupService() {
    _repository = Repository();
  }
  Future<List<Group>> fetchGroup() async {
    try {
      var response = await _repository.httpGet('group');
      List<Group> groupLists = [];
      if (response.statusCode == 200) {
        var jsonString = response.body;
        groupLists = groupFromJson(jsonString);
        return groupLists;
      } else {
        return [];
      }
    } catch (err) {
      throw err;
    }
  }
}
