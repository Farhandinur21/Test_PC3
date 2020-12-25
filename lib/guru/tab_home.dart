import 'package:flutter/material.dart';
import 'package:login/guru/buatkelas.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:login/guru/hal_pertemuan.dart';
//import 'hal_pertemuan.dart' as pertemuan;
//import 'package:login/signup.dart';

class Tabhome extends StatefulWidget {
  @override
  _TabhomeState createState() => _TabhomeState();
}

class _TabhomeState extends State<Tabhome> {
  Query _ref;

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('data')
        .child('mata_pelajaran')
        .orderByChild('jadwal');
  }

  void pindah() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BuatKelas()));
  }

  void temu() {
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
          //itemCount: itemCount,
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
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => Pertemuan(
                    pelajaran: daftar['nama_mapel'],
                  ))),
      child: Card(
          //margin: EdgeInsets.symmetric(vertical: 5),
          //padding: EdgeInsets.all(5),
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
          )),
    );
  }
}
