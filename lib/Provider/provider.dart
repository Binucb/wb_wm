import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wm_workbench/Services/factory_display.dart';
import 'package:wm_workbench/constants.dart';
import 'package:wm_workbench/main.dart';
import 'package:wm_workbench/models/item_display.dart';
import 'package:wm_workbench/models/maindb.dart';
import 'package:wm_workbench/models/pt.dart';
import 'package:wm_workbench/models/wb_model.dart';
import 'package:universal_html/html.dart' as html;
import 'package:http/http.dart' as http;

List<int> _cntStatus = [0, 0, 0];

class ThemeProvider extends ChangeNotifier {
  bool? _appTheme = false;
  bool? get appTheme => _appTheme;

  changeTheme() {
    _appTheme = !_appTheme!;
    //print(_appTheme);
    notifyListeners();
  }
}

class AppBarProvider extends ChangeNotifier {
  bool? _workbenchScreen = false;
  bool? get workbenchScreen => _workbenchScreen;
  chgWBScreen(bool val) {
    _workbenchScreen = val;
    notifyListeners();
  }
}

class ProviderOne extends ChangeNotifier {
  //bool? _dataLoading = true;

  String? _id = "234";
  String? _pt = "Test PT";
  List<String>? _imgList = [];
  List<String>? get imgList => _imgList;

  setImgList(List<String>? lst) {
    _imgList = lst;
    notifyListeners();
  }

  setImgatInd(int index, String url) {
    _imgList![index] = url;
    notifyListeners();
  }

  String? get id => _id;
  String? get pt => _pt;

  setIdPt(String id, String pt) {
    _id = id;
    _pt = pt;
    notifyListeners();
  }

  void fetchAlbum() async {
    print("api called");
    final response =
        await http.get(Uri.parse('http://10.127.116.51:5572/get_cat_lst'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}

class PTProvider extends ChangeNotifier {
  int? _ptCnt = 1;
  List<String> _attrWrds = [];

  getCsv(String cat, String ptg) async {
    final myData = await rootBundle.loadString("assets/csv/config_master.csv");
    List<List<dynamic>> rowsAsListOfValues =
        const CsvToListConverter().convert(myData);
    List<List<dynamic>> tstList = rowsAsListOfValues
        .where((element) => element[0] == cat && element[1] == ptg)
        .toList();
    //print(tstList);

    addtoPTBox(tstList);
  }

  getClsCsv(String cat, String ptg) async {
    print("I am called");
    final myData = await rootBundle.loadString("assets/csv/csv_cls.csv");
    List<List<dynamic>> rowsAsListOfValues =
        const CsvToListConverter().convert(myData);
    print("am I till this");
    List<List<dynamic>> tstList = rowsAsListOfValues
        .where((element) => element[0] == cat && element[1] == ptg)
        .toList();
    //print(tstList);

    addtoClsBox(tstList);
  }

  List<String> get attrWrds {
    List<String> _lst;

    if (configDB.get("atWrd") != null) {
      _lst = configDB.get("atWrd")!.split("|");
    } else {
      _lst = [];
    }
    return _lst;
  }

  void addToAttrWrds(str) {
    print(str);
    configDB.put("atWrd", str);

    notifyListeners();
  }

  int? get ptCnt {
    print(ptDB.toMap().length);
    if (ptDB.toMap().isEmpty) {
      return 0;
    } else {
      return ptDB.toMap().length;
    }
  }

  // Future<int?> ptCount() async {
  //   try {r
  //     _ptCnt = ptDB.toMap().length;
  //   } catch (e) {
  //     print(e);
  //     //_ptCnt = Future(() => ptDB.toMap().length);
  //   } finally {
  //     notifyListeners();
  //   }
  //   return _ptCnt;
  // }

  addtoPTBox(List<List<dynamic>> frmExcel) async {
    ptDB.clear();

    for (var element in frmExcel) {
      PtDB ls = PtDB();
      ls.required = element[3]! ?? "";
      ls.optional = element[4]! ?? "";
      if (element[5] == null) {
        ls.conditional = "";
      } else {
        ls.conditional = element[5]! ?? "";
      }

      await ptDB.put(element[2]!, ls);
    }
    //print("from PT method");
    //print(ptCnt);
    notifyListeners();
  }

  addtoClsBox(List<List<dynamic>> frmExcel) async {
    clsDB.clear();

    for (var element in frmExcel) {
      await clsDB.put(element[2], element[4]);
    }
  }
}

class AttProvider extends ChangeNotifier {
  //Attribute change

  // List<Attribute>? _showList2 = [];
  // List<Attribute>? get showList2 => _showList2;
  // changeList2(List<Attribute>? val, int val1) {
  //   _showList2 = [];
  //   _showList2 = List.from(val!.toList());
  //   _listNo = val1;
  //   notifyListeners();
  // }

  // List<Attribute>? _showList3 = [];
  // List<Attribute>? get showList3 => _showList3;
  // changeList3(List<Attribute>? val, int val1) {
  //   _showList3 = [];
  //   _showList3 = List.from(val!.toList());
  //   _listNo = val1;
  //   notifyListeners();
  // }

  List<int> get cntStatus => _cntStatus;

  incCount(int i) {
    notifyListeners();
  }
}

class DBProvider extends ChangeNotifier {
  List<ItemDisplay> _itmDisp = [];
  Display _item = Display();
  Display get item => _item;
  // var ky = configDB.get("actID");
  // pullItem(flMap!, ky);

  bool _dataLoading = false;
  bool get dataLoading {
    if (_dataLoading == false) {
      if (mainDB.keys.isNotEmpty) {
        _dataLoading = true;
      } else if (_dataLoading == true) {
        _dataLoading = true;
      }
    }
    return _dataLoading;
  }

  int _listNo = 0;
  int get listNo => _listNo;

  List<Attribute>? _showList1 = [];
  List<Attribute>? get showList1 {
    if (_listNo == 0) {
      return item.lstAttrs4!;
    } else if (_listNo == 1) {
      return item.lstAttrs4!
          .where((element) => element.classifier == MyMatch.content)
          .toList();
    } else if (_listNo == 2) {
      return item.lstAttrs4!
          .where((element) => element.classifier == MyMatch.partial)
          .toList();
    } else if (_listNo == 3) {
      return item.lstAttrs4!
          .where((element) => element.classifier == MyMatch.nomatch)
          .toList();
    } else if (_listNo == 4) {
      return item.lstAttrs4!
          .where((element) => element.err!.isNotEmpty)
          .toList();
    }
  }

  changeList1(int val1) {
    _listNo = val1;
    notifyListeners();
  }

  Map<dynamic, MainDB>? _flMap = Map();
  Map<dynamic, MainDB>? get flMap => _flMap;

  changeFlMap(Map<dynamic, MainDB> dbMap) {
    _flMap = dbMap;
    //notifyListeners();
  }

  String _rwNum = "";
  String get rwNum => _rwNum;

  changeDispItem(Display dItem) {
    _item = dItem;
    print("++++++++");
    print(" I am setting the display item");
    //changeDpItem() {}

    notifyListeners();
  }

  // changeDpItem(MyColumn col, String? val) {
  //   Display? itm = item;

  //   item.lstAttrs3![0].attrVal!.colValue = val!;

  //   notifyListeners();
  // }

  chagenRwNum(String rwNum) {
    _rwNum = rwNum;
    notifyListeners();
  }

  changedl(bool val) {
    _dataLoading = val;
    notifyListeners();
  }

//time
  void updateTime(String? tm) {
    var ahtCol = configDB.get("tmCol");

    var actID = configDB.get("actID");

    MainDB? lst = mainDB.get(actID);

    String? otm = lst!.itemDetails![int.parse(ahtCol!)];

    saveTimeinDB(int.parse(ahtCol) + 1, add2times(t1: tm, t2: otm));
  }

//saveTimeinDB
  saveTimeinDB(int colNum, String val) {
    MainDB mDB = MainDB();
    mDB.itemDetails = [];
    mDB.rwNm = 1;

    var actID = configDB.get("actID");

    MainDB? lst = mainDB.get(actID);
    mDB.itemDetails = lst!.itemDetails;
    print("AHT");
    print(colNum);
    mDB.itemDetails![colNum - 1] = val;

    //print(mDB.itemDetails![int.parse(stCol!) - 1]);

    mainDB.put(actID, mDB);
  }

//Save to DB
  saveToDB(int colNum, String val) {
    MainDB mDB = MainDB();
    print("Save DB is called");
    // print(colNum);
    // print(val);
    mDB.itemDetails = [];
    mDB.rwNm = 1;
    var stCol = configDB.get("stCol");
    var actID = configDB.get("actID");
    print("Status from saveto Db is $stCol");

    MainDB? lst = mainDB.get(actID);

    print(lst!.itemDetails![colNum - 1]);
    mDB.itemDetails = lst.itemDetails;
    mDB.itemDetails![colNum - 1] = val;

    //print(mDB.itemDetails![int.parse(stCol!) - 1]);

    mainDB.put(actID, mDB);

    notifyListeners();
  }

//pull item from db
  void pullItem(
      BuildContext context, Map<dynamic, MainDB> mainItem, String? ky) async {
    List<String>? lstAttr;
    List<String>? hdAttr;

    var db = Provider.of<DBProvider>(context, listen: false);

    try {
      //var db = DBProvider();
      // print("pullitem method is called");
      // print(mainDB.isOpen);
      // print(mainDB.keys.length);
      // print(ky);
      // print(ky);
      // print(mainDB.get(ky)!.itemDetails!.length);
      // print(mainDB.get("Item ID")!.itemDetails!.length);
      // mainDB.close();
      //mainDB = await Hive.openBox<MainDB>('mainDB');
      // print("+++++++++++++++");
      // print("Loading based on PT");
      MainDB? itemFrmDB = db.flMap![ky];
      MainDB? headFrmDB = db.flMap!["Item ID"];
      // print(itemFrmDB!.itemDetails);
      // print(headFrmDB!.itemDetails);
      lstAttr = itemFrmDB!.itemDetails;
      hdAttr = headFrmDB!.itemDetails;
      //print(lstAttr);
      //print(hdAttr);
      //return cnvLsttoDisp(lstAttr, hdAttr, ky);
    } catch (e) {
      print("I am calling cnvLsttoDisp - catch error section");

      print(e);
    }

    return cnvLsttoDisp(context, lstAttr, hdAttr, ky);

    //changeDispItem(item);
  }

  //Future<List<ItemDisplay>>? get itmDisp => getitmDisp();
//first method to load excel inflow file to main db
  Future<List<ItemDisplay>>? getitmDisp() async {
    List<ItemDisplay> retList = [];
    final stopwatch = Stopwatch()..start();

    try {
      Map<dynamic, MainDB> lstfromDB = mainDB.toMap();
      print('ln173 executed in ${stopwatch.elapsed}');

      if (lstfromDB.isNotEmpty) {
        MainDB? tstList = mainDB.get("Item ID");
        //MainDB tstList = lstfromDB.entries.elementAt(0).value;
        List<String> headers = [];
        print('ln179 executed in ${stopwatch.elapsed}');
        for (var element in tstList!.itemDetails!) {
          //print(element.toLowerCase().toString());
          if (element != null) {
            headers.add(element.toLowerCase().toString());
          }
        }
        int idCol = headers.indexOf("item id");
        if (idCol != null) {
          configDB.put("idCol", idCol.toString());
        }

        int ptCol = headers.indexOf("product type");

        int stCol = headers.indexOf("status");

        int i = 1;
        _cntStatus = [0, 0, 0];
        lstfromDB.forEach((key, value) {
          //print("status from getitmDisp");

          //print(_cntStatus);
          if (value.itemDetails![stCol] == "Completed") {
            _cntStatus[0] = _cntStatus[0] + 1;
          } else if (value.itemDetails![stCol] == "In Progress") {
            _cntStatus[1] = _cntStatus[1] + 1;
          } else if (value.itemDetails![stCol] == "") {
            _cntStatus[2] = _cntStatus[2] + 1;
          }

          retList.add(ItemDisplay(
            i.toString(),
            value.itemDetails![idCol],
            value.itemDetails![ptCol],
            value.itemDetails![stCol],
          ));
          i++;
        });
        var tst = AttProvider();
        tst.incCount(0);
        print('ln201 executed in ${stopwatch.elapsed}');

        return retList;
      } else {
        print(
            "I am called from getitmDisp when lstfromDB.is empty - Item main db empty");
        List<ItemDisplay> retList = [];

        return retList;
      }
    } catch (e) {
      //print("I am called from catch error");
      print(e);
    }

    return retList;

    // tstList.itemDetails!.forEach((element) {
    //   retList.add(ItemDisplay(element[idCol].toString(),
    //       element[ptCol].toString(), element[stCol].toString()));
    // });
  }

//adding items from excel to mainDB
  addtoBox(List<List<Data?>> frmExcel) async {
    print("I am called from line 255 - addtoBox method - provider file");
    String? itemID;
    //clear the existing db
    mainDB.clear();

    int i = 1;
    var hdrList = [];
    for (var ele in frmExcel[0]) {
      hdrList.add(ele!.value.toLowerCase().toString());
    }
    int idCol = hdrList.indexOf("item id");
    int ptCol = hdrList.indexOf("product type");
    int stCol = hdrList.indexOf("status");
    int tmCol = hdrList.indexOf("aht");
    //print(idCol);
    configDB.put("actID", frmExcel[1][idCol]!.value.toString());
    configDB.put("pt", frmExcel[1][ptCol]!.value.toString());
    configDB.put("stCol", stCol.toString());
    configDB.put("ptCol", ptCol.toString());
    configDB.put("idCol", idCol.toString());
    configDB.put("tmCol", tmCol.toString());
    for (var element in frmExcel) {
      MainDB ls = MainDB();
      ls.itemDetails = [];

      itemID = element[idCol]!.value.toString();
      for (var ele in element) {
        //print(itemID);
        if (ele == null) {
          ls.itemDetails!.add("");
          ls.rwNm = i;
        } else {
          ls.itemDetails!.add(ele.value.toString());
          ls.rwNm = i;
        }
      }
      if (ls.itemDetails!.last != "AHT") {
        ls.itemDetails!.last = "0:00:00";
      }

      await mainDB.put(itemID.toString(), ls);

      i++;
    }
    // changedl(true).then(html.window.location.reload());
    await changedl(true);
    html.window.location.reload();

    //notifyListeners();
    //print("I am run without any errors in provider- addtoBox");
    //notifyListeners();
  }
}

class BackEndData with ChangeNotifier {
  int _clkInd = 0;
  List<String> _lstWrds = [];
  //List<String> _attrWrds = [];

  int get clkInd => _clkInd;
  List<String> get lstWrds {
    List<String> _lst;

    if (configDB.get("hiWrd") != null) {
      _lst = configDB.get("hiWrd")!.split("|");
    } else {
      _lst = [];
    }
    return _lst;
  }

  void addToLstWrds(str) {
    List<String>? dbList;
    if (configDB.get("hiWrd") != null) {
      dbList = configDB.get("hiWrd")!.split("|");
    } else {
      dbList = [];
    }
    _lstWrds = dbList + str.split("\n");

    _lstWrds = _lstWrds.toSet().toList();
    configDB.put("hiWrd", _lstWrds.join("|"));

    notifyListeners();
  }

  void removeFrmLst(str) {
    List<String>? dbList;
    if (configDB.get("hiWrd") != null) {
      dbList = configDB.get("hiWrd")!.split("|");
    } else {
      dbList = [];
    }
    _lstWrds = dbList;
    _lstWrds.remove(str);
    configDB.put("hiWrd", _lstWrds.join("|"));

    notifyListeners();
  }

  void changeClk(str) {
    _clkInd = str;
    notifyListeners();
  }
}
