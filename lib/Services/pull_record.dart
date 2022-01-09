import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';
import 'package:wm_workbench/Provider/provider.dart';
import 'package:wm_workbench/Widgets/cust_alert.dart';

void uploadPT(BuildContext context) async {
  var _loading = Provider.of<PTProvider>(context, listen: false);

  showSnackBar(context, "Data loading in progress.Please wait...");
  var picked = await FilePicker.platform.pickFiles();
  //LoadingIndicatorDialog().show(context);
  //waitingalert(context: context, title: "Data Loading Status");

  if (picked != null) {
    //print(_loading.dataLoading);
    var bytes = picked.files.single.bytes;

    var excel = Excel.decodeBytes(bytes!);

    _loading.addtoPTBox(excel.tables["PT"]!.rows);

    showSnackBar(context, "Data loaded successfully");
  }
}
