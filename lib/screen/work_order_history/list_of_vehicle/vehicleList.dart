import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/Componets/custome_text.dart';
import 'package:mob_app/constants/constants.dart';
import 'package:mob_app/util/no_internet.dart';
import 'package:provider/provider.dart';
import '../../../Componets/row_column_text.dart';
import '../../../controller/vehicle_controller.dart';
import '../../../provider/connectivity_provider.dart';
import '../../drawer/drawer.dart';
import '../work_order_history.dart';

class VehicleList extends StatefulWidget {
  const VehicleList({super.key});

  @override
  State<VehicleList> createState() => _VehicleListState();
}

class _VehicleListState extends State<VehicleList>
    with TickerProviderStateMixin {
  VehicleController vehicleview = Get.put(VehicleController());

  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
        builder: (consumerContext, model, child) {
      if (model.isOnline != null) {
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
                                      Get.to(() => work_order_history_screen(),
                                          transition: Transition.native,
                                          fullscreenDialog: true,
                                          arguments: element.id.toString());
                                    },
                                    cells: <DataCell>[
                                      DataCell(RowText(
                                          text: element.model.toString())),
                                      DataCell(RowText(
                                          text:
                                              element.plateNumber.toString())),
                                      DataCell(RowText(
                                          text: element.color.toString())),
                                    ])))
                            .toList(),
                      ),
                    ),
                  )));
      } else {
        return NoInternet();
      }
    });
  }
}
