library rating_bar_updated;

import 'package:flutter/material.dart';

typedef RatingCallback = void Function(double rating);

class RatingBar extends StatefulWidget {
  RatingBar({
    Key? key,
    this.maxRating = 5,
    required this.onRatingChanged,
    required this.filledIcon,
    required this.emptyIcon,
    this.halfFilledIcon,
    this.isHalfAllowed = false,
    this.aligns = Alignment.centerLeft,
    this.initialRating = 0.0,
    this.filledColor,
    this.emptyColor = Colors.grey,
    this.halfFilledColor,
    this.size = 40,
  })  : _readOnly = false,
        super(key: key);

  RatingBar.readOnly({
    Key? key,
    this.maxRating = 5,
    required this.filledIcon,
    required this.emptyIcon,
    this.halfFilledIcon,
    this.isHalfAllowed = false,
    this.aligns = Alignment.centerLeft,
    this.initialRating = 0.0,
    this.filledColor,
    this.emptyColor = Colors.grey,
    this.halfFilledColor,
    this.size = 40,
  })  : _readOnly = true,
        onRatingChanged = null,
        super(key: key);

  final int maxRating;
  final IconData filledIcon;
  final IconData emptyIcon;
  final IconData? halfFilledIcon;
  final RatingCallback? onRatingChanged;
  final double initialRating;
  final Color? filledColor;
  final Color emptyColor;
  final Color? halfFilledColor;
  final double size;
  final bool isHalfAllowed;
  final Alignment aligns;
  final bool _readOnly;

  @override
  _RatingBarState createState() {
    return _RatingBarState();
  }
}

class _RatingBarState extends State<RatingBar> {
  late double _currentRating;
  late Alignment _aligns;

  @override
  void initState() {
    super.initState();
    _aligns = widget.aligns;
    _currentRating = widget.isHalfAllowed
        ? widget.initialRating
        : widget.initialRating.roundToDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: _aligns,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.maxRating, (index) {
          return Builder(
            builder: (rowContext) => widget._readOnly
                ? buildIcon(context, index + 1)
                : buildStar(rowContext, index + 1),
          );
        }),
      ),
    );
  }

  Widget buildIcon(BuildContext context, int position) {
    IconData? iconData;
    Color color;
    double rating;

    if (widget._readOnly) {
      rating = widget.isHalfAllowed
          ? widget.initialRating
          : widget.initialRating.roundToDouble();
    } else {
      rating = _currentRating;
    }

    if (position > rating + 0.5) {
      iconData = widget.emptyIcon;
      color = widget.emptyColor;
    } else if (position == rating + 0.5 && widget.halfFilledIcon != null) {
      iconData = widget.halfFilledIcon;
      color = widget.halfFilledColor ??
          widget.filledColor ??
          Theme.of(context).primaryColor;
    } else {
      iconData = widget.filledIcon;
      color = widget.filledColor ?? Theme.of(context).primaryColor;
    }
    return Icon(iconData, color: color, size: widget.size);
  }

  Widget buildStar(BuildContext context, int position) {
    return GestureDetector(
      child: buildIcon(context, position),
      onTap: () {
        setState(() => _currentRating = position.toDouble());
        widget.onRatingChanged?.call(_currentRating);
      },
      onHorizontalDragUpdate: (details) {
        RenderBox renderBox = context.findRenderObject() as RenderBox;
        var localPosition = renderBox.globalToLocal(details.globalPosition);
        var rating = localPosition.dx / widget.size;

        if (rating < 0) {
          rating = 0;
        } else if (rating > widget.maxRating) {
          rating = widget.maxRating.toDouble();
        } else {
          rating = widget.isHalfAllowed
              ? (2 * rating).ceilToDouble() / 2
              : rating.ceilToDouble();
        }
        if (_currentRating != rating) {
          setState(() => _currentRating = rating);
          widget.onRatingChanged?.call(_currentRating);
        }
      },
    );
  }
}
