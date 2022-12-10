import 'package:flutter/material.dart';
import 'package:test_flutter/util/consant/const_text.dart';

class ErrorPage extends StatelessWidget {
  final String? message;
  final VoidCallback? onRefresh;

  const ErrorPage({required this.message, this.onRefresh, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            message ?? Messages.defaultError,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Colors.red.shade900,
                ),
          ),
          if (onRefresh != null) ...[
            const SizedBox(height: 16),
            InkWell(
              onTap: onRefresh,
              child: Container(
                padding: Theme.of(context).buttonTheme.padding,
                decoration: BoxDecoration(
                  color: Theme.of(context).buttonTheme.colorScheme?.background,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    Text(
                      "refresh",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.refresh)
                  ],
                ),
              ),
            )
          ],
        ],
      ),
    );
  }
}
