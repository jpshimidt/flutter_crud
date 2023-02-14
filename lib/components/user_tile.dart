import 'package:flutter/material.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../routes/app_routes.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl.isEmpty
        ? const CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));
    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(AppRoutes.USER_FORM, arguments: user);
            },
            color: Colors.orange,
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text("Excluir usuário"),
                        content: Text("Tem certeza?"),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Não'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Provider.of<Users>(context, listen: false)
                                  .remove(user);
                              Navigator.of(context).pop();
                            },
                            child: Text('Sim'),
                          ),
                        ],
                      ));
            },
            color: Colors.red,
            icon: const Icon(Icons.delete),
          ),
        ]),
      ),
    );
  }
}
