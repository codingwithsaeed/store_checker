import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

/* Source is where apk/ipa is available to Download */
enum InstallSource {
  PLAY_STORE,
  BAZAAR,
  MYKET,
  LOCAL_SOURCE,
  AMAZON_APP_STORE,
  HUAWEI_APP_GALLERY,
  SAMSUNG_GALAXY_STORE,
  SAMSUNG_SMART_SWITCH_MOBILE,
  OPPO_APP_MARKET,
  XIAOMI_GET_APPS,
  VIVO_APP_STORE,
  OTHER_SOURCE,
  APP_STORE,
  TEST_FLIGHT,
  UNKNOWN
}

/* Store Checker is useful to find the origin of installed apk/ipa */
class StoreChecker {
  static const MethodChannel _channel = const MethodChannel('store_checker');

  /* Get origin of installed apk/ipa */
  static Future<InstallSource> get getSource async {
    final String? sourceName = await _channel.invokeMethod('getSource');
    if (Platform.isAndroid) {
      if (sourceName == null) {
        // Installed apk using adb commands or side loading or downloaded from any cloud service
        return InstallSource.LOCAL_SOURCE;
      } else if (sourceName.compareTo('com.android.vending') == 0) {
        // Installed apk from Google Play Store
        return InstallSource.PLAY_STORE;
      } else if (sourceName.compareTo('com.farsitel.bazaar') == 0) {
        // Installed apk from Bazaar
        return InstallSource.BAZAAR;
      } else if (sourceName.compareTo('ir.mservices.market') == 0) {
        // Installed apk from Bazaar
        return InstallSource.MYKET;
      } else if (sourceName.compareTo('com.amazon.venezia') == 0) {
        // Installed apk from Amazon App Store
        return InstallSource.AMAZON_APP_STORE;
      } else if (sourceName.compareTo('com.huawei.appmarket') == 0) {
        // Installed apk from Huawei App Store
        return InstallSource.HUAWEI_APP_GALLERY;
      } else if (sourceName.compareTo('com.sec.android.app.samsungapps') == 0) {
        // Installed apk from Samsung App Store
        return InstallSource.SAMSUNG_GALAXY_STORE;
      } else if (sourceName.compareTo('com.sec.android.easyMover') == 0) {
        // Installed apk from Samsung Smart Switch Mobile
        return InstallSource.SAMSUNG_SMART_SWITCH_MOBILE;
      } else if (sourceName.compareTo('com.oppo.market') == 0) {
        // Installed apk from Oppo App Store
        return InstallSource.OPPO_APP_MARKET;
      } else if (sourceName.compareTo('com.xiaomi.mipicks') == 0) {
        // Installed apk from Xiaomi App Store
        return InstallSource.XIAOMI_GET_APPS;
      } else if (sourceName.compareTo('com.vivo.appstore') == 0) {
        // Installed apk from Vivo App Store
        return InstallSource.VIVO_APP_STORE;
      } else {
        // Installed apk from Amazon app store or other markets
        return InstallSource.OTHER_SOURCE;
      }
    } else if (Platform.isIOS) {
      if (sourceName == null) {
        // Unknown source when null on iOS
        return InstallSource.UNKNOWN;
      } else if (sourceName.isEmpty) {
        // Downloaded ipa using cloud service and installed
        return InstallSource.LOCAL_SOURCE;
      } else if (sourceName.compareTo('AppStore') == 0) {
        // Installed ipa from App Store
        return InstallSource.APP_STORE;
      } else {
        // Installed ipa from Test Flight
        return InstallSource.TEST_FLIGHT;
      }
    }
    // Installed from Unknown source
    return InstallSource.UNKNOWN;
  }
}
