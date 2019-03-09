## References

Good examples:
https://github.com/Solido/awesome-flutter

Some examples (cookbook):
https://flutter.dev/docs/cookbook

Great sample apps:
https://github.com/flutter/samples/blob/master/INDEX.md

Zephyr is a good example of stuff:
https://github.com/memspace/zefyr/blob/master/packages/notus/lib/src/document.dart


Image manipulation (third-party):
https://pub.dartlang.org/packages/image

// Use custom painter:
https://docs.flutter.io/flutter/widgets/CustomPaint-class.html

Draw image on canvas, needs an Image:
https://docs.flutter.io/flutter/dart-ui/Canvas/drawImage.html

Canvas to image with a recorder:
https://stackoverflow.com/questions/50320479/flutter-how-would-one-save-a-canvas-custompainter-to-an-image-file
https://github.com/rxlabz/flutter_canvas_to_image

Other example of custom painter:
https://gist.github.com/stefanJi/2f28eb9e73271b77a33aad8095119894

https://github.com/flutter/flutter/blob/e41f1463cd9a7237df89bdec920745c8f7d22b8d/packages/flutter/lib/src/rendering/custom_paint.dart#L170
# To paint an image on a [Canvas]:

1. Obtain an [ImageStream], for example by calling [ImageProvider.resolve]
   on an [AssetImage] or [NetworkImage] object.

2. Whenever the [ImageStream]'s underlying [ImageInfo] object changes
   (see [ImageStream.addListener]), create a new instance of your custom
   paint delegate, giving it the new [ImageInfo] object.

https://docs.flutter.io/flutter/painting/ImageProvider-class.html

Can use this:
https://docs.flutter.io/flutter/widgets/Image/Image.asset.html

But it creates an image widget.

## Current issues

* VSC extension is not launching properly. Cannot open Dart DevTools, and does not hot reload/restart
