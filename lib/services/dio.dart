

import 'package:dio/dio.dart';

Dio dio(){

Dio dio = new Dio();

//dio.options.baseUrl = "http://10.0.2.2/rekammedishbb/public/api";
dio.options.baseUrl = "https://rekammedishabibjunior.000webhostapp.com/public/api";
dio.options.headers['accept'] = 'Application/Json';

return dio;
}