import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:universal_html/html.dart';
import 'package:wm_workbench/main.dart';

import 'package:wm_workbench/theme.dart';
import 'package:provider/provider.dart';
import 'package:wm_workbench/Provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String route = '/loginscreen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _un = TextEditingController();
  final TextEditingController _pwd = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderOne>(context);
    var theme = Provider.of<ThemeProvider>(context);
    var ab = Provider.of<AppBarProvider>(context);

    ab.chgWBScreen(false);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: (theme.appTheme!) ? ProjectTheme.dark() : ProjectTheme.light(),
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
                      child: Image.network(
                          "https://firebasestorage.googleapis.com/v0/b/wm-sd-ld.appspot.com/o/login_screen.gif?alt=media&token=e31a8653-4918-4eba-8cf9-1a30333926da"),
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
                          const Text("V1.3 Please Login"),
                          const SizedBox(height: 20),
                          CustomText(
                            un: _un,
                            oText: false,
                            lbl: "Associate ID",
                          ),
                          CustomText(un: _pwd, oText: true, lbl: "Password"),
                          const SizedBox(height: 20),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                              ),
                              onPressed: () {
                                if (_pwd.text == "password") {
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.bottomToTop,
                                          child: const MyHomePage()));
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
