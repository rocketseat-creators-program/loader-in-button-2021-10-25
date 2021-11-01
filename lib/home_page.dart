import 'package:botao_loading/botao.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Botao(
            onPressed: () async {
              await Future.delayed(const Duration(milliseconds: 3200));
            },
          ),
        ),
      ),
    );
  }
}
