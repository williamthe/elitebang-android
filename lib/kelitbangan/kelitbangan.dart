import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:filesystem_picker/filesystem_picker.dart';
//import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_litbang/kelitbangan/view_kelitbangan.dart';

class Kelitbangan extends StatefulWidget{
 @override
  _Kelitbangan createState() => _Kelitbangan();
}

class _Kelitbangan extends State<Kelitbangan>{
  List listData = [];

  //final dirRoot = findRoot(getApplicationDocumentsDirectory());

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

  Widget myList = Center(
      child: Text('Loading Data...'),
  );

  late BuildContext ex;

  @override
  Widget build(BuildContext context) {
    final contentHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    // -
    //     AppBar().preferredSize.height;
    //dialogContext =
    return MaterialApp(
     debugShowCheckedModeBanner: false,
     home: DefaultTabController(
       child: (
           Scaffold(
       body: Column(
         children: [
           Container(
             height: (contentHeight),
             child: TabBarView(
                 children: [
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Container(
                           height: (contentHeight * 0.8),
                           child: myList
                       ),
                       SizedBox(height: 5,),
                       Container(
                         padding: EdgeInsetsDirectional.all(5),
                         decoration: BoxDecoration(
                           color: Colors.blue,
                           borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),

                         ),
                         height: 50,
                         width: 100,
                         //color: Color.fromRGBO(0, 0, 100, 10),
                         child: TextButton(onPressed: (){
                           // setState(() {
                           showDialog(context: context, builder: (BuildContext contex2){
                             ex = contex2;
                             return AlertDialog(
                               title: Row(
                                 children: [
                                   Text( 'Mengambil Data...' ),
                                   new CircularProgressIndicator(),
                                 ],
                               ),
                             );
                           });
                           getList();

                           // });
                         }, child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Icon(Icons.refresh_outlined,color: Colors.white,size: 16,),
                             SizedBox(width: 3,),
                             Text('refresh', style: TextStyle(color: Colors.white,fontSize: 15)),
                           ],
                         ), ),
                       ),
                     ],),
                   GridView(
                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: 5,
                       crossAxisSpacing: 10,
                       mainAxisSpacing: 10,
                     ),
                     children: List.generate(100, (index) => Image(image: NetworkImage("https://picsum.photos/id/${Random().nextInt(100)}/200/300"))),
                   ),
                   Column(
                     children: [
                       Container(
                         height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - AppBar().preferredSize.height - 150,
                         child: ListView(
                           children: [
                             Container(
                               child: Center(
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Container(
                                       padding: EdgeInsets.fromLTRB(15,15,15,15),

                                     ),

                                     Container(
                                       padding: EdgeInsets.fromLTRB(15,5,15,5),
                                       child: TextField(
                                         //text:'',
                                         decoration: InputDecoration(
                                             border: OutlineInputBorder(
                                               borderRadius: BorderRadius.all(Radius.circular(10)),

                                             ),
                                             //prefixIcon: Icon(Icons.email_outlined),
                                             hintText: "Nomor",
                                             labelText: "Nomor"

                                         ),
                                         onChanged: (text){
                                           nomor = text;
                                         },
                                         controller: TextEditingController(text: nomor),
                                       ),
                                     ),
                                     Container(
                                       padding: EdgeInsets.fromLTRB(15,5,15,5),
                                       child: TextField(
                                         //text:'',
                                         decoration: InputDecoration(
                                             border: OutlineInputBorder(
                                               borderRadius: BorderRadius.all(Radius.circular(10)),

                                             ),
                                             //prefixIcon: Icon(Icons.email_outlined),
                                             hintText: "Tanggal",
                                             labelText: "Tanggal",
                                             suffixIcon: IconButton(onPressed: (){
                                               showDatePicker(context: context,
                                                 initialDate: DateTime.now(),
                                                 firstDate: DateTime(2000),
                                                 lastDate: DateTime(2099),

                                               ).then((value) {
                                                 setState(() {
                                                   tanggal = value.toString().split(' ')[0];
                                                 });
                                               });
                                             }, icon: Icon(Icons.date_range))

                                         ),
                                         onChanged: (text){

                                         },
                                         controller: TextEditingController(text: tanggal),
                                       ),
                                     ),
                                     Container(
                                       padding: EdgeInsets.fromLTRB(15,5,15,5),
                                       child: TextField(
                                         //text:'',
                                         decoration: InputDecoration(
                                           border: OutlineInputBorder(
                                             borderRadius: BorderRadius.all(Radius.circular(10)),

                                           ),
                                           //prefixIcon: Icon(Icons.email_outlined),
                                           hintText: "Judul",
                                           labelText: "Judul",
                                         ),
                                         onChanged: (text){
                                           judul = text;
                                         },
                                         controller: TextEditingController(text:judul),

                                       ),
                                     ),
                                     Container(
                                       alignment: Alignment.centerLeft,
                                       padding: EdgeInsets.fromLTRB(15,5,15,5),
                                       child: Text('Instansi'),
                                     ),
                                     Container(

                                       padding: EdgeInsets.fromLTRB(15,0,15,5),
                                       child:DropdownButton<int>(
                                           isExpanded: true,
                                           hint: Text('Instansi'),
                                           icon: Icon(Icons.arrow_drop_down),
                                           style: TextStyle(wordSpacing: 20),
                                           value: instansi,
                                           items: [
                                             DropdownMenuItem(child: Text('Lingkungan',style: TextStyle(color: Colors.black),), value: 2,),
                                             DropdownMenuItem(child: Text('Hutang',style: TextStyle(color: Colors.black)), value: 3,),
                                             DropdownMenuItem(child: Text('Litbang',style: TextStyle(color: Colors.black)), value: 4,),
                                             DropdownMenuItem(child: Text('Agama',style: TextStyle(color: Colors.black)), value: 1,),
                                           ],
                                           onChanged: (value) {
                                             // This is called when the user selects an item.
                                             setState(() {
                                               instansi = value == null? 1 : value;
                                             });
                                           }
                                       ),
                                     ),
                                     Container(
                                       padding: EdgeInsets.fromLTRB(15,5,15,5),
                                       child: TextField(
                                         //text:'',
                                         decoration: InputDecoration(
                                             border: OutlineInputBorder(
                                               borderRadius: BorderRadius.all(Radius.circular(10)),

                                             ),
                                             //prefixIcon: Icon(Icons.email_outlined),
                                             hintText: "Abstrak",
                                             labelText: "Abstrak"

                                         ),
                                         onChanged: (text){
                                           abstrak = text;
                                         },
                                         controller: TextEditingController(text: abstrak),
                                         minLines: 3,
                                         maxLines: 5,
                                         keyboardType: TextInputType.multiline,
                                       ),
                                     ),
                                     Container(
                                       padding: EdgeInsets.fromLTRB(15,5,15,5),
                                       child: TextField(
                                         //text:'',
                                         decoration: InputDecoration(
                                             border: OutlineInputBorder(
                                               borderRadius: BorderRadius.all(Radius.circular(10)),

                                             ),
                                             //prefixIcon: Icon(Icons.email_outlined),
                                             hintText: "Tindak Lanjut",
                                             labelText: "Tindak Lanjut"

                                         ),
                                         onChanged: (text){
                                           tindakLanjut = text;
                                         },
                                         controller: TextEditingController(text: tindakLanjut),
                                         minLines: 3,
                                         maxLines: 5,
                                         keyboardType: TextInputType.multiline,
                                       ),
                                     ),
                                     Container(
                                       padding: EdgeInsets.fromLTRB(15,5,15,5),
                                       child: TextField(
                                         //text:'',
                                         decoration: InputDecoration(
                                             border: OutlineInputBorder(
                                               borderRadius: BorderRadius.all(Radius.circular(10)),

                                             ),
                                             //prefixIcon: Icon(Icons.email_outlined),
                                             hintText: "Pelaksana",
                                             labelText: "Pelaksana :"

                                         ),
                                         onChanged: (text){
                                           pelaksana = text;
                                         },
                                         controller: TextEditingController(text: ''),
                                         minLines: 3,
                                         maxLines: 5,
                                         keyboardType: TextInputType.multiline,
                                       ),
                                     ),
                                     Row(
                                       children: [
                                         Text("Dokumen",style: TextStyle(height: 2,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                                         IconButton(onPressed: (){
                                           //FilesystemPicker.open(context: context, rootDirectory: Di);
                                           setState(() {

                                           });
                                         }, icon: Icon(Icons.add)),

                                       ],
                                     ),
                                     Container(
                                       padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                       height: 200,
                                       child: GridView(
                                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                           crossAxisCount: 4,
                                           crossAxisSpacing: 10,
                                           mainAxisSpacing: 10,
                                         ),
                                         children: List.generate(dokumen, (index) => Container( child:Icon(Icons.file_present,size: 30,) ,width: 100, height: 100, color: Color.fromRGBO(Random().nextInt(255), Random().nextInt(255), Random().nextInt(255), Random().nextDouble()),)),
                                       ),
                                     ),

                                     //Text('Update',style: TextStyle(color: Colors.red),)
                                   ],
                                 ),
                               ), /* add child content here */
                             ),],
                         ),
                       ),
                       Container(
                         width: 100,
                         height: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - AppBar().preferredSize.height ) * 0.07,
                         padding: EdgeInsetsDirectional.all(8),
                         //color: Colors.redAccent,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                             color: Color.fromRGBO(1, 123, 255, 10)
                         ),
                         child: Container(
                           decoration: BoxDecoration(
                             borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                             border: Border(),

                             //color: Color.fromRGBO(1, 123, 255, 10)
                           ),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               TextButton(onPressed: (){
                                 showDialog(context: context, builder: (BuildContext sv) {
                                   simpan = sv;
                                   return AlertDialog(
                                     title: Row(children: [
                                       Text('Menyimpan Data'),
                                       new CircularProgressIndicator()
                                     ]),
                                   );
                                 },);
                                 store();
                               }, child: Text('save',style: TextStyle(color: Colors.white, fontSize: 16),) ),
                               //IconButton(onPressed: (){}, icon: Icon(Icons.save, size: 28,color: Colors.white,),
                               //),
                             ],
                           ),),
                       ),
                     ],
                   )
                 ]),
           ),
         ],
       ),


       // floatingActionButton: FloatingActionButton(onPressed:(){},
       //   child: Icon(Icons.add_circle),),
     )),
        length: 3,
     )
    );
  }

  Future<void> store() async {
    var _mytoken = await SessionManager().get('_token');
    var response = await http.post(
      Uri.https('api-litbang.btx.co.id', 'api/kelitbangan/create'),
      headers: {
        'Authorization': 'Bearer ${_mytoken.toString()}'
      },
      body: {
        'id' : id.toString(),
        'nomor' : nomor,
        'tanggal' : tanggal,
        'judul' : judul,
        'abstrak' : abstrak,
        'tindak_lanjut' : tindakLanjut,
        'lingkup' : instansi.toString(),
        'pelaksana' : jsonEncode(pelaksana.toString().split('\n')),
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
        }).then((value) => resetForm());
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

  void showLitbang(listData) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return ViewKelitbangan(listData);
    }));
  }

  resetForm() {
    nomor = '';
    tanggal = '';
    judul = '';
    abstrak = '';
    tindakLanjut = '';
    pelaksana = '';
  }

  getList() async {
    var response = await http.get(
      Uri.https('api-litbang.btx.co.id', 'api/kelitbangan/list'),
      headers: {
        'Content-Type' : 'aplication/json; charset=UTF-8',
        'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImZkNDQzZGJhMzdkY2NjNTQzYmU4MTkzOWY0OTQ0MTkzZDc1YzZjYzcxNDY1YjBjOTIxOGE4MWM3NzVkZTkwNTM2Yjk1M2M4N2FjNGE0ODY4In0.eyJhdWQiOiIyIiwianRpIjoiZmQ0NDNkYmEzN2RjY2M1NDNiZTgxOTM5ZjQ5NDQxOTNkNzVjNmNjNzE0NjViMGM5MjE4YTgxYzc3NWRlOTA1MzZiOTUzYzg3YWM0YTQ4NjgiLCJpYXQiOjE2NjE5Mjg1OTgsIm5iZiI6MTY2MTkyODU5OCwiZXhwIjoxNjYxOTQ2NTk3LCJzdWIiOiIxNSIsInNjb3BlcyI6WyIqIl19.SUO0yl0Zqtzmn0ex_uR-vlh2mxXgjl1-am6MxpkcAal9aHt8nSLyOOBAFn4bTy3Szx2HJGMv_k5bzZ-JTU_yfHU5rqcYjjCWYclFoh8P1RWrhrFySxG_mNzbm5fDEB7913Wm5y5qRgt-ffOIYjYGQ1XX0EjU2bAgvdAFGA41g4r5KGT2-D88EGw1gQ8knRTxZOcIv_kqkCvQsGI4Ov3KGGgcYfi_7Q5nrNRqEPthycFMtUlX0QoFh-M2FRItE86ElVGSYREK6tt9vBsvhi07azBLQdShneFa8YNAg_lrhk0PQ4SKifpzCDdumyJNtNDDIqgsaMUiWMu9O0zZUxzHX-HYtuixDTWznjJm2DPWNUUfnClNIUpS7rautiie9aZvDV-BpLY6AO4xc_9omAzedytBbI7nivzy-M0tfv1MqnhmeggKNaSPhGiIqGKXedEjzhsVuaX7AZqdj5e7BqMUm-MnTD2A78VYyaYZhr9Soii98rzmgp8JzpLxFwaU-RsMfDMc5nU0_OOJ7hgagzDyh4HUxZEOqJgrPq8IPWAEvRiErxUNJlyxgGmt7BCebvS9Sq-ZqVUJGCo1LrvGTvAAFwZ9VjzmzAHwxUPfboStUt-W1TjzTUuV00YOqcETiFnnwq3c9yY02xoIsv9iCc56_A_idARPkcZWyOIzgldI6d0',
      },

    ).then((value) {
      // setState(){
      var listData = jsonDecode(value.body)['data'];
      setState(() {
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return ViewKelitbangan(listData[index]);
                  }));
                },
                child: Row(children: [
                  Container(

                    child: Text((index+1).toString(), style: TextStyle(fontSize: 17, color: Colors.black), ),
                    width: 50,
                    padding: EdgeInsets.all(20),
                    //color: Colors.lightBlue,
                    decoration: BoxDecoration(
                      // color: Colors.black38,
                        borderRadius: BorderRadiusDirectional.circular(20)
                    ),
                  ),
                  Container(
                      padding: EdgeInsetsDirectional.all(10),
                      child: Text(listData[index]['judul'],style: TextStyle(color: Colors.black),),
                      decoration: BoxDecoration(border: Border()
                      )
                  ),
                  Container()
                ],),
              )
          );
        },
          separatorBuilder: (context, index) => Container(height: 10,
            decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(20)),
          ),
          itemCount:listData.length,
        );
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
        getList();
      });
    });
  }

}

