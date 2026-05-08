import 'package:flutter/material.dart';

import '../models/cell_model.dart';

class GameViewModel extends ChangeNotifier {
  final List<CellModel> _cells = List.generate(64, (i) => CellModel(index: i));

  List<CellModel> get cells => _cells;

  void revealCell(int index) {
    if (_cells[index].isRevealed) return;

    _cells[index].isRevealed = true;

    notifyListeners();
  }
}
