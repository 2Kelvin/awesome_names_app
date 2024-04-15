import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // running the app => MyApp
  runApp(MyApp());
}

// the whole App
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // shares MyAppState to the whole App i.e. all App's widgets
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Awesome Namer App',
        // removing the debug mode banner
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        // App's starting point
        home: MyHomePage(),
      ),
    );
  }
}

// App's state
class MyAppState extends ChangeNotifier {
  // random word-pair stored in current variable
  var current = WordPair.random();

  // get next word class method
  void getNextWordPair() {
    // updating current property with the new word pair
    current = WordPair.random();
    // notifying state change to all widgets watching AppState
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  // build() will be called every time state changes
  // (i.e) a new name-pair is generated
  // and updates the widget
  @override
  Widget build(BuildContext context) {
    // watch track's for changes int the App's state (MyAppState)
    // the state changes when a new word is generated i.e. when current variable changes
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigCard(pair: pair),
            SizedBox(height: 20),
            // adding a generate next name elevated button
            ElevatedButton(
                onPressed: () {
                  appState.getNextWordPair();
                  print('New word-pair generated!');
                },
                child: Text('Generate Name'))
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}
