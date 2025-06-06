import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'calandar_list_view.dart';
import 'viewmodels/platform_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlatformViewModel(),
      child: MaterialApp(
        title: 'Custom Calendar List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const CalandarListView(),
      ),
    );
  }
}
