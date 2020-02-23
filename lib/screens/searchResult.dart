import 'package:flutter/material.dart';

class SearchResultScreen extends StatefulWidget{
  @override
  _SearchResultScreenState createState() =>_SearchResultScreenState();
}
class _SearchResultScreenState extends State<SearchResultScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Center(
        child: Text("Search Result"),
      ),
    );
  }
}