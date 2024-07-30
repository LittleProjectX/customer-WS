import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waroengsederhana/colors.dart';

class PayTransfer extends StatelessWidget {
  final String bank;
  final String number;
  final String name;

  const PayTransfer({
    super.key,
    required this.bank,
    required this.number,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //isi
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                height: 60,
                child: Image.asset(
                  'assets/images/$bank.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
              Text(
                number,
                style: const TextStyle(
                    fontSize: 18, height: 1, fontWeight: FontWeight.bold),
              ),
              Text('An. $name')
            ],
          ),
          //salin
          SizedBox(
              width: 120,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: tabColor),
                  onPressed: () {
                    _copyToClipboard(number, context);
                  },
                  child: const Text(
                    'Salin',
                    style: TextStyle(color: whiteColor),
                  )))
        ],
      ),
    );
  }
}

void _copyToClipboard(String text, BuildContext context) {
  Clipboard.setData(ClipboardData(text: text));
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Text copied to clipboard'),
    ),
  );
}
