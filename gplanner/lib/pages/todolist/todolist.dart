import 'package:flutter/widgets.dart';
import 'package:flutter_app_core/core/app_core.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ToDoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Text("This is the To-do lists page."),
      ),
    );
  }
}