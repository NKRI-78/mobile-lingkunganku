part of '../view/iuran_page.dart';

class CustomListInvoiceSection extends StatelessWidget {
  final List<Data>? iuran;
  final bool isLoading;
  final ValueNotifier<List<Data>> selectedInvoices;

  const CustomListInvoiceSection({
    super.key,
    required this.iuran,
    required this.isLoading,
    required this.selectedInvoices,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
          child: CircularProgressIndicator(color: AppColors.secondaryColor));
    }

    if (iuran == null || iuran!.isEmpty) {
      return const Center(child: EmptyPage(msg: 'Data Tagihan Kosong'));
    }

    return ListView.builder(
      itemCount: iuran!.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final Data iuranItem = iuran![index];
        final ValueNotifier<bool> isExpanded = ValueNotifier(false);

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10),
          elevation: 2,
          child: Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.all(8.0),
                leading: ValueListenableBuilder<List<Data>>(
                  valueListenable: selectedInvoices,
                  builder: (context, selected, child) {
                    return Checkbox(
                      activeColor: AppColors.secondaryColor,
                      checkColor: AppColors.selectColor,
                      value: selected.contains(iuranItem),
                      onChanged: (isChecked) {
                        if (isChecked == true) {
                          selectedInvoices.value = List.from(selected)
                            ..add(iuranItem);
                        } else {
                          selectedInvoices.value = List.from(selected)
                            ..remove(iuranItem);
                        }
                      },
                    );
                  },
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateHelper.parseDate(
                          iuranItem.invoiceDate ?? "Tanggal tidak tersedia"),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Rp ${NumberFormat("#,###", "id_ID").format(iuranItem.totalAmount ?? 0)}",
                      style: AppTextStyles.textDialog,
                    ),
                  ],
                ),
                subtitle: Text(
                  iuranItem.translateStatus,
                  style: TextStyle(
                    color: iuranItem.translateStatus == "PAID"
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: ValueListenableBuilder<bool>(
                  valueListenable: isExpanded,
                  builder: (context, expanded, child) {
                    return IconButton(
                      icon: Icon(
                          expanded ? Icons.expand_less : Icons.expand_more),
                      onPressed: () {
                        isExpanded.value = !expanded;
                      },
                    );
                  },
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: isExpanded,
                builder: (context, expanded, child) {
                  if (!expanded) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'Keterangan : ${iuranItem.note}',
                          style: AppTextStyles.textDialog,
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
