import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final HttpLink httpLink = HttpLink(
  uri: 'http://10.0.2.2:8000/graphql/'
);

final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link:httpLink as Link,
        cache: InMemoryCache(),
        // cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject)
  )
);


GraphQLClient clientToQuery() {
  return GraphQLClient(
    cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    link: httpLink as Link,
  );
}