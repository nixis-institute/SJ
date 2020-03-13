
import 'package:shared_preferences/shared_preferences.dart';
Future<String> getCartCount() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String _count = preferences.getString("cartCount");
    // print("count_"+_count);
    return _count;
  }


  Future<String> getUserId() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int id = preferences.getInt("Id");
    // print("count_"+_count);
    return id.toString();
  }

  Future<String> getTotal() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString("total");
    // print("count_"+_count);
    return id.toString();
  }


  setPaymentMode(payment) async{
    SharedPreferences preferences = await SharedPreferences.getInstance(); 
    preferences.setString("paymentMode", payment);    
  }
  setTotal(total) async{
    SharedPreferences preferences = await SharedPreferences.getInstance(); 
    preferences.setString("total", total);
  }

  setCount(count) async{
    SharedPreferences preferences = await SharedPreferences.getInstance(); 
    preferences.setString("cartCount", count);
  }

  setAddress(address,phone,id,name) async{
    SharedPreferences preferences = await SharedPreferences.getInstance(); 
    preferences.setString("address", address);
    preferences.setString("phone", phone);
    preferences.setString("addressId", id);
    preferences.setString("personName", name);
  }
  getPaymentMode() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("paymentMode");
  }


  Future<String> get_Address() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString("address");
    return id.toString();    
  }

    Future<String> getPhone() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString("phone");
    return id.toString();    
  }

  Future<String> getAddressId() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString("addressId");
    return id.toString();    
  }


  Future<String> getPersonName() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString("personName");
    return id.toString();
  }