import 'package:authandstore/components/database.dart';
import 'package:authandstore/database/db_itemList.dart';
import 'package:authandstore/screens/SignIn.dart';
import 'package:authandstore/screens/home.dart';
import 'package:authandstore/services/firebaseServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListOfUsers extends StatefulWidget {
  ListOfUsers({Key? key}) : super(key: key);

  @override
  State<ListOfUsers> createState() => _ListOfUsersState();
}

class _ListOfUsersState extends State<ListOfUsers> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: const Color.fromARGB(0, 4, 40, 69),
          title: const Text(
            "Users",
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
        body: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: StreamBuilder<QuerySnapshot>(
            stream: Database.readUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              } else if (snapshot.hasData || snapshot.data != null) {
                return ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 16.0),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var itemInfo = snapshot.data!.docs[index].data() as dynamic;
                    String name = itemInfo['email'];

                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        onTap: () {
                          Database.userUid = itemInfo['email'];
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Home();
                            },
                          ));
                        },
                        title: Text(
                          name ?? "",
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
    );
  }
}
