
import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:prototype_litbang/myenv.dart';

class LaporanPenelitian extends StatefulWidget{

  _LaporanPenelitian createState() => _LaporanPenelitian();
}

class _LaporanPenelitian extends State<LaporanPenelitian>{
  MyEnvironments env = new MyEnvironments();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: env.myFont),
        home:Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(title: Text('Pelaporan Penelitian',),
              backgroundColor: Colors.blue.shade900,
              //Color.fromRGBO(12, 12, 220, 100),
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

  _FormDataState(){
    for (var i = 2017; i <= 2026; i++){
      pilihanTahun.add(i);
    }
  }

  List pilihanTahun = [];
  Widget listAttachment = Center(child: Text('Tidak Ada File'),);

  List<Widget> fileSaya = [];
  List<Map> attachment = [];
  List<Widget> childFile = [];

  Map attachWidget = {};
  Map attachFile = {};

  String penulis = '';
  String judul = '';
  String tahun = '';
  String usulan = '';
  String doks = '';

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
                                Text("Penulis / Penyusun",style: formText),
                                Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRd))
                                      ),
                                      minLines: 2,
                                      maxLines: 5,
                                      onChanged: (v){
                                        penulis = v;
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
                          height: 160,
                          decoration: BoxDecoration(
                            // border: BorderDirectional(),
                              borderRadius: BorderRadius.circular(20),
                              color: CupertinoColors.white
                          ),
                          child:  Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Judul", style: formText),
                                Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRd))
                                      ),
                                      maxLines: 10,
                                      minLines: 5,
                                      onChanged: (v){
                                        judul = v;
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
                      height: 150,
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
                              child: Text('Tahun',
                                style: TextStyle(fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
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
                                padding: EdgeInsetsDirectional.all(10),
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
                                  //value: instansi as int,
                                  isExpanded: true,
                                  hint: const Text(
                                    'Pilih Tahun',
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
                                  items: pilihanTahun
                                      .map((item) =>
                                      DropdownMenuItem<int>(
                                        value: item,
                                        child: Text(
                                          item.toString(),
                                          style: const TextStyle(
                                            fontSize: 14,

                                          ),
                                        ),
                                      ))
                                      .toList(),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Silahkan Plih Tahun!';
                                    }
                                  },
                                  onChanged: (value) {
                                    print(value);
                                    tahun = value.toString();
                                    //Do something when changing the item if you want.
                                  },
                                  onSaved: (value) {
                                    value = value.toString();
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Dokumen", style: formText),
                                    IconButton(onPressed: (){
                                      getFile();
                                    }, icon: Icon(Icons.add_circle)),
                                  ],
                                ),
                                Container(
                                  height: 100,
                                    child: SingleChildScrollView(child: Column( children: childFile,))),

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
                                      style: TextStyle(fontFamily: 'Poppins', color: Colors.white),)))
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

    await http.post(
      Uri.https(env.apiUrl, 'api/pelaporan/create-penelitian'),
      body: {
        'penulis': penulis,
        'judul': judul,
        'tahun': tahun,
        'dokumen':doks,

      },
    ).then((value){

      var dec = jsonDecode(value.body);
      Navigator.of(simpan).pop();
      if(dec['status'] == true){
        uploadFile();
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

  getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],

    );

    if (result != null) {
      String dirAttchment = '/var/www/litbang_b/litbang/public/attachment/';

      PlatformFile pickFile = result.files.first;
      File file = File(pickFile.path.toString());
      doks = pickFile.name.toString().replaceAll(' ', '-');

      childFile.clear();

      setState(()  {
        attachFile[pickFile.name] = file;
        attachWidget[pickFile.name]=  Container(
            child: Row(
              children: [
                Expanded(
                    flex: 8,
                    child: Text(pickFile.name)),
                Expanded(
                    flex: 1,
                    child: IconButton(onPressed: (){
                      print('Open File');
                      OpenFile.open(pickFile.path.toString());
                    },icon: Icon(Icons.remove_red_eye, size: 18,),)),
                Expanded(
                    flex: 2,child: IconButton(onPressed: (){
                  setState((){
                    childFile.clear();
                    attachWidget.remove(pickFile.name);
                    attachWidget.forEach((key, value) {
                      childFile.add(value);
                      attachment.add({
                        'nama' : pickFile.name.toString().replaceAll(" ", "-"),
                        'url':  dirAttchment+key.toString().replaceAll(" ", "-"),
                        'tipe': 'application',
                      });
                    });

                    attachFile.remove(pickFile.name);
                    print(attachWidget);
                    print(attachFile);
                  });
                },icon: Icon(Icons.cancel_outlined, size: 18,),)),
              ],
            ));
        attachWidget.forEach((key, value) {
          childFile.add(value);
          attachment.add({
            'nama' : pickFile.name.toString(),
            'url':  dirAttchment+key.toString().replaceAll(" ", "-"),
            'tipe': 'application',
          });
        });
        print(childFile);
      });
    } else {
      // User canceled the picker
    }
  }

  uploadFile() async{
    var request = http.MultipartRequest("POST",Uri.https(env.webPoint, '/upload-laporan-penelitian'));

    attachFile.forEach((key, value) {
      request.files.add(
          http.MultipartFile(
            key.toString(),
            value.readAsBytes().asStream(),
            value.lengthSync(),
            filename: key.toString(),
          )
      );
    });
    request.send().then((response) async {
      if (response.statusCode == 200) print("Uploaded!");
      print(await response.stream.bytesToString());
      //print(response.reasonPhrase);
    });
  }

  hapusFile (int id) async{

    fileSaya.removeAt(id);
    attachment.removeAt(id);

    setState(() {
      listAttachment = ListView(children: fileSaya,);
    });

  }
}



