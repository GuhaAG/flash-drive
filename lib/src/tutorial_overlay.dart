import 'package:flutter/material.dart';

class TutorialOverlay extends ModalRoute<void> {
  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            children: [
              Text(
                'Tap to show/hide the answer',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
              Icon(
                Icons.arrow_downward,
                size: 60,
              ),
              SizedBox(
                height: 100,
                width: 0,
              ),
              Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    size: 60,
                  ),
                  Text(
                    'Swipe left or right to change cards',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    size: 60,
                  ),
                ],
              ),
            ],
          ),
          RaisedButton(
            onPressed: () => Navigator.pop(context),
            child: Icon(Icons.close),
          )
        ],
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
