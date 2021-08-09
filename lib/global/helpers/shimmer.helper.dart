import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHelper extends StatelessWidget {
  const ShimmerHelper.retangular({
    Key? key,
    this.width,
    required this.height,
  }) : super(key: key);

  final double? width;
  final double height;

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.grey.shade200,
        highlightColor: Colors.grey.shade50,
        child: Container(
          height: height,
          width: width ?? double.infinity,
          color: Colors.grey.shade200,
        ),
      );
}
