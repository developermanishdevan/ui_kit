import 'package:flutter/material.dart';

class AppOfflineWrapper extends StatelessWidget {
  const AppOfflineWrapper({
    required this.isOnline, required this.child, super.key,
    this.offlineBanner = true,
    this.onRetry,
  });

  final bool isOnline;
  final Widget child;
  final bool offlineBanner;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (!isOnline && offlineBanner)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Material(
              color: Colors.red[700],
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    const Icon(Icons.wifi_off, color: Colors.white, size: 16),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text('No internet connection',
                          style: TextStyle(color: Colors.white, fontSize: 13)),
                    ),
                    if (onRetry != null)
                      TextButton(
                        onPressed: onRetry,
                        style:
                            TextButton.styleFrom(foregroundColor: Colors.white),
                        child: const Text('Retry'),
                      ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
