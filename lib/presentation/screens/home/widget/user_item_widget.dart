import 'package:flutter/material.dart';
import 'package:test_flutter/data/model/user.dart';

class UserItemWidget extends StatelessWidget {
  final User user;

  const UserItemWidget(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.blue.shade50,
        border: Border.all(color: Colors.grey.shade50),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user.fullName,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 4),
          Text(
            user.email ?? '-',
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(height: 4),
          Text(
            user.address.toString(),
            style: Theme.of(context).textTheme.overline,
          ),
        ],
      ),
    );
  }
}
