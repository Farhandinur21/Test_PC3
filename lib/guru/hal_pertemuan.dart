import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:login/guru/buatpertemuan.dart';
import 'package:login/guru/hal_absen.dart';

class Pertemuan extends StatefulWidget {
  final String pelajaran;
  Pertemuan({this.pelajaran});

  @override
  _PertemuanState createState() => _PertemuanState();
}

class _PertemuanState extends State<Pertemuan> {
  Query _ref;

  void pertemuanKe() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BuatPertemuan(
                  pelajaran: widget.pelajaran,
                )));
  }

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('pertemuan')
        .orderByChild("mata_pelajaran")
        .equalTo(widget.pelajaran); 
  }

  void pindahHalAbsen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HalamanAbsen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pelajaran),
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 5, left: 3, right: 3),
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: _ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map daftar = snapshot.value;
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HalamanAbsen(
                    pertemuan: daftar['pertemuan_ke'],
                  )
                )
              ),
            child: _dataPertemuan(daftar: daftar)
            );
          },
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          splashColor: Colors.white,
          child: const Icon(Icons.add),
          onPressed: () => pertemuanKe()),
    );
  }
}

Widget _dataPertemuan({Map daftar}) {
  return Card(
    color: Colors.green[300],
    child: Row(
      children: <Widget>[
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
                  daftar['mata_pelajaran'],
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
                  "pertemuan ke :",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  daftar['pertemuan_ke'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
