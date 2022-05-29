import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wm_workbench/models/wb_model.dart';

import '../Provider/provider.dart';

List<String> findErrors(Display item, BuildContext context) {
  List<String> retError = [];
  var db = Provider.of<DBProvider>(context, listen: false);

  // for (var attr in item.lstAttrs1!) {
  //   if (attr.req == Requirement.required && attr.decCol!.colValue == "") {
  //     retError.add(
  //         "${attr.attrVal!.header} must have Yes/No decision. Cannot be blank");
  //   } else if (attr.req == Requirement.optional &&
  //       attr.decCol!.colValue == "No") {
  //     retError.add("${attr.attrVal!.header} cannot have No decision");
  //   }
  // }
  for (var attr in item.lstAttrs4!) {
    attr.err!.clear();
    //++checking req opt++
    if (attr.req == Requirement.required && attr.decCol!.colValue == "") {
      retError.add(
          "${attr.attrVal!.header} must have Yes/No decision. Cannot be blank");
      attr.err!.add(
          "${attr.attrVal!.header} must have Yes/No decision. Cannot be blank");
    } else if (attr.req == Requirement.optional &&
        attr.decCol!.colValue == "No") {
      retError.add("${attr.attrVal!.header} cannot have No decision");
      attr.err!.add("${attr.attrVal!.header} cannot have No decision");
    }
    // print(attr.attrVal!.header);
    // print(attr.attrVal!.clList!.length);
    //++checking closed list values++
    if (attr.decCol!.colValue == "Yes") {
      List<String> val = attr.attrVal!.colValue.split("|");
      if (attr.attrVal!.clList!.length != 1) {
        for (String indWord in val) {
          if (attr.attrVal!.clList!.contains(indWord)) {
          } else {
            attr.err!
                .add("$indWord is not part of Closed List Value. Please check");
            retError
                .add("$indWord is not part of Closed List Value. Please check");
          }
        }
      }
    }
    //++empty error code
    if (attr.decCol!.colValue == "Yes" || attr.decCol!.colValue == "No") {
      if (attr.errCode!.colValue == "") {
        attr.err!.add("Please select the Error code from the drop down");
        retError.add("Please select the Error code from the drop down");
      }
    }

    if (attr.decCol!.colValue == "Yes") {
      if (attr.attrVal!.colValue == "") {
        attr.err!.add("Attribute value cannot be blank with Yes decision");
        retError.add("Attribute value cannot be blank with Yes decision");
      }
    }
  }

  // for (var attr in item.lstAttrs3!) {
  //   if (attr.req == Requirement.required && attr.decCol!.colValue == "") {
  //     retError.add(
  //         "${attr.attrVal!.header} must have Yes/No decision. Cannot be blank");
  //   } else if (attr.req == Requirement.optional &&
  //       attr.decCol!.colValue == "No") {
  //     retError.add("${attr.attrVal!.header} cannot have No decision");
  //   }
  // }

  // for (var attr in item.lstAttrs4!) {
  //   if (attr.req == Requirement.required && attr.decCol!.colValue == "") {
  //     retError.add(
  //         "${attr.attrVal!.header} must have Yes/No decision. Cannot be blank");
  //   } else if (attr.req == Requirement.optional &&
  //       attr.decCol!.colValue == "No") {
  //     retError.add("${attr.attrVal!.header} cannot have No decision");
  //   }
  // }
  db.changeDispItem(item);

  return retError;
}
