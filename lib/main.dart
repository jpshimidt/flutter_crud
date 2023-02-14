import 'package:flutter/material.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:flutter_crud/views/user_form.dart';
import 'package:flutter_crud/views/user_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Users(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lista de Usuários',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: UserList(),
        initialRoute: AppRoutes.HOME,
        routes: {
          AppRoutes.USER_FORM: (context) => UserForm(),
        },
      ),
    );
  }
}
