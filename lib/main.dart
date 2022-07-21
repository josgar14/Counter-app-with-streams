import 'package:flutter/material.dart';
import 'dart:async'; // Josue: import async.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'counter app with stream',
      //Josue: default counter app with stream instead of setState.
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CounterPage(),
    );
  }
}

late final String title;

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;
  //Josue: our counter variable, here we store how many times the button was pressed.
  final StreamController<int> _streamController = StreamController<int>();
  // Josue: Here we define our StreamController and we specify that we're
  // going to be working with ints with the generic <int>

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
  //Josue: our dispose method, so we can get rid of _streamController and
  // stop it from consuming resources.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream version of the Counter App'),
      ),
      body: Center(
        child: StreamBuilder<int>(
            //Josue: this is our stream builder showing the
            // number of times the button is pressed
            stream: _streamController.stream, //Josue: we pass it a stream.
            initialData: _counter, // a variable with the initial data.
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              return Text('You hit me: ${snapshot.data} times');
              //and finally it's builder
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _streamController.sink.add(++_counter); // Here we update our
          // streamController adding one everytime the button is pressed.
        },
      ),
    );
  }
}
