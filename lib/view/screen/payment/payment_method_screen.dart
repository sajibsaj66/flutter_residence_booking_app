

/*class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {

  @override
  void initState() {
    DeviceUtils.innerUtils();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 64),
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 24, bottom: 0),
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back_ios, color: AppColors.blackPrimary, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        "Payment Method",
                        style: GoogleFonts.raleway(
                          color: const Color(0xFF333333),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              )
          ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration:
                      const BoxDecoration(gradient: AppColors.whiterColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomCreditCard(
                        top: 24,
                        imageType: ImageType.svg,
                        onTap: () => showDialog(
                          context: context,
                          builder: (context){
                           return const PaymentPopUp();
                         }
                      )),
                      CustomCreditCard(
                        imageSrc: AppImages.waveCard,
                        titleText: AppStaticStrings.wave,
                      ),
                      CustomCreditCard(imageSrc: AppImages.orangeCard,titleText: AppStaticStrings.orange),
                      CustomCreditCard(imageSrc: AppImages.mntCard,titleText: AppStaticStrings.mnt),
                      CustomCreditCard(imageSrc: AppImages.mntCard1,titleText: AppStaticStrings.mnt),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}*/
