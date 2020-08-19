import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

final String instructions =
    "• Press the upload button to load pairs of phrases.\n\n• Upload a txt file with comma separated phrases per line.\n\n• Swipe left or right to switch to the next card.\n\n• Tap the 👁 button to reveal the answer.";

List<Map<String, String>> wordPair = [];

bool loaded = false;
bool flashed = false;

class CardPage extends StatefulWidget {
  @override
  CardPageState createState() => CardPageState();
}

class CardPageState extends State<CardPage> {
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
                                    loaded
                                        ? wordPair[info.index + 1]['key'].trim()
                                        : instructions,
                                    style: new TextStyle(
                                      fontSize: 24.0,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify),
                                SizedBox(height: 100),
                                loaded
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
                                    loaded && flashed
                                        ? wordPair[info.index + 1]['value']
                                            .trim()
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
        itemCount: wordPair.length - 1);
  }
}
