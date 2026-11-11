import 'package:flutter/material.dart';

class SocialMediaBottom extends StatelessWidget {
  final String? text;
  final String? img;
  final VoidCallback? onTap;
  final bool? isLoading;

  SocialMediaBottom({
    super.key,
    this.text,
    this.img,
    this.onTap,
    this.isLoading = false,
  }) {
    assert((text != null && img != null) || isLoading == true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white, // خلفية بيضاء
        borderRadius: BorderRadius.circular(30), // حواف دائرية كاملة مثل الصورة
        border: Border.all(
          color: const Color(0xFFECECEC), // درجة الرمادي للإطار
          width: 1.2,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: isLoading == true
                ? Center(child: CircularProgressIndicator.adaptive())
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(img!, width: 24, height: 24),
                      const SizedBox(width: 12),
                      Text(
                        text!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1F2937), // لون النص أسود داكن
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
