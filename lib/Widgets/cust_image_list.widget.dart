import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wm_workbench/Provider/provider.dart';
import 'package:wm_workbench/models/wb_model.dart';
import 'package:wm_workbench/theme.dart';

class CustImageList extends StatefulWidget {
  final int? colNum;
  const CustImageList({Key? key, this.colNum}) : super(key: key);

  @override
  _CustImageListState createState() => _CustImageListState();
}

class _CustImageListState extends State<CustImageList> {
  //List<String> dispList = [];

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ProviderOne>(context, listen: false);
    var itemProv = Provider.of<DBProvider>(context, listen: false);
    List<String>? imgUrls = prov.imgList;
    Display itm = itemProv.item;
    print("I am called from buildmethod");
    return Dialog(
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: imgUrls!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      imgUrls.insert(index, "");
                                      print(index);
                                    });
                                  },
                                  icon: const Icon(
                                      Icons.add_circle_outline_outlined)),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      imgUrls.removeAt(index);
                                    });
                                  },
                                  icon: const Icon(
                                      Icons.remove_circle_outline_outlined)),
                              OneImageLine(
                                imageNo: index,
                                imageURL: imgUrls,
                              ),
                            ],
                          ),
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: ElevatedButton(
                        onPressed: () {
                          var db =
                              Provider.of<DBProvider>(context, listen: false);
                       
                          db.saveToDB(widget.colNum!, imgUrls.join(", "));
                          Navigator.pop(context);
                        },
                        child: const Text("  Save   ")),
                  )
                ],
              ),
            )));
  }
}

class OneImageLine extends StatefulWidget {
  final int? imageNo;
  final List<String>? imageURL;
  const OneImageLine({Key? key, this.imageNo, this.imageURL}) : super(key: key);

  @override
  State<OneImageLine> createState() => _OneImageLineState();
}

class _OneImageLineState extends State<OneImageLine> {
  final TextEditingController _imgText = TextEditingController();

  @override
  void dispose() {
    _imgText.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var prov1 = Provider.of<ProviderOne>(context, listen: true);
    _imgText.text = widget.imageURL![widget.imageNo!].trim();
    return Row(
      children: [
        //Add Button

        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Focus(
            onFocusChange: (value) {
              if (value == false) {
                var prov = Provider.of<ProviderOne>(context, listen: false);
                prov.setImgatInd(widget.imageNo!, _imgText.text);
              }
            },
            child: TextField(
              controller: _imgText,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: accentColor, width: 1.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                hintText: 'Image URL',
                labelText: 'Image URL - ${widget.imageNo! + 1}',
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        (_imgText.text != "")
            ? CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(_imgText.text.trim()),
              )
            : const Text("No Image")
      ],
    );
  }
}

class CusCircleAvatar extends StatelessWidget {
  const CusCircleAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
