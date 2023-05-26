import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app_flutter/controller/home/list_review_controller.dart';
import 'package:travel_app_flutter/models/reviews_model.dart';
import 'package:travel_app_flutter/views/review/list_review_screen.dart';

import '../../controller/home/review_controller.dart';
import '../../helpers/main_user.dart';
import '../../models/user_model.dart';

class ReviewScreen extends GetWidget<ReviewController> {
  final String idHotel;
  final String id;
  const ReviewScreen({Key? key, required this.id,required this.idHotel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController reviewController = TextEditingController();
    
    ReviewModel reviewModel = ReviewModel();
    UserModel userModel = MainUser.instance.model!;
    nameController.text = userModel.name.toString();

    Widget _buildForm() {
      return Container(
        margin: const EdgeInsets.all(24.0),
        child: Column(children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
               
                  enabled: false,
                  controller: nameController,
                  textAlignVertical: TextAlignVertical.center,
                  showCursor: true,
                  cursorColor: Theme.of(context).iconTheme.color,
                  decoration: InputDecoration(
                  //  hintText: 'Tên của bạn',
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.all(16.0),
                    filled: true,
                    fillColor: Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.8),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tên không được để trống';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  onChanged: (value) => controller.reviewContent.value = value,
                  controller: reviewController,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  textAlign: TextAlign.justify,
                  showCursor: true,
                  cursorColor: Theme.of(context).iconTheme.color,
                  decoration: InputDecoration(
                    hintText: 'Hãy nêu cảm nhận của bạn về khách sạn',
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.all(16.0),
                    filled: true,
                    fillColor: Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.8),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Không được để trống';
                    }
                    return null;
                  },
                ),
              ],
            ),
          )
        ]),
      );
    }

    Widget _buildContent(BuildContext context) {
      return GetBuilder<ReviewController>(builder: (controller) {
        switch (controller.postState) {
          case PostResultState.idle:
            return _buildForm();
          case PostResultState.loading:
            return const Center(child: CircularProgressIndicator());
          case PostResultState.success:
          case PostResultState.failure:
          default:
            return const SizedBox();
        }
      });
    }

    return GetBuilder<ReviewController>(builder: (controller) {
      return controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Scaffold(
            resizeToAvoidBottomInset: false,
           appBar: PreferredSize(
        preferredSize: const Size.fromHeight(96.0),
        child: AppBar(
          elevation: 0.0,
          titleSpacing: 24.0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          toolbarHeight: 96.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 24.0,
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withOpacity(0.6),
                child: IconButton(
                  splashRadius: 4.0,
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.arrow_back),
                  color: Theme.of(context).primaryIconTheme.color,
                  onPressed: () {
                 
                    Get.back();
                  },
                ),
              ),
              Text(
                'Đánh giá của bạn',
                style: Theme.of(context).appBarTheme.toolbarTextStyle,
              ),
              IconButton(
                splashRadius: 24.0,
                splashColor: Colors.grey[200],
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.send),
                color: Theme.of(context).iconTheme.color,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    reviewModel.idHotel = idHotel;
                    reviewModel.id = userModel.uId;
                    reviewModel.name = nameController.text;
                    reviewModel.review = reviewController.text;
                    controller.addReviewToFirestore(
                      model: reviewModel,
                    );
                    Get.to(ListReviewScreen(idHotel: idHotel));
                    Get.find<ListReviewByTypeController>().searching(idHotel: idHotel);
                  }
                },
              ),
            ],
          ),
        ),
      ),
          body: SafeArea(child: _buildContent(context)));
         
    });
  }
}
