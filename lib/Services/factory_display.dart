import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wm_workbench/Provider/provider.dart';
import 'package:wm_workbench/constants.dart';
import 'package:wm_workbench/models/pt.dart';
import 'package:wm_workbench/models/wb_model.dart';
import 'dart:convert' show utf8;

import '../main.dart';

void cnvLsttoDisp(
    BuildContext cntxt, List<String>? lstI, List<String>? lstrH, String? ky) {
  //print(lstI);
  List<String> headers = [];
  List<MyColumn> colist = [];
  Display? disp = Display();

  int i = 1;
  for (var element in lstrH!) {
    MyColumn col = MyColumn();
    col.colNum = i;
    col.header = element;
    col.clList = [];
    col.colValue = lstI![i - 1];

    col.dropDown = [];
    headers.add(element.toLowerCase().toString());
    colist.add(col);
    // print(colist.length);
    // print(element);
    i++;
  }
  //print("finished chaning it to lower case & added the columns");
  int idCol = headers.indexOf("item id");
  int ptCol = headers.indexOf("product type");
  int pnCol = headers.indexOf("product name");
  //print(ptCol);
  String pt = lstI![ptCol];

  PtDB? attrNeeded = ptDB.get(pt);
  //print(attrNeeded!.required);

  List<Attribute> req =
      retAttr(attrNeeded!.required, Requirement.required, colist, lstrH);
  List<Attribute> opt =
      retAttr(attrNeeded.optional, Requirement.optional, colist, lstrH);
  late List<Attribute> con;
  if (attrNeeded.conditional!.isNotEmpty) {
    con =
        retAttr(attrNeeded.conditional, Requirement.conditional, colist, lstrH);
  } else {
    con = [];
  }

  List<Attribute> cons = req + opt + con;

  disp.reqCount = req.length;
  disp.optCount = opt.length;
  disp.conCount = con.length;

  List<Attribute>? lst1 = [];
  List<Attribute>? lst2 = [];
  List<Attribute>? lst3 = [];

  for (Attribute attr in cons) {
    //print(attr.attrVal!.header);
    disp.rwNum = ky;
    disp.itemID = lstI[idCol];
    disp.pt = pt;
    disp.pn = lstI[pnCol];

    if (attr.attrVal!.header!.toLowerCase() == "product short description") {
      disp.sd = attr;
      //print(disp.sd!.attrVal!.colValue);
    } else if (attr.attrVal!.header!.toLowerCase() ==
        "product long description") {
      disp.ld = attr;
    } else if (attr.attrVal!.header!.toLowerCase().contains("main image url")) {
      List<ImageURL> lst = [];
      ImageURL imgurl = ImageURL();

      imgurl.label = "Main Image";
      imgurl.imageURL = attr.attrVal!.colValue;

      lst.add(imgurl);
      disp.lstImages = lst;
      lst3.add(attr);
    } else if (attr.attrVal!.header!
        .toLowerCase()
        .contains("secondary image url")) {
      int i = 1;

      List<ImageURL>? imgList = <ImageURL>[];

      for (var img in fetchURL(attr.attrVal!.colValue)) {
        //print(img);
        ImageURL? imgurl = ImageURL();
        imgurl.label = "Secondary Image - $i";
        imgurl.imageURL = img;

        imgList.add(imgurl);
        //print(imgList[i - 1].imageURL);

        i++;
      }

      disp.lstImages!.addAll(imgList);
      lst3.add(attr);
    } else if (attr.opCom!.colValue != "NA") {
      //print("opCom not null: ${attr.opCom!.colValue}");
      if (attr.opCom!.colValue.contains("Content Match")) {
        lst1.add(attr);
      }
      if (attr.opCom!.colValue.contains("Only Tool Predicted")) {
        lst2.add(attr);
      }

      if (attr.opCom!.colValue.contains("No Match") ||
          attr.opCom!.colValue.contains("Blank Match") ||
          attr.opCom!.colValue.contains("Outside SOP") ||
          attr.opCom!.colValue.contains("Not Able to Validate")) {
        lst3.add(attr);
      }
    } else if (attr.opCom!.colValue == "NA") {
      //print("else: ${attr.opCom!.colValue}");
      lst3.add(attr);
    }
  }

  disp.lstAttrs1 = lst1;
  disp.lstAttrs2 = lst2;
  disp.lstAttrs3 = lst3;

  var db = Provider.of<DBProvider>(cntxt, listen: false);
  db.changeDispItem(disp);
}

List<Attribute> retAttr(String? lst, Requirement? knd, List<MyColumn>? colist,
    List<String>? lstrH) {
  List<Attribute> retList = [];
  List<String> lstString = lst!.split("|");
  //print(lst);
  for (String att in lstString) {
    int col = lstrH!.indexOf(att);
    Attribute attr = Attribute();
    attr.req = knd;
    attr.attrVal = colist![col];

    attr.err = [];
    if (colist[col + 1].header!.toLowerCase().contains("op_")) {
      //print(col);
      attr.opVal = colist[col + 1];
      attr.decCol = colist[col + 2];
      attr.errCode = colist[col + 4];
      attr.comments = colist[col + 6];
      attr.opCom = colist[col + 7];
      attr.cfCol = colist[col + 8];
      //print("CFCol: ${attr.cfCol!.colNum}");
    } else {
      // print(col);
      attr.decCol = colist[col + 1];
      attr.errCode = colist[col + 2];
      attr.comments = colist[col + 3];
      attr.opVal = MyColumn(colValue: "NA");
      attr.opCom = MyColumn(colValue: "NA");
      attr.cfCol = MyColumn(colValue: "NA");
      //print("CFCOL:${attr.cfCol!.colNum}");
    }
    //print(retList.length);
    retList.add(attr);
  }

  return retList;
}

Requirement reqRet(String? req) {
  late Requirement rs;
  if (req == "req") {
    rs = Requirement.required;
  } else if (req == "opt") {
    rs = Requirement.optional;
  } else if (req == "con") {
    rs = Requirement.conditional;
  }
  return rs;
}
