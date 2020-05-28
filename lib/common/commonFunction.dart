
import 'package:shared_preferences/shared_preferences.dart';
Future<String> getCartCount() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String _count = preferences.getInt("cartLen").toString();
    // print(_count);
    // print(preferences.getInt("cartLen"));
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
    preferences.setInt("cartLen", count);
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

  getToken() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("LastToken");    
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

dynamic colorsPicker ={
"#FFFFFF":"White",
"#C0C0C0":"Silver",
"#808080":"Gray", 
"#000000":"Black",
"#FF0000":"Red",
"#800000":"Maroon",
"#FFFF00":"Yellow",
"#808000":"Olive",
"#00FF00":"Lime" ,
"#008000":"Green", 
"#00FFFF":"Aqua",
"#008080":"Teal",
"#0000FF":"Blue",
"#000080":"Navy",
"#FF00FF":"Fuchsia",
"#800080":"Purple",
};
