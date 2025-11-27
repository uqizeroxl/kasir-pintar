import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  // Sample product data - in a real app, this would come from an API
  final List<Product> _products = [
    Product(
      id: 1,
      name: 'Apple iPhone 15',
      sku: 'IPH15-256GB',
      description: 'Latest Apple iPhone 15 with 256GB storage',
      price: 999.99,
      costPrice: 800.00,
      stockQuantity: 15,
      categoryId: 1,
      isActive: true,
      categoryName: 'Electronics',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Product(
      id: 2,
      name: 'Samsung Galaxy S24',
      sku: 'S24-512GB',
      description: 'Samsung Galaxy S24 with 512GB storage',
      price: 899.99,
      costPrice: 700.00,
      stockQuantity: 10,
      categoryId: 1,
      isActive: true,
      categoryName: 'Electronics',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Product(
      id: 3,
      name: 'MacBook Pro 16"',
      sku: 'MBP-16-M2',
      description: 'Apple MacBook Pro 16 inch with M2 chip',
      price: 2399.99,
      costPrice: 2000.00,
      stockQuantity: 5,
      categoryId: 1,
      isActive: true,
      categoryName: 'Electronics',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Product(
      id: 4,
      name: 'Nike Air Max',
      sku: 'NAM-2024-BLK',
      description: 'Nike Air Max 2024 Black Edition',
      price: 129.99,
      costPrice: 80.00,
      stockQuantity: 30,
      categoryId: 2,
      isActive: true,
      categoryName: 'Footwear',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Product(
      id: 5,
      name: 'Levi\'s Jeans',
      sku: 'LV-501-BLK-32',
      description: 'Levi\'s 501 Black Jeans Size 32',
      price: 79.99,
      costPrice: 45.00,
      stockQuantity: 20,
      categoryId: 3,
      isActive: true,
      categoryName: 'Clothing',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  final List<Product> _filteredProducts = [];
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _filteredProducts.addAll(_products);
  }

  void _filterProducts(String query) {
    setState(() {
      _filteredProducts.clear();
      if (query.isEmpty) {
        _filteredProducts.addAll(_products);
      } else {
        _filteredProducts.addAll(
          _products.where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()) ||
              product.sku.toLowerCase().contains(query.toLowerCase())),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: _filterProducts,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                final product = _filteredProducts[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.inventory,
                        color: Colors.grey[700],
                      ),
                    ),
                    title: Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.sku),
                        const SizedBox(height: 4),
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${product.stockQuantity} in stock',
                          style: TextStyle(
                            color: product.stockQuantity > 0
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        // TODO: Add to cart functionality
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Added ${product.name} to cart'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}