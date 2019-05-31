import "package:flutter/widgets.dart";

class ScreenCharset {
  ImageStream _imageStream;
  ImageInfo _imageInfo;
  ImageStreamListener _imageStreamListener;
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
    _imageStreamListener = new ImageStreamListener(_updateImage);
    _imageStream = map.resolve(createLocalImageConfiguration(context));
    _imageStream.addListener(_imageStreamListener);
  }


  // ================================================================================================================
  // ACCESSOR INTERFACE ---------------------------------------------------------------------------------------------

  ImageInfo get imageInfo => _imageInfo;


  // ================================================================================================================
	// PUBLIC INTERFACE -----------------------------------------------------------------------------------------------

  void dispose() {
    _imageStream.removeListener(_imageStreamListener);
  }


  // ================================================================================================================
  // PRIVATE INTERFACE ----------------------------------------------------------------------------------------------

  void _updateImage(ImageInfo imageInfo, bool synchronousCall) {
    _imageInfo = imageInfo;
  }
}
