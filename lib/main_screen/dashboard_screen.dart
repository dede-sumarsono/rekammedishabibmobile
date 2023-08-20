

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rekammedishbb/main_screen/logout_screen.dart';
import 'package:rekammedishbb/main_screen/data_pasien.dart';
import 'package:rekammedishbb/main_screen/register.dart';
import 'package:rekammedishbb/main_screen/rekam_medis.dart';
import 'package:rekammedishbb/revisi/data_antrian/data_antrian.dart';
import 'package:rekammedishbb/revisi/data_pasien_revisi.dart';
import 'package:rekammedishbb/revisi/rekam_medis_revisi.dart';
import 'package:rekammedishbb/second_screen/isi_data_pasien_untuk_dokter.dart';
import 'package:rekammedishbb/second_screen/total_pasien.dart';
import 'package:rekammedishbb/second_screen/user_list.dart';

import '../services/auth.dart';
import '../services/dio.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final storage = new FlutterSecureStorage();
  var totalUser;
  var totalPasien;
  bool getalluser = false;

  readToken() async {


    String? token = await storage.read(key: 'token');

    Dio.Response response = await dio().get('/getalluser',
        options: Dio.Options(headers: {'Authorization' : 'Bearer $token'}));

    Dio.Response response2 = await dio().get('/getallpasien2',
        options: Dio.Options(headers: {'Authorization' : 'Bearer $token'}));

    print(response);
    print(response2);
    print(response.data['data']);
    print(response2.data['data']);

    setState(() {
      totalUser = response.data['data'];
      totalPasien = response2.data['data'];
      getalluser = true;

    });


  }

  @override
  void initState() {
    readToken();
    // TODO: implement initState
    super.initState();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final userdata = Provider.of<Auth>(context);
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: Color(0xff189CAB),
        leading: IconButton(
          onPressed:  (){
            _key.currentState!.openDrawer();
          },
          icon: Icon(Icons.menu,color: Colors.white,),
        ),
        title:Row(
          children: [
            Icon(Icons.home,color: Colors.white,),
            SizedBox(width: 9,),
            Text('Dashboard',style: GoogleFonts.nunito(color: Colors.white)),
            Spacer(),
            IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LogOutScreen()));
                }, icon: Icon(Icons.person,color: Colors.white,))
          ],
        ),

      ),
      body: getalluser == false ? Center(child: CircularProgressIndicator(),)

      :Padding(
        padding: EdgeInsets.only(left: 30,top: 30,right: 30),
        child: Column(
          children: [

            userdata.user!.jabatan == 2 ?
            //userdata.user!.jabatan == 0 ?
            Column(
              children: [
                InkWell(
                  onTap: (){
                    print('Total Admin Klik');
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>UserList(tf: 'Admin')));
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>UserList(tf: '2')));
                  },
                  child: Container(
                    color: Colors.grey.withOpacity(0.5),
                    width: double.infinity,
                    height: 100,
                    child: Row(
                      children: [
                        Image.asset('assets/image/logo_petugas_admin.png',height: 90,width: 90,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20,),
                            Text('Total Petugas Admin',style: GoogleFonts.nunito(fontSize: 14,color: Colors.black),),
                            Text('${totalUser['Petugas Admin']}',style: GoogleFonts.nunito(fontSize: 34,fontWeight: FontWeight.bold,color: Colors.black),)

                          ],
                        )

                      ],
                    ),

                  ),

                ),

                SizedBox(height: 20,),

                InkWell(
                  onTap: (){
                    print('Total Admin Klik');
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>UserList(tf: 'Admin')));
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>UserList(tf: '1')));
                  },
                  child: Container(
                    color: Colors.grey.withOpacity(0.5),
                    width: double.infinity,
                    height: 100,
                    child: Row(
                      children: [
                        Image.asset('assets/image/logo_admin.png',height: 90,width: 90,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20,),
                            Text('Total Admin',style: GoogleFonts.nunito(fontSize: 14,color: Colors.black),),
                            Text('${totalUser['Admin']}',style: GoogleFonts.nunito(fontSize: 34,fontWeight: FontWeight.bold,color: Colors.black),)

                          ],
                        )

                      ],
                    ),

                  ),

                ),


              ],
            )




                :SizedBox(height: 1,),






            SizedBox(height: 20,),


            InkWell(
              onTap: (){
                print('Total Pasien');
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>UserList(tf: 'Pasien')));
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>TotalPasien()));
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DataAntrian()));

              },
              child: Container(
                color: Colors.grey.withOpacity(0.5),
                width: double.infinity,
                height: 100,
                child: Row(
                  children: [
                    Image.asset('assets/image/logo_pasien.png',height: 90,width: 90,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        Text('Total Pasien',style: GoogleFonts.nunito(fontSize: 14,color: Colors.black),),
                        Text('${totalPasien}',style: GoogleFonts.nunito(fontSize: 34,fontWeight: FontWeight.bold,color: Colors.black),)

                      ],
                    )

                  ],
                ),

              ),
            ),

            SizedBox(height: 20,),


            InkWell(
              onTap: (){
                print('Total Dokter');
                Navigator.push(context, MaterialPageRoute(builder: (context)=>UserList(tf: '0')));

              },
              child: Container(
                color: Colors.grey.withOpacity(0.5),
                width: double.infinity,
                height: 100,
                child: Row(
                  children: [
                    Image.asset('assets/image/logo_dokter.png',height: 90,width: 90,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        Text('Total Dokter',style: GoogleFonts.nunito(fontSize: 14,color: Colors.black),),
                        Text('${totalUser['Dokter']}',style: GoogleFonts.nunito(fontSize: 34,fontWeight: FontWeight.bold,color: Colors.black),)

                      ],
                    )

                  ],
                ),

              ),
            ),


            /*SizedBox(height: 20,),

            ElevatedButton(
                onPressed: (){
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>IsiDataPasienUntukDokter()));

                },
                child: Text('Tambahkan data pasien untuk dokter'),
            ),

            SizedBox(height: 20,),

            ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));

              },
              child: Text('Register akun'),
            ),*/




          ],

        ),
      ),




      /*drawer: Drawer(
        child: Consumer<Auth>(builder: (context, auth,child){
          if (! auth.authenticated){
            return ListView(
              children: [
                ListTile(
                  title: Text("Login"),
                  leading: Icon(Icons.login),
                  onTap: () async{

                    authBool = await Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginScreen()));
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height/3,),
                Center(child: Text("Harap Login Dulu", style: TextStyle(
                    fontSize: 22,fontWeight: FontWeight.w600
                ),))
              ],
            );
          }
          else if( auth.authenticated && auth.user?.username == null ){
            return const Center(
                child: CircularProgressIndicator()
            );
          }
          else{
            return ListView(
              children: [
                DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Image.asset("assets/image/logoad.png"
                        ,width: 50,height: 50,
                      ),

                      SizedBox(height: 10,),
                      Text(auth.user!.username.toString(),style: TextStyle(color: Colors.white),)
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100))
                  ),
                ),

                ListTile(
                  title: Text("Logout"),
                  leading: Icon(Icons.logout,color: Colors.blue,),
                  onTap: (){
                    Provider.of<Auth>(context, listen: false)
                        .logout();
                    authBool = false;

                  },
                )
              ],
            );
          }

        }),
      ),*/




      drawer: Drawer(
        backgroundColor: Color(0xff189CAB),
        child: ListView(
          children: [
            ListTile(
              title: Text("Dashboard",style: GoogleFonts.nunito(color: Colors.white),),
              leading: Icon(Icons.home,color: Colors.white,),
              onTap: (){
                //print('Dashboard Clicked');
                _key.currentState!.closeDrawer();
              },
            ),

            /*ListTile(
              title: Text("Rekam Medis",style: GoogleFonts.nunito(color: Colors.white),),
              //leading: Icon(Icons.book,color: Colors.white,),
              leading: SvgPicture.asset('assets/image/book_edit.svg'),
              onTap: (){
                print('Rekam Medis Clicked');
                Route route = MaterialPageRoute(builder: (context) => RekamMedis());
                Navigator.pushReplacement(context, route);
              },
            ),

            ListTile(
              title: Text("Data Pasien",style: GoogleFonts.nunito(color: Colors.white),),
              //leading: Icon(Icons.home,color: Colors.white,),
              leading: SvgPicture.asset('assets/image/bookofhealth.svg',width: 22,height: 22,),
              onTap: (){
                print('Data Pasien');
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>DataPasien()));
                Route route = MaterialPageRoute(builder: (context) => DataPasien());
                Navigator.pushReplacement(context, route);
              },
            ),*/


            //////////////Revisi


            /////////Rekam Medis Revisi
            ListTile(
              title: Text("Rekam Medis",style: GoogleFonts.nunito(color: Colors.white),),
              //leading: Icon(Icons.book,color: Colors.white,),
              leading: SvgPicture.asset('assets/image/book_edit.svg'),
              onTap: (){
                print('Rekam Medis Clicked');
                Route route = MaterialPageRoute(builder: (context) => RekamMedisRevisi());
                Navigator.pushReplacement(context, route);
              },
            ),


            ListTile(
              title: Text("Data Pasien",style: GoogleFonts.nunito(color: Colors.white),),
              //leading: Icon(Icons.home,color: Colors.white,),
              leading: SvgPicture.asset('assets/image/bookofhealth.svg',width: 22,height: 22,),
              onTap: (){
                print('Data Pasien');
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>DataPasien()));
                Route route = MaterialPageRoute(builder: (context) => DataPasienRevisi());
                Navigator.pushReplacement(context, route);
              },
            ),

            ListTile(
              title: Text("Antrian Pasien",style: GoogleFonts.nunito(color: Colors.white),),
              //leading: Icon(Icons.home,color: Colors.white,),
              leading: SvgPicture.asset('assets/image/queue.svg',width: 22,height: 22,),
              onTap: (){
                print('Data Pasien');
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>DataPasien()));
                Route route = MaterialPageRoute(builder: (context) => DataAntrian());
                Navigator.pushReplacement(context, route);
              },
            ),
            /////////////////////





          ],
        ),


      ),




    );
  }
}
