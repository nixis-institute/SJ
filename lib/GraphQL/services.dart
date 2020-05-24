import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_graphql/src/link/operation.dart';
// import 'package:flutter_graphql/src/link/fetch_result.dart';


// final server_url = 'http://shoppingjunction.pythonanywhere.com';
// final server_url = "http://10.0.2.2:8000";
final server_url = "http://127.0.0.1:8000";

  class AuthLink extends Link {
    AuthLink()
        : super(
      request: (Operation operation, [NextLink forward]) {
        StreamController<FetchResult> controller;

        Future<void> onListen() async {
          try {
            SharedPreferences preferences = await SharedPreferences.getInstance();
            // var token = await AuthUtil.getToken();
            var token = preferences.getString("LastToken");
            // print(token);
            if(token!=null)
            // var token =".";
            operation.setContext(<String, Map<String, String>>{
              'headers': <String, String>{'Authorization': '''JWT $token'''}
            });


          } catch (error) {
            print(error.toString());
            controller.addError(error);
          }

          await controller.addStream(forward(operation));
          await controller.close();
        }

        controller = StreamController<FetchResult>(onListen: onListen);

        return controller.stream;
      },
    );
  }

  var authLink = AuthLink()
      .concat(HttpLink(uri: server_url+"/graphql/"));


final HttpLink httpLink = HttpLink(
  // uri: 'http://10.0.2.2:8000/graphql/'
  uri: server_url+'/graphql/',
  // headers:<String,String>{
  //   'Authorization':'JWT '+
  // }
);

final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link:httpLink as Link,
        // link:authLink,
        cache: InMemoryCache(),
        // cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject)
  )
);


GraphQLClient clientToQuery() {
  return GraphQLClient(
    cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    link: authLink,
    // link:httpLink as Link,
    // link:authLink,
  );
}