import 'package:flutter_test/flutter_test.dart';
import 'package:qualite_mobile_s5/main.dart';

void main() {
  testWidgets('affiche la liste des étudiants et le calcul de moyenne', (
    tester,
  ) async {
    await tester.pumpWidget(const MonApplication());

    expect(find.text('Liste des étudiants'), findsOneWidget);
    expect(find.text('Nom: Alice'), findsOneWidget);
    expect(find.text('Moyenne : 17.25'), findsOneWidget);

    await tester.tap(find.text('Nom: Alice'));
    await tester.pumpAndSettle();

    expect(find.text('Détails de l\'étudiant'), findsOneWidget);
    expect(find.text('Nom de l\'étudiant : Alice'), findsOneWidget);
    expect(find.text('Moyenne : 17.25'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Calculer la moyenne de la classe'));
    await tester.pumpAndSettle();

    expect(find.text('La moyenne des étudiants est : 14.35'), findsOneWidget);
  });
}
