package com.example.image_segmenter_plugin

import android.graphics.Bitmap
import com.google.mlkit.vision.common.InputImage
import com.google.mlkit.vision.segmentation.subject.SubjectSegmentation
import com.google.mlkit.vision.segmentation.subject.SubjectSegmenter
import com.google.mlkit.vision.segmentation.subject.SubjectSegmenterOptions

class ImageSegmenterHelper {

    private lateinit var _subjectSegmenter: SubjectSegmenter
    private var inputBitmap: Bitmap? = null

    init {
        setupSegmenter()
    }

    private fun setupSegmenter() {
        val options = SubjectSegmenterOptions.Builder().enableForegroundBitmap().build()
        _subjectSegmenter = SubjectSegmentation.getClient(options)
    }

    fun close() {
        inputBitmap = null
        _subjectSegmenter.close()
    }

    fun setInputBitmap(bitmap: Bitmap?) {
        inputBitmap = bitmap
    }

    fun processImage(onResult: (SegmentResult) -> Unit, onError: (String?) -> Unit) {
        setupSegmenter()

        inputBitmap?.let {
            _subjectSegmenter.process(InputImage.fromBitmap(it, 0))
                .addOnSuccessListener { result ->
                    onResult(SegmentResult(result.foregroundBitmap))
                }.addOnFailureListener { e ->
                onError(e.message)
            }
        }
    }

    data class SegmentResult(
        val outputImage: Bitmap?,
    )

}