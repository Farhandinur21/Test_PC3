import 'package:flutter/material.dart';
import 'package:login/ortu/absen_nilai.dart';

class BuatKelas extends StatefulWidget {
  final String unik;
  BuatKelas({this.unik});

  @override
  _BuatKelasState createState() => _BuatKelasState();
}

class _BuatKelasState extends State<BuatKelas> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nisInput = new TextEditingController();

  check() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
    }
  }

  nisCek(){
    if(nisInput.text == ''){
      check();
    }else{
      return submit();
    }
  }

  void submit() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Tabhome(
          nisAnak: nisInput.text,
        )));
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
              "Input Nis Anak",
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
                      controller: nisInput,
                      keyboardType: TextInputType.number,
                      validator: (e) {
                        if (e.isEmpty) {
                          return "Isi Nis";
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
                        hintText: "Masukkan Nis",
                        hintStyle: TextStyle(color: Colors.black87),
                        labelText: "Nis",
                        labelStyle: TextStyle(color: Colors.black87),
                      )),
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                    ),
                    height: 10,
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
                        onTap: () {
                          check();
                          //submit();
                          nisCek();
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
