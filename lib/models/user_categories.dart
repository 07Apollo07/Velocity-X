import 'package:cloud_firestore/cloud_firestore.dart';

class UserCategoryModel {
  late List<dynamic>? category = [];

  UserCategoryModel({
    this.category,
  });
  UserCategoryModel.fromDocumentSnapshot({DocumentSnapshot? documentSnapshot}) {
    category = documentSnapshot!["Categories"];
    print(category);
  }
}

class CategoryModel {
  late String? name = "";
  late List<dynamic>? ids = [];

  CategoryModel({this.name, this.ids});
}
