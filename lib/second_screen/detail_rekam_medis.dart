

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rekammedishbb/main_screen/rekam_medis.dart';
import 'package:rekammedishbb/second_screen/isi_data_pasien_copy.dart';

import '../main_screen/logout_screen.dart';
import '../services/auth.dart';

class DetailRekamMedis extends StatefulWidget {
  DetailRekamMedis({Key? key,required this.tf}) : super(key: key);
  Map tf;

  @override
  State<DetailRekamMedis> createState() => _DetailRekamMedisState(this.tf);
}

class _DetailRekamMedisState extends State<DetailRekamMedis> {

  _DetailRekamMedisState(this.tf);
  late Map tf;

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final storage = new FlutterSecureStorage();


  //////////////////////timer atribut

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
            Route route = MaterialPageRoute(builder: (context) => RekamMedis());
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
  void dispose() {
    _timer.cancel();
    super.dispose();
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
            //Icon(Icons.plus,color: Colors.white,),
            SvgPicture.asset('assets/image/book_edit.svg',width: 24,height: 24),
            SizedBox(width: 9,),
            Text('Detail Pasien',style: GoogleFonts.nunito(color: Colors.white)),
            Spacer(),
            IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LogOutScreen()));
                }, icon: Icon(Icons.person,color: Colors.white,))
          ],
        ),
      ),

      body: loading == true ? Center(child: CircularProgressIndicator(color: Color(0xff189CAB),)) : ListView(
        padding: EdgeInsets.only(left: 20,right: 20),
        children: [
          SizedBox(height: 40,),
          Container(
            //height: MediaQuery.of(context).size.height*0.7,
            width: 40,
            decoration: BoxDecoration(
              //color: Color(0xFF94CCF9),
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10.0),
              /*boxShadow: [
                BoxShadow(
                  //color: Color(0xFF04589A),
                  color:Colors.black54.withOpacity(0.5),
                  offset: Offset(7, 7),
                  blurRadius: 6,
                ),
              ],*/
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: Text(tf['name'],style: GoogleFonts.nunito(fontSize: 21,fontWeight: FontWeight.bold),maxLines: 3,)),
                      Text( tf['created_at'].substring(0,10),style: GoogleFonts.nunito())
                    ],
                  ),
                  Text('Poli : ${tf['poli']}',style: GoogleFonts.nunito()),
                  Text('Jenis Pelayanan : ${tf['jenis_pelayanan']}',style: GoogleFonts.nunito(),),

                  SizedBox(height: 15,),

                  Row(
                    children: [
                      Text('No RM        ',style: GoogleFonts.nunito(fontSize: 18),),
                      Text(' : ',style: GoogleFonts.nunito(fontSize: 18),),
                      Text(tf['nomor'],style: GoogleFonts.nunito(fontSize: 18),),
                    ],
                  ),

                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nama          ',style: GoogleFonts.nunito(fontSize: 18),),
                      Text(' : ',style: GoogleFonts.nunito(fontSize: 18),),
                      Flexible(child: Text(tf['name'],style: GoogleFonts.nunito(fontSize: 18),maxLines: 2,)),
                    ],
                  ),

                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text('NIK              ',style: GoogleFonts.nunito(fontSize: 18),),
                      Text(' : ',style: GoogleFonts.nunito(fontSize: 18),),
                      Text(tf['nik'],style: GoogleFonts.nunito(fontSize: 18),),
                    ],
                  ),

                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Alamat        ',style: GoogleFonts.nunito(fontSize: 18),),
                      Text(' : ',style: GoogleFonts.nunito(fontSize: 18),),
                      Flexible(child: Text(tf['alamat'],style: GoogleFonts.nunito(fontSize: 18), maxLines: 4,)),
                    ],
                  ),

                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tgl Lahir      ',style: GoogleFonts.nunito(fontSize: 18),),
                      Text(' : ',style: GoogleFonts.nunito(fontSize: 18),),
                      Flexible(child: Text(tf['tgl_lahir'],style: GoogleFonts.nunito(fontSize: 18), maxLines: 4,)),
                    ],
                  ),

                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('J Kelamin     ',style: GoogleFonts.nunito(fontSize: 18),),
                      Text(' : ',style: GoogleFonts.nunito(fontSize: 18),),
                      Flexible(child: Text(tf['jenis_kelamin'],style: GoogleFonts.nunito(fontSize: 18), maxLines: 4,)),
                    ],
                  ),

                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('J Pelayanan ',style: GoogleFonts.nunito(fontSize: 18),),
                      Text(' : ',style: GoogleFonts.nunito(fontSize: 18),),
                      Flexible(child: Text(tf['jenis_pelayanan'],style: GoogleFonts.nunito(fontSize: 18), maxLines: 4,)),
                    ],
                  ),

                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Diagnosa     ',style: GoogleFonts.nunito(fontSize: 18),),
                      Text(' : ',style: GoogleFonts.nunito(fontSize: 18),),
                      Flexible(child: Text(tf['diagnosa'],style: GoogleFonts.nunito(fontSize: 18), maxLines: 4,)),
                    ],
                  ),

                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Terapi           ',style: GoogleFonts.nunito(fontSize: 18),),
                      Text(' : ',style: GoogleFonts.nunito(fontSize: 18),),
                      Flexible(child: Text(tf['terapi'],style: GoogleFonts.nunito(fontSize: 18), maxLines: 4,)),
                    ],
                  ),

                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ketarangan  ',style: GoogleFonts.nunito(fontSize: 18),),
                      Text(' : ',style: GoogleFonts.nunito(fontSize: 18),),
                      Flexible(child: Text(tf['keterangan'],style: GoogleFonts.nunito(fontSize: 18), maxLines: 4,)),
                    ],
                  ),

                  SizedBox(height: 20,),

                  Row(
                    children: [

                      SizedBox(
                        //width: 140,
                        child: ElevatedButton(
                            onPressed: (){
                              //copy data
                              print('tombol copy dipencet');
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>IsiDataPasienCopy(tf: tf,)));


                            },
                            child: Row(
                              children: [
                                Icon(Icons.delete),
                                Text("  Copy Data")
                              ],
                            )),
                      ),

                      Spacer(),

                      SizedBox(
                        //width: 140,
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
                              children: [
                                Icon(Icons.delete),
                                Text("  Hapus")
                              ],
                            )),
                      ),

                    ],
                  ),






                ],
              ),
            ),
          ),
          SizedBox(height: 60,)

        ],
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Log Out!!"),
          content: new Text("Apakah anda yakin akan menghapus data ini ??"),
          actions: <Widget>[
            new TextButton(
              child: new Text("OK"),
              onPressed: () {

                loading = true;
                print('Anda telah log menghapus data');
                Provider.of<Auth>(context, listen: false)
                    .deletePost(id: tf['id']);
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
