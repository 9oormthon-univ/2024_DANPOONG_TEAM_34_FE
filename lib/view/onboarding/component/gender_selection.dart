import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GenderSelection extends StatelessWidget {
  const GenderSelection({
    super.key,
    required this.selector,
    required this.isSelected,
  });

  final String selector;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        height: 60,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE5F0FF) : Colors.white,
          border: Border.all(
            color:
                isSelected ? const Color(0xFF0066ff) : const Color(0xFFE5E5EC),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                selector,
                style: TextStyle(
                  color: isSelected
                      ? const Color(0xFF2B8FFF)
                      : const Color(0xFF999999),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
