import 'package:flutter/material.dart';

class KeyboardVisibility extends StatefulWidget {
  const KeyboardVisibility({
    super.key,
    required this.builder,
    this.withFloatingButtonClose = false,
    this.floatingNotShow = false,
  });
  final bool floatingNotShow;
  final bool withFloatingButtonClose;
  final Widget Function(
      BuildContext _, bool keyboardVisible, double keyboardHeight) builder;

  @override
  State<KeyboardVisibility> createState() => _KeyboardVisibilityState();
}

class _KeyboardVisibilityState extends State<KeyboardVisibility>
    with WidgetsBindingObserver {
  bool isVisible = false;
  double keyboardHeight = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    final bottomInset = View.of(context).viewInsets.bottom;
    final keyboardInset = EdgeInsets.fromViewPadding(
        View.of(context).viewInsets, View.of(context).devicePixelRatio);

    bool valueVisible = bottomInset > 30;

    setState(() {
      keyboardHeight = keyboardInset.bottom;
    });

    if (valueVisible != isVisible) {
      setState(() {
        isVisible = valueVisible;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (widget.withFloatingButtonClose) {
      child = Stack(
        children: [
          widget.builder(context, isVisible, keyboardHeight),
          if (isVisible)
            Positioned(
              right: 16,
              bottom: (widget.floatingNotShow ? keyboardHeight : 0) +
                  MediaQuery.of(context).padding.bottom +
                  16,
              child: FloatingActionButton(
                heroTag: const Key('keyboarddown'),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                },
                child: const Icon(Icons.keyboard_arrow_down_outlined),
              ),
            ),
        ],
      );
    } else {
      child = widget.builder(context, isVisible, keyboardHeight);
    }

    return child;
  }
}
