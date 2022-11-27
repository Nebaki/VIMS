import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/componets/custome_text.dart';
import 'package:mob_app/controller/work_order_history/work_order_history.dart';
import 'package:mob_app/models/work_order/work_order_history.dart';
import 'package:mob_app/util/no_internet.dart';

import '../../componets/circular_tap.dart';
import '../../constants/constants.dart';
import '../../controller/connection_checker/connection_manager_controller.dart';
import '../drawer/drawer.dart';

class work_order_history_screen extends StatefulWidget {
  const work_order_history_screen({super.key});

  @override
  State<work_order_history_screen> createState() =>
      _work_order_history_screenState();
}

class _work_order_history_screenState extends State<work_order_history_screen>
    with TickerProviderStateMixin {
  WorkOrderHistoryController workorder_h =
      Get.put(WorkOrderHistoryController());

  ConnectionManagerController _controller =
      Get.put(ConnectionManagerController());
  void initState() {
    workorder_h.fetchWorkorderhistory(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String statusW = "";
    String oiltype = "";
    String total_lubrication_cost = '';
    String total_labour_cost = '';
    String total_parts_cost = '';
    String partNoDescription = "";
    String status = "";
    try {
      total_lubrication_cost =
          workorder_h.woh!.data[0].totalLubricationCost.toString();
    } catch (e) {
      total_lubrication_cost = '';
    }
    try {
      oiltype = workorder_h.woh!.data[0].lubrications![0].oilType.toString();
    } catch (e) {
      oiltype = '';
    }
    try {
      total_labour_cost = workorder_h.woh!.data[0].totalLabourCost.toString();
    } catch (e) {
      total_labour_cost = '';
    }
    try {
      total_parts_cost = workorder_h.woh!.data[0].totalPartsCost.toString();
    } catch (e) {
      total_parts_cost = '';
    }
    try {
      statusW = workorder_h.woh!.data[0].status.toString();
    } catch (e) {
      statusW = '';
    }

    try {
      partNoDescription = workorder_h.woh!.data[0].workOrderDetails![0].partNoDescription.toString();
    } catch (e) {
      partNoDescription = '';
    }
    try {
      status = workorder_h.woh!.data[0].workOrderDetails![0].status.toString();
    } catch (e) {
      status = '';
    }

    final columns = ['Work order', 'Status'];

    return Obx(() => _controller.connectionType.value == 1 ||
            _controller.connectionType.value == 2
        ? DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                bottom: TabBar(
                  labelPadding: const EdgeInsets.only(left: 20, right: 20),
                  // controller: _tabController,
                  labelColor: Colors.black,
                  isScrollable: true,
                  unselectedLabelColor: Colors.grey,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: CircleTabIndicator(color: kPrimaryColor, rad: 4),
                  tabs: [
                    Tab(
                      child: Custome_text(
                        text: "Work order",
                        textstyle: TextStyle(fontSize: 16),
                      ),
                    ),
                    Tab(
                      child: Custome_text(text: "Lubrications"),
                    ),
                    Tab(
                      child: Custome_text(text: "Total"),
                    )
                  ],
                ),
                title: Custome_text(
                  text: "work order history",
                ),
                centerTitle: true,
              ),
              drawer: drawer(),
              body: TabBarView(children: [
                DataTable(
                  border: TableBorder.symmetric(
                      inside: BorderSide(
                          width: 1,
                          color: kPrimaryColor,
                          style: BorderStyle.solid)),
                  columns: getColumns(columns),
                  rows: <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text(partNoDescription)),
                        DataCell(Text(status)),
                      ],
                    ),
                    
                  ],
                ),
                Center(
                    child: ListView(
                      children: [
                        ListTile(style:ListTileStyle.drawer ,
                          tileColor: kPrimaryColor,
                          
                          title: Text(oiltype,style: TextStyle(color: Colors.white),),
                        )
                      ],
                    )),

                //
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Center(
                      child: Column(children: [
                    Row(children: [
                      Text("Total_lubrication_cost",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Expanded(child: Container()),
                      Custome_text(
                        text: total_lubrication_cost,
                      )
                    ]),
                    Row(children: [
                      Text("Total_parts_cost",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Expanded(child: Container()),
                      Custome_text(
                        text: total_parts_cost,
                      )
                    ]),
                    Row(children: [
                      Text(
                        "Total_labour_cost",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(child: Container()),
                      Custome_text(
                        text: total_labour_cost,
                      )
                    ]),
                    Row(children: [
                      Text("Status",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Expanded(child: Container()),
                      Custome_text(
                        text: statusW,
                      )
                    ])
                  ])),
                ),
              ]),
            ),
          )
        : NoInternet());
  }

  List<DataColumn> getColumns(List<String> columns) =>
      columns.map((String column) => DataColumn(label: Text(column))).toList();
}
