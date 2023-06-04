import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import '../../components/build_search_item.dart';
import '../../components/custom_field.dart';
import '../../components/custom_text.dart';
import '../../controller/home/search_results_controller.dart';
import '../../helpers/constants.dart';


// ignore: must_be_immutable
class SearchResultsScreen extends GetWidget<SearchResultsController> {
  SearchResultsScreen({
    required this.city,
    required this.checkIn,
    required this.checkOut,
    required this.numPerson,
    required this.numRooms,
    Key? key,
  }) : super(key: key);
  String? city;
  final DateTime checkIn;
  final DateTime checkOut;
  final int? numPerson;
  final int? numRooms;
  final String patternOfDateTime = "d MMM";

  String get textOfSearchBox {
    city ??= "";
    return "${city!} ${DateFormat(patternOfDateTime).format(checkIn)} , ${DateFormat(patternOfDateTime).format(checkOut)}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const CustomText(
          text: "Hotels",
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(85),
                  child: CustomField(
                    enabled: false,
                    hint: textOfSearchBox,
                    fillColor: k_fieldGray,
                    radius: 85,
                    suffixIcon: Container(
                      margin: const EdgeInsets.all(10),
                      child: const CircleAvatar(
                        backgroundColor: k_primaryColor,
                        child: Icon(LineIcons.search, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GetBuilder<SearchResultsController>(
              builder: ((controller) {
                if (controller.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (controller.results.isEmpty) {
                  return const Center(
                    child: CustomText(
                      text: "Không tìm thấy được phòng nào",
                      maxLines: 2,
                      fontSize: 30,
                    ),
                  );
                }

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.separated(
                    itemCount: controller.results.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 20);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return BuildSearchItem(
                        model: controller.results[index],
                        checkIn: checkIn,
                        checkOut: checkOut,
                        numPerson: numPerson,
                        numRoom: numRooms,
                        city: city,
                        );
                    },
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
