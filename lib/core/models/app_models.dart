import 'package:flutter/material.dart';

enum AppRole { user, courier }

enum SyncStatus { localOnly, pendingSync, synced, syncFailed }

enum PaymentMethod { qris, bankTransfer, ewallet, bankbri, bankbca, shoppepaylater, gopay, ovo, dana, codcash, tokencrypto } ///cashOnDelivery }

enum WasteType { plastik, kertas, kaca, logam }

enum PickupStatus { draft, scheduled, assigned, inProgress, completed }

enum TaskStatus { assigned, inProgress, completed }

class SyncMetadata {
  const SyncMetadata({
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    required this.version,
    this.lastSyncedAt,
  });

  final DateTime createdAt;
  final DateTime updatedAt;
  final SyncStatus syncStatus;
  final DateTime? lastSyncedAt;
  final int version;

  SyncMetadata copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    SyncStatus? syncStatus,
    DateTime? lastSyncedAt,
    int? version,
  }) {
    return SyncMetadata(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      version: version ?? this.version,
    );
  }
}

class UserProfile {
  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.points,
    required this.walletBalance,
    required this.role,
    required this.sync,
  });

  final String id;
  final String name;
  final String email;
  final int points;
  final double walletBalance;
  final AppRole role;
  final SyncMetadata sync;

  UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    int? points,
    double? walletBalance,
    AppRole? role,
    SyncMetadata? sync,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      points: points ?? this.points,
      walletBalance: walletBalance ?? this.walletBalance,
      role: role ?? this.role,
      sync: sync ?? this.sync,
    );
  }
}


class BuyTransaction {
  const BuyTransaction({
    required this.id,
    required this.userId,
    required this.wasteType,
    required this.weightKg,
    required this.estimatedPrice,
    required this.paymentMethod,
    required this.pickupRequested,
    required this.sync,
  });

  final String id;
  final String userId;
  final WasteType wasteType;
  final double weightKg;
  final double estimatedPrice;
  final PaymentMethod paymentMethod;
  final bool pickupRequested;
  final SyncMetadata sync;

  BuyTransaction copyWith({
    String? id,
    String? userId,
    WasteType? wasteType,
    double? weightKg,
    double? estimatedPrice,
    PaymentMethod? paymentMethod,
    bool? pickupRequested,
    SyncMetadata? sync,
  }) {
    return BuyTransaction(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      wasteType: wasteType ?? this.wasteType,
      weightKg: weightKg ?? this.weightKg,
      estimatedPrice: estimatedPrice ?? this.estimatedPrice,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      pickupRequested: pickupRequested ?? this.pickupRequested,
      sync: sync ?? this.sync,
    );
  }
}

class SellTransaction {
  const SellTransaction({
    required this.id,
    required this.userId,
    required this.wasteType,
    required this.weightKg,
    required this.estimatedPrice,
    required this.paymentMethod,
    required this.pickupRequested,
    required this.sync,
  });

  final String id;
  final String userId;
  final WasteType wasteType;
  final double weightKg;
  final double estimatedPrice;
  final PaymentMethod paymentMethod;
  final bool pickupRequested;
  final SyncMetadata sync;

  SellTransaction copyWith({
    String? id,
    String? userId,
    WasteType? wasteType,
    double? weightKg,
    double? estimatedPrice,
    PaymentMethod? paymentMethod,
    bool? pickupRequested,
    SyncMetadata? sync,
  }) {
    return SellTransaction(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      wasteType: wasteType ?? this.wasteType,
      weightKg: weightKg ?? this.weightKg,
      estimatedPrice: estimatedPrice ?? this.estimatedPrice,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      pickupRequested: pickupRequested ?? this.pickupRequested,
      sync: sync ?? this.sync,
    );
  }
}

class PickupSchedule {
  const PickupSchedule({
    required this.id,
    required this.sellTransactionId,
    required this.location,
    required this.scheduledFor,
    required this.status,
    required this.sync,
    this.courierName,
  });

  final String id;
  final String sellTransactionId;
  final String location;
  final DateTime scheduledFor;
  final PickupStatus status;
  final String? courierName;
  final SyncMetadata sync;

  PickupSchedule copyWith({
    String? id,
    String? sellTransactionId,
    String? location,
    DateTime? scheduledFor,
    PickupStatus? status,
    String? courierName,
    SyncMetadata? sync,
  }) {
    return PickupSchedule(
      id: id ?? this.id,
      sellTransactionId: sellTransactionId ?? this.sellTransactionId,
      location: location ?? this.location,
      scheduledFor: scheduledFor ?? this.scheduledFor,
      status: status ?? this.status,
      courierName: courierName ?? this.courierName,
      sync: sync ?? this.sync,
    );
  }
}

class RewardPointLedger {
  const RewardPointLedger({
    required this.id,
    required this.title,
    required this.points,
    required this.sync,
  });

  final String id;
  final String title;
  final int points;
  final SyncMetadata sync;
}

class EducationModule {
  const EducationModule({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.durationMinutes,
    required this.completed,
    required this.color,
    required this.sync,
  });

  final String id;
  final String title;
  final String subtitle;
  final int durationMinutes;
  final bool completed;
  final Color color;
  final SyncMetadata sync;

  EducationModule copyWith({
    String? id,
    String? title,
    String? subtitle,
    int? durationMinutes,
    bool? completed,
    Color? color,
    SyncMetadata? sync,
  }) {
    return EducationModule(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      completed: completed ?? this.completed,
      color: color ?? this.color,
      sync: sync ?? this.sync,
    );
  }
}

class CommunityPost {
  const CommunityPost({
    required this.id,
    required this.author,
    required this.content,
    required this.location,
    required this.likes,
    required this.sync,
  });

  final String id;
  final String author;
  final String content;
  final String location;
  final int likes;
  final SyncMetadata sync;
}

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.material,
    required this.description,
    required this.sellerName,
    required this.price,
    required this.sync,
  });

  final String id;
  final String name;
  final String material;
  final String description;
  final String sellerName;
  final double price;
  final SyncMetadata sync;
}

class CartItem {
  const CartItem({
    required this.product,
    required this.quantity,
  });

  final Product product;
  final int quantity;

  double get subtotal => product.price * quantity;

  CartItem copyWith({
    Product? product,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}

class Cart {
  const Cart({required this.items});

  final List<CartItem> items;

  double get totalAmount => items.fold(
        0,
        (sum, item) => sum + item.subtotal,
      );
}

class Order {
  const Order({
    required this.id,
    required this.items,
    required this.paymentMethod,
    required this.paymentSuccessful,
    required this.sync,
  });

  final String id;
  final List<CartItem> items;
  final PaymentMethod paymentMethod;
  final bool paymentSuccessful;
  final SyncMetadata sync;

  double get totalAmount => items.fold(
        0,
        (sum, item) => sum + item.subtotal,
      );
}

class CourierTask {
  const CourierTask({
    required this.id,
    required this.pickupScheduleId,
    required this.title,
    required this.customerName,
    required this.address,
    required this.weightKg,
    required this.payout,
    required this.scheduledFor,
    required this.status,
    required this.sync,
    this.notes,
  });

  final String id;
  final String pickupScheduleId;
  final String title;
  final String customerName;
  final String address;
  final double weightKg;
  final double payout;
  final DateTime scheduledFor;
  final TaskStatus status;
  final String? notes;
  final SyncMetadata sync;

  CourierTask copyWith({
    String? id,
    String? pickupScheduleId,
    String? title,
    String? customerName,
    String? address,
    double? weightKg,
    double? payout,
    DateTime? scheduledFor,
    TaskStatus? status,
    String? notes,
    SyncMetadata? sync,
  }) {
    return CourierTask(
      id: id ?? this.id,
      pickupScheduleId: pickupScheduleId ?? this.pickupScheduleId,
      title: title ?? this.title,
      customerName: customerName ?? this.customerName,
      address: address ?? this.address,
      weightKg: weightKg ?? this.weightKg,
      payout: payout ?? this.payout,
      scheduledFor: scheduledFor ?? this.scheduledFor,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      sync: sync ?? this.sync,
    );
  }
}

class SyncJob {
  const SyncJob({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.action,
    required this.sync,
  });

  final String id;
  final String entityType;
  final String entityId;
  final String action;
  final SyncMetadata sync;

  SyncJob copyWith({SyncMetadata? sync}) {
    return SyncJob(
      id: id,
      entityType: entityType,
      entityId: entityId,
      action: action,
      sync: sync ?? this.sync,
    );
  }
}

class AppNotification {
  const AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.createdAt,
  });

  final String id;
  final String title;
  final String message;
  final DateTime createdAt;
}
