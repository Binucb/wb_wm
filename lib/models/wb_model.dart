
class Display {
  String? rwNum;
  String? itemID;
  String? pt;
  String? pn;
  Attribute? sd;
  Attribute? ld;
  List<ImageURL>? lstImages;
  int? reqCount = 0;
  int? optCount = 0;
  int? conCount = 0;

  List<Attribute>? lstAttrs1 = [];
  List<Attribute>? lstAttrs2 = [];
  List<Attribute>? lstAttrs3 = [];
  List<Attribute>? lstAttrs4 = [];
  Display(
      {this.rwNum,
      this.itemID,
      this.pt,
      this.sd,
      this.ld,
      this.reqCount,
      this.optCount,
      this.conCount,
      this.lstImages,
      this.lstAttrs1,
      this.lstAttrs2,
      this.lstAttrs3,
      this.lstAttrs4});
}

class ImageURL {
  String? label;
  String imageURL;
  ImageURL({this.label, this.imageURL = ""});
}

class Attribute {
  MyColumn? attrVal;
  MyColumn? decCol;
  MyColumn? errCode;
  MyColumn? comments;
  MyColumn? opVal;
  MyColumn? opCom;
  MyColumn? cfCol;
  MyMatch? classifier;
  Requirement? req;
  List<String>? err;

  Attribute(
      {this.attrVal,
      this.decCol,
      this.errCode,
      this.comments,
      this.opVal,
      this.opCom,
      this.req,
      this.cfCol,
      this.err});
}

class MyColumn {
  int? colNum;
  String? header;
  String colValue;
  List<String>? dropDown;
  List<String>? clList;

  MyColumn(
      {this.colNum,
      this.header,
      this.colValue = "",
      this.dropDown,
      this.clList});
}

set colValue(String? val) {
  colValue = val;
}

set dropDown(List<String>? val) {
  dropDown = val;
}

enum Requirement { required, optional, conditional }
enum MyMatch {content, partial, nomatch}
