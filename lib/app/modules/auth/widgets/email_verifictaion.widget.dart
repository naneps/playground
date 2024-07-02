import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EmailVerificationWidget extends StatelessWidget {
  String? email;
  EmailVerificationWidget({
    super.key,
    this.email,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            MdiIcons.emailOutline,
            size: 100,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(height: 10),
          Text.rich(
            TextSpan(
              text: 'We have sent a verification email to ',
              children: [
                TextSpan(
                  text: email,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).primaryColorDark,
                      ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'Please check your email to verify your account',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
