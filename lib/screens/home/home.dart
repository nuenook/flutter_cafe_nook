import 'package:cafe_nook/models/brew.dart';
import 'package:cafe_nook/screens/home/brew_list.dart';
import 'package:cafe_nook/screens/home/settings_form.dart';
import 'package:cafe_nook/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:cafe_nook/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {

    void _showSettingPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Cafe Nook'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              onPressed: () async {
                await _auth.signOut();
              },
              label: Text('logout'),
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () {
                _showSettingPanel();
              },

            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
              'assets/coffee_bg.png'
              ),
              fit: BoxFit.cover,
            )
          ),
          child: BrewList()),
      ),
    );
  }
}
