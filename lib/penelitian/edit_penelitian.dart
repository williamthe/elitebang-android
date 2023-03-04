
import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_litbang/myenv.dart';

class EditPenelitian extends StatefulWidget{
    Map myData = {};
    EditPenelitian(Map data){
      myData = data;
    }
  _EditPenelitian createState() => _EditPenelitian(myData);
}

class _EditPenelitian extends State<EditPenelitian>{

  Map myData = {};
  _EditPenelitian(Map data){
    myData = data;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Scaffold(
            appBar: AppBar(title: Text('Edit '+myData['usulan']),
              centerTitle: true,
              leading: IconButton(onPressed: (){
                Navigator.of(context).pop();
              },icon: Icon(Icons.arrow_circle_left),),
            ),
            body: FormData(myData)
        )
    );
  }

}

class FormData extends StatefulWidget{
  Map myData = {};
  FormData(Map data){
    myData = data;
  }
  @override
  State<FormData> createState() => _FormDataState(myData);
}

class _FormDataState extends State<FormData> {
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

  Widget w_bidang = Container();

  _FormDataState(Map data){
    nomor = data['nomor'] == null ? '-' : data['nomor'];
    tanggal = data['tanggal'] == null ? '-' : data['tanggal'];
    usulan = data['usulan'] == null ? '-' : data['usulan'];;
    pengusul = data['pengusul'] == null ? '-' : data['pengusul'];
    latar_belakang = data['latar_belakang'] == null ? '-' : data['latar_belakang'];
    tujuan = data['tujuan'] == null ? '-' : data['tujuan'];
    email = data['email'] == null ? '-' : data['email'];
    nomor_kontak = data['nomor_kontak'] == null ? '-' : data['nomor_kontak'];
    lokasi = data['lokasi'] == null ? '-' : data['lokasi'];;
    faktor_penghambat = data['faktor_penghambat'] == null ? '-' : data['faktor_penghambat'];
    faktor_pendukung = data['faktor_pendukung'] == null ? '-' : data['faktor_pendukung'];
    status = data['status'] == null ? '-' : data['status'];
    bidang = data['instansi'] == null ? 1 : data['instansi'];
  }

  get barukan => null;

  late BuildContext simpan;

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
                                Text("Nomor", style: TextStyle(fontWeight: FontWeight.bold),),
                                Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder()
                                      ),
                                      controller: TextEditingController(text: nomor),
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
                                Text("Tanggal",style: TextStyle(fontWeight: FontWeight.bold)),
                                Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
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
                                Text("Usulan", style: TextStyle(fontWeight: FontWeight.bold)),
                                Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder()
                                      ),
                                      maxLines: 10,
                                      minLines: 3,
                                      onChanged: (v){
                                        usulan = v;
                                      },
                                      controller: TextEditingController(text: usulan),
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
                                Text("Pengusul",style: TextStyle(fontWeight: FontWeight.bold)),
                                Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder()
                                      ),
                                      onChanged: (v){
                                        pengusul = v;
                                      },
                                      controller: TextEditingController(text: pengusul),
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
                                Text("Latar Belakang", style: TextStyle(fontWeight: FontWeight.bold)),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder()
                                    ),
                                    minLines: 10,
                                    maxLines: 100,
                                    onChanged: (v){
                                      latar_belakang = v;
                                    },
                                    controller: TextEditingController(text: latar_belakang),
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
                                Text("Tujuan", style: TextStyle(fontWeight: FontWeight.bold)),
                                Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder()
                                      ),
                                      maxLines: 10,
                                      minLines: 3,
                                      onChanged: (v){
                                        tujuan = v;
                                      },
                                      controller: TextEditingController(text: tujuan),
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
                                Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
                                Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder()
                                      ),
                                      onChanged: (v){
                                        email = v;
                                      },
                                      controller: TextEditingController(text: email),
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
                                Text("Nomor Kontak", style: TextStyle(fontWeight: FontWeight.bold)),
                                Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder()
                                      ),
                                      onChanged: (v){
                                        nomor_kontak = v;
                                      },
                                      controller: TextEditingController(text: nomor_kontak),
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
                                Text("Lokasi", style: TextStyle(fontWeight: FontWeight.bold)),
                                Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder()
                                      ),
                                      maxLines: 10,
                                      minLines: 3,
                                      onChanged: (v){
                                        lokasi = v;
                                      },
                                      controller: TextEditingController(text: lokasi),
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
                                Text("Faktor Pendukung", style: TextStyle(fontWeight: FontWeight.bold)),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder()
                                    ),
                                    minLines: 10,
                                    maxLines: 100,
                                    onChanged: (v){
                                      faktor_pendukung = v;
                                    },
                                    controller: TextEditingController(text: faktor_pendukung),
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
                                Text("Faktor Penghambat", style: TextStyle(fontWeight: FontWeight.bold)),
                                Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                      minLines: 10,
                                      maxLines: 100,
                                      onChanged: (v){
                                        faktor_penghambat = v;
                                      },
                                      controller: TextEditingController(text: faktor_penghambat),
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
                                    width: 115,
                                    child: Text('update', style: TextStyle(color: Colors.white),)))
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
      Uri.https('api-litbang.btx.co.id', 'api/usulan-penelitian/create'),
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
            title: Text('Berhasil'),
            content: Text(dec['message']),
          );
        }).then((value) => {});
      }
      else{
        showDialog(context: simpan, builder: (context){
          return AlertDialog(
            title: Text('Gagal!'),
            content: Text(dec['message']),
          );
        });
      }

      print(dec);
    } );

  }
}

class FormEdit extends StatefulWidget{
  Map dataKelitbangan = {};
  String pelaksana = '';
  FormEdit(Map data){
    this.dataKelitbangan = data;
    if(data['pelaksana'] == null){
      this.pelaksana =  '-';
    }else{
      for (var age in data['pelaksana']) {
        this.pelaksana += age['nama']+"\n";
      }
    }
    this.dataKelitbangan.remove('pelaksana');
    this.dataKelitbangan['pelaksana'] = this.pelaksana;

  }
  @override
  State<FormEdit> createState() => _FormEditState(dataKelitbangan);
}

class _FormEditState extends State<FormEdit> {

  MyEnvironments env = new MyEnvironments();
  Map myData = {};

  String id = '0';
  String nomor = '';
  String tanggal = '';
  String usulan = '';
  String pengusul = '';
  String latar_belakang = '';
  String tujuan = '';
  String status = '';
  int bidang = 1;
  String email = '';
  String lokasi = '';
  String nomor_kontak = '';
  String faktor_pendukung = '';
  String faktor_penghambat = '';
  String external = '';

  _FormEditState(Map myData){
    this.myData           = myData;
    this.id               = myData['id'].toString()    == null ? '0' : myData['id'].toString();
    this.nomor            = myData['nomor']            == null ? '-' : myData['nomor'];
    this.usulan           = myData['usulan']           == null ? '-' : myData['usulan'];
    this.tanggal          = myData['tanggal']          == null ? '-' : myData['tanggal'];
    this.bidang         = myData['instansi']         == null ? 1 : myData['instansi'];
    this.pengusul         = myData['pengusul']         == null ? '-' : myData['pengusul'];
    this.latar_belakang   = myData['latar_belakang']   == null ? '-' : myData['latar_belakang'];
    this.id               = myData['id']               == null ? '0' : myData['id'].toString();
    this.email            = myData['email']            == null ? '-' : myData['email'];
    this.faktor_pendukung = myData['faktor_pendukung'] == null ? '-' : myData['faktor_pendukung'];
    this.faktor_penghambat= myData['faktor_penghambat']== null ? '0' : myData['faktor_penghambat'].toString();
    this.nomor_kontak     = myData['nomor_kontak']     == null ? '-' : myData['nomor_kontak'];
    this.tujuan     = myData['tujuan']     == null ? '-' : myData['tujuan'];

  }

  List listInstansi = [];
  late BuildContext updel;
  Widget w_bidang = Container();
  @override
  Widget build(BuildContext context) {

    return Container(
      height : (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) * 0.82,
      child: ListView(
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
                        child: TextField(

                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.numbers_sharp)),
                          ),
                          onChanged: (e){
                            nomor = e;
                          },
                          controller: TextEditingController(text: nomor),
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
                            tanggal = e;
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
                      child: Text('Judul Usulan',
                        style: TextStyle(fontSize: 14, color: Colors.black,

                        ),
                      ),
                      padding: EdgeInsetsDirectional.all(13),
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
                            suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.abc_outlined)),

                          ),
                          style: TextStyle(fontSize: 13),
                          minLines: 5,
                          maxLines: 10,
                          onChanged: (e){
                            usulan = e;
                          },
                          controller: TextEditingController(text: usulan),
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
                      child: Text('Pengusul',
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
                        child: TextField(

                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.perm_identity_outlined)),
                          ),
                          minLines: 2,
                          maxLines: 10,
                          onChanged: (e){
                            pengusul = e;
                          },
                          controller: TextEditingController(text: pengusul),
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
              height: 250,
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
                      child: Text('Latar Belakang',
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
                        child: TextField(

                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.flip_to_back_outlined)),
                          ),
                          minLines: 5,
                          maxLines: 10,
                          onChanged: (e){
                            latar_belakang = e;
                          },
                          style: TextStyle(fontSize: 14),
                          controller: TextEditingController(text: latar_belakang),
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
                        child: TextField(

                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.gps_fixed_outlined)),
                          ),
                          minLines: 4,
                          maxLines: 10,
                          onChanged: (e){
                            tujuan = e;
                          },
                          style: TextStyle(fontSize: 13),
                          controller: TextEditingController(text: tujuan),
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
                      child: Text('Email',
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
                        child: TextField(

                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.email_outlined)),
                          ),
                          minLines: 1,
                          maxLines: 10,
                          onChanged: (e){
                            email = e;
                          },
                          controller: TextEditingController(text: email),
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
                      child: Text('Nomor Kontak',
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
                        child: TextField(

                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.contact_phone_outlined)),
                          ),
                          minLines: 1,
                          maxLines: 10,
                          onChanged: (e){
                            nomor_kontak = e;
                          },
                          controller: TextEditingController(text: nomor_kontak),
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
                      child: Text('Faktor Pendukung',
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
                        child: TextField(

                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.gps_fixed_outlined)),
                          ),
                          minLines: 4,
                          maxLines: 10,
                          onChanged: (e){
                            faktor_pendukung = e;
                          },
                          controller: TextEditingController(text: faktor_pendukung),
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
                      child: Text('Faktor Penghambat',
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
                        child: TextField(

                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.gps_fixed_outlined)),
                          ),
                          minLines: 4,
                          maxLines: 10,
                          onChanged: (e){
                            faktor_penghambat = e;
                          },
                          controller: TextEditingController(text: faktor_penghambat),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Expanded(
                    //flex: 9,
                    child: Container(
                      //height: 60,
                        padding: EdgeInsetsDirectional.all(5),
                        child: TextButton(
                          child: Text('verifikasi',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,),),
                          onPressed: (){
                            setStatus('Verifikasi');
                          },
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                            ),
                            borderRadius: BorderRadiusDirectional.circular(10),
                            color: Colors.orangeAccent
                        )
                    ),
                  ),
                  SizedBox(width: 3,),
                  Expanded(
                    //flex: 9,
                    child: Container(
                      //height: 60,
                        padding: EdgeInsetsDirectional.all(5),
                        child: TextButton(
                          child: Text('terima',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,),),
                          onPressed: (){
                            setStatus('Terima');
                          },
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                            ),
                            borderRadius: BorderRadiusDirectional.circular(10),
                            color: Colors.blueAccent
                        )
                    ),
                  ),
                  SizedBox(width: 3,),
                  Expanded(
                    //flex: 9,
                    child: Container(
                      //height: 60,
                        padding: EdgeInsetsDirectional.all(5),
                        child: TextButton(
                          child: Text('tolak',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,),),
                          onPressed: (){
                            setStatus('Tolak');
                          },
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                            ),
                            borderRadius: BorderRadiusDirectional.circular(10),
                            color: Colors.black26
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    //flex: 9,
                    child: Container(
                      //height: 60,
                        padding: EdgeInsetsDirectional.all(5),
                        child: TextButton(
                          child: Text('update',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,),),
                          onPressed: (){
                            update();
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
                  SizedBox(width: 3,),
                  Expanded(
                    //flex: 9,
                    child: Container(
                      //height: 60,
                        padding: EdgeInsetsDirectional.all(5),
                        child: TextButton(
                          child: Text('hapus',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,),),
                          onPressed: (){
                            confirmDelete();
                          },
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                            ),
                            borderRadius: BorderRadiusDirectional.circular(10),
                            color: Colors.redAccent
                        )
                    ),
                  ),

                ],)
          ),
        ],
      ),
    );
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        getBidang();
      });
    });
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
                            borderRadius: BorderRadius.circular(10),
                          ),
                          //Add more decoration as you want here
                          //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                        ),
                        value: bidang,
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

  Future<void> update() async {

    showDialog(context: context, builder: (BuildContext upd){
      updel = upd;
      return AlertDialog(
        title: Column(
          children: [
            Text( 'Mengupdate Data...' ),
            Center( child :new CircularProgressIndicator()),
          ],
        ),
      );
    });

    var _mytoken = await SessionManager().get('_token');

    await http.post(
      Uri.https(env.apiUrl, 'api/usulan-penelitian/update'),
      headers: {
        //'Content-Type' : 'aplication/json;',
        'Authorization': 'Bearer ${_mytoken.toString()}'
      },
      body: {
        'id' : id.toString(),
        'nomor' : nomor,
        'tanggal' : tanggal,
        'usulan' : usulan,
        'pengusul' : pengusul,
        'latar_belakang' : latar_belakang,
        'tujuan' : tujuan,
        'status' : status,
        'instansi' : bidang.toString(),
        'email' : email,
        'lokasi' : lokasi,
        'nomor_kontak' : nomor_kontak,
        'faktor_pendukung' : faktor_pendukung,
        'faktor_penghambat' : faktor_penghambat,

      },
    ).then((value){
      var dec = jsonDecode(value.body);
      Navigator.of(updel).pop();
      if(dec['status'] == true){
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text('Update Berhasil!'),
            content: Text(dec['message']),
          );
        });
      }
      else{
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text('Update Gagal!'),
            content: Text(dec['message']),
          );
        });
      }

    } );

  }

  Future<void> delete() async {

    showDialog(context: context, builder: (BuildContext upd){
      updel = upd;
      return AlertDialog(
        title: Column(
          children: [
            Text( 'Menghapus Data...', ),
            Center(child: new CircularProgressIndicator()),
          ],
        ),
      );
    });

    var _mytoken = await SessionManager().get('_token');

    var response = await http.post(
      Uri.https(env.apiUrl, 'api/usulan-penelitian/delete'),
      headers: {
        //'Content-Type' : 'aplication/json;',
        'Authorization': 'Bearer ${_mytoken.toString()}'
      },
      body: {
        'id' : id.toString(),
      },
    ).then((value){
      var dec = jsonDecode(value.body);
      Navigator.of(updel).pop();
      if(dec['status'] == true){
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text('Berhasil!'),
            content: Text(dec['message']),
          );
        });
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

  Future<void> setStatus(statusu) async {
    status = statusu;

    showDialog(context: context, builder: (BuildContext upd){
      updel = upd;
      return AlertDialog(
        title: Column(
          children: [
            Text( 'Mengupdate Data...' ),
            Center( child :new CircularProgressIndicator()),
          ],
        ),
      );
    });

    var _mytoken = await SessionManager().get('_token');

    await http.post(
      Uri.https(env.apiUrl, 'api/usulan-penelitian/set-status'),
      headers: {
        //'Content-Type' : 'aplication/json;',
        'Authorization': 'Bearer ${_mytoken.toString()}'
      },
      body: {
        'id' : id.toString(),
        'status' : status,
      },
    ).then((value){
      var dec = jsonDecode(value.body);
      Navigator.of(updel).pop();
      if(dec['status'] == true){
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text('Update Berhasil!'),
            content: Text(dec['message']),
          );
        });
      }
      else{
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text('Update Gagal!'),
            content: Text(dec['message']),
          );
        });
      }

    } );

  }

  confirmDelete(){
    showDialog(context: context, builder: (BuildContext conf){
      updel = conf;
      return AlertDialog(
        title: Text( 'Akan Menghapus Data?',),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(updel).pop();
            delete();
          },
              child: Text('Ya',
               ),
            style: ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(side: BorderSide( color: Colors.blue),
                    borderRadius:BorderRadiusDirectional.circular(10) ))
            ),
          ),
          TextButton(onPressed: (){
            Navigator.of(updel).pop();
          },
              child: Text('Batal',
               ),
            style: ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(side: BorderSide( color: Colors.blue),
                  borderRadius:BorderRadiusDirectional.circular(10) ))
            ),
          ),

        ],
      );
    });
  }
}



