import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:getx_todo_list/app/data/model/task.dart';
import 'package:getx_todo_list/app/modules/home/widgets/add_cart.dart';
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
        Obx(() =>
           GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              ...controller.tasks
                  .map((element) => TaskCard(
                        task: element,
                      ))
                  .toList(),
              TaskCard(
                  task: const Task(
                      title: 'title', icon: 0xe59c, color: '#FF2B60E6')),
              AddCard()
            ],
          ),
        )
      ])),
    );
  }
}
