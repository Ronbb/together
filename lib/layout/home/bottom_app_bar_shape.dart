import 'dart:math' as math;

import 'package:flutter/material.dart';

/// A rectangle with a smooth circular notch and top border radius.
class BottomAppBarShape extends NotchedShape {
  /// Creates a [BottomAppBarShape].
  ///
  /// The same object can be used to create multiple shapes.
  const BottomAppBarShape();

  /// Creates a [Path] that describes a rectangle with a smooth circular notch
  /// and top border radius.
  ///
  /// `host` is the bounding box for the returned shape. Conceptually this is
  /// the rectangle to which the notch will be applied.
  ///
  /// `guest` is the bounding box of a circle that the notch accommodates. All
  /// points in the circle bounded by `guest` will be outside of the returned
  /// path.
  ///
  /// The notch is curve that smoothly connects the host's top edge and
  /// the guest circle.
  @override
  Path getOuterPath(Rect host, Rect guest) {
    if (guest == null || !host.overlaps(guest)) return Path()..addRect(host);

    // The guest's shape is a circle bounded by the guest rectangle.
    // So the guest's radius is half the guest width.
    final double notchRadius = guest.width / 2.0;

    // The edge radius means the host rectangle's radius.
    // That is smaller than notch's.
    final double edgeRadius = guest.width / 2.5;

    // We build a path for the notch from 3 segments:
    // Segment A - a Bezier curve from the host's top edge to segment B.
    // Segment B - an arc with radius notchRadius.
    // Segment C - a Bezier curve from segment B back to the host's top edge.
    //
    // A detailed explanation and the derivation of the formulas below is
    // available at: https://goo.gl/Ufzrqn
    const double s1 = 15.0;
    const double s2 = 1.0;

    final double r1 = notchRadius;
    final double r2 = edgeRadius;
    final double a = -1.0 * r1 - s2;
    final double b = host.top - guest.center.dy;

    final double n2 = math.sqrt(b * b * r1 * r1 * (a * a + b * b - r1 * r1));
    final double p2xA = ((a * r1 * r1) - n2) / (a * a + b * b);
    final double p2xB = ((a * r1 * r1) + n2) / (a * a + b * b);
    final double p2yA = math.sqrt(r1 * r1 - p2xA * p2xA);
    final double p2yB = math.sqrt(r1 * r1 - p2xB * p2xB);

    final List<Offset> p = List<Offset>(6);

    // p0, p1, and p2 are the control points for segment A.
    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    final double cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);

    // p3, p4, and p5 are the control points for segment B, which is a mirror
    // of segment A around the y axis.
    p[3] = Offset(-1.0 * p[2].dx, p[2].dy);
    p[4] = Offset(-1.0 * p[1].dx, p[1].dy);
    p[5] = Offset(-1.0 * p[0].dx, p[0].dy);

    // translate all points back to the absolute coordinate system.
    for (int i = 0; i < p.length; i += 1) p[i] += guest.center;

    // We build a path for edge radius. There are two parts at top left and top
    // right. Not like before, we use absolute coordinate directly.

    final List<Offset> ep = List<Offset>(6);
    final double eyo = host.height >= edgeRadius ? host.top + r2 : host.bottom;
    ep[0] = Offset(host.left, eyo);
    ep[1] = Offset(host.left, host.top);
    ep[2] = Offset(host.left + r2, host.top);

    ep[3] = Offset(host.right - r2, host.top);
    ep[4] = Offset(host.right, host.top);
    ep[5] = Offset(host.right, eyo);

    return Path()
      ..moveTo(ep[0].dx, ep[0].dy)
      ..quadraticBezierTo(ep[1].dx, ep[1].dy, ep[2].dx, ep[2].dy)
      ..lineTo(p[0].dx, p[0].dy)
      ..quadraticBezierTo(p[1].dx, p[1].dy, p[2].dx, p[2].dy)
      ..arcToPoint(
        p[3],
        radius: Radius.circular(notchRadius),
        clockwise: false,
      )
      ..quadraticBezierTo(p[4].dx, p[4].dy, p[5].dx, p[5].dy)
      ..lineTo(ep[3].dx, ep[3].dy)
      ..quadraticBezierTo(ep[4].dx, ep[4].dy, ep[5].dx, ep[5].dy)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();
  }
}

