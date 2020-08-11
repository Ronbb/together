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
  FocusNode _focusNode;
  bool _hasContent;
  bool _showMore;

  Color get suffixIconDisabledColor => Theme.of(context).disabledColor;
  Color get suffixIconAccentColor => Theme.of(context).accentColor;
  Color get suffixIconColor =>
      _hasContent ?? false ? suffixIconAccentColor : suffixIconDisabledColor;

  Color get prefixIconColor => Theme.of(context).iconTheme.color;

  double get marginBottom =>
      _showMore ?? false ? 0 : MediaQuery.of(context).viewInsets.bottom;

  @override
  void initState() {
    _hasContent = false;
    _showMore = false;

    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _showMore = !_focusNode.hasFocus;
      });
    });

    _textEditingController = TextEditingController();
    _textEditingController.addListener(() {
      setState(() {
        _hasContent = _textEditingController.text?.isNotEmpty ?? false;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void onFinish() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(bottom: marginBottom),
      child: GestureDetector(
        onTap: () => _focusNode.unfocus(),
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
                      Icons.add_circle_outline,
                      color: prefixIconColor,
                    ),
                    hintText: "Helper",
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.arrow_forward,
                        color: suffixIconColor,
                      ),
                      onPressed: _hasContent ? onFinish : null,
                    ),
                  ),
                  toolbarOptions: ToolbarOptions(
                    copy: true,
                    cut: true,
                    paste: true,
                    selectAll: true,
                  ),
                  focusNode: _focusNode,
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
                    IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: _showMoreOptions,
                    )
                  ],
                ),
                if (_showMore)
                  Container(
                    height: 192,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showMoreOptions() {
    setState(() {
      _focusNode.unfocus();
      _showMore = true;
    });
  }
}
