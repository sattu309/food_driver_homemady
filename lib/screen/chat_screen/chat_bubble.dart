import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:homemady_drivers/widgets/helper.dart';
import 'package:intl/intl.dart';
import '../../../widgets/app_theme.dart';
import '../../widgets/dimenestion.dart';

class ChatBubble extends StatefulWidget {
  final bool isMe;
  final String message;
  final String messageType;
  final DateTime? sentTime;
  final DateTime? highlightTime;
  final bool? messageSeen;

  const ChatBubble(
      {Key? key,
      required this.isMe,
      required this.message,
      required this.sentTime,
      this.highlightTime,
      this.messageSeen, required this. messageType})
      : super(key: key);

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  final DateFormat dateFormat1 = DateFormat("hh:mm a");

  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: double.maxFinite,
      // color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.highlightTime != null)
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.highlightTime!.isCurrentData ? "Today" : dateFormat.format(widget.highlightTime!)),
              ),
            ),
          Row(
            mainAxisAlignment: widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                        children: [
                          widget.messageType == "simpleMessage"?
                          Flexible(
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [BoxShadow(spreadRadius: 1, blurRadius: 15, color: Colors.grey.shade300)],
                                color: widget.isMe ? const Color(0xFF7ED957) : Colors.white,
                                // color:  Color(0xFF7ED957),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12).copyWith(top: 8),
                              child: Column(
                                crossAxisAlignment: widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                // mainAxisAlignment: widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.end,
                                children: [
                                  Text(widget.message,
                                      style: TextStyle(
                                          fontSize: AddSize.font16,
                                          fontWeight: FontWeight.w400,
                                          color: widget.isMe ? Colors.white : const Color(0xff3D4260))),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.end,
                                    children: [
                                      if (widget.sentTime != null)
                                        Flexible(
                                          child: Text(dateFormat1.format(widget.sentTime!),
                                              style: TextStyle(
                                                  fontSize: AddSize.font12,
                                                  fontWeight: FontWeight.w500,
                                                  color: widget.isMe ? Colors.white : const Color(0xffAAAFB5))),
                                        ),
                                      if (widget.isMe == true) ...[
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Icon(
                                          Icons.done_all_outlined,
                                          size: 16,
                                          color: widget.messageSeen! ? AppTheme.primaryColor : Colors.white,
                                        )
                                      ]
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ):
                          Flexible(
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [BoxShadow(spreadRadius: 1, blurRadius: 15, color: Colors.grey.shade300)],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12).copyWith(top: 8),
                              child:GestureDetector(
                                  onTap: () {
                                    // showDialogue();
                                  },
                                  child: SizedBox(
                                    // width: 100,
                                    // height: 100,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: widget.message,
                                        fit: BoxFit.cover,
                                        errorWidget: (_, __, ___) => const SizedBox(),
                                        placeholder: (_, __) => const SizedBox(),
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                          // Flexible(
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       boxShadow: [BoxShadow(spreadRadius: 1, blurRadius: 15, color: Colors.grey.shade300)],
                          //       color: widget.isMe ? Colors.white:const Color(0xFF7ED957),
                          //       // color:  Color(0xFF7ED957),
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12).copyWith(top: 8),
                          //     child: Column(
                          //       crossAxisAlignment: widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          //       // mainAxisAlignment: widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.end,
                          //       children: [
                          //         // Text(widget.message,
                          //         //     style: TextStyle(
                          //         //         fontSize: AddSize.font16,
                          //         //         fontWeight: FontWeight.w400,
                          //         //         color: widget.isMe ? Colors.white : Color(0xff3D4260))),
                          //         Image.network(widget.message),
                          //         Row(
                          //           mainAxisSize: MainAxisSize.min,
                          //           crossAxisAlignment: CrossAxisAlignment.end,
                          //           mainAxisAlignment: widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.end,
                          //           children: [
                          //             if (widget.sentTime != null)
                          //               Flexible(
                          //                 child: Text(dateFormat1.format(widget.sentTime!),
                          //                     style: TextStyle(
                          //                         fontSize: AddSize.font12,
                          //                         fontWeight: FontWeight.w500,
                          //                         color: widget.isMe ? Colors.white : Color(0xffAAAFB5))),
                          //               ),
                          //             if (widget.isMe == true) ...[
                          //               const SizedBox(
                          //                 width: 4,
                          //               ),
                          //               Icon(
                          //                 Icons.done_all_outlined,
                          //                 size: 16,
                          //                 color: widget.messageSeen! ? AppTheme.primaryColor : Colors.white,
                          //               )
                          //             ]
                          //           ],
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
