

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rekammedishbb/revisi/data%20_pasien/isi_antrian_pasien.dart';

import '../../main_screen/logout_screen.dart';
import '../../services/auth.dart';

class LihatDataPasien extends StatefulWidget {
  LihatDataPasien({Key? key, required this.tf}) : super(key: key);
  Map tf;

  @override
  State<LihatDataPasien> createState() => _LihatDataPasienState(this.tf);
}

class _LihatDataPasienState extends State<LihatDataPasien> {
  _LihatDataPasienState(this.tf);
  late Map tf;


  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final _formKey = GlobalKey<FormState>();


  TextEditingController _diagnosaController = TextEditingController();
  TextEditingController _terapiController = TextEditingController();
  TextEditingController  _keteranganController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: AppBar(
          backgroundColor: Color(0xff189CAB),
          //leading: Icon(Icons.menu,color: Colors.white,),
          leading: IconButton(
            onPressed:  (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back,color: Colors.white,),
          ),
          title:Row(
            children: [
              //Icon(Icons.plus,color: Colors.white,),
              SvgPicture.asset('assets/image/bookofhealth.svg',width: 25,height: 25),
              SizedBox(width: 9,),
              Text('Data Pasien',style: GoogleFonts.nunito(color: Colors.white)),
              Spacer(),
              IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LogOutScreen()));
                  }, icon: Icon(Icons.person,color: Colors.white,))
            ],
          ),
        ),
        /*body: Container(
        child: Text('Isi Data Pasien Admin',style: GoogleFonts.nunito(fontSize: 30,fontWeight: FontWeight.bold),),
      ),*/

        body:
        Column(
          children: [
            SizedBox(height: 10,),

            //Center(child: Text('Data Pasien',style: GoogleFonts.nunito(fontSize: 30,fontWeight: FontWeight.bold),)),





            Form(
              key: _formKey,
              child: Expanded(
                flex: 1,
                child: Container(
                    margin: EdgeInsets.only(left: 20,right: 20),
                    child: ListView(
                      //mainAxisSize: MainAxisSize.max,
                      children:<Widget>[

                        //_textInput(hint: "xx-xxxx-xx",controller: _nomorController,validVar: 'Tolong isi nomor yang sesuai',judul: 'No RM'),
                        //_textInput(hint: "NIK",controller: _nikController,validVar: 'Tolong isi password yang sesuai',judul: "NIK"),
                        //_textInput(hint: "Nama Pasien",controller: _namapasienController,validVar: 'Tolong isi nama pasien yang sesuai',judul: "Nama"),
                        //_textInput(hint: "Tanggal Lahir",controller: _tanggallahirpasienController,validVar: 'Tolong isi tanggal lahir yang sesuai',judul: "Tanggal Lahir"),

                        TextFieldWidget(
                          //'E-mail',idx['jenis_layanan'], Icons.mail_outline),
                            'Nama Pasien','${tf["name"]}', Icons.person),

                        TextFieldWidget(
                          //'E-mail',idx['jenis_layanan'], Icons.mail_outline),
                            'Tanggal Lahir','${tf["tgl_lahir"]}', Icons.baby_changing_station),

                        TextFieldWidget(
                          //'E-mail',idx['jenis_layanan'], Icons.mail_outline),
                            'Alamat','${tf["alamat"]}', Icons.location_on),

                        TextFieldWidget(
                          //'E-mail',idx['jenis_layanan'], Icons.mail_outline),
                            'Jenis Kelamin','${tf["jenis_kelamin"]}', Icons.man),

                        TextFieldWidget(
                          //'E-mail',idx['jenis_layanan'], Icons.mail_outline),
                            'Agama','${tf["agama"]}', Icons.mosque),

                        TextFieldWidget(
                          //'E-mail',idx['jenis_layanan'], Icons.mail_outline),
                            'Pekerjaan','${tf["pekerjaan"]}', Icons.work),



                        SizedBox(height: 20,),

                        Center(
                          child: SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width*0.5,
                            child: ElevatedButton(

                                onPressed: (){


                                  /*if(_formKey.currentState!.validate()){
                                    Provider.of<Auth>(context, listen: false)
                                        .updateDokter(creds:creds,id: tf["id"]);
                                    Navigator.pop(context,true);
                                  }*/

                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>IsiAntrianPasien(tf: tf,)));


                                },
                                //child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 18),),
                                child: Text("Buat Antrian",style: GoogleFonts.nunito(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
                                style: ButtonStyle(

                                    foregroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xffFBBD08)),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.zero,
                                            side: BorderSide(color: Color(0xffFBBD08))
                                        )
                                    )
                                )



                            ),
                          ),
                        ),

                        SizedBox(height: 30,)

















                      ],)
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
              Flexible(
                child: Text(isian,
                  maxLines: 4,
                  softWrap: true,
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54),
                ),
              ),
            ],
          ),




        )
      ],
    );
  }
  ////////////////////


  ////////////////
  Widget _textInput({controller, hint,validVar,judul}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10,),
        Text(judul),
        SizedBox(height: 5,),
        Container(
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Color(0xffEBE3CC80),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          padding: EdgeInsets.only(left: 10),
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,

            ),
            controller: controller,
            validator: (value) => value!.isEmpty ? validVar : null,
          ),
        ),
      ],
    );
  }





  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Padding(
      padding: EdgeInsets.only(left: 10),
      child: Text(item,
        style: TextStyle(fontSize: 14),
      ),
    ),
  );
}
