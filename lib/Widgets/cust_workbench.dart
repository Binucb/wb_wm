import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wm_workbench/Provider/provider.dart';
import 'package:wm_workbench/Services/methods.dart';
import 'package:wm_workbench/Widgets/cust_alert.dart';
import 'package:wm_workbench/Widgets/cust_image_list.widget.dart';
import 'package:wm_workbench/main.dart';
import 'package:wm_workbench/models/wb_model.dart';
import 'package:wm_workbench/theme.dart';

import '../Services/attribute_errors.dart';
import '../constants.dart';

class MyCustWBScreen extends StatelessWidget {
  //final Display? dItem;
  const MyCustWBScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var prov1 = Provider.of<ThemeProvider>(context, listen: false).appTheme;
    var prov = Provider.of<AttProvider>(context, listen: true);
    var dProv = Provider.of<DBProvider>(context, listen: true);
    Display? dItem = dProv.item;
    // print("++++++++++++++++++");
    // print(dItem);
    // print("MyCustWBScreen item is building");
    // print(dItem.ld!.attrVal!.colValue);
    // print(dItem.pn);

    //print(dItem.ld!.decCol!.colValue);
    //print(dItem.ld!.decCol!.colNum);

    double ht = MediaQuery.of(context).size.height;
    double wt = MediaQuery.of(context).size.width;
    return (dItem.itemID != "")
        ? Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              height: ht,
              width: wt,
              child: RawScrollbar(
                thumbColor: accentColor,
                radius: const Radius.circular(20),
                thickness: 5,
                child: SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          CustCard(
                              //pn
                              ht: ht * 0.08,
                              wt: wt * 0.665,
                              wd: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // SelectableText(
                                  //   "Product Name : ",
                                  //   style: Theme.of(context).textTheme.bodyText1,
                                  // ),
                                  EasyRichText(
                                    dItem.pn!,
                                    selectable: true,
                                    caseSensitive: false,
                                    patternList: [
                                      EasyRichTextPattern(
                                          matchWordBoundaries: false,
                                          targetString: context
                                              .watch<BackEndData>()
                                              .lstWrds,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              backgroundColor: Colors.blue)),
                                      EasyRichTextPattern(
                                          matchWordBoundaries: false,
                                          targetString: dupString(dItem.pn!),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              backgroundColor: Colors.red)),
                                      EasyRichTextPattern(
                                          matchWordBoundaries: false,
                                          targetString: context
                                              .watch<PTProvider>()
                                              .attrWrds,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              backgroundColor: Colors.green)),
                                    ],
                                  ),

                                  // SelectableText(
                                  //   dItem!.pn!,
                                  //   style: Theme.of(context).textTheme.bodyText2,
                                  // ),
                                ],
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  //sd
                                  Row(
                                    children: [
                                      CustCard(
                                        //sd
                                        ht: ht * 0.62,
                                        wt: wt * 0.33,

                                        wd: Column(
                                          children: [
                                            Row(
                                              children: [
                                                HeaderWidget(
                                                  txt: dItem
                                                      .sd!.attrVal!.header!,
                                                  dItem: dItem,
                                                ),
                                                Text(
                                                  "${dItem.sd!.attrVal!.colValue.split(" ").length} words",
                                                  style: const TextStyle(
                                                      color: Colors.redAccent,
                                                      fontSize: 10),
                                                ),
                                              ],
                                            ),

                                            const SizedBox(height: 0.6),
                                            SizedBox(
                                              height: 250,
                                              child: EasyRichText(
                                                ret(dItem
                                                    .sd!.attrVal!.colValue),
                                                selectable: true,
                                                caseSensitive: false,
                                                patternList: [
                                                  EasyRichTextPattern(
                                                      matchWordBoundaries:
                                                          false,
                                                      hasSpecialCharacters:
                                                          true,
                                                      targetString: dupString(
                                                          dItem.ld!.attrVal!
                                                                  .colValue +
                                                              " " +
                                                              dItem.sd!.attrVal!
                                                                  .colValue),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          backgroundColor:
                                                              Colors.red)),
                                                  EasyRichTextPattern(
                                                      matchWordBoundaries:
                                                          false,
                                                      targetString: context
                                                          .watch<BackEndData>()
                                                          .lstWrds,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          backgroundColor:
                                                              Colors.blue)),
                                                  EasyRichTextPattern(
                                                      matchWordBoundaries:
                                                          false,
                                                      targetString: context
                                                          .watch<PTProvider>()
                                                          .attrWrds,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          backgroundColor:
                                                              Colors.green)),
                                                ],
                                              ),
                                            ), // SelectableText(
                                            //     dItem!.sd!.attrVal!.colValue),
                                            Expanded(
                                                child: Align(
                                                    alignment: FractionalOffset
                                                        .bottomCenter,
                                                    child: CustBox(
                                                      attr: dItem.sd,
                                                      key: key,
                                                      headerString: dItem
                                                          .sd!.attrVal!.header!,
                                                      errCol: dItem
                                                          .sd!.decCol!.colNum,
                                                      erCodCol: dItem
                                                          .sd!.errCode!.colNum,
                                                      comCol: dItem
                                                          .sd!.comments!.colNum,
                                                      errVal: dItem
                                                          .sd!.decCol!.colValue,
                                                      erCodVal: dItem.sd!
                                                          .errCode!.colValue,
                                                      comVal: dItem.sd!
                                                          .comments!.colValue,
                                                    ))),
                                          ],
                                        ),
                                      ),
                                      CustCard(
                                        //ld
                                        ht: ht * 0.62,
                                        wt: wt * 0.33,
                                        wd: Column(
                                          children: [
                                            Row(
                                              children: [
                                                HeaderWidget(
                                                  txt: dItem
                                                      .ld!.attrVal!.header!,
                                                  dItem: dItem,
                                                ),
                                                Text(
                                                  "${dItem.ld!.attrVal!.colValue.split(" ").length} words",
                                                  style: const TextStyle(
                                                      color: Colors.redAccent,
                                                      fontSize: 10),
                                                ),
                                                const Text(
                                                  "|",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 10),
                                                ),
                                                Text(
                                                  "${"<li>".allMatches(dItem.ld!.attrVal!.colValue).length} Bullet points",
                                                  style: const TextStyle(
                                                      color: Colors.redAccent,
                                                      fontSize: 10),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 0.6),
                                            SizedBox(
                                              height: 250,
                                              child: EasyRichText(
                                                ret(dItem
                                                    .ld!.attrVal!.colValue),
                                                selectable: true,
                                                caseSensitive: false,
                                                patternList: [
                                                  EasyRichTextPattern(
                                                      matchWordBoundaries:
                                                          false,
                                                      targetString: dupString(
                                                          dItem.ld!.attrVal!
                                                                  .colValue +
                                                              " " +
                                                              dItem.sd!.attrVal!
                                                                  .colValue),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          backgroundColor:
                                                              Colors.red)),
                                                  EasyRichTextPattern(
                                                      matchWordBoundaries:
                                                          false,
                                                      targetString: context
                                                          .watch<BackEndData>()
                                                          .lstWrds,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          backgroundColor:
                                                              Colors.blue)),
                                                  EasyRichTextPattern(
                                                      matchWordBoundaries:
                                                          false,
                                                      targetString: context
                                                          .watch<PTProvider>()
                                                          .attrWrds,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          backgroundColor:
                                                              Colors.green)),
                                                ],
                                              ),
                                            ),

                                            // SelectableText(
                                            //     dItem!.ld!.attrVal!.colValue),
                                            Expanded(
                                                child: Align(
                                                    alignment: FractionalOffset
                                                        .bottomCenter,
                                                    child: CustBox(
                                                      attr: dItem.ld,
                                                      key: key,
                                                      headerString: dItem
                                                          .ld!.attrVal!.header!,
                                                      errCol: dItem
                                                          .ld!.decCol!.colNum,
                                                      erCodCol: dItem
                                                          .ld!.errCode!.colNum,
                                                      comCol: dItem
                                                          .ld!.comments!.colNum,
                                                      errVal: dItem
                                                          .ld!.decCol!.colValue,
                                                      erCodVal: dItem.ld!
                                                          .errCode!.colValue,
                                                      comVal: dItem.ld!
                                                          .comments!.colValue,
                                                    ))),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          CustCard(
                              //imgs
                              ht: ht * 0.3,
                              wt: wt * 0.665,
                              wd: LstImages(imgUrl: dItem.lstImages!))
                        ],
                      ),
                      //attribute columns
                      Column(
                        children: [
                          CustLst(
                              //attri
                              ht: ht * 0.71,
                              wt: wt * 0.31,
                              //col: (prov1!) ? Colors.black : Colors.grey.shade200,
                              wd: ListAttr(bckLst: dItem.lstAttrs1)),
                          CustCard(
                            //attri
                            ht: ht * 0.3,
                            wt: wt * 0.31,
                            wd: RowChips(
                              dItem: dItem,
                            ),
                          ),
                        ],
                      )
                    ],
                  ), //main 3 row
                ),
              ),
            ),
          )
        : const Text("Loading...");
  }
}

// class ListAttrWidget extends StatelessWidget {
//   const ListAttrWidget({
//     Key? key,
//     required this.dItem,
//   }) : super(key: key);

//   final Display? dItem;

//   @override
//   Widget build(BuildContext context) {
//     var prov = Provider.of<AttProvider>(context);

//     return ListAttr(
//         lst: (prov.showList!.isNotEmpty) ? prov.showList : dItem!.lstAttrs1);
//   }
// }

class CustLst extends StatelessWidget {
  final double? ht;
  final double? wt;
  final Widget? wd;
  const CustLst({this.ht, this.wt, this.wd, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(15.0) //                 <--- border radius here
            ),
      ),
      height: ht,
      width: wt,
      child: (wd == null)
          ? const Padding(
              padding: EdgeInsets.all(8),
              child: Text("sample"),
            )
          : Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
              child: wd,
            ),
    );
  }
}

class CustCard extends StatelessWidget {
  final double? ht;
  final double? wt;
  final Widget? wd;
  final Color? col;

  const CustCard({this.ht, this.wt, this.wd, this.col, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double pad;
    //var prov = Provider.of<ThemeProvider>(context,listen: false).appTheme;
    if (col == null) {
      pad = 8.0;
    } else {
      pad = 0;
    }

    return Card(
      //color: (col == null) ? Colors.white : col,
      // color: (col == null)
      //     ? (prov!)
      //         ? Colors.black54
      //         : Colors.white
      //     : col,
      elevation: 1,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(15.0) //                 <--- border radius here
              ),
        ),
        height: ht,
        width: wt,
        child: (wd == null)
            ? Padding(
                padding: EdgeInsets.all(pad),
                child: const Text("sample"),
              )
            : Padding(
                padding: EdgeInsets.all(pad),
                child: wd,
              ),
      ),
    );
  }
}

class LstImages extends StatelessWidget {
  final List<ImageURL>? imgUrl;
  const LstImages({Key? key, this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var db = Provider.of<DBProvider>(context, listen: true);
    return ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, index) {
          return const VerticalDivider();
        },
        scrollDirection: Axis.horizontal,
        itemCount: imgUrl!.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      imgUrl![index].label!,
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (ctx) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(imgUrl![index].imageURL),
                              ));
                    },
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.20,
                      child: Image.network(
                        imgUrl![index].imageURL,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

// Widget lstImages(List<ImageURL> imgUrl) {
//   return ListView.separated(
//       shrinkWrap: true,
//       separatorBuilder: (BuildContext context, index) {
//         return const VerticalDivider();
//       },
//       scrollDirection: Axis.horizontal,
//       itemCount: imgUrl.length,
//       itemBuilder: (BuildContext context, int index) {
//         return Card(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     imgUrl[index].label!,
//                     style: const TextStyle(fontSize: 12, color: Colors.black),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     showDialog(
//                         barrierDismissible: true,
//                         context: context,
//                         builder: (ctx) => Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Image.network(imgUrl[index].imageURL),
//                             ));
//                   },
//                   child: SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.20,
//                     child: Image.network(
//                       imgUrl[index].imageURL,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       });
// }

class CustBox extends StatefulWidget {
  final Attribute? attr;
  final String? headerString;
  final String? errVal;
  final int? errCol;
  final String? erCodVal;
  final int? erCodCol;
  final String? comVal;
  final int? comCol;

  const CustBox(
      {Key? key,
      required this.attr,
      required this.headerString,
      required this.errCol,
      required this.erCodCol,
      required this.comCol,
      required this.errVal,
      required this.erCodVal,
      required this.comVal})
      : super(key: key);

  @override
  State<CustBox> createState() => _CustBoxState();
}

class _CustBoxState extends State<CustBox> {
  List<String> erCodValues = [];
  void bringDD(String header, String dec) {
    if (dropDD.containsKey(header.toLowerCase())) {
      erCodValues = [];
      String fromMap = dropDD[header.toLowerCase()]!;
      List<String> lstFromMap = fromMap.split("|");

      if (dec == "Yes") {
        for (var tsStr in lstFromMap[0].split(",")) {
          //print(tsStr);
          erCodValues.add(tsStr);
        }
      } else if (dec == "No") {
        for (var tsStr in lstFromMap[1].split(",")) {
          erCodValues.add(tsStr);
        }
      }
    } else {
      erCodValues = [];
      String fromMap = dropDD["others"]!;
      List<String> lstFromMap = fromMap.split("|");

      if (dec == "Yes") {
        for (var tsStr in lstFromMap[0].split(",")) {
          erCodValues.add(tsStr);
        }
      } else if (dec == "No") {
        for (var tsStr in lstFromMap[1].split(",")) {
          erCodValues.add(tsStr);
        }
      }
    }
    //secDD = " ";
    //setState(() {});
  }

  String? dd1Val;
  String? dd2Val;
  String? commVal;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.errVal == "Yes") {
      bringDD(widget.headerString!, "Yes");
    } else if (widget.errVal == "No") {
      bringDD(widget.headerString!, "No");
    }

    super.initState();
  }

  //String? secDD = " ";
  @override
  Widget build(BuildContext context) {
    dd1Val = widget.errVal;
    dd2Val = widget.erCodVal;
    commVal = widget.comVal;
    TextEditingController _controller =
        TextEditingController(text: widget.comVal ?? " ");
    // print("Testing dropdown1: - " + widget.erCodVal!);
    // print("Testing dropdown2: - " + widget.errVal!);
    // print("Testing dropdown1 colnum: - " + widget.errCol!.toString());
    // print("Testing dropdown2 colnum: - " + widget.erCodCol!.toString());

    final List<String> _decValues = [
      "",
      "Yes",
      "No",
    ];

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            width: (MediaQuery.of(context).size.width * 0.3) / 4,
            child: Form(
              key: widget.key,
              child: DropdownButtonFormField(
                value: dd1Val ?? "",
                style: Theme.of(context).textTheme.bodyText2,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                  labelText: "Yes/No",
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                  border: const OutlineInputBorder(),
                ),
                items: _decValues
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: (String? value) async {
                  var db = Provider.of<DBProvider>(context, listen: false);
                  if (value == "Yes") {
                    //print(dd2Val);
                    if (dd2Val != "") {
                      dd2Val = "";
                      erCodValues = [];
                      //print("I am runing when changing Yes decision");

                      await db.saveToDB(widget.erCodCol!, "");
                      widget.attr!.errCode!.colValue = "";
                    }

                    bringDD(widget.headerString!, "Yes");

                    dd1Val = "Yes";
                  } else if (value == "No") {
                    if (dd2Val != "") {
                      //print("I am runing when changing No decision");
                      dd2Val = "";
                      erCodValues = [];

                      await db.saveToDB(widget.erCodCol!, "");
                      widget.attr!.errCode!.colValue = "";
                    }

                    bringDD(widget.headerString!, "No");
                    dd1Val = "No";
                  }
                  setState(() {});
                  //print("saving Col:" + widget.errCol!.toString());
                  db.saveToDB(widget.errCol!, value!);
                  widget.attr!.decCol!.colValue = value;
                },
                isExpanded: false,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            width: (MediaQuery.of(context).size.width * 0.3) / 3,
            child: DropdownButtonFormField(
              //second dropdown
              value: dd2Val ?? "",
              style: Theme.of(context).textTheme.bodyText2,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                labelText: "Error Code",
                labelStyle: Theme.of(context).textTheme.bodyText1,
                border: const OutlineInputBorder(),
              ),
              items: erCodValues.map((String? e) {
                return DropdownMenuItem(
                  child: Text(e!),
                  value: e,
                );
              }).toList(),

              // .map((e) => DropdownMenuItem(
              //       child: Text(
              //         e,
              //         //overflow: TextOverflow.fade,
              //       ),
              //       value: e,
              //     ))
              // .toList(),
              onChanged: (String? value) {
                setState(() {
                  dd2Val = value!;
                });
                var db = Provider.of<DBProvider>(context, listen: false);
                db.saveToDB(widget.erCodCol!, value!);
                widget.attr!.errCode!.colValue = value;
              },

              isExpanded: true,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: SizedBox(
              width: (MediaQuery.of(context).size.width * 0.3) / 3.2,
              child: Focus(
                onFocusChange: (value) {
                  if (value == false) {
                    var db = Provider.of<DBProvider>(context, listen: false);
                    db.saveToDB(widget.comCol!, _controller.text);
                    widget.attr!.comments!.colValue = _controller.text;
                  }
                },
                child: TextFormField(
                  // onEditingComplete:
                  //     db.saveToDB(widget.comCol!, _controller.text),
                  // onSaved: db.saveToDB(widget.comCol!, _controller.text),

                  //onChanged: (value) => db.saveToDB(widget.comCol!, value),
                  focusNode: FocusNode(canRequestFocus: true),
                  controller: _controller,
                  style: Theme.of(context).textTheme.bodyText2,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                    labelText: "Comments",
                    labelStyle: Theme.of(context).textTheme.bodyText1,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ListAttr extends StatelessWidget {
  final List<Attribute>? bckLst;
  const ListAttr({this.bckLst, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Attribute>? lst1;
    List<Attribute>? lst2;
    List<Attribute>? lst3;

    var db = Provider.of<AttProvider>(context);

    lst1 = List.from(db.showList1!.toList());

    lst2 = List.from(db.showList2!.toList());

    lst3 = List.from(db.showList3!.toList());

    return RawScrollbar(
      thumbColor: Colors.green,
      radius: const Radius.circular(20),
      thickness: 4,
      child: LstViewCard(
          lst: (db.listNo == 1)
              ? (lst1.isNotEmpty)
                  ? lst1
                  : bckLst
              : (db.listNo == 2)
                  ? lst2
                  : (db.listNo == 3)
                      ? lst3
                      : []),
    );
  }
}

class LstViewCard extends StatelessWidget {
  final List<Attribute>? lst;

  const LstViewCard({
    this.lst,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: lst!.length,
        itemBuilder: (BuildContext context, int index) {
          return CustAttrCard(
              attr: lst![index],
              attrHeader: lst![index].attrVal!.header,
              defText: lst![index].attrVal!.colValue,
              attrCol: lst![index].attrVal!.colNum,
              decCol: lst![index].decCol!.colNum,
              erCodCol: lst![index].errCode!.colNum,
              comCol: lst![index].comments!.colNum,
              comVal: lst![index].comments!.colValue,
              decVal: lst![index].decCol!.colValue,
              erCodVal: lst![index].errCode!.colValue,
              attrHeader1: lst![index].opVal!.header ?? "",
              defText1: (lst![index].opVal!.colValue != "NA")
                  ? lst![index].opVal!.colValue
                  : "",
              attrHeader2: lst![index].opCom!.header ?? "",
              defText2: (lst![index].opVal!.colValue != "NA")
                  ? lst![index].opCom!.colValue
                  : "",
              req: lst![index].req,
              cfLst: lst![index].cfCol!.colValue);
        });
  }
}

class CustAttrCard extends StatelessWidget {
  final Attribute? attr;
  final String? attrHeader;
  final String? defText;
  final int? attrCol;
  final int? decCol;
  final String? decVal;
  final int? erCodCol;
  final String? erCodVal;
  final int? comCol;
  final String? comVal;
  final String? cfLst;

  final String? attrHeader1;
  final String? defText1;
  final String? attrHeader2;
  final String? defText2;
  final Requirement? req;

  const CustAttrCard(
      {this.attrHeader,
      this.attr,
      this.defText,
      this.attrHeader1,
      this.defText1,
      this.attrHeader2,
      this.defText2,
      this.req,
      this.attrCol,
      this.decCol,
      this.erCodCol,
      this.comCol,
      this.decVal,
      this.erCodVal,
      this.comVal,
      this.cfLst,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool imageCard =
        (attrHeader!.toLowerCase().contains("image url") ? true : false);

    var db = Provider.of<DBProvider>(context, listen: false);
    TextEditingController _controller =
        TextEditingController(text: defText ?? " ");
    TextEditingController _controller1 =
        TextEditingController(text: defText1 ?? " ");
    TextEditingController _controller2 =
        TextEditingController(text: defText2 ?? " ");
    Color reqCol = (req == Requirement.required)
        ? Colors.green
        : (req == Requirement.optional)
            ? Colors.yellow
            : (req == Requirement.conditional)
                ? Colors.purple
                : Colors.purple;
    List<String>? txtLst = defText1!.split("|");
    List<String>? hgList = [];
    List<String>? lwList = [];
    int coli = 0;
    List<String>? cfVal = cfLst!.split("|");

    for (var wrd in cfVal) {
      if (wrd == "High") {
        hgList.add(txtLst[coli]);
        coli++;
      } else if (wrd == "Low") {
        lwList.add(txtLst[coli]);
        coli++;
      }
    }

    return Card(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              String txtWrd1 =
                  (_controller.text != "") ? _controller.text + "|" : "";
              String txtWrd2 =
                  (_controller1.text.isNotEmpty) ? _controller1.text : "";

              var atCol = Provider.of<PTProvider>(context, listen: false);
              atCol.addToAttrWrds(txtWrd1 + txtWrd2);
            },
            child: Card(
              color: reqCol,
              child: SizedBox(
                height: 4,
                width: MediaQuery.of(context).size.width * 0.3,
              ),
            ),
          ),
          (imageCard)
              ? ElevatedButton(
                  onPressed: () {
                    var prov = Provider.of<ProviderOne>(context, listen: false);
                    prov.setImgList(_controller.text.split(","));
                    showDialog(
                        context: context,
                        builder: (context) {
                          return CustImageList(
                            colNum: attr!.attrVal!.colNum,
                          );
                        });
                    print(_controller.text);
                  },
                  child: const Text("Expand"))
              : const SizedBox(),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                //header
                Padding(
                  padding: const EdgeInsets.fromLTRB(6, 4, 0, 6),
                  child: SizedBox(
                    width: (MediaQuery.of(context).size.width * 0.3),
                    child: Focus(
                      onFocusChange: (value) {
                        if (value == false) {
                          //print("Save : " + _controller.text);
                          //print("Save : " + attrCol.toString());
                          db.saveToDB(attrCol!, _controller.text);
                          attr!.attrVal!.colValue = _controller.text;
                        }
                      },
                      child: TextFormField(
                        //onChanged: (value) => db.saveToDB(attrCol!, value),
                        style: Theme.of(context).textTheme.bodyText2,
                        controller: _controller,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(10, 25, 10, 10),
                          labelText: attrHeader,
                          labelStyle: Theme.of(context).textTheme.bodyText1,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                CustBox(
                  attr: attr,
                  key: key,
                  headerString: attrHeader,
                  errCol: decCol,
                  erCodCol: erCodCol,
                  comCol: comCol,
                  errVal: decVal,
                  erCodVal: erCodVal,
                  comVal: comVal,
                ),
                // const SizedBox(height: 10),
                // (attrHeader1 != "")
                //     ? Padding(
                //         padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
                //         child: SizedBox(
                //           width: (MediaQuery.of(context).size.width * 0.3),
                //           child: TextFormField(
                //             style: Theme.of(context).textTheme.bodyText2,
                //             controller: _controller1,
                //             decoration: InputDecoration(
                //               isDense: true,
                //               contentPadding:
                //                   const EdgeInsets.fromLTRB(10, 15, 10, 10),
                //               labelText: attrHeader1,
                //               labelStyle: Theme.of(context).textTheme.bodyText1,
                //               border: const OutlineInputBorder(),
                //             ),
                //           ),
                //         ),
                //       )
                //     : const SizedBox(),
                const SizedBox(height: 10),
                (attrHeader1 != "")
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
                        child: Container(
                          child: InputDecorator(
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 12, 10, 8),
                              labelText: attrHeader1,
                              labelStyle: Theme.of(context).textTheme.bodyText1,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            child: SizedBox(
                              width: (MediaQuery.of(context).size.width * 0.3),
                              child: EasyRichText(
                                defText1!,
                                selectable: true,
                                caseSensitive: false,
                                patternList: [
                                  EasyRichTextPattern(
                                      matchWordBoundaries: false,
                                      targetString: hgList,
                                      // context
                                      //     .watch<BackEndData>()
                                      //     .lstWrds,
                                      style:
                                          const TextStyle(color: Colors.green)),
                                  // backgroundColor: Colors.blue)),
                                  EasyRichTextPattern(
                                      matchWordBoundaries: false,
                                      targetString: lwList,
                                      // context
                                      //     .watch<PTProvider>()
                                      //     .attrWrds,
                                      style:
                                          const TextStyle(color: Colors.red)),
                                  //backgroundColor: Colors.green)),
                                ],
                              ),
                            ),
                          ),
                        ))
                    : const SizedBox(),
                const SizedBox(height: 10),
                (attrHeader2 != "")
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                        child: SizedBox(
                          width: (MediaQuery.of(context).size.width * 0.3),
                          child: TextFormField(
                            style: Theme.of(context).textTheme.bodyText2,
                            controller: _controller2,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 15, 10, 10),
                              labelText: attrHeader2,
                              labelStyle: Theme.of(context).textTheme.bodyText1,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(height: 15)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RowChips extends StatefulWidget {
  final Display? dItem;
  const RowChips({this.dItem, Key? key}) : super(key: key);

  @override
  State<RowChips> createState() => _RowChipsState();
}

class _RowChipsState extends State<RowChips> {
  var stopwatch = Stopwatch()..start();

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<AttProvider>(context, listen: true);

    int colNo = prov.listNo;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  prov.changeList1(widget.dItem!.lstAttrs1, 1);
                },
                child: Chip(
                  backgroundColor: (colNo != 1) ? Colors.black54 : accentColor,
                  label: const Text(
                    "Content Match",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  prov.changeList2(widget.dItem!.lstAttrs2, 2);
                  //print("I am called");
                },
                child: Chip(
                  backgroundColor: (colNo != 2) ? Colors.black54 : accentColor,
                  label: const Text(
                    "Partial Match",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  prov.changeList3(widget.dItem!.lstAttrs3, 3);
                },
                child: Chip(
                  backgroundColor: (colNo != 3) ? Colors.black54 : accentColor,
                  label: const Text(
                    "No Match",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
              onPressed: () async {
                List<String> fnErr = findErrors(widget.dItem!);
                if (fnErr.isEmpty) {
                  var dbProv = Provider.of<DBProvider>(context, listen: false);
                  int stCol = int.parse(configDB.get("stCol")!) + 1;
                  dbProv.saveToDB(stCol, "Completed");
                  dbProv.updateTime(format(stopwatch.elapsed));

                  await dbProv.changedl(true);
                  print(stopwatch.elapsed);
                  customalert1(
                      dbProv: dbProv,
                      context: context,
                      title: "Save Item",
                      content:
                          "Would you like to Save the changes to this item?",
                      met2: reload);
                } else {
                  customErrorAlert(context, fnErr);
                }

                // Navigator.push(
                //     context,
                //     PageTransition(
                //         type: PageTransitionType.bottomToTop,
                //         child: const MyHomePage()));
              },
              icon: const Icon(Icons.save),
              label: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Save Record", style: TextStyle(fontSize: 18)),
              )),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Req Attr: ${widget.dItem!.reqCount.toString()}|"),
              Text("Opt Attr: ${widget.dItem!.optCount.toString()}|"),
              Text("Cond Attr: ${widget.dItem!.conCount.toString()}"),
            ],
          )
        ],
      ),
    );
  }
}
