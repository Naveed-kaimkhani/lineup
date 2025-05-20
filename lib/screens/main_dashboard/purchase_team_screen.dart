import 'package:flutter/material.dart';
import 'package:gaming_web_app/constants/widgets/custom_scaffold/dashboard_scaffold.dart';
import 'package:gaming_web_app/screens/main_dashboard/success_purchase_team_dialog.dart';

class PurchaseTeamScreen extends StatelessWidget {
  const PurchaseTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardScaffold(
      userImage: 'assets/images/dummy_image.png',
      userName: 'Test User',
      isShowBanner: false,
      body: PurchaseTeamWidget(),
    );
  }
}

class PurchaseTeamWidget extends StatelessWidget {
  const PurchaseTeamWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Left Side - Summary
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'PURCHASE YOUR',
                  style: TextStyle(fontSize: 30, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                const Text(
                  'TEAM',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF003366),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '\$250.00',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFB03A2E),
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 12),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: const [
                      _SummaryRow(label: 'Platform basics', amount: '\$86.00'),
                      _SummaryRow(label: 'Subtotal', amount: '\$86.00'),
                      _SummaryRow(label: 'Tax', amount: '\$5.00'),
                      Divider(),
                      _SummaryRow(label: 'Total due today', amount: '\$91.00'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 32),

          /// Right Side - Form
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'CONTACT INFORMATION',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB03A2E),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(hint: 'Email'),
                  const SizedBox(height: 24),

                  const Text(
                    'PAYMENT METHOD',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB03A2E),
                    ),
                  ),
                  const SizedBox(height: 8),

                  _buildTextField(
                    hint: 'Card Number',
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.credit_card, size: 16),
                        SizedBox(width: 8),
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(child: _buildTextField(hint: 'MM / YY')),
                      const SizedBox(width: 8),
                      Expanded(child: _buildTextField(hint: 'CVC')),
                    ],
                  ),

                  _buildTextField(hint: 'Cardholder name'),
                  _buildTextField(hint: 'Country or region'),
                  Row(
                    children: [
                      Expanded(child: _buildTextField(hint: 'City')),
                      const SizedBox(width: 8),
                      Expanded(child: _buildTextField(hint: 'Postal Code')),
                    ],
                  ),
                  _buildTextField(hint: 'State'),

                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFB03A2E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (_) => const SuccessPurchaseTeamDialog(),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Pay Now',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({required String hint, Widget? suffixIcon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFF6F6F6),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String amount;
  const _SummaryRow({required this.label, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
