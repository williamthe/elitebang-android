
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_litbang/myenv.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../User_menu.dart';

class ViewUser extends StatefulWidget{
  Map myData = {};
  ViewUser(listData){
    this.myData = listData;
  }
  _ViewUser createState() => _ViewUser(myData);
}

class _ViewUser extends State<ViewUser>{

  MyEnvironments env = new MyEnvironments();

  Map myData = {};
  String pelaksana = '';
  _ViewUser(Map myData){
    this.myData = myData;
    if(myData['pelaksana'] == null){
      this.pelaksana =  '-';
    }else{
      print(myData['pelaksana'].runtimeType);
      if(myData['pelaksana'].runtimeType != String){
        for (var age in myData['pelaksana']) {
          this.pelaksana += age['nama']+"\n";
        }
      }

    }
    myData.remove('pelaksana');
    this.myData['pelaksana'] = this.pelaksana;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: env.myFont),
        home:Scaffold(
            //backgroundColor: Color.fromRGBO(12, 12, 220, 100),
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
                height: 50,
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
                          child: Text(myData['judul'],
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

class FormView extends StatefulWidget{
  Map dataKelitbangan = {};
  String pelaksana = '';
  FormView(Map data){
    this.dataKelitbangan = data;
    if(data['pelaksana'] == null){
      this.pelaksana =  '-';
    }else {
      this.pelaksana = data['pelaksana'];
      this.dataKelitbangan['pelaksana'] = this.pelaksana;
    }
  }
  @override
  State<FormView> createState() => _FormViewState(dataKelitbangan);
}

class _FormViewState extends State<FormView> {

  Map myData = {};

  String id = '0';
  String tanggal = '';
  String judul = '';
  int instansi = 1;
  String abstrak = '';
  String tindakLanjut = '';
  String nomor = '';
  String pelaksana = '';
  String namaInstansi ='';
  List<Widget> dokumen = [];

  _FormViewState(Map myData){
    this.myData       = myData;
    this.nomor        = myData['nomor']         == null ? '-' : myData['nomor'];
    this.judul        = myData['judul']         == null ? '-' : myData['judul'];
    this.tanggal      = myData['tanggal']       == null ? '-' : myData['tanggal'];
    this.instansi     = myData['lingkup']       == null ? 1 : myData['lingkup'];
    this.namaInstansi = myData['lingkup_data']  == null ? '-' : myData['lingkup_data']['nama'];
    this.abstrak      = myData['abstrak']       == null ? '-' : myData['abstrak'];
    this.tindakLanjut = myData['tindak_lanjut'] == null ? '-' : myData['tindak_lanjut'];
    this.id           = myData['id']            == null ? '0' : myData['id'].toString();
    this.pelaksana    = myData['pelaksana']     == null ? '-' : myData['pelaksana'];

    for (var age in myData['attachment']) {
      var st= Map<String, dynamic>.from(age);
      dokumen.add(TextButton(onPressed: (){
        launchUrlString("https://litbang.btx.co.id/${st['url'].toString().split('public/')[1]}",
            mode: LaunchMode.externalApplication );
      },
          child: Text(st['nama'])
        )
      );
    }

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
                      child: Text('Bidang',
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
                      child: Text('Judul',
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
                        child: Text(judul,

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
                      child: Text('Abstrak',
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
                          child: Text(abstrak,

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
                      child: Text('Tindak Lanjut',
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
                        child: Text(tindakLanjut,

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
                        child: Text(pelaksana,

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
                      child: Text('File / Dokumen',
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
                      alignment: Alignment.centerLeft,
                        padding: EdgeInsetsDirectional.all(15),
                        child: ListView(
                          children: [Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: dokumen,)],
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



