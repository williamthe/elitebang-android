
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_litbang/penelitian/edit_penelitian.dart';

class ViewPenelitian extends StatefulWidget{
  Map myData = {};
  ViewPenelitian(listData){
    this.myData = listData;
  }
  _ViewPenelitian createState() => _ViewPenelitian(myData);
}

class _ViewPenelitian extends State<ViewPenelitian>{
  Map myData = {};
  String pelaksana = '';
  _ViewPenelitian(Map myData){
    this.myData = myData;

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Scaffold(
            appBar: AppBar(title: Text(myData['usulan'],),
              centerTitle: true,
              leading: IconButton(onPressed: (){
                Navigator.of(context).pop();
              },icon: Icon(Icons.arrow_circle_left),),
            ),
            body: Column(
              children: [
                ViewData(myData,pelaksana),
                Container(
                    height: (MediaQuery.of(context).size.height - 25 - MediaQuery.of(context).padding.top - AppBar().preferredSize.height) * 0.1,
                    child: ActionData(myData))
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
          height: (MediaQuery.of(context).size.height - 25 - MediaQuery.of(context).padding.top - AppBar().preferredSize.height) * 0.9,
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

class ActionData extends StatelessWidget{
  
  Map dataPenelitian = {};
  ActionData(Map data){
    dataPenelitian = data;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsetsDirectional.all(3),
          decoration:
          BoxDecoration(
            color: Colors.amberAccent,
            borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
            //     //
          ),
          height: 45,
          width: 75,

          child: TextButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return EditPenelitian(dataPenelitian);
            },));
          },
            child: Row(
              children: [
                //     //
                Icon(Icons.edit,color: Colors.white,size: 14,),
                SizedBox(width: 5,),
                Text('edit', style: TextStyle(color: Colors.white,fontSize: 15)),
              ],
            ), ),
        ),
        Container(width: 15,),
        Container(
          padding: EdgeInsetsDirectional.all(3),
          decoration:
          BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
            //     //
          ),
          height: 45,
          width: 85,

          child: TextButton(onPressed: (){
            deletePenelitian(dataPenelitian['id']);
          },
            child: Row(
              children: [
                //     //
                Icon(Icons.delete,color: Colors.white,size: 15,),
                SizedBox(width: 5,),
                Text('delete', style: TextStyle(color: Colors.white,fontSize: 15)),
              ],
            ), ),
        ),
      ],
    );
  }

  void deletePenelitian(dataPenelitian) {}

}



