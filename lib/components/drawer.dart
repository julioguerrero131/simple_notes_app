import 'package:flutter/material.dart';
import 'package:simple_notes_app/components/drawer_tile.dart';
import 'package:simple_notes_app/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // Header
          const DrawerHeader(
            child: Icon(Icons.edit),
          ),

          const SizedBox(height: 25,),

          // Notes Tile
          DrawerTile(
            title: "Notes", 
            leading: Icon(
              Icons.home,
              color: Theme.of(context).colorScheme.inversePrimary,
              ), 
            onTap: () => Navigator.pop(context),
          ),

          // Setting Tile
          DrawerTile(
            title: "Settings", 
            leading: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.inversePrimary,
            ), 
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
            }
          ),
        ],
      ),
    );
  }
}