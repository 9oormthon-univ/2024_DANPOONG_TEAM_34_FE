import 'package:flutter/material.dart';

class SelectBox extends StatelessWidget {
  const SelectBox({
    super.key,
    required this.selector,
    required this.isSelected,
    required this.isCenter,
  });

  final String selector;
  final bool isSelected;
  final bool isCenter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFE5F0FF) : Colors.white,
        border: Border.all(
          color: isSelected ? const Color(0xFF0066ff) : const Color(0xFFE5E5EC),
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment:
            isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Text(
            selector,
            style: TextStyle(
              color: isSelected
                  ? const Color(0xFF111111)
                  : const Color(0xFF999999),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
