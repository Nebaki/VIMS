import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/componets/custome_text.dart';
import 'package:mob_app/constants/constants.dart';
import 'package:mob_app/screen/vehicle_intake/vehicle_intake_part.dart';
import 'package:mob_app/util/no_internet.dart';
import 'package:provider/provider.dart';
import '../../../componets/row_column_text.dart';
import '../../../controller/vehicle_controller.dart';
import '../../../provider/connectivity_provider.dart';
import '../../drawer/drawer.dart';

class VehicleListIntakePart extends StatefulWidget {
  const VehicleListIntakePart({super.key});

  @override
  State<VehicleListIntakePart> createState() => _VehicleListIntakePartState();
}

class _VehicleListIntakePartState extends State<VehicleListIntakePart>
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
                                      Get.to(() => VehicleIntakePart(),
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
