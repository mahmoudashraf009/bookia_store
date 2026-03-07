// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/cib_apple.png
  AssetGenImage get cibApple =>
      const AssetGenImage('assets/images/cib_apple.png');

  /// File path: assets/images/first_screen.jpeg
  AssetGenImage get firstScreen =>
      const AssetGenImage('assets/images/first_screen.jpeg');

  /// File path: assets/images/google_ic.png
  AssetGenImage get googleIc =>
      const AssetGenImage('assets/images/google_ic.png');

  /// File path: assets/images/login_screen.jpeg
  AssetGenImage get loginScreen =>
      const AssetGenImage('assets/images/login_screen.jpeg');

  /// File path: assets/images/login_screen_arabic .jpeg
  AssetGenImage get loginScreenArabic =>
      const AssetGenImage('assets/images/login_screen_arabic .jpeg');

  /// File path: assets/images/register_screen.jpeg
  AssetGenImage get registerScreen =>
      const AssetGenImage('assets/images/register_screen.jpeg');

  /// File path: assets/images/register_screen_arabic.jpeg
  AssetGenImage get registerScreenArabic =>
      const AssetGenImage('assets/images/register_screen_arabic.jpeg');

  /// File path: assets/images/splash.png
  AssetGenImage get splash => const AssetGenImage('assets/images/splash.png');

  /// File path: assets/images/splashAndroid12.png
  AssetGenImage get splashAndroid12 =>
      const AssetGenImage('assets/images/splashAndroid12.png');

  /// File path: assets/images/welcome_background.jpg
  AssetGenImage get welcomeBackground =>
      const AssetGenImage('assets/images/welcome_background.jpg');

  /// File path: assets/images/welcome_screen_arabic.jpeg
  AssetGenImage get welcomeScreenArabic =>
      const AssetGenImage('assets/images/welcome_screen_arabic.jpeg');

  /// File path: assets/images/welcome_screen_english.jpeg
  AssetGenImage get welcomeScreenEnglish =>
      const AssetGenImage('assets/images/welcome_screen_english.jpeg');

  /// List of all assets
  List<AssetGenImage> get values => [
    cibApple,
    firstScreen,
    googleIc,
    loginScreen,
    loginScreenArabic,
    registerScreen,
    registerScreenArabic,
    splash,
    splashAndroid12,
    welcomeBackground,
    welcomeScreenArabic,
    welcomeScreenEnglish,
  ];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/ar.json
  String get ar => 'assets/translations/ar.json';

  /// File path: assets/translations/en.json
  String get en => 'assets/translations/en.json';

  /// List of all assets
  List<String> get values => [ar, en];
}

class Assets {
  const Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
