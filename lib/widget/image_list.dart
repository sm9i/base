import 'dart:io';

import 'package:base/widget/route/route.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///
///展示图片资源信息
///https://juejin.im/post/5cf62ab0e51d45776031afb2#heading-0
///
class ImageListWidget extends StatelessWidget {
  const ImageListWidget._(this._images, this._defaultCurrent);

  final List<ImageBean> _images;
  final int _defaultCurrent;

  static Future showImages(BuildContext context,
      {@required List<ImageBean> images, int defaultCurrent = 0}) {
    return Navigator.push(
      context,
      new TransparentRoute(
        builder: (_) => ImageListWidget._(images, defaultCurrent),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //设置颜色为暗色
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      //设置透明
      child: Material(
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: ExtendedImageSlidePage(
            child: childWidget(),
          ),
        ),
      ),
    );
  }

  Widget childWidget() {
    return ExtendedImageGesturePageView.builder(
      itemBuilder: (context, index) {
        Widget widget =
            _images[index].isLocal ? localWidget(index) : netWorkImage(index);
        if (index == _defaultCurrent) {
          print(_images[index].path + index.toString());
          widget = Hero(
            tag: _images[index].path + index.toString(),
            child: widget,
          );
        }
        return widget;
      },
      controller: PageController(
        initialPage: _defaultCurrent,
      ),
      itemCount: _images.length,
    );
  }

  Widget netWorkImage(int index) => ExtendedImage.network(
        _images[index].path,
        fit: BoxFit.contain,
        mode: ExtendedImageMode.gesture,
        enableSlideOutPage: true,
      );

  Widget localWidget(int index) => ExtendedImage.file(
        File(_images[index].path),
        fit: BoxFit.contain,
        mode: ExtendedImageMode.gesture,
        enableSlideOutPage: true,
      );
}

///图片实体类
class ImageBean {
  final String path;
  final bool isLocal;

  ImageBean(this.path, {this.isLocal = false});
}
