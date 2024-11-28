import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';

class BusinessCardBig extends StatelessWidget {
  final String name;
  final String nameEn;
  final String department;
  final String email;
  final String phone;

  final double radian = 90 * math.pi / 180;

  const BusinessCardBig({
    super.key,
    required this.name,
    required this.nameEn,
    required this.department,
    required this.email,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: radian,
      child: Transform.scale(
        scale: 1.55,
        child: Transform.translate(
          offset: const Offset(
            124,
            0,
          ),
          child: AspectRatio(
            aspectRatio: 2 / 1.4,
            child: Container(
              width: Get.width,
              height: 500,
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
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
                            style: FontSystem.MKR20B
                                .copyWith(color: ColorSystem.white)),
                        const SizedBox(width: 8),
                        Text(nameEn,
                            style: FontSystem.MKR16B.copyWith(
                              color: ColorSystem.white,
                            ))
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          "리부트오피스 일상회복팀 | ",
                          style: FontSystem.MKR12R
                              .copyWith(color: ColorSystem.white),
                        ),
                        Text(
                          department,
                          style: FontSystem.MKR12R
                              .copyWith(color: ColorSystem.white),
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
                              style: FontSystem.MKR12R
                                  .copyWith(color: ColorSystem.white),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              phone,
                              style: FontSystem.MKR12R
                                  .copyWith(color: ColorSystem.white),
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
            ),
          ),
        ),
      ),
    );
  }
}
