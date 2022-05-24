import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wm_workbench/constants.dart';

import '../Provider/provider.dart';

class ChoosePTG extends StatefulWidget {
  const ChoosePTG({Key? key}) : super(key: key);

  @override
  State<ChoosePTG> createState() => _ChoosePTGState();
}

class _ChoosePTGState extends State<ChoosePTG> {
  String dropdownvalue = "Choose Category";
  String dropdownvalue1 = "Choose PTG";

  var categories = dropPTG.keys.toList();
  var ptgLst = ["Choose PTG"];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              child: DropdownButton(
                  isExpanded: true,
                  hint: const Text("Choose your category"),
                  value: dropdownvalue,
                  items: categories.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                      dropdownvalue1 = "Choose PTG";
                      ptgLst = dropPTG[newValue]!.split("|");
                    });
                  }),
            ),
            const SizedBox(height: 5),
            //Choose PTG dropdown
            SizedBox(
              width: 250,
              child: DropdownButton(
                  isExpanded: true,
                  hint: const Text("Choose PTG"),
                  value: dropdownvalue1,
                  items: ptgLst.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) async {
                    setState(() {
                      dropdownvalue1 = newValue!;
                    });
                    if (dropdownvalue != "Choose Category" &&
                        dropdownvalue1 != "Choose PTG") {
                      var ptProv =
                          Provider.of<PTProvider>(context, listen: false);
                      await ptProv.getCsv(dropdownvalue, dropdownvalue1);
                    }
                  }),
            ),
          ],
        ),
      ],
    );
  }
}
