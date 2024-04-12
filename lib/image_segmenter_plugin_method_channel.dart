import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'image_segmenter_plugin_platform_interface.dart';

/// An implementation of [ImageSegmenterPluginPlatform] that uses method channels.
class MethodChannelImageSegmenterPlugin extends ImageSegmenterPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('image_segmenter_plugin');

  /// Prepare input image as bytes before running segmentation.
  @override
  void setInputImage(Uint8List bytes) {
    methodChannel.invokeMethod<void>("setInputImage", bytes);
  }

  /// Run segmentation with this method then get result as ["result"] map key.
  @override
  Future<Uint8List?> segmentImage() {
    return methodChannel.invokeMethod("segmentImage").then((result) => result["result"] as Uint8List?);
  }

  /// Segmenter must be initalize before segmentation. Call this method before [segmentImage].
  @override
  Future<void> init() {
    return methodChannel.invokeMethod<void>("init");
  }

  /// Close segmenter after process done.
  @override
  void clear() {
    methodChannel.invokeMethod<void>("clear");
  }
}
