import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:authandstore/components/database.dart';
import 'package:authandstore/screens/EditScreen.dart';
import 'package:authandstore/screens/EditScreen.dart';
import 'package:authandstore/screens/SignIn.dart';
import 'package:authandstore/services/firebaseServices.dart';
import 'package:flutter/material.dart';
import 'package:authandstore/screens/AddScreen.dart';

class UserHomePage extends StatefulWidget {
  UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
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
              onPressed: () async {
                await FirebaseServices().signOut();
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
            child: StreamBuilder<QuerySnapshot>(
              stream: Database.readItems(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                } else if (snapshot.hasData || snapshot.data != null) {
                  return ListView.separated(
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16.0),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var itemInfo =
                          snapshot.data!.docs[index].data() as dynamic;
                      String docID = snapshot.data!.docs[index].id;
                      String name = itemInfo['Name'];
                      String price = itemInfo['price'];

                      return Ink(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          onTap: () {},
                          title: Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            price,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    },
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.orange,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
