//import 'dart:ffi';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:wm_workbench/Provider/provider.dart';
import 'package:wm_workbench/Widgets/cust_alert.dart';
import 'package:universal_html/html.dart' as html;
import 'package:wm_workbench/constants.dart';
import 'package:wm_workbench/main.dart';
import 'package:wm_workbench/models/maindb.dart';

import 'isolate_functions.dart';

void download(BuildContext context) async {
  var excel = Excel.createExcel();
  Sheet sheetObject = excel['Sheet1'];
  int i = 1;
  //List<String> dataList = [];
  MainDB? headers = mainDB.get("Item ID");
  headers!.itemDetails!.add("Emp ID");
  sheetObject.insertRowIterables(headers.itemDetails as List<String>, 0);

  int idCol = int.parse(configDB.get("idCol")!);
  int stCol = int.parse(configDB.get("stCol")!);

  mainDB.values.toList().forEach((ele) {
    if (ele.itemDetails![idCol] != "Item ID" &&
        ele.itemDetails![stCol] == "Completed") {
      ele.itemDetails!.add(configDB.get("lStatus")!);
      sheetObject.insertRowIterables(ele.itemDetails as List<String>, i);
      i++;
    }
  });
  excel.save(fileName: "output.xlsx");
}

void reload(BuildContext context) async {
  html.window.location.reload();
  Navigator.pop(context);
}

void upload(BuildContext context) async {
  var picked = await FilePicker.platform.pickFiles();

  showSnackBar(context, "Data loading in progress.Please wait...");
  //LoadingIndicatorDialog().show(context);
  //waitingalert(context: context, title: "Data Loading Status");

  if (picked != null) {
    //print(_loading.dataLoading);
    var bytes = picked.files.single.bytes;

    Excel excel = await compute(parseExcelFile, bytes!);

    //var excel = Excel.decodeBytes(bytes!);

    excel.tables["Sheet1"]!
        .cell(CellIndex.indexByColumnRow(
            rowIndex: 0, columnIndex: excel.tables["Sheet1"]!.maxCols))
        .value = "Status";
    excel.tables["Sheet1"]!
        .cell(CellIndex.indexByColumnRow(
            rowIndex: 0, columnIndex: excel.tables["Sheet1"]!.maxCols))
        .value = "AHT";
    var _loading = Provider.of<DBProvider>(context, listen: false);
    await _loading.addtoBox(excel.tables["Sheet1"]!.rows);

    //List<List<Data?>> lst = excel.tables["Sheet1"]!.rows;

    showSnackBar(context, "Data loaded successfully");

    //LoadingIndicatorDialog().dismiss();
    //_loading.changeDataLoading(true);
    //print(_loading.dataLoading);

    //var itemBox = await Hive.openBox<List>(items);
    //itemBox.deleteAll(itemBox.keys);

    //Provider.of<HomeProvider>(context, listen: false).setexFile(
    //excel.tables["Production & QC Report"]!.rows,
    //);
  }
}

void uploadPT(BuildContext context) async {
  var _loading = Provider.of<PTProvider>(context, listen: false);
  //var _db = Provider.of<DBProvider>(context, listen: false);

  var picked = await FilePicker.platform.pickFiles();
  showSnackBar(context, "Data loading in progress.Please wait...");

  //LoadingIndicatorDialog().show(context);
  //waitingalert(context: context, title: "Data Loading Status");

  if (picked != null) {
    //print(_loading.dataLoading);
    var bytes = picked.files.single.bytes;

    //var excel = Excel.decodeBytes(bytes!);
    Excel excel = await compute(parseExcelFile, bytes!);

    await _loading.addtoPTBox(excel.tables["PT"]!.rows);
    showSnackBar(context, "Data loaded successfully");
    //_loading.ptCount();
    //_db.changedl(true);
  }
}
