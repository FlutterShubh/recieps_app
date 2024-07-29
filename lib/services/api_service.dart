import 'package:dio/dio.dart';

class ApiService{
   late final Dio _dio; 
   
   ApiService(){
    _dio =  Dio(
         BaseOptions(
             baseUrl: "https://api.spoonacular.com/"
         )
     );
   }
   //random?apiKey=efbdcadf5fbe46bb8bdf2e6c8b4be181
   
   Future<Response> getRecipes()async{
    try {
      final Response response = await _dio.get("recipes/random?apiKey=4c237c860cc34b62a9c72a2f3209b0d6");
      print(response.data);
      return response;
    } on Exception catch (e) {
     print(e.toString());
     return Future.error(e.toString());
    }
   }
}