import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class CustomHtmlExtension extends HtmlExtension {
  @override
  Set<String> get supportedTags => {"p"}; // Target hanya elemen <p>

  @override
  InlineSpan build(ExtensionContext context) {
    return WidgetSpan(
      child: SizedBox(
        width: double.infinity, // Agar tidak overflow horizontal
        child: Text(
          context.element!.text,
          maxLines: 2, // Batasi maksimal 2 baris
          overflow: TextOverflow.ellipsis, // Tambahkan titik tiga (...)
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
