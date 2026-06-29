import 'package:flutter/material.dart';

class MoveDotPage extends StatefulWidget {
  const MoveDotPage({super.key});

  @override
  State<MoveDotPage> createState() => _MoveDotPageState();
}

class _MoveDotPageState extends State<MoveDotPage> {
  bool left = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AnimatedAlign")),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Text(
              "Tap the area to move the dot",
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 20),

            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (left == true) {
                      left = false;
                    } else {
                      left = true;
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: AnimatedAlign(
                    duration: Duration(milliseconds: 650),
                    curve: Curves.easeInOut,
                    alignment:
                    left ? Alignment.centerLeft : Alignment.centerRight,
                    child: Container(
                      margin:  EdgeInsets.all(16),
                      width: 60,
                      height: 60,
                      decoration:  BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child:  Icon(
                        Icons.directions_run,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),

            Text(left ? "Position: Left" : "Position: Right "),

            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

// Animates the position of a widget inside its parent by changing its Alignment value.

/*

Flutter uses Alignment(x, y) where:
 x: -1 = far left, 0 = center, +1 = far right
 y: -1 = top, 0 = center, +1 = bottom
 Decimals like 0.4 mean "slightly right of center"

Examples:
Alignment.centerLeft = Alignment(-1, 0)
Alignment.centerRight = Alignment(1, 0).
*/