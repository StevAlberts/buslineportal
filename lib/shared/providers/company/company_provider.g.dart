// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$streamCompanyHash() => r'6a66df6dbd09ea8e6dc81c9d9d659d0ccf0a0be6';

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

/// See also [streamCompany].
@ProviderFor(streamCompany)
const streamCompanyProvider = StreamCompanyFamily();

/// See also [streamCompany].
class StreamCompanyFamily extends Family<AsyncValue<Company?>> {
  /// See also [streamCompany].
  const StreamCompanyFamily();

  /// See also [streamCompany].
  StreamCompanyProvider call(
    String companyId,
  ) {
    return StreamCompanyProvider(
      companyId,
    );
  }

  @override
  StreamCompanyProvider getProviderOverride(
    covariant StreamCompanyProvider provider,
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
  String? get name => r'streamCompanyProvider';
}

/// See also [streamCompany].
class StreamCompanyProvider extends AutoDisposeStreamProvider<Company?> {
  /// See also [streamCompany].
  StreamCompanyProvider(
    String companyId,
  ) : this._internal(
          (ref) => streamCompany(
            ref as StreamCompanyRef,
            companyId,
          ),
          from: streamCompanyProvider,
          name: r'streamCompanyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$streamCompanyHash,
          dependencies: StreamCompanyFamily._dependencies,
          allTransitiveDependencies:
              StreamCompanyFamily._allTransitiveDependencies,
          companyId: companyId,
        );

  StreamCompanyProvider._internal(
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
    Stream<Company?> Function(StreamCompanyRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StreamCompanyProvider._internal(
        (ref) => create(ref as StreamCompanyRef),
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
  AutoDisposeStreamProviderElement<Company?> createElement() {
    return _StreamCompanyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StreamCompanyProvider && other.companyId == companyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, companyId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StreamCompanyRef on AutoDisposeStreamProviderRef<Company?> {
  /// The parameter `companyId` of this provider.
  String get companyId;
}

class _StreamCompanyProviderElement
    extends AutoDisposeStreamProviderElement<Company?> with StreamCompanyRef {
  _StreamCompanyProviderElement(super.provider);

  @override
  String get companyId => (origin as StreamCompanyProvider).companyId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
