// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tickets_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$streamPassengerTicketsHash() =>
    r'4130510235405feb4787aac11b1b0546b96dac78';

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

String _$streamLuggageTicketsHash() =>
    r'9f6fb3e1bfdc2acd62c734445b5ad18d1591ab42';

/// See also [streamLuggageTickets].
@ProviderFor(streamLuggageTickets)
const streamLuggageTicketsProvider = StreamLuggageTicketsFamily();

/// See also [streamLuggageTickets].
class StreamLuggageTicketsFamily
    extends Family<AsyncValue<List<LuggageTicket>>> {
  /// See also [streamLuggageTickets].
  const StreamLuggageTicketsFamily();

  /// See also [streamLuggageTickets].
  StreamLuggageTicketsProvider call(
    String tripId,
  ) {
    return StreamLuggageTicketsProvider(
      tripId,
    );
  }

  @override
  StreamLuggageTicketsProvider getProviderOverride(
    covariant StreamLuggageTicketsProvider provider,
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
  String? get name => r'streamLuggageTicketsProvider';
}

/// See also [streamLuggageTickets].
class StreamLuggageTicketsProvider
    extends AutoDisposeStreamProvider<List<LuggageTicket>> {
  /// See also [streamLuggageTickets].
  StreamLuggageTicketsProvider(
    String tripId,
  ) : this._internal(
          (ref) => streamLuggageTickets(
            ref as StreamLuggageTicketsRef,
            tripId,
          ),
          from: streamLuggageTicketsProvider,
          name: r'streamLuggageTicketsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$streamLuggageTicketsHash,
          dependencies: StreamLuggageTicketsFamily._dependencies,
          allTransitiveDependencies:
              StreamLuggageTicketsFamily._allTransitiveDependencies,
          tripId: tripId,
        );

  StreamLuggageTicketsProvider._internal(
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
    Stream<List<LuggageTicket>> Function(StreamLuggageTicketsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StreamLuggageTicketsProvider._internal(
        (ref) => create(ref as StreamLuggageTicketsRef),
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
  AutoDisposeStreamProviderElement<List<LuggageTicket>> createElement() {
    return _StreamLuggageTicketsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StreamLuggageTicketsProvider && other.tripId == tripId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tripId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StreamLuggageTicketsRef
    on AutoDisposeStreamProviderRef<List<LuggageTicket>> {
  /// The parameter `tripId` of this provider.
  String get tripId;
}

class _StreamLuggageTicketsProviderElement
    extends AutoDisposeStreamProviderElement<List<LuggageTicket>>
    with StreamLuggageTicketsRef {
  _StreamLuggageTicketsProviderElement(super.provider);

  @override
  String get tripId => (origin as StreamLuggageTicketsProvider).tripId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
