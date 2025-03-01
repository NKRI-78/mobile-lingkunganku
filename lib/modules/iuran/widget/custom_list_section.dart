import 'package:flutter/material.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';

class CustomListSection extends StatelessWidget {
  const CustomListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isExpanded = ValueNotifier(false);
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        leading: Checkbox(
          activeColor: AppColors.secondaryColor,
          checkColor: AppColors.selectColor,
          value: true,
          onChanged: (value) {
            //
          },
        ),
        title: const Text(
          "29 Desember 2023",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text(
          'Tagihan jatuh tempo',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        trailing: ValueListenableBuilder<bool>(
          valueListenable: isExpanded,
          builder: (context, expanded, child) {
            return Icon(expanded ? Icons.expand_less : Icons.expand_more);
          },
        ),
      ),
    );
  }
}
