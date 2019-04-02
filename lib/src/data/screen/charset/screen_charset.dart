import "package:flutter/widgets.dart";

class ScreenCharset {
  ImageStream _imageStream;
  ImageInfo _imageInfo;
  final int charWidth;
  final int charHeight;


  // ================================================================================================================
  // CONSTRUCTOR ----------------------------------------------------------------------------------------------------

  ScreenCharset({
    @required BuildContext context,
    @required AssetImage map,
    @required this.charWidth,
    @required this.charHeight
  }) {
    _imageStream = map.resolve(createLocalImageConfiguration(context));
    _imageStream.addListener(_updateImage);
  }


  // ================================================================================================================
  // ACCESSOR INTERFACE ---------------------------------------------------------------------------------------------

  ImageInfo get imageInfo => _imageInfo;


  // ================================================================================================================
	// PUBLIC INTERFACE -----------------------------------------------------------------------------------------------

  void dispose() {
    _imageStream.removeListener(_updateImage);
  }


  // ================================================================================================================
  // PRIVATE INTERFACE ----------------------------------------------------------------------------------------------

  void _updateImage(ImageInfo imageInfo, bool synchronousCall) {
    _imageInfo = imageInfo;
  }
}
