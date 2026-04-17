import 'package:flutter/material.dart';
import '../../models/game_result.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);
  final List<GameResult> listMaqueta = const [
    GameResult(date: '10 Abr', timeSpent: '01:20', isVictory: true),
    GameResult(date: '09 Abr', timeSpent: '04:45', isVictory: false),
    GameResult(date: '08 Abr', timeSpent: '02:10', isVictory: true),
    GameResult(date: '07 Abr', timeSpent: '03:30', isVictory: false),
    GameResult(date: '06 Abr', timeSpent: '00:50', isVictory: true),
    GameResult(date: '03 Abr', timeSpent: '10:50', isVictory: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historial (Maqueta)')),
      body: ListView.builder(
        itemCount: listMaqueta.length,
        itemBuilder: (context, index) {
          final game = listMaqueta[index];

          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text('Fecha: ${game.date}'),
              subtitle: Text('Tiempo: ${game.timeSpent}'),
              trailing: Icon(
                game.isVictory ? Icons.check_circle : Icons.cancel,
                color: game.isVictory ? Colors.green : Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }
}
