


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rekammedishbb/main_screen/login_screen.dart';

import '../services/auth.dart';

class LogOutScreen extends StatefulWidget {
  const LogOutScreen({Key? key}) : super(key: key);

  @override
  State<LogOutScreen> createState() => _LogOutScreenState();
}

class _LogOutScreenState extends State<LogOutScreen> {

  final statusJabatan = [
    'Dokter',
    'Admin',
    'Petugas Admin'

  ];

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
  void dispose() {
    _timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final userdata = Provider.of<Auth>(context);
    print(userdata.user?.poli);
    return Scaffold(
      backgroundColor: Color(0xff189CAB),
      body: loading == true ? Center(child: CircularProgressIndicator(color: Colors.white,)) :SafeArea(
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
                              ),
                              Positioned(
                                top: 5,
                                  left: 5,
                                  child:
                                  IconButton(
                                    onPressed: (){
                                      print('back arrow tapped');
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.arrow_back,color: Colors.white,size: 30,),
                                  )

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
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: CircleAvatar(
                          //backgroundColor: Colors.grey,
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          child: Image.asset('assets/image/add_user.png',width: 70,height: 70,color: Colors.white,),
                        ),
                      )

                    ),

                  ],
                ),
              ),
              SizedBox(height: 20,),
              //Text('Dr. Johny Laksono',style: GoogleFonts.nunito(fontSize: 24, color: Colors.black54),),
              Text('${userdata.user?.name}',style: GoogleFonts.nunito(fontSize: 24, color: Colors.black54),),
              SizedBox(height: 10,),
              Text('${statusJabatan[userdata.user!.jabatan]}',style: GoogleFonts.nunito(fontSize: 24, color: Colors.black54),),
              SizedBox(height: 0,),
              //Text('Umum',style: GoogleFonts.nunito(fontSize: 24, color: Colors.black54),),
              userdata.user?.poli == null ?
              Text('Non Dokter',style: GoogleFonts.nunito(fontSize: 24, color: Colors.black54),) :
              Text('${userdata.user!.poli}',style: GoogleFonts.nunito(fontSize: 24, color: Colors.black54),),


              Spacer(),


              Center(
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width*0.5,
                  child: ElevatedButton(

                      onPressed: (){

                        /*loading = true;
                        print('Anda telah log out');
                          Provider.of<Auth>(context, listen: false)
                              .logout();
                          startTimer();*/

                        _showDialog(context);





                      },
                      //child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 18),),
                      child: Text("Log Out",style: GoogleFonts.nunito(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
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






              SizedBox(height: 20,),


              Spacer(),




            ],
          ),
        ),
      ),

    );




  }



  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Log Out!!"),
          content: new Text("Apakah anda yakin akan log out??"),
          actions: <Widget>[
            new TextButton(
              child: new Text("OK"),
              onPressed: () {

                /*Provider.of<Auth>(context, listen: false)
                    .logout();

                Navigator.of(context).pop();

                setState(() {
                  authBool = false;
                  isDataLoaded = false;
                });*/

                loading = true;
                print('Anda telah log out');
                Provider.of<Auth>(context, listen: false)
                .logout();
                Navigator.of(context).pop();
                startTimer();


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
