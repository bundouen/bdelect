import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/productcontroller.dart';
import '../../screen/product_by_group_screen.dart';
import '../group_item.dart';

class GroupProduct extends StatelessWidget {
  // final GroupController groupController = Get.find<GroupController>();
  final groups;
  final ProductController controller;
  GroupProduct(this.groups, this.controller);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 200,
        // color: Colors.grey[200],
        child: Obx(() {
           if (controller.isLoading.value)
          return Center(
            child: CupertinoActivityIndicator(
              animating: true,
              radius: 10,
            ),
          );
        else
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: groups.length,
            itemBuilder: (ctxt, i) {
              return InkWell(
                onTap: () {
                  Get.toNamed(
                    ProductByGroupScreen.routeName,
                    arguments: groups[i].id,
                  );
                },
                child: GroupItem(groups: groups[i]),
              );
            },
          );
        }),
      ),
    );
  }
}
