import 'package:flutter/material.dart';
import 'package:image_segmenter_plugin_example/segmenter_view_mixin.dart';
import 'package:image_segmenter_plugin_example/widget/looped_arrow_animation.dart';
import 'package:image_segmenter_plugin_example/widget/my_elevated_button.dart';
import 'package:image_segmenter_plugin_example/widget/success_animation.dart';
import 'package:lottie/lottie.dart';

class SegmenterView extends StatefulWidget {
  const SegmenterView({super.key});

  @override
  State<SegmenterView> createState() => _SegmenterViewState();
}

class _SegmenterViewState extends State<SegmenterView> with SegmenterViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subject Segmenter Plugin'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16) + const EdgeInsets.only(bottom: 48),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  height: 512,
                  width: double.maxFinite,
                  alignment: Alignment.center,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: buildImage(),
                  ),
                ),
              ),
              if (pickedImage != null && resultImage == null) ...{
                Column(
                  children: [
                    const LoopedArrowAnimation(
                      height: 150,
                    ),
                    MyElevatedButton(text: 'Process image.', onPressed: segmentImage),
                  ],
                ),
              } else if (resultImage != null) ...{
                Column(
                  children: [
                    SuccessAnimation(
                      onCompleted: () {
                        updateClearButtonState(true);
                      },
                    ),
                    const SizedBox(height: 32),
                    if (showClearButton) ...{
                      MyElevatedButton(onPressed: clear, text: 'Clear'),
                    },
                  ],
                ),
              }
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage() {
    if (pickedImage == null) {
      return GestureDetector(
        onTap: () async {
          if (await isGrantedGalleryPermission()) {
            await pickImageFromGallery();
            if (pickedImage != null) {
              imageSegmenter.setInputImage(pickedImage!);
            }
          } else {
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Permission is required."),
              ),
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/click_lottie.json',
              height: 200,
            ),
            const Text(
              "Pick an image.",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
            ),
          ],
        ),
      );
    } else if (pickedImage != null && resultImage == null) {
      return Image.memory(key: ValueKey(pickedImage!), pickedImage!);
    } else {
      return Image.memory(key: ValueKey(resultImage!), resultImage!);
    }
  }
}
