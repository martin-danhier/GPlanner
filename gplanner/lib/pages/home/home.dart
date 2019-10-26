import 'package:flutter/widgets.dart';
import 'package:flutter_app_core/core/app_core.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: PlatformButton(
          child: Text(AppCore.getThemeName(context)),
          onPressed: () => AppCore.switchPlatform(context),
        ),
      ),
    );
  }
}
