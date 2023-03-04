
import 'dart:async';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'agenda/index.dart';
import 'agenda/list.dart';
import 'attachment/list.dart';
import 'berita/list.dart';
import 'inovasi/list.dart';
import 'kelitbangan/kelitbangan.dart';
import 'kelitbangan/list.dart';
import 'login.dart';
import 'mysettings.dart';
import 'penelitian/list.dart';
import 'package:http/http.dart' as http;
import 'usulan-inovasi/list.dart';
import 'myenv.dart';

import 'menu.dart';
import 'pelaporan/list.dart';
import 'regulasi/list.dart';
import 'package:sqflite/sqflite.dart';


class UserMenu extends StatefulWidget{
  _UserMenu createState() => _UserMenu();
  
}

class _UserMenu extends State<UserMenu>{
  MyEnvironments env = MyEnvironments();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: env.myFont),
      home:Scaffold(
          backgroundColor: Color.fromRGBO(20, 80, 200, 100),
        //backgroundColor: Colors.blue.shade900,
          body: GestureDetector(
            onTapCancel: (){
              Navigator.of(context).pop();
            },
            child: Center(child: MyGridMenu())),
          )
          ,
      //initialRoute: '/menu',
      routes: {
        '/menu': (context) => MyGridMenu(),
        '/login' : (context) => Login(),
        '/agenda': (context) => IndexAgenda(),
        '/berita': (context) => ListBerita(),
        '/kelitbangan': (context) => Kelitbangan(),
        '/inovasi': (context) => ListInovasi(),
        '/penelitian': (context) => Kelitbangan(),
      },
    );
  }


}


class MyGridMenu extends StatefulWidget{
  @override
  State<MyGridMenu> createState() => _MyGridMenuState();
}

class _MyGridMenuState extends State<MyGridMenu> {

  String title = 'E-Litbang Makassar Mobile App';
  String title2 = 'E-litbang Kota Makassar Mobile';
  String visi = '';
  String misi = '';
  String profile = '';
  String status ='Menunggu';
  List myBerita = [];
  List myKelitbangan = [];
  bool auth =  false;
  MyEnvironments env = new MyEnvironments();

  late Widget menuAct;
  late Widget menu1;
  late Widget menu2;

  List titleMenu = [
    'Master',
    'Agenda',
    'Berita',
    'Kelitbangan',
    'Inovasi',
    'Penelitian',
    'Usulan Inovasi',
    'Foto',
    'Regulasi',
    'Pelaporan',
    //'Segera'

  ];

  @override
  Widget build(BuildContext context) {
    final myBodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    Color titleColor = Colors.black87;
    Color iconMenuColor = Color.fromARGB(220, 18, 82, 180);
    //Color iconMenuColor = Colors.amberAccent;//Color.fromRGBO(12, 12, 220, 100);
    Color menuColor = CupertinoColors.white;
    double menuIconX = (MediaQuery.of(context).size.width - 30)/3.3/2-8;
    double menuIconSize = menuIconX;


    List colorMenu = [
      Colors.redAccent,
      Colors.blueAccent,
      Colors.greenAccent,
      Colors.amberAccent,
      Colors.orangeAccent,
      Colors.deepOrangeAccent,
      Colors.greenAccent,
      Colors.black54,
      Colors.redAccent,
      Colors.amber,
    ];

    List menuBack = [
      Colors.red.shade50,
      Colors.blue.shade50,
      Colors.green.shade50,
      Colors.amber.shade50,
      Colors.orange.shade50,
      Colors.orange.shade50,
      Colors.green.shade50,
      Colors.black12,
      Colors.red.shade50,
      Colors.amber.shade50,
    ];

    List iconMenu = [
      Icons.admin_panel_settings_rounded,
      Icons.date_range_sharp,
      Icons.new_releases,
      Icons.screen_search_desktop_sharp,
      Icons.lightbulb_circle,
      Icons.content_paste_search_sharp,
      Icons.person_pin,
      Icons.camera_alt,
      Icons.gavel_outlined,
      Icons.edit_note_sharp,
      //Icons.more_horiz_outlined,

    ];

    List navigationMenu = [
      auth == true ? Menu(): Login() ,
      ListAgenda(),
      ListBerita(),
      ListKelitbangan(),
      ListInovasi(),
      ListPenelitian(),
      ListUsulanInovasi(),
      ListFoto(),
      ListRegulasi(),
      ListPelaporan(),
     // null,
    ];

    TextStyle titleStyle = TextStyle(
        color: titleColor,
        fontSize: 10.3,
        fontWeight: FontWeight.bold,
    );

    Color opsColor = Color.fromRGBO(10, 100, 200, 10);

    List<Widget> menus = List.generate(titleMenu.length, (index) => Container(
      //height: 100,
      decoration: BoxDecoration(
       // color: menuBack[index],
       borderRadius: BorderRadiusDirectional.only(bottomEnd: Radius.circular(20),topStart: Radius.circular(20),),
      ),
      child: TextButton(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    //color: Colors.blue,
                    //backgroundBlendMode: BlendMode.multiply,
                    // image: DecorationImage(
                    //     image: AssetImage('images/agenda.svg'),
                    //   fit: BoxFit.fill
                    //
                    // )
                  ),
                  padding: EdgeInsetsDirectional.all(2),
                  child: Icon(iconMenu[index],
                    size: menuIconSize,
                    color: colorMenu[index],
                  )
              ),
            ),
            Container(
             // padding: EdgeInsetsDirectional.all(3),
              decoration: BoxDecoration(
                //color: iconMenuColor,
                borderRadius: BorderRadiusDirectional.circular(10),
                //border: Border.all()
              ),
              child: Center(
                child: Text(titleMenu[index],
                  style: titleStyle
                  // style:TextStyle(
                  //   fontSize: 10,
                  //   color: Colors.black
                  // )

                ),
              ),
            )
          ],),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return navigationMenu[index] != null ? navigationMenu[index] : UserMenu();
          },));
        },
      ),
    ));
    
    List<Widget> menus2 = List.generate(titleMenu.length, (index) => Container(
      
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadiusDirectional.only(bottomStart: Radius.circular(20),topEnd: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.white70 ,
            blurRadius: 4,
            offset: Offset(4, 8), // Shadow position
          ),
        ],
        //border: Border.all()
      ),
      child: TextButton(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
                decoration: BoxDecoration(

                ),
                padding: EdgeInsetsDirectional.all(2),
                child: Icon(iconMenu[index],
                  size: 40,
                  color: Colors.blue.shade700,
                )
            ),
          ),
          Container(
            // padding: EdgeInsetsDirectional.all(3),
            decoration: BoxDecoration(
              //color: iconMenuColor,
              borderRadius: BorderRadiusDirectional.circular(10),
              //border: Border.all()
            ),
            child: Center(
              child: Text(titleMenu[index],
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 10,
                    //fontWeight: FontWeight.bold
                  )
              ),
            ),
          )
        ],),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return navigationMenu[index] != null ? navigationMenu[index] : UserMenu();
          },));
        },
      ),
    ));
    List<Widget> beritas = List.generate(myBerita.length, (index) => Column(
      children: [
        Container(
          child: Text(myBerita[index]['judul'],
            style: TextStyle(
                //fontFamily: 'Poppins',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 11.5
            )
            ,),
        ),
        Container(
          decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadiusDirectional.circular(20),
            image: DecorationImage(image:
            NetworkImage(
                myBerita[index]['attachment'].length == 0 ? "${env.webUrl}/images/appshowcase/slider-iphone.png" :
                "${env.webUrl}/images/upload/${myBerita[index]['attachment'][0]['nama']}"
            ),fit: BoxFit.cover
            ),
            //backgroundBlendMode: BlendMode.colorDodge
          ),
          padding: EdgeInsetsDirectional.all(15),
          //color: Colors.blue,
          height: 110,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Expanded(
              flex: 9,
              child: Container(
                decoration: BoxDecoration(

                ),
              )),
          ],
          ),),
      ],
    ));
    List<Widget> _vm = [
      Column(
      children: [
        Container(
          child: Text('Profile',
            style: TextStyle(
                //fontFamily: 'Poppins',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 11.5
            )
            ,),
        ),
        Container(
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadiusDirectional.circular(20),
            // image: DecorationImage(image:
            // NetworkImage(
            //     myBerita[index]['attachment'].length == 0 ? "${env.webUrl}/images/appshowcase/slider-iphone.png" :
            //     "${env.webUrl}/images/upload/${myBerita[index]['attachment'][0]['nama']}"
            // ),fit: BoxFit.cover
            // ),
            //backgroundBlendMode: BlendMode.colorDodge
          ),
          padding: EdgeInsetsDirectional.all(15),
          //color: Colors.blue,
          height: 110,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 9,
                  child: Text(profile)),
            ],
          ),),
      ],
    ),
      Column(
        children: [
          Container(
            child: SingleChildScrollView(
              child: Text('Visi',
                style: TextStyle(
                    //fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5
                )
                ,),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadiusDirectional.circular(20),
              // image: DecorationImage(image:
              // NetworkImage(
              //     myBerita[index]['attachment'].length == 0 ? "${env.webUrl}/images/appshowcase/slider-iphone.png" :
              //     "${env.webUrl}/images/upload/${myBerita[index]['attachment'][0]['nama']}"
              // ),fit: BoxFit.cover
              // ),
              //backgroundBlendMode: BlendMode.colorDodge
            ),
            padding: EdgeInsetsDirectional.all(15),
            //color: Colors.blue,
            height: 110,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 9,
                    child: Text(visi),
                    ),
              ],
            ),),
        ],
      ),
      Column(
        children: [
          Container(
            child: SingleChildScrollView(
              child: Text('Misi',
                style: TextStyle(
                    // fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13
                )
                ,),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadiusDirectional.circular(20),
              // image: DecorationImage(image:
              // NetworkImage(
              //     myBerita[index]['attachment'].length == 0 ? "${env.webUrl}/images/appshowcase/slider-iphone.png" :
              //     "${env.webUrl}/images/upload/${myBerita[index]['attachment'][0]['nama']}"
              // ),fit: BoxFit.cover
              // ),
              //backgroundBlendMode: BlendMode.colorDodge
            ),
            padding: EdgeInsetsDirectional.all(15),
            //color: Colors.blue,
            height: 110,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 9,
                    child: Text(misi)
                ),
              ],
            ),),
        ],
      ),
    ];
    List<Widget> kelitbangan = List.generate(myBerita.length, (index) => Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          // color: CupertinoColors.white,
          borderRadius: BorderRadiusDirectional.circular(25)
      ),
      padding: EdgeInsetsDirectional.all(5),
      //color: Colors.blue,
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 9,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                    borderRadius: BorderRadiusDirectional.circular(20)
                ),
                alignment: AlignmentDirectional.centerStart,
                padding: EdgeInsetsDirectional.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(myBerita[index]['judul'],
                      style: TextStyle(
                         // fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                      ),),
                    IconButton(onPressed: (){
                      launchUrlString(env.webUrl+'/view-berita/'+myBerita[index]['id'].toString(),mode: LaunchMode.externalApplication);
                    }, icon: Icon(Icons.slideshow, size: 35,),)
                    // Text(myKelitbangan[index]['tanggal'],
                    //   style: TextStyle(
                    //     fontFamily: 'Poppins',
                    //     //fontWeight: FontWeight.bold,
                    //     fontSize: 10,
                    //   ),),
                  ],
                ),
              )),
          // Expanded(child: Container(
          //   width: 10,
          //   color: Colors.blue,
          // )),
          // Expanded(
          //     flex:2,
          //     child: Container(
          //       child: Text(myKelitbangan[index]['tanggal']),
          //     )
          // )
        ],
      ),));
    double menuSpasing = (MediaQuery.of(context).size.width/4)/8;
    menu1 = Container(height: myBodyHeight,
      child: Column(children: [
        Container(height: myBodyHeight*0.25,
          color: Colors.blue.shade900,
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: myBodyHeight*0.25*0.5,
                  decoration: BoxDecoration(
                    // color: Colors.transparent,
                    // borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: AssetImage("images/makassar.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                  //color: Color.fromRGBO(15, 15, 220, 2),

                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(23)),
                    //border: Border.all(color: Colors.white),
                  ),
                  child: Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        //color: CupertinoColors.white,
                        color: Colors.white
                    ),),
                  //color: Color.fromRGBO(15, 15, 220, 2),

                ),
              ),
              // Expanded(child: Container(
              //   // decoration: BoxDecoration(color: CupertinoColors.white,
              //   // ),
              //   child: IconButton(
              //     onPressed: (){
              //       Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              //         return MySettings();
              //       },));
              //     },
              //     icon: Icon(Icons.settings, color: CupertinoColors.white,),
              //   ),
              // )
              // )
              // SizedBox(width: 5,),
            ],
          ),
        ),
        Container(height: myBodyHeight*0.75,
          padding: EdgeInsetsDirectional.all(8),
          decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(20)
          ),
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing:12,
                mainAxisSpacing: 10
            ),children: menus + [
            Container(
              //height: 100,
              decoration: BoxDecoration(
                //color: Colors.blue.shade50,
                borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(20),
                    bottomEnd: Radius.circular(20)
                ),
              ),
              child: TextButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            // image: DecorationImage(
                            //     image: AssetImage("image_icon/home.png"),
                            //     fit: BoxFit.contain
                            // )
                          ),
                          padding: EdgeInsetsDirectional.all(2),
                          child: Icon(Icons.travel_explore,
                            size: menuIconSize,
                            color: iconMenuColor,)
                      ),
                    ),
                    Container(
                      // padding: EdgeInsetsDirectional.all(3),
                      decoration: BoxDecoration(
                        // color: iconMenuColor,
                        borderRadius: BorderRadiusDirectional.circular(10),
                        //border: Border.all()
                      ),
                      child: Text('Website',
                          style: titleStyle
                      ),
                    )
                  ],),
                onPressed: () {
                  launchUrlString(env.webUrl,mode: LaunchMode.externalApplication);
                },
              ),
            ),
            Container(
              //height: 100,
              decoration: BoxDecoration(
               // color: Colors.black12,
                borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(20),
                    bottomEnd: Radius.circular(20)
                ),

              ),
              child: TextButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            // image: DecorationImage(
                            //   image: AssetImage("images/camera.png"),
                            //   fit: BoxFit.contain,
                            //   ),
                          ),
                          padding: EdgeInsetsDirectional.all(2),
                          child: Icon(Icons.more_horiz,
                            size: menuIconSize,
                            color: Colors.black54,)
                      ),
                    ),
                    Container(
                      // padding: EdgeInsetsDirectional.all(3),
                      decoration: BoxDecoration(
                        // color: iconMenuColor,
                        borderRadius: BorderRadiusDirectional.circular(10),
                        //border: Border.all()
                      ),
                      child: Text('Segera',
                          style: titleStyle
                      ),
                    )
                  ],),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                    return UserMenu();
                  },));
                },
              ),
            )
          ],
          ),
        ),

      ],
      ),);
    menu2 = Container(
      height: myBodyHeight,
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Column(
        children: [
          Container(
            height: myBodyHeight * 0.3,
            decoration: BoxDecoration(
              //color: Colors.blueAccent,
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(40),
              ),
              gradient: LinearGradient(colors: [
                Colors.blue.shade800,
                Colors.blue.shade700,
              ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
            )
            ),
            child: Center(
              child: Row(
                //mainAxisAlignment: ,
                children: [
                  Expanded(child: Container()),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(image: AssetImage('images/makassar.png',),width: 70),
                        SizedBox(height: 7,),
                        Text(title2,style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15
                        ),)
                      ],
                    ),
                  ),
                  Expanded(

                      child: Column(
                    children: [
                      //IconButton(onPressed: (){}, icon: Icon(Icons.help, color: Colors.white,))
                    ],
                  )),
                ],
              ),
            ),
          ),
          Container(
            height: myBodyHeight * 0.70,
            padding: EdgeInsets.all(15),
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing:12,
                  mainAxisSpacing: 10
              ),children: menus2 + [
              Container(
                //height: 100,
                decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadiusDirectional.only(bottomStart: Radius.circular(20),topEnd: Radius.circular(20))
                ),
                child: TextButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                              // image: DecorationImage(
                              //     image: AssetImage("image_icon/home.png"),
                              //     fit: BoxFit.contain
                              // )
                            ),
                            padding: EdgeInsetsDirectional.all(2),
                            child: Icon(Icons.travel_explore,
                              size: 40,
                              color: Colors.blue.shade700,)
                        ),
                      ),
                      Container(
                        // padding: EdgeInsetsDirectional.all(3),
                        decoration: BoxDecoration(
                          // color: iconMenuColor,
                          borderRadius: BorderRadiusDirectional.circular(10),
                          //border: Border.all()
                        ),
                        child: Text('Website',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 10,
                            )
                        ),
                      )
                    ],),
                  onPressed: () {
                    launchUrlString(env.webUrl,mode: LaunchMode.externalApplication);
                  },
                ),
              ),
              // Container(
              //   //height: 100,
              //   decoration: BoxDecoration(
              //     color: Colors.blue.shade50,
              //     borderRadius: BorderRadiusDirectional.only(bottomStart: Radius.circular(20),topEnd: Radius.circular(20)),
              //
              //   ),
              //   child: TextButton(
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Expanded(
              //           child: Container(
              //               decoration: BoxDecoration(
              //               ),
              //               padding: EdgeInsetsDirectional.all(2),
              //               child: Icon(Icons.more_horiz,
              //                 size: 40,
              //                 color: Colors.blue.shade700,)
              //           ),
              //         ),
              //         Container(
              //           // padding: EdgeInsetsDirectional.all(3),
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadiusDirectional.circular(10),
              //           ),
              //           child: Text('Model 1',
              //               style: TextStyle(
              //                 color: Colors.black87,
              //                 fontSize: 10,
              //               )
              //           ),
              //         )
              //       ],),
              //     onPressed: () {
              //       // setState(() {
              //       //     menuAct = menu1;
              //       //     title = 'Haloooooo';
              //       //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
              //       //       return UserMenu();
              //       //     },));
              //       // });
              //       changeMenu();
              //     },
              //   ),
              // )
            ],
            ),
          )
        ],
      ),
    );
    menuAct = menu2;
    return menuAct;

  }

  cekInternet() async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    setState((){
      status = isConnected == true ? 'Connected' : 'No Connection';
    });
  }

  changeMenu(){
    setState((){
      menuAct = menu1;
      //title = 'Aloo';
      //titleMenu[0] = 'Admin';

    });


  }

  getberitas() async {

     await http.get(
      Uri.https(env.apiUrl, 'api/berita/terkini'),
      headers: {
        'Content-Type' : 'aplication/json; charset=UTF-8',
        'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImZkNDQzZGJhMzdkY2NjNTQzYmU4MTkzOWY0OTQ0MTkzZDc1YzZjYzcxNDY1YjBjOTIxOGE4MWM3NzVkZTkwNTM2Yjk1M2M4N2FjNGE0ODY4In0.eyJhdWQiOiIyIiwianRpIjoiZmQ0NDNkYmEzN2RjY2M1NDNiZTgxOTM5ZjQ5NDQxOTNkNzVjNmNjNzE0NjViMGM5MjE4YTgxYzc3NWRlOTA1MzZiOTUzYzg3YWM0YTQ4NjgiLCJpYXQiOjE2NjE5Mjg1OTgsIm5iZiI6MTY2MTkyODU5OCwiZXhwIjoxNjYxOTQ2NTk3LCJzdWIiOiIxNSIsInNjb3BlcyI6WyIqIl19.SUO0yl0Zqtzmn0ex_uR-vlh2mxXgjl1-am6MxpkcAal9aHt8nSLyOOBAFn4bTy3Szx2HJGMv_k5bzZ-JTU_yfHU5rqcYjjCWYclFoh8P1RWrhrFySxG_mNzbm5fDEB7913Wm5y5qRgt-ffOIYjYGQ1XX0EjU2bAgvdAFGA41g4r5KGT2-D88EGw1gQ8knRTxZOcIv_kqkCvQsGI4Ov3KGGgcYfi_7Q5nrNRqEPthycFMtUlX0QoFh-M2FRItE86ElVGSYREK6tt9vBsvhi07azBLQdShneFa8YNAg_lrhk0PQ4SKifpzCDdumyJNtNDDIqgsaMUiWMu9O0zZUxzHX-HYtuixDTWznjJm2DPWNUUfnClNIUpS7rautiie9aZvDV-BpLY6AO4xc_9omAzedytBbI7nivzy-M0tfv1MqnhmeggKNaSPhGiIqGKXedEjzhsVuaX7AZqdj5e7BqMUm-MnTD2A78VYyaYZhr9Soii98rzmgp8JzpLxFwaU-RsMfDMc5nU0_OOJ7hgagzDyh4HUxZEOqJgrPq8IPWAEvRiErxUNJlyxgGmt7BCebvS9Sq-ZqVUJGCo1LrvGTvAAFwZ9VjzmzAHwxUPfboStUt-W1TjzTUuV00YOqcETiFnnwq3c9yY02xoIsv9iCc56_A_idARPkcZWyOIzgldI6d0',
      },
    ).then((value) {

      var beritas = jsonDecode(value.body)['data'];
      setState(() {
        myBerita = beritas;
      });
    });
  }

  getkelitbangan() async {

    await http.get(
      Uri.https(env.apiUrl, 'api/kelitbangan/terkini'),
      headers: {
        'Content-Type' : 'aplication/json; charset=UTF-8',
        'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImZkNDQzZGJhMzdkY2NjNTQzYmU4MTkzOWY0OTQ0MTkzZDc1YzZjYzcxNDY1YjBjOTIxOGE4MWM3NzVkZTkwNTM2Yjk1M2M4N2FjNGE0ODY4In0.eyJhdWQiOiIyIiwianRpIjoiZmQ0NDNkYmEzN2RjY2M1NDNiZTgxOTM5ZjQ5NDQxOTNkNzVjNmNjNzE0NjViMGM5MjE4YTgxYzc3NWRlOTA1MzZiOTUzYzg3YWM0YTQ4NjgiLCJpYXQiOjE2NjE5Mjg1OTgsIm5iZiI6MTY2MTkyODU5OCwiZXhwIjoxNjYxOTQ2NTk3LCJzdWIiOiIxNSIsInNjb3BlcyI6WyIqIl19.SUO0yl0Zqtzmn0ex_uR-vlh2mxXgjl1-am6MxpkcAal9aHt8nSLyOOBAFn4bTy3Szx2HJGMv_k5bzZ-JTU_yfHU5rqcYjjCWYclFoh8P1RWrhrFySxG_mNzbm5fDEB7913Wm5y5qRgt-ffOIYjYGQ1XX0EjU2bAgvdAFGA41g4r5KGT2-D88EGw1gQ8knRTxZOcIv_kqkCvQsGI4Ov3KGGgcYfi_7Q5nrNRqEPthycFMtUlX0QoFh-M2FRItE86ElVGSYREK6tt9vBsvhi07azBLQdShneFa8YNAg_lrhk0PQ4SKifpzCDdumyJNtNDDIqgsaMUiWMu9O0zZUxzHX-HYtuixDTWznjJm2DPWNUUfnClNIUpS7rautiie9aZvDV-BpLY6AO4xc_9omAzedytBbI7nivzy-M0tfv1MqnhmeggKNaSPhGiIqGKXedEjzhsVuaX7AZqdj5e7BqMUm-MnTD2A78VYyaYZhr9Soii98rzmgp8JzpLxFwaU-RsMfDMc5nU0_OOJ7hgagzDyh4HUxZEOqJgrPq8IPWAEvRiErxUNJlyxgGmt7BCebvS9Sq-ZqVUJGCo1LrvGTvAAFwZ9VjzmzAHwxUPfboStUt-W1TjzTUuV00YOqcETiFnnwq3c9yY02xoIsv9iCc56_A_idARPkcZWyOIzgldI6d0',
      },

    ).then((value) {
      // setState(){
      var litbang = jsonDecode(value.body)['data'];
      setState(() {
        myKelitbangan = litbang;
      });
    });

  }

  getAuth () async {
    this.auth = await SessionManager().get('auth') == null ? false : await SessionManager().get('auth') ;
    String _token = await SessionManager().get('_token') == null ? '' : await SessionManager().get('_token');


    await http.get(
      Uri.https(env.apiUrl, 'api/auth/check'),
      headers: {
        'Content-Type' : 'aplication/json; charset=UTF-8',
        'Authorization': 'Bearer ${_token}'
      },

    ).then((value) async {

      var cek = jsonDecode(value.body);
      this.auth = cek['status'] == true ? true : false;

    });
  }

  Future<void> getPref () async {
    String _token = '';
    await http.get(
        Uri.https(env.apiUrl, 'api/pref/get'),
        headers: {
          'Authorization': 'Bearer ${_token}'
        }

    ).then((value) async {
      // setState(){
      var cek = jsonDecode(value.body);
      if(cek['status'] == true){
        setState((){
          env.myFont = cek['data']['font'] == null ? 'Poppins' : cek['data']['font'];
          title = cek['data']['title'] == null ? 'E-Litbang Makassar Mobile' : cek['data']['title'];
          misi = cek['data']['misi'] == null ? '-' : cek['data']['misi'];
          visi = cek['data']['visi'] == null ? '-' : cek['data']['visi'];
          profile = cek['data']['profile'] == null ? '-' : cek['data']['profile'];
        });

      }
      else{
        showDialog(context: context, builder: (BuildContext ex) {
          return AlertDialog(title: Row(
            children: [
              Expanded(
                flex:9,
                child: Text(cek['message'],
                  style: TextStyle(
                      fontFamily: 'Poppins'
                  ),),
              ),
            ],
          ),);
        },);
      }

    });
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
       // getberitas();
       // getkelitbangan();
        getAuth();
        getPref();
    });
  }
}

