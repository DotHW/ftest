import 'package:flutter/material.dart';

class FadeCardPage extends StatefulWidget {
  const FadeCardPage({super.key});

  @override
  State<FadeCardPage> createState() => _FadeCardPageState();
}

class _FadeCardPageState extends State<FadeCardPage> {
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fade App - AnimatedOpacity")),
      body: Center(
        child: GestureDetector(
          onDoubleTap: () => setState(() => visible = !visible),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedOpacity(
                duration: Duration(milliseconds: 600),
                opacity: visible ? 1.0 : 0.0,
                child: Container(
                  width: 260,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade600,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    "Double Tap to Fade",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),

              SizedBox(height: 18),
              Text(
                visible ? "Visible" : "Hidden",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
