import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/guru/loginscreen.dart';
import 'package:login/auth_service.dart';
import 'package:firebase_database/firebase_database.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String alert = "isi data diri";
  static FirebaseAuth _auth = FirebaseAuth.instance;
  final _key = new GlobalKey<FormState>();

  DatabaseReference buatDataGuru = FirebaseDatabase.instance.reference()
    .child('data')
    .child('orang_tua');

  TextEditingController namaLengkapInput = new TextEditingController();
  TextEditingController emailInput = new TextEditingController();
  TextEditingController nisInput = new TextEditingController();
  TextEditingController passwordInput = new TextEditingController();

  dataOrtu() async {
    final FirebaseUser user = await _auth.currentUser();
    String uid = user.uid;

    buatDataGuru.child(uid).set({
      'nama_ortu' : namaLengkapInput.text,
      'email' : emailInput.text,
      'nis' : nisInput.text,
    });
  }

  kondisiKirim(){
    if(namaLengkapInput.text == "" 
      || emailInput.text == ""
      || nisInput.text == ""
      || passwordInput.text == ""){
        check();
    }else{
      dataOrtu();
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
    }
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
              "Register",
              style: TextStyle(fontSize: 30.0, color: Colors.black),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
            ),
            Text(alert),
            SizedBox(
              child: Padding(
                padding: EdgeInsets.all(20.0),
              ),
              height: 20,
            ),
            Form(
              key: _key,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: namaLengkapInput,
                    validator: (e) {
                      if (e.isEmpty) {
                        return "Isi Nama Lengkap Anda";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87)
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        size: 25.0,
                      ),
                      hintText: "Masukkan Nama Lengkap",
                      hintStyle: TextStyle(color: Colors.black87),
                      labelText: "Nama Lengkap",
                      labelStyle: TextStyle(color: Colors.black87),
                    )
                  ),
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                    ),
                    height: 10,
                  ),
                  TextFormField(
                    controller: emailInput,
                    validator: (e) {
                      if (e.isEmpty) {
                        return "Isi Username Anda";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87)
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        size: 25.0,
                      ),
                      hintText: "Masukkan Email",
                      hintStyle: TextStyle(color: Colors.black87),
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.black87),
                    )
                  ),
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                    ),
                    height: 10,
                  ),
                  TextFormField(
                      controller: nisInput,
                      validator: (e) {
                        if (e.isEmpty) {
                          return "Isi NIS Anak Anda";
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
                        hintText: "Isi NIS anak anda",
                        hintStyle: TextStyle(color: Colors.black87),
                        labelText: "NIS anak anda",
                        labelStyle: TextStyle(color: Colors.black87),
                      )),
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                    ),
                    height: 10,
                  ),
                  TextFormField(
                      controller: passwordInput,
                      validator: (e) {
                        if (e.isEmpty) {
                          return "Isi Password Anda";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87)),
                        prefixIcon: Icon(
                          Icons.vpn_key,
                          size: 25.0,
                        ),
                        hintText: "Masukkan Password",
                        hintStyle: TextStyle(color: Colors.black87),
                        labelText: "Password",
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
                          splashColor: Colors.white,
                          child: Center(
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  fontSize: 20, color: Colors.white
                                ),
                              ),
                            ),
                            onTap: () async {
                              await AuthServices.signUp(
                                emailInput.text, passwordInput.text
                              );
                              kondisiKirim();
                            }
                          )
                        ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
