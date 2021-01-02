import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'nilai_absen.dart';

class Siswa extends StatefulWidget {
  final String pertemuan;
  Siswa({this.pertemuan});

  @override
  _SiswaState createState() => _SiswaState();
}

class _SiswaState extends State<Siswa> {
  Query _ref;

  @override
  initState() {
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('siswa')
        .orderByChild("nis");
  }

  pindahHalAbsen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HalamanAbsen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pertemuan Ke : " + widget.pertemuan),
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
                    nis: daftar['nis'],
                  )
                )
              ),
            child: _dataPertemuan(daftar: daftar)
            );
          },
        ),
      ),
      backgroundColor: Colors.white,
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
                  "Nama :",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  daftar['nama'],
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
                  "nis : ",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  daftar['nis'],
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
