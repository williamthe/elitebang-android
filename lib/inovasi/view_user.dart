
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_litbang/myenv.dart';

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
  _ViewUser(Map data){
    this.myData = data;
    if(myData['pelaksana'] == null){
      this.pelaksana =  '-';
    }else{
      if(myData['pelaksana'].runtimeType != String)
        {
          for (var age in myData['pelaksana']) {
            this.pelaksana += age['nama']+"\n";
          }
        }
    }
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
                            child: Text(myData['nama'],
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
  }
  @override
  State<FormView> createState() => _FormViewState(dataKelitbangan);
}

class _FormViewState extends State<FormView> {

  Map myData = {};

  String tanggal = '';
  String nomor = '';
  String nama = '';
  int instansi = 1;
  String tujuan = '';
  String manfaat = '';
  String hasil = '';
  String namaInstansi ='';
  String deskripsi = '';
  String kelengkapan = '';
  String pelaksana ='';

  _FormViewState(Map myData){
    this.myData       = myData;
    this.nomor        = myData['nomor']        == null ? '-' : myData['nomor'];
    this.nama         = myData['nama']         == null ? '-' : myData['nama'];
    this.tanggal      = myData['tanggal']      == null ? '-' : myData['tanggal'];
    this.instansi     = myData['instansi']      == null ? 1 : myData['instansi'];
    this.namaInstansi = myData['instansi_data'] == null ? '-' : myData['instansi_data']['nama'];
    this.tujuan       = myData['tujuan']       == null ? '-' : myData['tujuan'];
    this.manfaat      = myData['manfaat']      == null ? '-' : myData['manfaat'];
    this.hasil        = myData['hasil']        == null ? '-' : myData['hasil'];
    this.deskripsi    = myData['deskripsi']    == null ? '-' : myData['deskripsi'];
    this.kelengkapan  = myData['kelengkapan']  == null ? '-' : myData['kelengkapan'];
    this.pelaksana    = myData['pelaksana']    == null ? '-' : myData['pelaksana'].toString();
    print(myData['instansi_data']);
    print(this.namaInstansi);
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
                      child: Text('Bidang / Instansi',
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
                      child: Text('Nama',
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
                        child: Text(nama,

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
                        child: SingleChildScrollView(
                          child: Text(tujuan,

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
                          child: Text(manfaat,

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
                          child: Text(hasil,

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
                          child: Text(deskripsi,

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
                        child: Text(kelengkapan,

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



