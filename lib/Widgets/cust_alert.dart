import 'package:flutter/material.dart';

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

Widget headerWidget(String txt) {
  return Card(
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
            txt,
            style: const TextStyle(fontSize: 12, color: Colors.white),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    ),
  );
}
