import 'dart:io';

import 'package:intl/intl.dart';
import 'package:mi_studio/constants/export.dart';
import 'package:mi_studio/screens/profile/controller/profile_controller.dart';

import '../../models/orders_model.dart';

class OrderDetail extends StatefulWidget {
  final OrderModel order;

  const OrderDetail({super.key, required this.order});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      return Scaffold(
          backgroundColor: ColorConstants.lightGreyishColor,
          appBar: HelperUtility.commonAppBar(
              title:
                  'Order ${Get.find<ProfileController>().orderDetail[0].orderId}'),
          body: SafeArea(
            child: controller.orderDetail.isNotEmpty
                ? Column(
                    children: [
                      ListView.builder(
                          itemCount: controller.orderDetail.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var orderDet =
                                Get.find<ProfileController>().orderDetail;
                            var format = NumberFormat.simpleCurrency(
                                locale: Platform.localeName,
                                name: widget.order.currencyCode);

                            return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 3.sp, horizontal: 29.sp),
                                child: Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 1.sp),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 13.sp, vertical: 18.sp),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                        color: ColorConstants.whiteColor),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            HelperUtility.customText(
                                                title: orderDet[index].name,
                                                color:
                                                    ColorConstants.blackColor,
                                                fontSize: 12.sp,
                                                textAlign: TextAlign.left,
                                                fontWeight: FontWeight.w400),
                                            /* const Spacer(),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 17.sp,
                                              vertical: 7.sp),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6.r),
                                              color: ColorConstants
                                                  .lightGreyColor),
                                          child: HelperUtility.customText(
                                              title: "Reorder",
                                              color: ColorConstants.blackColor,
                                              fontSize: 12.sp,
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.w500),
                                        ) */
                                          ],
                                        ),
                                        SizedBox(
                                          height: 12.sp,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 100.sp,
                                              width: 77.sp,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                image: NetworkImage(controller
                                                    .listData![index]
                                                    .data!
                                                    .site!
                                                    .products!
                                                    .edges![0]
                                                    .node!
                                                    .images!
                                                    .edges![0]
                                                    .node!
                                                    .url
                                                    .toString()),
                                              )),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                HelperUtility.customText(
                                                    title: "Color:",
                                                    color: ColorConstants
                                                        .textGreyColor,
                                                    fontSize: 10.sp,
                                                    textAlign: TextAlign.left,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                const Icon(
                                                  Icons.circle,
                                                  color: Color.fromRGBO(
                                                      240, 197, 194, 1),
                                                  /* profileController
                                                            .listProdDetails![
                                                                index]
                                                            .data!
                                                            .site!
                                                            .products!
                                                            .edges![0]
                                                            .node!
                                                            .productOptions!
                                                            .edges![index]
                                                            .node!
                                                            .values!
                                                            .edges![0]
                                                            .node!
                                                            .hexColors !=
                                                        null
                                                    ? Color(int.parse(
                                                        "0xFF${profileController.listProdDetails![index].data!.site!.products!.edges![0].node!.productOptions!.edges![index].node!.values!.edges![0].node!.hexColors![0].toString().split("#").last}"))
                                                    : Colors.transparent */

                                                  size: 18,
                                                ),
                                                SizedBox(
                                                  height: 14.sp,
                                                ),
                                                HelperUtility.customText(
                                                    title: "Ordered on",
                                                    color: ColorConstants
                                                        .textGreyColor,
                                                    fontSize: 10.sp,
                                                    textAlign: TextAlign.left,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                HelperUtility.customText(
                                                    title: widget.order
                                                                .dateCreated !=
                                                            ""
                                                        ? '${widget.order.dateCreated?.split(',').last.split(' ')[1] ?? ""} ${widget.order.dateCreated?.split(',').last.split(' ')[2] ?? ""} ${widget.order.dateCreated?.split(',').last.split(' ')[3] ?? ""}'
                                                        : " ",
                                                    color: ColorConstants
                                                        .blackColor,
                                                    fontSize: 10.sp,
                                                    textAlign: TextAlign.left,
                                                    fontWeight: FontWeight.w400)
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                HelperUtility.customText(
                                                    title: "Size:",
                                                    color: ColorConstants
                                                        .textGreyColor,
                                                    fontSize: 10.sp,
                                                    textAlign: TextAlign.left,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                HelperUtility.customText(
                                                    title: orderDet[index]
                                                        .productOptions![0]
                                                        .displayValue,
                                                    color: ColorConstants
                                                        .blackColor,
                                                    fontSize: 10.sp,
                                                    textAlign: TextAlign.left,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                SizedBox(
                                                  height: 20.sp,
                                                ),
                                                HelperUtility.customText(
                                                    title: "Delivered on",
                                                    color: ColorConstants
                                                        .textGreyColor,
                                                    fontSize: 10.sp,
                                                    textAlign: TextAlign.left,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                HelperUtility.customText(
                                                    title: widget.order
                                                                .dateShipped !=
                                                            ""
                                                        ? '${widget.order.dateShipped?.split(',').last.split(' ')[1]} ${widget.order.dateShipped?.split(',').last.split(' ')[2] ?? ""} ${widget.order.dateShipped?.split(',').last.split(' ')[3] ?? ''}'
                                                        : "28 Jul 2022",
                                                    color: ColorConstants
                                                        .blackColor,
                                                    fontSize: 10.sp,
                                                    textAlign: TextAlign.left,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                HelperUtility.customText(
                                                    title: "Quantity:",
                                                    color: ColorConstants
                                                        .textGreyColor,
                                                    fontSize: 10.sp,
                                                    textAlign: TextAlign.left,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                HelperUtility.customText(
                                                    title: orderDet[index]
                                                        .quantity
                                                        .toString(),
                                                    color: ColorConstants
                                                        .blackColor,
                                                    fontSize: 10.sp,
                                                    textAlign: TextAlign.left,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                SizedBox(
                                                  height: 20.sp,
                                                ),
                                                HelperUtility.customText(
                                                    title: "Total Amount:",
                                                    color: ColorConstants
                                                        .textGreyColor,
                                                    fontSize: 10.sp,
                                                    textAlign: TextAlign.left,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                HelperUtility.customText(
                                                    title:
                                                        "${format.currencySymbol} ${orderDet[index].totalIncTax!.split('.').first}",
                                                    color: ColorConstants
                                                        .blackColor,
                                                    fontSize: 10.sp,
                                                    textAlign: TextAlign.left,
                                                    fontWeight: FontWeight.w400)
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    )));
                          }),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 29.sp),
                        child: Container(
                            width: 1.sw,
                            margin: EdgeInsets.symmetric(vertical: 1.sp),
                            padding: EdgeInsets.symmetric(
                                horizontal: 13.sp, vertical: 25.sp),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                color: ColorConstants.whiteColor),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HelperUtility.customText(
                                    title: "Shipping Details",
                                    color: ColorConstants.blackColor,
                                    fontSize: 11.sp,
                                    textAlign: TextAlign.left,
                                    fontWeight: FontWeight.w500),
                                SizedBox(
                                  height: 11.h,
                                ),
                                HelperUtility.customText(
                                    title:
                                        "${widget.order.billingAddress?.firstName}${widget.order.billingAddress?.lastName}\n${widget.order.billingAddress?.city}",
                                    color: ColorConstants.blackColor,
                                    fontSize: 10.sp,
                                    textAlign: TextAlign.left,
                                    fontWeight: FontWeight.w400),
                              ],
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.sp, horizontal: 29.sp),
                        child: Container(
                            width: 1.sw,
                            padding: EdgeInsets.symmetric(
                                horizontal: 13.sp, vertical: 25.sp),
                            margin: EdgeInsets.symmetric(vertical: 1.sp),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                color: ColorConstants.whiteColor),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HelperUtility.customText(
                                    title: "Payment Details",
                                    color: ColorConstants.blackColor,
                                    fontSize: 11.sp,
                                    textAlign: TextAlign.left,
                                    fontWeight: FontWeight.w500),
                                SizedBox(
                                  height: 14.h,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        HelperUtility.customText(
                                            title:
                                                "Bank of Italy Card ****4589",
                                            color: ColorConstants.blackColor,
                                            fontSize: 10.sp,
                                            textAlign: TextAlign.left,
                                            fontWeight: FontWeight.w400),
                                        HelperUtility.customText(
                                            title: "Credit Card",
                                            color:
                                                ColorConstants.textGreyNewColor,
                                            fontSize: 9.sp,
                                            textAlign: TextAlign.left,
                                            fontWeight: FontWeight.w400),
                                      ],
                                    ),
                                    const Spacer(),
                                    Image.asset(AppImages.visaCardImage)
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
          ));
    });
  }
}
