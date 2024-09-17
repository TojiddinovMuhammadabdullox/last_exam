import 'package:flutter/material.dart';

class ObshiyCard extends StatelessWidget {
  const ObshiyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: 120,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.payment),
              Text("Total Salary"),
              SizedBox(height: 15),
              Text("\$ 1,289.38")
            ],
          ),
        ),
      ),
    );
  }
}
