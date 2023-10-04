import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_flutter/provider/room_data_provider.dart';
import 'package:tictactoe_flutter/screens/game_screen.dart';

import 'screens/create_room.dart';
import 'screens/join_room.dart';
import 'screens/main_menu_screen.dart';
import 'utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter App',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
        ),
        routes: {
          MainMenuScreen.routeName: (context) => const MainMenuScreen(),
          JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
          CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
          GameScreen.routeName: (context) => const GameScreen(),
        },

        // useMaterial3: true,

        home: const MainMenuScreen(),
      ),
    );
  }
}
