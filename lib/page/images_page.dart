import 'package:base/widget/image_list.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImagesPage extends StatefulWidget {
  @override
  _ImagesPageState createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage> {
  List<String> images = [];

  @override
  void initState() {
    List.generate(
        10,
        (index) => images.add(
            "https://ss3.bdstatic.com/lPoZeXSm1A5BphGlnYG/skin/48$index.jpg"));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print(images[index] + index.toString());
                    ImageListWidget.showImages(
                      context,
                      images:
                          images.map<ImageBean>((e) => ImageBean(e)).toList(),
                      defaultCurrent: index,
                    );
                  },
                  child: Hero(
                    tag: images[index] + index.toString(),
                    child: ExtendedImage.network(
                      images[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              itemCount: images.length,
            ),
          )
        ],
      ),
    );
  }
}
