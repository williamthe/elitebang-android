
import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_litbang/myenv.dart';

class FormUsulan extends StatefulWidget{

  _FormUsulan createState() => _FormUsulan();
}

class _FormUsulan extends State<FormUsulan>{

  MyEnvironments env = new MyEnvironments();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: env.myFont),
        debugShowCheckedModeBanner: false,
        home:Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(title: Text('Usulkan Penelitian',),
            backgroundColor: Colors.blue.shade900,
            centerTitle: true,
            leading: IconButton(onPressed: (){
              Navigator.of(context).pop();
            },icon: Icon(Icons.cancel),),
          ),
          body: FormData()
        )
    );
  }

}

class FormData extends StatefulWidget{
  @override
  State<FormData> createState() => _FormDataState();
}

class _FormDataState extends State<FormData> {

  MyEnvironments env = new MyEnvironments();
  Map data = {};
  String pelaksana = '';
  String nomor = '';
  String tanggal = '';
  String usulan = '';
  String pengusul = '';
  String latar_belakang = '';
  String tujuan = '';
  String email = '';
  String nomor_kontak = '';
  String lokasi = '';
  String faktor_penghambat = '';
  String faktor_pendukung = '';
  String status = 'usulan';
  int bidang = 0;
  get barukan => null;

  late BuildContext simpan;
  TextStyle formText = TextStyle(

    fontWeight: FontWeight.bold,
  );
  
  double borderRd = 10;
  TextStyle poppin = TextStyle();
  Widget w_instansi = Container();
  List listInstansi = [];
  @override
  Widget build(BuildContext context) {
    return
      SingleChildScrollView(
        child: Column(children: [
          Container(
            padding: EdgeInsetsDirectional.all(15),
            height: (MediaQuery.of(context).size.height - 25 - MediaQuery.of(context).padding.top - AppBar().preferredSize.height),
            child: ListView(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 12,
                          child: Container(
                            padding: EdgeInsetsDirectional.all(10),
                            height: 100,
                            decoration: BoxDecoration(
                              // border: BorderDirectional(),
                                borderRadius: BorderRadius.circular(20),
                                color: CupertinoColors.white
                            ),
                            child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Nomor", style: formText,),
                                  Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRd))
                                        ),
                                        controller: TextEditingController(text :nomor),
                                      )
                                  ),
                                ]),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 10,
                          ),
                        ),
                        Expanded(
                          flex: 12,
                          child: Container(
                            padding: EdgeInsetsDirectional.all(10),
                            height: 100,
                            decoration: BoxDecoration(
                              // border: BorderDirectional(),
                                borderRadius: BorderRadius.circular(20),
                                color: CupertinoColors.white
                            ),
                            child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Tanggal",style: formText),
                                  Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRd)),
                                            
                                            suffixIcon: IconButton(onPressed: (){
                                              showDatePicker(context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(1990),
                                                  lastDate: DateTime(2099)
                                              ).then((value) => {
                                                setState((){
                                                  tanggal = value.toString().split(" ")[0];
                                                })
                                              });
                                            }, icon: Icon(Icons.date_range),)
                                        ),
                                        controller: TextEditingController(text: tanggal),
                                      )
                                  ),
                                ]),

                          ),
                        ),
                      ],
                    ),
                    Container(height: 5,),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsetsDirectional.all(10),
                            height: 120,
                            decoration: BoxDecoration(
                              // border: BorderDirectional(),
                                borderRadius: BorderRadius.circular(20),
                                color: CupertinoColors.white
                            ),
                            child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Usulan", style: formText),
                                  Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRd))
                                        ),
                                        maxLines: 10,
                                        minLines: 3,
                                        onChanged: (v){
                                          usulan = v;
                                        },
                                      )
                                  ),

                                ]),
                          ),
                        ),
                      ],
                    ),
                    Container(height: 5,),
                    w_instansi,
                    Container(height: 5,),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsetsDirectional.all(10),
                            height: 100,
                            decoration: BoxDecoration(
                              // border: BorderDirectional(),
                                borderRadius: BorderRadius.circular(20),
                                color: CupertinoColors.white
                            ),
                            child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Pengusul",style: formText),
                                  Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRd))
                                        ),
                                        onChanged: (v){
                                          pengusul = v;
                                        },
                                      )
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                    Container(height: 5,),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsetsDirectional.all(10),
                            height: 180,
                            decoration: BoxDecoration(
                              // border: BorderDirectional(),
                                borderRadius: BorderRadius.circular(20),
                                color: CupertinoColors.white
                            ),
                            child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Latar Belakang", style: formText),
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRd))
                                      ),
                                      minLines: 10,
                                      maxLines: 100,
                                      onChanged: (v){
                                        latar_belakang = v;
                                      },
                                    ),

                                  ),
                                  //Text(data['pelaksana'].toString()),
                                ]),
                          ),
                        )
                      ],
                    ),
                    Container(height: 5,),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsetsDirectional.all(10),
                            height: 120,
                            decoration: BoxDecoration(
                              // border: BorderDirectional(),
                                borderRadius: BorderRadius.circular(20),
                                color: CupertinoColors.white
                            ),
                            child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Tujuan", style: formText),
                                  Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRd))
                                        ),
                                        maxLines: 10,
                                        minLines: 3,
                                        onChanged: (v){
                                          tujuan = v;
                                        },
                                      )
                                  ),

                                ]),
                          ),
                        ),
                      ],
                    ),
                    Container(height: 5,),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsetsDirectional.all(10),
                            height: 100,
                            decoration: BoxDecoration(
                              // border: BorderDirectional(),
                                borderRadius: BorderRadius.circular(20),
                                color: CupertinoColors.white
                            ),
                            child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Email", style: formText),
                                  Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRd))
                                        ),
                                        onChanged: (v){
                                          email = v;
                                        },
                                      )
                                  ),
                                  //Text(data['pelaksana'].toString()),
                                ]),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsetsDirectional.all(10),
                            height: 100,
                            decoration: BoxDecoration(
                              // border: BorderDirectional(),
                                borderRadius: BorderRadius.circular(20),
                                color: CupertinoColors.white
                            ),
                            child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Nomor Kontak", style: formText),
                                  Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRd))
                                        ),
                                        onChanged: (v){
                                          nomor_kontak = v;
                                        },
                                      )
                                  ),
                                  //Text(data['pelaksana'].toString()),
                                ]),
                          ),
                        ),
                      ],
                    ),
                    Container(height: 5,),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsetsDirectional.all(10),
                            height: 120,
                            decoration: BoxDecoration(
                              // border: BorderDirectional(),
                                borderRadius: BorderRadius.circular(20),
                                color: CupertinoColors.white
                            ),
                            child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Lokasi", style: formText),
                                  Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRd))
                                        ),
                                        maxLines: 10,
                                        minLines: 3,
                                        onChanged: (v){
                                          lokasi = v;
                                        },
                                      )
                                  ),

                                ]),
                          ),
                        ),
                      ],
                    ),
                    Container(height: 5,),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsetsDirectional.all(10),
                            height: 180,
                            decoration: BoxDecoration(
                              // border: BorderDirectional(),
                                borderRadius: BorderRadius.circular(20),
                                color: CupertinoColors.white
                            ),
                            child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Faktor Pendukung", style: formText),
                                  Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRd))
                                        ),
                                      minLines: 10,
                                      maxLines: 100,
                                      onChanged: (v){
                                        faktor_pendukung = v;
                                      },
                                      ),


                                  ),
                                  //Text(data['pelaksana'].toString()),
                                ]),
                          ),
                        ),
                      ],
                    ),
                    Container(height: 5,),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsetsDirectional.all(10),
                            height: 180,
                            decoration: BoxDecoration(
                              // border: BorderDirectional(),
                                borderRadius: BorderRadius.circular(20),
                                color: CupertinoColors.white
                            ),
                            child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Faktor Penghambat", style: formText),
                                  Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRd)),
                                        ),
                                        minLines: 10,
                                        maxLines: 100,
                                        onChanged: (v){
                                          faktor_penghambat = v;
                                        },
                                      )
                                  ),
                                  //Text(data['pelaksana'].toString()),
                                ]),
                          ),
                        ),
                      ],
                    ),
                    Container(height: 5,),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsetsDirectional.all(5),
                            height: 70,
                            decoration: BoxDecoration(
                              // border: BorderDirectional(),
                                borderRadius: BorderRadius.circular(20),
                                //color: CupertinoColors.white
                            ),
                            child:  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextButton(onPressed: (){
                                    showDialog(context: context, builder: (BuildContext co) {
                                      simpan = co;
                                      return AlertDialog(title: Text('Menyimpan Data..',style: poppin,),
                                      content: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(child: new CircularProgressIndicator()),
                                        ],
                                      ),
                                      );
                                    },);
                                    store();
                                  }, child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.greenAccent,
                                      borderRadius: BorderRadiusDirectional.circular(10)
                                    ),
                                    alignment: Alignment.center,
                                      height: 43,

                                      child: Text('simpan',
                                        style: TextStyle( color: Colors.white),)))
                                  //Text(data['pelaksana'].toString()),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],),
      );
  }

  Future<void> store() async {

      await http.post(
      Uri.https(env.apiUrl, 'api/usulan-penelitian/create'),
      body: {

        'nomor' : nomor,
        'tanggal' : tanggal,
        'usulan' : usulan,
        'pengusul' : pengusul,
        'latar_belakang' : latar_belakang,
        'tujuan' : tujuan,
        'email' : email,
        'nomor_kontak' : nomor_kontak,
        'lokasi' : lokasi,
        'faktor_pendukung' : faktor_pendukung,
        'faktor_penghambat' : faktor_penghambat,
        'external' : '1',
        'status': status,
        'instansi': bidang.toString()

      },
    ).then((value){

      var dec = jsonDecode(value.body);
      Navigator.of(simpan).pop();
      if(dec['status'] == true){
        showDialog(context: simpan, builder: (context){
          return AlertDialog(
            title: Text('Berhasil',style: poppin,),
            content: Text(dec['message'],style: poppin,),
          );
        }).then((value) => {});
      }
      else{
        showDialog(context: simpan, builder: (context){
          return AlertDialog(
            title: Text('Gagal!',style: poppin,),
            content: Text(dec['message'],style: poppin,),
          );
        });
      }

      print(dec);
    } );

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
      setState((){
        w_instansi = Container(
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
                    child: Text('Bidang Tujuan',
                      style: TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
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
                            borderRadius: BorderRadius.circular(10),
                          ),
                          //Add more decoration as you want here
                          //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                        ),

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
                          bidang = value as int;
                          //Do something when changing the item if you want.
                        },
                        onSaved: (value) {
                          bidang = value as int;
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

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        getBidang();
        getNomor();
      });
    });
  }

  getNomor() async {
    await http.get(
      Uri.https(env.apiUrl, 'api/usulan-penelitian/nomor'),
      headers: {
        'Content-Type' : 'aplication/json; charset=UTF-8',
        'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImZkNDQzZGJhMzdkY2NjNTQzYmU4MTkzOWY0OTQ0MTkzZDc1YzZjYzcxNDY1YjBjOTIxOGE4MWM3NzVkZTkwNTM2Yjk1M2M4N2FjNGE0ODY4In0.eyJhdWQiOiIyIiwianRpIjoiZmQ0NDNkYmEzN2RjY2M1NDNiZTgxOTM5ZjQ5NDQxOTNkNzVjNmNjNzE0NjViMGM5MjE4YTgxYzc3NWRlOTA1MzZiOTUzYzg3YWM0YTQ4NjgiLCJpYXQiOjE2NjE5Mjg1OTgsIm5iZiI6MTY2MTkyODU5OCwiZXhwIjoxNjYxOTQ2NTk3LCJzdWIiOiIxNSIsInNjb3BlcyI6WyIqIl19.SUO0yl0Zqtzmn0ex_uR-vlh2mxXgjl1-am6MxpkcAal9aHt8nSLyOOBAFn4bTy3Szx2HJGMv_k5bzZ-JTU_yfHU5rqcYjjCWYclFoh8P1RWrhrFySxG_mNzbm5fDEB7913Wm5y5qRgt-ffOIYjYGQ1XX0EjU2bAgvdAFGA41g4r5KGT2-D88EGw1gQ8knRTxZOcIv_kqkCvQsGI4Ov3KGGgcYfi_7Q5nrNRqEPthycFMtUlX0QoFh-M2FRItE86ElVGSYREK6tt9vBsvhi07azBLQdShneFa8YNAg_lrhk0PQ4SKifpzCDdumyJNtNDDIqgsaMUiWMu9O0zZUxzHX-HYtuixDTWznjJm2DPWNUUfnClNIUpS7rautiie9aZvDV-BpLY6AO4xc_9omAzedytBbI7nivzy-M0tfv1MqnhmeggKNaSPhGiIqGKXedEjzhsVuaX7AZqdj5e7BqMUm-MnTD2A78VYyaYZhr9Soii98rzmgp8JzpLxFwaU-RsMfDMc5nU0_OOJ7hgagzDyh4HUxZEOqJgrPq8IPWAEvRiErxUNJlyxgGmt7BCebvS9Sq-ZqVUJGCo1LrvGTvAAFwZ9VjzmzAHwxUPfboStUt-W1TjzTUuV00YOqcETiFnnwq3c9yY02xoIsv9iCc56_A_idARPkcZWyOIzgldI6d0',
      },

    ).then((value) {
      setState((){
        nomor = (value.body).toString();
        print(nomor);
      });

    });
  }
}



