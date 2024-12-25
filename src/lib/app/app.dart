import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tamagochi_appss/services/pet_service.dart';
import 'package:tamagochi_appss/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:tamagochi_appss/ui/bottom_sheets/pet_stats_sheet.dart';
import 'package:tamagochi_appss/ui/bottom_sheets/pet_store_sheet.dart';
import 'package:tamagochi_appss/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:tamagochi_appss/ui/dialogs/pet_creation_dialog.dart';
import 'package:tamagochi_appss/ui/dialogs/pet_death_dialog.dart';
import 'package:tamagochi_appss/ui/views/home/home_view.dart';
import 'package:tamagochi_appss/ui/views/startup/startup_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
  ],
  dependencies: [
    InitializableSingleton(classType: PetService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    StackedBottomsheet(classType: PetStoreSheet),
    StackedBottomsheet(classType: PetStatsSheet),
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: PetCreationDialog),
    StackedDialog(classType: PetDeathDialog),
  ],
)
class App {}
