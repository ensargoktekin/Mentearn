import 'dart:io' show Platform;

class Secret {
  static const ANDROID_CLIENT_ID =
      "993366918465-6pfbitni3l44h7basfpl1hsjfigp04fs.apps.googleusercontent.com";
  static const IOS_CLIENT_ID =
      "993366918465-pi1ssorv1so0gg34nq0f6kq4c4tlrlnt.apps.googleusercontent.com";
  static String getId() =>
      Platform.isAndroid ? Secret.ANDROID_CLIENT_ID : Secret.IOS_CLIENT_ID;
}
