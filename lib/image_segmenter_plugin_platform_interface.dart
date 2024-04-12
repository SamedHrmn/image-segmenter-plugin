import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'image_segmenter_plugin_method_channel.dart';

abstract class ImageSegmenterPluginPlatform extends PlatformInterface {
  /// Constructs a ImageSegmenterPluginPlatform.
  ImageSegmenterPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static ImageSegmenterPluginPlatform _instance = MethodChannelImageSegmenterPlugin();

  /// The default instance of [ImageSegmenterPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelImageSegmenterPlugin].
  static ImageSegmenterPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ImageSegmenterPluginPlatform] when
  /// they register themselves.
  static set instance(ImageSegmenterPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  void setInputImage(Uint8List bytes);

  Future<Uint8List?> segmentImage();

  Future<void> init();

  void clear();
}
