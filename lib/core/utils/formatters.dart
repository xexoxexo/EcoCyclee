import 'package:ecocycle/core/models/app_models.dart';
import 'package:intl/intl.dart';

String formatCurrency(double value) {
  return NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  ).format(value);
}

String formatShortDate(DateTime value) {
  return DateFormat('dd MMM, HH:mm', 'id_ID').format(value);
}

String paymentMethodLabel(PaymentMethod method) {
  switch (method) {
    case PaymentMethod.qris:
      return 'QRIS';
    case PaymentMethod.bankTransfer:
      return 'Transfer Bank';
    case PaymentMethod.ewallet:
      return 'E-Wallet';
    case PaymentMethod.codcash:
      return 'Bayar di Tempat';
    case PaymentMethod.bankbri:
      return 'Bank BRI';
    case PaymentMethod.bankbca:
      return 'Bank BCA';
    case PaymentMethod.shoppepaylater:
      return 'Shoppe Pay Later';
    case PaymentMethod.gopay:
      return 'GoPay';
    case PaymentMethod.ovo:
      return 'OVO';
    case PaymentMethod.dana:
      return 'DANA';
    case PaymentMethod.tokencrypto:
      return 'Token Crypto';
  }
}

String wasteTypeLabel(WasteType wasteType) {
  switch (wasteType) {
    case WasteType.plastik:
      return 'Plastik';
    case WasteType.kertas:
      return 'Kertas';
    case WasteType.kaca:
      return 'Kaca';
    case WasteType.logam:
      return 'Logam';
  }
}

String syncStatusLabel(SyncStatus status) {
  switch (status) {
    case SyncStatus.localOnly:
      return 'Lokal';
    case SyncStatus.pendingSync:
      return 'Menunggu sync';
    case SyncStatus.synced:
      return 'Tersinkron';
    case SyncStatus.syncFailed:
      return 'Gagal sync';
  }
}

String taskStatusLabel(TaskStatus status) {
  switch (status) {
    case TaskStatus.assigned:
      return 'Ditugaskan';
    case TaskStatus.inProgress:
      return 'Dalam perjalanan';
    case TaskStatus.completed:
      return 'Selesai';
  }
}
