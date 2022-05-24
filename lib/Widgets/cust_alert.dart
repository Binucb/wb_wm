import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wm_workbench/Provider/provider.dart';
import 'package:wm_workbench/Screens/choose_cat_ptg.dart';
import 'package:wm_workbench/main.dart';
import 'package:wm_workbench/models/wb_model.dart';

customalert(
    {BuildContext? context, String? title, String? content, Function? met2}) {
  return showDialog(
    context: context!,
    builder: (ctx) {
      return Container(
        height: 40,
        width: 120,
        constraints: const BoxConstraints(maxWidth: 95, maxHeight: 40),
        child: AlertDialog(
          title: Text(title!),
          content: Text(content!),
          actions: <Widget>[
            Container(
              height: 40,
              width: 120,
              constraints: const BoxConstraints(maxWidth: 95, maxHeight: 40),
              child: TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text("Cancel"),
              ),
            ),
            Container(
              height: 40,
              width: 120,
              constraints: const BoxConstraints(maxWidth: 95, maxHeight: 40),
              child: TextButton(
                onPressed: () async {
                  Navigator.of(ctx).pop();
                  await met2!(context);
                },
                child: const Text("Okay"),
              ),
            ),
          ],
        ),
      );
    },
  );
}

customUpload(
    {BuildContext? context, String? title, String? content, Function? met2}) {
  return showDialog(
    context: context!,
    builder: (ctx) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(60, 70, 60, 70),
        child: Dialog(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  title!,
                  style: const TextStyle(color: Colors.green, fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(content!),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ChoosePTG(),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text("Cancel"),
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.of(ctx).pop();
                      await met2!(context);
                    },
                    child: const Text("Choose  File to Upload"),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

customErrorAlert(BuildContext? context, List<String> err) {
  return showDialog(
      context: context!,
      builder: (ctx) {
        return Dialog(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      "Errors!!!",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: err.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(err[index]),
                            );
                          }),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text("Ok"))
                ],
              ),
            ),
          ),
        );
      });
}

customCat(BuildContext? context) {
  return showDialog(
      context: context!,
      builder: (ctx) {
        return Dialog(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      "Errors!!!",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  const SizedBox(
                    height: 300,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ChoosePTG(),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text("Ok"))
                ],
              ),
            ),
          ),
        );
      });
}

customalert1(
    {BuildContext? context,
    String? title,
    String? content,
    Function? met2,
    var dbProv}) {
  return showDialog(
    context: context!,
    builder: (ctx) {
      //var dbProv = Provider.of<DBProvider>(context, listen: false);
      int stCol = int.parse(configDB.get("stCol")!) + 1;

      return Container(
        height: 40,
        width: 120,
        constraints: const BoxConstraints(maxWidth: 95, maxHeight: 40),
        child: AlertDialog(
          title: Text(title!),
          content: Text(content!),
          actions: <Widget>[
            Container(
              height: 40,
              width: 120,
              constraints: const BoxConstraints(maxWidth: 95, maxHeight: 40),
              child: TextButton(
                onPressed: () async {
                  print(stCol);
                  await dbProv.saveToDB(stCol, "In Progress");
                  Navigator.of(ctx).pop();
                  // await met2!(context);
                },
                child: const Text("Cancel"),
              ),
            ),
            Container(
              height: 40,
              width: 120,
              constraints: const BoxConstraints(maxWidth: 95, maxHeight: 40),
              child: TextButton(
                onPressed: () async {
                  print(stCol);
                  await dbProv.saveToDB(stCol, "Completed");
                  Navigator.of(ctx).pop();
                  await met2!(context);
                },
                child: const Text("OK"),
              ),
            ),
          ],
        ),
      );
    },
  );
}

showSnackBar(BuildContext context, String msg) {
  final snackBar = SnackBar(content: Text(msg));

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

// Widget waitingalert({BuildContext? context, String? title}) {
//   var _loading = Provider.of<ProviderOne>(context!, listen: false);
//   return SizedBox(
//     height: 250,
//     width: 150,
//     child: Card(
//       child: Column(
//         children: <Widget>[
//           Text(
//             title!,
//             style: Theme.of(context).textTheme.headline6,
//           ),
//           (_loading.dataLoading!)
//               ? const CircularProgressIndicator()
//               : const Icon(Icons.check_circle_outline),
//           TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text("Okay"))
//         ],
//       ),
//     ),
//   );
// }

class LoadingIndicatorDialog {
  static final LoadingIndicatorDialog _singleton =
      LoadingIndicatorDialog._internal();
  late BuildContext _context;

  factory LoadingIndicatorDialog() {
    return _singleton;
  }

  LoadingIndicatorDialog._internal();

  show(BuildContext context, {String text = 'Loading...'}) {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _context = context;
          return WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
              backgroundColor: Colors.white,
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 16, top: 16, right: 16),
                        child: CircularProgressIndicator(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(text),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  dismiss() {
    Navigator.of(_context).pop();
  }
}

class HeaderWidget extends StatefulWidget {
  final Display? dItem;
  final String? txt;

  const HeaderWidget({Key? key, this.txt, this.dItem}) : super(key: key);

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  late TextEditingController _sdController;
  late TextEditingController _ldController;

  @override
  void dispose() {
    // TODO: implement dispose
    _sdController.dispose();
    _ldController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _sdController =
        TextEditingController(text: widget.dItem!.sd!.attrVal!.colValue);
    _ldController =
        TextEditingController(text: widget.dItem!.ld!.attrVal!.colValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var db = Provider.of<DBProvider>(context, listen: false);
    void _showMaterialDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Card(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        //header
                        Padding(
                          padding: const EdgeInsets.fromLTRB(6, 4, 0, 6),
                          child: Focus(
                            onFocusChange: (value) {
                              if (value == false) {
                                //print("Save : " + _controller.text);
                                //print("Save : " + attrCol.toString());
                                db.saveToDB(widget.dItem!.sd!.attrVal!.colNum!,
                                    _sdController.text);
                                widget.dItem!.sd!.attrVal!.colValue =
                                    _sdController.text;
                              }
                            },
                            child: TextFormField(
                              maxLines: 10,
                              //onChanged: (value) => db.saveToDB(attrCol!, value),
                              style: Theme.of(context).textTheme.bodyText2,
                              controller: _sdController,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(10, 25, 10, 10),
                                labelText: widget.dItem!.sd!.attrVal!.header,
                                labelStyle:
                                    Theme.of(context).textTheme.bodyText1,
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(6, 4, 0, 6),
                          child: Focus(
                            onFocusChange: (value) {
                              if (value == false) {
                                //print("Save : " + _controller.text);
                                //print("Save : " + attrCol.toString());
                                db.saveToDB(widget.dItem!.ld!.attrVal!.colNum!,
                                    _ldController.text);
                                widget.dItem!.ld!.attrVal!.colValue =
                                    _ldController.text;
                              }
                            },
                            child: TextFormField(
                              maxLines: 7,
                              //onChanged: (value) => db.saveToDB(attrCol!, value),
                              style: Theme.of(context).textTheme.bodyText2,
                              controller: _ldController,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(10, 25, 10, 10),
                                labelText: widget.dItem!.ld!.attrVal!.header,
                                labelStyle:
                                    Theme.of(context).textTheme.bodyText1,
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        ElevatedButton.icon(
                            onPressed: () async {
                              await db.saveToDB(
                                  widget.dItem!.sd!.attrVal!.colNum!,
                                  _sdController.text);
                              await db.saveToDB(
                                  widget.dItem!.ld!.attrVal!.colNum!,
                                  _ldController.text);
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.save),
                            label: const Text("Save"))
                      ],
                    )), //sizedBox ends
              ),
            );
          });
    }

    return GestureDetector(
      onTap: _showMaterialDialog,
      child: Card(
        elevation: 2,
        color: Colors.black38,
        shape: RoundedRectangleBorder(
          //side: const BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.txt!,
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
