import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wm_workbench/Provider/provider.dart';
import 'package:wm_workbench/Services/methods.dart';
import 'package:wm_workbench/Widgets/cust_appbar.dart';
import 'package:wm_workbench/Widgets/custdrawer.dart';
import 'package:wm_workbench/constants.dart';
import 'package:wm_workbench/theme.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context, listen: false);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: projectName,
      theme: (provider.appTheme!) ? ProjectTheme.dark() : ProjectTheme.light(),
      home: Scaffold(
        drawer: const DrawerCustom(),
        appBar: CustAppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                  onPressed: () {
                    uploadPT(context);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add config files")),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
