part of 'login_bloc.dart';

@immutable

abstract class AuthenticateState{}

class AuthenticateInital extends AuthenticateState{
  List<Object> get props => [];
}

class Authenticated extends AuthenticateState{
  SimpleUserModel user;
  Authenticated({this.user});
  List<Object> get props => [];
} 

class NotAuthenticated extends AuthenticateState{
  @override
  List<Object> get props => [];
}



abstract class LoginState {}
class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState{
  LoginSuccess();
  @override
  List<Object> get props => [];
}
class LoginFailure extends LoginState{
  LoginFailure();  
  @override
  List<Object> get props => [];
}
class IsAuthenticated extends LoginState{
  bool isAuthenticated;
  IsAuthenticated(this.isAuthenticated);
  @override
  List<Object> get props => [];
}
