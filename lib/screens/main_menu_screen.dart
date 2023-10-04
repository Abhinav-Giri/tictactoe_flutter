import 'package:flutter/material.dart';

import '../responsive/responsive.dart';
import '../widgets/custom_button.dart';
import 'create_room.dart';
import 'join_room.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});
  static String routeName = '/main-screen';

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Responsive(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            onTap: () => createRoom(context),
            text: 'Create Room',
          ),
          const SizedBox(height: 20),
          CustomButton(
            onTap: () => joinRoom(context),
            text: 'Join Room',
          ),
        ],
      ),
    ));
  }
}
