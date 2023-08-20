

import 'dart:async';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rekammedishbb/main_screen/rekam_medis.dart';
import 'package:rekammedishbb/revisi/rekam_medis_revisi.dart';
import 'package:rekammedishbb/second_screen/isi_data_pasien_copy.dart';

import '../main_screen/logout_screen.dart';
import '../services/auth.dart';
import '../services/dio.dart';

class DetailRekamMedisRevisi extends StatefulWidget {
  DetailRekamMedisRevisi({Key? key,required this.tf}) : super(key: key);
  int tf;

  @override
  State<DetailRekamMedisRevisi> createState() => _DetailRekamMedisRevisiState(this.tf);
}

class _DetailRekamMedisRevisiState extends State<DetailRekamMedisRevisi> {

  _DetailRekamMedisRevisiState(this.tf);
  late int tf;

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final storage = new FlutterSecureStorage();
  var loading = true;



  ///////////////////get data rekam medis pasien
  late var jsonList;
  late Map isiandata;


  void getData(id) async {
    try {
      String? token = await storage.read(key: 'token');
      Provider.of<Auth>(context, listen: false).getToken(token: token);

      Dio.Response response = await dio().get('/lihatdatarekampasien/$id',options: Dio.Options(headers: {'Authorization' : 'Bearer $token'}));


      if(response.statusCode == 200){
        print(response.data['data']);
        isiandata = response.data['data'];
        setState(() {
          jsonList = response.data['data']['pasienrekam'] as List;
          print('jumlah pasien rekam : ${jsonList.length}');
          //print(jsonList[0]);
          loading = false;
        });
      }else{
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
    //_foundData = _allData;
  }


  @override
  void initState() {
    // TODO: implement initState

    //print(tf);

    getData(tf);


    super.initState();
  }


  //////////////////////timer atribut



  late Timer _timer;
  int _start = 2;


  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            Route route = MaterialPageRoute(builder: (context) => RekamMedisRevisi());
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

      body: loading == true ? Center(child: CircularProgressIndicator(color: Color(0xff189CAB),)) :
      ListView(
        padding: EdgeInsets.only(left: 20,right: 20),
        children: [
          SizedBox(height: 20,),
          Text("Pasien",style: GoogleFonts.nunito(fontSize: 24,fontWeight: FontWeight.bold)),
          SizedBox(height: 10,),
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
                      Flexible(child: Text(isiandata['name'],style: GoogleFonts.nunito(fontSize: 21,fontWeight: FontWeight.bold),maxLines: 3,)),
                      Text( isiandata['created_at'].substring(0,10),style: GoogleFonts.nunito())
                    ],
                  ),
 //                 Text('Poli : ${tf['poli']}',style: GoogleFonts.nunito()),
 //                 Text('Jenis Pelayanan : ${tf['jenis_pelayanan']}',style: GoogleFonts.nunito(),),

                  SizedBox(height: 15,),


                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nama          ',style: GoogleFonts.nunito(fontSize: 18),),
                      Text(' : ',style: GoogleFonts.nunito(fontSize: 18),),
                      Flexible(child: Text(isiandata['name'],style: GoogleFonts.nunito(fontSize: 18),maxLines: 2,)),
                    ],
                  ),

                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text('NIK              ',style: GoogleFonts.nunito(fontSize: 18),),
                      Text(' : ',style: GoogleFonts.nunito(fontSize: 18),),
                      Flexible(child: Text(isiandata['nik'],style: GoogleFonts.nunito(fontSize: 18),maxLines: 2,)),
                    ],
                  ),

                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Alamat        ',style: GoogleFonts.nunito(fontSize: 18),),
                      Text(' : ',style: GoogleFonts.nunito(fontSize: 18),),
                      Flexible(child: Text(isiandata['alamat'],style: GoogleFonts.nunito(fontSize: 18), maxLines: 8,)),
                    ],
                  ),

                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tgl Lahir      ',style: GoogleFonts.nunito(fontSize: 18),),
                      Text(' : ',style: GoogleFonts.nunito(fontSize: 18),),
                      Flexible(child: Text(isiandata['tgl_lahir'],style: GoogleFonts.nunito(fontSize: 18), maxLines: 4,)),
                    ],
                  ),

                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('J Kelamin     ',style: GoogleFonts.nunito(fontSize: 18),),
                      Text(' : ',style: GoogleFonts.nunito(fontSize: 18),),
                      Flexible(child: Text(isiandata['jenis_kelamin'],style: GoogleFonts.nunito(fontSize: 18), maxLines: 4,)),
                    ],
                  ),

                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Agama         ',style: GoogleFonts.nunito(fontSize: 18),),
                      Text(' : ',style: GoogleFonts.nunito(fontSize: 18),),
                      Flexible(child: Text(isiandata['agama'],style: GoogleFonts.nunito(fontSize: 18), maxLines: 4,)),
                    ],
                  ),

                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pekerjaan     ',style: GoogleFonts.nunito(fontSize: 18),),
                      Text(' : ',style: GoogleFonts.nunito(fontSize: 18),),
                      Flexible(child: Text(isiandata['pekerjaan'],style: GoogleFonts.nunito(fontSize: 18), maxLines: 4,)),
                    ],
                  ),

                  SizedBox(height: 20,),

                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      SizedBox(
                        //width: 140,
                        child: ElevatedButton(
                            onPressed: (){


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
          SizedBox(height: 30,),

          Text("Riwayat Rekam Medis",style: GoogleFonts.nunito(fontSize: 24,fontWeight: FontWeight.bold)),

          SizedBox(height: 5,),



          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: jsonList == null ? 0 : jsonList.length,
            //itemCount: jsonList.length,
            itemBuilder: (BuildContext context, int index) {

              if(isiandata['pasienrekam'][index]['terapi'] != null){
               return Column(
                children: [
                  SizedBox(height: 10,),
                  Container(
                    //margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10.0),
                    ),

                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('No RM        ',style: GoogleFonts.nunito(fontSize: 18),),
                            Text(' : ',style: GoogleFonts.nunito(fontSize: 18),),
                            Text(isiandata['pasienrekam'][index]['nomor'],style: GoogleFonts.nunito(fontSize: 18),),
                          ],
                        ),
                        SizedBox(height: 5,),

                        Row(
                          children: [
                            Text('J Pelayanan',style: GoogleFonts.nunito(fontSize: 18),),
                            Text(' : ',style: GoogleFonts.nunito(fontSize: 18),),
                            Text(isiandata['pasienrekam'][index]['jenis_pelayanan'],style: GoogleFonts.nunito(fontSize: 18),),
                          ],
                        ),
                        SizedBox(height: 5,),

                        Row(
                          children: [
                            Text('J Poli           ',style: GoogleFonts.nunito(fontSize: 18),),
                            Text(' : ',style: GoogleFonts.nunito(fontSize: 18),),
                            Text(isiandata['pasienrekam'][index]['poli'],style: GoogleFonts.nunito(fontSize: 18),),
                          ],
                        ),
                        SizedBox(height: 5,),

                        Row(
                          children: [
                            Text('Diagnosa    ',style: GoogleFonts.nunito(fontSize: 18),),
                            Text(' : ',style: GoogleFonts.nunito(fontSize: 18),),
                            Flexible(child: Text(isiandata['pasienrekam'][index]['diagnosa'].toString(),style: GoogleFonts.nunito(fontSize: 18),)),
                          ],
                        ),
                        SizedBox(height: 5,),

                        Row(
                          children: [
                            Text('Terapi          ',style: GoogleFonts.nunito(fontSize: 18),),
                            Text(' : ',style: GoogleFonts.nunito(fontSize: 18),),
                            Flexible(child: Text(isiandata['pasienrekam'][index]['terapi'].toString(),style: GoogleFonts.nunito(fontSize: 18), maxLines: 5,)),
                          ],
                        ),
                        SizedBox(height: 5,),

                        Row(
                          children: [
                            Text('Keterangan ',style: GoogleFonts.nunito(fontSize: 18),),
                            Text(' : ',style: GoogleFonts.nunito(fontSize: 18),),
                            Flexible(child: Text(isiandata['pasienrekam'][index]['keterangan'].toString(),style: GoogleFonts.nunito(fontSize: 18),maxLines: 5,)),
                          ],
                        ),
                        SizedBox(height: 5,),

                        Row(
                          children: [
                            Text('Tgl Periksa  ',style: GoogleFonts.nunito(fontSize: 18),),
                            Text(' : ',style: GoogleFonts.nunito(fontSize: 18),),
                            Text(isiandata['pasienrekam'][index]['created_at'].substring(0,10),style: GoogleFonts.nunito(fontSize: 18),),
                          ],
                        ),
                        SizedBox(height: 5,),


                      ],
                    ),

                  ),
                ],
              );}
              else{
                return Container();
              }
            }
          ),



          SizedBox(height: 60,),






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
          content: new Text("Apakah anda yakin akan menghapus data pasien ini ??"),
          actions: <Widget>[
            new TextButton(
              child: new Text("OK"),
              onPressed: () {


                loading = true;
                print('Anda telah log menghapus data');
                Provider.of<Auth>(context, listen: false)
                    .deletePost(id: tf);
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
