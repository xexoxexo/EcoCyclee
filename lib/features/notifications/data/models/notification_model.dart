// TODO Implement this library.
class NotificationModel {
  final String id;
  final String userId;
  final String type; // 'sell', 'buy', 'exchange_point'
  final String title;
  final String message;
  final String description;
  final DateTime createdAt;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    required this.message,
    required this.description,
    required this.createdAt,
    this.isRead = false,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      userId: json['userId'],
      type: json['type'],
      title: json['title'],
      message: json['message'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      isRead: json['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'type': type,
      'title': title,
      'message': message,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'isRead': isRead,
    };
  }

  factory NotificationModel.sellItem({
    required String id,
    required String userId,
    required String itemName,
    required double price,
  }) {
    return NotificationModel(
      id: id,
      userId: userId,
      type: 'sell',
      title: 'Penjualan Berhasil',
      message: 'Item "$itemName" telah terjual',
      description: 'Anda berhasil menjual $itemName seharga Rp${price.toStringAsFixed(0)}',
      createdAt: DateTime.now(),
    );
  }

  factory NotificationModel.buyItem({
    required String id,
    required String userId,
    required String itemName,
    required double price,
  }) {
    return NotificationModel(
      id: id,
      userId: userId,
      type: 'buy',
      title: 'Pembelian Berhasil',
      message: 'Anda berhasil membeli "$itemName"',
      description: 'Pembelian $itemName seharga Rp${price.toStringAsFixed(0)} telah dikonfirmasi',
      createdAt: DateTime.now(),
    );
  }

  factory NotificationModel.exchangePoint({
    required String id,
    required String userId,
    required int points,
    required String reward,
  }) {
    return NotificationModel(
      id: id,
      userId: userId,
      type: 'exchange_point',
      title: 'Tukar Point Berhasil',
      message: 'Anda berhasil menukar $points poin',
      description: 'Terima kasih telah menukar $points poin dengan $reward',
      createdAt: DateTime.now(),
    );
  }
}