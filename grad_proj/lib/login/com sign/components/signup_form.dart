import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import '../../../config.dart';
import 'card_alert_dialog.dart';
import 'card_input_formatter.dart';
import 'card_month_input_formatter.dart';
import 'master_card.dart';
import 'my_painter.dart';
import 'package:http/http.dart' as http;

class SignUpFormco extends StatefulWidget {
  const SignUpFormco({Key? key}) : super(key: key);

  @override
  State<SignUpFormco> createState() => _SignUpFormStateco();
}

class _SignUpFormStateco extends State<SignUpFormco> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderNameController =
      TextEditingController();
  final TextEditingController cardExpiryDateController =
      TextEditingController();
  final TextEditingController cardCvvController = TextEditingController();

  final FlipCardController flipCardController = FlipCardController();

  bool allFieldsFilled = false;

  void payment() async {
    if (cardNumberController.text.isEmpty ||
        cardHolderNameController.text.isEmpty ||
        cardExpiryDateController.text.isEmpty ||
        cardCvvController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الرجاء تعبئة جميع الحقول'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    String? cardNumber = cardNumberController.text;
    int? cardCvv = int.tryParse(cardCvvController.text);
    var regBody = {
      "CardNumber": cardNumber,
      "Name": cardHolderNameController.text,
      "date": cardExpiryDateController.text,
      "CVV": cardCvv
    };
    var response = await http.post(
      Uri.parse(pay),
      body: jsonEncode(regBody),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const SignUpFormco();
          },
        ),
      );
    }
  }

  void updateFieldsFilledStatus() {
    setState(() {
      allFieldsFilled = cardNumberController.text.isNotEmpty &&
          cardHolderNameController.text.isNotEmpty &&
          cardExpiryDateController.text.isNotEmpty &&
          cardCvvController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: 500,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  FlipCard(
                    fill: Fill.fillFront,
                    direction: FlipDirection.HORIZONTAL,
                    controller: flipCardController,
                    onFlip: () {},
                    flipOnTouch: false,
                    onFlipDone: (isFront) {},
                    front: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: buildCreditCard(
                        color: const Color(0xFF063970),
                        cardExpiration: cardExpiryDateController.text.isEmpty
                            ? "08/2022"
                            : cardExpiryDateController.text,
                        cardHolder: cardHolderNameController.text.isEmpty
                            ? "Card Holder"
                            : cardHolderNameController.text.toUpperCase(),
                        cardNumber: cardNumberController.text.isEmpty
                            ? "XXXX XXXX XXXX XXXX"
                            : cardNumberController.text,
                      ),
                    ),
                    back: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        elevation: 4.0,
                        color: const Color(0xFF063970),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Container(
                          height: 230,
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, bottom: 22.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(height: 0),
                              const Text(
                                'https://www.paypal.com',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 11,
                                ),
                              ),
                              Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width / 1.2,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              CustomPaint(
                                painter: MyPainter(),
                                child: SizedBox(
                                  height: 35,
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        cardCvvController.text.isEmpty
                                            ? "322"
                                            : cardCvvController.text,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 21,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 11,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width / 1.12,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      controller: cardNumberController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        hintText: 'Card Number',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        prefixIcon: Icon(
                          Icons.credit_card,
                          color: Colors.grey,
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(16),
                        CardInputFormatter(),
                      ],
                      onChanged: (value) {
                        var text = value.replaceAll(RegExp(r'\s+\b|\b\s'), ' ');
                        setState(() {
                          cardNumberController.value =
                              cardNumberController.value.copyWith(
                                  text: text,
                                  selection: TextSelection.collapsed(
                                      offset: text.length),
                                  composing: TextRange.empty);
                        });
                        updateFieldsFilledStatus();
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width / 1.12,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      controller: cardHolderNameController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        hintText: 'Full Name',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          cardHolderNameController.value =
                              cardHolderNameController.value.copyWith(
                                  text: value,
                                  selection: TextSelection.collapsed(
                                      offset: value.length),
                                  composing: TextRange.empty);
                        });
                        updateFieldsFilledStatus();
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width / 2.4,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      controller: cardExpiryDateController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        hintText: 'MM/YY',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          color: Colors.grey,
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                        CardDateInputFormatter(),
                      ],
                      onChanged: (value) {
                        var text = value.replaceAll(RegExp(r'\s+\b|\b\s'), ' ');
                        setState(() {
                          cardExpiryDateController.value =
                              cardExpiryDateController.value.copyWith(
                                  text: text,
                                  selection: TextSelection.collapsed(
                                      offset: text.length),
                                  composing: TextRange.empty);
                        });
                        updateFieldsFilledStatus();
                      },
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width / 2.4,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      controller: cardCvvController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        hintText: 'CVV',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      onTap: () {
                        setState(() {
                          Future.delayed(const Duration(milliseconds: 300), () {
                            flipCardController.toggleCard();
                          });
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          int length = value.length;
                          if (length == 4 || length == 9 || length == 14) {
                            cardNumberController.text = '$value ';
                            cardNumberController.selection =
                                TextSelection.fromPosition(
                                    TextPosition(offset: value.length + 1));
                          }
                        });
                        updateFieldsFilledStatus();
                      },
                    ),
                  ),
                  const SizedBox(height: 20 * 3),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: allFieldsFilled
                          ? const Color(0xFF063970)
                          : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      minimumSize:
                          Size(MediaQuery.of(context).size.width / 1.12, 55),
                    ),
                    onPressed: allFieldsFilled
                        ? () {
                            Future.delayed(const Duration(milliseconds: 300),
                                () {
                              payment();
                              showDialog(
                                  context: context,
                                  builder: (context) =>
                                      const CardAlertDialog());
                              cardCvvController.clear();
                              cardExpiryDateController.clear();
                              cardHolderNameController.clear();
                              cardNumberController.clear();
                              flipCardController.toggleCard();
                            });
                          }
                        : null,
                    child: Text(
                      'Add Card'.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
