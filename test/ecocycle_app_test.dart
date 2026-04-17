import 'package:ecocycle/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('onboarding flows into user dashboard', (tester) async {
    await tester.pumpWidget(const EcoCycleRoot());
    await tester.pumpAndSettle();

    expect(find.text('Mulai Sekarang'), findsOneWidget);

    await tester.tap(find.text('Mulai Sekarang'));
    await tester.pumpAndSettle();

    expect(find.text('Masuk ke EcoCycle'), findsOneWidget);

    await tester.tap(find.text('Masuk sebagai Pengguna'));
    await tester.pumpAndSettle();

    expect(find.text('EcoCycle Hari Ini'), findsOneWidget);
    expect(find.text('Jual Sampah'), findsOneWidget);
  });

  testWidgets('role-aware shell routes courier to task view', (tester) async {
    await tester.pumpWidget(const EcoCycleRoot());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Mulai Sekarang'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Masuk sebagai Kurir'));
    await tester.pumpAndSettle();

    expect(find.text('Tugas Penjemputan'), findsOneWidget);
    expect(find.text('Kurir siap jalan'), findsOneWidget);
  });

  testWidgets('user shell bottom navigation opens community tab', (tester) async {
    await tester.pumpWidget(const EcoCycleRoot());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Mulai Sekarang'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Masuk sebagai Pengguna'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Komunitas'));
    await tester.pumpAndSettle();

    expect(find.text('ECOmmunity'), findsOneWidget);
    expect(find.text('Publikasikan'), findsOneWidget);
  });
}
