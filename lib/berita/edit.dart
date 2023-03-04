import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../myenv.dart';


class FormEdit extends StatefulWidget{
  Map dataKelitbangan = {};
  FormEdit(Map data){
    this.dataKelitbangan = data;

  }
  @override
  State<FormEdit> createState() => _FormEditState(dataKelitbangan);
}

class _FormEditState extends State<FormEdit> {
  MyEnvironments env = new MyEnvironments();
  Map myData = {};

  String id = '0';
  String tanggal = '';
  String judul = '';
  String deskripsi = '';
  String namaFile = '';
  List<Widget> fileSaya = [];
  List<Map> attachment = [];
  List<Widget> childFile = [];



  Map attachWidget = {};
  Map attachFile = {};

  Widget listAttachment = Center(child: Text('Tidak Ada File'),);

  _FormEditState(Map myData){
    this.myData     = myData;
    this.judul       = myData['judul']        == null ? '-' : myData['judul'];
    this.tanggal    = myData['tanggal']     == null ? '-' : myData['tanggal'];
    this.deskripsi     = myData['deskripsi']  == null ? '-' : myData['deskripsi'];
    this.id = myData['id'].toString();

  }

  List listInstansi = [];
  late BuildContext updel;
  @override
  Widget build(BuildContext context) {

    return Container(
      height : (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) * 0.82,
      child: ListView(
        children: [
          Container(
              padding: EdgeInsetsDirectional.all(5),
              height: 200,
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
                      child: Text('Judul Berita',
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
                            judul = e;
                          },
                          minLines: 3,
                          maxLines: 5,
                          controller: TextEditingController(text: judul),
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
              height: 200,
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
                          child: Text('hapus',
                            style: TextStyle(fontFamily: 'Poppins',
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

        getData();
      });
    });
  }
  Future<void> getData() async {

    showDialog(context: context, builder: (BuildContext upd){
      updel = upd;
      return AlertDialog(
        title: Column(
          children: [
            Text( 'Mengambil Data...' ),
            Center(child: new CircularProgressIndicator())
          ],
        ),
      );
    });

    var _mytoken = await SessionManager().get('_token');

    await http.post(
      Uri.https(env.apiUrl, 'api/berita/get/id'),
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
        deskripsi = dec['data']['deskripsi'];
        print(deskripsi);
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

  Future<void> update() async {

    showDialog(context: context, builder: (BuildContext upd){
      updel = upd;
      return AlertDialog(
        title: Text( 'Mengupdate Data...' ),
        content: Center(child: new CircularProgressIndicator()),
      );
    });

    var _mytoken = await SessionManager().get('_token');

    await http.post(
      Uri.https(env.apiUrl, 'api/berita/update'),
      headers: {
        //'Content-Type' : 'aplication/json;',
        'Authorization': 'Bearer ${_mytoken.toString()}'
      },
      body: {
        'id' : id.toString(),
        'tanggal' : tanggal,
        'judul': judul,
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
            Text( 'Menghapus Data...', style: TextStyle(fontFamily: 'Poppins') ),
            Center(child: new CircularProgressIndicator()),
          ],
        ),
      );
    });

    var _mytoken = await SessionManager().get('_token');

    await http.post(
      Uri.https(env.apiUrl, 'api/berita/delete'),
      headers: {
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

  confirmDelete(){
    showDialog(context: context, builder: (BuildContext conf){
      updel = conf;
      return AlertDialog(
        title: Text( 'Akan Menghapus Data?',style: TextStyle(fontFamily: 'Poppins') ),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(updel).pop();
            delete();
          },
              child: Text('Ya',
                style: TextStyle(fontFamily: 'Poppins'),)),
          TextButton(onPressed: (){
            Navigator.of(updel).pop();
          },
              child: Text('Batal',
                style: TextStyle(fontFamily: 'Poppins'),)),
        ],
      );
    });
  }

  getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      String dirAttchment = '/var/www/litbang_b/litbang/public/attachment/';

      PlatformFile pickFile = result.files.first;
      File file = File(pickFile.path.toString());
      namaFile = pickFile.name;
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
    var request = http.MultipartRequest("POST",Uri.https('litbang.btx.co.id', '/upload-regulasi'));

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