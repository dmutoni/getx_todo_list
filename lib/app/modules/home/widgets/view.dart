import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:getx_todo_list/app/core/values/colors.dart';
import 'package:getx_todo_list/app/data/model/task.dart';
import 'package:getx_todo_list/app/modules/home/widgets/add_cart.dart';
import 'package:getx_todo_list/app/modules/home/widgets/add_diolog.dart';
import 'package:getx_todo_list/app/modules/home/widgets/controller.dart';
import 'package:getx_todo_list/app/core/utils/extensions.dart';
import 'package:getx_todo_list/app/modules/home/widgets/task_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(children: [
        Padding(
          padding: EdgeInsets.all(4.0.wp),
          child: Text(
            'My list using Getx',
            style: TextStyle(
              fontSize: 24.0.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Obx(
          () => GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              ...controller.tasks
                  .map((element) => LongPressDraggable(
                        data: element,
                        onDragStarted: () => controller.changeDeleting(true),
                        onDraggableCanceled: (_, __) =>
                            controller.changeDeleting(false),
                        onDragEnd: (_) => controller.changeDeleting(false),
                        feedback: Opacity(
                            opacity: 0.8, child: TaskCard(task: element)),
                        child: TaskCard(
                          task: element,
                        ),
                      ))
                  .toList(),
              AddCard()
            ],
          ),
        )
      ])),
      floatingActionButton: DragTarget<Task>(
        builder: (_, __, ___) {
          return Obx(
            () => FloatingActionButton(
              backgroundColor: controller.deleting.value ? Colors.red : blue,
              onPressed: () => Get.to(() => AddDialog(), transition:  Transition.downToUp),
              child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
            ),
          );
        },
        onAccept: (Task task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess('Delete Success');
        },
      ),
    );
  }
}
