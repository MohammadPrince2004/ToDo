import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ViewModel/MainDataProvider.dart';

class SelectedBorderModel extends ChangeNotifier {
  int index = 0;

  void select(int new_val) {

    index=new_val;
    notifyListeners();

  }
}
