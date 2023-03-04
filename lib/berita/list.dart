
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import '../myenv.dart';
import 'package:prototype_litbang/user_menu.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';


class ListBerita extends StatefulWidget{
  _ListBerita createState() => _ListBerita();

}

class _ListBerita extends State<ListBerita>{
  MyEnvironments env = new MyEnvironments();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: env.myFont),
        home:Scaffold(
            backgroundColor: Color.fromRGBO(20, 20, 200, 100),
            //endDrawer: Icon(Icons.arrow_left, color: Colors.black, size: 50,),
            body:MylistData()
        )
    );
  }

}
class MenuView{

  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Scaffold(
            body:
            MylistData()
        )
    );
  }

}

class MylistData extends StatefulWidget{

  @override
  State<MylistData> createState() => _MylistDataState();
}

class _MylistDataState extends State<MylistData> {
  MyEnvironments env = new MyEnvironments();
  TextStyle menuText = TextStyle(
      fontSize: 14,
      color: Colors.black87,
     overflow: TextOverflow.ellipsis
  );

  Color menuColor = Colors.white;
  double menuIconSize = 33;
  Color menuIconColor = Colors.black;

  List<Widget> listData = [];
  late BuildContext ref;

  @override
  Widget build(BuildContext context) {
    final myBodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top ;

     Container(
      padding: EdgeInsetsDirectional.all(15),
      child: Column(
        children: [
          Container(height: myBodyHeight * 0.02,),
          Container(
            decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadiusDirectional.circular(10)
            ),
            padding: EdgeInsetsDirectional.only(top: 5,bottom: 5,start: 15),
            //color: Colors.blue,
            height: myBodyHeight * 0.07,
            child: Center(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: IconButton(icon:Icon(Icons.grid_view_sharp), onPressed: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                        return UserMenu();
                      },));
                    },
                      tooltip: 'Ke User Menu',),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(padding: EdgeInsetsDirectional.only(start: 10),
                        child: Text('Berita',
                          style: TextStyle(fontWeight: FontWeight.bold),)),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(icon:Icon(Icons.refresh), onPressed: (){
                      getList();
                    },
                      tooltip: 'Refresh Data',),
                  ),
                ],
              ),
            ),

          ),
          Container(height: myBodyHeight * 0.01,),
          Container(
            height: myBodyHeight * 0.85,
            child: ListView(
              children: [
                Column(
                    children: [
                      Container(
                          child: Column(children: listData,)
                      )
                    ]),

              ],
            ),
          ),
        ],
      ),
    );
    
    return Container(
      height:  myBodyHeight ,
      child: Column(
        children: [
          Container(height: myBodyHeight * 0.15,
            padding: EdgeInsetsDirectional.only(top: MediaQuery.of(context).padding.top),
            decoration: BoxDecoration(
              //color: CupertinoColors.white,
              borderRadius: BorderRadiusDirectional.circular(13)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Expanded(
                flex: 1,
                child: IconButton(icon: Icon(Icons.grid_view_sharp,color: Colors.white),
                  onPressed: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                    return UserMenu();
                  },));
                },)),
              Expanded(
                flex: 8,
                child: Center(
                    child: Text('Daftar Berita',style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),),
                  ),
              ),
              Expanded(
                    flex: 1,
                    child: IconButton(icon: Icon(Icons.refresh,color: Colors.white,),
                      onPressed: (){
                       getList();
                      },)),

            ],),
          ),
          Container(
            height: myBodyHeight * 0.03,
          ),
          Container(height: myBodyHeight * 0.82,
            decoration: BoxDecoration(
             borderRadius: BorderRadiusDirectional.circular(12),
             // color: Color.fromRGBO(12, 12, 220, 50),
              color: Colors.white
            ),
            child: ListView(
              children: listData,
            ),
            padding: EdgeInsetsDirectional.all(10),
          ),
        ],
      ),
    );
  }

  getList() async {
    showDialog(context: context, builder: (BuildContext bc) {
      ref = bc;
      return AlertDialog(title: Center(child: new CircularProgressIndicator()),);
    },);
    var response = await http.get(
      Uri.https(env.apiUrl, 'api/berita/list'),
      headers: {
        'Content-Type' : 'aplication/json; charset=UTF-8',
        'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImZkNDQzZGJhMzdkY2NjNTQzYmU4MTkzOWY0OTQ0MTkzZDc1YzZjYzcxNDY1YjBjOTIxOGE4MWM3NzVkZTkwNTM2Yjk1M2M4N2FjNGE0ODY4In0.eyJhdWQiOiIyIiwianRpIjoiZmQ0NDNkYmEzN2RjY2M1NDNiZTgxOTM5ZjQ5NDQxOTNkNzVjNmNjNzE0NjViMGM5MjE4YTgxYzc3NWRlOTA1MzZiOTUzYzg3YWM0YTQ4NjgiLCJpYXQiOjE2NjE5Mjg1OTgsIm5iZiI6MTY2MTkyODU5OCwiZXhwIjoxNjYxOTQ2NTk3LCJzdWIiOiIxNSIsInNjb3BlcyI6WyIqIl19.SUO0yl0Zqtzmn0ex_uR-vlh2mxXgjl1-am6MxpkcAal9aHt8nSLyOOBAFn4bTy3Szx2HJGMv_k5bzZ-JTU_yfHU5rqcYjjCWYclFoh8P1RWrhrFySxG_mNzbm5fDEB7913Wm5y5qRgt-ffOIYjYGQ1XX0EjU2bAgvdAFGA41g4r5KGT2-D88EGw1gQ8knRTxZOcIv_kqkCvQsGI4Ov3KGGgcYfi_7Q5nrNRqEPthycFMtUlX0QoFh-M2FRItE86ElVGSYREK6tt9vBsvhi07azBLQdShneFa8YNAg_lrhk0PQ4SKifpzCDdumyJNtNDDIqgsaMUiWMu9O0zZUxzHX-HYtuixDTWznjJm2DPWNUUfnClNIUpS7rautiie9aZvDV-BpLY6AO4xc_9omAzedytBbI7nivzy-M0tfv1MqnhmeggKNaSPhGiIqGKXedEjzhsVuaX7AZqdj5e7BqMUm-MnTD2A78VYyaYZhr9Soii98rzmgp8JzpLxFwaU-RsMfDMc5nU0_OOJ7hgagzDyh4HUxZEOqJgrPq8IPWAEvRiErxUNJlyxgGmt7BCebvS9Sq-ZqVUJGCo1LrvGTvAAFwZ9VjzmzAHwxUPfboStUt-W1TjzTUuV00YOqcETiFnnwq3c9yY02xoIsv9iCc56_A_idARPkcZWyOIzgldI6d0',
      },

    ).then((value) {

      var listDataSrc = jsonDecode(value.body)['data'];
     // print(listDataSrc);
      setState((){
        this.listData = List.generate(listDataSrc.length, (index) => Column(
          children:[
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                //color: Colors.blue.shade100,
                color: Color.fromRGBO(225, 225, 220, 0.25),
                borderRadius: BorderRadiusDirectional.circular(15),
                border: Border.all( color: CupertinoColors.white),
              ),
              padding: EdgeInsetsDirectional.all(10),
              height: 85,
              child: TextButton(
                onPressed: (){
                  launchUrlString('${env.webUrl}/view-berita/${listDataSrc[index]['id']}',
                      mode: LaunchMode.externalApplication,
                      //webViewConfiguration: WebViewConfiguration()
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            //alignment:Alignment.center,
                            child: Text(listDataSrc[index]['judul'] == null ? '' : listDataSrc[index]['judul'],
                              style: menuText, ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Image(image: NetworkImage(
                            "${env.webUrl}/images/litbang-min.png")
                        )
                    )
                  ],
                ),
              ),
            ),
            Container(height: 8,),
          ],
        ) );
      });
      Navigator.of(ref).pop();
      // Navigator.of(referesh).pop();
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



