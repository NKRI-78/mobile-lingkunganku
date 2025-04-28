part of '../view/ppob_page.dart';

class CustomFieldSection extends StatefulWidget {
  final TextEditingController controller;
  final String? type;

  const CustomFieldSection({
    super.key,
    required this.controller,
    required this.type,
  });

  @override
  State<CustomFieldSection> createState() => _CustomFieldSectionState();
}

class _CustomFieldSectionState extends State<CustomFieldSection> {
  Timer? _debounce;
  String? lastPrefix;
  String? _errorMessage; // Tambahkan variabel untuk menyimpan pesan error

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    _debounce?.cancel();
    super.dispose();
  }

  void _onTextChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      String nomor = _normalizePhoneNumber(widget.controller.text.trim());

      if (widget.controller.text != nomor) {
        widget.controller.text = nomor;
        widget.controller.selection = TextSelection.fromPosition(
          TextPosition(offset: nomor.length),
        );
      }

      // if (nomor.length < 5) {
      //   // ⚠️ Nomor kurang dari 5 digit, tampilkan error
      //   setState(() {
      //     _errorMessage = "Nomor harus minimal 5 digit.";
      //   });
      //   return;
      // } else {
      //   // ✅ Nomor valid, hilangkan error
      //   setState(() {
      //     _errorMessage = null;
      //   });
      // }

      String prefix = nomor.substring(0, 5);
      if (prefix != lastPrefix) {
        lastPrefix = prefix;
        if (mounted) {
          print("📡 Fetching Data untuk prefix: $prefix, type: ${widget.type}");
          context
              .read<PpobCubit>()
              .fetchPulsaData(prefix: prefix, type: widget.type ?? "PULSA");
        }
      } else {
        print("⚠️ Prefix tidak berubah, tidak fetch ulang.");
      }
    });
  }

  String _normalizePhoneNumber(String number) {
    String cleanedNumber = number.replaceAll(RegExp(r'\D'), '');
    if (cleanedNumber.startsWith('0')) {
      return '62${cleanedNumber.substring(1)}';
    } else if (!cleanedNumber.startsWith('62')) {
      return '62$cleanedNumber';
    }
    return cleanedNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey, width: 0.5),
          ),
          child: Row(
            children: [
              Expanded(
                child: Theme(
                  data: ThemeData(
                      textSelectionTheme: TextSelectionThemeData(
                    selectionHandleColor: Colors.transparent,
                  )),
                  child: TextField(
                    controller: widget.controller,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(13),
                    ],
                    cursorColor: AppColors.secondaryColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Masukkan Nomor",
                      hintStyle: AppTextStyles.textWelcome,
                      isDense: true,
                    ),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  final selectedNumber = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactListPpob()),
                  );

                  if (selectedNumber != null && selectedNumber is String) {
                    widget.controller.text = selectedNumber;
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                ),
                icon: const Icon(Icons.contacts, color: Colors.white, size: 18),
                label: const Text(
                  "Daftar Kontak",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        if (_errorMessage != null) // Tampilkan error jika ada
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 10),
            child: Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
