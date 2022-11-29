import 'package:elementary_network_image_widget_flutter/widget/network_image_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elementary Network Image Widget'),
      ),
      body: const Center(
        child:
            NetworkImageWidget('https://i.ibb.co/jgkB4ZN1/Elementary-Logo.png'),
      ),
    );
  }
}
