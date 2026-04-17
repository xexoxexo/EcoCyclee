import 'package:ecocycle/app/router.dart';
import 'package:ecocycle/core/repositories/repository_interfaces.dart';
import 'package:ecocycle/core/services/eco_cycle_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ecoCycleStoreProvider = ChangeNotifierProvider<EcoCycleStore>((ref) {
  return EcoCycleStore.seeded();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return ref.watch(ecoCycleStoreProvider);
});

final sellRepositoryProvider = Provider<SellRepository>((ref) {
  return ref.watch(ecoCycleStoreProvider);
});

final plannerRepositoryProvider = Provider<PlannerRepository>((ref) {
  return ref.watch(ecoCycleStoreProvider);
});

final communityRepositoryProvider = Provider<CommunityRepository>((ref) {
  return ref.watch(ecoCycleStoreProvider);
});

final marketplaceRepositoryProvider = Provider<MarketplaceRepository>((ref) {
  return ref.watch(ecoCycleStoreProvider);
});

final pointsRepositoryProvider = Provider<PointsRepository>((ref) {
  return ref.watch(ecoCycleStoreProvider);
});

final courierTasksRepositoryProvider = Provider<CourierTasksRepository>((ref) {
  return ref.watch(ecoCycleStoreProvider);
});

final syncRepositoryProvider = Provider<SyncRepository>((ref) {
  return ref.watch(ecoCycleStoreProvider);
});

final routerProvider = Provider((ref) {
  final store = ref.watch(ecoCycleStoreProvider);
  return buildRouter(store);
});
