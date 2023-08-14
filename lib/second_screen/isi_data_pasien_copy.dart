

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rekammedishbb/main_screen/dashboard_screen.dart';
import 'package:rekammedishbb/main_screen/data_pasien.dart';

import '../main_screen/logout_screen.dart';
import '../services/auth.dart';

class IsiDataPasienCopy extends StatefulWidget {
  IsiDataPasienCopy({Key? key,required this.tf}) : super(key: key);
  Map tf;

  @override
  State<IsiDataPasienCopy> createState() => _IsiDataPasienCopyState(this.tf);
}

class _IsiDataPasienCopyState extends State<IsiDataPasienCopy> {
  _IsiDataPasienCopyState(this.tf);
  late Map tf;


  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final _formKey = GlobalKey<FormState>();

  //dropdown
  String? valuePoli;
  String? valueJenisLayanan;
  String? valueJenisKelamin;
  late int indexvaluePoli;
  late int indexvalueJenisLayanan;
  late int indexvalueJenisKelamin;

  final statusPoli = [
    'Umum',
    'Gigi',
    'Anak',
    'KIA',
    'MTBS',
  ];

  final statusJenisLayanan = [
    'Umum',
    'BPJS',

  ];

  final statusJenisKelamin = [
    'Pria',
    'Wanita',

  ];






  /////////////

  TextEditingController _nomorController = TextEditingController();
  TextEditingController _namapasienController = TextEditingController();
  TextEditingController _nikController = TextEditingController();
  TextEditingController _tanggallahirpasienController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _agamaController = TextEditingController();
  TextEditingController  _pekerjaanController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    _nikController.text = tf['nik'];
    _namapasienController.text = tf['name'];
    _tanggallahirpasienController.text = tf['tgl_lahir'];
    _alamatController.text = tf['alamat'];
    _agamaController.text = tf['agama'];
    _pekerjaanController.text = tf['pekerjaan'];
    valueJenisKelamin = tf['jenis_kelamin'];

    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    print(tf.toString());
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
              Text('Isi Data Pasien Copy',style: GoogleFonts.nunito(color: Colors.white)),
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

            Center(child: Text('Isi Data Pasien Admin',style: GoogleFonts.nunito(fontSize: 30,fontWeight: FontWeight.bold),)),





            Form(
              key: _formKey,
              child: Expanded(
                flex: 1,
                child: Container(
                    margin: EdgeInsets.only(left: 20,right: 20,top: 30),
                    child: ListView(
                      //mainAxisSize: MainAxisSize.max,
                      children:<Widget>[

                        _textInput(hint: "xx-xxxx-xx",controller: _nomorController,validVar: 'Tolong isi nomor yang sesuai',judul: 'No RM'),
                        _textInput(hint: "NIK",controller: _nikController,validVar: 'Tolong isi password yang sesuai',judul: "NIK"),
                        _textInput(hint: "Nama Pasien",controller: _namapasienController,validVar: 'Tolong isi nama pasien yang sesuai',judul: "Nama"),
                        _textInput(hint: "Tanggal Lahir",controller: _tanggallahirpasienController,validVar: 'Tolong isi tanggal lahir yang sesuai',judul: "Tanggal Lahir"),
                        _textInput(hint: "Alamat",controller: _alamatController,validVar: 'Tolong isi alamat lahir yang sesuai',judul: "Alamat"),


                        ////////////////JENIS KELAMIN
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15,),
                            Text(
                              'Jenis Kelamin',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              // height: 50,
                              decoration: BoxDecoration(
                                  color: Color(0xffEBE3CC80),
                                  boxShadow: [
                                    BoxShadow(
                                      //color: Colors.black.withOpacity(0.05),
                                        color: Colors.black.withOpacity(0.25),
                                        spreadRadius: 1,
                                        blurRadius: 1)
                                  ],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: valueJenisKelamin,
                                        iconSize: 30,
                                        isExpanded: true,
                                        icon: Icon(Icons.arrow_drop_down,color: Colors.grey,),
                                        //items: itemsList.map(buildMenuItem).toList(),
                                        items: statusJenisKelamin.map(buildMenuItem).toList(),
                                        onChanged: (value) => setState(() {
                                          this.valueJenisKelamin = value;

                                          print(valueJenisKelamin);
                                          print(statusJenisKelamin.indexOf(value!));

                                          this.indexvalueJenisKelamin = statusJenisKelamin.indexOf(value!);
                                          print('valuenya adalah $indexvalueJenisKelamin');

                                        }),
                                      ),
                                    ),
                                  ),



                                ],
                              ),
                            )
                          ],
                        ),
                        ////////////////////JENIS KELAMIN DONE


                        _textInput(hint: "Agama",controller: _agamaController,validVar: 'Tolong isi Agama yang sesuai',judul: "Agama"),
                        _textInput(hint: "Pekerjaan",controller: _pekerjaanController,validVar: 'Tolong isi Pekerjaan yang sesuai',judul: "Pekerjaan"),


                        ////////////////JENIS LAYANAN
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Text(
                              'Jenis Layanan',
                              //style: GoogleFonts.poppins(
                              //fontSize: 14,
                              //fontWeight: FontWeight.w600,
                              //color: Color(0xffA7A7A7)),
                              //color: Color(0xffA7A7A7)),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              // height: 50,
                              decoration: BoxDecoration(
                                  color: Color(0xffEBE3CC80),
                                  boxShadow: [
                                    BoxShadow(
                                      //color: Colors.black.withOpacity(0.05),
                                        color: Colors.black.withOpacity(0.25),
                                        spreadRadius: 1,
                                        blurRadius: 1)
                                  ],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: valueJenisLayanan,
                                        iconSize: 30,
                                        isExpanded: true,
                                        icon: Icon(Icons.arrow_drop_down,color: Colors.grey,),
                                        //items: itemsList.map(buildMenuItem).toList(),
                                        items: statusJenisLayanan.map(buildMenuItem).toList(),
                                        onChanged: (value) => setState(() {
                                          this.valueJenisLayanan = value;

                                          print(valueJenisLayanan);
                                          print(statusJenisLayanan.indexOf(value!));

                                          this.indexvalueJenisLayanan = statusJenisLayanan.indexOf(value!);
                                          print('valuenya adalah $indexvalueJenisLayanan');

                                        }),
                                      ),
                                    ),
                                  ),



                                ],
                              ),
                            )
                          ],
                        ),
                        ////////////////////JENIS LAYANAN DONE

                        ////////////////POLI
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Text(
                              'Poli',
                              //style: GoogleFonts.poppins(
                              //fontSize: 14,
                              //fontWeight: FontWeight.w600,
                              //color: Color(0xffA7A7A7)),
                              //color: Color(0xffA7A7A7)),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              // height: 50,
                              decoration: BoxDecoration(
                                  color: Color(0xffEBE3CC80),
                                  boxShadow: [
                                    BoxShadow(
                                      //color: Colors.black.withOpacity(0.05),
                                        color: Colors.black.withOpacity(0.25),
                                        spreadRadius: 1,
                                        blurRadius: 1)
                                  ],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: valuePoli,
                                        iconSize: 30,
                                        isExpanded: true,
                                        icon: Icon(Icons.arrow_drop_down,color: Colors.grey,),
                                        //items: itemsList.map(buildMenuItem).toList(),
                                        items: statusPoli.map(buildMenuItem).toList(),
                                        onChanged: (value) => setState(() {
                                          this.valuePoli = value;

                                          print(valuePoli);
                                          print(statusPoli.indexOf(value!));

                                          this.indexvaluePoli = statusPoli.indexOf(value!);
                                          print('valuenya adalah $indexvaluePoli');

                                        }),
                                      ),
                                    ),
                                  ),



                                ],
                              ),
                            )
                          ],
                        ),
                        ////////////////////POLI ANAK DONE





                        //SizedBox(height: 40,)
                        SizedBox(height: 20,),

                        Center(
                          child: SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width*0.5,
                            child: ElevatedButton(

                                onPressed: (){


                                  Map creds = {
                                    //'username' : _usernameController.text,
                                    //'password' :   _passwordController.text,
                                    'nomor': _nomorController.text,
                                    'nik': _nikController.text,
                                    'name': _namapasienController.text,
                                    'tgl_lahir': _tanggallahirpasienController.text,
                                    'alamat': _alamatController.text,
                                    'jenis_kelamin': valueJenisKelamin,
                                    'agama': _agamaController.text,
                                    'pekerjaan': _pekerjaanController.text,
                                    'jenis_pelayanan': valueJenisLayanan,
                                    'poli': valuePoli
                                  };

                                  print(creds);

                                  if(_formKey.currentState!.validate()){
                                    Provider.of<Auth>(context, listen: false)
                                        .createDataPasien(creds:creds);

                                    Navigator.of(context).popUntil((route) => route.isFirst);

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
