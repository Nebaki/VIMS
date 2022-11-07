import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mob_app/util/constants.dart';

class drawer extends StatelessWidget {
  const drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 38),
              child: SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:18.0,left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 25,
                            backgroundColor:kPrimaryColor,
                            // backgroundImage: AssetImage(''),
                          ),
                          InkWell(
                            onTap: () {},
                            child: const Text(
                              "Sign in",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          const Text(
                            "Nebyu hussein",
                            style: TextStyle(color: Color.fromARGB(145, 0, 0, 0)),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right:8.0,top: 30),
                      child:  TextButton(onPressed: (){}, child: const Text("Edit",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 6, 33, 56)),))
                    )
                  ],
                ),
              ),
            ),
          ),
          const Divider(
            color: Color.fromARGB(43, 0, 0, 0),
            height: 3,
            thickness: 3,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 13),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.home_filled,color: kPrimaryColor,),
                  title: const Text("Home"),
                  onTap: (){}
                ),
                ListTile(
                  leading: const Icon(Icons.notifications_rounded,color: kPrimaryColor,),
                  title: const Text("Notification"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.settings,color: kPrimaryColor,),
                  title: const Text("Settings"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.send,color: kPrimaryColor,),
                  title: const Text("Contact us"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.share,color: kPrimaryColor,),
                  title: const Text("share"),
                  onTap: (){},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
