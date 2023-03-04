import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'menu.dart';
import 'myenv.dart';

class Login extends StatefulWidget{
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login>{

  MyEnvironments env = new MyEnvironments();

  String email = '';
  String password = '';
  String info = '';
  bool logging = false;
  late Widget buttonLogin ;
  late Widget loginActive ;
  late Widget loginInActive ;
  late BuildContext logg;

  @override
  Widget build(BuildContext context) {
    double bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - AppBar().preferredSize.height;

    Widget login1 = Container(
      height: bodyHeight,
      decoration: BoxDecoration(
        // image: DecorationImage(
        //   image: AssetImage("images/makassar.png"),
        //   fit: BoxFit.cover,
        // ),
      ),
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
                  prefixIcon: Icon(Icons.email_outlined),
                  hintText: "Email",
                ),
                style: TextStyle(
                    fontFamily: 'Poppins'
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
                    fontFamily: 'Poppins'
                ),
                obscureText: true,
                onChanged: (text){
                  this.password = text;
                },
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(55,5,55,5),
                child: Container(
                  padding: EdgeInsets.fromLTRB(30,5,30,5),
                  child: TextButton(onPressed: (){
                    authLogin();
                    if(logging){
                      setState(() {

                        info = 'loading';
                      });
                    }},
                    style: TextButton.styleFrom(
                      backgroundColor: CupertinoColors.systemBlue,

                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text("LOGIN",
                          style: TextStyle(color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins'
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
                )
            ),
            Text(info,style: TextStyle(color: Colors.red),)

          ],
        ),
      ), /* add child content here */
    );
    Widget login2 = Container(
      height: bodyHeight,
      decoration: BoxDecoration(

      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: bodyHeight * 0.33,
              decoration: BoxDecoration(
                color: Color.fromRGBO(20, 80, 200, 20),
                borderRadius: BorderRadiusDirectional.circular(15)
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Image(
                      image: AssetImage('images/makassar.png'),
                      fit: BoxFit.scaleDown,
                      height: 130,
                    ),
                    Container( height: bodyHeight * 0.33 * 0.05,),
                    Text('Master Login', style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),)
                  ],
                ),
              ),
              
            ),
            Container(
              height : bodyHeight * 0.67,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(55,10,55,5),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: "Email",
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
                      obscureText: true,
                      onChanged: (text){
                        this.password = text;
                      },
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(45,5,45,5),
                      decoration: BoxDecoration(
                          //borderRadius: BorderRadiusDirectional.circular(15)
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          //borderRadius: BorderRadiusDirectional.circular(15)
                        ),
                        padding: EdgeInsets.fromLTRB(30,5,30,5),
                        child: TextButton(onPressed: (){
                          authLogin();
                          if(logging){
                            setState(() {
                              info = 'loading';
                            });
                          }},
                          style: TextButton.styleFrom(
                            //backgroundColor: Colors.blueAccent,

                          ),
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(15),
                              color: Colors.blueAccent
                            ),
                            child: Center(
                              child: Text('login', style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                              ),),
                            ),
                          ),
                        ),
                      )
                  ),
                  Text(info,style: TextStyle(color: Colors.red),)
                ],
              ),
              decoration: BoxDecoration(

              ),
            ),
          ],
        ),
      ),

    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: env.myFont),
      home: Scaffold(
        //backgroundColor: Color.fromRGBO(20, 80, 200, 100),
        body: login2,
      ),
    );
  }

  Future<void> authLogin() async {

    var dec;
    showDialog(context: context, builder: (BuildContext logg1) {
      logg = logg1;
      return AlertDialog(title: Center(child: new CircularProgressIndicator()),);
    },);
    logging = true;
    await http.post(
      Uri.https(env.apiUrl, 'api/auth/login'),
      body: {'email': this.email, 'password': this.password},
    ).then((value) async {
      dec = jsonDecode(value.body);

      if(dec['status']){

        SessionManager().set("_token", dec['data']['access_token']);
        SessionManager().set("user_id", dec['data']['user']['id']);
        SessionManager().set("user", dec['data']['user']['username']);
        SessionManager().set("auth", true);

        var authed = await SessionManager().get("auth");
        print(authed);

        Navigator.of(logg).pop();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
          return authed == true ? Menu() : Login();
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

  }

}