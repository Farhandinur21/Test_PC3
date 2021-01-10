import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../auth_service.dart';

class Akun extends StatefulWidget {
  final String unik;
  Akun({this.unik});

  @override
  _AkunState createState() => _AkunState();
}

class _AkunState extends State<Akun> {

  Query _ref;

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('data')
        .child('guru')
        .child(widget.unik);
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: StreamBuilder(
        stream: _ref.onValue,
        builder: (context, snapshot){
          if(snapshot.hasData && 
             !snapshot.hasError && 
             snapshot.data.snapshot.value != null){
            var _guru = Profile.fromJson(snapshot.data.snapshot.value);
            //print(widget.unik);
            return dataGuru(_guru);
          }         
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      ),
    );
  }

  Widget dataGuru(Profile _guru){
    return Scaffold(
        body: new Stack(
        children: <Widget>[
          Positioned(
              width: 350.0,
              top: MediaQuery.of(context).size.height / 5,
              child: Column(
                children: <Widget>[
                  Container(
                      width: 150.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(Radius.circular(75.0)),
                          boxShadow: [
                            BoxShadow(blurRadius: 7.0, color: Colors.black)
                          ])),
                  SizedBox(height: 50.0),
                  Text(
                    '${_guru.namaGuru}',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    '${_guru.nip}',
                    style: TextStyle(
                        fontSize: 17.0,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Montserrat'),
                  ),
                  SizedBox(height: 25.0),
                  Container(
                      height: 30.0,
                      width: 95.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.redAccent,
                        color: Colors.red,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () async{
                            await AuthServices.signOut();
                          },
                          child: Center(
                            child: Text(
                              'Log out',
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      ))
                ],
              ))
        ],
      ));
  }
}

class Profile{
  final String namaGuru;
  final String nip;

  Profile({this.namaGuru,this.nip});

  factory Profile.fromJson(Map<dynamic, dynamic>json){
    return Profile(
      namaGuru: (json['nama_guru']),
      nip: (json['nip'])
    );
  }
}
