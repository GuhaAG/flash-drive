import 'package:flash_drive/src/video_guide_overlay.dart';
import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

String instructions =
    "• Upload a text file with comma separated phrases per line.\n\n" +
        "• We will make flash cards for you using the phrase pairs.\n\n" +
        "• Upload a file by pressing the upload button on the bottom right.\n\n" +
        "• Start by watching a guide by pressing the button right below.\n\n";

List<Map<String, String>> wordPair = [];

bool loaded = false;
bool flashed = false;

class CardPage extends StatefulWidget {
  @override
  CardPageState createState() => CardPageState();
}

class CardPageState extends State<CardPage> {
  void _showOverlay(BuildContext context) {
    Navigator.of(context).push(VideoGuideOverlay());
  }

  @override
  TransformerPageView build(BuildContext context) {
    return new TransformerPageView(
        loop: true,
        viewportFraction: 0.8,
        onPageChanged: (int) {
          setState(() {
            flashed = false;
          });
        },
        transformer: new PageTransformerBuilder(
            builder: (Widget child, TransformInfo info) {
          return new Padding(
            padding: new EdgeInsets.all(10.0),
            child: new Material(
              elevation: 8.0,
              textStyle: new TextStyle(color: Colors.white),
              borderRadius: new BorderRadius.circular(10.0),
              child: new Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  new Positioned(
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new ParallaxContainer(
                          child: Align(
                              alignment: Alignment.center,
                              child: Column(children: <Widget>[
                                Text(
                                    loaded && wordPair.length > 0
                                        ? wordPair[info.index]['key'].trim()
                                        : instructions,
                                    style: new TextStyle(
                                      fontSize: 24.0,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify),
                                wordPair.length == 0
                                    ? SizedBox(
                                        width: 100,
                                        height: 50,
                                        child: FloatingActionButton(
                                          onPressed: () {
                                            _showOverlay(context);
                                          },
                                          tooltip: 'Show Guide',
                                          child: Icon(Icons.ondemand_video),
                                          backgroundColor: Colors.amber,
                                        ))
                                    : SizedBox(height: 0),
                                SizedBox(height: 100),
                                loaded && wordPair.length > 0
                                    ? FloatingActionButton(
                                        onPressed: () {
                                          setState(() {
                                            flashed = !flashed;
                                          });
                                        },
                                        child: Icon(Icons.remove_red_eye),
                                        backgroundColor: Colors.grey,
                                      )
                                    : SizedBox(height: 0),
                                SizedBox(height: 100),
                                Text(
                                    loaded && flashed && wordPair.length > 0
                                        ? wordPair[info.index]['value'].trim()
                                        : "",
                                    style: new TextStyle(
                                      fontSize: 24.0,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify),
                              ])),
                          position: info.position,
                          translationFactor: 300.0,
                        ),
                      ],
                    ),
                    left: 10.0,
                    right: 10.0,
                    top: 100.0,
                  )
                ],
              ),
            ),
          );
        }),
        itemCount: wordPair.length > 0 ? wordPair.length : 1);
  }
}
