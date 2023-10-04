import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_flutter/provider/room_data_provider.dart';
import 'package:tictactoe_flutter/resources/socket_methods.dart';
import 'package:tictactoe_flutter/views/scoreboard.dart';
import 'package:tictactoe_flutter/views/tictactoe_borad.dart';
import 'package:tictactoe_flutter/views/waiting_lobby.dart';
// import 'package:provider/provider.dart';

// import '../provider/room_data_provider.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/game';
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.updatePlayersStateListener(context);
    _socketMethods.updateRoomListener(context);
    _socketMethods.pointIncreaseListener(context);
    _socketMethods.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    // print(Provider.of<RoomDataProvider>(context).player1.socketID);
    // print(Provider.of<RoomDataProvider>(context).player2.socketID);

    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return Scaffold(
      body: roomDataProvider.roomData['isJoin']
          ? const WaitingLobby()
          : SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // Provider.of<RoomDataProvider>(context).roomData.toString(),
                children: [
                  const Scoreboard(),
                  const TicTacToeBoard(),
                  Text(
                      '${roomDataProvider.roomData['turn']['username']}\'s turn'),
                ],
              ),
            ),
    );
  }
}
