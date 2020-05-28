import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping_junction/bloc/login_bloc/login_repository.dart';
import 'package:shopping_junction/models/userModel.dart';

part 'login_event.dart';
part 'login_state.dart';

class AuthenticateBloc extends Bloc<AuthenticateEvent,AuthenticateState>{
  LoginRepostory repository;
  // AuthenticateBloc authenticateBloc;
  
  AuthenticateBloc(this.repository);
  
  @override
  AuthenticateState get initialState => AuthenticateInital();
  @override
  Stream<AuthenticateState> mapEventToState(
    AuthenticateEvent event,
  ) async*{
    if(event is AppStarted){
      // print("inital");
      final token = await repository.hasToken();
      final info = await repository.getPersistInfo();
      // print(token);
      yield token?Authenticated(
        user: info
      ):NotAuthenticated();
    }
    if(event is LoggedOut){
      await repository.removeToken();
      yield NotAuthenticated();
    }
    if(event is OnAuthenticated){
      final info = await repository.getPersistInfo();
      // print("called Authenticated in block file");
      yield Authenticated(user:info);
    }
    if(event is OnProfilePicUpdate){
      SimpleUserModel user = (state as Authenticated).user;
      user.profilePic = event.url;
      yield Authenticated(user:user);
    }

  }
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepostory repository;
  AuthenticateBloc authenticateBloc;
  LoginBloc({this.repository, this.authenticateBloc});
  // LoginBloc({this.repository});
  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    // TODO: implement mapEventToState


    if(event is OnLogin)
    {
      yield LoginLoading();
      var token = await repository.login(event.username, event.password);    
      if(token!=null){
        await repository.setUserInfo();
        authenticateBloc.add(
          OnAuthenticated()
        );
      }
      // print(token);

      yield token==null?LoginFailure():LoginSuccess();
    
    }
    // if(event is OnProfilePicUpdate){
    //   repository.updatePic(url)
    // }
    if(event is OnLogout){
      // repository.removeToken();
      authenticateBloc.add(
        LoggedOut()
      );
      yield IsAuthenticated(false);
    }



  }
}
