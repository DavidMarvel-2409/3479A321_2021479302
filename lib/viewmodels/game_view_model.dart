import 'package:flutter/material.dart';
import 'dart:math';
import '../models/cell_model.dart';
import 'dart:async';

class GameViewModel extends ChangeNotifier {
  bool _isGameOver = false;
  bool get isGameOver => _isGameOver;
  late List<CellModel> _cells;
  Timer? _timer;

  int secondsElapsed = 0;

  bool _isFirstTap = true;

  // Dificultad dinámica
  final int gridSize;

  late int totalCells;

  GameViewModel({required this.gridSize}) {
    totalCells = gridSize * gridSize;
    _cells = List.generate(totalCells, (i) => CellModel(index: i));
    _generateMines();
    _calculateAdjacentBombs();
  }

  List<CellModel> get cells => _cells;

  void revealCell(int index) {
    if (_isGameOver || _cells[index].isRevealed) return;
    if (_isFirstTap) {
      _isFirstTap = false;
      _startTimer();
    }

    if (_cells[index].isBomb) {
      _timer?.cancel();
      _cells[index].isRevealed = true;
      _isGameOver = true;
      _revealAll();
      notifyListeners();
      return;
    }

    _floodReveal(index);

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

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      secondsElapsed++;
      notifyListeners();
    });
  }

  List<int> _getNeighbors(int index) {
    List<int> neighbors = [];

    int row = index ~/ gridSize;
    int col = index % gridSize;

    for (int r = row - 1; r <= row + 1; r++) {
      for (int c = col - 1; c <= col + 1; c++) {
        if (r == row && c == col) continue;

        if (r >= 0 && r < gridSize && c >= 0 && c < gridSize) {
          neighbors.add(r * gridSize + c);
        }
      }
    }
    return neighbors;
  }

  void _floodReveal(int index) {
    if (_cells[index].isRevealed) return;

    _cells[index].isRevealed = true;

    if (_cells[index].adjacentBombs > 0) return;

    List<int> neighbors = _getNeighbors(index);

    for (int neighbor in neighbors) {
      if (!_cells[neighbor].isBomb) {
        _floodReveal(neighbor);
      }
    }
  }

  void _revealAll() {
    for (var cell in _cells) {
      cell.isRevealed = true;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
