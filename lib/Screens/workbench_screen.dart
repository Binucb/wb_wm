import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wm_workbench/Provider/provider.dart';
import 'package:wm_workbench/Widgets/cust_appbar.dart';
import 'package:wm_workbench/Widgets/cust_workbench.dart';
import 'package:wm_workbench/Widgets/custdrawer.dart';
import 'package:wm_workbench/constants.dart';
import 'package:wm_workbench/main.dart';
import 'package:wm_workbench/models/wb_model.dart';
import 'package:wm_workbench/theme.dart';

class WBScreen extends StatelessWidget {
  const WBScreen({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var rwNum = Provider.of<DBProvider>(context, listen: false).rwNum;
    //var actID = configDB.get("actID");

    // print("actid " + actID!);
    //print(rwNum);
    var provider = Provider.of<ThemeProvider>(context, listen: false);
    var db = Provider.of<DBProvider>(context, listen: true);
    print(db.rwNum);
    //provider.chgWBScreen(true);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: projectName,
      theme: (provider.appTheme!) ? ProjectTheme.dark() : ProjectTheme.light(),
      home: Scaffold(
        drawer: const DrawerCustom(),
        appBar: CustAppBar(),
        body: Center(
          child: FutureBuilder(
            future: db.pullItem(db.rwNum),
            builder: (BuildContext context, AsyncSnapshot<Display> snapshot) {
              if (snapshot.hasData) {
                return Center(child: MyCustWBScreen(dItem: snapshot.data));
              }
              if (snapshot.hasError) {
                return Text(
                    "Error from WBScreen class: " + snapshot.error.toString());
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
