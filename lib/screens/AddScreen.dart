import 'package:authandstore/database/db_AddItemForm.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatelessWidget {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _priceFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _nameFocusNode.unfocus();
        _priceFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          elevation: 0,
          title: const Text(
            "Add item screen",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: DbAddItemForm(
              nameFocusNode: _nameFocusNode,
              priceFocusNode: _priceFocusNode,
            ),
          ),
        ),
      ),
    );
  }
}
