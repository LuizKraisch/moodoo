import 'package:flutter/material.dart';

class CardExpandRoute<T> extends PageRouteBuilder<T> {
  CardExpandRoute({
    required Widget page,
    required Rect sourceRect,
    required Color cardColor,
    BorderRadius cardBorderRadius = const BorderRadius.all(Radius.circular(30)),
  }) : super(
         opaque: false,
         pageBuilder: (_, _, _) => page,
         transitionDuration: const Duration(milliseconds: 350),
         reverseTransitionDuration: const Duration(milliseconds: 300),
         transitionsBuilder: (context, animation, _, child) {
           final screenSize = MediaQuery.of(context).size;
           final fullRect = Rect.fromLTWH(
             0,
             0,
             screenSize.width,
             screenSize.height,
           );

           final rectAnim = RectTween(begin: sourceRect, end: fullRect).animate(
             CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
           );
           final contentOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
             CurvedAnimation(
               parent: animation,
               curve: const Interval(0.25, 0.85, curve: Curves.easeIn),
             ),
           );

           return RepaintBoundary(
             child: AnimatedBuilder(
               animation: animation,
               builder: (_, _) {
                 final rect = rectAnim.value!;
                 return Stack(
                   children: [
                     Positioned(
                       left: rect.left,
                       top: rect.top,
                       width: rect.width,
                       height: rect.height,
                       child: ClipRRect(
                         borderRadius: cardBorderRadius,
                         clipBehavior: Clip.hardEdge,
                         child: ColoredBox(
                           color: cardColor,
                           child: FadeTransition(
                             opacity: contentOpacity,
                             child: child,
                           ),
                         ),
                       ),
                     ),
                   ],
                 );
               },
             ),
           );
         },
       );
}
