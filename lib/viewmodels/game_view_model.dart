import 'package:flutter/material.dart';
import 'dart:math';

import '../models/cell_model.dart';

class GameViewModel extends ChangeNotifier {
  final List<CellModel> _cells = List.generate(64, (i) => CellModel(index: i));

  GameViewModel() {
    _generateMines();
  }

  List<CellModel> get cells => _cells;

  void revealCell(int index) {
    if (_cells[index].isRevealed) return;

    _cells[index].isRevealed = true;

    notifyListeners();
  }

  void _generateMines() {
    final random = Random();
    int minesPlace = 0;

    while (minesPlace < 10) {
      int index = random.nextInt(_cells.length);
      if (!_cells[index].isBomb) {
        _cells[index].isBomb = true;
        minesPlace++;
      }
    }
  }
}
