import 'package:flutter/material.dart';
import 'package:flutter_crud/components/user_tile.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<Users>(context);

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.USER_FORM);
              },
              icon: Icon(Icons.add))
        ],
        centerTitle: true,
        title: Text('Lista de usuarios'),
        backgroundColor: Colors.black45,
      ),
      body: ListView.builder(
        itemBuilder: ((context, index) => UserTile(users.byIndex(index))),
        itemCount: users.count,
      ),
    );
  }
}
