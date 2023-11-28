import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wm_workbench/Provider/provider.dart';
import 'package:wm_workbench/theme.dart';

class SearcFeature extends StatefulWidget {
  const SearcFeature({Key? key}) : super(key: key);

  @override
  State<SearcFeature> createState() => _SearcFeatureState();
}

class _SearcFeatureState extends State<SearcFeature> {
  final TextEditingController _searchText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<DBProvider>(context, listen: true);
    return SizedBox(
      height: 45,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
            onChanged: (value) {
              prov.changeSearLsNo(5, value);
              print(value);
            },
            style: TextStyle(
              fontSize: 12.0,
              color: accentColor,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 2),
              prefixIcon: const Icon(Icons.search),
              hintText: "Search the Attribute",
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: accentColor, width: 32.0),
                  borderRadius: BorderRadius.circular(5.0)),
              // focusedBorder: OutlineInputBorder(
              //     borderSide:
              //         const BorderSide(color: Colors.white, width: 32.0),
              //     borderRadius: BorderRadius.circular(25.0))
            )),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchText.dispose();
  }
}
