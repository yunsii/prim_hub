
import 'package:flutter/material.dart';
import 'package:flutter_auth0/flutter_auth0.dart';

import 'pkce.dart';
import 'standard.dart';

final String clientId = 'DObrW6FTg0gKm66tE6xK1qWl3ZLubUkc';
final String domain = 'prim-hub.auth0.com';

class Auth0Page extends StatefulWidget {
  Auth0Page({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Auth0PageState createState() => _Auth0PageState();
}

class _Auth0PageState extends State<Auth0Page>
    with SingleTickerProviderStateMixin {
  TabController controller;
  Auth0 auth;
  final GlobalKey<ScaffoldState> skey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, initialIndex: 0, length: 2);
    auth = Auth0(baseUrl: 'https://$domain/', clientId: clientId);
  }

  void showInfo(String text, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(text),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: skey,
      appBar: AppBar(
        elevation: 0.7,
        centerTitle: false,
        leading: Image.network(
          'https://cdn.auth0.com/styleguide/components/1.0.8/media/logos/img/logo-grey.png',
          height: 40,
        ),
        backgroundColor: Color.fromRGBO(0, 0, 0, 1.0),
        title: Text(widget.title),
        bottom: TabBar(
          controller: controller,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(
              text: 'PKCE Flow',
            ),
            Tab(
              text: 'Standard Flow',
            )
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (ctx, constraints) {
          return Container(
            constraints: constraints,
            color: Colors.white,
            child: TabBarView(
              controller: controller,
              children: <Widget>[
                PKCEPage(auth, showInfo),
                StandardPage(auth, showInfo),
              ],
            ),
          );
        },
      ),
    );
  }
}