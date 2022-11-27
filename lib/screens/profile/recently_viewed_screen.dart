import 'dart:convert';

import 'package:mi_studio/constants/export.dart';
import 'package:mi_studio/models/products_model.dart';
import 'package:mi_studio/screens/search/search_controller/search_controller.dart';
import 'package:mi_studio/screens/shop/best_seller_screen.dart';
import 'package:mi_studio/screens/shop/product_detail_screen.dart';

class RecentlyViewedScreen extends StatefulWidget {
  const RecentlyViewedScreen({Key? key}) : super(key: key);

  @override
  State<RecentlyViewedScreen> createState() => _RecentlyViewedScreenState();
}

class _RecentlyViewedScreenState extends State<RecentlyViewedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.lightGreyishColor,
      appBar: HelperUtility.commonAppBar(title: "app_bar_recently".tr),
      body: body(),
    );
  }
}

Widget body() {
  SearchController searchController = Get.put(SearchController());

  return SafeArea(
      child: Column(children: [
    Container(
      padding: EdgeInsets.symmetric(vertical: 5.sp),
      decoration: BoxDecoration(
          color: ColorConstants.whiteColor,
          border: Border(
            bottom: BorderSide(width: 3, color: ColorConstants.greyColor),
            top: BorderSide(width: 3, color: ColorConstants.greyColor),
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
            width: 3.sp,
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
        padding: EdgeInsets.only(left: 25.sp),
        shrinkWrap: true,
        itemCount: searchController.getJsonList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 4.0, childAspectRatio: 2.6 / 4),
        itemBuilder: (BuildContext context, int index) {
          ProductsEdge productsEdge = ProductsEdge.fromJson(
              json.decode(searchController.getJsonList[index]));
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                child: Container(
                  height: 1.sw * 0.5,
                  width: 1.sw * 0.4,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                          image: NetworkImage(
                            productsEdge.node!.images!.edges![0].node!.url
                                .toString(),
                          ),
                          fit: BoxFit.cover)),
                ),
                onTap: () {
                  var item = productsEdge;
                  Get.to(() => ProductDetail(
                        edge: item,
                        //currencySymbol:item.node.,
                      ));
                },
              ),
              SizedBox(
                height: 5.sp,
              ),
              Flexible(
                child: HelperUtility.customText(
                    title: productsEdge.node?.name,
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
                    title: '',
                    color: ColorConstants.blackColor,
                    fontSize: 10.sp,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w400),
              )
            ],
          );
        },
      ),
    )
  ]));
}
