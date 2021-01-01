import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'tab_home.dart';

class QueryMapel extends StatefulWidget {
  @override
  _QueryMapelState createState() => _QueryMapelState();
}

class _QueryMapelState extends State<QueryMapel> {
  Query _ref;

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('data')
        .child('guru')
        .orderByChild('id');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 5, left: 3, right: 3),
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: _ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map daftar = snapshot.value;
            return _dataKelas(daftar: daftar);
          },
        ),
      ),
    );
  }

  Widget _dataKelas({Map daftar}) {
    return GestureDetector(
      onTap: () => Navigator.push( context,MaterialPageRoute(
        builder: (
          BuildContext context) => Tabhome(
            //id: daftar['id'],
          )
        )
      ),
    );
  }
}
