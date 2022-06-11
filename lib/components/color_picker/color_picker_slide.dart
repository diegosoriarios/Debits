import 'package:debits/components/color_picker/slider_indicator.dart';
import 'package:flutter/material.dart';

class ColorPickerSlide extends StatefulWidget {
  final double width;
  final Color color;
  final double sliderPosition;
  final Function setColor;

  const ColorPickerSlide(this.width, this.color, this.setColor, this.sliderPosition, {Key? key}) : super(key: key);
  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPickerSlide> {
  final List<Color> _colors = [
    const Color.fromARGB(255, 255, 0, 0),
    const Color.fromARGB(255, 255, 128, 0),
    const Color.fromARGB(255, 255, 255, 0),
    const Color.fromARGB(255, 128, 255, 0),
    const Color.fromARGB(255, 0, 255, 0),
    const Color.fromARGB(255, 0, 255, 128),
    const Color.fromARGB(255, 0, 255, 255),
    const Color.fromARGB(255, 0, 128, 255),
    const Color.fromARGB(255, 0, 0, 255),
    const Color.fromARGB(255, 127, 0, 255),
    const Color.fromARGB(255, 255, 0, 255),
    const Color.fromARGB(255, 255, 0, 127),
    const Color.fromARGB(255, 128, 128, 128),
  ];

  late Color _currentColor;

  @override
  void initState() {
    super.initState();
    _currentColor = widget.color;
    _currentColor = _calculateSelectedColor(widget.sliderPosition);
  }

  _colorChangeHandler(double position) {
    if (position > widget.width) {
      position = widget.width;
    }
    if (position < 0) {
      position = 0;
    }

    var calculatedColor = _calculateSelectedColor(position);
    widget.setColor(position, calculatedColor);
  }

  Color _calculateSelectedColor(double position) {
    double positionInColorArray =
        (position / widget.width * (_colors.length - 1));
    int index = positionInColorArray.truncate();
    double remainder = positionInColorArray - index;
    if (remainder == 0.0) {
      _currentColor = _colors[index];
    } else {
      int redValue = _colors[index].red == _colors[index + 1].red
          ? _colors[index].red
          : (_colors[index].red +
                  (_colors[index + 1].red - _colors[index].red) * remainder)
              .round();
      int greenValue = _colors[index].green == _colors[index + 1].green
          ? _colors[index].green
          : (_colors[index].green +
                  (_colors[index + 1].green - _colors[index].green) * remainder)
              .round();
      int blueValue = _colors[index].blue == _colors[index + 1].blue
          ? _colors[index].blue
          : (_colors[index].blue +
                  (_colors[index + 1].blue - _colors[index].blue) * remainder)
              .round();
      _currentColor = Color.fromARGB(255, redValue, greenValue, blueValue);
    }
    return _currentColor;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onHorizontalDragStart: (DragStartDetails details) {
              _colorChangeHandler(details.localPosition.dx);
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              _colorChangeHandler(details.localPosition.dx);
            },
            onTapDown: (TapDownDetails details) {
              _colorChangeHandler(details.localPosition.dx);
            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                width: widget.width,
                height: 15,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.grey[800]!),
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(colors: _colors),
                ),
                child: CustomPaint(
                  painter: SliderIndicatorPainter(widget.sliderPosition, _currentColor),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
