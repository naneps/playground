import 'package:get/get.dart';
import 'package:playground/app/models/navigation.model.dart';
import 'package:playground/app/routes/app_pages.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController'
  RxList<NavigationModel> navigationList = <NavigationModel>[
    NavigationModel(
      title: 'Box Shadow Generator',
      route: Routes.BOX_SHADOW_GENERATOR,
    ),
    NavigationModel(
      title: 'Gradient Generator',
      route: Routes.GRADIENT_GENERATOR,
    ),
  ].obs;
}
