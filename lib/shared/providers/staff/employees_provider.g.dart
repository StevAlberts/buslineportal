// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employees_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$streamAllEmployeesHash() =>
    r'22cc1ae0049143f010f43ae30037772b999baeb9';

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

/// See also [streamAllEmployees].
@ProviderFor(streamAllEmployees)
const streamAllEmployeesProvider = StreamAllEmployeesFamily();

/// See also [streamAllEmployees].
class StreamAllEmployeesFamily extends Family<AsyncValue<List<Employee>>> {
  /// See also [streamAllEmployees].
  const StreamAllEmployeesFamily();

  /// See also [streamAllEmployees].
  StreamAllEmployeesProvider call(
    String companyId,
  ) {
    return StreamAllEmployeesProvider(
      companyId,
    );
  }

  @override
  StreamAllEmployeesProvider getProviderOverride(
    covariant StreamAllEmployeesProvider provider,
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
  String? get name => r'streamAllEmployeesProvider';
}

/// See also [streamAllEmployees].
class StreamAllEmployeesProvider
    extends AutoDisposeStreamProvider<List<Employee>> {
  /// See also [streamAllEmployees].
  StreamAllEmployeesProvider(
    String companyId,
  ) : this._internal(
          (ref) => streamAllEmployees(
            ref as StreamAllEmployeesRef,
            companyId,
          ),
          from: streamAllEmployeesProvider,
          name: r'streamAllEmployeesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$streamAllEmployeesHash,
          dependencies: StreamAllEmployeesFamily._dependencies,
          allTransitiveDependencies:
              StreamAllEmployeesFamily._allTransitiveDependencies,
          companyId: companyId,
        );

  StreamAllEmployeesProvider._internal(
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
    Stream<List<Employee>> Function(StreamAllEmployeesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StreamAllEmployeesProvider._internal(
        (ref) => create(ref as StreamAllEmployeesRef),
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
    return _StreamAllEmployeesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StreamAllEmployeesProvider && other.companyId == companyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, companyId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StreamAllEmployeesRef on AutoDisposeStreamProviderRef<List<Employee>> {
  /// The parameter `companyId` of this provider.
  String get companyId;
}

class _StreamAllEmployeesProviderElement
    extends AutoDisposeStreamProviderElement<List<Employee>>
    with StreamAllEmployeesRef {
  _StreamAllEmployeesProviderElement(super.provider);

  @override
  String get companyId => (origin as StreamAllEmployeesProvider).companyId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
