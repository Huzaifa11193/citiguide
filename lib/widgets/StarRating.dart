import 'package:flutter/material.dart';

typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;
  final Color color;

  StarRating({this.starCount = 5, this.rating = .0, required this.onRatingChanged, required this.color});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = new Icon(
        Icons.star_border_rounded,
        color: color ?? Theme.of(context).primaryColor,
        size: 15,
      );
    }
    else if (index > rating - 1 && index < rating) {
      icon = new Icon(
        Icons.star_half_rounded,
        color: color ?? Theme.of(context).primaryColor,
        size: 15,
      );
    } else {
      icon = new Icon(
        Icons.star_rate_rounded,
        color: color ?? Theme.of(context).primaryColor,
        size: 15,
      );
    }
    return new InkResponse(
      onTap: onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
      child: icon,
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      
      children: new List.generate(starCount, (index) => buildStar(context, index))
      );
  }
}