// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trips_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$streamAllTripsHash() => r'0aa9b3262f9e1ae4ee197a88adcac821faaa1a7b';

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

/// See also [streamAllTrips].
@ProviderFor(streamAllTrips)
const streamAllTripsProvider = StreamAllTripsFamily();

/// See also [streamAllTrips].
class StreamAllTripsFamily extends Family<AsyncValue<List<Trip>>> {
  /// See also [streamAllTrips].
  const StreamAllTripsFamily();

  /// See also [streamAllTrips].
  StreamAllTripsProvider call(
    String companyId,
  ) {
    return StreamAllTripsProvider(
      companyId,
    );
  }

  @override
  StreamAllTripsProvider getProviderOverride(
    covariant StreamAllTripsProvider provider,
  ) {
    return call(
      provider.companyId,
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
  String? get name => r'streamAllTripsProvider';
}

/// See also [streamAllTrips].
class StreamAllTripsProvider extends AutoDisposeStreamProvider<List<Trip>> {
  /// See also [streamAllTrips].
  StreamAllTripsProvider(
    String companyId,
  ) : this._internal(
          (ref) => streamAllTrips(
            ref as StreamAllTripsRef,
            companyId,
          ),
          from: streamAllTripsProvider,
          name: r'streamAllTripsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$streamAllTripsHash,
          dependencies: StreamAllTripsFamily._dependencies,
          allTransitiveDependencies:
              StreamAllTripsFamily._allTransitiveDependencies,
          companyId: companyId,
        );

  StreamAllTripsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.companyId,
  }) : super.internal();

  final String companyId;

  @override
  Override overrideWith(
    Stream<List<Trip>> Function(StreamAllTripsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StreamAllTripsProvider._internal(
        (ref) => create(ref as StreamAllTripsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        companyId: companyId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Trip>> createElement() {
    return _StreamAllTripsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StreamAllTripsProvider && other.companyId == companyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, companyId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StreamAllTripsRef on AutoDisposeStreamProviderRef<List<Trip>> {
  /// The parameter `companyId` of this provider.
  String get companyId;
}

class _StreamAllTripsProviderElement
    extends AutoDisposeStreamProviderElement<List<Trip>>
    with StreamAllTripsRef {
  _StreamAllTripsProviderElement(super.provider);

  @override
  String get companyId => (origin as StreamAllTripsProvider).companyId;
}

String _$streamTripHash() => r'b3107ba1404f30b02e4ef006e595e98b16eeb38b';

/// See also [streamTrip].
@ProviderFor(streamTrip)
const streamTripProvider = StreamTripFamily();

/// See also [streamTrip].
class StreamTripFamily extends Family<AsyncValue<Trip>> {
  /// See also [streamTrip].
  const StreamTripFamily();

  /// See also [streamTrip].
  StreamTripProvider call(
    String companyId,
  ) {
    return StreamTripProvider(
      companyId,
    );
  }

  @override
  StreamTripProvider getProviderOverride(
    covariant StreamTripProvider provider,
  ) {
    return call(
      provider.companyId,
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
  String? get name => r'streamTripProvider';
}

/// See also [streamTrip].
class StreamTripProvider extends AutoDisposeStreamProvider<Trip> {
  /// See also [streamTrip].
  StreamTripProvider(
    String companyId,
  ) : this._internal(
          (ref) => streamTrip(
            ref as StreamTripRef,
            companyId,
          ),
          from: streamTripProvider,
          name: r'streamTripProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$streamTripHash,
          dependencies: StreamTripFamily._dependencies,
          allTransitiveDependencies:
              StreamTripFamily._allTransitiveDependencies,
          companyId: companyId,
        );

  StreamTripProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.companyId,
  }) : super.internal();

  final String companyId;

  @override
  Override overrideWith(
    Stream<Trip> Function(StreamTripRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StreamTripProvider._internal(
        (ref) => create(ref as StreamTripRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        companyId: companyId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Trip> createElement() {
    return _StreamTripProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StreamTripProvider && other.companyId == companyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, companyId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StreamTripRef on AutoDisposeStreamProviderRef<Trip> {
  /// The parameter `companyId` of this provider.
  String get companyId;
}

class _StreamTripProviderElement extends AutoDisposeStreamProviderElement<Trip>
    with StreamTripRef {
  _StreamTripProviderElement(super.provider);

  @override
  String get companyId => (origin as StreamTripProvider).companyId;
}

String _$streamMovingTripsHash() => r'4048a1c29d11bf77c64dfc4f7f7fb3a24eade1aa';

/// See also [streamMovingTrips].
@ProviderFor(streamMovingTrips)
const streamMovingTripsProvider = StreamMovingTripsFamily();

/// See also [streamMovingTrips].
class StreamMovingTripsFamily extends Family<AsyncValue<List<Trip>>> {
  /// See also [streamMovingTrips].
  const StreamMovingTripsFamily();

  /// See also [streamMovingTrips].
  StreamMovingTripsProvider call(
    String companyId,
  ) {
    return StreamMovingTripsProvider(
      companyId,
    );
  }

  @override
  StreamMovingTripsProvider getProviderOverride(
    covariant StreamMovingTripsProvider provider,
  ) {
    return call(
      provider.companyId,
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
  String? get name => r'streamMovingTripsProvider';
}

/// See also [streamMovingTrips].
class StreamMovingTripsProvider extends AutoDisposeStreamProvider<List<Trip>> {
  /// See also [streamMovingTrips].
  StreamMovingTripsProvider(
    String companyId,
  ) : this._internal(
          (ref) => streamMovingTrips(
            ref as StreamMovingTripsRef,
            companyId,
          ),
          from: streamMovingTripsProvider,
          name: r'streamMovingTripsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$streamMovingTripsHash,
          dependencies: StreamMovingTripsFamily._dependencies,
          allTransitiveDependencies:
              StreamMovingTripsFamily._allTransitiveDependencies,
          companyId: companyId,
        );

  StreamMovingTripsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.companyId,
  }) : super.internal();

  final String companyId;

  @override
  Override overrideWith(
    Stream<List<Trip>> Function(StreamMovingTripsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StreamMovingTripsProvider._internal(
        (ref) => create(ref as StreamMovingTripsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        companyId: companyId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Trip>> createElement() {
    return _StreamMovingTripsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StreamMovingTripsProvider && other.companyId == companyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, companyId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StreamMovingTripsRef on AutoDisposeStreamProviderRef<List<Trip>> {
  /// The parameter `companyId` of this provider.
  String get companyId;
}

class _StreamMovingTripsProviderElement
    extends AutoDisposeStreamProviderElement<List<Trip>>
    with StreamMovingTripsRef {
  _StreamMovingTripsProviderElement(super.provider);

  @override
  String get companyId => (origin as StreamMovingTripsProvider).companyId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
