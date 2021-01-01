import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'package:provider/provider.dart';
import 'guru/wrapper.dart';

class VerifikasiGuru extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.firebaseUserStream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}