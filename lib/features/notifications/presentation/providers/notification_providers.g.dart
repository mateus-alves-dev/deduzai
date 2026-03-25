// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationPermissionGranted)
final notificationPermissionGrantedProvider =
    NotificationPermissionGrantedProvider._();

final class NotificationPermissionGrantedProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  NotificationPermissionGrantedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationPermissionGrantedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationPermissionGrantedHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return notificationPermissionGranted(ref);
  }
}

String _$notificationPermissionGrantedHash() =>
    r'7225cfb114443c5af1cda6731df2fbf6deb0ffd3';

@ProviderFor(notificationBannerShouldShow)
final notificationBannerShouldShowProvider =
    NotificationBannerShouldShowProvider._();

final class NotificationBannerShouldShowProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  NotificationBannerShouldShowProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationBannerShouldShowProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationBannerShouldShowHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return notificationBannerShouldShow(ref);
  }
}

String _$notificationBannerShouldShowHash() =>
    r'cb64ac461d93888b034a7ef1e8cb43ee1006d075';

@ProviderFor(NotificationBannerNotifier)
final notificationBannerProvider = NotificationBannerNotifierProvider._();

final class NotificationBannerNotifierProvider
    extends $NotifierProvider<NotificationBannerNotifier, void> {
  NotificationBannerNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationBannerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationBannerNotifierHash();

  @$internal
  @override
  NotificationBannerNotifier create() => NotificationBannerNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$notificationBannerNotifierHash() =>
    r'e56319130d7d9bba41deb3bc958f9cb10ea2cac6';

abstract class _$NotificationBannerNotifier extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(monthlyReminderEnabled)
final monthlyReminderEnabledProvider = MonthlyReminderEnabledProvider._();

final class MonthlyReminderEnabledProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  MonthlyReminderEnabledProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'monthlyReminderEnabledProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$monthlyReminderEnabledHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return monthlyReminderEnabled(ref);
  }
}

String _$monthlyReminderEnabledHash() =>
    r'6d4ce6ce37f309fbb62015f2fbafa8bbcad21f82';
