import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    animation = Tween<double>(
      begin: 0,
      end: 6.28, // full circle rotation (2π)
    ).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AnimatedBuilder")),
      body: Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Transform.rotate(
              angle: animation.value,
              child: child,
            );
          },
          child: Container(
            width: 120,
            height: 120,
            color: Colors.blue,
            child: Icon(
              Icons.star,
              color: Colors.white,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}


/*
Explicit Animations:
This gives you full control. Instead of Flutter handling everything, you drive the animation yourself.
Required for loops, sequences, and complex motion.

It needs three pieces:

1. AnimationController : the engine

```dart
controller = AnimationController(
  duration: Duration(seconds: 2),
  vsync: this,
)..repeat();
```

Acts like a stopwatch. It counts from 0.0 to 1.0 over the set duration. You can call .forward(), .reverse(), .repeat(), or .stop() on it.

vsync: this requires your class to use SingleTickerProviderStateMixin.
This is mandatory, it prevents the animation from wasting resources when the widget is not visible.


2. Tween + .animate() — the translator

```dart
animation = Tween<double>(begin: 0, end: 6.28).animate(controller);
```

The controller only produces values from 0.0 to 1.0.
The Tween maps that range to whatever values you actually need.
Here, 6.28 is 2π (a full circle in radians), used for rotation.


3. AnimatedBuilder : the rebuilder

```dart
AnimatedBuilder(
  animation: animation,
  builder: (context, child) {
    return Transform.rotate(
      angle: animation.value,
      child: child,
    );
  },
  child: Container(...), // built ONCE, not on every frame
)
```

The child parameter is built once and passed into builder.
Only the Transform.rotate wrapper rebuilds on each frame, not the widget inside. This is the key performance benefit of AnimatedBuilder.


*/


/*
1. dispose() is mandatory: Always call controller.dispose() when using AnimationController. Forgetting it causes memory leaks.

2. Curves — The curve: parameter controls the feel of the animation:
   - Curves.easeInOut : smooth, natural
   - Curves.bounceOut : bouncy
   - Curves.elasticIn : springy

3. Radians vs Degrees — Flutter rotation uses radians, not degrees:
   - 2π ≈ 6.28 = full 360° rotation
   - π ≈ 3.14 = 180°
   - π/2 ≈ 1.57 = 90°
   - Use import 'dart:math' to get math.pi

4. SingleTickerProviderStateMixin : Required mixin when using AnimationController.
If you have two controllers, use TickerProviderStateMixin (without "Single").

5. setState() is not needed with AnimatedBuilder : The whole point is that AnimatedBuilder listens to the animation directly and rebuilds itself.
Calling setState() on every frame would be wasteful and is the old incorrect way.
*/