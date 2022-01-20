import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wm_workbench/Provider/provider.dart';
import 'package:wm_workbench/Screens/addwords.dart';
import 'package:wm_workbench/Services/methods.dart';
import 'package:wm_workbench/Widgets/cust_alert.dart';
import 'package:wm_workbench/main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class CustAppBar extends StatefulWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  CustAppBar({Key? key})
      : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  State<CustAppBar> createState() => _CustAppBarState();
}

class _CustAppBarState extends State<CustAppBar> {
  Future<void> _launchInWebViewWithDomStorage(String url) async {
    if (!await launch(
      url,
      forceSafariVC: true,
      forceWebView: true,
      enableDomStorage: true,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: (!Provider.of<AppBarProvider>(context, listen: false)
              .workbenchScreen!)
          ? <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton.icon(
                    label: const Text("Upload"),
                    onPressed: () async {
                      await customalert(
                          context: context,
                          title: "File upload",
                          content:
                              "Kindly upload the new workfile to the workbench. \nOld files will be deleted from the Database",
                          met2: upload);
                    },
                    icon: const Icon(
                      Icons.cloud_upload,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton.icon(
                    label: const Text("Download"),
                    onPressed: () {
                      customalert(
                          context: context,
                          title: "File Download",
                          content: "Only saved line items will be downloaded",
                          met2: download);
                    },
                    icon: const Icon(
                      Icons.cloud_download,
                    )),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: IconButton(
                  onPressed: () async {
                    await customalert(
                        context: context,
                        title: "Config File upload",
                        content:
                            "Would you like update the config file for the category. \nNote:Old files will be deleted from the Database",
                        met2: uploadPT);
                  },
                  icon: const Icon(
                    Icons.post_add_outlined,
                  ),
                  color: Colors.white,
                ),
              )
              // IconButton(
              //     onPressed: () {
              //       provider.changeTheme();
              //     },
              //     icon: (provider.appTheme!)
              //         ? const Icon(Icons.light_mode_outlined)
              //         : const Icon(Icons.light_mode_sharp))
            ]
          : <Widget>[
              Padding(
                padding: const EdgeInsets.all(11.0),
                child: ElevatedButton.icon(
                    label: const Text("Add Highlight Words"),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AddWords();
                          });
                    },
                    icon: const Icon(
                      Icons.highlight,
                    )),
              )
            ],
      title: Row(
        children: [
          Text(projectName),
          (Provider.of<AppBarProvider>(context, listen: false).workbenchScreen!)
              ? Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("ITEM ID : ",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          )),
                    ),
                    Text(
                      Provider.of<ProviderOne>(context).id!,
                      style: TextStyle(fontSize: 14),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.white70,
                    ),
                    const Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("PT : ",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          )),
                    ),
                    Text(Provider.of<ProviderOne>(context).pt!,
                        style: const TextStyle(fontSize: 14)),
                    IconButton(
                        onPressed: () {
                          String toLaunch =
                              'https://www.walmart.com/ip/${Provider.of<ProviderOne>(context, listen: false).id!}';
                          _launchInWebViewWithDomStorage(toLaunch);
                        },
                        icon: const Icon(Icons.launch))
                  ],
                )
              : const SizedBox(
                  height: 5,
                )
        ],
      ),
    );
  }
}
