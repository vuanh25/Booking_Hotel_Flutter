import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app_flutter/models/reviews_model.dart';

enum PostResultState { idle, loading, success, failure }

class ReviewController extends GetxController {
  final reviewContent = ''.obs;
  ReviewModel? reviewModel;
  ReviewModel? get model => reviewModel;
  final String _message = '';
  String get message => _message;
 

  PostResultState? _postState = PostResultState.idle;
  PostResultState? get postState => _postState;
  bool isLoading = false;
  void setPostState(PostResultState newState) {
    _postState = newState;
  }

  Future<String?> getExistingReviewId() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('reviews')
        .doc("XOGm87VMIK0JJRv8AWTB")
        .collection("hotels")
        .where('id', isEqualTo: model?.id)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Trả về ID của review đã tồn tại nếu có
      return querySnapshot.docs[0].id;
    }

    // Trả về null nếu không tìm thấy review
    return null;
  }

   void saveReview() async {
    final content = reviewContent.value;
    final userId = model!.id;
 

    if (userId != null) {
      final existingReviewId = await getExistingReviewId();

      if (existingReviewId != null) {
        // Đã tồn tại bài review, chỉnh sửa nội dung
        await FirebaseFirestore.instance
            .collection('reviews')
            .doc("XOGm87VMIK0JJRv8AWTB")
            .collection('hotels')
            .doc(existingReviewId)
            .update({'content': content});
      } else {
        // Chưa tồn tại bài review, tạo mới
       addReviewToFirestore(model: model);
      }
    }
  }







  Future<void> addReviewToFirestore({ReviewModel? model}) async {
    try {
      isLoading = true;
      _postState = PostResultState.loading;
      final collectionRef = FirebaseFirestore.instance
          .collection('reviews')
          .doc("XOGm87VMIK0JJRv8AWTB")
          .collection("hotels");

      // Tạo một document mới với ID ngẫu nhiên
      final newDocRef = collectionRef.doc();

      // Ghi thông tin sản phẩm vào document mới
      await newDocRef.set({
        'idHotel': model?.idHotel,
        'id': model?.id,
        'name': model?.name,
        'review': model?.review,
      });
      _postState = PostResultState.success;
      // Get.closeAllSnackbars();
      Get.snackbar(
        "Cảm ơn bạn đã cho một đánh giá! Chúc một ngày tốt lành",
        "",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      );
      isLoading = false;
      update();
      print('Product added successfully!');
    } catch (e) {
      print('Error adding product: $e');
    }
  }
}
