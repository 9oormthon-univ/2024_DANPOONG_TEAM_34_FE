import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';

class BusinessCard extends StatelessWidget {
  final String name;
  final String nameEn;
  final String department;
  final String email;
  final String phone;

  const BusinessCard({
    super.key,
    required this.name,
    required this.nameEn,
    required this.department,
    required this.email,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 200,
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: ColorSystem.blue.shade500,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ColorSystem.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(name,
                    style:
                        FontSystem.MKR14B.copyWith(color: ColorSystem.white)),
                const SizedBox(width: 8),
                Text(nameEn,
                    style: FontSystem.MKR12M.copyWith(
                      color: ColorSystem.white,
                    ))
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  "리부트오피스 일상회복팀 | ",
                  style: FontSystem.MKR10R.copyWith(color: ColorSystem.white),
                ),
                Text(
                  department,
                  style: FontSystem.MKR10R.copyWith(color: ColorSystem.white),
                ),
              ],
            ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      email,
                      style:
                          FontSystem.MKR10R.copyWith(color: ColorSystem.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      phone,
                      style:
                          FontSystem.MKR10R.copyWith(color: ColorSystem.white),
                    ),
                  ],
                ),
                SvgPicture.asset(
                  'assets/icons/common/app-logo.svg',
                  width: 30,
                  height: 30,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
