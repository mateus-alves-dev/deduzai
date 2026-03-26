# ML Kit text recognizer optional scripts may be absent in release builds.
# Prevent R8 from failing when those optional classes are not packaged.
-dontwarn com.google.mlkit.vision.text.chinese.**
-dontwarn com.google.mlkit.vision.text.devanagari.**
-dontwarn com.google.mlkit.vision.text.japanese.**
-dontwarn com.google.mlkit.vision.text.korean.**

# Keep ML Kit text recognizer APIs used via plugin reflection/indirection.
-keep class com.google.mlkit.vision.text.** { *; }
