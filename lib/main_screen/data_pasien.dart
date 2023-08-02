

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rekammedishbb/main_screen/dashboard_screen.dart';
import 'package:rekammedishbb/main_screen/rekam_medis.dart';
import 'package:rekammedishbb/second_screen/isi_data_pasien.dart';
import 'package:rekammedishbb/second_screen/isi_data_pasien_untuk_dokter.dart';

import '../services/auth.dart';
import '../services/dio.dart';
import 'logout_screen.dart';

class DataPasien extends StatefulWidget {
  const DataPasien({Key? key}) : super(key: key);

  @override
  State<DataPasien> createState() => _DataPasienState();
}

class _DataPasienState extends State<DataPasien> {

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final storage = new FlutterSecureStorage();


  TextEditingController _searchController = TextEditingController();


  late var jsonList;
  List<dynamic> _foundData = [];
  var jabatan;

  void getData() async {
    try {
      String? token = await storage.read(key: 'token');
      Provider.of<Auth>(context, listen: false).getToken(token: token);

      Dio.Response response = await dio().get('/getdaftarepasien',options: Dio.Options(headers: {'Authorization' : 'Bearer $token'}));


      if(response.statusCode == 200){
        setState(() {
          jsonList = response.data['data'] as List;
          _foundData = jsonList;
        });
      }else{
        print(response.statusCode);
      }
      print(response);
    } catch (e) {
      print(e);
    }
    //_foundData = _allData;
  }

  /////////////////////////////////////////
  void _runFilter(String enteredKeyword) {
    //List<Map<String, dynamic>> results = [];
    List<dynamic> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = jsonList;
    } else {
      results = _foundData
          .where((user) =>
          user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundData = results;
    });
  }
  ///////////////////////////////////////

  @override
  void initState() {




    getData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final userdata = Provider.of<Auth>(context);
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: Color(0xff189CAB),
        //leading: Icon(Icons.menu,color: Colors.white,),
        leading: IconButton(
          onPressed:  (){
            _key.currentState!.openDrawer();
          },
          icon: Icon(Icons.menu,color: Colors.white,),
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



      body: Column(
        children: [

          SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xff189CAB).withOpacity(0.8),
              ),
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: _searchController,
                onChanged: (value) => _runFilter(value),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search,color: Colors.white,),
                    hintText: 'Ketikan nama',
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none

                ),
              ),
            ),
          ),


          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                //itemCount: jsonList == null ? 0 : jsonList.length,
                  itemCount: _foundData == null ? 0 : _foundData.length,
                  //itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        color: Colors.grey.withOpacity(0.01),
                        child: ListTile(
                          title: Text(_foundData[index]['name']),
                          //title: Text('hai'),
                          //subtitle: Text('Jenis Layanan : Peralihan Hak'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${_foundData[index]['jenis_kelamin']}"),
                              //Text(_foundData[index]['poli'])
                            ],
                          ),
                          trailing: Container(
                            //width: 75,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(_foundData[index]['created_at'].substring(0,10)),
                                //Text(_foundData[index]['status'])
                                Icon(Icons.arrow_right_outlined),
                                Spacer(),

                              ],

                            ),
                          ),
                          onTap: (){

                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>IsiDataPasienUntukDokter(tf: _foundData[index]),));
                            //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailRekamMedis(),));

                            /*Fluttertoast.showToast(
                                    msg: '$index',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );*/
                            //print(_foundData[index].toString());
                          },
                        ));
                  }),
            ),
          ),



        ],
      ),





      floatingActionButton:
      userdata.user!.jabatan != 2 ?
          Container():
      FloatingActionButton(
        onPressed: (){
          print('Tombol tambah telah diklik');
          Navigator.push(context, MaterialPageRoute(builder: (context)=>IsiDataPasien()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),

      drawer: Drawer(
        backgroundColor: Color(0xff189CAB),
        child: ListView(
          children: [
            ListTile(
              title: Text("Dashboard",style: GoogleFonts.nunito(color: Colors.white),),
              leading: Icon(Icons.home,color: Colors.white,),
              onTap: (){
                //print('Dashboard Clicked');
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardScreen()));
                Route route = MaterialPageRoute(builder: (context) => DashboardScreen());
                Navigator.pushReplacement(context, route);
              },
            ),

            ListTile(
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
                _key.currentState!.closeDrawer();

              },
            ),


          ],
        ),


      ),
    );
  }
}
