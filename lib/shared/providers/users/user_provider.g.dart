// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$streamUserRequestHash() => r'defd514038db223d0b4f131c8900b363cfa04da9';

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
    String uid,
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
    String uid,
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

  final String uid;

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
  String get uid;
}

class _StreamUserRequestProviderElement
    extends AutoDisposeStreamProviderElement<UserRequestModel?>
    with StreamUserRequestRef {
  _StreamUserRequestProviderElement(super.provider);

  @override
  String get uid => (origin as StreamUserRequestProvider).uid;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
