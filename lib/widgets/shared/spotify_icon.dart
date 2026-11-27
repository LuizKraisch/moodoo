import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SpotifyIcon extends StatelessWidget {
  const SpotifyIcon({super.key, this.size = 22});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/logos/spotify-icon.svg',
      width: size,
      height: size,
      semanticsLabel: 'Spotify',
    );
  }
}
