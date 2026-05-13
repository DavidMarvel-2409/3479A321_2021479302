import 'package:flutter/material.dart';
import 'dart:math';

import '../models/cell_model.dart';

class GameViewModel extends ChangeNotifier {
  final List<CellModel> _cells = List.generate(64, (i) => CellModel(index: i));

  GameViewModel() {
    _generateMines();
    _calculateAdjacentBombs();
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

  void _calculateAdjacentBombs() {
    for (int i = 0; i < _cells.length; i++) {
      if (_cells[i].isBomb) continue;
      int bombCount = 0;
      List<int> neighbors = _getNeighbors(i);

      for (int neighbor in neighbors) {
        if (_cells[neighbor].isBomb) {
          bombCount++;
        }
      }
      _cells[i].adjacentBombs = bombCount;
    }
  }

  List<int> _getNeighbors(int index) {
    List<int> neighbors = [];

    int row = index ~/ 8;
    int col = index % 8;

    for (int r = row - 1; r <= row + 1; r++) {
      for (int c = col - 1; c <= col + 1; c++) {
        if (r == row && c == col) continue;

        if (r >= 0 && r < 8 && c >= 0 && c < 8) {
          neighbors.add(r * 8 + c);
        }
      }
    }

    return neighbors;
  }
}
