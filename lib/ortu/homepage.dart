import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:login/ortu/input_nis.dart' as beranda;
import 'tab_akun.dart' as profile;

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with SingleTickerProviderStateMixin {
  TabController controller;

  static FirebaseAuth _auth = FirebaseAuth.instance;

  String uid;

  Timer timer;
  int counter = 0;

  queryId()async{
    final FirebaseUser user = await _auth.currentUser();
    uid = user.uid.toString();
  }

  @override
  void initState() {
    super.initState();
    queryId();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => addValue());
    controller = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    controller.dispose();
  }

  void addValue() {
    setState(() {
       counter++; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: new Text("Parenting Control"),
        bottom: new TabBar(
          controller: controller,
          tabs: <Widget>[
            new Tab(
              icon: new Icon(Icons.person),
            ),
            new Tab(
              icon: new Icon(Icons.home),
            ),
          ],
        ),
      ),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new profile.Akun(
            unik: uid,
          ),
          new beranda.BuatKelas(),
        ],
      ),
    );
  }
}
