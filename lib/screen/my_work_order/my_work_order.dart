import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/screen/drawer/drawer.dart';

import '../../controller/current_progress_of_work_order/progress_of_work_order.dart';

class Current_work_order extends StatefulWidget {
  const Current_work_order({super.key});

  @override
  State<Current_work_order> createState() => _Current_work_orderState();
}

class _Current_work_orderState extends State<Current_work_order> {
  current_work_order_controller current_work =
      Get.put(current_work_order_controller());
  @override
  void initState() {
    current_work.fetchWorkorder(context: context);
    super.initState();
  }

  String FailurName = "";
  late int length;
  List<Current_work_order>? list;

  @override
  Widget build(BuildContext context) {
    try {
      FailurName = current_work
          .current_work_order!.data![0].workOrderDetails![0].partNoDescription
          .toString();
    } catch (e) {
      FailurName = '';
    }
    try {
      length = current_work.current_work_order!.data!.length;
    } catch (e) {}
    return Scaffold(
      drawer: drawer(),
      appBar: AppBar(
        title: Text("Current work order progress"),
      ),
      body: ListView.builder(
        itemCount: current_work.current_work_order?.data!.length,
        itemBuilder: (context, index) {
          return ListTile(
          //   title: Text(current_work
          //       .current_work_order.data![index].totalLubricationCost
          //       .toString()),
          );
        },
      ),
    );
  }
}
