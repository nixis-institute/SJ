part of 'login_bloc.dart';


abstract class AuthenticateEvent {}

class AppStarted extends AuthenticateEvent{
  @override
  List<Object> get props => null;
}
class OnProfilePicUpdate extends AuthenticateEvent{
  String url;
  OnProfilePicUpdate({this.url});
}

class OnIsAuthentication extends AuthenticateEvent{
  @override
  List<Object> get props => null;
}
class OnAuthenticated extends AuthenticateEvent{
  @override
  List<Object> get props =>null;
}
class LoggedOut extends AuthenticateEvent{
  @override
  List<Object> get props =>null;  
}



@immutable
abstract class LoginEvent {}
class OnLogin extends LoginEvent{
  String username;
  String password;
  OnLogin({this.username,this.password});
}

class OnGoogleLogin extends LoginEvent{
  String username;
  String displayName;
  String phone;
  String img;
  OnGoogleLogin({this.username,this.displayName,this.phone,this.img});
}

class OnLogout extends LoginEvent{
  @override  
  List<Object> get props => null;
}

