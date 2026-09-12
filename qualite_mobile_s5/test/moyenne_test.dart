import 'package:flutter_test/flutter_test.dart';
import 'package:qualite_mobile_s5/main.dart';

void main() {
  group('calcul de la moyenne des étudiants', () {
    test('retourne la bonne moyenne pour un cas simple', () {
      final etudiants = [
        Etudiant(nom: 'Alice', moyenne: 12.0),
        Etudiant(nom: 'Bob', moyenne: 14.0),
      ];

      expect(calculerMoyenne(etudiants), 13.0);
    });

    test('retourne la bonne moyenne pour un cas plus varié', () {
      final etudiants = [
        Etudiant(nom: 'Alice', moyenne: 17.25),
        Etudiant(nom: 'Bob', moyenne: 16.5),
        Etudiant(nom: 'Charlie', moyenne: 11.75),
        Etudiant(nom: 'David', moyenne: 12.75),
        Etudiant(nom: 'Eve', moyenne: 13.5),
      ];

      expect(calculerMoyenne(etudiants), 14.35);
    });
  });
}
