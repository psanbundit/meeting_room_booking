import 'package:equatable/equatable.dart';

class ApplicationState extends Equatable {
  final bool toggleLoading;
  final String? currentSelectLocale;
  final double screenWidth;
  final double screenHeight;
  final int currentTappedIndex;

  const ApplicationState({
    this.toggleLoading = false,
    this.currentSelectLocale = 'th',
    this.screenWidth = 0,
    this.screenHeight = 0,
    this.currentTappedIndex = 0,
  });

  ApplicationState copyWith({
    bool? toggleLoading,
    String? currentSelectLocale,
    double? screenWidth,
    double? screenHeight,
    int? currentTappedIndex,
  }) {
    return ApplicationState(
      toggleLoading: toggleLoading ?? this.toggleLoading,
      currentSelectLocale: currentSelectLocale ?? this.currentSelectLocale,
      screenWidth: screenWidth ?? this.screenWidth,
      screenHeight: screenHeight ?? this.screenHeight,
      currentTappedIndex: currentTappedIndex ?? this.currentTappedIndex,
    );
  }

  @override
  List<Object?> get props => [
        toggleLoading,
        currentSelectLocale,
        screenWidth,
        screenHeight,
        currentTappedIndex,
      ];
}
