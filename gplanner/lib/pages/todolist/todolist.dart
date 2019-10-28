import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_core/core/app_core.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ToDoListPage extends StatelessWidget {
  Widget customPercentageBar(double percentage, double width, double height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
      Text("50%"),
      Stack(
        children: <Widget>[
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.green[100]),
          ),
          Container(
            width: width * (percentage / 100),
            height: height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.green),
          ),
        ],
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text("Home"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              leading: Icon(Icons.check_box, color: Colors.green),
              title: Text(
                "Ma to-do list",
                style: TextStyle(fontSize: 25),
              ),
              trailing: customPercentageBar(50, 90, 15),
            ),
          ),
          Divider(),
          ExpansionTile(
            leading: Icon(Icons.list),
            title: Text("Étapes"),
            children: <Widget>[
              Text("1ère étape")
            ],
          ),
          //customPercentageBar(50, 300, 20),
        ],
      ),
    );
  }
}
