// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passengers_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$streamPassengerTicketsHash() =>
    r'648a0ef7e005e812ceffe73c03a0ed8e58a415ed';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [streamPassengerTickets].
@ProviderFor(streamPassengerTickets)
const streamPassengerTicketsProvider = StreamPassengerTicketsFamily();

/// See also [streamPassengerTickets].
class StreamPassengerTicketsFamily
    extends Family<AsyncValue<List<PassengerTicket>>> {
  /// See also [streamPassengerTickets].
  const StreamPassengerTicketsFamily();

  /// See also [streamPassengerTickets].
  StreamPassengerTicketsProvider call(
    String tripId,
  ) {
    return StreamPassengerTicketsProvider(
      tripId,
    );
  }

  @override
  StreamPassengerTicketsProvider getProviderOverride(
    covariant StreamPassengerTicketsProvider provider,
  ) {
    return call(
      provider.tripId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'streamPassengerTicketsProvider';
}

/// See also [streamPassengerTickets].
class StreamPassengerTicketsProvider
    extends AutoDisposeStreamProvider<List<PassengerTicket>> {
  /// See also [streamPassengerTickets].
  StreamPassengerTicketsProvider(
    String tripId,
  ) : this._internal(
          (ref) => streamPassengerTickets(
            ref as StreamPassengerTicketsRef,
            tripId,
          ),
          from: streamPassengerTicketsProvider,
          name: r'streamPassengerTicketsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$streamPassengerTicketsHash,
          dependencies: StreamPassengerTicketsFamily._dependencies,
          allTransitiveDependencies:
              StreamPassengerTicketsFamily._allTransitiveDependencies,
          tripId: tripId,
        );

  StreamPassengerTicketsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tripId,
  }) : super.internal();

  final String tripId;

  @override
  Override overrideWith(
    Stream<List<PassengerTicket>> Function(StreamPassengerTicketsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StreamPassengerTicketsProvider._internal(
        (ref) => create(ref as StreamPassengerTicketsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tripId: tripId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<PassengerTicket>> createElement() {
    return _StreamPassengerTicketsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StreamPassengerTicketsProvider && other.tripId == tripId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tripId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StreamPassengerTicketsRef
    on AutoDisposeStreamProviderRef<List<PassengerTicket>> {
  /// The parameter `tripId` of this provider.
  String get tripId;
}

class _StreamPassengerTicketsProviderElement
    extends AutoDisposeStreamProviderElement<List<PassengerTicket>>
    with StreamPassengerTicketsRef {
  _StreamPassengerTicketsProviderElement(super.provider);

  @override
  String get tripId => (origin as StreamPassengerTicketsProvider).tripId;
}

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
