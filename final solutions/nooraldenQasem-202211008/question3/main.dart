import 'package:flutter/material.dart';

import 'animated_container.dart';
import 'animated_opacity.dart';
import 'animated_align.dart';
import 'animated_builder.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Animations")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) =>  AnimatedBoxPage())),
              child: const Text("AnimatedContainer"),
            ),

            SizedBox(height: 30 ),

            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) =>  FadeCardPage())),
              child: const Text("AnimatedOpacity"),
            ),

            SizedBox(height: 30 ),

            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) =>  MoveDotPage())),
              child: const Text("AnimatedAlign"),
            ),

            SizedBox(height: 30 ),

            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) =>  AnimationPage())),
              child: const Text("AnimatedBuilder"),
            ),
          ],
        ),
      ),
    );
  }
}

// You just change a value inside setState(), and Flutter smoothly transitions to the new state automatically.
// No animation controller needed.

// GestureDetector : wraps any widget and listens for touch events. It is what triggers animations based on user input.

/*
                Implicit (AnimatedContainer, etc.)                  Explicit (AnimatedBuilder) |

 Control:            Flutter handles it                                     You drive it
 Setup needed:       Just change a value                             Controller + Tween + Builder
 Use when:        One-shot triggered animations                   Loops, sequences, complex motion
 Example:            Button grows on tap                                Spinner rotating forever

*/