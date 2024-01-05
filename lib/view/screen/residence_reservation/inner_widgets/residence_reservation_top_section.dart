import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/view/screen/home/home_model/home_model.dart';

class ResidenceReservationTopSection extends StatefulWidget {

  final List<Residence> residence;
  final int index;

  const ResidenceReservationTopSection({super.key, required this.residence, required this.index});

  @override
  State<ResidenceReservationTopSection> createState() => _ResidenceReservationTopSectionState();
}

class _ResidenceReservationTopSectionState extends State<ResidenceReservationTopSection> {

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
            itemCount: widget.residence[widget.index].photo?.length ?? 0,
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: 180,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: CachedNetworkImage(imageUrl: widget.residence[widget.index].photo?[index].publicFileUrl.toString()??"",fit: BoxFit.fill,),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.center,
          child: DotsIndicator(
            dotsCount: widget.residence[widget.index].photo?.length?? 0,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          widget.residence[widget.index].residenceName??"",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF333333),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
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
                                  text: '${widget.residence[widget.index].ratings??0}',
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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
                            text: '${widget.residence[widget.index].hourlyAmount??0}',
                            style: GoogleFonts.openSans(
                              color: const Color(0xFF333333),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: "/hr".tr,
                            style: GoogleFonts.raleway(
                              color: const Color(0xFF333333),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.right,
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
                            text: '${widget.residence[widget.index].dailyAmount}',
                            style: GoogleFonts.openSans(
                              color: const Color(0xFF333333),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: '/day'.tr,
                            style: GoogleFonts.raleway(
                              color: const Color(0xFF333333),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                        child: Text(widget.residence[widget.index].city??'',
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  alignment: Alignment.center,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE8EDE6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  child: Text(
                    "${widget.residence[widget.index].status}".toUpperCase(),
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
