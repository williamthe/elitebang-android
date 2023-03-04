import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_litbang/myenv.dart';


class ViewAgenda extends StatefulWidget{
  Map myData = {};
  ViewAgenda(listData){
    this.myData = listData;
  }

  _ViewAgenda createState() => _ViewAgenda(myData);

}

class _ViewAgenda extends State<ViewAgenda>{
  Map myData = {};
  _ViewAgenda(Map myData){
    this.myData = myData;
  }
  MyEnvironments env = new MyEnvironments();

  @override
  Widget build(BuildContext context) {
    double bodyHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: env.myFont),
        home:Scaffold(
          body:Container(
            height: bodyHeight,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20),
                  height: bodyHeight * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade900,
                    borderRadius: BorderRadiusDirectional.circular(20)

                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(onPressed: (){
                            Navigator.of(context).pop();
                          }, icon: Icon(
                            Icons.arrow_circle_left,
                            color: Colors.white,)
                          ),
                        ],
                      ),
                      SizedBox(height: 35,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //Icon(Icons.schedule, color: Colors.white, size: 50,),
                                Text(myData['nama'],
                                  style: TextStyle(
                                    color: Colors.white,
                                      fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsetsDirectional.all(15),
                  height: bodyHeight * 0.7,
                  child: Column(
                    children: [
                      Container(height: bodyHeight * 0.05,),
                      Container(
                        padding: EdgeInsetsDirectional.all(10),
                        height: bodyHeight * 0.15,
                        decoration: BoxDecoration(
                         color: Colors.blue.shade50,
                            borderRadius: BorderRadiusDirectional.only(
                              bottomStart: Radius.circular(20),
                              topEnd: Radius.circular(20),
                            )

                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Icon(
                                Icons.place,
                                color: Colors.blue.shade800,
                              size: 40,),
                              flex: 3,),
                            Expanded(
                              flex : 8,
                              child: SingleChildScrollView(
                                child: Text(myData['tempat'],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(height: bodyHeight * 0.01,),
                      Container(
                        padding: EdgeInsetsDirectional.all(10),
                        height: bodyHeight * 0.15,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadiusDirectional.only(
                                bottomStart: Radius.circular(20),
                              topEnd: Radius.circular(20),
                            )

                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Icon(
                                Icons.date_range,
                                color: Colors.blue.shade800,
                                size: 40,
                              ),
                              flex: 3,),
                            Expanded(
                              flex : 8,
                              child: Text(myData['tanggal'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,

                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(height: bodyHeight * 0.01,),
                      Container(
                        padding: EdgeInsetsDirectional.all(10),
                        height: bodyHeight * 0.15,
                        decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                            borderRadius: BorderRadiusDirectional.only(
                              bottomStart: Radius.circular(20),
                              topEnd: Radius.circular(20),
                            )

                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Icon(
                                Icons.watch_later_outlined,
                                color: Colors.blue.shade800,
                                size: 40,
                              ),
                              flex: 3,),
                            Expanded(
                              flex : 8,
                              child: Text(myData['waktu'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          )
        )
    );
  }

}


