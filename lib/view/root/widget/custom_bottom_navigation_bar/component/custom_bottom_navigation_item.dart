import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNavigationItem extends StatelessWidget {
  const CustomBottomNavigationItem({
    super.key,
    required this.isActive,
    required this.assetPath,
  });

  final bool isActive;
  final String assetPath;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 4),
        _buildAnimationView(),
        const SizedBox(height: 2),
        _buildImageView(),
      ],
    );
  }

  Widget _buildAnimationView() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 2),
      height: 4,
      width: isActive ? 20 : 0,
      decoration: const BoxDecoration(
        color: Color(0xFF111111),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  Widget _buildImageView() {
    return SvgPicture.asset(
      assetPath,
      colorFilter: isActive
          ? const ColorFilter.mode(
              Color(0xFF111111),
              BlendMode.srcIn,
            )
          : null,
      height: 28,
    );
  }
}
