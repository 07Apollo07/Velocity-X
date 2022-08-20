import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:velocityx/models/organization.dart';

class OrganiztionDb {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("Organization");

  Future<List> getAllOrganizations() async {
    QuerySnapshot querySnapshot =
        await userCollection.get() as QuerySnapshot<Object?>;
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  Future<List> getOrganizationByUID(String uid) async {
    QuerySnapshot querySnapshot = await userCollection
        .where("Uid", isEqualTo: uid)
        .get() as QuerySnapshot<Object?>;
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  Future<List> getOrganizationByName(String name) async {
    QuerySnapshot querySnapshot = await userCollection
        .where("orgName", isEqualTo: name)
        .get() as QuerySnapshot<Object?>;
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  // Future<OrganizationModel> GetOrganizationInfo(String orgId) async {
  //   try {
  //     OrganizationModel _OrgInfo = OrganizationModel();
  //     await _firestore.collection("Organization").doc(orgId).get().then(
  //       (DocumentSnapshot doc) {
  //         _OrgInfo =
  //             OrganizationModel.fromDocumentSnapshot(documentSnapshot: doc);
  //         print(_OrgInfo.orgName);
  //         // print(_fileStat.fileLastOpenedDateTime);
  //         // print(_fileStat.file_transfers);
  //         // print(_fileStat.tracking);
  //       },
  //     );
  //     return _OrgInfo;
  //   } catch (e) {
  //     print(e.toString());
  //     return OrganizationModel();
  //   }
  // }
  Stream<OrganizationModel> orgStream(String orgId) {
    print("orgId is ${orgId}");
    print("Accessing Current Signed in Organization Stream");
    return _firestore
        .collection("Organization")
        .doc(orgId)
        .snapshots()
        .map((DocumentSnapshot query) {
      print(query.data());
      return OrganizationModel.fromDocumentSnapshot(documentSnapshot: query);
    });
  }
}
