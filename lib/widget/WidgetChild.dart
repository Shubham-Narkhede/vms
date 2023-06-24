import 'package:flutter/material.dart';

import '../models/ModelDropDown.dart';
import 'WidgetText.dart';

class WidgetChild extends StatefulWidget {
  final List<ModelDropDown> list;
  final Function(ModelDropDown) callBack;

  WidgetChild({
    required this.list,
    required this.callBack,
  });
  @override
  _WidgetChildState createState() => _WidgetChildState();
}

class _WidgetChildState extends State<WidgetChild> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 250,
        child: ListView.builder(
            itemBuilder: (_, int index) {
              ModelDropDown item = widget.list[index];
              return InkWell(
                onTap: () {
                  setState(() {
                    widget.callBack(item);
                    FocusScope.of(context).unfocus();
                  });
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Container(
                  padding: const EdgeInsets.only(bottom: 5),
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey))),
                  margin: const EdgeInsets.only(
                      left: 20, top: 13, bottom: 13, right: 20),
                  child: widgetText(
                      text: item.title,
                      textStyle:
                          textStyle(textColor: Colors.black, fontSize: 16)),
                ),
              );
            },
            itemCount: widget.list.length));
  }
}
