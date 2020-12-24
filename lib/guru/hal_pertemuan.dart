import 'package:flutter/material.dart';

class Pertemuan extends StatefulWidget {
  final String pelajaran;
  Pertemuan({this.pelajaran});

  @override
  _PertemuanState createState() => _PertemuanState();
}

class _PertemuanState extends State<Pertemuan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pelajaran),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            new Icon(Icons.home),
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
