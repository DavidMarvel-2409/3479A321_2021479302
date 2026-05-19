import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/cell_model.dart';

class MineCell extends StatelessWidget {
  final CellModel cell;
  final VoidCallback onTap;
  const MineCell({Key? key, required this.cell, required this.onTap})
    : super(key: key);

  Widget _buildCellContent() {
    if (!cell.isRevealed) {
      return const SizedBox.shrink();
    }

    if (cell.isBomb) {
      return Image.asset(
        'assets/icons/mine.png',
        width: 32,
        height: 32,
        fit: BoxFit.contain,
      );
    }

    return Text(
      cell.adjacentMines == 0 ? '' : '${cell.adjacentMines}',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: _numberColor(cell.adjacentMines),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: cell.isRevealed
              ? cell.isBomb
                    ? theme.colorScheme.error
                    : theme.colorScheme.surface
              : theme.colorScheme.secondary,
          border: Border.all(color: theme.colorScheme.outline, width: 1.5),
        ),
        child: Center(child: _buildCellContent()),
      ),
    );
  }

  Color _numberColor(int number) {
    switch (number) {
      case 1:
        return Colors.blue;

      case 2:
        return Colors.green;

      case 3:
        return Colors.red;

      case 4:
        return Colors.purple;

      case 5:
        return Colors.orange;

      default:
        return Colors.black;
    }
  }
}
