import 'package:flutter/material.dart';
import 'package:game_collection/Wordle/constants/colors.dart';
import 'package:game_collection/Wordle/constants/themes.dart';
import 'package:game_collection/Wordle/game.dart';
import 'package:game_collection/Wordle/theme_provider.dart';
import 'package:game_collection/Wordle/utils/theme_preferences.dart';
import 'package:provider/provider.dart';
import 'controller.dart';

void main(){
  runApp(const Wordle());
}

class Wordle extends StatelessWidget {
  const Wordle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Controller()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: FutureBuilder(
        initialData: false,
        future: ThemePreferences.getTheme(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Provider.of<ThemeProvider>(context, listen: false)
                  .setTheme(turnOn: snapshot.data as bool);
            });
          }
          return Consumer<ThemeProvider>(
            builder: (_, notifier, __) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Wordle',
              theme: notifier.isDark ? darkTheme : lightTheme,
              home: const Material(child: Game()),
            ),
          );
        },
      ),
    );
  }
}