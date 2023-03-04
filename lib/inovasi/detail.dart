import 'package:flutter/material.dart';

class Detail extends StatelessWidget{
  Map myData = {};
  String Pelaksana ='';

  Detail(Map meData){
   this.myData = meData;

  }
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
            title: Text('Nama',style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(myData['nama'] == null ? '-' : myData['nama']),
          ),
          ListTile(
            title: Text('Tujuan',style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(myData['tujuan'] == null ? '-' : myData['tujuan']),
          ),
          ListTile(
            title: Text('Manfaat',style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(myData['manfaat'] == null ? '-' : myData['manfaat']),
          ),
          ListTile(
            title: Text('Instansi',style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(myData['instansi_data']['nama']),
          ),
          ListTile(
            title: Text('Deskripsi',style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(myData['deskripsi']),
          ),
          ListTile(
            title: Text('Pelaksana',style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(myData['pelaksana']),
          ),
          ListTile(
            title: Text('Dokumen :',style: TextStyle(fontWeight: FontWeight.bold)),
           // subtitle: Text(myData['instansi_data']['nama']),
          ),
          Container(
            height: 200,
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              children: List.generate(1, (index) => Column(children:
              [
                TextButton(onPressed: (){
                  String urlFile = "https://litbang.btx.co.id/attachment/documents/kelitbangan-Usulan Menu Website Balitbangda.pdf";

                },
                    child: Text('xxx'))])),
            ),
          ),
        ],
      ),
    );
  }

}