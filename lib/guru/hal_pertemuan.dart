import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Pertemuan extends StatefulWidget {
  final String pelajaran;
  Pertemuan({this.pelajaran});

  @override
  _PertemuanState createState() => _PertemuanState();
}

class _PertemuanState extends State<Pertemuan> {

  /*Query _ref;

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('data')
        .child('pertemuan')
        .orderByChild('jadwal');
  }

  kondisiKelas(){
    if(widget.pelajaran == ){

    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(widget.pelajaran),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            new Icon(Icons.home),
            Text(widget.pelajaran),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          splashColor: Colors.white,
          child: const Icon(Icons.add),
          onPressed: () => {}),
    );
  }
}