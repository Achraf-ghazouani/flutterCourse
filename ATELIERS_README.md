# Flutter Material 3 - Ateliers Pratiques

Ce projet contient deux ateliers pratiques pour apprendre Material Design 3 avec Flutter.

## Structure du Projet

```
lib/
├── main.dart           # Point d'entrée de l'application
├── atelier1.dart       # Page de profil utilisateur Material 3
└── atelier2.dart       # Liste de produits Material 3
```

## Atelier 1 : Page de profil utilisateur

Une page de profil complète avec Material Design 3 contenant :

✅ **Étape 1** : Photo de profil circulaire avec badge de vérification
- Stack pour superposer les éléments
- CircleAvatar avec dégradé
- Badge avec icône de vérification

✅ **Étape 2** : Nom et titre
- Typographie Material 3
- Couleurs cohérentes du ColorScheme

✅ **Étape 3** : Statistiques avec chips
- Fonction helper `_buildStatChip`
- Affichage responsive avec Wrap
- 3 statistiques : Abonnés, Projets, Expérience

✅ **Étape 4** : Section "À propos"
- Card Material 3 avec élévation 0
- Icône et titre
- Description personnelle

✅ **Étape 5** : Bouton flottant étendu
- FloatingActionButton.extended
- Icône + Label
- Position centrale en bas

## Atelier 2 : Liste de Produits

Une liste de produits avec cards Material 3 contenant :

✅ **Étape 1** : Liste des produits
- ListView.builder pour affichage dynamique
- 3 produits exemples

✅ **Étape 2** : Construction d'une carte produit
- Card Material 3
- Layout avec Row

✅ **Étape 3** : Image avec badge "NEW"
- Stack pour superposition
- Badge conditionnel (if product.isNew)
- Image avec NetworkImage

✅ **Étape 4** : Informations du produit
- Nom du produit
- Rating avec étoile
- Prix avec style Material 3

✅ **Étape 5** : Bouton d'action
- IconButton pour ajouter au panier
- Couleur primaire du thème

## Comment tester

### Tester l'Atelier 1 (Page de profil)
Dans `main.dart`, utilisez :
```dart
home: const ProfilePageM3(),
```

### Tester l'Atelier 2 (Liste de produits)
Dans `main.dart`, décommentez l'import et utilisez :
```dart
import 'atelier2.dart';
...
home: const ProductListPageM3(),
```

## Lancer l'application

```bash
flutter run
```

## Fonctionnalités Material 3

- ✨ `useMaterial3: true` activé
- 🎨 ColorScheme cohérent
- 📝 Typographie Material 3 (textTheme)
- 🎯 Formes arrondies modernes
- 🌈 Couleurs de surface adaptatives
- 📱 Design responsive

## Notes importantes

- Les images utilisent `picsum.photos` pour les exemples
- Tous les composants sont conformes aux guidelines Material Design 3
- Code commenté pour faciliter l'apprentissage
- Fonctions helper pour réutilisabilité
