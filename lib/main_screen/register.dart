//import 'package:arsipdian/screens/home_screen.dart';
//import 'package:arsipdian/screens/register.dart';
import 'dart:async';

import 'package:rekammedishbb/main_screen/dashboard_screen.dart';
import 'package:rekammedishbb/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Register> {
  TextEditingController _emailnameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _jabatanController = TextEditingController();
  TextEditingController _poliController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late int indexvalueJabatan;
  late int indexvaluePoli;
  String? valueJabatan;
  String? valuePoli;

  final statusJabatan = [
    'Dokter',
    'Admin',
    'Petugas Admin'

  ];

  final statusPoli = [
    'Umum',
    'Gigi',
    'Anak',
    'KIA',
    'MTBS',
    "Non Dokter"

  ];


  @override
  void initState() {
    _usernameController.text = '';
    _passwordController.text = '';
    _nameController.text = '';
    _jabatanController.text="";
    _poliController.text = '';
    _emailnameController.text = '';
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
            Navigator.pop(context);
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
    _usernameController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _jabatanController.dispose();
    _poliController.dispose();
    _emailnameController.dispose();
    _timer.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff189CAB),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height*0.3 + 70,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          //height: 240,
                          height: MediaQuery.of(context).size.height*0.3,
                          decoration: BoxDecoration(
                              color: Color(0xff189CAB),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(100),
                                  bottomLeft: Radius.circular(100))),
                          child: Stack(
                            children: [
                              Center(
                                child: Column(
                                  children: [
                                    SizedBox(height: 20,),
                                    Text(
                                      'Medical',
                                      style: GoogleFonts.pacifico(fontSize: 48,color: Colors.white,),
                                    ),
                                    Text(
                                      'Records',
                                      style: GoogleFonts.pacifico(fontSize: 48,color: Colors.white,),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          //child: ,
                        ),

                      ],
                    ),
                    Positioned(
                        top: MediaQuery.of(context).size.height*0.23,
                        left: MediaQuery.of(context).size.width*0.38,
                        //left:,
                        child:
                        //Image.asset('assets/image/loginlogo.png',height: 100,width: 100,)
                        Image.asset('assets/image/loginlogo.png',height: 100,width: 100,)

                      /*Container(
                          color: Colors.black54,
                          height: 100,
                          width: 100,

                        )*/
                    )
                  ],
                ),
              ),

              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width*0.15,
                    right: MediaQuery.of(context).size.width*0.15,
                  ),
                  children: <Widget>[
                    Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text('E-mail',style: GoogleFonts.nunito(fontSize: 16,color: Colors.black87),),
                            SizedBox(height: 10,),

                            TextFormField(
                                decoration:new InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                    labelText: 'Masukan E-mail',
                                    prefixIcon: Icon(Icons.mail)
                                ),
                                controller: _emailnameController,
                                validator: (value) => value!.isEmpty ? 'Tolong masukan email yang benar' : null
                            ),

                            SizedBox(height: 20,),

                            Text('Nama',style: GoogleFonts.nunito(fontSize: 16,color: Colors.black87),),
                            SizedBox(height: 10,),

                            TextFormField(
                                decoration:new InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                    labelText: 'Masukan Nama',
                                    prefixIcon: Icon(Icons.person)
                                ),
                                controller: _nameController,
                                validator: (value) => value!.isEmpty ? 'Tolong masukan nama yang sesuai' : null
                            ),

                            SizedBox(height: 20,),

                            Text('Username',style: GoogleFonts.nunito(fontSize: 16,color: Colors.black87),),
                            SizedBox(height: 10,),

                            TextFormField(
                                decoration:new InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                    labelText: 'Masukan Username',
                                    prefixIcon: Icon(Icons.person)
                                ),
                                controller: _usernameController,
                                validator: (value) => value!.isEmpty ? 'Tolong masukan username yang sesuai' : null
                            ),

                            SizedBox(height: 20,),


                            Text('Password',style: GoogleFonts.nunito(fontSize: 16,color: Colors.black87),),


                            SizedBox(height: 10,),


                            TextFormField(
                                decoration:new InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                    labelText: 'Masukan Passwordnya',
                                    //prefixIcon: prefixIcon??Icon(Icons.done),
                                    prefixIcon: Icon(Icons.key)



                                ),
                                obscureText: true,
                                controller: _passwordController,
                                validator: (value) => value!.isEmpty ? 'Tolong masukan password yang sesuai' : null
                            ),

                            SizedBox(height: 20,),

                            ///////////////////////////////dropdown jabatan
                            Text('Jabatan',style: GoogleFonts.nunito(fontSize: 16,color: Colors.black87),),
                            SizedBox(height: 10,),

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
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: valueJabatan,
                                        iconSize: 30,
                                        isExpanded: true,
                                        icon: Icon(Icons.arrow_drop_down,color: Colors.black87,),
                                        //items: itemsList.map(buildMenuItem).toList(),
                                        items: statusJabatan.map(buildMenuItem).toList(),
                                        onChanged: (value) => setState(() {
                                          this.valueJabatan = value;

                                          print(valueJabatan);
                                          print(statusJabatan.indexOf(value!));

                                          this.indexvalueJabatan = statusJabatan.indexOf(value!);
                                          print('valuenya adalah $indexvalueJabatan');

                                        }),
                                      ),
                                    ),
                                  ),



                                ],
                              ),
                            ),
                            /*TextFormField(
                                decoration:new InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                    labelText: 'Masukan E-mail',
                                    prefixIcon: Icon(Icons.mail)
                                ),
                                controller: _emailnameController,
                                validator: (value) => value!.isEmpty ? 'Tolong masukan email yang benar' : null
                            ),*/

                            SizedBox(height: 20,),

                            //////////////dropdown


                            ///////////////////////////////dropdown poli
                            Text('Poli',style: GoogleFonts.nunito(fontSize: 16,color: Colors.black87),),
                            SizedBox(height: 10,),

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
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: valuePoli,
                                        iconSize: 30,
                                        isExpanded: true,
                                        icon: Icon(Icons.arrow_drop_down,color: Colors.black87,),
                                        //items: itemsList.map(buildMenuItem).toList(),
                                        items: statusPoli.map(buildMenuItem).toList(),
                                        onChanged: (value) => setState(() {
                                          this.valuePoli = value;

                                          print(valuePoli);
                                          print(statusPoli.indexOf(value!));

                                          this.indexvaluePoli = statusJabatan.indexOf(value!);
                                          print('valuenya adalah $indexvaluePoli');

                                        }),
                                      ),
                                    ),
                                  ),



                                ],
                              ),
                            ),
                            /*TextFormField(
                                decoration:new InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                    labelText: 'Masukan E-mail',
                                    prefixIcon: Icon(Icons.mail)
                                ),
                                controller: _emailnameController,
                                validator: (value) => value!.isEmpty ? 'Tolong masukan email yang benar' : null
                            ),*/

                            SizedBox(height: 30),

                            //////////////dropdown



                            Center(
                              child: SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width*0.5,
                                child: ElevatedButton(

                                    onPressed: (){


                                      Map creds = {
                                        'email': _emailnameController.text,
                                        'name': _nameController.text,
                                        'username' : _usernameController.text,
                                        'password' : _passwordController.text,
                                        'jabatan': indexvalueJabatan,
                                        'poli':valuePoli
                                      };

                                      print(creds);

                                      if(_formKey.currentState!.validate()){
                                        Provider.of<Auth>(context, listen: false)
                                           .register(creds:creds);
                                      }

                                      startTimer();

                                    },
                                    //child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 18),),
                                    child: Text("Register Akun",style: GoogleFonts.nunito(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
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

                            SizedBox(height: 30,),










                          ],
                        ))

                  ],
                ),
              )




            ],
          ),
        ),
      ),



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
