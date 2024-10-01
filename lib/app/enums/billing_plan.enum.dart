import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum BillingPlan {
  free,
  basic,
  premium(),
  ultimate,
}

extension BillingPlanExtension on BillingPlan {
  IconData get icon {
    switch (this) {
      case BillingPlan.free:
        return MdiIcons.account;
      case BillingPlan.basic:
        return MdiIcons.accountGroup;
      case BillingPlan.premium:
        return MdiIcons.accountStar;
      case BillingPlan.ultimate:
        return MdiIcons.accountSupervisor;
      default:
        return Icons.error;
    }
  }

  String get slug {
    switch (this) {
      case BillingPlan.free:
        return 'Free Plan';
      case BillingPlan.basic:
        return 'Basic Plan';
      case BillingPlan.premium:
        return 'Premium Plan';
      case BillingPlan.ultimate:
        return 'Ultimate Plan';
      default:
        return '';
    }
  }

  fromString(String value) {
    switch (value.toLowerCase()) {
      case 'free':
        return BillingPlan.free;
      case 'basic':
        return BillingPlan.basic;
      case 'premium':
        return BillingPlan.premium;
      case 'ultimate':
        return BillingPlan.ultimate;
      default:
        return null;
    }
  }
}
