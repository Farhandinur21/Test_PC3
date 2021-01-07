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

  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  Query _ref;

  String aa;

  readData(){
    databaseReference
      .child('data')
      .child('orang_tua')
      .child(widget.unik)
      .once()
      .then((DataSnapshot dataSnapshot){
        var data = dataSnapshot.value;
        String gg = data.toString();
        print(gg);
        var splitData = gg.split(',');
        var day = splitData[1];
        var daySplit = day.split(":");
        var hari = daySplit[1].replaceAll('','');
        var ss = hari.split(' ');
        var kk = ss[1];
        aa = kk.toString();
        print('halo'+aa);
    });
  }

  @override
  void initState() {
    super.initState();
    readData();
    //print(aa);
    _ref = FirebaseDatabase.instance
        .reference()
        .child('presensi')
        .orderByChild('nis')
        .equalTo(aa);
  }

  pindah() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BuatKelas()));
  }

  temu() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Pertemuan()));
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
            pelajaran: daftar['mata_pelajaran'],
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
                      "Absensi :",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      daftar['absensi'],
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
                      "Nama Siswa : ",
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
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
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
                      "Nilai :",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      daftar['nilai'],
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
                      Icons.book,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      "Nis :",
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
                      Icons.book,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      "Pertemuan Ke :",
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
              ],
            ),
          ],
        )
      )
    );
  }
}
