

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rekammedishbb/main_screen/register.dart';
import 'package:rekammedishbb/second_screen/user_detail_list.dart';

import '../services/auth.dart';
import '../services/dio.dart';

class UserList extends StatefulWidget {
  UserList({Key? key, required this.tf}) : super(key: key);
  String tf;

  @override
  State<UserList> createState() => _UserListState(this.tf);
}

class _UserListState extends State<UserList> {
  _UserListState(this.tf);
  late String tf;
  final storage = new FlutterSecureStorage();


  final GlobalKey<ScaffoldState> _key = GlobalKey();
  TextEditingController _searchController = TextEditingController();


  late var jsonList;
  List<dynamic> _foundData = [];
  var jabatan;

  void getData() async {
    try {
      String? token = await storage.read(key: 'token');
      Provider.of<Auth>(context, listen: false).getToken(token: token);

      Dio.Response response = await dio().get('/getuser/$tf}',options: Dio.Options(headers: {'Authorization' : 'Bearer $token'}));


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

    if(tf == "0"){
      jabatan = 'Dokter';
    }else if(tf == "1"){
      jabatan = 'Admin';
    }else if(tf == "2"){
      jabatan = "Petugas Admin";
    }
    print(jabatan);


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
              //_key.currentState!.openDrawer();
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back,color: Colors.white,),
          ),
          title:Row(
            children: [
              Icon(Icons.person_add_outlined,color: Colors.white,),
              SizedBox(width: 9,),
              Text('User List',style: GoogleFonts.nunito(color: Colors.white)),
              Spacer(),
              IconButton(
                  onPressed: (){
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>LogOutScreen()));
                  }, icon: Icon(Icons.person,color: Colors.white,))
            ],
          ),
        ),

        floatingActionButton:
        userdata.user!.jabatan != 2 ?
        Container():
        FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        )
        ,

      body:

      Column(
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
                              Text("$jabatan  ${_foundData[index]['poli']}"),
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

                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserDetailList(tf: _foundData[index]),));

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
      )


      /*Container(
        child: Text('$tf'),
      ),*/
    );
  }


}
