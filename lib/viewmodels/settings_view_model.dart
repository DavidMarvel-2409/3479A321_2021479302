import 'package:flutter/material.dart';
import '../core/services/storage_service.dart';

class SettingsViewModel extends ChangeNotifier {
  String _username = '';
  String _difficulty = 'Fácil';

  String get username => _username;
  String get difficulty => _difficulty;

  int get gridSize {
    if (_difficulty == 'Fácil') return 8;
    if (_difficulty == 'Medio') return 10;
    return 12;
  }

  SettingsViewModel() {
    _loadSettings();
  }
  void _loadSettings() {
    _username = StorageService.getUsername();
    _difficulty = StorageService.getDifficulty();
  }

  void refreshSettings() {
    _loadSettings();
    notifyListeners();
  }
}
