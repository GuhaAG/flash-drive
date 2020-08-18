import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

List<Map<String, String>> wordPair = [];

bool pressed = false;

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
                              child: Container(
                                  child: Text(
                                      pressed
                                          ? wordPair[info.index + 1]['key']
                                          : "Press the upload button to load some word pairs.",
                                      style: new TextStyle(
                                        fontSize: 24.0,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.justify))),
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
