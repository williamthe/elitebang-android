
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../myenv.dart';


class FormEdit extends StatefulWidget{
  Map dataKelitbangan = {};
  String pelaksana = '';
  FormEdit(Map data){

    this.dataKelitbangan = data;
    if(data['pelaksana'] == null){
      this.pelaksana =  '-';
    }else{
      if(data['pelaksana'].runtimeType != String){
        for (var age in data['pelaksana']) {
          this.pelaksana += age['nama']+"\n";
        }
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
  String tanggal = '';
  String judul = '';
  int instansi = 1;
  String rangkuman = '';
  String tipe = '';

  String abstrak = '';
  String tindakLanjut = '';
  String nomor = '';
  String pelaksana = '';

  List listTipe = [ 'Fisik', 'Non Fisik'];

  List<Widget> fileSaya = [];
  List<Map> attachment = [];
  List<Widget> childFile = [];

  Map attachWidget = {};
  Map attachFile = {};

  Widget listAttachment = Center(child: Text('Tidak Ada File'),);

  Widget fileSayaRangkuman = Container();
  List<Map> attachmentRangkuman = [];
  List<Widget> childFileRangkuman = [];

  Map attachWidgetRangkuman = {};
  Map attachFileRangkuman = {};
  Widget listAttachmentRangkuman = Center(child: Text('Tidak Ada File'),);

  Widget winstansi = Container();
  double formFont = 13;


  _FormEditState(Map myData){
    this.myData       = myData;
    this.nomor        = myData['nomor']         == null ? '-' : myData['nomor'];
    this.judul        = myData['judul']         == null ? '-' : myData['judul'];
    this.tanggal      = myData['tanggal']       == null ? '-' : myData['tanggal'];
    this.instansi     = myData['lingkup']       == null ? 1 : myData['lingkup'];
    this.rangkuman    = myData['rangkuman']       == null ? '-' : myData['rangkuman'];
    this.tipe         = myData['tipe']       == null ? 1 : myData['tipe'];
    this.abstrak      = myData['abstrak']       == null ? '-' : myData['abstrak'];
    this.tindakLanjut = myData['tindak_lanjut'] == null ? '-' : myData['tindak_lanjut'];
    this.id           = myData['id']            == null ? '0' : myData['id'].toString();
    this.pelaksana    = myData['pelaksana']     == null ? '-' : myData['pelaksana'];


    for (var age in myData['attachment']) {
      var st= Map<String, dynamic>.from(age);
      attachWidget[st['nama']] = Container(child: Row(
        children: [
          Expanded(
              flex: 8,
              child: Container(child: Text(st['nama'].toString()))),
          Expanded(
              flex: 1,
              child: IconButton(onPressed: (){
                launchUrlString("${env.webUrl}/files-attachment/laporan-kelitbangan/${st['nama'].toString()}",
                    mode:LaunchMode.externalApplication );
              }, icon: Icon(Icons.remove_red_eye, size: 20,))),
          Expanded(
              flex:2,
              child:
              Container(child: IconButton(onPressed: (){
                setState(() {
                  childFile.clear();
                  attachment.clear();
                  attachWidget.remove(st['nama']);
                  attachWidget.forEach((key, value) {
                    childFile.add(value);
                    attachment.add({
                      'nama': st['nama'],
                      'url': st['url'],
                      'tipe': 'application',
                    });
                  });

                  attachFile.remove(st['nama']);
                });
              }, icon: Icon(Icons.cancel, size: 20))
              )
          ),

        ],
      ),);
      childFile.add(attachWidget[st['nama']]);
      attachment.add({
        'nama' : st['nama'],
        'url':  st['url'],
        'tipe': st['tipe'],
      });
    }

    if(myData['rangkuman'] != null){
      childFileRangkuman.add(Container(child: Row(
        children: [
          Expanded(
              flex: 8,
              child: Container(child: Text(myData['rangkuman'].toString()))),
          Expanded(
              flex: 1,
              child: IconButton(onPressed: (){
                launchUrlString("${env.webUrl}/files-attachment/rangkuman-kelitbangan/${myData['rangkuman'].toString()}",
                    mode:LaunchMode.externalApplication );
              }, icon: Icon(Icons.remove_red_eye, size: 20,))),
          Expanded(
              flex:2,
              child:
              Container(child: IconButton(onPressed: (){
                setState(() {
                  hapusFileRangkuman();
                });
              }, icon: Icon(Icons.cancel, size: 20))
              )
          ),

        ],
      ),));
    }
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
                          style: TextStyle(
                            fontSize: formFont
                          ),
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
          winstansi,
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
                      child: Text('Tipe',
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
                              borderRadius: BorderRadius.circular(15),
                            ),
                            //Add more decoration as you want here
                            //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                          ),
                          value: tipe,
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
                          items: listTipe
                              .map((item) =>
                              DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    // fontFamily: 'Poppins',
                                  ),
                                ),
                              ))
                              .toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'Pilih Tipe';
                            }
                          },
                          onChanged: (value) {
                            print(value);
                            tipe = value.toString() ;
                            //Do something when changing the item if you want.
                          },
                          onSaved: (value) {
                            tipe = value.toString() ;
                          },
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
                            suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.abc_outlined)),
                          ),
                          minLines: 2,
                          maxLines: 10,
                          onChanged: (e){
                            judul = e;
                          },
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
              height: 230,
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
                            suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.texture)),
                          ),
                          minLines: 4,
                          maxLines: 10,
                          onChanged: (e){
                            abstrak = e;
                          },
                          controller: TextEditingController(text: abstrak),
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
                            suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.next_plan_outlined)),
                          ),
                          minLines: 4,
                          maxLines: 10,
                          onChanged: (e){
                            tindakLanjut = e;
                          },
                          controller: TextEditingController(text: tindakLanjut),
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
                            suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.supervised_user_circle_sharp)),
                          ),
                          minLines: 4,
                          maxLines: 10,
                          onChanged: (e){
                            pelaksana = e;
                          },
                          controller: TextEditingController(text: pelaksana),
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
                    flex:5,
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(

                            child: Text('File ${childFile.length}',
                              style: TextStyle(fontSize: 14, color: Colors.black,

                              ),
                            ),

                          ),
                          Container(
                            child: IconButton(onPressed: (){
                              setState(() {
                                getFile();
                              });

                            },
                              icon: Icon(Icons.add_circle),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadiusDirectional.circular(10)
                            ),
                          )
                        ],
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
                        // child: Text(namaFiles),
                        child: ListView(children: [Column(children: childFile,)]),
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
                    flex:5,
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(

                            child: Text('File Rangkuman',
                              style: TextStyle(fontSize: 14, color: Colors.black,

                              ),
                            ),

                          ),
                          Container(
                            child: IconButton(onPressed: (){
                              setState(() {
                                getFileRangkuman();
                              });

                            },
                              icon: Icon(Icons.add_circle),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadiusDirectional.circular(10)
                            ),
                          )
                        ],
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
                        // child: Text(namaFiles),
                        child: ListView(children: [Column(children: childFileRangkuman,)]),
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
                  SizedBox(width: 10,),
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
        winstansi = Container(
            padding: EdgeInsetsDirectional.all(5),
            height: 160,
            decoration: BoxDecoration(
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
                      style: TextStyle(fontSize: 12, color: Colors.black,

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
                        value: instansi,
                        isExpanded: true,
                        hint: const Text(
                          'Pilih Bidang',
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
                            return 'Silahkan Pilih Bidang';
                          }
                        },
                        onChanged: (value) {
                          instansi = value as int;
                          print(instansi);
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
            Center(child: new CircularProgressIndicator())
          ],
        ),
      );
    });

    var _mytoken = await SessionManager().get('_token');
     await http.post(
      Uri.https(env.apiUrl, 'api/kelitbangan/update'),
      headers: {
        //'Content-Type' : 'aplication/json;',
        'Authorization': 'Bearer ${_mytoken.toString()}'
      },
      body: {
        'id' : id.toString(),
        'nomor' : nomor,
        'tanggal' : tanggal,
        'judul' : judul,
        'abstrak' : abstrak,
        'tindak_lanjut' : tindakLanjut,
        'tipe' : tipe,
        'rangkuman' : rangkuman,
        'lingkup' : instansi.toString(),
        'pelaksana' : jsonEncode(pelaksana.toString().split('\n')),
        'attachment' : jsonEncode(attachment),
      },
    ).then((value){
      var dec = jsonDecode(value.body);
      print(dec);
      Navigator.of(updel).pop();
      if(dec['status'] == true){
        uploadFile();
        uploadFileRangkuman();
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
            Text( 'Menghapus Data...',),
            Center(child: new CircularProgressIndicator()),
          ],
        ),
      );
    });

    var _mytoken = await SessionManager().get('_token');

    var response = await http.post(
      Uri.https(env.apiUrl, 'api/kelitbangan/delete'),
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

  confirmDelete(){
    showDialog(context: context, builder: (BuildContext conf){
      updel = conf;
      return AlertDialog(
        title: Text( 'Akan Menghapus Data?' ),
        actions: [
            TextButton(onPressed: (){
              Navigator.of(updel).pop();
              delete();
            },
                child: Text('Ya',
                  )),
            TextButton(onPressed: (){
              Navigator.of(updel).pop();
            },
                child: Text('Batal',
                  )),
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
                    },icon: Icon(Icons.remove_red_eye, size: 20,),)),
                Expanded(
                    flex: 2,child: IconButton(onPressed: (){
                  setState((){
                    childFile.clear();
                    attachWidget.remove(pickFile.name);
                    attachWidget.forEach((key, value) {
                      childFile.add(value);
                      attachment.add({
                        'nama' : pickFile.name.toString(),
                        'url':  dirAttchment+key.toString().replaceAll(" ", "-"),
                        'tipe': 'application',
                      });
                    });

                    attachFile.remove(pickFile.name);
                    print(attachWidget);
                    print(attachFile);
                  });
                },icon: Icon(Icons.cancel_outlined, size: 20,),)),
              ],
            ));
        attachWidget.forEach((key, value) {
          childFile.add(value);
          attachment.add({
            'nama' : pickFile.name.toString().replaceAll(" ", "-"),
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
    var request = http.MultipartRequest("POST",Uri.https(env.webPoint, '/upload-attachment'));

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

  addOldFile(files){

    setState(() {

    });
  }

  getFileRangkuman() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      String dirAttchment = '/var/www/litbang_b/litbang/public/attachment/';

      PlatformFile pickFile = result.files.first;
      File file = File(pickFile.path.toString());
      childFileRangkuman.clear();
      rangkuman = pickFile.name.toString().replaceAll(' ', '-');

      setState(()  {
        attachFileRangkuman[pickFile.name] = file;
        Container(
            child: Row(
              children: [
                Expanded(
                    flex: 8,
                    child: Text(pickFile.name)),
                Expanded(
                    flex: 1,
                    child: IconButton(onPressed: (){
                      print('Open File');    OpenFile.open(pickFile.path.toString());
                    },icon: Icon(Icons.remove_red_eye, size: 18,),)),
                Expanded(
                    flex: 2,child: IconButton(onPressed: (){
                  setState((){
                    childFileRangkuman.clear();
                    attachWidgetRangkuman.remove(pickFile.name);
                    attachWidgetRangkuman.forEach((key, value) {
                      childFileRangkuman.add(value);
                    });

                    attachFileRangkuman.remove(pickFile.name);

                  });
                },icon: Icon(Icons.cancel_outlined, size: 18,),)),
              ],
            ));
        childFileRangkuman.add(Container(
            child: Row(
              children: [
                Expanded(
                    flex: 8,
                    child: Text(pickFile.name)),
                Expanded(
                    flex: 1,
                    child: IconButton(onPressed: (){

                      OpenFile.open(pickFile.path.toString());
                    },icon: Icon(Icons.remove_red_eye, size: 18,),)),
                Expanded(
                    flex: 2,child: IconButton(onPressed: (){
                  hapusFileRangkuman();
                },icon: Icon(Icons.cancel_outlined, size: 18,),)),
              ],
            )));
      });
    } else {
      // User canceled the picker
    }
  }

  uploadFileRangkuman() async{
    var request = http.MultipartRequest("POST",Uri.https(env.webPoint, '/upload-rangkuman'));

    attachFileRangkuman.forEach((key, value) {
      request.files.add(
          http.MultipartFile(
            key.toString(),
            value.readAsBytes().asStream(),
            value.lengthSync(),
            filename: key.toString(),
          )
      );
    });
    // request.files.add(
    //     http.MultipartFile(
    //         'picture',
    //         File(filename).readAsBytes().asStream(),
    //         File(filename).lengthSync(),
    //         filename: filename.split("/").last
    //     )
    // );
    request.send().then((response) async {
      if (response.statusCode == 200) print("Uploaded!");
      print(await response.stream.bytesToString());
      //print(response.reasonPhrase);
    });
  }

  hapusFileRangkuman() async{
    rangkuman = '';
    childFileRangkuman.clear();
    attachFileRangkuman.clear();
    setState(() {
      listAttachmentRangkuman = ListView(children: [fileSayaRangkuman,]);
    });

  }
}

