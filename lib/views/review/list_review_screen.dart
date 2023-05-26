

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app_flutter/components/custom_text.dart';
import 'package:travel_app_flutter/controller/home/list_review_controller.dart';
import 'package:travel_app_flutter/helpers/main_user.dart';
import 'package:travel_app_flutter/models/user_model.dart';
import 'package:travel_app_flutter/views/home/review_screen.dart';

import '../../components/custom_button.dart';

class ListReviewScreen extends GetWidget<ListReviewByTypeController>
{
  final String idHotel;
  ListReviewScreen({Key? key,required this.idHotel}): super(key: key);
  
  UserModel userModel = MainUser.instance.model!;
  @override
  Widget build(BuildContext context)
  {
    return GetBuilder<ListReviewByTypeController>(
      builder: (controller)
      {
        return controller.isLoading ?  const Center(child: CircularProgressIndicator()) : 
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text("Review"),
            centerTitle: true,
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            width: Get.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: CustomText(text: 'Tổng số reviews: ${controller.listReview.length}',
                    fontSize: 28,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500,
                    ),
                    ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.listReview.length,
                    physics:   const NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index)
                    {
                      return SizedBox(
                        
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          child: Container(
                           
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primaryContainer,
                                width: 3.0,
                              ),
                             borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                         height: 50,
                                         width: 50,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primaryContainer
                                              .withOpacity(0.6),
                                          borderRadius: BorderRadius.circular(50.0),
                                        ),
                           
                                        child: const Icon(
                                          Icons.person_outline,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16.0),
                                    Expanded(
                                      flex: 8,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.listReview[index].name!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(fontWeight: FontWeight.w600,fontSize: 20),
                                          ),
                                       
                                          // Text(
                                          //   controller.listReview[index].date!,
                                          //   style: Theme.of(context).textTheme.titleMedium,
                                          // ),
                                          const SizedBox(height: 5.0),
                                          Text(
                                            controller.listReview[index].review!,
                                            style: Theme.of(context).textTheme.bodyMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    ),
                     const SizedBox(height: 20),
                CustomButton(
                  text: "Review",
                  onPressed: () =>Get.to(
                    () => ReviewScreen(id: "YRcEpseieaWWPC20mnUcmEFIw9N2", idHotel: idHotel)
                  )
                ),
                ],
              ),
            ),
          ),
        );
      }
      );
  }
}

