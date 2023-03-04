
import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_litbang/myenv.dart';

class FormBaru extends StatefulWidget{
  @override
  State<FormBaru> createState() => _FormBaruState();
}

class _FormBaruState extends State<FormBaru> {

  MyEnvironments env = new MyEnvironments();

  String nomor = '';
  String tanggal = '';
  int instansi = 0;
  String nama = '';
  String tujuan = '';
  String manfaat = '';
  String hasil = '';
  String deskripsi = '';
  String kelengkapan = '';
  String pelaksana = '';

  late BuildContext simpan;
  Widget w_bidang = Container();

  List listInstansi = [];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
            padding: EdgeInsetsDirectional.all(5),
            height: 160,
            decoration: BoxDecoration(
              // border: BorderDirectional(),
                borderRadius: BorderRadius.circular(20),
                color: CupertinoColors.white
            ),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex:3,
                  child: Container(
                    child: Text('Nomor',
                      style: TextStyle(fontSize: 14, color: Colors.black,

                      ),
                    ),
                    padding: EdgeInsetsDirectional.all(13),
                    //color: Colors.lightBlue,
                    decoration: BoxDecoration(
                      //   color: Colors.black12,
                        borderRadius: BorderRadiusDirectional.circular(15)
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                      padding: EdgeInsetsDirectional.all(15),
                      decoration: BoxDecoration(border: Border(),
                        //color: Colors.black12
                      ),
                      child: TextFormField(
                        controller: TextEditingController(text: nomor),
                        style: TextStyle(
                          fontSize: 14
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                          ),
                          suffixIcon: Icon(Icons.numbers_sharp)
                        ),
                        onChanged: (e){
                          nomor = e;
                        },

                      ),
                  ),
                ),
              ],)
        ),
        Container(height: 10,),
        Container(
            padding: EdgeInsetsDirectional.all(5),
            height: 160,
            decoration: BoxDecoration(
              // border: BorderDirectional(),
                borderRadius: BorderRadius.circular(20),
                color: CupertinoColors.white
            ),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex:3,

                  child: Container(
                    child: Text('Tanggal',
                      style: TextStyle(fontSize: 14, color: Colors.black,

                      ),
                    ),
                    padding: EdgeInsetsDirectional.all(13),
                    //color: Colors.lightBlue,
                    decoration: BoxDecoration(
                      //   color: Colors.black12,
                        borderRadius: BorderRadiusDirectional.circular(15)
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                      padding: EdgeInsetsDirectional.all(15),
                      child: TextField(
                        
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(onPressed: (){
                            showDatePicker(context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2099)).then((value) => setState((){
                              tanggal = value.toString().split(" ")[0];
                            }));
                          }, icon: Icon(Icons.date_range)),
                        ),
                        onChanged: (e){
                          setState(() {
                            tanggal = e;
                          });
                        },
                        controller: TextEditingController(text: tanggal),
                      ),
                      decoration: BoxDecoration(border: Border(),
                        //color: Colors.black12
                      )
                  ),
                ),
              ],)
        ),
        Container(height: 10,),
        w_bidang,
        Container(height: 10,),
        Container(
            padding: EdgeInsetsDirectional.all(5),
            height: 160,
            decoration: BoxDecoration(
              // border: BorderDirectional(),
                borderRadius: BorderRadius.circular(20),
                color: CupertinoColors.white
            ),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex:3,

                  child: Container(
                    child: Text('Nama',
                      style: TextStyle(fontSize: 14, color: Colors.black,

                      ),
                    ),
                    padding: EdgeInsetsDirectional.all(13),
                    //color: Colors.lightBlue,
                    decoration: BoxDecoration(
                      //   color: Colors.black12,
                        borderRadius: BorderRadiusDirectional.circular(15)
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                      padding: EdgeInsetsDirectional.all(15),
                      child: TextFormField(
                        maxLines: 10,
                        minLines: 2,
                        onChanged: (e){
                          nama = e;
                        },
                        controller: TextEditingController(text: nama),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: Icon(Icons.abc_sharp)
                        ),
                      ),
                      decoration: BoxDecoration(border: Border(),
                        //color: Colors.black12
                      )
                  ),
                ),
              ],)
        ),
        Container(height: 10,),
        Container(
            padding: EdgeInsetsDirectional.all(5),
            height: 180,
            decoration: BoxDecoration(
              // border: BorderDirectional(),
                borderRadius: BorderRadius.circular(20),
                color: CupertinoColors.white
            ),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex:3,
                  child: Container(
                    child: Text('Tujuan',
                      style: TextStyle(fontSize: 14, color: Colors.black,

                      ),
                    ),
                    padding: EdgeInsetsDirectional.all(13),
                    //color: Colors.lightBlue,
                    decoration: BoxDecoration(
                      //   color: Colors.black12,
                        borderRadius: BorderRadiusDirectional.circular(15)
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Container(
                      padding: EdgeInsetsDirectional.all(15),
                      child: TextFormField(
                        maxLines: 10,
                        minLines: 3,
                        onChanged: (e){
                          tujuan = e;
                        },
                        controller: TextEditingController(text: tujuan),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: Icon(Icons.location_searching)
                        ),
                      ),
                      decoration: BoxDecoration(border: Border(),
                        //color: Colors.black12
                      )
                  ),
                ),
              ],)
        ),
        Container(height: 10,),
        Container(
            padding: EdgeInsetsDirectional.all(5),
            height: 180,
            decoration: BoxDecoration(
              // border: BorderDirectional(),
                borderRadius: BorderRadius.circular(20),
                color: CupertinoColors.white
            ),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex:3,
                  child: Container(
                    child: Text('Manfaat',
                      style: TextStyle(fontSize: 14, color: Colors.black,

                      ),
                    ),
                    padding: EdgeInsetsDirectional.all(13),
                    //color: Colors.lightBlue,
                    decoration: BoxDecoration(
                      //   color: Colors.black12,
                        borderRadius: BorderRadiusDirectional.circular(15)
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Container(
                      padding: EdgeInsetsDirectional.all(15),
                      child: TextFormField(
                        maxLines: 10,
                        minLines: 3,
                        onChanged: (e){
                          manfaat = e;
                        },
                        controller: TextEditingController(text: manfaat),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: Icon(Icons.security_update_good)
                        ),
                      ),
                      decoration: BoxDecoration(border: Border(),
                        //color: Colors.black12
                      )
                  ),
                ),
              ],)
        ),
        Container(height: 10,),
        Container(
            padding: EdgeInsetsDirectional.all(5),
            height: 180,
            decoration: BoxDecoration(
              // border: BorderDirectional(),
                borderRadius: BorderRadius.circular(20),
                color: CupertinoColors.white
            ),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex:3,
                  child: Container(
                    child: Text('Hasil',
                      style: TextStyle(fontSize: 14, color: Colors.black,

                      ),
                    ),
                    padding: EdgeInsetsDirectional.all(13),
                    //color: Colors.lightBlue,
                    decoration: BoxDecoration(
                      //   color: Colors.black12,
                        borderRadius: BorderRadiusDirectional.circular(15)
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Container(
                      padding: EdgeInsetsDirectional.all(15),
                      child: TextFormField(
                        maxLines: 10,
                        minLines: 3,
                        onChanged: (e){
                          hasil = e;
                        },
                        controller: TextEditingController(text: hasil),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: Icon(Icons.star)
                        ),
                      ),
                      decoration: BoxDecoration(border: Border(),
                        //color: Colors.black12
                      )
                  ),
                ),
              ],)
        ),
        Container(height: 10,),
        Container(
            padding: EdgeInsetsDirectional.all(5),
            height: 180,
            decoration: BoxDecoration(
              // border: BorderDirectional(),
                borderRadius: BorderRadius.circular(20),
                color: CupertinoColors.white
            ),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex:3,
                  child: Container(
                    child: Text('Deskripsi',
                      style: TextStyle(fontSize: 14, color: Colors.black,

                      ),
                    ),
                    padding: EdgeInsetsDirectional.all(13),
                    //color: Colors.lightBlue,
                    decoration: BoxDecoration(
                      //   color: Colors.black12,
                        borderRadius: BorderRadiusDirectional.circular(15)
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Container(
                      padding: EdgeInsetsDirectional.all(15),
                      child: TextFormField(
                        maxLines: 10,
                        minLines: 3,
                        onChanged: (e){
                          deskripsi = e;
                        },
                        controller: TextEditingController(text: deskripsi),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: Icon(Icons.description)
                        ),
                      ),
                      decoration: BoxDecoration(border: Border(),
                        //color: Colors.black12
                      )
                  ),
                ),
              ],)
        ),
        Container(height: 10,),
        Container(
            padding: EdgeInsetsDirectional.all(5),
            height: 180,
            decoration: BoxDecoration(
              // border: BorderDirectional(),
                borderRadius: BorderRadius.circular(20),
                color: CupertinoColors.white
            ),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex:3,
                  child: Container(
                    child: Text('Kelengkapan',
                      style: TextStyle(fontSize: 14, color: Colors.black,

                      ),
                    ),
                    padding: EdgeInsetsDirectional.all(13),
                    //color: Colors.lightBlue,
                    decoration: BoxDecoration(
                      //   color: Colors.black12,
                        borderRadius: BorderRadiusDirectional.circular(15)
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Container(
                      padding: EdgeInsetsDirectional.all(15),
                      child: TextFormField(
                        maxLines: 10,
                        minLines: 3,
                        onChanged: (e){

                          kelengkapan = e;
                        },
                        controller: TextEditingController(text: kelengkapan),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: Icon(Icons.important_devices)
                        ),
                      ),
                      decoration: BoxDecoration(border: Border(),
                        //color: Colors.black12
                      )
                  ),
                ),
              ],)
        ),
        Container(height: 10,),
        Container(
            padding: EdgeInsetsDirectional.all(5),
            height: 180,
            decoration: BoxDecoration(
              // border: BorderDirectional(),
                borderRadius: BorderRadius.circular(20),
                color: CupertinoColors.white
            ),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex:3,
                  child: Container(
                    child: Text('Pelaksana',
                      style: TextStyle(fontSize: 14, color: Colors.black,

                      ),
                    ),
                    padding: EdgeInsetsDirectional.all(13),
                    //color: Colors.lightBlue,
                    decoration: BoxDecoration(
                      //   color: Colors.black12,
                        borderRadius: BorderRadiusDirectional.circular(15)
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Container(
                      padding: EdgeInsetsDirectional.all(15),
                      child: TextFormField(
                        maxLines: 10,
                        minLines: 3,
                        onChanged: (e){
                          pelaksana = e;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: Icon(Icons.supervised_user_circle)
                        ),
                        controller: TextEditingController(text: pelaksana),
                      ),

                      decoration: BoxDecoration(border: Border(),
                        //color: Colors.black12
                      )
                  ),
                ),
              ],)
        ),
        Container(height: 10,),
        Container(
            padding: EdgeInsetsDirectional.all(10),
            height: 70,
            decoration: BoxDecoration(
              border: BorderDirectional(),
                borderRadius: BorderRadius.circular(20),
                //color: CupertinoColors.white
            ),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  //flex: 9,
                  child: Container(
                    //height: 60,
                      width: double.infinity,
                      padding: EdgeInsetsDirectional.all(5),
                      child: TextButton(
                        child: Text('simpan',
                          style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,),),
                        onPressed: (){
                          store();
                        },
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                          ),
                          borderRadius: BorderRadiusDirectional.circular(10),
                          color: Colors.greenAccent
                      )
                  ),
                ),
              ],)
        ),

      ],
    );
  }

  getBidang() async {

    await http.get(
      Uri.https(env.apiUrl, 'api/kelitbangan/list/bidang'),
      headers: {
        'Content-Type' : 'aplication/json; charset=UTF-8',
        'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImZkNDQzZGJhMzdkY2NjNTQzYmU4MTkzOWY0OTQ0MTkzZDc1YzZjYzcxNDY1YjBjOTIxOGE4MWM3NzVkZTkwNTM2Yjk1M2M4N2FjNGE0ODY4In0.eyJhdWQiOiIyIiwianRpIjoiZmQ0NDNkYmEzN2RjY2M1NDNiZTgxOTM5ZjQ5NDQxOTNkNzVjNmNjNzE0NjViMGM5MjE4YTgxYzc3NWRlOTA1MzZiOTUzYzg3YWM0YTQ4NjgiLCJpYXQiOjE2NjE5Mjg1OTgsIm5iZiI6MTY2MTkyODU5OCwiZXhwIjoxNjYxOTQ2NTk3LCJzdWIiOiIxNSIsInNjb3BlcyI6WyIqIl19.SUO0yl0Zqtzmn0ex_uR-vlh2mxXgjl1-am6MxpkcAal9aHt8nSLyOOBAFn4bTy3Szx2HJGMv_k5bzZ-JTU_yfHU5rqcYjjCWYclFoh8P1RWrhrFySxG_mNzbm5fDEB7913Wm5y5qRgt-ffOIYjYGQ1XX0EjU2bAgvdAFGA41g4r5KGT2-D88EGw1gQ8knRTxZOcIv_kqkCvQsGI4Ov3KGGgcYfi_7Q5nrNRqEPthycFMtUlX0QoFh-M2FRItE86ElVGSYREK6tt9vBsvhi07azBLQdShneFa8YNAg_lrhk0PQ4SKifpzCDdumyJNtNDDIqgsaMUiWMu9O0zZUxzHX-HYtuixDTWznjJm2DPWNUUfnClNIUpS7rautiie9aZvDV-BpLY6AO4xc_9omAzedytBbI7nivzy-M0tfv1MqnhmeggKNaSPhGiIqGKXedEjzhsVuaX7AZqdj5e7BqMUm-MnTD2A78VYyaYZhr9Soii98rzmgp8JzpLxFwaU-RsMfDMc5nU0_OOJ7hgagzDyh4HUxZEOqJgrPq8IPWAEvRiErxUNJlyxgGmt7BCebvS9Sq-ZqVUJGCo1LrvGTvAAFwZ9VjzmzAHwxUPfboStUt-W1TjzTUuV00YOqcETiFnnwq3c9yY02xoIsv9iCc56_A_idARPkcZWyOIzgldI6d0',
      },

    ).then((value) {
      listInstansi = jsonDecode(value.body)['data'];
      print(listInstansi);
      setState((){
        w_bidang = Container(
            padding: EdgeInsetsDirectional.all(5),
            height: 160,
            decoration: BoxDecoration(
              // border: BorderDirectional(),
                borderRadius: BorderRadius.circular(20),
                color: CupertinoColors.white
            ),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex:3,

                  child: Container(
                    child: Text('Bidang',
                      style: TextStyle(fontSize: 14, color: Colors.black,
                        // fontFamily: 'Poppins'
                      ),
                    ),
                    padding: EdgeInsetsDirectional.all(13),
                    //color: Colors.lightBlue,
                    decoration: BoxDecoration(
                      //   color: Colors.black12,
                        borderRadius: BorderRadiusDirectional.circular(15)
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                      padding: EdgeInsetsDirectional.all(15),
                      child:
                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          //Add isDense true and zero Padding.
                          //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          //Add more decoration as you want here
                          //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                        ),
                        // value: instansi as int,
                        isExpanded: true,
                        hint: const Text(
                          'Pilih Bidang ',
                          style: TextStyle(fontSize: 12,),

                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 30,
                        buttonHeight: 60,
                        buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        items: listInstansi
                            .map((item) =>
                            DropdownMenuItem<int>(
                              value: item['id'],
                              child: Text(
                                item['nama'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  // fontFamily: 'Poppins',
                                ),
                              ),
                            ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select gender.';
                          }
                        },
                        onChanged: (value) {
                          print(value);
                          instansi = value as int;
                          //Do something when changing the item if you want.
                        },
                        onSaved: (value) {
                          instansi = value as int;
                        },
                      ),
                      decoration: BoxDecoration(border: Border(),
                        //color: Colors.black12
                      )
                  ),
                ),
              ],)
        );
      });

    });
  }

  Future<void> store() async {
    simpanDialog();
    print(instansi);
    var _mytoken = await SessionManager().get('_token');
     await http.post(
      Uri.https(env.apiUrl, 'api/inovasi/create'),
      headers: {
        'Authorization': 'Bearer ${_mytoken.toString()}'
      },
      body: {
        'nomor' : nomor,
        'tanggal' : tanggal,
        'nama' : nama,
        'instansi' : instansi.toString(),
        'tujuan' : tujuan,
        'manfaat' : manfaat,
        'hasil' : hasil,
        'deskripsi' : deskripsi,
        'kelengkapan' : kelengkapan,
        'pelaksana' : jsonEncode(pelaksana.toString().split('\n')),
      },
    ).then((value){
      var dec = jsonDecode(value.body);
      print(dec);
      Navigator.of(simpan).pop();
      if(dec['status'] == true){
        showDialog(context: simpan, builder: (context){
          return AlertDialog(
            title: Text('Berhasil'),
            content: Text(dec['message']),
          );
        }).then((value) => resetForm());
      }
      else{
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text('Gagal!'),
            content: Text(dec['message']),
          );
        });
      }

    } );

  }



  resetForm() {}

  simpanDialog(){
    showDialog(context: context, builder: (BuildContext sv) {
      simpan = sv;
      return AlertDialog(title: Column(
        children: [
          Center(child: new CircularProgressIndicator()),
          Text('Menyimpan Data')
        ],
      ),);
    },);
  }

  getNomor() async {
    await http.get(
      Uri.https(env.apiUrl, 'api/inovasi/nomor'),
      headers: {
        'Content-Type' : 'aplication/json; charset=UTF-8',
        'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImZkNDQzZGJhMzdkY2NjNTQzYmU4MTkzOWY0OTQ0MTkzZDc1YzZjYzcxNDY1YjBjOTIxOGE4MWM3NzVkZTkwNTM2Yjk1M2M4N2FjNGE0ODY4In0.eyJhdWQiOiIyIiwianRpIjoiZmQ0NDNkYmEzN2RjY2M1NDNiZTgxOTM5ZjQ5NDQxOTNkNzVjNmNjNzE0NjViMGM5MjE4YTgxYzc3NWRlOTA1MzZiOTUzYzg3YWM0YTQ4NjgiLCJpYXQiOjE2NjE5Mjg1OTgsIm5iZiI6MTY2MTkyODU5OCwiZXhwIjoxNjYxOTQ2NTk3LCJzdWIiOiIxNSIsInNjb3BlcyI6WyIqIl19.SUO0yl0Zqtzmn0ex_uR-vlh2mxXgjl1-am6MxpkcAal9aHt8nSLyOOBAFn4bTy3Szx2HJGMv_k5bzZ-JTU_yfHU5rqcYjjCWYclFoh8P1RWrhrFySxG_mNzbm5fDEB7913Wm5y5qRgt-ffOIYjYGQ1XX0EjU2bAgvdAFGA41g4r5KGT2-D88EGw1gQ8knRTxZOcIv_kqkCvQsGI4Ov3KGGgcYfi_7Q5nrNRqEPthycFMtUlX0QoFh-M2FRItE86ElVGSYREK6tt9vBsvhi07azBLQdShneFa8YNAg_lrhk0PQ4SKifpzCDdumyJNtNDDIqgsaMUiWMu9O0zZUxzHX-HYtuixDTWznjJm2DPWNUUfnClNIUpS7rautiie9aZvDV-BpLY6AO4xc_9omAzedytBbI7nivzy-M0tfv1MqnhmeggKNaSPhGiIqGKXedEjzhsVuaX7AZqdj5e7BqMUm-MnTD2A78VYyaYZhr9Soii98rzmgp8JzpLxFwaU-RsMfDMc5nU0_OOJ7hgagzDyh4HUxZEOqJgrPq8IPWAEvRiErxUNJlyxgGmt7BCebvS9Sq-ZqVUJGCo1LrvGTvAAFwZ9VjzmzAHwxUPfboStUt-W1TjzTUuV00YOqcETiFnnwq3c9yY02xoIsv9iCc56_A_idARPkcZWyOIzgldI6d0',
      },

    ).then((value) {
      setState((){
        nomor = (value.body).toString();
      });

    });
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        getBidang();
        getNomor();
      });
    });
  }
}