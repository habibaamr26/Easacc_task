

import 'package:easacc_task/core/constant/widgets/custom_elevated_button.dart';
import 'package:easacc_task/core/utils/app_colors.dart';
import 'package:easacc_task/core/utils/app_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomWebUrl extends StatelessWidget {
  TextEditingController urlController ;
  void Function() onPressed;
   CustomWebUrl({super.key,required this.urlController, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return   Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppText.webUrlInput,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(
            AppText.websiteUrl,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: urlController,
            decoration: InputDecoration(
              hintText: 'https://example.com',
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child:SocialButton(
              text: AppText.save, 
              backgroundColor: AppColors.secondaryColor,
               textColor: AppColors.primaryColor, 
               onPressed: onPressed)
          ),
        ],
      ),
    );

  }
}
