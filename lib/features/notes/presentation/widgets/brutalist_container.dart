import 'package:flutter/material.dart';

class BrutalistContainer extends StatefulWidget {
  final Widget child;
  final Color backgroundColor;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final double borderThickness;
  final double offsetDistance;
  final double? width;
  final double? height;

  const BrutalistContainer({
    super.key,
    required this.child,
    this.backgroundColor = Colors.white,
    this.onTap,
    this.padding,
    this.borderThickness = 2.0,
    this.offsetDistance = 4.0,
    this.width,
    this.height,
  });

  @override
  State<BrutalistContainer> createState() => _BrutalistContainerState();
}

class _BrutalistContainerState extends State<BrutalistContainer> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final double translation = _isPressed ? widget.offsetDistance : 0.0;

    Widget container = Container(
      width: widget.width,
      height: widget.height,
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        border: Border.all(color: Colors.black, width: widget.borderThickness),
        boxShadow: _isPressed
            ? []
            : [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(widget.offsetDistance, widget.offsetDistance),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ),
              ],
      ),
      child: widget.child,
    );

    if (widget.onTap == null) {
      return container;
    }

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: Transform.translate(
        offset: Offset(translation, translation),
        child: container,
      ),
    );
  }
}
