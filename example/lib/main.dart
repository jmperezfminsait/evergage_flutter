import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:evergage_flutter/evergage_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _evergageFlutterPlugin = EvergageFlutter();
  bool evergageInitialization = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _evergageFlutterPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> initializeEvergage() async {
    await _evergageFlutterPlugin.initializeEvergage("", "", "", true);
    setState(() {
      evergageInitialization = true;
    });
  }

  Future<void> setAccountId() async {
    await _evergageFlutterPlugin.setAccountId(" ");
  }

  Future<void> getAccountId() async {
    await _evergageFlutterPlugin.getAccountId();
  }

  Future<void> getAnonymousId() async {
    await _evergageFlutterPlugin.getAnonymousId();
  }

  Future<void> getUserId() async {
    await _evergageFlutterPlugin.getUserId();
  }

  Future<void> setAccountAttribute() async {
    await _evergageFlutterPlugin.setAccountAttribute("", "");
  }

  Future<void> setUserAttribute() async {
    await _evergageFlutterPlugin.setUserAttribute("", "");
  }

  Future<void> setFirebaseToken() async {
    await _evergageFlutterPlugin.setFirebaseToken("");
  }

  Future<void> sendEvent() async {
    await _evergageFlutterPlugin.sendEvent("");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Center(
              child: Text('Running on: $_platformVersion\n'),
            ),
            TextButton(
              onPressed: () {
                initializeEvergage();
              },
              child: const Text("Initialize evergage"),
            ),
            if(evergageInitialization)...[
              TextButton(
                onPressed: () {
                  setAccountId();
                },
                child: const Text("Set account id"),
              ),
              TextButton(
                onPressed: () {
                  getAccountId();
                },
                child: const Text("Get account id"),
              ),
              TextButton(
                onPressed: () {
                  getAnonymousId();
                },
                child: const Text("Get anonymous id"),
              ),
              TextButton(
                onPressed: () {
                  getUserId();
                },
                child: const Text("Get user id"),
              ),
              TextButton(
                onPressed: () {
                  setAccountAttribute();
                },
                child: const Text("Set account attribute"),
              ),
              TextButton(
                onPressed: () {
                  setUserAttribute();
                },
                child: const Text("Set user attribute"),
              ),
              TextButton(
                onPressed: () {
                  setFirebaseToken();
                },
                child: const Text("Set Firebase Token"),
              ),
              TextButton(
                onPressed: () {
                  sendEvent();
                },
                child: const Text("Track Action"),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
