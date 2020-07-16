import 'dart:math' as math;

import 'package:flutter/material.dart';

class BottomAppBarShape extends NotchedShape {
  const BottomAppBarShape();

  @override
  Path getOuterPath(Rect host, Rect guest) {
    if (guest == null || !host.overlaps(guest)) return Path()..addRect(host);

    final double notchRadius = guest.width / 2.0;
    final double edgeRadius = guest.width / 2.5;

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

    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    final double cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);

    p[3] = Offset(-1.0 * p[2].dx, p[2].dy);
    p[4] = Offset(-1.0 * p[1].dx, p[1].dy);
    p[5] = Offset(-1.0 * p[0].dx, p[0].dy);

    final List<Offset> ep = List<Offset>(6);
    ep[0] = Offset(host.left, host.top + r2);
    ep[1] = Offset(host.left, host.top);
    ep[2] = Offset(host.left + r2, host.top);

    ep[3] = Offset(host.right - r2, host.top);
    ep[4] = Offset(host.right, host.top);
    ep[5] = Offset(host.right, host.top + r2);

    for (int i = 0; i < p.length; i += 1) p[i] += guest.center;

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
