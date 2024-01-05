import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/view/screen/booking_list/booking_list_model/booking_list_model.dart';

class BookingDetailsTopSection extends StatefulWidget {
  const BookingDetailsTopSection({super.key, required this.data});
  final Booking? data;

  @override
  State<BookingDetailsTopSection> createState() => _BookingDetailsTopSectionState();
}

class _BookingDetailsTopSectionState extends State<BookingDetailsTopSection> {
  int currentPosition = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            onPageChanged: (value) {
              setState(() {
                currentPosition = value;
              });
            },
            itemCount: widget.data?.residenceId?.photo?.length ?? 0,
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: 180,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: CachedNetworkImage(imageUrl: widget.data?.residenceId?.photo?[index].publicFileUrl.toString()??"",fit: BoxFit.fill,),
              );
            },
          ),
        ),
        const SizedBox(height: 10,),
        Align(
          alignment: Alignment.center,
          child: DotsIndicator(
            dotsCount: widget.data?.residenceId?.photo?.length?? 0,
            position: currentPosition,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          widget.data?.residenceId?.residenceName??"",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF333333),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Color(0xFFFBA91D), size: 18),
                          const SizedBox(width: 4),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '(',
                                  style: GoogleFonts.raleway(
                                    color: const Color(0xFF333333),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: '${widget.data?.residenceId?.ratings??0}',
                                  style: GoogleFonts.openSans(
                                    color: const Color(0xFF333333),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: ')',
                                  style: GoogleFonts.raleway(
                                    color: const Color(0xFF333333),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '\$',
                        style: GoogleFonts.raleway(
                          color: const Color(0xFF333333),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: '${widget.data?.residenceId?.hourlyAmount??100}',
                        style: GoogleFonts.openSans(
                          color: const Color(0xFF333333),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: "/5-hr".tr,
                        style: GoogleFonts.raleway(
                          color: const Color(0xFF333333),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.right,
                )
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      const Icon(Icons.place_outlined, color: Color(0xFF818181), size: 18),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          widget.data?.residenceId?.city??'',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF818181),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  alignment: Alignment.center,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE8EDE6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  child: Text(
                    "${widget.data?.residenceId?.status}".toUpperCase(),
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF6AA259),
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      height: 1.40,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
