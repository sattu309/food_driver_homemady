import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady_drivers/routers/routers.dart';
import 'package:homemady_drivers/widgets/custome_textfiled.dart';

import '../widgets/custome_size.dart';
import '../widgets/dimenestion.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          elevation: 1.7,
          shadowColor: Colors.grey.shade300,
          titleSpacing: 30,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: const Icon(Icons.arrow_back,color: Colors.black,),
          ),
          leadingWidth: AddSize.size40 * 0.9,
          title: const Text( 'Chat',
            style:TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: Color(0xFF1A2E33)
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      offset: const Offset(.1, .1,
                      ),
                      blurRadius: 14.0,
                      spreadRadius: 0.5,
                    ),
                  ],
                ),
                child: CommonTextFieldWidgetSearch(
                  hint: 'Search',
                  onTap: (){},
                  prefix: IconButton(
                    onPressed: (){},
                    icon: Image.asset('assets/images/search-normal.png',height: 20,),
                  ),
                  suffix: IconButton(
                    onPressed: (){},
                    icon: Image.asset('assets/images/filter_icon.png',height: 25,),
                  ),
                ),
              ),
              addHeight(15),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(MyRouters.chatMessageScreen);
                    },
                    child: Column(
                      children: [
                        Slidable(
                            endActionPane: ActionPane(
                              motion: const BehindMotion(),
                              extentRatio: 1/5,
                              children: [
                                CustomSlidableAction(
                                  onPressed: (context) {},
                                  backgroundColor: const Color(0xFFF1B83F).withOpacity(0.20),
                                  borderRadius: BorderRadius.circular(10),
                                  foregroundColor: const Color(0xFFEF5360),
                                  child: Image.asset('assets/images/trash.png',height: 24,),

                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ClipOval(child: Image.asset('assets/images/IMG_6897.png',height: 50,)),
                                  addWidth(10),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text('Prateek Saini',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: const Color(0xFF3D4260)
                                          ),),
                                        addHeight(3),
                                        Text('Of course, what can I help you...',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: const Color(0xFF486769).withOpacity(0.70)
                                          ),
                                          overflow: TextOverflow.ellipsis,

                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('2 min ago',
                                        style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: const Color(0xFFFF784D)
                                        ),),
                                      addHeight(3),
                                      Container(
                                        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFF6FA141)
                                        ),
                                        child: Text(
                                          '3',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: Colors.white
                                          ),
                                        ),
                                      )
                                    ],
                                  ),

                                ],
                              ),
                            )
                        ),
                        addHeight(10)
                      ],
                    ),
                  );
                },
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(MyRouters.chatMessageScreen);
                    },
                    child: Column(
                      children: [
                        Slidable(
                            endActionPane: ActionPane(
                              motion: const BehindMotion(),
                              extentRatio: 1/5,
                              children: [
                                CustomSlidableAction(
                                  onPressed: (context) {},
                                  backgroundColor: const Color(0xFFF1B83F).withOpacity(0.20),
                                  borderRadius: BorderRadius.circular(10),
                                  foregroundColor: const Color(0xFFEF5360),
                                  child: Image.asset('assets/images/trash.png',height: 24,),

                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipOval(child: Image.asset('assets/images/IMG_6896.png',height: 50,)),
                                  addWidth(10),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text('Prateek Saini',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: const Color(0xFF3D4260)
                                          ),),
                                        addHeight(3),
                                        Text('Of course, what can I help you...',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: const Color(0xFF486769).withOpacity(0.70)
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('Yesterday',
                                        style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: const Color(0xFF7F8790)
                                        ),),
                                      addHeight(14),
                                    Image.asset('assets/images/Layer 2.png',height: 11,)
                                    ],
                                  ),

                                ],
                              ),
                            )
                        ),
                        addHeight(10)
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
