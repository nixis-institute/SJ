class LoginModel {
  final String userName;
  // final String firstName;
  final String token;
  final String email;
  final int userId;

  LoginModel(this.userName, this.token, this.email, this.userId);

  LoginModel.fromJson(Map<String, dynamic> json)
      : userName = json['name'],
        token = json['token'],
        email = json['email'],
        userId = json['pk'];

  Map<String, dynamic> toJson() =>
      {
        'name': userName,
        'token': token,
        'email': email,
        'pk': userId,
      };
}

class SimpleUserModel{
  String firstName;
  String lastName;
  String id;
  String username;
  int cartLen;
  String profileId;
  String profilePic;
  SimpleUserModel({this.firstName,this.lastName,this.id,this.username,this.cartLen,this.profileId,this.profilePic});
}

class UserModel {
  String username;
  String id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String gender;
  String profileId;
  String profilePic;
  List<Address> address;
  UserModel(this.username,this.id,this.firstName,this.lastName,this.email,this.phone,this.gender,
  this.address,{this.profilePic,this.profileId}
  );
}

class Address {
  String id;
  String houseNo;
  String colony;
  String personName;
  String landmark;
  String city;
  String state;
  String phoneNumber;
  String alternateNumber;
  Address(this.id,this.houseNo,this.colony,this.personName,this.landmark,this.city,this.state,this.phoneNumber,this.alternateNumber);
}