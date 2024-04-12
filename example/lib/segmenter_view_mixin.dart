import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_segmenter_plugin/image_segmenter_plugin.dart';
import 'package:image_segmenter_plugin_example/segmenter_view.dart';
import 'package:permission_handler/permission_handler.dart';

mixin SegmenterViewMixin on State<SegmenterView> {
  Uint8List? pickedImage;
  Uint8List? resultImage;
  final imageSegmenter = ImageSegmenterPlugin();
  bool showClearButton = false;

  @override
  void initState() {
    super.initState();
    imageSegmenter.init();
  }

  @override
  void dispose() {
    imageSegmenter.clear();
    super.dispose();
  }

  Future<void> pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    pickedImage = await image.readAsBytes();
    setState(() {});
  }

  Future<bool> isGrantedGalleryPermission() async {
    final status = await Permission.photos.request();
    return status.isGranted;
  }

  Future<void> segmentImage() async {
    resultImage = await imageSegmenter.segmentImage();
    setState(() {});
  }

  void clear() {
    setState(() {
      pickedImage = null;
      resultImage = null;
      showClearButton = false;
    });

    imageSegmenter.clear();
  }

  void updateClearButtonState(bool s) {
    setState(() {
      showClearButton = s;
    });
  }
}
