import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/controllers/CategoryController.dart';
import 'package:velocityx/controllers/filesController.dart';
import 'package:velocityx/shared/TaskTile.dart';

class Files extends StatelessWidget {
  final List<dynamic> category;

  const Files({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<CategoryController>(
          init: Get.put(CategoryController(category)),
          builder: (categoryController) {
            if (categoryController != null &&
                categoryController.categoryFiles.length > 0) {
              return ListView.builder(
                  itemCount: categoryController.categoryFilesId.length,
                  itemBuilder: (_, index) {
                    // return TaskTile(
                    //     assigned_by: "Random Person",
                    //     due_date: "Random Due Date",
                    //     filesModel: controller.categoryFiles[index]);
                    return Text(
                        categoryController.categoryFilesId[index].toString());
                  });
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
