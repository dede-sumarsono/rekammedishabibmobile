

import 'dart:async';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rekammedishbb/main_screen/dashboard_screen.dart';

import '../services/auth.dart';
import '../services/dio.dart';

class UserDetailList extends StatefulWidget {
  UserDetailList({Key? key, required this.tf}) : super(key: key);
  Map tf;

  @override
  State<UserDetailList> createState() => _UserDetailListState(this.tf);
}

class _UserDetailListState extends State<UserDetailList> {
  _UserDetailListState(this.tf);
  late Map tf;
  final storage = new FlutterSecureStorage();


  final GlobalKey<ScaffoldState> _key = GlobalKey();


  late var jsonList;
  var jabatan;
  var poli;


  @override
  void initState() {
    if(tf['jabatan'] == 0){
      jabatan = 'Dokter';
    }else if(tf['jabatan'] == 1){
      jabatan = 'Admin';
    }else if(tf['jabatan'] == 2){
      jabatan = "Petugas Admin";
    }

    if (tf['poli']==null||tf['poli']==''){
      poli = "Petugas Non Dokter";
    }else if (tf['poli']!=null){
      poli = tf['poli'];
    }

    print(tf['poli']);
    print(jabatan);
        super.initState();
  }


  var loading = false;
  late Timer _timer;
  int _start = 2;


  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            //Navigator.pop(context);
            Route route = MaterialPageRoute(builder: (context) => DashboardScreen());
            Navigator.pushReplacement(context, route);


            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: AppBar(
          backgroundColor: Color(0xff189CAB),
          //leading: Icon(Icons.menu,color: Colors.white,),
          leading: IconButton(
            onPressed:  (){
              //_key.currentState!.openDrawer();
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back,color: Colors.white,),
          ),
          title:Row(
            children: [
              Icon(Icons.person_add_outlined,color: Colors.white,),
              SizedBox(width: 9,),
              Text('User List Detail',style: GoogleFonts.nunito(color: Colors.white)),
              Spacer(),
              IconButton(
                  onPressed: (){
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>LogOutScreen()));
                  }, icon: Icon(Icons.person,color: Colors.white,))
            ],
          ),
        ),

        body:

        Column(
          children: [

            Image.asset('assets/image/add_user_hitam.png',
              width: MediaQuery.of(context).size.width*0.5
            ),
            
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: ListView(
                  children: [

                    SizedBox(height: 20,),

                    TextFieldWidget(
                      //'E-mail',idx['jenis_layanan'], Icons.mail_outline),
                        'Nama','${tf['name']}', Icons.account_circle),


                    TextFieldWidget(
                      //'E-mail',idx['jenis_layanan'], Icons.mail_outline),
                        'Jabatan','$jabatan', Icons.work),

                    TextFieldWidget(
                      //'E-mail',idx['jenis_layanan'], Icons.mail_outline),
                        'Poli','$poli', Icons.home_repair_service),


                    SizedBox(height: 10,),

                    Row(
                      children: [
                        Spacer(),
                        SizedBox(
                          width: 180,
                          child: ElevatedButton(
                              onPressed: (){

                                /*loading = true;
                              print('Anda telah log menghapus data');
                              Provider.of<Auth>(context, listen: false)
                                  .deletePost(id: tf['id']);
                              startTimer();*/

                                _showDialog(context);

                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.delete),
                                  Text("  Hapus User")
                                ],
                              )),
                        ),
                      ],
                    ),







                  ],
                ),
              ),
            ),
          ],
        )



    );


  }

  //////////////////////////////
  TextFieldWidget(String title,String isian, IconData iconData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xff189CAB)),
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          // height: 50,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  //color: Colors.black.withOpacity(0.05),
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 1,
                    blurRadius: 1)
              ],
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(iconData, color: Color(0xff189CAB),),
              ),
              Text(isian,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54),
              ),
            ],
          ),




        ),

      ],
    );
  }
////////////////////


  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Log Out!!"),
          content: new Text("Apakah anda yakin akan menghapus user ${tf['name']} ??"),
          actions: <Widget>[
            new TextButton(
              child: new Text("OK"),
              onPressed: () {

                loading = true;
                print('Anda telah log menghapus data');
                Provider.of<Auth>(context, listen: false)
                    .destroyuser(id: tf['id']);
                startTimer();
                Navigator.of(context).pop();



              },
            ),
            new TextButton(
              child: new Text("Tidak"),
              onPressed: () {
                Navigator.of(context).pop();

              },
            ),

          ],
        );
      },
    );
  }


}
