import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:wm_workbench/Provider/provider.dart';
import 'package:wm_workbench/Screens/workbench_screen.dart';
import 'package:wm_workbench/main.dart';
import 'package:wm_workbench/models/item_display.dart';

class CustomTable extends StatelessWidget {
  final List<ItemDisplay>? lst;
  const CustomTable({this.lst, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (lst!.isNotEmpty)
        ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(label: Text("Item ID")),
                    DataColumn(label: Text("Product Type")),
                    DataColumn(label: Text("Status"))
                  ],
                  rows: _createRows(context, lst),
                ),
              ),
            ),
          )
        : const Center(
            child: Text("Kindly add  inflow files"),
          );
  }
}

List<DataRow> _createRows(BuildContext context, List<ItemDisplay>? lst) {
  print("Running from _creteRows method inside custom table");
  List<DataRow> rowlst = [];
  var _loading = Provider.of<ProviderOne>(context, listen: false);
  var ab = Provider.of<AppBarProvider>(context, listen: false);
  var db = Provider.of<DBProvider>(context, listen: false);

  for (var element in lst!) {
    if (element.itemID!.toLowerCase() != "item id") {
      rowlst.add(DataRow(cells: [
        DataCell(SelectableText(element.itemID!), onTap: () {
          db.chagenRwNum(element.itemID!);
          configDB.put("actID", element.itemID!);
          int? stCol = int.parse(configDB.get("stCol")!) + 1;
          print("Status:" + stCol.toString());
          db.saveToDB(stCol, "In Progress");
          _loading.setIdPt(element.itemID!, element.pt!);
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.bottomToTop,
                  child: const WBScreen()));
          ab.chgWBScreen(true);

          //print(element.rwNum);
        }),
        DataCell(SelectableText(element.pt!)),
        DataCell(SelectableText(
            (element.status!.isNotEmpty) ? element.status! : "Not Started")),
      ]));
    }
  }
  return rowlst;
}
