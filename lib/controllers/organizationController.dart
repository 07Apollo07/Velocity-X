import 'package:get/get.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/controllers/userController.dart';
import 'package:velocityx/models/organization.dart';
import 'package:velocityx/services/organizationDb.dart';

class OrganizationController extends GetxController {
  Rx<OrganizationModel> orgModel = OrganizationModel().obs;
  OrganizationModel get org => orgModel.value;
  bool initialized = false;
  // set org(OrganizationModel value) => this.orgModel.value = value;

  void fetchInfo() {
    try {
      print("User controller initilized and Org controller fetching");
      String orgUid = Get.find<UserController>().user.organization_no;
      print("from org controller org id is " + orgUid);
      orgModel.bindStream(OrganiztionDb().orgStream(orgUid));
      print(orgModel);
      changeInitalized(true);
    } catch (e) {
      print(e.toString());
    }
  }

  void changeInitalized(bool change) {
    initialized = change;
    update();
  }
}
