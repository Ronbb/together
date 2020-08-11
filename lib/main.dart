import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:syncfusion_flutter_core/core.dart';
import 'package:together/layout/home/add_todo_dialog.dart';
import 'package:together/page/home/home_page.dart';
import 'package:together/page/login/login_page.dart';
import 'package:together/wrapper/global_wrapper.dart';
import 'package:together/ignore/license.dart';
import 'package:together/injection_container/injection_container.dart';
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
      home: GlobalWrapper(root: (LoginPage())),
    );
  }
}
