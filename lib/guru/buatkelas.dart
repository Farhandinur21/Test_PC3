import 'package:flutter/material.dart';
import 'package:login/guru/homepage.dart';
import 'package:firebase_database/firebase_database.dart';

class BuatKelas extends StatefulWidget {
  @override
  _BuatKelasState createState() => _BuatKelasState();
}

class _BuatKelasState extends State<BuatKelas> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController mataPelajaranInput = new TextEditingController();
  TextEditingController jadwalInput = new TextEditingController();
  TextEditingController namaGuru = new TextEditingController();

  DatabaseReference kelasTambah = FirebaseDatabase.instance
      .reference()
      .child('data')
      .child('mata_pelajaran');

  void tambahKelas() {
    kelasTambah.push().set({
      'jadwal': jadwalInput.text,
      'nama_mapel': mataPelajaranInput.text,
      'nama_guru': namaGuru.text,
    });
  }

  void submit() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Homepage(null)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20.0),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(
              "BUAT KELAS",
              style: TextStyle(fontSize: 30.0, color: Colors.green),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
            ),
            SizedBox(
              child: Padding(
                padding: EdgeInsets.all(20.0),
              ),
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                      controller: mataPelajaranInput,
                      validator: (e) {
                        if (e.isEmpty) {
                          return "Isi Mata Pelajaran";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87)),
                        prefixIcon: Icon(
                          Icons.book,
                          size: 25.0,
                        ),
                        hintText: "Masukkan Mata Pelajaran",
                        hintStyle: TextStyle(color: Colors.black87),
                        labelText: "Mata Pelajaran",
                        labelStyle: TextStyle(color: Colors.black87),
                      )),
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                    ),
                    height: 10,
                  ),
                  TextFormField(
                      controller: jadwalInput,
                      validator: (e) {
                        if (e.isEmpty) {
                          return "Isi jadwal kelas";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87)),
                        prefixIcon: Icon(
                          Icons.timer,
                          size: 25.0,
                        ),
                        hintText: "Masukkan Jadwal Kelas",
                        hintStyle: TextStyle(color: Colors.black87),
                        labelText: "Jadwal Kelas",
                        labelStyle: TextStyle(color: Colors.black87),
                      )),
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                    ),
                    height: 10,
                  ),
                  TextFormField(
                      controller: namaGuru,
                      validator: (e) {
                        if (e.isEmpty) {
                          return "Isi Nama guru pengampu";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87)),
                        prefixIcon: Icon(
                          Icons.person,
                          size: 25.0,
                        ),
                        hintText: "Masukkan Nama Guru Pengampu",
                        hintStyle: TextStyle(color: Colors.black87),
                        labelText: "Guru Pengampu",
                        labelStyle: TextStyle(color: Colors.black87),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    color: Colors.green,
                    elevation: 5,
                    child: Container(
                      height: 35.0,
                      child: InkWell(
                        onTap: () {
                          tambahKelas();
                          submit();
                        },
                        splashColor: Colors.white,
                        child: Center(
                          child: Text(
                            "Submit",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
