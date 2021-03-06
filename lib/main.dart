import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:flutter/material.dart';
import 'package:shopping_junction/bloc/cart_block/cart_bloc.dart';
import 'package:shopping_junction/bloc/cart_block/cart_repository.dart';
import 'package:shopping_junction/bloc/login_bloc/login_bloc.dart';
import 'package:shopping_junction/bloc/orders_bloc/orders_bloc.dart';
import 'package:shopping_junction/bloc/orders_bloc/orders_repository.dart';
import 'package:shopping_junction/bloc/products_bloc/products_bloc.dart';
import 'package:shopping_junction/bloc/subproduct_bloc/subproduct_bloc.dart';
import 'package:shopping_junction/bloc/subproduct_bloc/subproduct_repository.dart';
import 'package:shopping_junction/screens/accounts/login.dart';
import 'package:shopping_junction/screens/detail_screen.dart';
import 'package:shopping_junction/screens/home_screen.dart';
import 'package:shopping_junction/screens/orders/order_list.dart';

import 'bloc/login_bloc/login_repository.dart';
import 'bloc/products_bloc/product_repository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  LoginRepostory loginRepostory = LoginRepostory();
  ProductRepository productRepository = ProductRepository();
  CartRepository cartRepository = CartRepository();
  OrdersRepository ordersRepository = OrdersRepository();
  SubProductRepository subProductRepository = SubProductRepository();
  @override
  Widget build(BuildContext context) {
    Color theme = Color(0xffc2d0b1);
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductsBloc>(
          create: (context)=> ProductsBloc(productRepository),
        ),
        BlocProvider<LoginBloc>(
          create: (context)=> LoginBloc(repository: loginRepostory, authenticateBloc: BlocProvider.of<AuthenticateBloc>(context)),
          child: LoginScreen(),
        ),
        BlocProvider<AuthenticateBloc>(
          create: (context)=> AuthenticateBloc(loginRepostory)..add(AppStarted()),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(cartRepository: cartRepository),
        ),
        BlocProvider<OrdersBloc>(
          create: (context)=> OrdersBloc(repository:ordersRepository),
          child: OrderList(),
          // child: LoginScreen(),
        ),

        BlocProvider<SubproductBloc>(
          create: (context)=> SubproductBloc(repository:subProductRepository),
          // child: DetailPage(),
          // child: LoginScreen(),
        ),



        // BlocProvider<ProductsBloc>(
        //   create: (context)=> ProductsBloc(),
        // ),        
      ], 
      child: 
    
    
    MaterialApp(
      title: 'Shopping Junction',
      theme: ThemeData(
        primaryColor: Colors.teal,
        ),
      // darkTheme: ThemeData(
      //     brightness: Brightness.dark,
      //   ),

      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      // home:SplashScreen(),
    home: BlocBuilder<AuthenticateBloc,AuthenticateState>(
      builder: (context,state){
        return HomeScreen();
      //   if(state is Authenticated) 
      //     return HomeScreen();
      //   else
      //     return LoginScreen();
      // },
      // child: HomeScreen()
        }
      ),

       routes: <String,WidgetBuilder>{
        '/home':(BuildContext context) => new HomeScreen(),
        // '/productList':(BuildContext context) => new ProductScreen(),
        // '/image':(BuildContext context) => new ImageScreen(),
        },
    //   routes: <String, WidgetBuilder>{
    //   '/HomeScreen': (BuildContext context) => new HomeScreen()
    // },

    )
    );
  }
}



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }    
  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/HomeScreen');
  }
  @override
  void initState() {
    super.initState();
    startTime();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: Text("This is splash screen"),
        // child: new Image.asset('assets/splash.jpeg'),
      ),
    );
  }  

}





class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
