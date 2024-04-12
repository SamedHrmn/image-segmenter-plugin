import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_segmenter_plugin/image_segmenter_plugin_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelImageSegmenterPlugin platform = MethodChannelImageSegmenterPlugin();
  const MethodChannel channel = MethodChannel('image_segmenter_plugin');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {});
}
