
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rekammedishbb/services/dio.dart';

import '../models/user.dart';

class Auth extends ChangeNotifier{

  bool _isLoggedIn = false;
  late User? _user;
  late String? _token;
  late int _id;

  bool get authenticated => _isLoggedIn;
  User? get user => _user;
  int get id => _id;

  final storage = new FlutterSecureStorage();

  void register ({required Map creds}) async {
    print(creds);

    try{
      Dio.Response response = await dio().post('/register',data: creds);
      print(response.data['message'].toString());

      String toast = response.data['message'.toString()];
      Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );


    } catch(e){
      print(e);

      String toast = "Register Gagal";
      Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );


    }
    notifyListeners();
  }

  void login ({required Map creds}) async {
    print(creds);

    try{
      Dio.Response response = await dio().post('/login',data: creds);
      print(response.data.toString());

      String token = response.data.toString();
      this.getToken(token: token);

      String toast = 'Login Berhasil';
      Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);



          /*String toast2 = 'token adalah $token';
      Fluttertoast.showToast(
          msg: toast2,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );*/

      _isLoggedIn = true;
    } catch(e){
      String toast = 'Login Gagal';
      Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      print(e);

    }
    notifyListeners();
  }



  void logout() async {

    try{
      Dio.Response response = await dio().get('/logout',
      options: Dio.Options(headers: {'Authorization' : 'Bearer $_token'}));

      cleanUp();
      notifyListeners();
    }catch (e){
      print(e);
    }

  }

  void cleanUp() async {
    this._user = null;
    this._isLoggedIn = false;
    this._token = null;
    //this._id =  null;
    await storage.delete(key: 'token');
  }

  void getToken({String? token}) async {
    if(token == null){
      return;
    }else{
      try{
        Dio.Response response = await dio().get('/me',
            options: Dio.Options(headers: {'Authorization' : 'Bearer $token'}));
        this._isLoggedIn = true;
        this._user = User.fromJson(response.data);
        this._token = token;
        this._id = response.data['id'];
        this.storeToken(token: token);



        notifyListeners();
        print(_user);
        //print(_id);
      }
      catch(e){
        print(e);
      }

    }
  }


  void storeToken({required String token}) async {

    this.storage.write(key: 'token', value: token);
  }

  void getalluser () async {
    print(_token.toString());
    print(_token.toString());
    try{
      Dio.Response response = await dio().get('/getalluser',options: Dio.Options(headers: {'Authorization' : 'Bearer $_token'}));
      print(response.data.toString());


    } catch(e){
      print(e);
    }
    notifyListeners();

  }

  void postDataUser ({required Map creds}) async {
    try{
      Dio.Response response = await dio().post('/post',data: creds,options: Dio.Options(headers: {'Authorization' : 'Bearer $_token'}));
      print(response.data.toString());

      String toast = 'Data Sudah berhasil ditambahkan';
      Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );


    } catch(e){
      String toast = 'Data tidak berhasil ditambahkan';
      Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      print(e);
    }
    notifyListeners();

  }

  void userToAdmin ({required int id}) async {
    try{
      Dio.Response response = await dio().post('/updatelevel/$id',options: Dio.Options(headers: {'Authorization' : 'Bearer $_token'}));
      print(response.data.toString());

      String toast = response.data['data'].toString();
      Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );


    } catch(e){
      String toast = "User tidak dapat diUpdate";
      Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

      print(e);
    }
    notifyListeners();

  }

  void rubahPassword ({required Map creds}) async {
    try{
      Dio.Response response = await dio().post('/updatePassword',data: creds,options: Dio.Options(headers: {'Authorization' : 'Bearer $_token'}));
      print(response.data.toString());

      String toast = response.data['message'].toString();
      Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );


    } catch(e){
      print(e);

      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    notifyListeners();

  }

  void updateStatusUser ({required int id,required Map creds}) async {
    try{
      Dio.Response response = await dio().post('/rubahstatusterdaftar/$id',data: creds,options: Dio.Options(headers: {'Authorization' : 'Bearer $_token'}));
      print(response.data.toString());

      String toast = response.data['data'].toString();
      Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );


    } catch(e){
      print(e);
    }
    notifyListeners();

  }

  void destroyuser ({required int id}) async {
    try{
      Dio.Response response = await dio().post('/destroyuser/$id',options: Dio.Options(headers: {'Authorization' : 'Bearer $_token'}));
      print(response.data.toString());

      String toast = response.data['data'].toString();
      Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );


    } catch(e){

      String toast = 'User gagal dihapus';
      Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

      print(e);
    }
    notifyListeners();

  }

  Future getId({String? token}) async {
    if(token == null){
      return;
    }else{
      try{
        /*Dio.Response response = await dio().get('/me',
            options: Dio.Options(headers: {'Authorization' : 'Bearer $token'}));*/

        Dio.Response response = await dio().get('/getuserordercount/$id',
            options: Dio.Options(headers: {'Authorization' : 'Bearer $token'}));

        var hasilid = response.data['data'];
        print(hasilid);

        return hasilid;


        notifyListeners();
      }
      catch(e){
        print(e);
      }

    }
  }

  Future getId2({String? token}) async {
    if(token == null){
      return;
    }else{
      try{
        /*Dio.Response response = await dio().get('/me',
            options: Dio.Options(headers: {'Authorization' : 'Bearer $token'}));*/

        Dio.Response response = await dio().get('/getuserordercount2/$id',
            options: Dio.Options(headers: {'Authorization' : 'Bearer $token'}));

        var hasilid = response.data['data'];
        print(hasilid);

        return hasilid;


        notifyListeners();
      }
      catch(e){
        print(e);
      }

    }
  }

  void deletePost ({required int id}) async {
    try{
      //Dio.Response response = await dio().post('/destroy/$id',options: Dio.Options(headers: {'Authorization' : 'Bearer $_token'}));
      Dio.Response response = await dio().post('/deletepasien/$id',options: Dio.Options(headers: {'Authorization' : 'Bearer $_token'}));
      print(response.data.toString());

      //String toast = response.data['data'].toString();
      String toast = 'Data Berhasil Dihapus';
      Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );


    } catch(e){

      String toast = 'Data Gagal Dihapus';
      Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );

      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

      print(e);
    }
    notifyListeners();

  }

  void updateDokter ({required Map creds,required int id}) async {
    try{
      Dio.Response response = await dio().post('/update/$id',data: creds,options: Dio.Options(headers: {'Authorization' : 'Bearer $_token'}));
      print(response.data.toString());

      String toast = 'Data Sudah berhasil ditambahkan';
      Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );


    } catch(e){
      String toast = 'Data tidak berhasil ditambahkan';
      Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      print(e);
    }
    notifyListeners();

  }


  void createDataPasien ({required Map creds}) async {
    try{
      //Dio.Response response = await dio().post('/create',data: creds,options: Dio.Options(headers: {'Authorization' : 'Bearer $_token'}));
      Dio.Response response = await dio().post('/tambahpasien',data: creds,options: Dio.Options(headers: {'Authorization' : 'Bearer $_token'}));
      print(response.data.toString());

      String toast = 'Data Sudah berhasil ditambahkan';
      Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );


    } catch(e){
      String toast = 'Data tidak berhasil ditambahkan';
      Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      print(e);
    }
    notifyListeners();

  }

  void createDataRekaman ({required Map creds}) async {
    try{
      //Dio.Response response = await dio().post('/create',data: creds,options: Dio.Options(headers: {'Authorization' : 'Bearer $_token'}));
      Dio.Response response = await dio().post('/buatrekaman',data: creds,options: Dio.Options(headers: {'Authorization' : 'Bearer $_token'}));
      print(response.data.toString());

      String toast = 'Antrian Sudah berhasil ditambahkan';
      Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );


    } catch(e){
      String toast = 'Antrian tidak berhasil ditambahkan';
      Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      print(e);
    }
    notifyListeners();

  }


  void updateRekaman ({required Map creds,required int id}) async {
    try{
      Dio.Response response = await dio().post('/updaterekaman/$id',data: creds,options: Dio.Options(headers: {'Authorization' : 'Bearer $_token'}));
      print(response.data.toString());

      String toast = 'Data Sudah berhasil diperbaharui';
      Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );


    } catch(e){
      String toast = 'Data gagal diperbaharui';
      Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      print(e);
    }
    notifyListeners();

  }



}