import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:store_checker/store_checker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String source = 'None';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    InstallSource installationSource;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      //get origin of installed application
      installationSource = await StoreChecker.getSource;
    } on PlatformException {
      installationSource = InstallSource.UNKNOWN;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // Set source text state
    setState(() {
      switch (installationSource) {
        case InstallSource.PLAY_STORE:
          // Installed from Play Store
          source = "Play Store";
          break;
        case InstallSource.BAZAAR:
          source = "Bazaar";
          break;
        case InstallSource.MYKET:
          source = "Myket";
          break;
        case InstallSource.LOCAL_SOURCE:
          // Installed using adb commands or side loading or any cloud service
          source = "Local Source";
          break;
        case InstallSource.AMAZON_APP_STORE:
          // Installed from Amazon app store
          source = "Amazon Store";
          break;
        case InstallSource.HUAWEI_APP_GALLERY:
          // Installed from Huawei app store
          source = "Huawei App Gallery";
          break;
        case InstallSource.SAMSUNG_GALAXY_STORE:
          // Installed from Samsung app store
          source = "Samsung Galaxy Store";
          break;
        case InstallSource.SAMSUNG_SMART_SWITCH_MOBILE:
          // Installed from Samsung Smart Switch Mobile
          source = "Samsung Smart Switch Mobile";
          break;
        case InstallSource.XIAOMI_GET_APPS:
          // Installed from Xiaomi app store
          source = "Xiaomi Get Apps";
          break;
        case InstallSource.OPPO_APP_MARKET:
          // Installed from Oppo app store
          source = "Oppo App Market";
          break;
        case InstallSource.VIVO_APP_STORE:
          // Installed from Vivo app store
          source = "Vivo App Store";
          break;
        case InstallSource.OTHER_SOURCE:
          // Installed from other market store
          source = "Other Source";
          break;
        case InstallSource.APP_STORE:
          // Installed from iOS app store
          source = "App Store";
          break;
        case InstallSource.TEST_FLIGHT:
          // Installed from Test Flight
          source = "Test Flight";
          break;
        case InstallSource.UNKNOWN:
          // Installed from Unknown source
          source = "Unknown Source";
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Installed from: $source\n'),
        ),
      ),
    );
  }
}
