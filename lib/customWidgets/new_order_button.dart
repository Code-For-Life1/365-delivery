import 'package:flutter/material.dart';


class FancyButton extends StatelessWidget {
  FancyButton({this.token});
  final String token;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.deepOrange,
      splashColor: Colors.orange,
      child: PulsingWidget(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.drive_eta,
              color: Colors.amber,
              //size: 30.0,
            ),
            const SizedBox(width: 9.0),
            Text(
              'New Order',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
      onPressed: () => {
        Navigator.pushNamed(context, '/placeNewOrder', arguments: this.token)
      },
      shape: const StadiumBorder(),
    );
  }
}

class PulsingWidget extends StatefulWidget {
  final Tween<double> tween;
  final Widget child;
  final Duration duration;

  const PulsingWidget({@required this.child, this.duration, this.tween})
      : assert(child != null);
  _PulsingWidget createState() => _PulsingWidget();
}

class _PulsingWidget extends State<PulsingWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Duration _duration;
  Tween<double> _tween;

  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _tween = widget.tween ?? Tween(begin: 0.25, end: 1.0);
    _duration = widget.duration ?? Duration(milliseconds: 500);
    _animationController = AnimationController(
      vsync: this,
      duration: _duration,
    );
    final CurvedAnimation curve = CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    );
    _animation = _tween.animate(curve);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
