// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employees_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$streamCompanyEmployeesHash() =>
    r'3d5c93a3902e2240b321f39437bd8f4f7d16f283';

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

/// See also [streamCompanyEmployees].
@ProviderFor(streamCompanyEmployees)
const streamCompanyEmployeesProvider = StreamCompanyEmployeesFamily();

/// See also [streamCompanyEmployees].
class StreamCompanyEmployeesFamily extends Family<AsyncValue<List<Employee>>> {
  /// See also [streamCompanyEmployees].
  const StreamCompanyEmployeesFamily();

  /// See also [streamCompanyEmployees].
  StreamCompanyEmployeesProvider call(
    String companyId,
  ) {
    return StreamCompanyEmployeesProvider(
      companyId,
    );
  }

  @override
  StreamCompanyEmployeesProvider getProviderOverride(
    covariant StreamCompanyEmployeesProvider provider,
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
  String? get name => r'streamCompanyEmployeesProvider';
}

/// See also [streamCompanyEmployees].
class StreamCompanyEmployeesProvider
    extends AutoDisposeStreamProvider<List<Employee>> {
  /// See also [streamCompanyEmployees].
  StreamCompanyEmployeesProvider(
    String companyId,
  ) : this._internal(
          (ref) => streamCompanyEmployees(
            ref as StreamCompanyEmployeesRef,
            companyId,
          ),
          from: streamCompanyEmployeesProvider,
          name: r'streamCompanyEmployeesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$streamCompanyEmployeesHash,
          dependencies: StreamCompanyEmployeesFamily._dependencies,
          allTransitiveDependencies:
              StreamCompanyEmployeesFamily._allTransitiveDependencies,
          companyId: companyId,
        );

  StreamCompanyEmployeesProvider._internal(
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
    Stream<List<Employee>> Function(StreamCompanyEmployeesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StreamCompanyEmployeesProvider._internal(
        (ref) => create(ref as StreamCompanyEmployeesRef),
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
  AutoDisposeStreamProviderElement<List<Employee>> createElement() {
    return _StreamCompanyEmployeesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StreamCompanyEmployeesProvider &&
        other.companyId == companyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, companyId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StreamCompanyEmployeesRef
    on AutoDisposeStreamProviderRef<List<Employee>> {
  /// The parameter `companyId` of this provider.
  String get companyId;
}

class _StreamCompanyEmployeesProviderElement
    extends AutoDisposeStreamProviderElement<List<Employee>>
    with StreamCompanyEmployeesRef {
  _StreamCompanyEmployeesProviderElement(super.provider);

  @override
  String get companyId => (origin as StreamCompanyEmployeesProvider).companyId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
