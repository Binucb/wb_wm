import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:universal_html/html.dart';
import 'package:wm_workbench/constants.dart';
import 'package:wm_workbench/main.dart';

import 'package:wm_workbench/theme.dart';
import 'package:provider/provider.dart';
import 'package:wm_workbench/Provider/provider.dart';
import 'package:hashids2/hashids2.dart';
import 'package:universal_html/html.dart' as html;

class LoginScreen extends StatefulWidget {
  static const String route = '/loginscreen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String erMsg = "";
  final TextEditingController _un = TextEditingController();
  final TextEditingController _pwd = TextEditingController();
  String dropdownvalue = "Choose Category";

  var categories = [
    'Choose Category',
    'Apparel',
    'Furniture',
    'F&B',
    'Home',
    'Books',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //var provider = Provider.of<ProviderOne>(context);
    //var theme = Provider.of<ThemeProvider>(context);
    //var ab = Provider.of<AppBarProvider>(context, listen: false);

    //ab.chgWBScreen(false);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ProjectTheme.light(),
      home: Scaffold(
        body: Center(
          child: Card(
            elevation: 3,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.7,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset("assets/images/login_screen.gif"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width * 0.305,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                          ),
                          Text(version),
                          const SizedBox(height: 20),
                          CustomText(
                            un: _un,
                            oText: false,
                            lbl: "Associate ID",
                          ),
                          CustomText(un: _pwd, oText: true, lbl: "Password"),
                          Text(
                            erMsg,
                            style: const TextStyle(color: Colors.red),
                          ),
                          const SizedBox(height: 5),
                          DropdownButton(
                              hint: const Text("Choose you category"),
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
                                });
                              }),
                          const SizedBox(height: 20),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                              ),
                              onPressed: () async {
                                if (pswdChk(_un.text, _pwd.text)) {
                                  var ptProv = Provider.of<PTProvider>(context,
                                      listen: false);
                                  await ptProv.getCsv(dropdownvalue);

                                  configDB.put("lStatus", _un.text);
                                  Navigator.of(context).pop();
                                  _un.text = "";
                                  _pwd.text = "";
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.bottomToTop,
                                          child: const MyHomePage()));
                                  //html.window.location.reload();
                                } else {
                                  setState(() {
                                    erMsg =
                                        "Incorrect Associate ID & Password combinantion ";
                                  });
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              )),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.network(
                                    "https://firebasestorage.googleapis.com/v0/b/wm-sd-ld.appspot.com/o/cgn.png?alt=media&token=837558c0-79f3-4886-a359-63eb995431a7",
                                    height: 50,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _un.dispose();
    _pwd.dispose();
    super.dispose();
  }
}

class CustomText extends StatelessWidget {
  const CustomText({
    Key? key,
    required TextEditingController un,
    required this.oText,
    required this.lbl,
  })  : _un = un,
        super(key: key);

  final TextEditingController _un;
  final bool oText;
  final String lbl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
          style: const TextStyle(color: Colors.black, fontSize: 14),
          controller: _un,
          obscureText: oText,
          maxLines: 1,
          decoration: InputDecoration(
              labelText: lbl,
              labelStyle: TextStyle(
                color: Colors.indigo.shade400,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                  color: Colors.indigo.shade400,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: Colors.blueGrey,
                  width: 0.5,
                ),
              ))),
    );
  }
}

bool pswdChk(String str1, String str2) {
  if (str2 == retpsw(str1)) {
    return true;
  } else {
    return false;
  }
}

String retpsw(String dat) {
  final hashids = HashIds(
    salt: 'xed4567',
    minHashLength: 8,
    alphabet: 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
  );
  String id = dat;
  String res = id.split("").reversed.join("");
  final code = hashids.encode(int.parse(res));

  return code;
}
