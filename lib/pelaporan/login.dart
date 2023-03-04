import 'dart:convert';
//import 'dart:io/shared_preferences';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_litbang/myenv.dart';
import 'package:prototype_litbang/pelaporan/inovasi.dart';
import 'package:prototype_litbang/pelaporan/penelitian.dart';


class Login extends StatefulWidget{
  String tipe = '';
  Login(String tipe){
    this.tipe = tipe;
  }

  @override
  _Login createState() => _Login(tipe);
}

class _Login extends State<Login>{
  String tipe = '';
  _Login(String tipe){
    this.tipe = tipe;
  }
  String email = '';
  String password = '';
  String info = '';
  bool logging = false;
  late BuildContext logg;
  MyEnvironments env = new MyEnvironments();

  @override
  Widget build(BuildContext context) {
    double bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - AppBar().preferredSize.height;
    Widget buttonLogin = Container(
      padding: EdgeInsets.fromLTRB(30,5,30,5),
      child: TextButton(onPressed: (){
        authLogin();

      },
        style: TextButton.styleFrom(
          backgroundColor: CupertinoColors.systemBlue,

        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text("LOGIN",
              style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold,

                //BorderRadiusDirectional.all(Radius.circular(30))
              ),
            ),

            SizedBox(
              width: 30,
              height: 40,
            ),

          ],
        ),
      ),
    );
    Widget bodyForm = Container(
        height: bodyHeight,

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image( image: AssetImage("images/makassar.png"),
                width: double.infinity,
                height: 130,),
              Container(
                padding: EdgeInsets.fromLTRB(55,15,55,5),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),

                    ),
                    prefixIcon: Icon(Icons.supervised_user_circle_outlined),
                    hintText: "Username",
                  ),
                  style: TextStyle(

                  ),
                  onChanged: (text){
                    this.email = text;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(55,2,55,2),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    prefixIcon: Icon(Icons.key),
                    hintText: "Password",
                  ),
                  style: TextStyle(

                  ),
                  obscureText: true,
                  onChanged: (text){
                    this.password = text;
                  },
                ),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(55,5,55,5),
                  child: buttonLogin
              ),
              TextButton(onPressed: (){
                Navigator.of(context).pop(context);
              }, child: Text('Kembali')),
              Text(info,style: TextStyle(color: Colors.red),)

            ],
          ),
        ), /* add child content here */
      );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: env.myFont),
      home:
      Scaffold(
        resizeToAvoidBottomInset: false,
        body: bodyForm,

      )

    );
  }

  Future<void> authLogin() async {

    if(logging){
      setState(() {
        info = 'loading';
      });
    }
    var dec;
    showDialog(context: context, builder: (BuildContext logg1) {
      logg = logg1;
      return AlertDialog(title: Center(child: new CircularProgressIndicator()),);
    },);
    logging = true;
     await http.post(
      Uri.https(env.apiUrl, 'api/pelaporan/auth'),
      body: {'username': this.email, 'password': this.password,'tipe': tipe},
    ).then((value){
      dec = jsonDecode(value.body);
      print('apakah ini :'+tipe);
      print(email);
      print(password);

      if(dec['status']){

        Navigator.of(logg).pop();

        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
          return tipe == 'inovasi' ? LaporanInovasi() : LaporanPenelitian();
        }
        ));
      }
      else{
        Navigator.of(logg).pop();
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text('Login Gagal!'),
            content: Text("Email atau Password Anda Salah, Silahkan Cek Kembali!"),
          );
        });
        setState(() {
          this.info = dec['message'];
        });
      }

    });

    logging = false;

  }

}




