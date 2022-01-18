import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:wm_workbench/Provider/provider.dart';
import 'package:wm_workbench/Screens/workbench_screen.dart';
import 'package:wm_workbench/main.dart';
import 'package:wm_workbench/models/item_display.dart';
import 'package:wm_workbench/models/maindb.dart';

class CustomTable extends StatelessWidget {
  final Map<dynamic, MainDB>? flMap;
  final List<MainDB>? lst;
  final int? stCol;
  final int? idCol;
  final int? ptCol;
  const CustomTable(
      {this.flMap, this.lst, this.idCol, this.ptCol, this.stCol, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var db = Provider.of<DBProvider>(context, listen: false);
    db.changeFlMap(flMap!);

    return (lst!.isNotEmpty)
        ? Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: SizedBox(
              width: 700,
              child: Card(
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                        label: Text(
                      "Item ID",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text("Product Type",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text("Status",
                            style: TextStyle(fontWeight: FontWeight.bold)))
                  ],
                  rows: _createRows(context, lst!, idCol, ptCol, stCol),
                ),
              ),
            ),
          )
        : const Center(
            child: Text("Kindly add  inflow files"),
          );
  }
}

List<DataRow> _createRows(BuildContext context, List<MainDB>? lst, int? idCol,
    int? ptCol, int? stCol) {
  print("Running from _creteRows method inside custom table");
  List<DataRow> rowlst = [];
  var _loading = Provider.of<ProviderOne>(context, listen: false);
  var ab = Provider.of<AppBarProvider>(context, listen: false);
  var db = Provider.of<DBProvider>(context, listen: false);

  for (var element in lst!) {
    if (element.itemDetails![idCol!].toLowerCase() != "item id") {
      rowlst.add(DataRow(cells: [
        DataCell(SelectableText(element.itemDetails![idCol]), onTap: () {
          db.chagenRwNum(element.itemDetails![idCol]);
          configDB.put("actID", element.itemDetails![idCol]);
          // print("=============");
          // print(db.flMap!.length);
          // print(element.itemDetails![idCol]);
          db.pullItem(context, db.flMap!, element.itemDetails![idCol]);
          int? stCol = int.parse(configDB.get("stCol")!) + 1;
          print("Status:" + stCol.toString());
          db.saveToDB(stCol, "In Progress");
          _loading.setIdPt(
              element.itemDetails![idCol], element.itemDetails![ptCol!]);
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.bottomToTop,
                  child: const WBScreen()));
          ab.chgWBScreen(true);

          //print(element.rwNum);
        }),
        DataCell(SelectableText(element.itemDetails![ptCol!])),
        DataCell(SelectableText((element.itemDetails![stCol!].isNotEmpty)
            ? element.itemDetails![stCol]
            : "Not Started")),
      ]));
    }
  }
  return rowlst;
}
