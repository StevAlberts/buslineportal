// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passengers_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$passengerDataHash() => r'55433cd817311878bc308f76ea6b56ba6126023b';

/// See also [PassengerData].
@ProviderFor(PassengerData)
final passengerDataProvider =
    AutoDisposeAsyncNotifierProvider<PassengerData, List<Passenger>>.internal(
  PassengerData.new,
  name: r'passengerDataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$passengerDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PassengerData = AutoDisposeAsyncNotifier<List<Passenger>>;
String _$selectedSeatsHash() => r'13e5091ae3ea591b3f8b192a0638634dded96f03';

/// See also [SelectedSeats].
@ProviderFor(SelectedSeats)
final selectedSeatsProvider =
    AutoDisposeAsyncNotifierProvider<SelectedSeats, List<String>>.internal(
  SelectedSeats.new,
  name: r'selectedSeatsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedSeatsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedSeats = AutoDisposeAsyncNotifier<List<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
