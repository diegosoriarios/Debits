import 'package:debits/screen/charts_page.dart';
import 'package:debits/screen/debit_form.dart';
import 'package:debits/screen/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomePage(),
        '/form': (context) => const DebitForm(),
        '/chart': (context) => ChartPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
    );
  }
}