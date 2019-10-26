import 'package:flutter/material.dart';
import 'package:flutter_app_core/flutter_app_core.dart';
import 'package:gplanner/pages/home/home.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppCore(
      navigation: ParallelNavigation(
        initialRoute: '/home',
        routes: {
          '/home': (_) => HomePage(),
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
        ],
      ),
    );
  }
}
