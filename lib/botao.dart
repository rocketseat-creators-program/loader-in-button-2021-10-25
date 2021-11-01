import 'package:flutter/material.dart';

typedef FutureVoidCallback = Future<void> Function();

class Botao extends StatefulWidget {
  final FutureVoidCallback onPressed;

  const Botao({Key? key, required this.onPressed}) : super(key: key);

  @override
  _BotaoState createState() => _BotaoState();
}

class _BotaoState extends State<Botao> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Tween<double> _tween;
  late Animation<double> _animation;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _tween = Tween(begin: 0.0, end: 1.0);

    _animation = _tween.animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    _controller.addStatusListener((status) {
      if (isLoading) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      }
    });

    // _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (!isLoading) {
          setState(() {
            _controller.forward();
            isLoading = true;
          });
          await widget.onPressed();
          setState(() {
            isLoading = false;
            _controller.stop();
            _controller.reset();
          });
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return LinearProgressIndicator(
                  value: _animation.value,
                  minHeight: 60,
                  backgroundColor: const Color(0xFFF6CB02),
                  valueColor: const AlwaysStoppedAnimation(
                    Color(0xFFE7BA00),
                  ),
                );
              },
            ),
            const Text(
              'Botão Animado',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
