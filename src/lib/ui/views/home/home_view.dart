import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tamagochi_appss/ui/common/ui_helpers.dart';
import 'package:tamagochi_appss/ui/widgets/pet_action_buttons.dart';
import 'package:tamagochi_appss/ui/widgets/pet_animation.dart';
import 'package:tamagochi_appss/ui/widgets/pet_status_bar.dart';
import 'package:tamagochi_appss/ui/views/home/home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              verticalSpaceLarge,
              if (viewModel.modelError != null)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    viewModel.modelError.toString(),
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              if (viewModel.pet != null) ...[
                Text(
                  viewModel.pet!.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpaceMedium,
                PetAnimation(pet: viewModel.pet!),
                verticalSpaceMedium,
                PetStatusBar(pet: viewModel.pet!),
                verticalSpaceLarge,
                PetActionButtons(
                  pet: viewModel.pet!,
                  onFeed: viewModel.feedPet,
                  onPlay: viewModel.playWithPet,
                  onSleep: viewModel.putPetToSleep,
                  onStats: viewModel.showPetStats,
                ),
              ],
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) => viewModel.initialize();
}
