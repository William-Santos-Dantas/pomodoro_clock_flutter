import './pages/index/index.dart';
import 'package:flutter/material.dart';

// Pages

class Routes {
  static final routes = <String, WidgetBuilder>{
    '/': (context) => IndexPage(),
  };
}