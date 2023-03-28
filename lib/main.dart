import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await analytics.logAppOpen();
  runApp(const MyApp());
}

final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    analytics.setCurrentScreen(screenName: 'Home Screen');
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Analytics'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Analytics',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    analytics.logEvent(
                      name: 'test_event',
                      parameters: <String, dynamic>{
                        'test_param': 'value',
                      },
                    );
                    //logCustomEvent();
                    // analytics.logEvent(name: 'Event 1 Activated!');
                  },
                  child: const Text('Event1')),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    analytics.logEvent(name: 'Event 2 Activated!');
                  },
                  child: const Text('Event2'))
            ],
          ),
        ));
  }
}
