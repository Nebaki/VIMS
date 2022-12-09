// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/componets/custome_text.dart';
import 'package:mob_app/constants/constants.dart';
import '../../../controller/vehicle_controller.dart';
import '../../drawer/drawer.dart';
import '../current_work_order.dart.dart';

class VehicleListOCurrentWorkOrder extends StatefulWidget {
  const VehicleListOCurrentWorkOrder({super.key});

  @override
  State<VehicleListOCurrentWorkOrder> createState() => _VehicleListState();
}

class _VehicleListState extends State<VehicleListOCurrentWorkOrder>
    with TickerProviderStateMixin {
  VehicleController vehicleview = Get.put(VehicleController());

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Custome_text(text: "My vehicles"),
          centerTitle: true,
        ),
        drawer: drawer(),
        body: Obx(() => vehicleview.isLoading.value == true
            ? Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: DataTable(
                    showCheckboxColumn: false,
                    sortColumnIndex: 1,
                    sortAscending: true,
                    columns: [
                      DataColumn(
                        label: ColumnText(
                          text: 'Model',
                        ),
                      ),
                      DataColumn(
                        label: ColumnText(
                          text: 'Plate Number',
                        ),
                      ),
                      DataColumn(
                        label: ColumnText(
                          text: 'Color',
                        ),
                      ),
                    ],
                    rows: vehicleview.vehicleList
                        .map(((element) => DataRow(
                                onSelectChanged: (bool? selected) {
                                  print(element.id.toString());
                                  Get.to(() => current_work_order(),
                                      transition: Transition.native,
                                      fullscreenDialog: true,
                                      arguments: element.id.toString());
                                },
                                cells: <DataCell>[
                                  DataCell(
                                      RowText(text: element.model.toString())),
                                  DataCell(RowText(
                                      text: element.plateNumber.toString())),
                                  DataCell(
                                      RowText(text: element.color.toString())),
                                ])))
                        .toList(),
                  ),
                ),
              )));
  }
}

class RowText extends StatelessWidget {
  RowText({required this.text, this.textstyle});
  String text;
  final TextStyle? textstyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(text,
            style: TextStyle(color: KbalckColor, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class ColumnText extends StatelessWidget {
  ColumnText({required this.text, this.textstyle});
  String text;
  final TextStyle? textstyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(text,
            style: TextStyle(
                color: KlighyBlackColor, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
