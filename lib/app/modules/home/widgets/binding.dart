import 'package:get/get.dart';
import 'package:getx_todo_list/app/data/providers/task/provider.dart';
import 'package:getx_todo_list/app/data/services/storage/repository.dart';
import 'package:getx_todo_list/app/modules/home/widgets/controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(
            taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        )));
  }
}
