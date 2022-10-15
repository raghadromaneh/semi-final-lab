import 'package:flutter/material.dart';
import 'package:authandstore/components/database.dart';

class DbAddItemForm extends StatefulWidget {
  final FocusNode nameFocusNode;
  final FocusNode priceFocusNode;

  const DbAddItemForm({
    required this.nameFocusNode,
    required this.priceFocusNode,
  });

  @override
  _DbAddItemFormState createState() => _DbAddItemFormState();
}

class _DbAddItemFormState extends State<DbAddItemForm> {
  final _addItemFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _addItemFormKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24.0),
                const Text(
                  'Name',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 22.0,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  focusNode: widget.nameFocusNode,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: "Enter item name",
                  ),
                ),
                const SizedBox(height: 24.0),
                const Text(
                  'Price',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 22.0,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  focusNode: widget.priceFocusNode,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  controller: _priceController,
                  decoration: const InputDecoration(
                    hintText: "Enter item price",
                  ),
                ),
              ],
            ),
          ),
          _isProcessing
              ? const Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 2, 66, 78),
                    ),
                  ),
                )
              : Container(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 2, 66, 78),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      widget.nameFocusNode.unfocus();
                      widget.priceFocusNode.unfocus();

                      if (_addItemFormKey.currentState!.validate()) {
                        setState(() {
                          _isProcessing = true;
                        });

                        await Database.addItem(
                          Name: _nameController.text,
                          price: _priceController.text,
                        );

                        setState(() {
                          _isProcessing = false;
                        });

                        Navigator.of(context).pop();
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                      child: Text(
                        'ADD ITEM',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 238, 238, 238),
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
