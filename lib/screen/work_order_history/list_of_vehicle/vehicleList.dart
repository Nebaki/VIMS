// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mob_app/componets/custome_text.dart';
// import 'package:mob_app/constants/constants.dart';
// import '../../../controller/vehicle_controller.dart';
// import '../../drawer/drawer.dart';
// import '../work_order_history.dart';

// class VehicleList extends StatefulWidget {
//   const VehicleList({super.key});

//   @override
//   State<VehicleList> createState() => _VehicleListState();
// }

// class _VehicleListState extends State<VehicleList>
//     with TickerProviderStateMixin {
//   VehicleController vehicleview = Get.put(VehicleController());

//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Custome_text(text: "My vehicles"),
//           centerTitle: true,
//         ),
//         drawer: drawer(),
//         body: Obx(() => vehicleview.isLoading.value == true
//             ? Center(
//                 child: CircularProgressIndicator(
//                   color: kPrimaryColor,
//                 ),
//               )
//             : Padding(
//                 padding: const EdgeInsets.only(top: 20.0),
//                 child: ListView.builder(
//                     itemCount: vehicleview.vehicleList.length,
//                     itemBuilder: ((context, index) {
//                       return Card(
//                         elevation: 8.0,
//                         margin: new EdgeInsets.symmetric(
//                             horizontal: 10.0, vertical: 6.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(10)),
//                               color: Color.fromRGBO(64, 75, 96, .9)),
//                           child: ListTile(
//                             contentPadding: EdgeInsets.symmetric(
//                                 horizontal: 20.0, vertical: 10.0),
//                             leading: Container(
//                               padding: EdgeInsets.only(right: 12.0),
//                               decoration: new BoxDecoration(
//                                   border: new Border(
//                                       right: new BorderSide(
//                                           width: 1.0, color: Colors.white24))),
//                               child:
//                                   Icon(Icons.car_repair, color: Colors.white),
//                             ),
//                             title: Row(
//                               children: [
//                                 Custome_text(text: "Model:"),
//                                 Text(
//                                   vehicleview.vehicleList[index].model!,
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                             trailing: Icon(Icons.keyboard_arrow_right,
//                                 color: Colors.white, size: 30.0),
//                             subtitle: Row(
//                               children: <Widget>[
//                                 Expanded(
//                                   flex: 5,
//                                   child: Row(
//                                     children: [
//                                       Custome_text(text: "Plate number:"),
//                                       Text(
//                                           vehicleview
//                                               .vehicleList[index].plateNumber!,
//                                           style:
//                                               TextStyle(color: Colors.white)),
//                                     ],
//                                   ),
//                                 ),
//                                 Expanded(
//                                     flex: 1,
//                                     child: Container(
//                                       child: LinearProgressIndicator(
//                                           backgroundColor: Color.fromRGBO(
//                                               209, 224, 224, 0.2),
//                                           value: 0.3,
//                                           valueColor: AlwaysStoppedAnimation(
//                                               Colors.green)),
//                                     )),
//                               ],
//                             ),
//                             onTap: () async {
//                               print(vehicleview.vehicleList[index].id);
//                               Get.to(() => work_order_history_screen(),
//                                   transition: Transition.native,
//                                   fullscreenDialog: true,
//                                   arguments: vehicleview.vehicleList[index].id);
//                             },
//                           ),
//                         ),
//                       );
//                     })),
//               )));
//   }
// }

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/componets/custome_text.dart';
import 'package:mob_app/constants/constants.dart';
import 'package:mob_app/util/no_internet.dart';
import 'package:provider/provider.dart';
import '../../../componets/row_column_text.dart';
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
                              text: 'PlateNumber',
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
