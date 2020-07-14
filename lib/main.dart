import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:syncfusion_flutter_core/core.dart';
import 'package:together/global_wrapper/global_wrapper.dart';
import 'package:together/ignore/license.dart';
import 'package:together/injection_container/injection_container.dart';
import 'package:together/layout/layout.dart';
import 'package:together/theme/app_theme.dart';

Future<void> main() async {
  SyncfusionLicense.registerLicense(SYNCFUSION_LICENSE);
  await injectDependencies();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Together',
      darkTheme: GetIt.I<AppTheme>().dark,
      theme: GetIt.I<AppTheme>().light,
      home: GlobalWrapper(root: Layout()),
    );
  }
}
