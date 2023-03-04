import 'package:flutter/material.dart';

class Detail extends StatelessWidget{
  Map myData = {};

  Detail(this.myData);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: ListView(
        children: [
          ListTile(
            title: Text('Nomor',style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(myData['nomor'] == null ? '-' : myData['nomor']),
          ),
          ListTile(
            title: Text('Tanggal',style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(myData['tanggal'] == null ? '-' : myData['tanggal']),
          ),
          ListTile(
            title: Text('Judul',style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(myData['judul'] == null ? '-' : myData['judul']),
          ),
          ListTile(
            title: Text('Abstrack',style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(myData['abstrak'] == null ? '-' : myData['abstrak']),
          ),
          ListTile(
            title: Text('Tindak Lanjut',style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(myData['tindak_lanjut'] == null ? '-' : myData['tindak_lanjut']),
          ),
          ListTile(
            title: Text('Instansi',style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(myData['lingkup_data']['nama']),
          ),
          ListTile(
            title: Text('Pelaksana',style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(myData['pelaksana']),
          ),
          ListTile(
            title: Text('Dokumen :',style: TextStyle(fontWeight: FontWeight.bold)),
            //subtitle: Text(myData['lingkup_data']['nama']),
          ),
          Container(
            height: 200,
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              children: List.generate(myData['attachment'].length, (index) => Column(children:
              [
                TextButton(onPressed: (){
                  String urlFile = "https://litbang.btx.co.id/attachment/documents/kelitbangan-Usulan Menu Website Balitbangda.pdf";

                },
                    child: Text(myData['attachment'][index]['nama']))])),
            ),
          ),
        ],
      ),
    );
  }

}