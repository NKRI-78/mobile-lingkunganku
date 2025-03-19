part of '../view/ppob_page.dart';

class CustomCardSection extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onCardSelected;

  const CustomCardSection({
    super.key,
    required this.selectedIndex,
    required this.onCardSelected,
  });

  @override
  State<CustomCardSection> createState() => _CustomCardSectionState();
}

class _CustomCardSectionState extends State<CustomCardSection> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 3,
      itemBuilder: (context, index) {
        List<Map<String, String>> data = [
          {"title": "Pulsa", "image": "assets/icons/ppob_pulsa.png"},
          {"title": "Paket Data", "image": "assets/icons/ppob_data.png"},
          {"title": "Listrik", "image": "assets/icons/ppob_listrik.png"},
        ];
        return _buildCard(data[index]["title"]!, data[index]["image"]!, index);
      },
    );
  }

  Widget _buildCard(String title, String imagePath, int index) {
    bool isSelected = widget.selectedIndex == index;
    return GestureDetector(
      onTap: () {
        widget.onCardSelected(index); // Panggil callback untuk update state
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondaryColor : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30,
              child: Image.asset(imagePath),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.secondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
