
import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_litbang/myenv.dart';

class LaporanInovasi extends StatefulWidget{

  _LaporanInovasi createState() => _LaporanInovasi();
}

class _LaporanInovasi extends State<LaporanInovasi>{

  MyEnvironments env = new MyEnvironments();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: env.myFont),
        debugShowCheckedModeBanner: false,
        home:Scaffold(
           // resizeToAvoidBottomInset: false,
            appBar: AppBar(title: Text('Pelaporan Inovasi', style: TextStyle(),),
              backgroundColor: Colors.blue.shade800,
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

  String nama_skpd = '';
  String nama_unit = '';
  String nama_inovasi = '';
  String nomor_sk_inovasi = '';
  String tanggal_sk_inovasi = '';
  String jumlah_pelaksana_inovasi = '';
  String inisiator_daerah_inovasi = '';
  String urusan_inovasi_daerah = '';
  String waktu_uji_coba = '';
  String waktu_diterapkan = '';
  String rancang_bangun = '';
  String tujuan = '';
  String manfaat = '';
  String hasil = '';

  String jenisInovasi = 'Digital';
  List listJenisInovasi = [
    'Digital',
    'Non Digital'
  ];
  String bentukInovasi = '';
  List listBentukInovasi = [
  'Inovasi Tata Kelola Pemerintahan Daerah',
  'Inovasi Pelayanan Publik',
  'Inovasi bentuk lainnya sesuai bidang urusan pemerintahan yang menjadi kewenangan Daerah',

  ];
  String inovasiTematik = '';
  List listInovasiTematik = [
  'Penanggulangan Covid-19',
  'Penanganan tata kelola Smart-City',
  'Peningkatan PAD',
  ];

  late BuildContext simpan;
  TextStyle formText = TextStyle(
    fontWeight: FontWeight.bold,
  );

  double borderRd = 10;
  TextStyle poppin = TextStyle();

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
                                Text("Nama SKPD", style: formText,),
                                Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRd))
                                      ),
                                      onChanged: (e){
                                        nama_skpd = e;
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
                                Text("Nama Unit", style: formText,),
                                Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRd))
                                      ),
                                      onChanged: (e){
                                        nama_unit = e;
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
                        flex: 12,
                        child: Container(
                          padding: EdgeInsetsDirectional.all(10),
                          height: 130,
                          decoration: BoxDecoration(
                            // border: BorderDirectional(),
                              borderRadius: BorderRadius.circular(20),
                              color: CupertinoColors.white
                          ),
                          child:  Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Nama Inovasi", style: formText,),
                                Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRd))
                                      ),
                                      minLines: 3,
                                      maxLines: 10,
                                      onChanged: (e){
                                        nama_inovasi = e;
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
                                Text("Nomor SK Inovasi",style: formText),
                                Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRd)),

                                          // suffixIcon: IconButton(onPressed: (){
                                          //
                                          // }, icon: Icon(Icons.numbers_sharp),)
                                      ),
                                      onChanged: (e){
                                        nomor_sk_inovasi = e;
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
                                Text("Tanggal SK Inovasi",style: formText),
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
                                                tanggal_sk_inovasi = value.toString().split(" ")[0];
                                              })
                                            });
                                          }, icon: Icon(Icons.date_range),)
                                      ),
                                      controller: TextEditingController(text: tanggal_sk_inovasi),
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
                                Text("Jumlah Pelaksana", style: formText),
                                Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRd))
                                      ),
                                      maxLines: 10,
                                      minLines: 3,
                                      onChanged: (v){
                                        jumlah_pelaksana_inovasi = v;
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
                                Text("Inisiator Daerah", style: formText),
                                Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRd))
                                      ),
                                      maxLines: 10,
                                      minLines: 3,
                                      onChanged: (v){
                                        inisiator_daerah_inovasi = v;
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
                                Text("Jenis Inovasi",style: formText),
                                Expanded(
                                    child: DropdownButtonFormField2(
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
                                      //value: null,
                                      isExpanded: true,
                                      hint: const Text(
                                        'Pilih Jenis Inovasi',
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
                                      items: listJenisInovasi
                                          .map((item) =>
                                          DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,

                                              ),
                                            ),
                                          ))
                                          .toList(),
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Silahkan Pilih Jenis Inovasi.';
                                        }
                                      },
                                      onChanged: (value) {
                                        print(value);
                                        inovasiTematik = value as String;
                                        //Do something when changing the item if you want.
                                      },
                                      onSaved: (value) {
                                        inovasiTematik = value as String;
                                      },
                                    ),
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
                          height: 130,
                          decoration: BoxDecoration(
                            // border: BorderDirectional(),
                              borderRadius: BorderRadius.circular(20),
                              color: CupertinoColors.white
                          ),
                          child:  Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Bentuk Inovasi",style: formText),
                                Expanded(
                                  child: DropdownButtonFormField2(
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
                                    //value: null,
                                    isExpanded: true,
                                    hint: const Text(
                                      'Pilih Bentuk Inovasi',
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
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    items: listBentukInovasi
                                        .map((item) =>
                                        DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,

                                            ),
                                          ),
                                        ))
                                        .toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Silahkan Pilih Bentuk Inovasi.';
                                      }
                                    },
                                    onChanged: (value) {
                                      print(value);
                                      bentukInovasi = value as String;
                                      //Do something when changing the item if you want.
                                    },
                                    onSaved: (value) {
                                      bentukInovasi = value as String;
                                    },
                                  ),
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
                                Text("Inovasi Tematik",style: formText),
                                Expanded(
                                  child: DropdownButtonFormField2(
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
                                    //value: null,
                                    isExpanded: true,
                                    hint: const Text(
                                      'Pilih Inovasi Tematik',
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
                                    items: listInovasiTematik
                                        .map((item) =>
                                        DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,

                                            ),
                                          ),
                                        ))
                                        .toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Silahkan Pilih Inovasi Tematik.';
                                      }
                                    },
                                    onChanged: (value) {
                                      print(value);
                                      jenisInovasi = value as String;
                                      //Do something when changing the item if you want.
                                    },
                                    onSaved: (value) {
                                      jenisInovasi = value as String;
                                    },
                                  ),
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
                                Text("Urusan Inovasi Daerah", style: formText),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRd))
                                    ),
                                    minLines: 10,
                                    maxLines: 100,
                                    onChanged: (v){
                                      urusan_inovasi_daerah = v;
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
                                Text("Waktu Uji Coba",style: formText),
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
                                                waktu_uji_coba = value.toString().split(" ")[0];
                                              })
                                            });
                                          }, icon: Icon(Icons.date_range),)
                                      ),
                                      controller: TextEditingController(text: waktu_uji_coba),
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
                                Text("Waktu Diterapkan",style: formText),
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
                                                waktu_diterapkan = value.toString().split(" ")[0];
                                              })
                                            });
                                          }, icon: Icon(Icons.date_range),)
                                      ),
                                      controller: TextEditingController(text: waktu_diterapkan),
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
                                Text("Rancang Bangun", style: formText),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRd))
                                    ),
                                    minLines: 10,
                                    maxLines: 100,
                                    onChanged: (v){
                                      rancang_bangun = v;
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
                                Text("Tujuan", style: formText),
                                Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRd)),
                                      ),
                                      minLines: 10,
                                      maxLines: 100,
                                      onChanged: (v){
                                        tujuan = v;
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
                                Text("Manfaat", style: formText),
                                Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRd)),
                                      ),
                                      minLines: 10,
                                      maxLines: 100,
                                      onChanged: (v){
                                        manfaat = v;
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
                                Text("Hasil", style: formText),
                                Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRd)),
                                      ),
                                      minLines: 10,
                                      maxLines: 100,
                                      onChanged: (v){
                                        hasil = v;
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
      ],);
  }

  Future<void> store() async {
    print('Store Laporan Inovasi');
    await http.post(
      Uri.https(env.apiUrl, 'api/pelaporan/create-inovasi'),
      body: {

        'nama_skpd': nama_skpd,
        'nama_unit':nama_unit,
        'nama_inovasi': nama_inovasi,
        'nomor_sk_inovasi': nomor_sk_inovasi,
        'tanggal_sk_inovasi': tanggal_sk_inovasi,
        'jumlah_pelaksana_inovasi': jumlah_pelaksana_inovasi,
        'inisiator_daerah_inovasi': inisiator_daerah_inovasi,
        'urusan_inovasi_daerah': urusan_inovasi_daerah,
        'waktu_uji_coba': waktu_uji_coba,
        'waktu_diterapkan': waktu_diterapkan,
        'rancang_bangun': rancang_bangun,
        'tujuan':tujuan,
        'manfaat': manfaat,
        'hasil': hasil,

        'jenis_inovasi': jenisInovasi,
        'bentuk_inovasi': bentukInovasi,
        'inovasi_tematik': inovasiTematik,

      },
    ).then((value){

      var dec = jsonDecode(value.body);
      print(dec);
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
}



