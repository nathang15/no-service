import 'package:flutter/material.dart';
import 'package:game_collection/Wordle/utils/quick_box.dart';
import 'package:game_collection/Wordle/utils/theme_preferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_provider.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Settings'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.maybePop(context);
              },
              icon: const Icon(Icons.clear))
        ],
      ),
      body: Column(
        children: [
          Consumer<ThemeProvider>(
            builder: (_, notifier, __) {
              bool _isSwitched = false;
              _isSwitched = notifier.isDark;

              return SwitchListTile(
                title: const Text('Dark Theme'),
                value: _isSwitched,
                onChanged: (value) {
                  _isSwitched = value;
                  ThemePreferences.saveTheme(isDark: _isSwitched);
                  Provider.of<ThemeProvider>(context, listen: false)
                      .setTheme(turnOn: _isSwitched);
                },
              );
            },
          )
        ],
      ),
    );
  }
}