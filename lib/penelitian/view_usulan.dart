
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_litbang/myenv.dart';

import '../User_menu.dart';

class ViewUsulan extends StatefulWidget{
  Map myData = {};
  ViewUsulan(listData){
    this.myData = listData;
  }
  _ViewUsulan createState() => _ViewUsulan(myData);
}

class _ViewUsulan extends State<ViewUsulan>{
  Map myData = {};
  String pelaksana = '';
  _ViewUsulan(Map myData){
    this.myData = myData;
  }

  MyEnvironments env = new MyEnvironments();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: env.myFont),
        debugShowCheckedModeBanner: false,
        home:Scaffold(
          body: Column(
            children: [
              Container(height: 25,),
              Container(
                decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    borderRadius: BorderRadiusDirectional.circular(10)
                ),
                padding: EdgeInsetsDirectional.only(top: 5,bottom: 5),
                //color: Colors.blue,
                height : (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) * 0.12 -25,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: IconButton(icon:Icon(Icons.grid_view_sharp), onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return UserMenu();
                        },));
                      },
                        tooltip: 'User Menu',),
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(padding: EdgeInsetsDirectional.only(start: 10),
                          child: Text(myData['usulan'],
                            style: TextStyle(

                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis
                            ),
                          )),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(icon:Icon(Icons.keyboard_double_arrow_left), onPressed: (){
                        Navigator.of(context).pop();
                      },
                        tooltip: 'List Data',),
                    ),
                  ],
                ),

              ),
              FormView(myData),
            ],
          )
        )
    );
  }

}

class ViewData extends StatelessWidget{
  Map data = {};
  String pelaksana = '';
  ViewData(Map data,String pelaksana){
    this.data = data;
    this.pelaksana = pelaksana;
  }
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
                        flex: 8,
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
                                Container(
                                    padding: EdgeInsetsDirectional.all(10),
                                    child: Text(data['nomor'] == null ? '-' : data['nomor'] )),
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
                        flex: 8,
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
                                Container(
                                    padding: EdgeInsetsDirectional.all(5),
                                    child: Text(data['tanggal'] == null ? '-' : data['tanggal'])),
                              ]),

                        ),
                      ),
                    ],
                  ),
                  Container(height: 15,),
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
                                Text("Usulan", style: TextStyle(fontWeight: FontWeight.bold)),
                                Container(
                                    padding: EdgeInsetsDirectional.all(5),
                                    child: Text(data['usulan'] == null ? '-' : data['usulan'])),
                              ]),
                        ),
                      ),
                    ],
                  ),
                  Container(height: 15,),
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
                                Container(
                                    padding: EdgeInsetsDirectional.all(5),
                                    child: SingleChildScrollView(
                                      child: Text(data['pengusul']  == null ? '-' : data['pengusul']),
                                      scrollDirection: Axis.vertical,
                                    )),
                              ]),
                        ),
                      ),
                    ],
                  ),
                  Container(height: 15,),
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
                                Text("Latar Belakang", style: TextStyle(fontWeight: FontWeight.bold)),
                                Container(
                                    padding: EdgeInsetsDirectional.all(5),
                                    child: Text(data['latar_belakang'] == null ? '-' : data['latar_belakang'])),
                              ]),
                        ),
                      )
                    ],
                  ),
                  Container(height: 15,),
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
                                Text("Tujuan", style: TextStyle(fontWeight: FontWeight.bold)),
                                Container(
                                    padding: EdgeInsetsDirectional.all(5),
                                    child: Text(data['tujuan'] == null ? 'Tidak Ada' : data['tujuan'])),
                              ]),
                        ),
                      ),
                    ],
                  ),
                  Container(height: 15,),
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
                                Text("Status", style: TextStyle(fontWeight: FontWeight.bold)),
                                Container(padding: EdgeInsetsDirectional.all(5),
                                  child: Text(data['status'] == null ? '-' : data['status']),)
                                //Text(data['pelaksana'].toString()),
                              ]),
                        ),
                      ),
                    ],
                  ),
                  Container(height: 15,),
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
                                Container(padding: EdgeInsetsDirectional.all(5),
                                  child: Text(data['email'] == null ? '-' : data['email']),)
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
                                Container(padding: EdgeInsetsDirectional.all(5),
                                  child: Text(data['nomor_kontak'] == null ? '-' : data['nomor_kontak']),)
                                //Text(data['pelaksana'].toString()),
                              ]),
                        ),
                      ),
                    ],
                  ),
                  Container(height: 15,),
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
                                Text("Lokasi", style: TextStyle(fontWeight: FontWeight.bold)),
                                Container(padding: EdgeInsetsDirectional.all(5),
                                  child: Text(data['lokasi'] == null ? '-' : data['lokasi']),)

                              ]),
                        ),
                      ),
                    ],
                  ),
                  Container(height: 15,),
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
                                Text("Faktor Pendukung", style: TextStyle(fontWeight: FontWeight.bold)),
                                Container(padding: EdgeInsetsDirectional.all(5),
                                  child: Text(data['faktor_pendukung'] == null ? '-' : data['faktor_pendukung']),)
                                //Text(data['pelaksana'].toString()),
                              ]),
                        ),
                      ),
                    ],
                  ),
                  Container(height: 15,),
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
                                Text("Faktor Penghambat", style: TextStyle(fontWeight: FontWeight.bold)),
                                Container(padding: EdgeInsetsDirectional.all(5),
                                  child: Text(data['faktor_penghambat'] == null ? '-' : data['faktor_penghambat']),)
                                //Text(data['pelaksana'].toString()),
                              ]),
                        ),
                      ),
                    ],
                  ),
                  Container(height: 15,),
                ],
              ),
            ],
          ),
        ),
      ],);
  }
}

class FormView extends StatefulWidget{
  Map dataKelitbangan = {};
  String pelaksana = '';
  FormView(Map data){
    this.dataKelitbangan = data;
    if(data['pelaksana'] == null){
      this.pelaksana =  '-';
    }
    this.dataKelitbangan.remove('pelaksana');
    this.dataKelitbangan['pelaksana'] = this.pelaksana;

  }
  @override
  State<FormView> createState() => _FormViewState(dataKelitbangan);
}

class _FormViewState extends State<FormView> {

  Map myData = {};

  String email = '@mail';
  String tanggal = '';
  String usulan = '';
  String pengusul = '';
  String latar_belakang = '';
  String tujuan = '';
  String nomor = '';
  String status = '';
  String namaInstansi ='';
  String faktor_pendukung = '';
  String faktor_penghambat ='';
  String nomor_kontak ='';
  String lokasi ='';

  _FormViewState(Map myData){
    this.myData         = myData;
    this.nomor          = myData['nomor']         == null ? '-' : myData['nomor'];
    this.usulan         = myData['usulan']        == null ? '-' : myData['usulan'];
    this.tanggal        = myData['tanggal']       == null ? '-' : myData['tanggal'];
    this.pengusul       = myData['pengusul']      == null ? '-' : myData['pengusul'];
    this.namaInstansi   = myData['lingkup_data'] == null ? '-' : myData['lingkup_data']['nama'];
    this.latar_belakang = myData['latar_belakang']== null ? '-' : myData['latar_belakang'];
    this.tujuan         = myData['tujuan']        == null ? '-' : myData['tujuan'];
    this.email          = myData['email']         == null ? '@mail' : myData['email'];
    this.nomor_kontak          = myData['nomor_kontak']         == null ? '@mail' : myData['nomor_kontak'];
    this.status         = myData['status']        == null ? '-' : myData['status'];
    this.faktor_pendukung  = myData['faktor_pendukung']  == null ? '-' : myData['faktor_pendukung'];
    this.faktor_penghambat = myData['faktor_penghambat']  == null ? '-' : myData['faktor_penghambat'];
    this.lokasi = myData['lokasi']  == null ? '-' : myData['lokasi'];

    //print(myData['instansi_data']);
  }

  TextStyle titleStyle = TextStyle(

    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {

    return Container(
      height : (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) * 0.88,
      child: ListView(
        children: [
          Container(
              padding: EdgeInsetsDirectional.all(5),
              height: 100,
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
                    flex:2,
                    child: Container(
                      child: Text('Nomor',
                        style: titleStyle,
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
                    flex: 2,
                    child: Container(
                        padding: EdgeInsetsDirectional.all(15),
                        child: Text(nomor,

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
              height: 100,
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
                    flex:2,
                    child: Container(
                      child: Text('Tanggal',
                        style: titleStyle,
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
                    flex: 2,
                    child: Container(
                        padding: EdgeInsetsDirectional.all(15),
                        child: Text(tanggal,

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
              height: 120,
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
                    flex:2,

                    child: Container(
                      child: Text('Lingkup / Bidang / Instansi',
                        style: titleStyle,
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
                    flex: 2,
                    child: Container(
                        padding: EdgeInsetsDirectional.all(15),
                        child: Text(namaInstansi,

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
                      child: Text('Usulan',
                        style: titleStyle,
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
                        child: Text(usulan,

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
                        style: titleStyle,
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
                        child: Text(pengusul,

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
                      child: Text('Latar Belakang',
                        style: titleStyle,
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
                        child: SingleChildScrollView(
                          child: Text(latar_belakang,

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
                        style: titleStyle,
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
                        child: Text(tujuan,

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
                      child: Text('Status',
                        style: titleStyle,
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
                        child: Text(status,

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
                        style: titleStyle,
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
                        child: Text(email,

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
                        style: titleStyle,
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
                        child: Text(nomor_kontak,

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
                      child: Text('Lokasi',
                        style: titleStyle,
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
                        child: Text(lokasi,

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
                        style: titleStyle,
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
                        child: Text(faktor_pendukung,

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
                        style: titleStyle,
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
                        child: Text(faktor_penghambat,

                        ),
                        decoration: BoxDecoration(border: Border(),
                          //color: Colors.black12
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

      });
    });
  }

}
