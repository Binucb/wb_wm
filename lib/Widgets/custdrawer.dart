import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:wm_workbench/Provider/provider.dart';
import 'package:wm_workbench/Screens/config_filescreen.dart';
import 'package:wm_workbench/Screens/workbench_screen.dart';
import 'package:wm_workbench/constants.dart';
import 'package:wm_workbench/main.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _loading = Provider.of<ProviderOne>(context, listen: false);
    var _ab = Provider.of<AppBarProvider>(context, listen: false);
    var theme = Provider.of<ThemeProvider>(context, listen: false);
    var db = Provider.of<DBProvider>(context, listen: false);
    return Drawer(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 25,
          ),
          Text(
            projectName,
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(
            thickness: 5,
          ),
          const SizedBox(
            height: 15,
          ),
          custDrawer(context, Icons.dashboard, () {
            Navigator.pop(context);
            _ab.chgWBScreen(false);
            db.changedl(true);

            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: const MyHomePage()));
          }, "Dashboard"),
          custDrawer(context, Icons.app_registration_outlined, () {
            String? actID = configDB.get("actID");
            db.chagenRwNum(actID!);
            String? pt = configDB.get("pt");
            _ab.chgWBScreen(true);
            _loading.setIdPt(actID, pt!);

            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: const WBScreen()));
          }, "Workbench"),
          custDrawer(context, Icons.settings, () {
            Navigator.pop(context);
            _ab.chgWBScreen(false);

            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: const ConfigScreen()));
          }, "Config Files"),
          custDrawer(context, Icons.highlight, () {}, "Add Highlight Words"),
          custDrawer(context, Icons.light_mode_outlined, () {
            //print("i am pressed while changing theeme");
            theme.changeTheme();
          }, "Change Dark/Light Theme"),
          custDrawer(context, Icons.power_settings_new, () {}, "Logout"),
          Expanded(
            child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(version),
                )),
          ),
        ],
      ),
    );
  }
}

Widget custDrawer(BuildContext context, IconData drIcon,
    VoidCallback runFunciton, String lable) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 6, 2, 8),
    child: Row(
      children: [
        Icon(
          drIcon,
          color: Colors.green,
        ),
        TextButton(
            onPressed: runFunciton,
            child: Text(
              lable,
              style: Theme.of(context).textTheme.headline6,
            ))
      ],
    ),
  );
}
