import 'package:authandstore/screens/SignIn.dart';
import 'package:flutter/material.dart';
import 'package:authandstore/components/database.dart';
import 'package:authandstore/database/db_edit_item_form.dart';

class EditScreen extends StatefulWidget {
  final String currentTitle;
  final String currentDescription;
  final String documentId;

  EditScreen({
    required this.currentTitle,
    required this.currentDescription,
    required this.documentId,
  });

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final FocusNode _titleFocusNode = FocusNode();

  final FocusNode _descriptionFocusNode = FocusNode();

  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _titleFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: const Color.fromARGB(0, 4, 40, 69),
          title: const Text(
            "Edit",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            _isDeleting
                ? const Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                      right: 16.0,
                    ),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.redAccent,
                      ),
                      strokeWidth: 3,
                    ),
                  )
                : IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                      size: 32,
                    ),
                    onPressed: () async {
                      setState(() {
                        _isDeleting = true;
                      });

                      await Database.deleteItem(
                        docId: widget.documentId,
                      );

                      setState(() {
                        _isDeleting = false;
                      });

                      Navigator.of(context).pop();
                    },
                  ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return SignIn();
                  },
                ));
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: DbEditItemForm(
              documentId: widget.documentId,
              nameFocusNode: _titleFocusNode,
              priceFocusNode: _descriptionFocusNode,
              currentTitle: widget.currentTitle,
              currentDescription: widget.currentDescription,
            ),
          ),
        ),
      ),
    );
  }
}
