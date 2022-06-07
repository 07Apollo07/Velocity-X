import 'package:get/get.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/models/user.dart';
import 'package:velocityx/services/usersDb.dart';

class UserController extends GetxController {
  Rx<UserModel> userModel = UserModel().obs;

  UserModel get user => userModel.value;

  set user(UserModel value) => this.userModel.value = value;

  void clear() {
    userModel.value = UserModel();
  }

  @override
  void onInit() {
    String uid = Get.find<AuthController>().user!.uid;
    print("Accessing user stream");
    userModel
        .bindStream(UserDb().userStream(uid)); //stream coming from firebase
  }
}
