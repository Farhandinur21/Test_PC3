import 'package:flutter/material.dart';
import 'package:login/guru/loginscreen.dart';

class Welcomescreen extends StatefulWidget {
  @override
  _WelcomescreenState createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {
  void lewat() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        //width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20.0),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
              padding: EdgeInsets.all(3),
              child: Image.asset("img/pcontrol.jpg"),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Center(
                child: Text(
                  "SELAMAT DATANG DI P-CONTROL",
                  style: TextStyle(fontSize: 15.0, color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Center(
                child: Text(
                  "APLIKASI YANG MEMPERMUDAH ORANG TUA UNTUK MELIHAT NILAI ANAKNYA",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Center(
                child: Text(
                  "SILAHKAN PILIH",
                  style: TextStyle(fontSize: 15.0, color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              color: Colors.green,
              elevation: 5,
              child: Container(
                height: 35.0,
                child: InkWell(
                  onTap: () => lewat(),
                  splashColor: Colors.white,
                  child: Center(
                    child: Text(
                      "Guru",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              color: Colors.green,
              elevation: 5,
              child: Container(
                height: 35.0,
                child: InkWell(
                  onTap: () => lewat(),
                  splashColor: Colors.white,
                  child: Center(
                    child: Text(
                      "Orang tua",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
