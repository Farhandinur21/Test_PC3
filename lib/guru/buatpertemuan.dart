import 'package:flutter/material.dart';
import 'package:login/guru/hal_pertemuan.dart';
import 'package:firebase_database/firebase_database.dart';

class BuatPertemuan extends StatefulWidget {
  @override
  _BuatPertemuanState createState() => _BuatPertemuanState();
}

class _BuatPertemuanState extends State<BuatPertemuan> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController jumlahpertemuanInput = new TextEditingController();

  DatabaseReference pertemuanTambah = FirebaseDatabase.instance
      .reference()
      .child('pertemuan')
      .orderByChild("mata_pelajaran");

  void tambahPertemuan() {
    pertemuanTambah.push().set({
      'mata_pelajaran'
          'pertemuan_ke': jumlahpertemuanInput.text,
    });
  }

  void submit() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Pertemuan()));
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
              "BUAT PERTEMUAN",
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
                      controller: jumlahpertemuanInput,
                      validator: (e) {
                        if (e.isEmpty) {
                          return "Isi Jumlah Pertemuan";
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
                        hintText: "Masukkan Jumlah Pertemuan",
                        hintStyle: TextStyle(color: Colors.black87),
                        labelText: "Pertemuan ke",
                        labelStyle: TextStyle(color: Colors.black87),
                      )),
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                    ),
                    height: 10,
                  ),
                  Card(
                    color: Colors.green,
                    elevation: 5,
                    child: Container(
                      height: 35.0,
                      child: InkWell(
                        onTap: () {
                          tambahPertemuan();
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
