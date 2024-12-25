import 'package:tamagochi_appss/main/bootstrap.dart';
import 'package:tamagochi_appss/models/enums/flavor.dart';
import 'package:tamagochi_appss/ui/views/app/app_view.dart';

void main() {
  bootstrap(
    builder: () => const AppView(),
    flavor: Flavor.production,
  );
}
