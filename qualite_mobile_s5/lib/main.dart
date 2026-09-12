import 'package:flutter/material.dart';

void main() {
  runApp(const MonApplication());
}

class Etudiant {
  final String nom;
  final double moyenne;

  Etudiant({required this.nom, required this.moyenne});
}

class MonApplication extends StatelessWidget {
  const MonApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liste des étudiants',
      home: PageAccueil(),
      debugShowCheckedModeBanner: false,
      routes: {'/details': (context) => const DetailPage()},
    );
  }
}

double calculerMoyenne(List<Etudiant> etudiants) {
  if (etudiants.isEmpty) {
    return 0.0;
  }

  final total = etudiants.fold<double>(
    0.0,
    (sum, etudiant) => sum + etudiant.moyenne,
  );

  return total / etudiants.length;
}

class PageAccueil extends StatelessWidget {
  PageAccueil({super.key});

  final List<Etudiant> etudiants = [
    Etudiant(nom: 'Alice', moyenne: 17.25),
    Etudiant(nom: 'Bob', moyenne: 16.5),
    Etudiant(nom: 'Charlie', moyenne: 11.75),
    Etudiant(nom: 'David', moyenne: 12.75),
    Etudiant(nom: 'Eve', moyenne: 13.5),
  ];

  void moyenneAlertDialog(BuildContext context, double average) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Moyenne des étudiants'),
          content: Text('La moyenne des étudiants est : $average'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des étudiants'),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Liste des étudiants et de leurs moyennes :',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: etudiants.length,
                itemBuilder: (context, index) {
                  final etudiant = etudiants[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: Material(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0),
                      child: ListTile(
                        title: Text('Nom: ${etudiant.nom}'),
                        subtitle: Text('Moyenne : ${etudiant.moyenne}'),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/details',
                            arguments: etudiant,
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                final average = calculerMoyenne(etudiants);
                moyenneAlertDialog(context, average);
              },
              child: const Text('Calculer la moyenne de la classe'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final etudiant = ModalRoute.of(context)!.settings.arguments as Etudiant;

    return Scaffold(
      appBar: AppBar(title: const Text('Détails de l\'étudiant')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Nom de l\'étudiant : ${etudiant.nom}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Moyenne : ${etudiant.moyenne}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
