import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:go_router/go_router.dart';

import '../../misc/colors.dart';
import '../../misc/text_style.dart';

class ContactListPpob extends StatefulWidget {
  const ContactListPpob({super.key});

  @override
  _ContactListPpobState createState() => _ContactListPpobState();
}

class _ContactListPpobState extends State<ContactListPpob> {
  List<Contact> contacts = [];
  List<Contact> filteredContacts = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = true; // Tambahkan state isLoading

  @override
  void initState() {
    super.initState();
    fetchContacts();
  }

  Future<void> fetchContacts() async {
    if (await FlutterContacts.requestPermission()) {
      List<Contact> fetchedContacts =
          await FlutterContacts.getContacts(withProperties: true);

      setState(() {
        contacts = fetchedContacts;
        filteredContacts = fetchedContacts;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Izin kontak ditolak'),
          backgroundColor: AppColors.redColor,
        ),
      );
    }
  }

  void filterContacts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredContacts = contacts;
      } else {
        filteredContacts = contacts
            .where((contact) =>
                contact.displayName.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pilih Kontak',
          style: AppTextStyles.textStyle1,
        ),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.buttonColor2,
            size: 24,
          ),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: filterContacts,
              decoration: InputDecoration(
                hintText: 'Cari kontak...',
                prefixIcon:
                    Icon(Icons.search_rounded, color: AppColors.buttonColor2),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      BorderSide(color: AppColors.secondaryColor, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.greyColor, width: 1),
                ),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.secondaryColor,
                    ),
                  )
                : filteredContacts.isEmpty
                    ? Center(
                        child: Text(
                          'Kontak Tidak Ditemukan',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredContacts.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(filteredContacts[index].displayName),
                            subtitle: Text(filteredContacts[index]
                                    .phones
                                    .isNotEmpty
                                ? filteredContacts[index].phones.first.number
                                : 'No phone number'),
                            onTap: () {
                              if (filteredContacts[index].phones.isNotEmpty) {
                                String rawNumber =
                                    filteredContacts[index].phones.first.number;

                                String cleanedNumber =
                                    rawNumber.replaceAll(RegExp(r'\D'), '');

                                if (cleanedNumber.startsWith('0')) {
                                  cleanedNumber =
                                      '62${cleanedNumber.substring(1)}';
                                } else if (!cleanedNumber.startsWith('62')) {
                                  cleanedNumber = '62$cleanedNumber';
                                }

                                Navigator.pop(context, cleanedNumber);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Kontak tidak memiliki nomor telepon')),
                                );
                              }
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
