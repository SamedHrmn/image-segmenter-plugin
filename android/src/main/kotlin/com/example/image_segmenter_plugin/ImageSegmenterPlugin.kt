package com.example.image_segmenter_plugin

import android.graphics.Bitmap
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


class ImageSegmenterPlugin : FlutterPlugin, MethodCallHandler {

    private lateinit var channel: MethodChannel
    private lateinit var imageSegmenterHelper: ImageSegmenterHelper
    private var outputImage: Bitmap? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "image_segmenter_plugin")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "init" -> {
                try {
                    imageSegmenterHelper = ImageSegmenterHelper()
                    result.success(null)
                } catch (e: Exception) {
                    result.error(
                        "ImageSegmenterHelper cant initialize successfully!",
                        null,
                        e,
                    )
                }
            }

            "setInputImage" -> {
                val uInt8List = call.arguments as ByteArray
                val bitmap = ImageUtil.convertByteArrayToBitmap(uInt8List)
                if (bitmap == null) {
                    result.error("Bitmap convertion error!", null, null)
                }

                imageSegmenterHelper.setInputBitmap(bitmap!!)
                result.success(null)
            }

            "segmentImage" -> {
                try {
                    imageSegmenterHelper.processImage(
                        onResult = {
                            outputImage = it.outputImage
                            if (outputImage == null) {
                                result.error("Error while segmentation", null, null)
                            }

                            val args = HashMap<String, Any>()
                            args["result"] = ImageUtil.convertBitmapToByteArray(
                                outputImage!!
                            )

                            result.success(args)
                        },
                        onError = {
                            result.error("Error while segmentation", it, null)
                        },
                    )
                } catch (e: Exception) {
                    result.error("Error while segmentation!", null, e)
                }
            }

            "clear" -> {
                try {
                    outputImage = null
                    imageSegmenterHelper.close()
                    result.success(null)
                } catch (e: Exception) {
                    result.error("Error while closing segmenter", e.message, e)
                }

            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }


}
