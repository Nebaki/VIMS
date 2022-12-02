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
            : Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ListView.builder(
                    itemCount: vehicleview.vehicleList.length,
                    itemBuilder: ((context, index) {
                      return Card(
                        elevation: 8.0,
                        margin: new EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Color.fromRGBO(64, 75, 96, .9)),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            leading: Container(
                              padding: EdgeInsets.only(right: 12.0),
                              decoration: new BoxDecoration(
                                  border: new Border(
                                      right: new BorderSide(
                                          width: 1.0, color: Colors.white24))),
                              child:
                                  Icon(Icons.car_repair, color: Colors.white),
                            ),
                            title: Row(
                              children: [
                                Custome_text(text: "Model:"),
                                Text(
                                  vehicleview.vehicleList[index].model!,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            trailing: Icon(Icons.keyboard_arrow_right,
                                color: Colors.white, size: 30.0),
                            subtitle: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 5,
                                  child: Row(
                                    children: [
                                      Custome_text(text: "Plate number:"),
                                      Text(
                                          vehicleview
                                              .vehicleList[index].plateNumber!,
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: LinearProgressIndicator(
                                          backgroundColor: Color.fromRGBO(
                                              209, 224, 224, 0.2),
                                          value: 0.3,
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.green)),
                                    )),
                              ],
                            ),
                            onTap: () async {
                              print(vehicleview.vehicleList[index].id);
                              Get.to(() => current_work_order(),
                                  transition: Transition.native,
                                  fullscreenDialog: true,
                                  arguments: vehicleview.vehicleList[index].id);
                            },
                          ),
                        ),
                      );
                    })),
              )));
  }
}
