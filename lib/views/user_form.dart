import 'package:flutter/material.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class UserForm extends StatefulWidget {
  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    if (user != null) {
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarUrl'] = user.avatarUrl;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    try {
      final user = ModalRoute.of(context)?.settings.arguments as User;
      _loadFormData(user);
    } on Error catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Usuário'),
        backgroundColor: Colors.black45,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                final isValid = _form.currentState!.validate();

                if (isValid) {
                  _form.currentState?.save();
                  Provider.of<Users>(context, listen: false).put(
                    User(
                      id: _formData['id'].toString(),
                      name: _formData['name'].toString(),
                      email: _formData['email'].toString(),
                      avatarUrl: _formData['avatarUrl'].toString(),
                    ),
                  );
                  Navigator.of(context).pop();
                }
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
            key: _form,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: _formData['name'],
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: ((value) {
                    if (value!.trim().isEmpty) {
                      return 'Ocorreu um erro no campo "Nome"';
                    }
                  }),
                  onSaved: (newValue) => _formData['name'] = newValue!,
                ),
                TextFormField(
                  initialValue: _formData['email'],
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: ((value) {
                    if (value!.trim().isEmpty) {
                      return 'Ocorreu um erro no campo "Email"';
                    }
                  }),
                  onSaved: (newValue) => _formData['email'] = newValue!,
                ),
                TextFormField(
                  initialValue: _formData['avatarUrl'],
                  decoration: const InputDecoration(labelText: 'Avatar (url)'),
                  validator: ((value) {}),
                  onSaved: (newValue) => _formData['avatarUrl'] = newValue!,
                )
              ],
            )),
      ),
    );
  }
}
