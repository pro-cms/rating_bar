# rating_bar_updated

A customizable *Rating Bar* for flutter with half rating support

[![pub package](https://img.shields.io/pub/v/rating_bar_updated.svg?style=popout)](https://pub.dartlang.org/packages/rating_bar_updated)

## Installation

Add this to your package's pubspec.yaml file

```yaml
dependencies:
  ...
  rating_bar_updated: ^latest.version.here
```

## Usage
First import paging.dart

```dart
  import 'package:rating_bar_updated/rating_bar_updated.dart';
```
`onRatingChanged` callback returns current rating which is a double,
when the rating has changed.

```dart
  RatingBar(
    onRatingChanged: (rating) => setState(() => _rating = rating),
    filledIcon: Icons.star,
    emptyIcon: Icons.star_border,
    halfFilledIcon: Icons.star_half,
    isHalfAllowed: true,
    aligns: Alignment.centerLeft,
    filledColor: Colors.green,
    emptyColor: Colors.redAccent,
    halfFilledColor: Colors.amberAccent, 
    size: 48,
  ),
```

You can also use read-only rating bar widget

```dart
  RatingBar.readOnly(
    initialRating: 3.5,
    isHalfAllowed: true,
    aligns: Alignment.centerLeft,
    halfFilledIcon: Icons.star_half,
    filledIcon: Icons.star,
    emptyIcon: Icons.star_border,
  ),
```

## Screenshots

<image src="https://raw.github.com/joshmatta/rating_bar/master/flutter_01.png" width="350px"/>

## License
[MIT License](https://github.com/pro-cms/rating_bar/blob/master/LICENSE)
