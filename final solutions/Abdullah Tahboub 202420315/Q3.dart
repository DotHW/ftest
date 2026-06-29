import 'package:flutter/material.dart';
void main() {
  runApp(App());
}
class App extends StatefulWidget {
  
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  late Animation<double> animation;
  bool change = false;
  final TextEditingController formatController = TextEditingController();
  final k = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();

    animation = Tween<double>(begin: 0, end: 6.28).animate(controller);
  }

  @override
  void dispose(){
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text(
              "Flutter Animated App",
            ),
             ),

        body: Column(
          children: [
            Center(
                  child: Container(
                  width: 400,
            height: 400,

            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.blue,
            ),
            child: GestureDetector(
              onTap: () => setState(() => change = !change),
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: change ? 500 : 800,
                  height: change ? 500 : 800,
                  padding: EdgeInsets.all(60),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.green,
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: change ? 300 : 600,
                    height: change ? 300 : 600,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          child: Image(
                            image: NetworkImage("http://picsum.photos/200"),
                            height: change ? 200 : 400,
                            width: change ? 200 : 400,
                            fit: BoxFit.contain,
                          ),
                    ),

                  ),
                ),
              ),
            ),
                  ),


                ),
            AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: animation.value,
                  child: child,
                );
              },
              child: TextField(
                controller: formatController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (k.currentState!.validate()) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text("Login ")));
                      }
                    });
                  },
                  child: Text("Start"),
                ),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (k.currentState!.validate()) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text("Login ")));
                      }
                    });
                  },
                  child: Text("Stop"),
                ),
              ],
            ),
          ],
        ),
    ),
    );
  }
}