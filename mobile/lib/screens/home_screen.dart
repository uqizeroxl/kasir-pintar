import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import 'shopping_cart_screen.dart';
import 'checkout_screen.dart';
import 'transaction_history_screen.dart';
import 'cashier_dashboard.dart';
import 'product_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _codeController = TextEditingController();
  List<Product> _cartItems = [];
  List<Product> _suggestions = [];
  bool _isLoading = false;
  
  // Sample product data - in a real app, this would come from an API
  final List<Product> _products = [
    Product(
      id: 1,
      name: 'Apple iPhone 15',
      sku: 'IPH15',
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
      sku: 'S24',
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
      sku: 'MBP16',
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
      sku: 'NAM24',
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
      sku: 'LV501',
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

  void _addToCart(Product product) {
    setState(() {
      _cartItems.add(product);
      _suggestions.clear();
      _codeController.clear();
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added ${product.name} to cart'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _searchProductByCode(String code) async {
    debugPrint('Searching for product code: $code');
    if (code.isEmpty) {
      setState(() {
        _suggestions.clear();
      });
      debugPrint('Code is empty, cleared suggestions');
      return;
    }
    
    setState(() {
      _isLoading = true;
    });
    
    try {
      // In a real app, this would call the actual API
      final results = await ApiService.searchProducts(code);
      debugPrint('Received ${results.length} suggestions');
      
      setState(() {
        _suggestions = results.map((json) => Product.fromJson(json)).toList();
        _isLoading = false;
      });
      debugPrint('Updated suggestions state, now showing ${_suggestions.length} items');
    } catch (e) {
      debugPrint('Error in _searchProductByCode: $e');
      setState(() {
        _isLoading = false;
        _suggestions.clear();
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error searching for products'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _onKeyPressed(String key) {
    if (key == 'C') {
      _codeController.clear();
      setState(() {
        _suggestions.clear();
      });
    } else if (key == 'Enter') {
      if (_suggestions.isNotEmpty) {
        _addToCart(_suggestions.first);
      } else {
        _searchProductByCode(_codeController.text);
      }
    } else {
      _codeController.text += key;
      _codeController.selection = TextSelection.fromPosition(
        TextPosition(offset: _codeController.text.length),
      );
      
      // Trigger search as user types
      _searchProductByCode(_codeController.text);
    }
  }

  double get _cartTotal {
    return _cartItems.fold(0.0, (sum, item) => sum + item.price);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Building HomeScreen, suggestions count: ${_suggestions.length}, isLoading: $_isLoading');
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('CashierX'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShoppingCartScreen(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Text(
                'CashierX',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Products'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductListScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_basket),
              title: const Text('Shopping Cart'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShoppingCartScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Checkout'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CheckoutScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Transaction History'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TransactionHistoryScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CashierDashboard(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement settings screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement logout functionality
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Product code input display
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: 'Enter Product Code',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _codeController.clear();
                    setState(() {
                      _suggestions.clear();
                    });
                  },
                ),
              ),
              onChanged: _searchProductByCode,
            ),
          ),
          
          // Suggestions list
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            )
          else
            Container(
              height: _suggestions.isEmpty ? 0 : 150,
              color: Colors.blue[50], // Add background color to make it visible
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _suggestions.isEmpty
                  ? const SizedBox.shrink()
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _suggestions.length,
                      itemBuilder: (context, index) {
                        debugPrint('Building suggestion item $index');
                        final product = _suggestions[index];
                        return Card(
                          margin: const EdgeInsets.only(right: 12.0),
                          child: InkWell(
                            onTap: () => _addToCart(product),
                            child: Container(
                              width: 150,
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    product.sku,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '\$${product.price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          
          // Calculator-style keypad
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      children: [
                        _buildKeypadButton('1'),
                        _buildKeypadButton('2'),
                        _buildKeypadButton('3'),
                        _buildKeypadButton('4'),
                        _buildKeypadButton('5'),
                        _buildKeypadButton('6'),
                        _buildKeypadButton('7'),
                        _buildKeypadButton('8'),
                        _buildKeypadButton('9'),
                        _buildKeypadButton('0'),
                        _buildKeypadButton('C'),
                        _buildKeypadButton('Enter'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Cart summary
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border(top: BorderSide(color: Colors.grey[300]!)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Items: ${_cartItems.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Total: \$${_cartTotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                ElevatedButton(
                  onPressed: _cartItems.isEmpty
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CheckoutScreen(),
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Checkout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeypadButton(String text) {
    return ElevatedButton(
      onPressed: () => _onKeyPressed(text),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(24),
        textStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(text),
    );
  }
}