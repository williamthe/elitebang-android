import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_litbang/kelitbangan/baru.dart';
import 'package:prototype_litbang/myenv.dart';
import 'package:prototype_litbang/penelitian/edit_penelitian.dart';
import 'package:prototype_litbang/penelitian/form_usulan.dart';
import 'package:url_launcher/url_launcher_string.dart';


class IndexPenelitian extends StatefulWidget{
  @override
  _IndexPenelitian createState() => _IndexPenelitian();
}

class _IndexPenelitian extends State<IndexPenelitian>{
  MyEnvironments env = new MyEnvironments();
  List listData = [];
  List listInstansi = [];

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
  String status = 'terlaksana';
  int instansi = 0;
  TextStyle formText = TextStyle(

    //fontWeight: FontWeight.bold,
  );

  double borderRd = 15;

  int dokumen = 0;
  int curin = 1;

  String username = '';
  String password = '';
  String tipe ='penelitian';

  late BuildContext simpan;

  Widget myList = Center(
    child: Text('Loading Data...'),
  );
  Widget awal = Text('');
  Widget listLaporan = Text('Belum Ada Data');

  late Widget laporan;
  late BuildContext ex;
  late Widget formPenelitian;

  double tinggiKonten = 0;

  @override
  Widget build(BuildContext context) {
    final contentHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - 7;
    tinggiKonten = contentHeight;
    laporan = Container(child: Column(
      children: [
        Container(height: 10,),
        Row(
          children: [
            Expanded(
              flex: 8,
              child: Container(
                //height: 60,
                  padding: EdgeInsetsDirectional.all(5),
                  child: TextButton(
                    child: Text('Public Password',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,),),
                    onPressed: (){
                      getPasswordList();
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
            Expanded(
                flex:2,
                child: Container(
                  // decoration: BoxDecoration(
                  //   border: Border.all()
                  // ),
                  child: IconButton(onPressed: (){
                    setState(() {
                      getListLaporan();
                    });
                  }, icon: Icon(Icons.refresh),
                  tooltip: 'Refresh Laporan',),
                )
            )
          ],
        ),
        Container(height: 5,),

      ],
    ),);
    formPenelitian = Container(
      padding: EdgeInsetsDirectional.all(15),
      height: tinggiKonten *0.82 -18,
      child: SingleChildScrollView(
        child: Column(
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
                        child: Text('Lingkup / Bidang / Instansi',
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
                            ///value: instansi,
                            isExpanded: true,
                            hint: const Text(
                              'Pilih Lingkup / Bidang',
                              style: TextStyle(fontSize: 14),
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

                                    ),
                                  ),
                                ))
                                .toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Silahkan Pilih ';
                              }
                            },
                            onChanged: (value) {
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
                    height: 80,
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
                              return AlertDialog(title: Text('Menyimpan Data..',),
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
                              height: 50,

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
      ),
    );

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: env.myFont),
        home: (
            Scaffold(
              //resizeToAvoidBottomInset : false,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(height: (contentHeight *0.13),
                      padding: EdgeInsetsDirectional.only(top: 30),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Container(width: 40,),
                          Icon(Icons.list,size: 30,),
                          Container(child: Text('Usulan Penelitian',
                            style: TextStyle(fontSize: 17,

                            ),
                          ),
                            padding: EdgeInsetsDirectional.only(start: 8),),
                          //Container(child: Text('...'),)
                        ],
                      ),
                      color: CupertinoColors.white,),
                    Container(
                      //color : Colors.black,
                      height: (contentHeight *0.82),
                      //padding: EdgeInsetsDirectional.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                  height: (contentHeight * 0.8),
                                  child: awal
                              ),
                            ],
                          ),
                        ],),
                    ),

                    //NavigationDestination(icon: icon, label: label,),
                    BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      iconSize: 20,
                      items: [
                        BottomNavigationBarItem(icon: Icon(Icons.keyboard_double_arrow_left,color: Colors.black54),label: 'Kembali'),
                        BottomNavigationBarItem(icon: Icon(Icons.filter_list,color: Colors.black54),label: 'Daftar'),
                        BottomNavigationBarItem(icon: Icon(Icons.book,color: Colors.black54,),label: 'Laporan'),
                        BottomNavigationBarItem(icon: Icon(Icons.add_circle,color: Colors.black54),label: 'Baru',backgroundColor: Colors.black87),
                      ],
                      backgroundColor: CupertinoColors.white,
                      elevation: 0,
                      currentIndex: curin,
                      onTap: (value) {
                        switch(value){
                          case 0 : Navigator.of(context).pop(); break;
                          case 1 : getList(); break;
                          case 2 : getListLaporan(); break;
                          case 3 : setState(() {
                            curin = 3;
                            awal = formPenelitian;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ))
    );
  }

  resetForm() {
    nomor = '';
    tanggal = '';

    pelaksana = '';
  }

  Future<void> store() async {

     await http.post(
      Uri.https('api-litbang.btx.co.id', 'api/usulan-penelitian/create'),
      body: {

        'nomor' : nomor,
        'tanggal' : tanggal,
        'usulan' : usulan,
        'pengusul' : pengusul,
        'latar_belakang' : latar_belakang,
        'tujuan' : tujuan,
        'email' : email,
        'instansi' :instansi.toString(),
        'nomor_kontak' : nomor_kontak,
        'lokasi' : lokasi,
        'faktor_pendukung' : faktor_pendukung,
        'faktor_penghambat' : faktor_penghambat,
        'external' : '0',
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

  getList() async {
    showDialog(context: context, builder: (BuildContext cc) {
      ex = cc;
      return AlertDialog(title: Center(child: new CircularProgressIndicator()),);
    },);
    var response = await http.get(
      Uri.https(env.apiUrl, 'api/usulan-penelitian/list'),
      headers: {
        'Content-Type' : 'aplication/json; charset=UTF-8',
      },

    ).then((value) {
      // setState(){

      var listData = jsonDecode(value.body)['data'];
      print(listData);
      setState(() {
        curin = 1;
        myList = ListView.separated(itemBuilder: (context,index){
          return Container(
              padding: EdgeInsetsDirectional.all(10),
              height: 100,
              decoration: BoxDecoration(
                // border: BorderDirectional(),
                  borderRadius: BorderRadius.circular(20),
                  color: CupertinoColors.white
              ),
              child:
              TextButton(
                onPressed: (){
                  setState(() {
                    awal = FormEdit(listData[index]);
                  });
                },
                child: Row(children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text((index+1).toString(), style: TextStyle(fontSize: 11, color: Colors.black), ),
                      width: 50,
                      padding: EdgeInsets.all(20),
                      //color: Colors.lightBlue,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadiusDirectional.circular(20)
                      ),
                    ),
                  ),
                  Expanded(
                    flex:11,
                    child: Container(
                        padding: EdgeInsetsDirectional.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(listData[index]['usulan'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                overflow: TextOverflow.ellipsis
                              ),),
                            Container(
                              padding: EdgeInsetsDirectional.all(3),
                              child: Text(listData[index]['lingkup_data'] == null ? 'Instansi Tidak Ditemukan!' : listData[index]['lingkup_data']['nama'],
                                style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 11,
                                  overflow: TextOverflow.ellipsis
                                ),),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(border: Border(),
                          //color: Colors.black12
                        )
                    ),
                  ),
                  Expanded(
                      flex:3,
                      child: Container(child: Text(listData[index]['status'].toString()),))
                ],),
              )
          );
        },
          separatorBuilder: (context, index) => Container(height: 13,
            decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(20)),
          ),
          itemCount:listData.length,
        );
        awal = myList;
      });
    }).whenComplete(( ) {
      setState(() {

      });
      Navigator.of(ex).pop();
    });

  }

  getListLaporan() async {

    String _mytoken = await SessionManager().get('_token');
    showDialog(context: context, builder: (BuildContext cc) {
      ex = cc;
      return AlertDialog(title: Center(child: new CircularProgressIndicator()),);
    },);
    await http.get(
      Uri.https(env.apiUrl, 'api/pelaporan/list/penelitian'),
      headers: {
        'Content-Type' : 'aplication/json; charset=UTF-8',
        'Authorization': 'Bearer ${_mytoken.toString()}'

      },

    ).then((value) {
      // setState(){
      var listData = jsonDecode(value.body)['data'];
      print(listData);
      setState(() {
        curin = 2;
        listLaporan = Column(
         children: [
           Container(
             padding: EdgeInsetsDirectional.only(start: 10,end: 10),
             child: Column(
             children: [
               Container(height: 10,),
               Row(
                 children: [
                   Expanded(
                     flex: 8,
                     child: Container(
                       //height: 60,
                         padding: EdgeInsetsDirectional.all(5),
                         child: TextButton(
                           child: Text('Public Password',
                             style: TextStyle(
                               fontSize: 16,
                               color: Colors.white,),),
                           onPressed: (){
                             getPasswordList();
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
                   Expanded(
                       flex:2,
                       child: Container(
                         // decoration: BoxDecoration(
                         //   border: Border.all()
                         // ),
                         child: IconButton(onPressed: (){
                           setState(() {
                             getListLaporan();
                           });
                         }, icon: Icon(Icons.refresh),
                           tooltip: 'Refresh Laporan',),
                       )
                   )
                 ],
               ),
               Container(height: 5,),
             ],
           ),),
           Container(
             padding: EdgeInsetsDirectional.all(10),
             height: tinggiKonten * 0.7,
             child:  ListView.separated(itemBuilder: (context,index){
               return Container(
                   padding: EdgeInsetsDirectional.all(5),
                   height: 175,
                   decoration: BoxDecoration(
                     // border: BorderDirectional(),
                       borderRadius: BorderRadius.circular(20),
                       color: CupertinoColors.white
                   ),
                   child:
                   TextButton(
                     onPressed: (){
                     },
                     child: Row(children: [
                       Expanded(
                         flex:11,
                         child: Container(
                             padding: EdgeInsetsDirectional.all(8),
                             alignment: Alignment.centerLeft,
                             child: SingleChildScrollView(
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text(listData[index]['judul'],
                                     style: TextStyle(
                                         color: Colors.black,
                                         fontSize: 13,
                                         overflow: TextOverflow.ellipsis
                                     ),),
                                   SizedBox(height: 5,),
                                   Container(
                                     child: Text(listData[index]['penulis'] + ' - ' + listData[index]['tahun'].toString(),
                                       style: TextStyle(
                                           color: Colors.black54,
                                           fontSize: 14,
                                           overflow: TextOverflow.ellipsis,
                                         fontWeight: FontWeight.bold
                                       ),),
                                   ),
                                   SizedBox(height: 8,),
                                   Container(
                                     child: Row(
                                       children: [
                                         Text('Download Berkas',
                                           style: TextStyle(
                                               color: Colors.black54,
                                               fontSize: 14,
                                               overflow: TextOverflow.ellipsis
                                           ),),
                                         IconButton(onPressed: (){
                                           launchUrlString('${env.webUrl}/files-attachment/laporan-penelitian/${listData[index]['dokumen'].toString()}',
                                                              mode:LaunchMode.externalApplication );
                                         }, icon: Icon(Icons.download))
                                       ],
                                     ),
                                   ),

                                 ],
                               ),
                             ),
                             decoration: BoxDecoration(border: Border(),
                               //color: Colors.black12
                             )
                         ),
                       ),
                       // Expanded(
                       //     flex:2,
                       //     child: Row(
                       //       children: [
                       //         IconButton(onPressed: (){
                       //           launchUrlString('${env.webUrl}/files-attachment/laporan-penelitian/${listData[index]['dokumen'].toString()}',
                       //               mode:LaunchMode.externalApplication );
                       //         }, icon: Icon(Icons.file_open,color: Colors.blueAccent,),
                       //           tooltip: 'Buka File',),
                       //       ],
                       //     )
                       // )
                     ],),
                   )
               );
             },
               separatorBuilder: (context, index) => Container(height: 13,
                 decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(20)),
               ),
               itemCount:listData.length,
             ),
           ),
         ],
        );
        awal = listLaporan;
      });
    }).whenComplete(( ) {
      Navigator.of(ex).pop();
    });

  }

  getPasswordList() async {

    var _mytoken = await SessionManager().get('_token');
    showDialog(context: context, builder: (BuildContext cc) {
      ex = cc;
      return AlertDialog(title: Center(child: new CircularProgressIndicator()),);
    },);
    var response = await http.post(
      Uri.https(env.apiUrl, 'api/pelaporan/get/user-by-tipe'),
      headers: {
        'Authorization': 'Bearer ${_mytoken}'  },
      body: {
        'tipe' : 'penelitian'
      }
    ).then((value){

      var respon = jsonDecode(value.body);
      Navigator.of(ex).pop();
      if(respon['status'] == true){
        var listPassword = jsonDecode(value.body)['data'];
        setState(() {
          myList = ListView.separated(itemBuilder: (context,index){
            return Container(
                padding: EdgeInsetsDirectional.all(15),
                height: 100,
                decoration: BoxDecoration(
                  // border: BorderDirectional(),
                    borderRadius: BorderRadius.circular(20),
                    color: CupertinoColors.white
                ),
                child:
                TextButton(
                  onPressed: (){
                    setState(() {

                    });
                  },
                  child: Row(children: [

                    Expanded(
                      flex:11,
                      child: Container(
                          padding: EdgeInsetsDirectional.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(listPassword[index]['username'],
                                style: TextStyle(color: Colors.black,fontSize: 14,),),
                              Container(
                                padding: EdgeInsetsDirectional.all(3),
                                child: Text(listPassword[index]['password'] == null ? '-' : listPassword[index]['password'],
                                  style: TextStyle(color: Colors.black38, fontSize: 11,),),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(border: Border(),
                            //color: Colors.black12
                          )
                      ),
                    ),

                  ],),
                )
            );
          },
            separatorBuilder: (context, index) => Container(height: 13,
              decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(20)),
            ),
            itemCount:listPassword.length,
          );
          awal = Column(
            children: [
              Container(height: 5,),
              Container(
                height: 60,
                decoration: BoxDecoration(
                    color: CupertinoColors.white
                ),
                child: Row(
                  children: [
                    Expanded(child: Container(
                      padding: EdgeInsetsDirectional.all(3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(15)
                         // border: Border.all()
                      ),
                      child: IconButton(onPressed: (){
                        tambahPublic();
                      },icon: Icon(Icons.add),),
                    )),
                    Expanded(child: Container(
                      padding: EdgeInsetsDirectional.all(3),
                      decoration: BoxDecoration(
                         // border: Border.all(),
                         borderRadius: BorderRadiusDirectional.circular(15)
                      ),
                      child: IconButton(onPressed: (){
                        getPasswordList();
                      },icon: Icon(Icons.refresh),),
                    ))
                  ],
                ),
              ),
              Container(
                  height: tinggiKonten *0.80 -70,
                  child: myList
              ),
            ],
          );
        });

      }
      else{
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text('Silahkan Login!'),
            content: Text(respon['message']),
          );
        });
      }

    });

  }

  tambahPublic(){
    username = '';
    password = '';

    setState(() {
      awal = Column(
        children: [
          Container(
              padding: EdgeInsetsDirectional.all(15),
              height: 80,
              decoration: BoxDecoration(
                // border: BorderDirectional(),
                  borderRadius: BorderRadius.circular(20),
                  color: CupertinoColors.white
              ),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(

                        child: IconButton(onPressed: (){
                          getPasswordList();
                        }, icon: Icon(Icons.keyboard_double_arrow_left)),
                      )),
                  Expanded(
                    flex:5,
                    child: Container(
                      child: Text('Buat Akun Publik Baru',
                        style: TextStyle(fontSize: 14, color: Colors.black,

                            fontWeight: FontWeight.bold
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
                      child: Text('Username',
                        style: TextStyle(fontSize: 14, color: Colors.black,

                        ),
                      ),
                      padding: EdgeInsetsDirectional.all(13),
                      decoration: BoxDecoration(
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
                            username = e;
                          },
                          controller: TextEditingController(text: username),
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
                      child: Text('Password',
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

                            }, icon: Icon(Icons.generating_tokens)),
                          ),
                          onChanged: (e){
                            password = e;
                          },
                          controller: TextEditingController(text: password),
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
                          child: Text('Simpan',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,),),
                          onPressed: (){
                            savePublicUser();
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
    });

  }

  savePublicUser() async {
    var _mytoken = await SessionManager().get('_token');
    showDialog(context: context, builder: (BuildContext cc) {
      ex = cc;
      return AlertDialog(
        title: Center(child: new CircularProgressIndicator()),);
    },);
    var response = await http.post(
        Uri.https(env.apiUrl, 'api/pelaporan/add-user'),
        headers: {
          'Authorization': 'Bearer ${_mytoken}'},
        body: {
          'tipe': 'penelitian',
          'username': username,
          'password': password
        }
    ).then((value) {
      var respon = jsonDecode(value.body);
      Navigator.of(ex).pop();
      print(respon);

      if (respon['status'] == true) {
        showDialog(context: ex, builder: (context) {
          return AlertDialog(
            title: Text('Berhasil!'),

          );
        });
      }
      else {
        showDialog(context: ex, builder: (context) {
          return AlertDialog(
            title: Text('Silahkan Login!'),
            content: Text(respon['message']),
          );
        });
      }
    });
  }

  getInstansi() async {
    await http.get(
      Uri.https(env.apiUrl, 'api/instansi/list'),
      headers: {
        'Content-Type' : 'aplication/json; charset=UTF-8',
        'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImZkNDQzZGJhMzdkY2NjNTQzYmU4MTkzOWY0OTQ0MTkzZDc1YzZjYzcxNDY1YjBjOTIxOGE4MWM3NzVkZTkwNTM2Yjk1M2M4N2FjNGE0ODY4In0.eyJhdWQiOiIyIiwianRpIjoiZmQ0NDNkYmEzN2RjY2M1NDNiZTgxOTM5ZjQ5NDQxOTNkNzVjNmNjNzE0NjViMGM5MjE4YTgxYzc3NWRlOTA1MzZiOTUzYzg3YWM0YTQ4NjgiLCJpYXQiOjE2NjE5Mjg1OTgsIm5iZiI6MTY2MTkyODU5OCwiZXhwIjoxNjYxOTQ2NTk3LCJzdWIiOiIxNSIsInNjb3BlcyI6WyIqIl19.SUO0yl0Zqtzmn0ex_uR-vlh2mxXgjl1-am6MxpkcAal9aHt8nSLyOOBAFn4bTy3Szx2HJGMv_k5bzZ-JTU_yfHU5rqcYjjCWYclFoh8P1RWrhrFySxG_mNzbm5fDEB7913Wm5y5qRgt-ffOIYjYGQ1XX0EjU2bAgvdAFGA41g4r5KGT2-D88EGw1gQ8knRTxZOcIv_kqkCvQsGI4Ov3KGGgcYfi_7Q5nrNRqEPthycFMtUlX0QoFh-M2FRItE86ElVGSYREK6tt9vBsvhi07azBLQdShneFa8YNAg_lrhk0PQ4SKifpzCDdumyJNtNDDIqgsaMUiWMu9O0zZUxzHX-HYtuixDTWznjJm2DPWNUUfnClNIUpS7rautiie9aZvDV-BpLY6AO4xc_9omAzedytBbI7nivzy-M0tfv1MqnhmeggKNaSPhGiIqGKXedEjzhsVuaX7AZqdj5e7BqMUm-MnTD2A78VYyaYZhr9Soii98rzmgp8JzpLxFwaU-RsMfDMc5nU0_OOJ7hgagzDyh4HUxZEOqJgrPq8IPWAEvRiErxUNJlyxgGmt7BCebvS9Sq-ZqVUJGCo1LrvGTvAAFwZ9VjzmzAHwxUPfboStUt-W1TjzTUuV00YOqcETiFnnwq3c9yY02xoIsv9iCc56_A_idARPkcZWyOIzgldI6d0',
      },

    ).then((value) {
      listInstansi = jsonDecode(value.body)['data'];

    });
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        getList();
        getInstansi();
      });
    });
  }

}

