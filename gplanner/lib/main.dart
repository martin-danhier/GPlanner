import 'package:flutter/material.dart';
import 'package:flutter_app_core/flutter_app_core.dart';
import 'package:gplanner/pages/home/home.dart';
import 'package:gplanner/pages/todolist/todolist.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppCore(
      navigation: ParallelNavigation(
        initialRoute: '/todolist',
        routes: {
          '/home': (_) => HomePage(),
          '/todolist': (_) => ToDoListPage(),
        },
        defaultTheme: 'light',
        themes: {
          'light': ExtendedThemeData.light(),
        },
        drawerItems: [
          DrawerItem(
            route: '/home',
            name: "Home",
            icon: Icons.home,
          ),
          DrawerItem(
            route: '/todolist',
            name: "To-do lists",
            icon: Icons.check_box,
          ),
        ],
      ),
    );
  }
}
