import 'package:flutter/material.dart';

class AddTodoDialog extends StatefulWidget {
  AddTodoDialog({Key key}) : super(key: key);

  @override
  _AddTodoDialogState createState() => _AddTodoDialogState();
}

@immutable
class TodoInfo {}

class _AddTodoDialogState extends State<AddTodoDialog> {
  TextEditingController _textEditingController;
  bool hasContent;

  Color get suffixIconDisabledColor => Theme.of(context).disabledColor;
  Color get suffixIconAccentColor => Theme.of(context).accentColor;
  Color get suffixIconColor =>
      hasContent ?? false ? suffixIconAccentColor : suffixIconDisabledColor;

  Color get prefixIconColor => Theme.of(context).iconTheme.color;

  @override
  void initState() {
    hasContent = false;

    _textEditingController = TextEditingController();
    _textEditingController.addListener(() {
      setState(() {
        hasContent = _textEditingController.text?.isNotEmpty ?? false;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(color: Colors.grey),
      child: Material(
        elevation: 16,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                autofocus: true,
                controller: _textEditingController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                    top: 16,
                    bottom: 12,
                    left: 12,
                    right: 12,
                  ),
                  focusedBorder: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.check_circle_outline,
                    color: prefixIconColor,
                  ),
                  hintText: "Helper",
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.arrow_forward,
                      color: suffixIconColor,
                    ),
                    onPressed: () {},
                  ),
                ),
                textAlignVertical: TextAlignVertical.center,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.go,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.calendar_today),
                    label: Text('Date'),
                  ),
                  FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.repeat),
                    label: Text('Repeat'),
                  ),
                  FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.alarm_add),
                    label: Text('Alarm'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
