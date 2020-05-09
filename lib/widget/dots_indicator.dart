import 'dart:math' as math;

import 'package:flutter/material.dart';

///
/// alex
/// An indicator showing the currently selected page of a PageController.
///
class DotsIndicator extends AnimatedWidget {
  const DotsIndicator({
    @required this.controller,
    @required this.itemCount,
    this.onPageSelected,
    this.maxWidth = 24.0,
    this.height = 20.0,
    this.size = 8.0,
    this.spacing = 30.0,
    this.color,
    this.colors,
    this.unselectedColor = Colors.grey,
  })  : assert(
            color == null || colors == null, 'Cannot provide color and colors at the same time.'),
        super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The maximum width of the indicator.
  final double maxWidth;

  /// The height of the indicator.
  final double height;

  /// The color of the dots.
  /// Defaults to `Colors.black`.
  final Color color;

  final List<Color> colors;

  /// The color of the dots which is unselected.
  /// Defaults to `Colors.grey`.
  final Color unselectedColor;

  /// The size of the dots
  final double size;

  /// The distance between the center of each dot
  final double spacing;

  void _onPageSelected(int index) {
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
  }

  Widget _buildDot(int index) {
    final unselected = Curves.easeOut.transform(
      math.max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    final zoom = 1.0 + (maxWidth / size - 1.0) * unselected;
    List<Color> _colors;
    if (colors != null) {
      _colors = List(2);
      _colors[0] = Color.lerp(unselectedColor, colors[0], unselected);
      _colors[1] = Color.lerp(unselectedColor, colors[1], unselected);
    }
    return SizedBox(
      width: spacing,
      child: Center(
        child: Container(
          width: size * zoom,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size),
            color: _colors == null
                ? Color.lerp(
                    unselectedColor,
                    color,
                    unselected,
                  )
                : (color == null ? unselectedColor : color),
            gradient: (_colors != null)
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: _colors,
                  )
                : null,
          ),
          child: GestureDetector(onTap: () => _onPageSelected(index)),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, _buildDot),
    );
  }
}