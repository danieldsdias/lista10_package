// ignore_for_file: use_key_in_widget_constructors, no_logic_in_create_state

library lista10_package;

import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter/material.dart';

class NewItemWidget extends StatefulWidget {
  final Function addTx;
  final Color? color;

  const NewItemWidget(this.addTx, [this.color]);

  static void startAddNewItem(BuildContext ctx, Function function,
      [Color? color]) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () => {},
          behavior: HitTestBehavior.opaque,
          child: color == null
              ? NewItemWidget(function)
              : NewItemWidget(function, color),
        );
      },
    );
  }

  @override
  State<NewItemWidget> createState() => _NewItemWidgetState(color);
}

class _NewItemWidgetState extends State<NewItemWidget> {
  final _titleController = TextEditingController();
  FocusNode focusNode = FocusNode();
  ColorSwatch? _tempMainColor;
  Color? _tempShadeColor;
  ColorSwatch? _mainColor = Colors.blue;
  Color? _shadeColor = Colors.blue[800];
  bool useColor = false;

  _NewItemWidgetState(Color? color) {
    if (color != null) {
      useColor = true;
      _mainColor = color as ColorSwatch?;
    }
  }

  void _openDialog(String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('CANCELAR'),
            ),
            TextButton(
              child: const Text('ESCOLHER'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() => _mainColor = _tempMainColor);
                setState(() => _shadeColor = _tempShadeColor);
              },
            ),
          ],
        );
      },
    );
  }

  void _openColorPicker() async {
    _openDialog(
      "Color picker",
      MaterialColorPicker(
          allowShades: false,
          selectedColor: _shadeColor,
          onColorChange: (color) => setState(() => _tempShadeColor = color),
          onMainColorChange: (color) => setState(() => _tempMainColor = color)),
    );
  }

  void _submitData() {
    final enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty) {
      return;
    }

    if (useColor) {
      widget.addTx(enteredTitle, _mainColor);
    } else {
      widget.addTx(enteredTitle);
    }

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                focusNode: focusNode,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Título'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
                textInputAction: TextInputAction.send,
              ),
              const SizedBox(height: 16.0),
              useColor
                  ? SizedBox(
                      height: 60,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 20),
                            child: CircleAvatar(
                                backgroundColor: _mainColor, radius: 20),
                          ),
                          OutlinedButton(
                            onPressed: _openColorPicker,
                            child: const Text('Escolher cor'),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              ElevatedButton(
                onPressed: _submitData,
                child: const Text('Criar Item'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
