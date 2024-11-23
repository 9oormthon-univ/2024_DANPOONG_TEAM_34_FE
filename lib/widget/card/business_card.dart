import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';

class BusinessCard extends StatefulWidget {
  final String name;
  final String nameEn;
  final String department;
  final String email;
  final String phone;
  final bool initiallyExpanded;

  const BusinessCard({
    super.key,
    required this.name,
    required this.nameEn,
    required this.department,
    required this.email,
    required this.phone,
    this.initiallyExpanded = false,
  });

  @override
  State<BusinessCard> createState() => _BusinessCardState();
}

class _BusinessCardState extends State<BusinessCard> {
  bool isExpanded = false;
  bool showBottomInfo = false;

  @override
  void initState() {
    super.initState();
    // 초기 확장 상태를 위젯 속성으로부터 설정
    isExpanded = widget.initiallyExpanded;
    showBottomInfo = widget.initiallyExpanded;
  }

  void _toggleCard() {
    if (isExpanded) {
      setState(() {
        isExpanded = false;
      });
      Future.delayed(const Duration(milliseconds: 240), () {
        if (mounted) {
          setState(() {
            showBottomInfo = false;
          });
        }
      });
    } else {
      setState(() {
        isExpanded = true;
      });
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          setState(() {
            showBottomInfo = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCard,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: Get.width * 0.9,
        height: isExpanded ? 200 : 87,
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
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  if (isExpanded && showBottomInfo) ...[
                    const Spacer(),
                    _buildContactInfo(),
                  ],
                ],
              ),
            ),
            Positioned(
              right: 20,
              bottom: 20,
              child: _buildLogo(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(widget.name,
                style: FontSystem.MKR14B.copyWith(color: ColorSystem.white)),
            const SizedBox(width: 8),
            Text(widget.nameEn,
                style: FontSystem.MKR12R.copyWith(color: ColorSystem.white))
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              "리부트오피스 일상회복팀 | ",
              style: FontSystem.MKR12R.copyWith(color: ColorSystem.white),
            ),
            Text(
              widget.department,
              style: FontSystem.MKR12R.copyWith(color: ColorSystem.white),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.email,
          style: FontSystem.MKR10R.copyWith(color: ColorSystem.white),
        ),
        const SizedBox(height: 4),
        Text(
          widget.phone,
          style: FontSystem.MKR10R.copyWith(color: ColorSystem.white),
        ),
      ],
    );
  }

  Widget _buildLogo() {
    return SvgPicture.asset(
      'assets/icons/common/app-logo.svg',
      width: 30,
      height: 30,
      colorFilter: const ColorFilter.mode(
        Colors.white,
        BlendMode.srcIn,
      ),
    );
  }
}
