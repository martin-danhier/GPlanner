import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_core/core/app_core.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ToDoListPage extends StatefulWidget {
  @override
  ToDoListPageState createState() => ToDoListPageState();
}

class ToDoListPageState extends State<ToDoListPage> {
  double percentage = 60;
  double prioritySliderValue = 0;
  final textFieldAddStepController = TextEditingController();

  // This data will be acquired from the database
  var steps = [];

  double getPercentage(data) {
    int nbSteps = data.length;
    int nbTrue = 0;
    for (int i = 0; i < nbSteps; i++) {
      if (data[i][1] == true) {
        nbTrue += 1;
      }
    }
    if (nbSteps > 0) {
      return nbTrue / nbSteps * 100;
    } else {
      return 0;
    }
  }

  List<Widget> buildListTiles(data) {
    var widgets = new List<Widget>();
    for (int i = 0; i < data.length; i++) {
      widgets.add(
        ListTile(
          title: Text(data[i][0]),
          leading: IconButton(
            icon: Icon(
              (data[i][1] == false)
                  ? Icons.check_box_outline_blank
                  : Icons.check_box,
              color: (data[i][1] == false)
                  ? Theme.of(context).disabledColor
                  : Colors.green,
            ),
            onPressed: () {
              setState(() {
                // Update db
                (steps[i][1] == true)
                    ? steps[i][1] = false
                    : steps[i][1] = true;
              });
            },
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.red,
            ),
            onPressed: () {
              setState(() {
                steps.removeAt(i);
              });
            },
          ),
        ),
      );
    }
    widgets.add(
      FlatButton(
        child: Text(
          "Ajouter une étape",
          style: TextStyle(color: Colors.blueAccent),
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Ajouter une étape"),
                  content: TextField(
                    decoration: InputDecoration(hintText: "Nom de l'étape"),
                    controller: textFieldAddStepController,
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Ajouter"),
                      onPressed: () {
                        setState(() {
                          if (textFieldAddStepController.text != "") {
                            data.add([textFieldAddStepController.text, false]);
                            textFieldAddStepController.text = "";
                          }
                          Navigator.pop(context);
                        });                     
                      },
                    ),
                  ],
                );
              });
        },
      ),
    );
    return widgets;
  }

  Widget customPercentageBar(double percentage, double width, double height) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("${percentage.round()}%"),
          Stack(
            children: <Widget>[
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.green[100]),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                width: width * (percentage / 100),
                height: height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: (getPercentage(steps) < 50)
                        ? Colors.red
                        : (getPercentage(steps) < 100)
                            ? Colors.yellow
                            : Colors.green),
              ),
            ],
          ),
          SizedBox(
            // This sized box is used to put the percentage bar at the same level than the todolist title
            height: 12,
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text("Home"),
      ),
      body: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              leading: IconButton(
                onPressed: () {
                  setState(() {
                    bool change;
                    (getPercentage(steps) == 100)
                        ? change = false
                        : change = true;
                    for (int i = 0; i < steps.length; i++) {
                      steps[i][1] = change;
                    }
                  });
                },
                icon: Icon(
                    (getPercentage(steps) == 100)
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color: (getPercentage(steps) == 100)
                        ? Colors.green
                        : Theme.of(context).disabledColor),
              ),
              title: Text(
                "Ma to-do list",
                style: TextStyle(fontSize: 20),
              ),
              trailing: customPercentageBar(getPercentage(steps), 90, 15),
            ),
          ),
          //Divider(),
          ExpansionTile(
            // onExpansionChanged: (_) {
            //   setState(() {
            //     if (_ == true) {
            //       percentage = 80;
            //     } else {
            //       percentage = 60;
            //     }
            //   });
            // },
            leading: Icon(Icons.list),
            title: Text("Étapes"),
            children: buildListTiles(steps),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text("Deadline"),
          ),
          ListTile(
            leading: Icon(Icons.priority_high),
            title: Text("Priorité"),
            trailing: SizedBox(
              width: 200,
              child: Slider(
                divisions: 2,
                value: prioritySliderValue,
                label: (prioritySliderValue == 0)
                    ? "Faible"
                    : (prioritySliderValue == 0.5) ? "Moyenne" : "Élevée",
                onChanged: (double value) {
                  setState(() {
                    prioritySliderValue = value;
                  });
                },
              ),
            ),
          ),
          // SizedBox(
          //   width: 300,
          //   child: Slider(
          //     divisions: 2,
          //     value: prioritySliderValue,
          //     label: (prioritySliderValue == 0)
          //         ? "Faible"
          //         : (prioritySliderValue == 0.5) ? "Moyenne" : "Élevée",
          //     onChanged: (double value) {
          //       setState(() {
          //         prioritySliderValue = value;
          //       });
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
