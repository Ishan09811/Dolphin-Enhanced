# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in /home/sigma/apps/android-sdk/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

-ignorewarnings
-dontskipnonpubliclibraryclasses
-dontskipnonpubliclibraryclassmembers
-verbose

-dontwarn sun.misc.Unsafe
-dontwarn javax.annotation.Nullable
-dontwarn org.conscrypt.OpenSSLProvider
-dontwarn org.conscrypt.Conscrypt
-dontwarn javax.annotation.ParametersAreNonnullByDefault

-keep class org.dolphinemu.dolphinemu.NativeLibrary { *; }
-keep class org.dolphinemu.dolphinemu.utils.Java_GCAdapter { *; }
-keep class org.dolphinemu.dolphinemu.utils.Java_WiimoteAdapter { *; }

-keep class org.dolphinemu.dolphinemu.model.IniFile
-keepclassmembers class org.dolphinemu.dolphinemu.model.IniFile { private <fields>; }
-keepclassmembers class org.dolphinemu.dolphinemu.model.GameFile { private <fields>; }
-keepclassmembers class org.dolphinemu.dolphinemu.model.GameFile { private <init>(...); }

#
# Kotlin Serialization
#

# Keep `Companion` object fields of serializable classes.
# This avoids serializer lookup through `getDeclaredClasses` as done for named companion objects.
-if @kotlinx.serialization.Serializable class **
-keepclassmembers class <1> {
    static <1>$Companion Companion;
}

# Keep `serializer()` on companion objects (both default and named) of serializable classes.
-if @kotlinx.serialization.Serializable class ** {
    static **$* *;
}
-keepclassmembers class <2>$<3> {
    kotlinx.serialization.KSerializer serializer(...);
}

# Keep `INSTANCE.serializer()` of serializable objects.
-if @kotlinx.serialization.Serializable class ** {
    public static ** INSTANCE;
}
-keepclassmembers class <1> {
    public static <1> INSTANCE;
    kotlinx.serialization.KSerializer serializer(...);
}

# @Serializable and @Polymorphic are used at runtime for polymorphic serialization.
-keepattributes RuntimeVisibleAnnotations,AnnotationDefault

# Don't print notes about potential mistakes or omissions in the configuration for kotlinx-serialization classes
# See also https://github.com/Kotlin/kotlinx.serialization/issues/1900
-dontnote kotlinx.serialization.**

# Serialization core uses `java.lang.ClassValue` for caching inside these specified classes.
# If there is no `java.lang.ClassValue` (for example, in Android), then R8/ProGuard will print a warning.
# However, since in this case they will not be used, we can disable these warnings
-dontwarn kotlinx.serialization.internal.ClassValueReferences
