import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shipper_app/constants/colors.dart';
import 'package:shipper_app/constants/fontSize.dart';

class EwayBillDetailScreen extends StatelessWidget {
  final Map<String, dynamic> ewayBillData;

  const EwayBillDetailScreen({super.key, required this.ewayBillData});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final List<Map<String, String>> keysAndLabels = [
      {'key': 'ewbNo', 'label': 'E-way Bill no '},
      {'key': 'ewayBillDate', 'label': 'E-way Bill Date '},
      {'key': 'fromTrdName', 'label': 'Generated By '},
      {'key': 'ewayBillDate', 'label': 'Valid From '},
      {'key': 'validUpto', 'label': 'Valid Until '},
      {'key': 'fromGstin', 'label': 'GSTIN Of Supplier '},
      {'key': 'fromPlace', 'label': 'Place Of Dispatch '},
      {'key': 'toGstin', 'label': 'Gstin Of Recipient '},
      {'key': 'toPlace', 'label': 'Place of Delivery '},
      {'key': 'transactionType', 'label': 'Transaction Type '},
      {'key': 'itemListDetails.0.hsnCode', 'label': 'HSN Code '},
      {'key': 'transporterName', 'label': 'Transporter '},
      {'key': 'vehicleListDetails.0.updMode', 'label': 'Mode '},
      {'key': 'vehicleListDetails.0.vehicleNo', 'label': 'Vehicle No '},
      {'key': 'ewayBillDate', 'label': 'Entered Date '},
    ];

    dynamic getValue(String keyPath) {
      List<String> path = keyPath.split('.');
      dynamic value = ewayBillData;

      for (String part in path) {
        if (value is Map && value.containsKey(part)) {
          value = value[part];
        } else if (value is List && int.tryParse(part) != null) {
          int index = int.parse(part);
          if (index < value.length) {
            value = value[index];
          } else {
            return 'N/A';
          }
        } else {
          return 'N/A';
        }
      }

      if (keyPath == 'ewayBillDate' || keyPath == 'validUpto') {
        try {
          DateTime parsedDate =
              DateFormat("dd/MM/yyyy hh:mm:ss a").parse(value);
          return DateFormat("dd/MM/yyyy").format(parsedDate);
        } catch (e) {
          return 'Invalid Date';
        }
      }

      return value;
    }

    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: 70,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: screenWidth * 0.03,
                        color: darkBlueTextColor,
                      ),
                    ),
                    const SizedBox(width: 18),
                    Text(
                      'E-way Bill Details',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: screenWidth * 0.02,
                        color: darkBlueTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: keysAndLabels.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, String> item = entry.value;
                    String key = item['key']!;
                    String label = item['label']!;
                    dynamic value = getValue(key);
                    return value != null
                        ? Container(
                            height: screenHeight * 0.07,
                            margin: index == 5
                                ? EdgeInsets.only(bottom: screenHeight * 0.05)
                                : EdgeInsets.zero,
                            decoration: BoxDecoration(
                              border: Border(
                                top: index == 0 || index == 6
                                    ? BorderSide.none
                                    : const BorderSide(
                                        color: greyShade, width: 0.8),
                                bottom: index == 5 || index == 14
                                    ? BorderSide.none
                                    : const BorderSide(
                                        color: greyShade, width: 0.8),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: screenHeight * 0.08,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(
                                        left: screenWidth * 0.04),
                                    color: const Color.fromARGB(
                                        255, 236, 240, 255),
                                    child: Text('$label: ',
                                        style: GoogleFonts.montserrat(
                                          fontSize: size_8,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Container(
                                    height: screenHeight * 0.08,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(
                                        left: screenWidth * 0.035),
                                    decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        boxShadow: index == 5 || index == 14
                                            ? [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 0,
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 3),
                                                )
                                              ]
                                            : []),
                                    child: Text('$value',
                                        style: GoogleFonts.montserrat(
                                          fontSize: size_8,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink();
                  }).toList(),
                ),
              ),
            ),
          ])),
    );
  }
}
