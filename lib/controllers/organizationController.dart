import 'package:get/get.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/controllers/userController.dart';
import 'package:velocityx/models/organization.dart';
import 'package:velocityx/services/organizationDb.dart';

class OrganizationController extends GetxController {
  Rx<OrganizationModel> orgModel = Rx<OrganizationModel>(OrganizationModel());
  OrganizationModel get org => orgModel.value;
  set org(OrganizationModel value) => this.orgModel.value = value;

  @override
  void onReady() async {
    super.onReady();
    String orgUid = Get.find<UserController>().user.organization_no;
    print("from org controller org id is " + orgUid);
    orgModel.bindStream(OrganiztionDb().orgStream(orgUid));
    print(orgModel);
  }
}
