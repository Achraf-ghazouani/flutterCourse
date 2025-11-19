import 'package:flutter/material.dart';

// Modèle de données
class Product {
  final String name;
  final double price;
  final String image;
  final bool isNew;
  final double rating;
  final String description;
  final Map<String, String> specifications;

  const Product(
    this.name,
    this.price,
    this.image, {
    this.isNew = false,
    this.rating = 0.0,
    this.description = '',
    this.specifications = const {},
  });
}

class ProductListPageM3 extends StatefulWidget {
  const ProductListPageM3({super.key});

  @override
  State<ProductListPageM3> createState() => _ProductListPageM3State();
}

class _ProductListPageM3State extends State<ProductListPageM3> {
  final Set<int> _expandedIndices = {};
  final Map<Product, int> _cart = {};

  void _toggleExpanded(int index) {
    setState(() {
      if (_expandedIndices.contains(index)) {
        _expandedIndices.remove(index);
      } else {
        _expandedIndices.add(index);
      }
    });
  }

  void _addToCart(Product product) {
    setState(() {
      _cart[product] = (_cart[product] ?? 0) + 1;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} ajouté au panier'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  int get _totalItems {
    return _cart.values.fold(0, (sum, qty) => sum + qty);
  }

  double get _totalPrice {
    double total = 0;
    _cart.forEach((product, qty) {
      total += product.price * qty;
    });
    return total;
  }

  void _showCart() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Récapitulatif Panier',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ..._cart.entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${entry.key.name} x${entry.value}'),
                    Text(
                      '${(entry.key.price * entry.value).toStringAsFixed(2)}€',
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: $_totalItems article${_totalItems > 1 ? 's' : ''}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${_totalPrice.toStringAsFixed(2)}€',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Fermer'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const List<Product> products = [
    Product(
      'iPhone 15',
      999,
      'assets/images/iphone.png',
      isNew: true,
      rating: 4.5,
      description:
          'Découvrez le iPhone 15, un produit haute performance conçu pour répondre à tous vos besoins. Design élégant et fonctionnalités avancées.',
      specifications: {
        'Écran': '6.1 pouces Super Retina XDR',
        'Processeur': 'A16 Bionic',
        'Mémoire': '128 GB',
        'Batterie': "Jusqu'à 20h de vidéo",
      },
    ),
    Product(
      'Samsung Galaxy',
      799,
      'assets/images/galaxy.png',
      isNew: false,
      rating: 4.2,
      description:
          'Le Samsung Galaxy offre une expérience mobile exceptionnelle avec son écran AMOLED et ses performances optimales.',
      specifications: {
        'Écran': '6.4 pouces AMOLED',
        'Processeur': 'Snapdragon 8 Gen 2',
        'Mémoire': '256 GB',
        'Batterie': '5000 mAh',
      },
    ),
    Product(
      'Google Pixel',
      699,
      'assets/images/google.png',
      isNew: true,
      rating: 4.7,
      description:
          'Google Pixel combine intelligence artificielle et photographie pour créer des moments inoubliables.',
      specifications: {
        'Écran': '6.2 pouces OLED',
        'Processeur': 'Google Tensor G3',
        'Mémoire': '128 GB',
        'Batterie': '4800 mAh',
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nos Produits'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        actions: [
          if (_cart.isNotEmpty)
            Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: _showCart,
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      _totalItems.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          final isExpanded = _expandedIndices.contains(index);

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                InkWell(
                  onTap: () => _toggleExpanded(index),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image avec badge "Nouveau"
                        Stack(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey[200],
                                image: DecorationImage(
                                  image: AssetImage(product.image),
                                  fit: BoxFit.cover,
                                  onError: (exception, stackTrace) {},
                                ),
                              ),
                              child: product.image.isEmpty
                                  ? Icon(
                                      Icons.image,
                                      size: 30,
                                      color: Colors.grey[400],
                                    )
                                  : null,
                            ),
                            if (product.isNew)
                              Positioned(
                                top: 2,
                                left: 2,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'NEW',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(width: 12),

                        // Informations du produit
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber.shade600,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    product.rating.toString(),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${product.price.toStringAsFixed(2)}€',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Bouton d'action
                        Column(
                          children: [
                            IconButton(
                              onPressed: () => _addToCart(product),
                              icon: Icon(
                                Icons.add_shopping_cart,
                                color: colorScheme.primary,
                                size: 20,
                              ),
                            ),
                            Icon(
                              isExpanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              size: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Section expandable pour description et spécifications
                AnimatedCrossFade(
                  firstChild: const SizedBox.shrink(),
                  secondChild: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(),
                        const SizedBox(height: 8),
                        Text(
                          'Description',
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.description,
                          style: TextStyle(
                            color: colorScheme.onSurfaceVariant,
                            fontSize: 12,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Spécifications',
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        ...product.specifications.entries.map(
                          (spec) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  spec.key,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                Text(
                                  spec.value,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  crossFadeState: isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 300),
                ),
              ],
            ),
          );
        },
      ),

      // Bouton Panier en bas
      bottomNavigationBar: _cart.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                border: Border(
                  top: BorderSide(color: colorScheme.outlineVariant),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Articles: $_totalItems',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Total: ${_totalPrice.toStringAsFixed(2)}€',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    FilledButton.icon(
                      onPressed: _showCart,
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text('Panier'),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
