import 'package:authandstore/database/db_itemList.dart';
import 'package:authandstore/screens/SignIn.dart';
import 'package:flutter/material.dart';
import 'package:authandstore/screens/AddScreen.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: const Color.fromARGB(0, 4, 40, 69),
          title: const Text(
            "Items",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddScreen(),
              ),
            );
          },
          backgroundColor: const Color.fromARGB(255, 5, 77, 105),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 32,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: DbItemList(),
          ),
        ),
      ),
    );
  }
}
