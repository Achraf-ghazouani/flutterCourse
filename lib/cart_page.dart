import 'package:flutter/material.dart';
import 'atelier2.dart';

class CartPage extends StatefulWidget {
  final Map<Product, int> cart;
  final Function(Map<Product, int>) onCartUpdated;

  const CartPage({super.key, required this.cart, required this.onCartUpdated});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Map<Product, int> _cart;
  final _emailController = TextEditingController();
  final _cardController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cart = Map.from(widget.cart);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  void _updateQuantity(Product product, int delta) {
    setState(() {
      final currentQty = _cart[product] ?? 0;
      final newQty = currentQty + delta;

      if (newQty <= 0) {
        _cart.remove(product);
      } else {
        _cart[product] = newQty;
      }

      widget.onCartUpdated(_cart);
    });
  }

  void _removeItem(Product product) {
    setState(() {
      _cart.remove(product);
      widget.onCartUpdated(_cart);
    });
  }

  double get _subtotal {
    double total = 0;
    _cart.forEach((product, qty) {
      total += product.price * qty;
    });
    return total;
  }

  double get _deliveryFee => 8.0;

  double get _taxRate => 0.19; // 19% tax rate

  double get _taxes => _subtotal * _taxRate;

  double get _total => _subtotal + _deliveryFee + _taxes;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Récapitulatif du Panier'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: _cart.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Votre panier est vide',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Liste des produits dans le panier
                  Container(
                    color: Colors.white,
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: _cart.length,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final entry = _cart.entries.elementAt(index);
                        final product = entry.key;
                        final quantity = entry.value;

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image du produit
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
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
                              const SizedBox(width: 12),

                              // Détails du produit
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${product.price.toStringAsFixed(2)}DT',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 8),

                                    // Contrôles de quantité
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey[300]!,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              InkWell(
                                                onTap: () => _updateQuantity(
                                                  product,
                                                  -1,
                                                ),
                                                child: Container(
                                                  padding: const EdgeInsets.all(
                                                    8,
                                                  ),
                                                  child: const Icon(
                                                    Icons.remove,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                    ),
                                                child: Text(
                                                  quantity.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () =>
                                                    _updateQuantity(product, 1),
                                                child: Container(
                                                  padding: const EdgeInsets.all(
                                                    8,
                                                  ),
                                                  child: const Icon(
                                                    Icons.add,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // Prix total et bouton supprimer
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${(product.price * quantity).toStringAsFixed(2)}DT',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete_outline,
                                      color: Colors.grey[600],
                                    ),
                                    onPressed: () => _removeItem(product),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Résumé du panier
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildSummaryRow(
                          'Sous-total',
                          '${_subtotal.toStringAsFixed(2)}DT',
                        ),
                        const SizedBox(height: 12),
                        _buildSummaryRow(
                          'Frais de livraison',
                          '${_deliveryFee.toStringAsFixed(2)}DT',
                        ),
                        const SizedBox(height: 12),
                        _buildSummaryRow(
                          'Taxes',
                          '${_taxes.toStringAsFixed(2)}DT',
                        ),
                        const Divider(height: 24),
                        _buildSummaryRow(
                          'Total',
                          '${_total.toStringAsFixed(2)}DT',
                          isTotal: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Formulaire de paiement
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Champ Email
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon: const Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),

                        // Champ Numéro de carte
                        TextField(
                          controller: _cardController,
                          decoration: InputDecoration(
                            hintText: 'Numéro de carte (simulation)',
                            prefixIcon: const Icon(Icons.credit_card),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 24),

                        // Bouton de paiement
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Paiement de ${_total.toStringAsFixed(2)}DT traité avec succès!',
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Payer ${_total.toStringAsFixed(2)}DT',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.black : Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal ? Colors.deepPurple : Colors.black,
          ),
        ),
      ],
    );
  }
}
