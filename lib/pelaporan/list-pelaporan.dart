import 'package:flutter/material.dart';
import 'package:prototype_litbang/penelitian/index.dart';
import '';
import 'list-password.dart';

class ListPelaporanPenelitian extends StatefulWidget{
  @override
  State<ListPelaporanPenelitian> createState() => _ListPelaporanPenelitianState();
}

class _ListPelaporanPenelitianState extends State<ListPelaporanPenelitian> {
  Widget listData = Container(
    child: Text('Belum Ada Data'),
  );
  @override
  Widget build(BuildContext context) {
    return Container(child: Column(
      children: [
        Container(
            padding: EdgeInsetsDirectional.all(10),
            height: 70,
            decoration: BoxDecoration(
              border: BorderDirectional(),
              borderRadius: BorderRadius.circular(20),
              //color: CupertinoColors.white
            ),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  //flex: 9,
                  child: Container(
                    //height: 60,
                      padding: EdgeInsetsDirectional.all(5),
                      child: TextButton(
                        child: Text('Atur Public Password',
                          style: TextStyle(fontFamily: 'Poppins',
                            fontSize: 14,
                            color: Colors.white,),),
                        onPressed: (){
                          Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
                            return ListPassword('penelitian');
                          },));
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
        listData,
      ],
    ),);
  }
}
