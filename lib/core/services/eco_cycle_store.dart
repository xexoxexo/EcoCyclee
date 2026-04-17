import 'package:ecocycle/core/models/app_models.dart';
import 'package:ecocycle/core/repositories/repository_interfaces.dart';
import 'package:flutter/material.dart' show Color;
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class EcoCycleStore extends ChangeNotifier
    implements
        AuthRepository,
        SellRepository,
        PlannerRepository,
        CommunityRepository,
        MarketplaceRepository,
        PointsRepository,
        CourierTasksRepository,
        SyncRepository {
  EcoCycleStore.seeded()
      : _uuid = const Uuid(),
        _hasCompletedOnboarding = false,
        _currentUser = null,
        _sellTransactions = [],
        _pickupSchedules = [],
        _posts = [],
        _products = [],
        _cart = const Cart(items: []),
        _orders = [],
        _pointHistory = [],
        _educationModules = [],
        _courierTasks = [],
        _syncQueue = [],
        _notifications = [] {
    _seedData();
  }

  final Uuid _uuid;

  bool _hasCompletedOnboarding;
  UserProfile? _currentUser;
  List<SellTransaction> _sellTransactions;
  List<PickupSchedule> _pickupSchedules;
  List<CommunityPost> _posts;
  List<Product> _products;
  Cart _cart;
  List<Order> _orders;
  List<RewardPointLedger> _pointHistory;
  List<EducationModule> _educationModules;
  List<CourierTask> _courierTasks;
  List<SyncJob> _syncQueue;
  List<AppNotification> _notifications;

  static SyncMetadata metadata({
    SyncStatus syncStatus = SyncStatus.synced,
    DateTime? createdAt,
  }) {
    final now = createdAt ?? DateTime.now();
    return SyncMetadata(
      createdAt: now,
      updatedAt: now,
      syncStatus: syncStatus,
      lastSyncedAt: syncStatus == SyncStatus.synced ? now : null,
      version: 1,
    );
  }

  void _seedData() {
    final now = DateTime.now();
    _products = [
      Product(
        id: 'prod-1',
        name: 'Tas Belanja Anyam',
        material: 'Plastik Daur Ulang',
        description: 'Tas kokoh untuk belanja harian dari kemasan plastik bekas.',
        sellerName: 'UMKM Hijau Nusantara',
        price: 89000,
        sync: metadata(createdAt: now.subtract(const Duration(days: 9))),
      ),
      Product(
        id: 'prod-2',
        name: 'Pot Serbaguna',
        material: 'Botol Kaca',
        description: 'Pot kecil untuk meja kerja dan sudut rumah.',
        sellerName: 'Studio Bumi Baru',
        price: 54000,
        sync: metadata(createdAt: now.subtract(const Duration(days: 7))),
      ),
      Product(
        id: 'prod-3',
        name: 'Dompet Lipat Eco',
        material: 'Banner Bekas',
        description: 'Dompet ringan dengan pola unik dari bahan sisa produksi.',
        sellerName: 'Kreasi Sirkular',
        price: 67000,
        sync: metadata(createdAt: now.subtract(const Duration(days: 5))),
      ),
    ];

    _posts = [
      CommunityPost(
        id: 'post-1',
        author: 'Komunitas Cempaka',
        content: 'Hari ini kami berhasil memilah 18 kg plastik bersama warga RW 04.',
        location: 'Bekasi',
        likes: 46,
        sync: metadata(createdAt: now.subtract(const Duration(hours: 8))),
      ),
      CommunityPost(
        id: 'post-2',
        author: 'SMP Hijau Lestari',
        content: 'Siswa kelas 8 membuat pot tanaman dari botol kaca. Hasilnya keren.',
        location: 'Bandung',
        likes: 31,
        sync: metadata(createdAt: now.subtract(const Duration(days: 1))),
      ),
    ];

    _educationModules = [
      EducationModule(
        id: 'edu-1',
        title: 'Mulai Pilah dari Rumah',
        subtitle: 'Kenali plastik, kertas, kaca, dan logam dalam 5 menit.',
        durationMinutes: 5,
        completed: true,
        color: const Color(0xFFE8F7F6),
        sync: metadata(createdAt: now.subtract(const Duration(days: 3))),
      ),
      EducationModule(
        id: 'edu-2',
        title: 'Setor Cerdas',
        subtitle: 'Tips menimbang dan memotret sampah agar pickup lebih cepat.',
        durationMinutes: 7,
        completed: false,
        color: const Color(0xFFFFF2D4),
        sync: metadata(createdAt: now.subtract(const Duration(days: 2))),
      ),
    ];

    _pointHistory = [
      RewardPointLedger(
        id: 'point-1',
        title: 'Menyelesaikan modul edukasi',
        points: 40,
        sync: metadata(createdAt: now.subtract(const Duration(days: 3))),
      ),
      RewardPointLedger(
        id: 'point-2',
        title: 'Transaksi plastik tersinkron',
        points: 55,
        sync: metadata(createdAt: now.subtract(const Duration(days: 1))),
      ),
    ];

    _notifications = [
      AppNotification(
        id: 'notif-1',
        title: 'Sync berhasil',
        message: '2 transaksi lokal berhasil dikirim ke pusat.',
        createdAt: now.subtract(const Duration(minutes: 45)),
      ),
      AppNotification(
        id: 'notif-2',
        title: 'Jadwal pickup besok',
        message: 'Kurir akan menjemput pukul 09.30 di rumah Anda.',
        createdAt: now.subtract(const Duration(hours: 4)),
      ),
    ];

    _pickupSchedules = [
      PickupSchedule(
        id: 'pickup-1',
        sellTransactionId: 'sell-1',
        location: 'Jl. Melati No. 7, Bekasi',
        scheduledFor: now.add(const Duration(hours: 18)),
        status: PickupStatus.assigned,
        courierName: 'Rafi',
        sync: metadata(createdAt: now.subtract(const Duration(hours: 12))),
      ),
    ];

    _sellTransactions = [
      SellTransaction(
        id: 'sell-1',
        userId: 'user-1',
        wasteType: WasteType.plastik,
        weightKg: 5.5,
        estimatedPrice: 27500,
        paymentMethod: PaymentMethod.ewallet,
        pickupRequested: true,
        sync: metadata(createdAt: now.subtract(const Duration(hours: 12))),
      ),
    ];

    _courierTasks = [
      CourierTask(
        id: 'task-1',
        pickupScheduleId: 'pickup-1',
        title: 'Pickup Plastik Campuran',
        customerName: 'Alya Putri',
        address: 'Jl. Melati No. 7, Bekasi',
        weightKg: 5.5,
        payout: 18000,
        scheduledFor: now.add(const Duration(hours: 18)),
        status: TaskStatus.assigned,
        notes: 'Pastikan menimbang ulang sebelum konfirmasi.',
        sync: metadata(createdAt: now.subtract(const Duration(hours: 12))),
      ),
      CourierTask(
        id: 'task-2',
        pickupScheduleId: 'pickup-2',
        title: 'Ambil Kertas Kantor',
        customerName: 'Klinik Sehat Sentosa',
        address: 'Jl. Pahlawan No. 3, Jakarta Timur',
        weightKg: 11.2,
        payout: 32000,
        scheduledFor: now.add(const Duration(days: 1, hours: 3)),
        status: TaskStatus.inProgress,
        notes: 'Hubungi satpam saat tiba.',
        sync: metadata(
          createdAt: now.subtract(const Duration(days: 1)),
          syncStatus: SyncStatus.pendingSync,
        ),
      ),
    ];

    _syncQueue = [
      SyncJob(
        id: 'sync-1',
        entityType: 'courier_task',
        entityId: 'task-2',
        action: 'update_status',
        sync: metadata(
          createdAt: now.subtract(const Duration(minutes: 15)),
          syncStatus: SyncStatus.pendingSync,
        ),
      ),
    ];
  }

  @override
  bool get hasCompletedOnboarding => _hasCompletedOnboarding;

  @override
  bool get isAuthenticated => _currentUser != null;

  @override
  AppRole? get currentRole => _currentUser?.role;

  @override
  UserProfile? get currentUser => _currentUser;

  @override
  List<SellTransaction> get sellTransactions => List.unmodifiable(
        _sellTransactions,
      );

  @override
  List<PickupSchedule> get pickupSchedules => List.unmodifiable(
        _pickupSchedules,
      );

  @override
  List<CommunityPost> get posts => List.unmodifiable(_posts);

  @override
  List<Product> get products => List.unmodifiable(_products);

  @override
  Cart get cart => _cart;

  @override
  List<Order> get orders => List.unmodifiable(_orders);

  @override
  List<RewardPointLedger> get pointHistory => List.unmodifiable(_pointHistory);

  @override
  List<EducationModule> get educationModules => List.unmodifiable(
        _educationModules,
      );

  @override
  List<CourierTask> get courierTasks => List.unmodifiable(_courierTasks);

  @override
  List<SyncJob> get syncQueue => List.unmodifiable(_syncQueue);

  @override
  List<AppNotification> get notifications => List.unmodifiable(_notifications);

  @override
  Future<void> completeOnboarding() async {
    _hasCompletedOnboarding = true;
    notifyListeners();
  }

  @override
  Future<UserProfile> signInAsRole(AppRole role) async {
    final now = DateTime.now();
    _currentUser = UserProfile(
      id: role == AppRole.user ? 'user-1' : 'courier-1',
      name: role == AppRole.user ? 'Alya Putri' : 'Rafi Saputra',
      email: role == AppRole.user
          ? 'alya@ecocycle.id'
          : 'rafi.courier@ecocycle.id',
      points: role == AppRole.user ? 320 : 120,
      walletBalance: role == AppRole.user ? 245000 : 410000,
      role: role,
      sync: metadata(createdAt: now),
    );
    notifyListeners();
    return _currentUser!;
  }

  @override
  Future<void> signOut() async {
    _currentUser = null;
    _cart = const Cart(items: []);
    notifyListeners();
  }

  @override
  Future<SellTransaction> submitSell({
    required WasteType wasteType,
    required double weightKg,
    required PaymentMethod paymentMethod,
    required bool pickupRequested,
  }) async {
    final pricePerKg = switch (wasteType) {
      WasteType.plastik => 5000.0,
      WasteType.kertas => 3000.0,
      WasteType.kaca => 2500.0,
      WasteType.logam => 7000.0,
    };
    final now = DateTime.now();
    final transaction = SellTransaction(
      id: _uuid.v4(),
      userId: _currentUser?.id ?? 'user-1',
      wasteType: wasteType,
      weightKg: weightKg,
      estimatedPrice: pricePerKg * weightKg,
      paymentMethod: paymentMethod,
      pickupRequested: pickupRequested,
      sync: metadata(
        createdAt: now,
        syncStatus: SyncStatus.pendingSync,
      ),
    );
    _sellTransactions = [transaction, ..._sellTransactions];
    _queueSync(entityType: 'sell_transaction', entityId: transaction.id);

    if (pickupRequested) {
      final schedule = PickupSchedule(
        id: _uuid.v4(),
        sellTransactionId: transaction.id,
        location: 'Alamat rumah tersimpan',
        scheduledFor: now.add(const Duration(days: 1)),
        status: PickupStatus.scheduled,
        courierName: 'Menunggu penugasan',
        sync: metadata(
          createdAt: now,
          syncStatus: SyncStatus.pendingSync,
        ),
      );
      _pickupSchedules = [schedule, ..._pickupSchedules];
      _notifications = [
        AppNotification(
          id: _uuid.v4(),
          title: 'Pickup baru dibuat',
          message: 'Permintaan pickup Anda tersimpan dan siap disinkronkan.',
          createdAt: now,
        ),
        ..._notifications,
      ];
    }

    notifyListeners();
    return transaction;
  }

  @override
  Future<void> createManualPickupSchedule({
    required DateTime scheduledFor,
    required String location,
  }) async {
    final schedule = PickupSchedule(
      id: _uuid.v4(),
      sellTransactionId: 'manual-${_uuid.v4()}',
      location: location,
      scheduledFor: scheduledFor,
      status: PickupStatus.scheduled,
      courierName: 'Penugasan otomatis',
      sync: metadata(
        createdAt: DateTime.now(),
        syncStatus: SyncStatus.localOnly,
      ),
    );
    _pickupSchedules = [schedule, ..._pickupSchedules];
    _queueSync(entityType: 'pickup_schedule', entityId: schedule.id);
    notifyListeners();
  }

  @override
  Future<void> addCommunityPost(String content) async {
    if (content.trim().isEmpty) {
      return;
    }
    final post = CommunityPost(
      id: _uuid.v4(),
      author: _currentUser?.name ?? 'Pengguna EcoCycle',
      content: content.trim(),
      location: 'Komunitas Lokal',
      likes: 0,
      sync: metadata(
        createdAt: DateTime.now(),
        syncStatus: SyncStatus.pendingSync,
      ),
    );
    _posts = [post, ..._posts];
    _queueSync(entityType: 'community_post', entityId: post.id);
    notifyListeners();
  }

  @override
  Future<void> addToCart(Product product) async {
    final existingIndex = _cart.items.indexWhere(
      (item) => item.product.id == product.id,
    );
    final nextItems = [..._cart.items];
    if (existingIndex >= 0) {
      nextItems[existingIndex] = nextItems[existingIndex].copyWith(
        quantity: nextItems[existingIndex].quantity + 1,
      );
    } else {
      nextItems.add(CartItem(product: product, quantity: 1));
    }
    _cart = Cart(items: nextItems);
    notifyListeners();
  }

  @override
  Future<Order> checkout(PaymentMethod paymentMethod) async {
    final now = DateTime.now();
    final order = Order(
      id: _uuid.v4(),
      items: _cart.items,
      paymentMethod: paymentMethod,
      paymentSuccessful: true,
      sync: metadata(
        createdAt: now,
        syncStatus: SyncStatus.pendingSync,
      ),
    );
    _orders = [order, ..._orders];
    _cart = const Cart(items: []);
    _queueSync(entityType: 'order', entityId: order.id);
    _notifications = [
      AppNotification(
        id: _uuid.v4(),
        title: 'Checkout berhasil',
        message: 'Pesanan daur ulang Anda akan diproses setelah sync.',
        createdAt: now,
      ),
      ..._notifications,
    ];
    notifyListeners();
    return order;
  }

  @override
  Future<void> completeModule(String moduleId) async {
    final index = _educationModules.indexWhere((module) => module.id == moduleId);
    if (index < 0) {
      return;
    }
    final module = _educationModules[index];
    if (module.completed) {
      return;
    }
    _educationModules[index] = module.copyWith(
      completed: true,
      sync: module.sync.copyWith(
        updatedAt: DateTime.now(),
        syncStatus: SyncStatus.pendingSync,
        version: module.sync.version + 1,
      ),
    );
    _pointHistory = [
      RewardPointLedger(
        id: _uuid.v4(),
        title: 'Modul selesai: ${module.title}',
        points: 30,
        sync: metadata(
          createdAt: DateTime.now(),
          syncStatus: SyncStatus.pendingSync,
        ),
      ),
      ..._pointHistory,
    ];
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(points: _currentUser!.points + 30);
    }
    _queueSync(entityType: 'education_module', entityId: module.id);
    notifyListeners();
  }

  @override
  CourierTask? findTask(String taskId) {
    return _courierTasks.cast<CourierTask?>().firstWhere(
          (task) => task?.id == taskId,
          orElse: () => null,
        );
  }

  @override
  Future<void> advanceTask(String taskId) async {
    final index = _courierTasks.indexWhere((task) => task.id == taskId);
    if (index < 0) {
      return;
    }

    final task = _courierTasks[index];
    final nextStatus = switch (task.status) {
      TaskStatus.assigned => TaskStatus.inProgress,
      TaskStatus.inProgress => TaskStatus.completed,
      TaskStatus.completed => TaskStatus.completed,
    };

    _courierTasks[index] = task.copyWith(
      status: nextStatus,
      sync: task.sync.copyWith(
        updatedAt: DateTime.now(),
        syncStatus: SyncStatus.pendingSync,
        version: task.sync.version + 1,
      ),
    );

    _notifications = [
      AppNotification(
        id: _uuid.v4(),
        title: 'Status kurir diperbarui',
        message: '${task.title} kini ${_courierTasks[index].status.name}.',
        createdAt: DateTime.now(),
      ),
      ..._notifications,
    ];

    _queueSync(entityType: 'courier_task', entityId: taskId);
    notifyListeners();
  }

  @override
  Future<void> runMockSync() async {
    final now = DateTime.now();
    _syncQueue = _syncQueue
        .map(
          (job) => job.copyWith(
            sync: job.sync.copyWith(
              updatedAt: now,
              lastSyncedAt: now,
              syncStatus: SyncStatus.synced,
              version: job.sync.version + 1,
            ),
          ),
        )
        .toList();

    _sellTransactions = _sellTransactions
        .map(
          (transaction) => transaction.copyWith(
            sync: transaction.sync.copyWith(
              updatedAt: now,
              lastSyncedAt: now,
              syncStatus: SyncStatus.synced,
              version: transaction.sync.version + 1,
            ),
          ),
        )
        .toList();

    _pickupSchedules = _pickupSchedules
        .map(
          (schedule) => schedule.copyWith(
            sync: schedule.sync.copyWith(
              updatedAt: now,
              lastSyncedAt: now,
              syncStatus: SyncStatus.synced,
              version: schedule.sync.version + 1,
            ),
          ),
        )
        .toList();

    _courierTasks = _courierTasks
        .map(
          (task) => task.copyWith(
            sync: task.sync.copyWith(
              updatedAt: now,
              lastSyncedAt: now,
              syncStatus: SyncStatus.synced,
              version: task.sync.version + 1,
            ),
          ),
        )
        .toList();

    _notifications = [
      AppNotification(
        id: _uuid.v4(),
        title: 'Mock sync selesai',
        message: 'Semua perubahan lokal dipromosikan menjadi status synced.',
        createdAt: now,
      ),
      ..._notifications,
    ];
    notifyListeners();
  }

  void _queueSync({
    required String entityType,
    required String entityId,
  }) {
    _syncQueue = [
      SyncJob(
        id: _uuid.v4(),
        entityType: entityType,
        entityId: entityId,
        action: 'upsert',
        sync: metadata(
          createdAt: DateTime.now(),
          syncStatus: SyncStatus.pendingSync,
        ),
      ),
      ..._syncQueue,
    ];
  }
}
