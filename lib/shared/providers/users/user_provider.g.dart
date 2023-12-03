// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$streamUserRequestHash() => r'31f80945b9a899e74345ec78990e30cfdec591f0';

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

/// See also [streamUserRequest].
@ProviderFor(streamUserRequest)
const streamUserRequestProvider = StreamUserRequestFamily();

/// See also [streamUserRequest].
class StreamUserRequestFamily extends Family<AsyncValue<UserRequestModel?>> {
  /// See also [streamUserRequest].
  const StreamUserRequestFamily();

  /// See also [streamUserRequest].
  StreamUserRequestProvider call(
    String? uid,
  ) {
    return StreamUserRequestProvider(
      uid,
    );
  }

  @override
  StreamUserRequestProvider getProviderOverride(
    covariant StreamUserRequestProvider provider,
  ) {
    return call(
      provider.uid,
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
  String? get name => r'streamUserRequestProvider';
}

/// See also [streamUserRequest].
class StreamUserRequestProvider
    extends AutoDisposeStreamProvider<UserRequestModel?> {
  /// See also [streamUserRequest].
  StreamUserRequestProvider(
    String? uid,
  ) : this._internal(
          (ref) => streamUserRequest(
            ref as StreamUserRequestRef,
            uid,
          ),
          from: streamUserRequestProvider,
          name: r'streamUserRequestProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$streamUserRequestHash,
          dependencies: StreamUserRequestFamily._dependencies,
          allTransitiveDependencies:
              StreamUserRequestFamily._allTransitiveDependencies,
          uid: uid,
        );

  StreamUserRequestProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String? uid;

  @override
  Override overrideWith(
    Stream<UserRequestModel?> Function(StreamUserRequestRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StreamUserRequestProvider._internal(
        (ref) => create(ref as StreamUserRequestRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<UserRequestModel?> createElement() {
    return _StreamUserRequestProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StreamUserRequestProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StreamUserRequestRef on AutoDisposeStreamProviderRef<UserRequestModel?> {
  /// The parameter `uid` of this provider.
  String? get uid;
}

class _StreamUserRequestProviderElement
    extends AutoDisposeStreamProviderElement<UserRequestModel?>
    with StreamUserRequestRef {
  _StreamUserRequestProviderElement(super.provider);

  @override
  String? get uid => (origin as StreamUserRequestProvider).uid;
}

String _$streamCurrentUserHash() => r'2e85504170ef63a142ca1a502079947669b5d9b7';

/// See also [streamCurrentUser].
@ProviderFor(streamCurrentUser)
const streamCurrentUserProvider = StreamCurrentUserFamily();

/// See also [streamCurrentUser].
class StreamCurrentUserFamily extends Family<AsyncValue<UserModel?>> {
  /// See also [streamCurrentUser].
  const StreamCurrentUserFamily();

  /// See also [streamCurrentUser].
  StreamCurrentUserProvider call(
    String? uid,
  ) {
    return StreamCurrentUserProvider(
      uid,
    );
  }

  @override
  StreamCurrentUserProvider getProviderOverride(
    covariant StreamCurrentUserProvider provider,
  ) {
    return call(
      provider.uid,
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
  String? get name => r'streamCurrentUserProvider';
}

/// See also [streamCurrentUser].
class StreamCurrentUserProvider extends AutoDisposeStreamProvider<UserModel?> {
  /// See also [streamCurrentUser].
  StreamCurrentUserProvider(
    String? uid,
  ) : this._internal(
          (ref) => streamCurrentUser(
            ref as StreamCurrentUserRef,
            uid,
          ),
          from: streamCurrentUserProvider,
          name: r'streamCurrentUserProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$streamCurrentUserHash,
          dependencies: StreamCurrentUserFamily._dependencies,
          allTransitiveDependencies:
              StreamCurrentUserFamily._allTransitiveDependencies,
          uid: uid,
        );

  StreamCurrentUserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String? uid;

  @override
  Override overrideWith(
    Stream<UserModel?> Function(StreamCurrentUserRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StreamCurrentUserProvider._internal(
        (ref) => create(ref as StreamCurrentUserRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<UserModel?> createElement() {
    return _StreamCurrentUserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StreamCurrentUserProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StreamCurrentUserRef on AutoDisposeStreamProviderRef<UserModel?> {
  /// The parameter `uid` of this provider.
  String? get uid;
}

class _StreamCurrentUserProviderElement
    extends AutoDisposeStreamProviderElement<UserModel?>
    with StreamCurrentUserRef {
  _StreamCurrentUserProviderElement(super.provider);

  @override
  String? get uid => (origin as StreamCurrentUserProvider).uid;
}

String _$streamUserManagersHash() =>
    r'e0a9efdc2e470a78ce6a66edc53c1ecbcd446267';

/// See also [streamUserManagers].
@ProviderFor(streamUserManagers)
const streamUserManagersProvider = StreamUserManagersFamily();

/// See also [streamUserManagers].
class StreamUserManagersFamily extends Family<AsyncValue<List<UserModel>?>> {
  /// See also [streamUserManagers].
  const StreamUserManagersFamily();

  /// See also [streamUserManagers].
  StreamUserManagersProvider call(
    String companyId,
  ) {
    return StreamUserManagersProvider(
      companyId,
    );
  }

  @override
  StreamUserManagersProvider getProviderOverride(
    covariant StreamUserManagersProvider provider,
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
  String? get name => r'streamUserManagersProvider';
}

/// See also [streamUserManagers].
class StreamUserManagersProvider
    extends AutoDisposeStreamProvider<List<UserModel>?> {
  /// See also [streamUserManagers].
  StreamUserManagersProvider(
    String companyId,
  ) : this._internal(
          (ref) => streamUserManagers(
            ref as StreamUserManagersRef,
            companyId,
          ),
          from: streamUserManagersProvider,
          name: r'streamUserManagersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$streamUserManagersHash,
          dependencies: StreamUserManagersFamily._dependencies,
          allTransitiveDependencies:
              StreamUserManagersFamily._allTransitiveDependencies,
          companyId: companyId,
        );

  StreamUserManagersProvider._internal(
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
    Stream<List<UserModel>?> Function(StreamUserManagersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StreamUserManagersProvider._internal(
        (ref) => create(ref as StreamUserManagersRef),
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
  AutoDisposeStreamProviderElement<List<UserModel>?> createElement() {
    return _StreamUserManagersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StreamUserManagersProvider && other.companyId == companyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, companyId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StreamUserManagersRef on AutoDisposeStreamProviderRef<List<UserModel>?> {
  /// The parameter `companyId` of this provider.
  String get companyId;
}

class _StreamUserManagersProviderElement
    extends AutoDisposeStreamProviderElement<List<UserModel>?>
    with StreamUserManagersRef {
  _StreamUserManagersProviderElement(super.provider);

  @override
  String get companyId => (origin as StreamUserManagersProvider).companyId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
