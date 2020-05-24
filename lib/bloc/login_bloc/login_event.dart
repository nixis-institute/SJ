part of 'login_bloc.dart';


abstract class AuthenticateEvent {}

class AppStarted extends AuthenticateEvent{
  @override
  List<Object> get props => null;
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

class OnLogout extends LoginEvent{
  @override  
  List<Object> get props => null;
}