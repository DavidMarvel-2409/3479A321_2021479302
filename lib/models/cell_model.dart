class CellModel {
  final int index;
  bool isBomb;
  bool isRevealed;
  bool isFlagged;
  int adjacentBombs;
  CellModel({
    required this.index,
    this.isBomb = false,
    this.isRevealed = false,
    this.isFlagged = false,
    this.adjacentBombs = 0,
  });
}
