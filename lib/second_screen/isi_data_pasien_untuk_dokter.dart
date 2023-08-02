

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rekammedishbb/main_screen/data_pasien.dart';

import '../main_screen/logout_screen.dart';
import '../services/auth.dart';

class IsiDataPasienUntukDokter extends StatefulWidget {
  IsiDataPasienUntukDokter({Key? key, required this.tf}) : super(key: key);
  Map tf;

  @override
  State<IsiDataPasienUntukDokter> createState() => _IsiDataPasienUntukDokterState(this.tf);
}

class _IsiDataPasienUntukDokterState extends State<IsiDataPasienUntukDokter> {
  _IsiDataPasienUntukDokterState(this.tf);
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
            SizedBox(height: 20,),

            Center(child: Text('Hasil Pemeriksaan Pasien',style: GoogleFonts.nunito(fontSize: 30,fontWeight: FontWeight.bold),)),





            Form(
              key: _formKey,
              child: Expanded(
                flex: 1,
                child: Container(
                    margin: EdgeInsets.only(left: 20,right: 20,top: 30),
                    child: ListView(
                      //mainAxisSize: MainAxisSize.max,
                      children:<Widget>[

                        //_textInput(hint: "xx-xxxx-xx",controller: _nomorController,validVar: 'Tolong isi nomor yang sesuai',judul: 'No RM'),
                        //_textInput(hint: "NIK",controller: _nikController,validVar: 'Tolong isi password yang sesuai',judul: "NIK"),
                        //_textInput(hint: "Nama Pasien",controller: _namapasienController,validVar: 'Tolong isi nama pasien yang sesuai',judul: "Nama"),
                        //_textInput(hint: "Tanggal Lahir",controller: _tanggallahirpasienController,validVar: 'Tolong isi tanggal lahir yang sesuai',judul: "Tanggal Lahir"),
                        TextFieldWidget(
                          //'E-mail',idx['jenis_layanan'], Icons.mail_outline),
                            'Nomor Pasien','${tf["nomor"]}', Icons.numbers),

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

                        TextFieldWidget(
                          //'E-mail',idx['jenis_layanan'], Icons.mail_outline),
                            'Jenis Pelayanan','${tf["jenis_pelayanan"]}', Icons.home_repair_service),

                        TextFieldWidget(
                          //'E-mail',idx['jenis_layanan'], Icons.mail_outline),
                            'Poli','${tf["poli"]}', Icons.add),

                        _textInput(hint: "Diagnosa",controller: _diagnosaController,validVar: 'Tolong isi alamat lahir yang sesuai',judul: "Diagnosa"),
                        _textInput(hint: "terapi",controller: _terapiController,validVar: 'Tolong isi Agama yang sesuai',judul: "Terapi"),
                        _textInput(hint: "Keterangan",controller: _keteranganController,validVar: 'Tolong isi Pekerjaan yang sesuai',judul: "Keterangan Tambahan"),



                        SizedBox(height: 20,),

                        Center(
                          child: SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width*0.5,
                            child: ElevatedButton(

                                onPressed: (){


                                  Map creds = {

                                    'diagnosa':_diagnosaController.text,
                                    'terapi':_terapiController.text,
                                    'keterangan':_keteranganController.text
                                  };

                                  print(creds);

                                  if(_formKey.currentState!.validate()){
                                    Provider.of<Auth>(context, listen: false)
                                        .updateDokter(creds:creds,id: tf["id"]);
                                    Navigator.pop(context,true);
                                    //Navigator.pop(MaterialPageRoute(builder: (context)=>HomeScreen(boleh:"boleh")));
                                    //Route route = MaterialPageRoute(builder: (context) => DataPasien());
                                    //Navigator.pushReplacement(context, route);
                                  }


                                },
                                //child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 18),),
                                child: Text("Simpan",style: GoogleFonts.nunito(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
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
