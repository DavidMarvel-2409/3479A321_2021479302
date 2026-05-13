import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/cell_model.dart';

class MineCell extends StatelessWidget {
  final CellModel cell;
  final VoidCallback onTap;
  const MineCell({Key? key, required this.cell, required this.onTap})
    : super(key: key);

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
        child: Center(
          child: cell.isRevealed
              ? cell.isBomb
                    ? Image.asset(
                        'assets/icons/mine.png',
                        width: 32,
                        height: 32,
                      )
                    : Text(
                        '${cell.adjacentBombs}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
