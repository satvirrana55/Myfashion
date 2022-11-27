import 'dart:io';

import 'package:intl/intl.dart';
import 'package:mi_studio/constants/export.dart';
import 'package:mi_studio/screens/home/home_controller.dart';
import 'package:mi_studio/screens/search/search_controller/search_controller.dart';
import 'package:mi_studio/screens/shop/product_detail_screen.dart';
import 'package:mi_studio/widgets/loader_dialog.dart';

class BestSeller extends StatefulWidget {
  const BestSeller({Key? key}) : super(key: key);

  @override
  State<BestSeller> createState() => _BestSellerState();
}

class _BestSellerState extends State<BestSeller> {
  HomeController homeController = Get.find<HomeController>();
  SearchController searchController = Get.put(SearchController());

  void _loadHomePage() {
    LoaderDialog.showLoadingDialog(context);
    homeController.fetchBestSeller(context);
    Get.back();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadHomePage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HelperUtility.commonAppBar(
          title: "app_bar_best_sellers".tr,
          isbottomTab: true,
          context: context),
      body: body(),
    );
  }

  Widget body() {
    return SafeArea(child: GetBuilder<HomeController>(builder: (controller) {
      return controller.bestSeller != null
          ? RefreshIndicator(
              onRefresh: () async {
                return controller.fetchBestSeller(context);
              },
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5.sp),
                    decoration: BoxDecoration(
                        color: ColorConstants.whiteColor,
                        border: Border(
                          bottom: BorderSide(
                              width: 1, color: ColorConstants.greyColor),
                          top: BorderSide(
                              width: 1, color: ColorConstants.greyColor),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Spacer(
                          flex: 1,
                        ),
                        HelperUtility.customText(
                            title: "filter".tr,
                            color: ColorConstants.blackColor,
                            fontSize: 12.sp,
                            textAlign: TextAlign.left,
                            fontWeight: FontWeight.w500),
                        const Spacer(
                          flex: 1,
                        ),
                        Container(
                          width: 1.sp,
                          height: 25.sp,
                          color: ColorConstants.greyColor,
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        HelperUtility.customText(
                            title: "sort".tr,
                            color: ColorConstants.blackColor,
                            fontSize: 12.sp,
                            textAlign: TextAlign.left,
                            fontWeight: FontWeight.w500),
                        const Spacer(
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20.sp),
                      itemCount: controller.bestSeller!.data!.site!.route!.node!
                          .products!.edges!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              childAspectRatio: 2.7 / 4),
                      itemBuilder: (BuildContext context, int index) {
                        var item = controller.bestSeller!.data!.site!.route!
                            .node!.products!.edges![index];
                        var format = NumberFormat.simpleCurrency(
                            locale: Platform.localeName,
                            name: item.node!.prices!.price!.currencyCode!);
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetail(
                                          edge: item,
                                          currencySymbol: format.currencySymbol,
                                        )));
                            // Get.to(() => );
                            searchController.setRecentViewName(
                              '${item.node!.sku}-${item.node!.name}',
                            );
                            searchController.setRecentViewImage(
                                '${item.node!.images!.edges![0].node!.url}');
                          },
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 1.sw * 0.5,
                                  width: 1.sw * 0.5,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(item.node!.images!
                                              .edges!.first.node!.url!),
                                          fit: BoxFit.fill)),
                                ),
                                SizedBox(
                                  height: 5.sp,
                                ),
                                Flexible(
                                  child: HelperUtility.customText(
                                      title: item.node!.name!,
                                      color: ColorConstants.blackColor,
                                      fontSize: 10.sp,
                                      textAlign: TextAlign.left,
                                      fontWeight: FontWeight.w400,
                                      textOverFlow: TextOverflow.ellipsis),
                                ),
                                SizedBox(
                                  height: 8.sp,
                                ),
                                Icon(
                                  Icons.circle,
                                  color: ColorConstants.lightBrownColor,
                                  size: 10,
                                ),
                                SizedBox(
                                  height: 8.sp,
                                ),
                                Expanded(
                                  child: HelperUtility.customText(
                                      title:
                                          "${format.currencySymbol} ${item.node!.prices!.price!.value}",
                                      color: ColorConstants.blackColor,
                                      fontSize: 10.sp,
                                      textAlign: TextAlign.center,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          : Container();
    }));
  }
}
