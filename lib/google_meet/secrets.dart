import 'dart:io' show Platform;

class Secret {
  static const ANDROID_CLIENT_ID =
      "826308309591-vop7hjm6bj11b60qvr4on3t6am3p0ie8.apps.googleusercontent.com";
  static const IOS_CLIENT_ID =
      "826308309591-hcki61dqtgubt63n23uv5c88i9fol3oo.apps.googleusercontent.com";
  static String getId() =>
      Platform.isAndroid ? Secret.ANDROID_CLIENT_ID : Secret.IOS_CLIENT_ID;
}
