import 'package:flutter/material.dart';

import 'WidgetText.dart';

class CommonDialog extends StatefulWidget {
  final String title;
  final Widget child;
  final bool? showCancel;
  CommonDialog({required this.title, required this.child, this.showCancel});
  @override
  _CommonDialogState createState() => new _CommonDialogState();
}

class _CommonDialogState extends State<CommonDialog> {
  Widget? child;
  @override
  void initState() {
    child = widget.child;
    super.initState();
  }

  @override
  void didUpdateWidget(dynamic oldWidget) {
    super.didUpdateWidget(oldWidget);
    child = widget.child;
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            insetPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            scrollable: true,
            contentPadding: EdgeInsets.all(5),
            titlePadding: EdgeInsets.only(
              top: 15,
              bottom: 7,
              left: 10,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widgetText(
                    text: widget.title, textStyle: textStyle(fontSize: 16)),
                if (widget.showCancel == true)
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    child: InkWell(
                        child: Icon(Icons.close),
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        }),
                  )
              ],
            ),
            content: Container(
              width: MediaQuery.of(context).size.width / 1.2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [child!],
              ),
            ));
      },
    );
  }
}
