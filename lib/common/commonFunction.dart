
import 'package:shared_preferences/shared_preferences.dart';
Future<String> getCartCount() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String _count = preferences.getString("cartCount");
    // print("count_"+_count);
    return _count;
  }


  Future<String> getUserId() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString("Id");
    // print("count_"+_count);
    return id;
  }