import 'package:flutter/material.dart';
import 'package:authandstore/components/database.dart';

class DbEditItemForm extends StatefulWidget {
  final FocusNode nameFocusNode;
  final FocusNode priceFocusNode;
  final String currentTitle;
  final String currentDescription;
  final String documentId;

  const DbEditItemForm({
    required this.nameFocusNode,
    required this.priceFocusNode,
    required this.currentTitle,
    required this.currentDescription,
    required this.documentId,
  });

  @override
  _DbEditItemFormState createState() => _DbEditItemFormState();
}

class _DbEditItemFormState extends State<DbEditItemForm> {
  final _editItemFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  late TextEditingController _nameController;
  late TextEditingController _priceController;

  @override
  void initState() {
    _nameController = TextEditingController(
      text: widget.currentTitle,
    );

    _priceController = TextEditingController(
      text: widget.currentDescription,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _editItemFormKey,
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
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    label: Text('Name'),
                    hintText: 'Enter your item name',
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
                  controller: _priceController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    label: Text('Price'),
                    hintText: 'Enter your item price',
                  ),
                ),
              ],
            ),
          ),
          _isProcessing
              ? const Padding(
                  padding: EdgeInsets.all(16.0),
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
                        const Color.fromARGB(255, 2, 66, 78),
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

                      if (_editItemFormKey.currentState!.validate()) {
                        setState(() {
                          _isProcessing = true;
                        });

                        await Database.updateItem(
                          docId: widget.documentId,
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
                        'UPDATE ITEM',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
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
