//import 'package:arsipdian/screens/home_screen.dart';
//import 'package:arsipdian/screens/register.dart';
import 'dart:async';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rekammedishbb/main_screen/dashboard_screen.dart';
import 'package:rekammedishbb/main_screen/splahscreen.dart';
import 'package:rekammedishbb/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../services/dio.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();


  readToken() async {


    String? token = await storage.read(key: 'token');

    Dio.Response response = await dio().get('/getalluser',
        options: Dio.Options(headers: {'Authorization' : 'Bearer $token'}));

    print(response);
    print(response.data['data']);
    //print(responseStatus.data['data']['Proses']);

    if(token != null)
    setState(() {

      Route route = MaterialPageRoute(builder: (context) => SplashScreen());
      Navigator.pushReplacement(context, route);

    });


  }

  @override
  void initState() {
    _usernameController.text = '';
    _passwordController.text = '';
    readToken();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _timer.cancel();
    super.dispose();
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
            Route route = MaterialPageRoute(builder: (context) => LoginScreen());
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
                                    Route route = MaterialPageRoute(builder: (context) => SplashScreen());
                                    Navigator.pushReplacement(context, route);
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
      ),

    );
  }
}
