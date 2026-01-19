import 'package:flutter/material.dart';
import 'package:app_7/models/choice.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            accountName: Text("Mariem"),
            accountEmail: Text("mariem@abc.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                "https://randomuser.me/api/portraits/women/49.jpg",
              ),
            ),
          ),
          ...choices.map((Choice choice) {
            return ListTile(
              leading: Icon(choice.icon, color: Colors.blueGrey),
              textColor: Colors.blueGrey,
              title: Text(choice.title),
              onTap: () { 
               Navigator.pushNamed(context, '/${choice.title}'); 
              }, 
            );
          }),
          const AboutListTile(
            icon: Icon(Icons.info, color: Colors.redAccent),
            applicationIcon: Icon(Icons.local_play),
            applicationName: 'ABC Corporation',
            applicationVersion: '1.0.25',
            applicationLegalese: '© 2024 Company',
            child: Text('About app'),
          ),
        ],
      ),
    );
  }
}
