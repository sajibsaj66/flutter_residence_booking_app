import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/view/screen/booking_list/booking_list_model/booking_list_model.dart';

class CheckoutTopSection extends StatefulWidget {
  const CheckoutTopSection({super.key, required this.index, required this.bookingListModel});

  final int index;
  final BookingListModel bookingListModel;

  @override
  State<CheckoutTopSection> createState() => _CheckoutTopSectionState();
}

class _CheckoutTopSectionState extends State<CheckoutTopSection> {
  @override
  Widget build(BuildContext context) {
    int currentPosition = 0;
    final data = widget.bookingListModel.data!.attributes!.bookings;
    final String status = data?[widget.index].status??"";
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
            itemCount: data?[widget.index].residenceId?.photo?.length ?? 0,
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: 180,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: CachedNetworkImage(imageUrl: data?[widget.index].residenceId?.photo?[index].publicFileUrl.toString()??"",fit: BoxFit.fill,),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.center,
          child: DotsIndicator(
            dotsCount: data?[widget.index].residenceId?.photo?.length?? 0,
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
                          "${data?[widget.index].residenceId!.residenceName}",
                          maxLines: 1,overflow: TextOverflow.ellipsis,
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
                                  text: '${data?[widget.index].residenceId!.ratings}',
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
                const SizedBox(width: 24),
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
                        text: '${data?[widget.index].residenceId!.hourlyAmount}',
                        style: GoogleFonts.openSans(
                          color: const Color(0xFF333333),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: '/hr',
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
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      const Icon(Icons.place_outlined, color: Color(0xFF818181), size: 18),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          '${data?[widget.index].residenceId!.address}',
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
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  decoration: BoxDecoration(
                      color: status=="pending"? const Color(0xFFF2E1E3): const Color(0xFFE8EDE6),
                      borderRadius: BorderRadius.circular(4)
                  ),
                  child: Text(
                    '${data?[widget.index].status}'.toUpperCase(),
                    style: GoogleFonts.raleway(
                      color: status=="pending"? const Color(0xFFD7263D):const Color(0xFF6AA259),
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
