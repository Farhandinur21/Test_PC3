import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

List<String> _presensi = ['Hadir', 'Absen', 'Sakit', 'Izin'];

class HalamanAbsen extends StatefulWidget {
  final String pertemuan;
  HalamanAbsen({this.pertemuan});

  @override
  _HalamanAbsenState createState() => _HalamanAbsenState();
}

class _HalamanAbsenState extends State<HalamanAbsen> {
  Query _ref;

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('siswa_pertemuan')
        .orderByChild("pertemuan_ke")
        .equalTo(widget.pertemuan);
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
            return ListSiswa(daftar: daftar);
          },
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class ListSiswa extends StatefulWidget {
  const ListSiswa({
    Key key,
    @required this.daftar,
  }) : super(key: key);

  final Map daftar;

  @override
  _ListSiswaState createState() => _ListSiswaState();
}

class _ListSiswaState extends State<ListSiswa> {
  String _selectedPresensi;
  String teks = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nilai = new TextEditingController();

  DatabaseReference presensiSiswa = FirebaseDatabase.instance
    .reference()
    .child('presensi');

  absen() {
    presensiSiswa.push().set({
      'nama': widget.daftar['nama'],
      'nis' : widget.daftar['nis'],
      'absensi': _selectedPresensi,
      'nilai' : nilai.text,
      'mata_pelajaran' : widget.daftar['mata_pelajaran'],
      'pertemuan_ke': widget.daftar['pertemuan_ke'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[300],
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 45,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
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
                            widget.daftar['nama'],
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
                      Container(
                        child: Row(
                          children: [
                            Text(
                              "NIS :",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              widget.daftar['nis'],
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 200,
                      ),
                    ],
                  ),
                ],
              ),
              Center(
                child: Container(
                  child: DropdownButton(
                    hint: Text('Kehadiran'),
                    value: _selectedPresensi,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedPresensi = newValue;
                      });
                    },
                    items: _presensi.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location),
                        value: location,
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Container(
              child: TextField(
                key: _formKey,
                keyboardType: TextInputType.number,
                controller: nilai,
              ),
            )
          ),
          RaisedButton(
            child: Text(
              "Save",
              style: TextStyle(
                color: Colors.black
              ),
            ),
            color: Colors.white,
            onPressed: (){
              absen();
              nilai.text="";
            },
          )
        ]
      )
    );
  }
}
