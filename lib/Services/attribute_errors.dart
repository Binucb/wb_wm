import 'package:wm_workbench/models/wb_model.dart';

List<String> findErrors(Display item) {
  List<String> retError = [];

  for (var attr in item.lstAttrs1!) {
    if (attr.req == Requirement.required && attr.decCol!.colValue == "") {
      retError.add(
          "${attr.attrVal!.header} must have Yes/No decision. Cannot be blank");
    } else if (attr.req == Requirement.optional &&
        attr.decCol!.colValue == "No") {
      retError.add("${attr.attrVal!.header} cannot have No decision");
    }
  }
  for (var attr in item.lstAttrs2!) {
    if (attr.req == Requirement.required && attr.decCol!.colValue == "") {
      retError.add(
          "${attr.attrVal!.header} must have Yes/No decision. Cannot be blank");
    } else if (attr.req == Requirement.optional &&
        attr.decCol!.colValue == "No") {
      retError.add("${attr.attrVal!.header} cannot have No decision");
    }
  }

  for (var attr in item.lstAttrs3!) {
    if (attr.req == Requirement.required && attr.decCol!.colValue == "") {
      retError.add(
          "${attr.attrVal!.header} must have Yes/No decision. Cannot be blank");
    } else if (attr.req == Requirement.optional &&
        attr.decCol!.colValue == "No") {
      retError.add("${attr.attrVal!.header} cannot have No decision");
    }
  }

  // for (var attr in item.lstAttrs4!) {
  //   if (attr.req == Requirement.required && attr.decCol!.colValue == "") {
  //     retError.add(
  //         "${attr.attrVal!.header} must have Yes/No decision. Cannot be blank");
  //   } else if (attr.req == Requirement.optional &&
  //       attr.decCol!.colValue == "No") {
  //     retError.add("${attr.attrVal!.header} cannot have No decision");
  //   }
  // }

  return retError;
}
