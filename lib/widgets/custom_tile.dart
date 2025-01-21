import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  const CustomTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.amber,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10)),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Chat with AI',
            style: TextStyle(fontSize: 20),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                  onPressed: () {}, child: const Text('Generate Now')))
        ],
      ),
    );
  }
}
