
import 'dart:convert';

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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: env.myFont),
        home:Scaffold(
         // resizeToAvoidBottomInset: false,
          appBar: AppBar(title: Text('Usulkan Inovasi',),
            backgroundColor: Colors.blue.shade900,
            centerTitle: true,
            leading: IconButton(onPressed: (){
              Navigator.of(context).pop();
            },icon: Icon(Icons.cancel),),
          ),
          body: SingleChildScrollView(child: FormData())
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

  get barukan => null;

  late BuildContext simpan;
  TextStyle formText = TextStyle(

    fontWeight: FontWeight.bold,
  );
  
  double borderRd = 10;
  TextStyle poppin = TextStyle(fontFamily: 'Poppins');

  @override
  Widget build(BuildContext context) {
    return
      Column(children: [
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
                                      controller: TextEditingController(text: nomor),
                                      onChanged: (n){
                                        nomor = n;
                                      },
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
                                    return AlertDialog(title: Text('Menyimpan Data..'),
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
                                    //width: 115,
                                    child: Text('simpan',
                                      style: TextStyle(
                                          color: Colors.white),)))
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
      ],);
  }

  Future<void> store() async {

    var response = await http.post(
      Uri.https(env.apiUrl, 'api/usulan-inovasi/create'),
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

      },
    ).then((value){

      var dec = jsonDecode(value.body);
      Navigator.of(simpan).pop();
      if(dec['status'] == true){
        showDialog(context: simpan, builder: (context){
          return AlertDialog(
            title: Text('Berhasil',),
            content: Text(dec['message'],),
          );
        }).then((value) => {});
      }
      else{
        showDialog(context: simpan, builder: (context){
          return AlertDialog(
            title: Text('Gagal!',),
            content: Text(dec['message'],),
          );
        });
      }

      print(dec);
    } );

  }

  getNomor() async {
    await http.get(
      Uri.https(env.apiUrl, 'api/usulan-inovasi/nomor'),
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
        getNomor();
      });
    });
  }
}



