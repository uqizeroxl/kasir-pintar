import 'package:flutter/material.dart';

class CashierDashboard extends StatelessWidget {
  const CashierDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cashier Dashboard'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Cashier Dashboard',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildDashboardCard(
                    context,
                    title: 'Products',
                    icon: Icons.inventory,
                    color: Colors.teal,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    title: 'Shopping Cart',
                    icon: Icons.shopping_basket,
                    color: Colors.orange,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    title: 'Checkout',
                    icon: Icons.payment,
                    color: Colors.blue,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    title: 'Transactions',
                    icon: Icons.history,
                    color: Colors.purple,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    title: 'Settings',
                    icon: Icons.settings,
                    color: Colors.grey,
                    onTap: () {
                      // TODO: Implement settings screen
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context,
      {required String title,
      required IconData icon,
      required Color color,
      required VoidCallback onTap}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: color,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}