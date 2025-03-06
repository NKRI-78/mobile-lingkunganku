import 'dart:async';
import 'dart:io';

import 'package:go_router/go_router.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class WebViewScreen extends StatefulWidget {
  final String title;
  final String url;
  const WebViewScreen({super.key, required this.url, required this.title});

  @override
  // ignore: library_private_types_in_public_api
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  Completer<WebViewController> controller = Completer<WebViewController>();
  WebViewController? controllerGlobal;
  bool isLoading = true;

  Future<void> launch(url) async {
    final Uri params = Uri(
        scheme: 'mailto',
        path: 'myOwnEmailAddress@gmail.com',
        queryParameters: {
          'subject': 'Default Subject',
          'body': 'Default body'
        });
    if (await canLaunchUrl(url)) {
      Uri.parse(url);
      await launchUrl(params);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Web : ${widget.url}');
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: exitApp,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColors.secondaryColor,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.whiteColor,
              size: 24,
            ),
          ),
          toolbarHeight: 90,
          actions: [
            PopupMenuButton(
              color: AppColors.whiteColor,
              iconColor: Colors.white,
              iconSize: 20,
              itemBuilder: (BuildContext buildContext) {
                return [
                  const PopupMenuItem(
                    value: "/bukadibrowser",
                    child: Text(
                      "Buka di browser",
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ];
              },
              onSelected: (route) async {
                if (route == "/bukadibrowser" &&
                    widget.url.contains(RegExp(r'^(http|https)://'))) {
                  openLink(widget.url);
                } else {
                  openLink("https://${widget.url}");
                }
              },
            )
          ],
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/icons/lingkunganku_putih.png',
                fit: BoxFit.contain,
                height: 35,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.url.contains(RegExp(r'^(http|https)://'))
                          ? widget.url
                          : "https://${widget.url}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.greyColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: AppColors.blackColor,
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    WebView(
                      javascriptMode: JavascriptMode.unrestricted,
                      initialUrl: widget.url,
                      userAgent:
                          'Mozilla/5.0 (Linux; Android 7.0; SM-G930V Build/NRD90M) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.125 Mobile Safari/537.36',
                      gestureNavigationEnabled: true,
                      onWebViewCreated: (WebViewController webViewController) {
                        controller.future
                            .then((value) => controllerGlobal = value);
                        controller.complete(webViewController);
                      },
                      navigationDelegate: (NavigationRequest request) async {
                        if (request.url.contains('tel:')) {
                          await launch(request.url);
                          return NavigationDecision.prevent;
                        } else if (request.url.contains('whatsapp:')) {
                          await launch(request.url);
                          return NavigationDecision.prevent;
                        } else if (request.url.contains('fb:')) {
                          await launch(request.url);
                          return NavigationDecision.prevent;
                        } else if (request.url.contains('mailto:')) {
                          await launch(request.url);
                          return NavigationDecision.prevent;
                        }
                        return NavigationDecision.navigate;
                      },
                      onPageStarted: (String url) async {
                        setState(() => isLoading = true);
                      },
                      onPageFinished: (String url) {
                        setState(() => isLoading = false);
                      },
                    ),
                    isLoading
                        ? Center(
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[200]!,
                              child: Card(
                                margin: EdgeInsets.zero,
                                color: AppColors.whiteColor,
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0)),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0),
                                      color: AppColors.whiteColor),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> exitApp() async {
    if (controllerGlobal != null) {
      if (await controllerGlobal!.canGoBack()) {
        controllerGlobal!.goBack();
        return Future.value(false);
      } else {
        return Future.value(true);
      }
    } else {
      return Future.value(true);
    }
  }
}

Future<void> openLink(String url) async {
  final uri = Uri.parse(url);

  if (!await launchUrl(uri)) {
    throw Exception('Could not launch $uri');
  }
}
