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
      cell.adjacentBombs == 0 ? '' : '${cell.adjacentBombs}',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.blueGrey,
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
          color: theme.colorScheme.secondary,
          border: Border.all(color: theme.colorScheme.outline, width: 1.5),
        ),
        child: Center(child: _buildCellContent()),
      ),
    );
  }
}
