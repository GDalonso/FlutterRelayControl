import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
//  Estrutura principal do aplicativo, com tema material app
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Raspberry pi relay control"),
        ),
        body: MyAppBody(),
      ),
    );
  }
}

class MyAppBody extends StatelessWidget {
//  Corpo do aplicativo, parte que tem as labels e botões
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        relayTile("Desk Lamp", "Turn on", "Turn off", "on", "off",
            1, Icon(Icons.lightbulb_outline)),
        relayTile("Relay 2", "Turn on", "Turn off", "on", "off", 2,
            Icon(Icons.add_a_photo)),
      ],
    ));
  }
}

class relayTile extends StatelessWidget {
//  todo: put default values for icon, firstbuttonstate and secondbuttonstate
  final titleText; // text of the tile
  final firstButtonText;
  final secondButtonText;
  final icon; // Icon of the tile
  final relay; // number of the relay expected by the api, int
  final firstButtonState; //string on or off
  final secondButtonState; //string on or off

//  Constructor
  relayTile(this.titleText, this.firstButtonText, this.secondButtonText,
      this.firstButtonState, this.secondButtonState, this.relay, this.icon);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(leading: icon, title: Text(titleText)),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: Text(firstButtonText),
                onPressed: () => apiCall(relay, firstButtonState),
              ),
              FlatButton(
                child: Text(secondButtonText),
                onPressed: () => apiCall(relay, secondButtonState),
              )
            ],
          ),
        ],
      ),
    );
  }
}

void apiCall(num relayNumber, String relayState) {
//  todo: chamar a api
  print(relayNumber.toString() + relayState);
  String comando = relayNumber.toString() + relayState;

  String url = "http://3.133.113.215:5000/";
  http.post(url, body: {'comando': comando});
}