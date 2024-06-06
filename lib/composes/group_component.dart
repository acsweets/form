import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class GroupComponent extends StatefulWidget {
  final List<Widget> children;
  final String label;

  const GroupComponent({super.key, this.children = const [], required this.label});

  @override
  State<GroupComponent> createState() => _GroupComponentState();
}

class _GroupComponentState extends State<GroupComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(left: 16, top: 12, bottom: 12),
              child: Text(
                "${widget.label}",
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              )),
          InputDecorator(
            decoration: InputDecoration(
                label: Text("标题", style: TextStyle(color: Colors.blue)),
                errorText: "Error",

                // errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 1)),
                // errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 1)),

                errorBorder: TopBottomBorder(borderSide: BorderSide(color: Colors.red, width: 1),),
                errorStyle: TextStyle(fontSize: 16)),
            child: Text("111111"),
          ),
          ...widget.children,
        ],
      ),
    );
  }
}
class TopBottomBorder extends InputBorder {
  /// 为[InputDecorator]创建圆角矩形轮廓边框。如果[borderSide]参数为[BolderSide.none]，则不会绘制边框。
  /// 但是，它仍然会定义一个形状（您可以看到[InputDecoration.filled]是否为true）。
  /// 如果应用程序未指定值为[BolderSide.none]的[borderSide]参数，则输入装饰器将基于当前主题和[InputDecorator.isFocused]，
  /// 使用[copyWith]替换自己的参数。[borderRadius]参数默认为四个角的圆形半径均为4.0的值。角半径必须是圆形的，
  /// 即它们的[Radius.x]和[Radius.y]值必须相同。另请参阅：[InputDecoration.floatingLabelBehavior]
  /// ，当[borderSide]为[BolderSide.none]时，
  /// 应将其设置为[FloatingLabel.never]。如果设为[FloatingLabelBehavior.auto]，则标签将延伸到容器之外，就像仍在绘制边界一样。
  const TopBottomBorder({
    super.borderSide = const BorderSide(),
    this.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
    this.gapPadding = 4.0,
  }) : assert(gapPadding >= 0.0);

  // The label text's gap can extend into the corners (even both the top left
  // and the top right corner). To avoid the more complicated problem of finding
  // how far the gap penetrates into an elliptical corner, just require them
  // to be circular.
  //
  // This can't be checked by the constructor because const constructor.
  static bool _cornersAreCircular(BorderRadius borderRadius) {
    return borderRadius.topLeft.x == borderRadius.topLeft.y
        && borderRadius.bottomLeft.x == borderRadius.bottomLeft.y
        && borderRadius.topRight.x == borderRadius.topRight.y
        && borderRadius.bottomRight.x == borderRadius.bottomRight.y;
  }

  /// Horizontal padding on either side of the border's
  /// [InputDecoration.labelText] width gap.
  ///
  /// This value is used by the [paint] method to compute the actual gap width.
  final double gapPadding;

  /// The radii of the border's rounded rectangle corners.
  ///
  /// The corner radii must be circular, i.e. their [Radius.x] and [Radius.y]
  /// values must be the same.
  final BorderRadius borderRadius;

  @override
  bool get isOutline => true;

  @override
  OutlineInputBorder copyWith({
    BorderSide? borderSide,
    BorderRadius? borderRadius,
    double? gapPadding,
  }) {
    return OutlineInputBorder(
      borderSide: borderSide ?? this.borderSide,
      borderRadius: borderRadius ?? this.borderRadius,
      gapPadding: gapPadding ?? this.gapPadding,
    );
  }

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(borderSide.width);
  }

  @override
  OutlineInputBorder scale(double t) {
    return OutlineInputBorder(
      borderSide: borderSide.scale(t),
      borderRadius: borderRadius * t,
      gapPadding: gapPadding * t,
    );
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is OutlineInputBorder) {
      final OutlineInputBorder outline = a;
      return OutlineInputBorder(
        borderRadius: BorderRadius.lerp(outline.borderRadius, borderRadius, t)!,
        borderSide: BorderSide.lerp(outline.borderSide, borderSide, t),
        gapPadding: outline.gapPadding,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is OutlineInputBorder) {
      final OutlineInputBorder outline = b;
      return OutlineInputBorder(
        borderRadius: BorderRadius.lerp(borderRadius, outline.borderRadius, t)!,
        borderSide: BorderSide.lerp(borderSide, outline.borderSide, t),
        gapPadding: outline.gapPadding,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  Path getInnerPath(Rect rect, { TextDirection? textDirection }) {
    return Path()
      ..addRRect(borderRadius.resolve(textDirection).toRRect(rect).deflate(borderSide.width));
  }

  ///getOuterPath 返回一个Path对象，也就是形状的裁剪
  @override
  Path getOuterPath(Rect rect, { TextDirection? textDirection }) {
    var path = Path();
    path.addRRect(RRect.fromRectAndRadius(rect, Radius.circular(10)));
    return path;
  }

  @override
  void paintInterior(Canvas canvas, Rect rect, Paint paint, { TextDirection? textDirection }) {
    canvas.drawRRect(borderRadius.resolve(textDirection).toRRect(rect), paint);
  }

  @override
  bool get preferPaintInterior => true;

  Path _gapBorderPath(Canvas canvas, RRect center, double start, double extent) {
    // When the corner radii on any side add up to be greater than the
    // given height, each radius has to be scaled to not exceed the
    // size of the width/height of the RRect.
    final RRect scaledRRect = center.scaleRadii();

    final Rect tlCorner = Rect.fromLTWH(
      scaledRRect.left,
      scaledRRect.top,
      scaledRRect.tlRadiusX * 2.0,
      scaledRRect.tlRadiusY * 2.0,
    );
    final Rect trCorner = Rect.fromLTWH(
      scaledRRect.right - scaledRRect.trRadiusX * 2.0,
      scaledRRect.top,
      scaledRRect.trRadiusX * 2.0,
      scaledRRect.trRadiusY * 2.0,
    );
    final Rect brCorner = Rect.fromLTWH(
      scaledRRect.right - scaledRRect.brRadiusX * 2.0,
      scaledRRect.bottom - scaledRRect.brRadiusY * 2.0,
      scaledRRect.brRadiusX * 2.0,
      scaledRRect.brRadiusY * 2.0,
    );
    final Rect blCorner = Rect.fromLTWH(
      scaledRRect.left,
      scaledRRect.bottom - scaledRRect.blRadiusY * 2.0,
      scaledRRect.blRadiusX * 2.0,
      scaledRRect.blRadiusY * 2.0,
    );

    // This assumes that the radius is circular (x and y radius are equal).
    // Currently, BorderRadius only supports circular radii.
    const double cornerArcSweep = math.pi / 2.0;
    final Path path = Path();

    // Top left corner
    if (scaledRRect.tlRadius != Radius.zero) {
      final double tlCornerArcSweep = math.acos(clampDouble(1 - start / scaledRRect.tlRadiusX, 0.0, 1.0));
      path.addArc(tlCorner, math.pi, tlCornerArcSweep);
    } else {
      // Because the path is painted with Paint.strokeCap = StrokeCap.butt, horizontal coordinate is moved
      // to the left using borderSide.width / 2.
      path.moveTo(scaledRRect.left - borderSide.width / 2, scaledRRect.top);
    }

    // Draw top border from top left corner to gap start.
    if (start > scaledRRect.tlRadiusX) {
      path.lineTo(scaledRRect.left + start, scaledRRect.top);
    }

    // Draw top border from gap end to top right corner and draw top right corner.
    const double trCornerArcStart = (3 * math.pi) / 2.0;
    const double trCornerArcSweep = cornerArcSweep;
    if (start + extent < scaledRRect.width - scaledRRect.trRadiusX) {
      path.moveTo(scaledRRect.left + start + extent, scaledRRect.top);
      path.lineTo(scaledRRect.right - scaledRRect.trRadiusX, scaledRRect.top);
      if (scaledRRect.trRadius != Radius.zero) {
        path.addArc(trCorner, trCornerArcStart, trCornerArcSweep);
      }
    } else if (start + extent < scaledRRect.width) {
      final double dx = scaledRRect.width - (start + extent);
      final double sweep = math.asin(clampDouble(1 - dx / scaledRRect.trRadiusX, 0.0, 1.0));
      path.addArc(trCorner, trCornerArcStart + sweep, trCornerArcSweep - sweep);
    }

    // Draw right border and bottom right corner.
    if (scaledRRect.brRadius != Radius.zero) {
      path.moveTo(scaledRRect.right, scaledRRect.top + scaledRRect.trRadiusY);
    }
    path.lineTo(scaledRRect.right, scaledRRect.bottom - scaledRRect.brRadiusY);
    if (scaledRRect.brRadius != Radius.zero) {
      path.addArc(brCorner, 0.0, cornerArcSweep);
    }

    // Draw bottom border and bottom left corner.
    path.lineTo(scaledRRect.left + scaledRRect.blRadiusX, scaledRRect.bottom);
    if (scaledRRect.blRadius != Radius.zero) {
      path.addArc(blCorner, math.pi / 2.0, cornerArcSweep);
    }

    // Draw left border
    path.lineTo(scaledRRect.left, scaledRRect.top + scaledRRect.tlRadiusY);

    return path;
  }

  /// 使用[borderRadius]在[rect]周围绘制一个圆角矩形。[borderSide]定义线条的颜色和权重。如果[gapExtent]为非空，圆角矩形的顶面可能会被一个间隙打断。在这种情况下，间隙从“gapStart-gapPadding”开始
  /// （假设[textDirection]为[textDirection.ltr]）。
  /// 间隙的宽度为“（gapPadding+gapExtent+gapPadding）gapPercentage”。
  /// rect 表明可以直接拿到组件的区域，然后....为所欲为吧
  ///  @override
  //   void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
  //     var paint = Paint()
  //       ..color = Colors.white
  //       ..strokeWidth = 2.0
  //       ..style = PaintingStyle.stroke
  //       ..strokeJoin = StrokeJoin.round;
  //     var w = rect.width;
  //     var h = rect.height;
  //     canvas.drawCircle(Offset(0.3*h,0.23*h), 0.12*h, paint);
  //     canvas.drawCircle(Offset(0.3*h,0.23*h), 0.06*h, paint..style=PaintingStyle.fill..color=Colors.black);
  //   }

  @override
  void paint(
      Canvas canvas,
      Rect rect, {
        double? gapStart,
        double gapExtent = 0.0,
        double gapPercentage = 0.0,
        TextDirection? textDirection,
      }) {
    assert(gapPercentage >= 0.0 && gapPercentage <= 1.0);
    assert(_cornersAreCircular(borderRadius));
    if (borderSide.style == BorderStyle.none) {
      return;
    }

    if (borderRadius.bottomLeft != Radius.zero || borderRadius.bottomRight != Radius.zero) {
      // This prevents the border from leaking the color due to anti-aliasing rounding errors.
      final BorderRadius updatedBorderRadius = BorderRadius.only(
        bottomLeft: borderRadius.bottomLeft.clamp(maximum: Radius.circular(rect.height / 2)),
        bottomRight: borderRadius.bottomRight.clamp(maximum: Radius.circular(rect.height / 2)),
      );

      // We set the strokeAlign to center, so the behavior is consistent with
      // drawLine and with the historical behavior of this border.
      BoxBorder.paintNonUniformBorder(canvas, rect,
          textDirection: textDirection,
          borderRadius: updatedBorderRadius,
          bottom: borderSide.copyWith(strokeAlign: BorderSide.strokeAlignCenter),
          color: borderSide.color);
    } else {
      canvas.drawLine(rect.topLeft, rect.topRight, borderSide.toPaint());

      // canvas.drawLine(rect.bottomLeft, rect.bottomRight, borderSide.toPaint());
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is OutlineInputBorder
        && other.borderSide == borderSide
        && other.borderRadius == borderRadius
        && other.gapPadding == gapPadding;
  }

  @override
  int get hashCode => Object.hash(borderSide, borderRadius, gapPadding);
}

