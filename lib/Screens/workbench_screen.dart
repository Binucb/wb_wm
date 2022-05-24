import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wm_workbench/Provider/provider.dart';
import 'package:wm_workbench/Widgets/cust_appbar.dart';
import 'package:wm_workbench/Widgets/cust_workbench.dart';
import 'package:wm_workbench/Widgets/custdrawer.dart';
import 'package:wm_workbench/constants.dart';
import 'package:wm_workbench/main.dart';
import 'package:wm_workbench/models/maindb.dart';
import 'package:wm_workbench/models/wb_model.dart';
import 'package:wm_workbench/theme.dart';

class WBScreen extends StatefulWidget {
  const WBScreen({key}) : super(key: key);

  @override
  State<WBScreen> createState() => _WBScreenState();
}

class _WBScreenState extends State<WBScreen> {
  @override
  Widget build(BuildContext context) {
    String ky = configDB.get("actID")!;
    //var provider = Provider.of<ThemeProvider>(context, listen: false);
    var db = Provider.of<DBProvider>(context, listen: false);

    //var rwNum = Provider.of<DBProvider>(context, listen: false).rwNum;
    //var actID = configDB.get("actID");

    // print("actid " + actID!);
    //print(rwNum);

    //print(db.rwNum);
    //provider.chgWBScreen(true);
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: projectName,
      theme: ProjectTheme.light(),
      home: WillPopScope(
        onWillPop: () async => true,
        child: Scaffold(
            drawer: const DrawerCustom(),
            appBar: CustAppBar(),
            body: (db.item.itemID != "")
                ? const MyCustWBScreen()
                : const Center(child: Text("Loading.."))),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}


// FutureBuilder(
//             future: db.pullItem(db.rwNum),
//             builder: (BuildContext context, AsyncSnapshot<Display> snapshot) {
//               if (snapshot.hasData) {
//                 return Center(child: MyCustWBScreen(dItem: snapshot.data));
//               }
//               if (snapshot.hasError) {
//                 return Text(
//                     "Error from WBScreen class: " + snapshot.error.toString());
//               }
//               return const CircularProgressIndicator();
//             },
//           )
