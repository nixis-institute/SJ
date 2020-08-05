import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      SimpleUserModel info = await repository.getPersistInfo();
      // print(token);
      yield token?Authenticated(
        user: info
      ):NotAuthenticated();
      info = await repository.setUserInfo();
      yield token?Authenticated(
        user: info
      ):NotAuthenticated();

    }
    if(event is LoggedOut){
      await repository.signOutGoogle();
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

    if(event is OnGoogleLogin)
    {
      // yield LoginLoading();
      
      


      // credential.providerId
      
        // final AuthResult authResult = await _auth.signInWithCredential(credential);
        
        // final FirebaseUser user = authResult.user;

        // assert(!user.isAnonymous);
        // assert(await user.getIdToken() != null);

        // final FirebaseUser currentUser = await _auth.currentUser();
        // assert(user.uid == currentUser.uid);
        // print('signInWithGoogle succeeded: $user');
        // return user;
      
      
      
      AuthCredential credential =  await repository.signInWithGoogle();
      yield GoogleLoading();
      FirebaseUser user = await repository.firebaseuser(credential);

      if(user!=null)
      {
        // yield GoogleLoading();
        var token = await repository.googleLogin(user.email, user.displayName, user.phoneNumber, user.photoUrl );
        // var token = await repository.login(event.username,data["password"]);
        
        if(token!=null){
          // await repository.setUserInfo();
          await repository.setUserInfoFromGoogle(user.email, user.displayName, user.phoneNumber, user.photoUrl);
          authenticateBloc.add(
            OnAuthenticated()
          );
        }
        yield token==null?LoginFailure():LoginSuccess();
      }
      else{
        yield LoginFailure();
      }


      // var token = await 

    }

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
