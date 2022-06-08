import 'package:get/get.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/models/user.dart';
import 'package:velocityx/services/usersDb.dart';
import 'package:intl/intl.dart';

class UserController extends GetxController {
  Rx<UserModel> userModel = UserModel().obs;
  Rx<List<UserModel>> userList =
      Rx<List<UserModel>>(List.empty(growable: true));

  UserModel get user => userModel.value;
  List<UserModel> get users => userList.value;

  set user(UserModel value) => this.userModel.value = value;

  void clear() {
    userModel.value = UserModel();
  }

  @override
  void onReady() async {
    super.onReady();
    String uid = Get.find<AuthController>().user!.uid;
    print("Accessing user stream");
    userModel.bindStream(UserDb().userStream(uid));
    ever(userModel, _userListStream);
  }

  void _userListStream(UserModel userModel) {
    userList.bindStream(UserDb().userListStream(user.organization_no));
  }

  String getDateFromTimeStamp(String timestamp) {
    int time = int.parse(timestamp);
    DateTime date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    String formattedDate = DateFormat('M/d/y ').format(date);
    return formattedDate;
  }
}
