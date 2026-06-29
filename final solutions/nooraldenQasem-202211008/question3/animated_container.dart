import 'package:flutter/material.dart';


class AnimatedBoxPage extends StatefulWidget {
  const AnimatedBoxPage({super.key});

  @override
  State<AnimatedBoxPage> createState() => _AnimatedBoxPageState();
}

class _AnimatedBoxPageState extends State<AnimatedBoxPage> {
  bool big = false;
  int timer = 0;
  final mark = 0;
  double wid1 = 500;
  double wid2 = 300;

  double he1 = 500;
  double he2 = 300;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AnimatedContainer")),
      body: Center(
        child:

        Column(
          children: [
            GestureDetector(
              onTap: () => setState(() => big = !big),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 700),
                curve: Curves.easeInOut,

                width: big ? wid1 : wid2,
                height: big ? he1 : he2,
                decoration: BoxDecoration(
                  color: big ? Colors.deepPurple : Colors.teal,
                  borderRadius: BorderRadius.circular(big ? 30 : 10),
                  border: Border.all(
                    color: big ? Colors.orange : Colors.white,
                    width: big ? 6 : 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: big ? 20 : 6,
                      spreadRadius: 1,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ],
                ),
                child: Center(
                    child: Image(image: NetworkImage("https://picsum.photos/200"), width: 200,height: 200,)
                ),
              ),

            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){

              setState(() {
                he2 = 600;
                wid2 = 600;
                he1 = 800;
                wid1 = 800;
              });
            }, child: Text("Animate")),
            SizedBox(height: 20,),

            TextFormField(

              decoration: InputDecoration(

                labelText: 'Enter time',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Age cannot be empty';
                }
                return null;
              },
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){}, child: Text("${timer}")),
            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  ElevatedButton(onPressed: (){
                    setState(() {
                      final mark = DateTime.timestamp();
                      // DateTime.fromMillisecondsSinceEpoch(timer);
                      print(DateTime.fromMillisecondsSinceEpoch(timer));
                      timer++;
                    });
                  }, child: Text("start")),
                ElevatedButton(onPressed: (){}, child: Text("end"))

              ],
            )
          ],
        )



      ),
    );
  }
}


/*

onTap: () => setState(() => big = !big),
similar to :
onTap: () {
  setState(() {
    if (big == true) {
      big = false;
    } else {
      big = true;
    }
  });
}
*/