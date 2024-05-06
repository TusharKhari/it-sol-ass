import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/screens/image_screen.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: ImageScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            // GridView.count(
            //     shrinkWrap: true,
            //     crossAxisCount: 7,
            //     children: List.generate(
            //       10,
            //       (index) {
            //         return Container(
            //           color: Colors.blue,
            //           margin: const EdgeInsets.all(10),
            //           child: Center(
            //             child: Text(
            //               'Item $index',
            //               style: const TextStyle(
            //                 color: Colors.white,
            //                 fontSize: 20,
            //               ),
            //             ),
            //           ),
            //         );
            //       },
            //     ))
            //
            // AnimationLimiter(
            
            //   child: GridView.count(
            //     shrinkWrap: true,
            //     crossAxisCount: 3,
            //     children: List.generate(
            //       100,
            //       (int index) {
            //         return AnimationConfiguration.staggeredGrid(
            //           position: index,
            //           duration: const Duration(milliseconds: 375),
            //           columnCount: 3,
            //           child: ScaleAnimation(
            //             child: FadeInAnimation(
            //               child: Container(
            //                 margin: EdgeInsets.all(8),
            //                 color: Colors.yellow,
            //                 child: Text("data"),
            //               ),
            //             ),
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
