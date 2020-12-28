import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

List<String> _presensi = ['Hadir', 'Absen', 'Sakit', 'Izin'];
//tring _selectedPresensi;

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
        .child('siswa')
        .orderByChild("nis");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pertemuan Ke : " + widget.pertemuan),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 5, left: 3, right: 3),
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: _ref,
          //itemCount: itemCount,
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
  @override
  Widget build(BuildContext context) {
    return Card(
      //margin: EdgeInsets.symmetric(vertical: 5),
      //padding: EdgeInsets.all(5),
      color: Colors.green[300],
      child: Row(
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
                ],
              ),
            ],
          ),
          Center(
            child: Container(
              child: DropdownButton(
                hint: Text('pilih'), // Not necessary for Option 1

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
    );
  }
}
