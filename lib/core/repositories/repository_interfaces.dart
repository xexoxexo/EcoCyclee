import 'package:ecocycle/core/models/app_models.dart';

abstract class AuthRepository {
  bool get isAuthenticated;
  bool get hasCompletedOnboarding;
  AppRole? get currentRole;
  UserProfile? get currentUser;

  Future<void> completeOnboarding();
  Future<UserProfile> signInAsRole(AppRole role);
  Future<void> signOut();
}

abstract class SellRepository {
  List<SellTransaction> get sellTransactions;

  Future<SellTransaction> submitSell({
    required WasteType wasteType,
    required double weightKg,
    required PaymentMethod paymentMethod,
    required bool pickupRequested,
  });
}

abstract class PlannerRepository {
  List<PickupSchedule> get pickupSchedules;

  Future<void> createManualPickupSchedule({
    required DateTime scheduledFor,
    required String location,
  });
}

abstract class CommunityRepository {
  List<CommunityPost> get posts;

  Future<void> addCommunityPost(String content);
}

abstract class MarketplaceRepository {
  List<Product> get products;
  Cart get cart;
  List<Order> get orders;

  Future<void> addToCart(Product product);
  Future<Order> checkout(PaymentMethod paymentMethod);
}

abstract class PointsRepository {
  List<RewardPointLedger> get pointHistory;
  List<EducationModule> get educationModules;

  Future<void> completeModule(String moduleId);
}

abstract class CourierTasksRepository {
  List<CourierTask> get courierTasks;

  CourierTask? findTask(String taskId);
  Future<void> advanceTask(String taskId);
}

abstract class SyncRepository {
  List<SyncJob> get syncQueue;
  List<AppNotification> get notifications;

  Future<void> runMockSync();
}
