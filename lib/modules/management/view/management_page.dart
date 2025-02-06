import 'package:flutter/material.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import 'package:mobile_lingkunganku/misc/text_style.dart';

class ManagementPage extends StatelessWidget {
  const ManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 50, bottom: 20, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Alamat",
                style: AppTextStyles.textStyle2,
              ),
              const SizedBox(height: 4),
              Text(
                "Jl. Bambu Kuning, Kemang Jakarta Selatan",
                style: AppTextStyles.textRegister2,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.textColor1,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.home, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "34 Warga",
                      style: AppTextStyles.textProfileBold,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "Anggota Terdaftar",
                        style: AppTextStyles.textDialog,
                      ),
                      trailing: const Icon(Icons.expand_more),
                      onTap: () {},
                    ),
                    _buildUserTile("Angela Fransiska", "Warga"),
                    _buildUserTile("Siti Badriah", "Warga"),
                    _buildUserTile("Irwanto Purwanto", "Warga"),
                    _buildUserTile("Supriadi Darma", "Warga"),
                    _buildUserTile("Wicaksono A", "Warga"),
                    _buildUserTile("Muhammad D", "Warga"),
                    _buildUserTile("Angga Nurhaimin", "Warga"),
                    _buildUserTile("Apriyandi Saputra", "Warga"),
                    _buildUserTile("Bimo Laksono", "Warga"),
                    _buildUserTile("Rifky Saputra", "Warga"),
                    _buildUserTile("Sapta A", "Warga"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserTile(String name, String role, [String? imagePath]) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: imagePath != null ? AssetImage(imagePath) : null,
        backgroundColor: Colors.blue.shade100,
        child: imagePath == null
            ? const Icon(Icons.person, color: Colors.blue)
            : null,
      ),
      title: Text(
        name,
        style: AppTextStyles.textDialog,
      ),
      subtitle: Text(role, style: TextStyle(color: Colors.grey.shade600)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}
