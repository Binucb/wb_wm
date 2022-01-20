import 'package:flutter/material.dart';

class CustImageList extends StatefulWidget {
  final String? urlList;
  const CustImageList({Key? key, this.urlList}) : super(key: key);

  @override
  _CustImageListState createState() => _CustImageListState();
}

class _CustImageListState extends State<CustImageList> {
  @override
  Widget build(BuildContext context) {
    List<String> imgUrls = widget.urlList!.split(", ");
    return Dialog(
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                itemCount: imgUrls.length,
                itemBuilder: (context, index) {
                  return OneImageLine(
                    imageNo: index,
                    imageURL: imgUrls[index],
                  );
                })));
  }
}

class OneImageLine extends StatefulWidget {
  final int? imageNo;
  final String? imageURL;
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
    _imgText.text = widget.imageURL!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //Add Button
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_circle_outline_outlined)),
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.remove_circle_outline_outlined)),
        TextField(
          controller: _imgText,
          maxLines: 2,
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 5.0),
            ),
            hintText: 'Image URL',
            labelText: 'Image URL - ${widget.imageNo! + 1}',
          ),
        ),
        CircleAvatar(
          backgroundImage: NetworkImage(widget.imageURL!),
        )
      ],
    );
  }
}
