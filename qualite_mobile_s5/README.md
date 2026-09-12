# qualite_mobile_s5

## Diagnostic complet des erreurs observées

Avant toute modification, le projet a été analysé avec Flutter pour identifier les erreurs exactes. La première observation a été que le fichier principal contenait plusieurs erreurs de syntaxe et de structure. Les messages remontés par le compilateur ont été les suivants.

### 1. Paramètres inexistants dans le widget

Flutter a affiché :

- `The named parameter 'mainAxisAlignment' isn't defined`
- `The named parameter 'crossAxisAlignment' isn't defined`
- `The named parameter 'children' isn't defined`

Ces erreurs signifiaient que le widget n’était pas construit correctement. `Padding` et les autres éléments de la page n’avaient pas la bonne structure. Le compilateur ne reconnaissait pas les paramètres utilisés, car ils n’étaient pas associés au bon widget ou à la bonne hiérarchie.

### 2. Chaîne de caractères mal fermée

Flutter a aussi signalé :

- `Unterminated string literal`
- `Expected to find ','`
- `Expected to find ')'`
- `Expected ';' after this.`
- `Error: String starting with ' must end with '`

La ligne concernée était :

```dart
child: Text('Calculer la moyenne de la classe’),
```

Le problème venait du fait que l’apostrophe utilisée était incorrecte. La chaîne de caractères commençait avec `'` mais se terminait avec un autre caractère typographique `’`, ce qui empêchait Dart de l’interpréter correctement. Une fois cette erreur introduite, le compilateur a produit une cascade d’erreurs supplémentaires parce qu’il n’arrivait plus à analyser correctement le reste du code.

### 3. Bouton `ElevatedButton` mal défini

Les erreurs suivantes ont ensuite été observées :

- `The named parameter 'onPressed' is required, but there's no corresponding argument`
- `The named parameter 'onPressed' isn't defined`
- `Required named parameter 'onPressed' must be provided`

Cela montrait que le bouton était écrit avec une syntaxe invalide. En Flutter, un `ElevatedButton` doit contenir un `onPressed` et un `child` correctement définis. Comme la chaîne de caractères précédente était cassée, le compilateur n’arrivait pas à lire le reste de l’instruction du bouton.

### 4. Erreurs de syntaxe en cascade

Flutter a ensuite remonté :

- `Expected to find ')'`
- `Expected to find ';'`
- `Expected an identifier`
- `Unexpected token ';'`
- `Expected an identifier, but got ')'`

Ces messages ne sont pas des problèmes différents, mais des conséquences de la même erreur initiale. Lorsque le compilateur rencontre une chaîne ouverte ou une parenthèse mal fermée, il n’arrive plus à déterminer la fin de l’instruction, et il génère ensuite des erreurs secondaires sur plusieurs lignes.

### 5. Warning `Dead code`

Flutter a aussi signalé :

- `Dead code. Try removing the code, or fixing the code before it so that it can be reached`

Cela signifie qu’une partie du code ne pourra jamais être exécutée car la syntaxe précédente empêche le compilateur d’atteindre cette zone. C’est une erreur logique de structure, causée par l’échec de l’analyse du code précédent.

### 6. Warning `unused local variable`

Dans la méthode de calcul de moyenne, il y avait une variable locale déclarée dans la boucle :

```dart
var total = 0;
```

Ce code a généré :

- `The value of the local variable 'total' isn't used`

Le vrai problème venait du fait que cette variable masquait la variable `total` déclarée auparavant. En plus de cela, le calcul faisait une conversion incorrecte de `double` vers `int`, ce qui ne correspondait pas à la logique d’une moyenne.

### 7. Test widget non compatible avec l’application

Le test existant appelait encore un ancien point d’entrée :

- `The name 'MyApp' isn't a class`
- `Couldn't find constructor 'MyApp'`

Cela montrait que le test n’était plus aligné avec le code réel du projet. Le test utilisait une classe qui n’existait pas dans l’application actuelle, donc il échouait avant même de démarrer le comportement attendu.

### 8. Assertion Material sur le `ListTile`

Après correction de plusieurs erreurs de syntaxe, une autre erreur Flutter a été détectée :

- `ListTile background color or ink splashes may be invisible.`

La raison était que le `ListTile` était placé dans un `DecoratedBox` avec une couleur de fond, alors que Flutter exige qu’un `ListTile` soit dans un `Material` pour que son fond et ses effets de pression soient visibles correctement. Le correctif a consisté à entourer le `ListTile` dans un `Material` avec la couleur souhaitée.

La bonne structure est la suivante :

```dart
return Padding(
  padding: const EdgeInsets.only(bottom: 12.0),
  child: Material(
    color: Colors.grey[200],
    borderRadius: BorderRadius.circular(10.0),
    child: ListTile(
      title: Text('Nom: ${etudiant.nom}'),
      subtitle: Text('Moyenne : ${etudiant.moyenne}'),
      onTap: () {
        Navigator.pushNamed(context, '/details', arguments: etudiant);
      },
    ),
  ),
);
```

L’important est de comprendre que l’espacement ne doit pas être appliqué sur le `DecoratedBox` ou directement autour du `ListTile` sans `Material`. L’espace est placé avec `Padding` ou `Container(margin: ...)`, tandis que la couleur et le fond sont gérés par le `Material`.

### 9. Cause racine globale

La cause racine était donc multiple, mais globale :

- la page d’accueil était mal écrite
- la syntaxe Dart était invalide
- le bouton et le texte étaient mal fermés
- le calcul de moyenne était incohérent
- le test ne correspondait plus au code actuel
- le rendu des éléments de liste ne respectait pas les règles Material de Flutter

Dans l’ensemble, le projet était dans un état où il ne compilait pas correctement et n’était pas cohérent avec les règles de Flutter.

## Actions effectuées

Pour corriger le projet, j’ai appliqué les actions suivantes :

1. réécriture du point d’entrée de l’application avec un `MonApplication` correct
2. reconstruction de la page `PageAccueil` avec une structure Flutter valide
3. correction du calcul de moyenne
4. correction du `ElevatedButton` et du texte affiché
5. correction de la navigation vers la page de détail
6. correction du rendu des éléments de la liste pour respecter les règles de `Material`
7. adaptation du test widget afin qu’il vérifie le vrai comportement attendu de l’application

## Vérification finale

Le projet a ensuite été vérifié avec la commande suivante :

```bash
flutter test test/widget_test.dart
```

Résultat obtenu :

- 1 test exécuté
- All tests passed!

## Réflexion sur la sobriété et l’impact environnemental

La qualité logicielle ne se limite pas à la bonne exécution du code. Il faut aussi réfléchir à la sobriété de l’application, à son utilité réelle et à son impact environnemental.

### 1. Éléments qui peuvent être allégés ou simplifiés

Dans cette application, plusieurs éléments peuvent être rendus plus simples et plus légers :

- supprimer les éléments visuels inutiles dans la liste, comme des bordures ou des effets trop lourds
- garder seulement les informations essentielles dans chaque carte d’étudiant : nom et moyenne
- éviter les widgets trop complexes quand un simple `ListTile` suffit
- limiter les animations et les effets graphiques qui ne sont pas nécessaires à l’usage principal
- garder le code simple et direct, sans fonctions ou blocs redondants
- éviter des dépendances ou des bibliothèques non utilisées
- réduire la quantité de texte, de couleurs et d’espaces superflus dans l’interface


### 2. Où sont appliquées les animations ?

Les animations observées sont surtout celles que Flutter applique automatiquement :

- effet de ripple au clic sur les éléments `ListTile`
- transition native lors de la navigation avec `Navigator.pushNamed(...)`
- animation d’ouverture de la boîte de dialogue avec `showDialog(...)`

Cela montre que l’application reste sobre, car elle n’utilise pas de mécanismes d’animation lourds ni surchargés pour un projet de cette taille.

### 3. Impact d’une interface plus sobre et d’un code plus propre

Une interface sobre présente plusieurs bénéfices :

- moins de consommation de ressources côté mobile
- meilleure fluidité et réactivité
- moins de charge CPU et mémoire
- code plus lisible, plus facile à maintenir et à modifier
- réduction du risque de bugs et d’erreurs de logique

Un code propre aide aussi à éviter les surconstructions inutiles, les recalculs répétitifs et les widgets trop complexes. Cela améliore à la fois la performance et la qualité du projet.

### 4. Outils et méthodes de vérification environnementale

Si un écran web, une landing page ou une page de présentation était disponible, il serait utile de tester son impact avec des outils comme :

- GreenIT Analysis
- EcoIndex.fr

Ces outils permettent d’évaluer la charge écologique d’une page en mesurant par exemple le poids des ressources, le nombre de requêtes ou la quantité de données téléchargées.

### 5. Pratiques de développement plus respectueuses de l’environnement

Voici au moins trois pratiques pertinentes :

1. limiter les dépendances inutiles et supprimer les bibliothèques non utilisées
2. éviter les reconstructions inutiles de widgets en gardant les interfaces simples et bien structurées
3. privilégier une interface claire, légère et peu surchargée pour réduire le nombre d’éléments affichés
4. garder le projet propre, bien organisé et maintenable afin de limiter la complexité et faciliter la correction des erreurs
5. utiliser des données légères, éviter les fichiers volumineux et éviter les images trop lourdes

## Fichiers de test créés et leur rôle

Le projet contient plusieurs fichiers de test pour vérifier différents niveaux de validation.

### 1. `test/moyenne_test.dart`

Ce fichier contient les tests unitaires. Il vérifie la logique isolée de calcul de moyenne, sans dépendre de l’interface.

Il sert à tester :

- un cas simple : moyenne de deux notes
- un cas plus varié : moyenne sur plusieurs étudiants

L’objectif est de valider la logique métier de manière fiable et rapide.

### 2. `test/widget_app_test.dart`

Ce fichier contient un test de widget. Il vérifie que l’interface affiche bien les éléments attendus :

- titre de l’application
- sous-titre de la page
- noms des étudiants dans la liste
- apparition de la boîte de dialogue après clic sur le bouton

Il permet de valider le comportement visuel et l’interaction avec les composants Flutter.Similaire au widget_test.dart

### 3. `test/integration_app_test.dart`

Ce fichier contient un test d’intégration. Il simule un scénario utilisateur complet :

- lancement de l’application
- ouverture de la liste
- clic sur un étudiant
- navigation vers la page de détails
- retour à la page principale
- clic sur le bouton de calcul de moyenne
- vérification de la fenêtre de dialogue

L’objectif est de valider la continuité entre les écrans et la cohérence du comportement global de l’application.

### 4. Pourquoi plusieurs types de tests ?

Chaque type de test a un rôle précis :

- les tests unitaires valident la logique pure
- les tests de widgets vérifient l’affichage et les interactions UI
- les tests d’intégration vérifient le parcours utilisateur complet

Cela permet d’avoir un projet plus fiable, plus robuste et plus facile à maintenir.

### 6. Conclusion sur la sobriété

Même une application simple peut être pensée de manière plus responsable. Un logiciel sobre est un logiciel plus lisible, plus performant, plus facile à maintenir et moins énergivore. Cela contribue à une meilleure qualité logicielle, à la fois technique et environnementale.
