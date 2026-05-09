## Flutter embedding (Dart AOT stays in native blob; shrink Java/Kotlin side only).
-keepattributes *Annotation*,Signature,InnerClasses,EnclosingMethod
-keepattributes SourceFile,LineNumberTable

-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }

-dontwarn org.chromium.**

## Play Feature Delivery — optional Play Core stubs referenced by Flutter embedding (deferred components). Not bundled in APK; suppress R8 missing-class errors.
-dontwarn com.google.android.play.core.**
