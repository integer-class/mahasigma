import 'package:flutter/material.dart';
import '../config/theme.dart';
class DescriptionPage extends StatelessWidget {
  const DescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: ImageIcon(AssetImage('assets/Icons/arrow-left.png')),
        ),
        title: Text(
          "Skin Problem", //Judul untuk halaman
          style: semiBoldTS.copyWith(fontSize: 16, color: Colors.black,),
          ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                ' ', // image
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Acne", //judul sesuai database
              style: semiBoldTS.copyWith(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 8),
            Text(
              "Acne is a skin problem that occurs when pores become clogged with oil and dead skin cells.", //desc sesuai database
              style: regularTS.copyWith(fontSize: 14, color: Colors.black87),
            ),
            SizedBox(height: 16),
            Text(
              "How To Treat", //judul sesuai database
              style: semiBoldTS.copyWith(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 8),
            Column(
              children: [
                _buildTreatmentStep("Wash your face regularly with a facial cleanser containing salicylic acid or benzoyl peroxide."),
                _buildTreatmentStep("Use cosmetics and skincare products labeled 'non-comedogenic' or 'oil-free'."),
                _buildTreatmentStep("Use a water-based moisturizer to keep skin hydrated."),
                _buildTreatmentStep("Protect skin from direct sun exposure."),
                _buildTreatmentStep("Avoid touching or squeezing acne."),
              ],
            )
          ],
        ),
        ),
    );
  }

  Widget _buildTreatmentStep(String text){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: regularTS.copyWith(fontSize: 14, color: Colors.black87),
      ),
    );
  }
}

