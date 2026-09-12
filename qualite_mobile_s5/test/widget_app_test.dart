import 'package:flutter_test/flutter_test.dart';
import 'package:qualite_mobile_s5/main.dart';

void main() {
  testWidgets('affiche le titre, la liste des étudiants et la boîte de dialogue', (tester) async {
    await tester.pumpWidget(const MonApplication());

    expect(find.text('Liste des étudiants'), findsOneWidget);
    expect(find.text('Liste des étudiants et de leurs moyennes :'), findsOneWidget);
    expect(find.text('Nom: Alice'), findsOneWidget);
    expect(find.text('Nom: Bob'), findsOneWidget);
    expect(find.text('Nom: Charlie'), findsOneWidget);
    expect(find.text('Nom: David'), findsOneWidget);
    expect(find.text('Nom: Eve'), findsOneWidget);

    await tester.tap(find.text('Calculer la moyenne de la classe'));
    await tester.pumpAndSettle();

    expect(find.text('Moyenne des étudiants'), findsOneWidget);
    expect(find.text('La moyenne des étudiants est : 14.35'), findsOneWidget);
  });
}
