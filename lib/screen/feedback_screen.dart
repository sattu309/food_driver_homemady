import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../controller/get_feedback_controller.dart';
import '../widgets/custome_size.dart';
import '../widgets/custome_textfiled.dart';
import '../widgets/dimenestion.dart';


class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({Key? key}) : super(key: key);
  static var feedBackScreen = "/feedBackScreen";
  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  final controller = Get.put(GetFeedbackController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getData();
  }
  double fullRating = 0;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: Scaffold(
          appBar: backAppBar(title: 'Feedback', context: context),
          body: controller.isDataLoading.value ?
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(controller.model.value.data!.avgRating.toString(),style: const TextStyle(
                        color: Color(0xFF1B233A),
                        fontSize: 48,
                        fontWeight: FontWeight.w600,
                      ),),
                      addWidth(26),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RatingBar.builder(
                            initialRating: double.parse(controller.model.value.data!.avgRating.toString()),
                            minRating: 1,
                            unratedColor: const Color(0xFFECE3D0),
                            itemCount: 7,
                            itemSize: 16.0,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                            updateOnDrag: false,
                            tapOnlyMode: false,
                            ignoreGestures: true,
                            allowHalfRating: true,
                            itemBuilder: (context, index) =>
                                Image.asset('assets/images/star.png',
                                  color: Colors.amber,
                                ),
                            onRatingUpdate: (rating) {
                              log(rating.toString());
                            },
                          ),
                          addHeight(3),
                          Padding(
                            padding:  const EdgeInsets.symmetric(horizontal: 4.0),
                            child:  Text('based on ${controller.model.value.data!.reviewsCount.toString()} reviews',style: const TextStyle(
                              color: Color(0xFF969AA3),
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),),
                          ),
                        ],
                      ),
                    ],
                  ),
                  addHeight(15),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Delivery',style: TextStyle(
                            color: Color(0xFF969AA3),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),),
                          Expanded(
                            child: LinearPercentIndicator(
                              lineHeight: 6.0,
                              barRadius: const Radius.circular(16),
                              backgroundColor: const Color(0xFFFAE9E4),
                              animation: true,
                              progressColor: const Color(0xFFA4D131),
                              percent: double.parse(controller.model.value.data!.totalReviews![4].avg.toString()) / 10,
                              animationDuration: 1200,
                            ),
                          ),
                        ],
                      ),
                      /* addHeight(4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(controller.model.value.data!.totalReviews![4].title.toString(),style: const TextStyle(
                            color: Color(0xFF969AA3),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),),
                          Expanded(
                            child: LinearPercentIndicator(
                              lineHeight: 6.0,
                              barRadius: const Radius.circular(16),
                              backgroundColor: const Color(0xFFFAE9E4),
                              animation: true,
                              progressColor: const Color(0xFFEE3D1C),
                              percent:  double.parse(controller.model.value.data!.totalReviews![4].avg.toString()) / 10,
                              animationDuration: 1200,
                            ),
                          ),
                        ],
                      ),*/
                    ],
                  ),
                  addHeight(20),
                  const Divider(
                    height: 1,
                    thickness: 1.5,
                    color: Color(0xFFE8F2EC),
                  ),
                  addHeight(20),
                  controller.model.value.data!.reviewsList!.isNotEmpty ?
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.model.value.data!.reviewsList!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(borderRadius: BorderRadius.circular(50) ,
                                child: CachedNetworkImage(
                                  imageUrl: controller.model.value.data!.reviewsList![index].profileImage.toString(),
                                  fit: BoxFit.cover,
                                  width: 50,
                                  height: 50,
                                  errorWidget: (_, __, ___) => Image.asset(
                                    'assets/images/Ellipse 67.png',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                  placeholder: (_, __) =>
                                  const Center(child: CircularProgressIndicator(color: Color(0xff7ED957),)),
                                ),
                              ),
                              //Image.asset('assets/images/Ellipse 1563.png',height: 50,),
                              addWidth(20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:  const EdgeInsets.symmetric(horizontal: 5.0),
                                      child: Text(controller.model.value.data!.reviewsList![index].userName.toString(),
                                        style: const TextStyle(
                                          color: Color(0xFF1B233A),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),),
                                    ),
                                    addHeight(10),
                                    RatingBar.builder(
                                      initialRating: 4,
                                      minRating: 1,
                                      unratedColor: const Color(0xFFECE3D0),
                                      itemCount: 5,
                                      itemSize: 16.0,
                                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                      updateOnDrag: true,
                                      itemBuilder: (context, index) =>
                                          Image.asset('assets/images/star.png',
                                            color: Colors.amber,
                                          ),
                                      onRatingUpdate: (ratingvalue) {
                                        setState(() {
                                          fullRating = ratingvalue;
                                        });
                                      },
                                    ),
                                    addHeight(7),
                                    Padding(
                                      padding: const  EdgeInsets.symmetric(horizontal: 5.0),
                                      child: RichText(
                                        text:  TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: controller.model.value.data!.reviewsList![index].review.toString(),
                                                  style: const TextStyle(
                                                    color: Color(0xFF969AA3),
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w300,

                                                  )),
                                              const TextSpan(
                                                  text: 'read more',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w400,
                                                      color: Color(0xFF567DF4)))
                                            ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // const Spacer(),
                              Padding(
                                padding:  const EdgeInsets.symmetric(vertical: 3.0),
                                child:  Text(controller.model.value.data!.reviewsList![index].date.toString(),style: const TextStyle(
                                  color: Color(0xFF969AA3),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AddSize.size5,
                          ),
                          index != 2
                              ? const Divider()
                              : const SizedBox(),
                          SizedBox(
                            height: AddSize.size5,
                          ),
                        ],
                      );
                    },
                  ) : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('No FeedBack',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                    ],
                  ),
                ],
              ),
            ),
          ) : const Center(child: CircularProgressIndicator(color: Color(0xff7ED957),)),
        ),
      );
    });
  }
}
