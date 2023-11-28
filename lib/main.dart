import 'package:flutter/material.dart';
//import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:wm_workbench/Provider/provider.dart';
import 'package:wm_workbench/Screens/login_screen.dart';
import 'package:wm_workbench/Widgets/cust_appbar.dart';
import 'package:wm_workbench/constants.dart';
import 'package:wm_workbench/models/item_display.dart';
import 'package:wm_workbench/models/maindb.dart';
import 'package:wm_workbench/models/pt.dart';
import 'package:wm_workbench/theme.dart';

import 'Screens/custom_table.dart';
import 'Widgets/custdrawer.dart';

//creating 3 hive Boxed
late Box<MainDB> mainDB;
late Box<String> configDB;
late Box<PtDB> ptDB;
late Box<String> clsDB;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setPathUrlStrategy();
  await Hive.initFlutter();
  Hive.registerAdapter(MainDBAdapter());
  Hive.registerAdapter(PtDBAdapter());

  mainDB = await Hive.openBox<MainDB>('mainDB');
  configDB = await Hive.openBox<String>('configDB');
  ptDB = await Hive.openBox<PtDB>('ptDB');
  clsDB = await Hive.openBox<String>('clsDB');

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ProviderOne()),
    ChangeNotifierProvider(create: (_) => DBProvider()),
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ChangeNotifierProvider(create: (_) => AppBarProvider()),
    ChangeNotifierProvider(create: (_) => PTProvider()),
    ChangeNotifierProvider(create: (_) => AttProvider()),
    ChangeNotifierProvider(create: (_) => BackEndData()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String lStatus = configDB.get("lStatus") ?? "";

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: projectName,
      theme: ProjectTheme.light(),
      home: (lStatus == "") ? const LoginScreen() : const MyHomePage(),
    );
  }
}
// TODO: Testing todos

class MyHomePage extends StatelessWidget {
  static const String route = '/homepage';
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var db = Provider.of<DBProvider>(context, listen: false);
    //var provider = Provider.of<ProviderOne>(context, listen: false);
    //provider.chgWBScreen(false);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawer: const DrawerCustom(),
        appBar: CustAppBar(),
        body: (db.dataLoading)
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    ValueListenableBuilder<Box<MainDB>>(
                        valueListenable: mainDB.listenable(),
                        builder: (context, box, widget) {
                          // print("============");
                          // print(configDB.get("stCol"));
                          // print(configDB.get("ptCol"));
                          // print(configDB.get("idCol"));

                          //db.changeFlMap(box.toMap());

                          //print("Inside valueListenable - ${box.toMap().length}");
                          //print(
                          //"Inside valueListenable - ${box.getAt(0)!.itemDetails![0]}");

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // ElevatedButton(
                              //     onPressed: () {},
                              //     child: Text("${box.toMap().length}")),
                              CustomTable(
                                flMap: box.toMap(),
                                lst: box.values.toList(),
                                idCol: int.parse(configDB.get("idCol")!),
                                ptCol: int.parse(configDB.get("ptCol")!),
                                stCol: int.parse(configDB.get("stCol")!),
                                ahtCol: int.parse(configDB.get("tmCol")!),
                              )
                            ],
                          );
                          // FutureBuilder(
                          //   future: db.getitmDisp(),
                          //   builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                          //     // Checking if future is resolved or not

                          //     // If we got an error
                          //     if (snapshot.hasError) {
                          //       return Center(
                          //         child: Text(
                          //           '${snapshot.error} occured',
                          //           style: const TextStyle(fontSize: 18),
                          //         ),
                          //       );

                          //       // if we got our data
                          //     } else if (snapshot.hasData) {
                          //       // Extracting data from snapshot object

                          //       return CustomTable(lst: snapshot.data);
                          //     }

                          //     // Displaying LoadingSpinner to indicate waiting state
                          //     return const Center(
                          //       child: CircularProgressIndicator(),
                          //     );
                          //   },
                          // );
                        })
                    // (mainDB.keys.isNotEmpty) ? const PieChart() : const SizedBox()
                  ],
                ),
              )
            : const Center(child: Text("Kindly upload the inflow file")),
      ),
    );
  }
}

String tst(List<ItemDisplay>? lst) {
  return lst![1].itemID!;
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final int y;
  final Color? color;
}

class PieChart extends StatelessWidget {
  const PieChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ab = Provider.of<AttProvider>(context, listen: false);
    List<ChartData> chartData = [
      ChartData("Completed", ab.cntStatus[0]),
      ChartData("In Progress", ab.cntStatus[1]),
      ChartData("Not Worked", ab.cntStatus[2]),
    ];
    return Expanded(
        child: SafeArea(
            child: Center(
      child: Container(
          child: SfCircularChart(
              title: ChartTitle(text: "Work Status:"),
              legend: Legend(
                  isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
              series: <CircularSeries>[
            // Render pie chart
            PieSeries<ChartData, String>(
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                dataSource: chartData,
                pointColorMapper: (ChartData data, _) => data.color,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y)
          ])),
    )));
  }
}
