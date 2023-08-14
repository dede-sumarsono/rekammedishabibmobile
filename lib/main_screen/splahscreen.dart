//import 'package:arsipdian/screens/home_screen.dart';
//import 'package:arsipdian/screens/register.dart';
import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rekammedishbb/main_screen/dashboard_screen.dart';
import 'package:rekammedishbb/main_screen/login_screen.dart';
import 'package:rekammedishbb/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final _formKey = GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();
  late Timer _timer;
  int _start = 3;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {

            final userdata = Provider.of<Auth>(context);

            if(! userdata.authenticated){
              Route route = MaterialPageRoute(builder: (context) => LoginScreen());
              Navigator.pushReplacement(context, route);
            }else{
              print('authentikasi dibutuhkan');
            }


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




  readToken() async {


    String? token = await storage.read(key: 'token');
    Provider.of<Auth>(context, listen: false).getToken(token:token);



  }

  @override
  void initState() {
    readToken();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff189CAB),
      body:

          Consumer<Auth>(builder: (context,auth,child){
            if (! auth.authenticated) {
              startTimer();
              return Center(child: CircularProgressIndicator(color: Colors.white,));

            //}else if( auth.authenticated && auth.user?.username == null ){
            }else if(auth.user?.username == null ){
              return const Center(
                  child: CircularProgressIndicator()
              );
            }else{
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.centerRight,
                    colors: <Color>[
                      Color(0xff189CAB),
                      Color(0xff5f9fa6),
                      Color(0xff005059),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30,),
                      Text("Anda Sudah \n Login", style: GoogleFonts.poppins(fontSize: 38,color: Colors.white,fontWeight: FontWeight.w600),),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          SizedBox(width: 10,),
                          Text("Selamat datang di aplikasi Rekam Medis \n salam sehat untuk kita semua ^_^", style: GoogleFonts.poppins(fontSize: 14,color: Colors.white,fontWeight: FontWeight.w600),),
                        ],
                      ),
                      Spacer(),

                      Center(
                        child: Image.asset('assets/image/loginlogo.png',
                          height: MediaQuery.of(context).size.height*0.4,

                        ),
                      ),

                      Spacer(),
                      Center(child: Text("Klik Tombol Next di Bawah ini",style: GoogleFonts.nunito(color: Colors.white),)),



                      SizedBox(height: 10,),
                      Center(
                        child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width*0.5,
                          child: ElevatedButton(

                              onPressed: (){
                                Route route = MaterialPageRoute(builder: (context) => DashboardScreen());
                                Navigator.pushReplacement(context, route);
                                /*if(auth.user!.jabatan == 0 ){
                                  Route route = MaterialPageRoute(builder: (context) => DashboardScreen());
                                  Navigator.pushReplacement(context, route);
                                  print('Anda adalah Dokter');
                                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardScreen()));
                                }else if(auth.user!.jabatan == 1){
                                  print('Anda adalah Admin');
                                  Route route = MaterialPageRoute(builder: (context) => DashboardScreen());
                                  Navigator.pushReplacement(context, route);
                                }else if(auth.user!.jabatan == 2){
                                  print('Anda adalah Petugas Admin');
                                  Route route = MaterialPageRoute(builder: (context) => DashboardScreen());
                                  Navigator.pushReplacement(context, route);
                                }else{
                                  String toast = 'User Jabatan tidak dikenali';
                                  Fluttertoast.showToast(
                                      msg: toast,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }*/


                              },
                              child: Text("Next",style: GoogleFonts.nunito(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
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

                      Spacer()

                    ],
                  ),
                ),
              );
            }







          },)





      /*SafeArea(
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

                      *//*Container(
                          color: Colors.black54,
                          height: 100,
                          width: 100,

                        )*//*
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
                            Text('Username',style: GoogleFonts.nunito(fontSize: 16,color: Colors.black87),),
                            SizedBox(height: 10,),
                            TextFormField(
                                decoration:new InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                    labelText: 'Masukan Username',
                                    prefixIcon: Icon(Icons.person)
                                ),
                                controller: _usernameController,
                                validator: (value) => value!.isEmpty ? 'please enter valid username' : null
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
                                validator: (value) => value!.isEmpty ? 'please enter valid password' : null
                            ),

                            SizedBox(height: 30,),



                            Center(
                              child: SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width*0.5,
                                child: ElevatedButton(

                                    onPressed: (){


                                      Map creds = {
                                        'username' : _usernameController.text,
                                        'password' : _passwordController.text
                                      };

                                      print(creds);

                                      if(_formKey.currentState!.validate()){
                                        Provider.of<Auth>(context, listen: false)
                                            .login(creds:creds);
                                        //Navigator.pop(MaterialPageRoute(builder: (context)=>HomeScreen(boleh:"boleh")));
                                        *//*Route route = MaterialPageRoute(builder: (context) => DashboardScreen());
                                    Navigator.pushReplacement(context, route);*//*
                                      }

                                    },
                                    //child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 18),),
                                    child: Text("Login",style: GoogleFonts.nunito(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
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






                          ],
                        ))

                  ],
                ),
              )




            ],
          ),
        ),
      ),*/

    );
  }
}
