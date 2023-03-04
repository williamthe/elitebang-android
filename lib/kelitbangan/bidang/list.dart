
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../../myenv.dart';
import 'index_by_bidang.dart';
import 'edit.dart';

class ListBidang extends StatefulWidget{
  @override
  State<ListBidang> createState() => _ListBidang();
}

class _ListBidang extends State<ListBidang> {


  MyEnvironments env = new MyEnvironments();

  Widget w_instansi = Container();
  List listInstansi = [];
  String selectedItem = 'Male';

  int id = 0;
  String tanggal = '';
  String judul = '';
  int instansi = 1;
  String abstrak = '';
  String tindakLanjut = '';
  String nomor = '';
  String pelaksana = '';
  int dokumen = 0;

  late BuildContext simpan;

  List<Widget> fileSaya = [];
  List<Map> attachment = [];
  List<Widget> childFile = [];

  Map attachWidget = {};
  Map attachFile = {};

  Widget listAttachment = Center(child: Text('Tidak Ada File'),);

  String namaFiles = '';
  Widget bidang = Container();
  late BuildContext ex;

  @override
  Widget build(BuildContext context) {
    return bidang;
  }

  getBidang() async {
    showDialog(context: context, builder: (BuildContext cc) {
      ex = cc;
      return AlertDialog(title: Center(child: new CircularProgressIndicator()),);
    },);
    await http.get(
      Uri.https(env.apiUrl, 'api/kelitbangan/list/bidang'),
      headers: {
        'Content-Type' : 'aplication/json; charset=UTF-8',
        'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImZkNDQzZGJhMzdkY2NjNTQzYmU4MTkzOWY0OTQ0MTkzZDc1YzZjYzcxNDY1YjBjOTIxOGE4MWM3NzVkZTkwNTM2Yjk1M2M4N2FjNGE0ODY4In0.eyJhdWQiOiIyIiwianRpIjoiZmQ0NDNkYmEzN2RjY2M1NDNiZTgxOTM5ZjQ5NDQxOTNkNzVjNmNjNzE0NjViMGM5MjE4YTgxYzc3NWRlOTA1MzZiOTUzYzg3YWM0YTQ4NjgiLCJpYXQiOjE2NjE5Mjg1OTgsIm5iZiI6MTY2MTkyODU5OCwiZXhwIjoxNjYxOTQ2NTk3LCJzdWIiOiIxNSIsInNjb3BlcyI6WyIqIl19.SUO0yl0Zqtzmn0ex_uR-vlh2mxXgjl1-am6MxpkcAal9aHt8nSLyOOBAFn4bTy3Szx2HJGMv_k5bzZ-JTU_yfHU5rqcYjjCWYclFoh8P1RWrhrFySxG_mNzbm5fDEB7913Wm5y5qRgt-ffOIYjYGQ1XX0EjU2bAgvdAFGA41g4r5KGT2-D88EGw1gQ8knRTxZOcIv_kqkCvQsGI4Ov3KGGgcYfi_7Q5nrNRqEPthycFMtUlX0QoFh-M2FRItE86ElVGSYREK6tt9vBsvhi07azBLQdShneFa8YNAg_lrhk0PQ4SKifpzCDdumyJNtNDDIqgsaMUiWMu9O0zZUxzHX-HYtuixDTWznjJm2DPWNUUfnClNIUpS7rautiie9aZvDV-BpLY6AO4xc_9omAzedytBbI7nivzy-M0tfv1MqnhmeggKNaSPhGiIqGKXedEjzhsVuaX7AZqdj5e7BqMUm-MnTD2A78VYyaYZhr9Soii98rzmgp8JzpLxFwaU-RsMfDMc5nU0_OOJ7hgagzDyh4HUxZEOqJgrPq8IPWAEvRiErxUNJlyxgGmt7BCebvS9Sq-ZqVUJGCo1LrvGTvAAFwZ9VjzmzAHwxUPfboStUt-W1TjzTUuV00YOqcETiFnnwq3c9yY02xoIsv9iCc56_A_idARPkcZWyOIzgldI6d0',
      },

    ).then((value) {
      // setState(){
      var listData = jsonDecode(value.body)['data'];
      setState(() {
        bidang = ListView.separated(itemBuilder: (context,index){
          return Container(
              padding: EdgeInsetsDirectional.all(10),
              height: 100,
              decoration: BoxDecoration(
                // border: BorderDirectional(),
                  borderRadius: BorderRadius.circular(20),
                  color: CupertinoColors.white
              ),
              child:
              Row(children: [
                Expanded(
                  flex: 7,
                  child: TextButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return IndexByBidang(listData[index]['id'], listData[index]['nama']);
                      },));
                    },
                    child: Container(
                        padding: EdgeInsetsDirectional.all(10),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(listData[index]['nama'],
                              style: TextStyle(color: Colors.black,fontSize: 14,overflow: TextOverflow.ellipsis),),
                            Container(
                              padding: EdgeInsetsDirectional.all(3),
                              child: Text(listData[index]['keterangan'] == null ? 'Instansi Tidak Ditemukan' : listData[index]['keterangan'],
                                style: TextStyle(color: Colors.black38, fontSize: 10,overflow: TextOverflow.ellipsis),),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(border: Border(),
                          //color: Colors.black12
                        )
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    child: IconButton(onPressed: (){
                        setState(() {

                          bidang = FormEditBidang(listData[index]);
                        });
                    }, icon: Icon(Icons.settings)),
                   // width: 60,

                    //color: Colors.lightBlue,
                    decoration: BoxDecoration(
                       //color: Colors.black12,
                        borderRadius: BorderRadiusDirectional.circular(50)
                    ),
                  ),
                ),

              ],)
          );
        },
          separatorBuilder: (context, index) => Container(height: 13,
            decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(20)),
          ),
          itemCount:listData.length,
        );
        //awal = myList;
      });
    }).whenComplete(( ) {
      setState(() {});
     Navigator.of(ex).pop();
    });

  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        getBidang();
      });
    });
  }


}