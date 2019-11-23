

import 'package:cafe_nook/models/user.dart';
import 'package:cafe_nook/screens/authenticate/authenticate.dart';
import 'package:cafe_nook/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);
    
    // return either Home or Authenticate widget
    // return Authenticate();
    return user == null ? Authenticate() : Home();
  }
}