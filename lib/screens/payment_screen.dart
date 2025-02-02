import 'package:flutter/material.dart';
import 'package:ice_cream_app/screens/thank.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        backgroundColor: Colors.pink[100],
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Payment Method",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Credit/Debit Card
            PaymentOption(
              icon: Icons.credit_card,
              title: "Credit/Debit Card",
              onTap: () {
                // TODO: Implement Card Payment
                print("Card Payment Selected");
              },
            ),
            const SizedBox(height: 15),

            // PayPal
            PaymentOption(
              icon: Icons.account_balance_wallet,
              title: "PayPal",
              onTap: () {
                // TODO: Implement PayPal
                print("PayPal Selected");
              },
            ),
            const SizedBox(height: 15),

            // Cash on Delivery
            PaymentOption(
              icon: Icons.attach_money,
              title: "Cash on Delivery",
              onTap: () {
                // TODO: Implement Cash Payment
                print("Cash on Delivery Selected");
              },
            ),
            const SizedBox(height: 40),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ThankYouPage()));

                  // TODO: Implement Payment Logic
                  print("Payment Processing...");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[100],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text(
                  "Proceed to Pay",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const PaymentOption({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 30, color: Colors.pink),
            SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
