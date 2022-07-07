import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/controllers/categoryController.dart';
import 'package:velocityx/controllers/filesController.dart';
import 'package:velocityx/models/user_categories.dart';
import 'package:velocityx/routes/app_pages.dart';
import 'package:velocityx/shared/TaskTile.dart';
import 'package:velocityx/shared/constants.dart';

class Files extends StatelessWidget {
  final CategoryModel category;

  const Files({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: GetBuilder<CategoryController>(
          init: Get.put<CategoryController>(CategoryController()),
          builder: (controller) {
            if (controller.initialized == false) {
              print(category.ids);
              print(category.name);
              controller.categoryFilesIds.value = category.ids ?? [];
              for (String id in category.ids ?? []) {
                print(id);
                controller.initializeCategoryFileList(id);
              }
              // controller.getFileModelsFromIds(category.ids ?? []);
              controller.changeInitialized(true);
            }
            if (controller.categoryFiles.length > 0) {
              return ListView.builder(
                  itemCount: controller.categoryFiles.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.METADATA,
                            id: Constants.homeId,
                            arguments: controller.categoryFiles[index]);
                      },
                      child: TaskTile(
                          assigned_by: "Random Person",
                          due_date: "Random date",
                          filesModel: controller.categoryFiles[index]),
                    );
                  });
            } else {
              return Center(
                  child: Text(
                "No Files in this Category",
                style: Theme.of(context).textTheme.headline5,
              ));
            }
          },
        ));
  }
}
