import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/guru/buatkelas.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:login/guru/hal_pertemuan.dart';

class Tabhome extends StatefulWidget {

  final String unik;
  Tabhome({this.unik});

  @override
  _TabhomeState createState() => _TabhomeState();
}

class _TabhomeState extends State<Tabhome> {

  Query _ref;
  String uid;
  static FirebaseAuth _auth = FirebaseAuth.instance;

  Timer timer;
  int counter = 0;

  queryId()async{
    final FirebaseUser user = await _auth.currentUser();
    uid = user.uid.toString();
  }

  @override
  void initState() {
    super.initState();
    queryId();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => addValue());
    _ref = FirebaseDatabase.instance
        .reference()
        .child('data')
        .child('mata_pelajaran')
        .orderByChild('unik')
        .equalTo(widget.unik);
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  void addValue() {
    setState(() {
       counter++; 
    });
  }

  pindah() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BuatKelas(unik: uid,)));
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
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          splashColor: Colors.white,
          child: const Icon(Icons.add),
          onPressed: () => pindah()),
    );
  }

  Widget _dataKelas({Map daftar}) {
    return GestureDetector(
      onTap: () => Navigator.push( context,MaterialPageRoute(
        builder: (
          BuildContext context) => Pertemuan(
            pelajaran: daftar['nama_mapel'],
          )
        )
      ),
      child: Card(
        color: Colors.green[300],
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.book,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      "Mata Pelajaran :",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      daftar['nama_mapel'],
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.timer,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      "Jadwal :",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      daftar['jadwal'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      "Nama Guru : ",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      daftar['nama_guru'],
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ],
        )
      )
    );
  }
}
