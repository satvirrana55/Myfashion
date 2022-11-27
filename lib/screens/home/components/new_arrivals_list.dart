import 'dart:developer';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:mi_studio/constants/export.dart';
import 'package:mi_studio/constants/prefs_key.dart';
import 'package:mi_studio/main.dart';
import 'package:mi_studio/screens/home/home_controller.dart';
import 'package:mi_studio/screens/search/search_controller/search_controller.dart';

import '../../shop/product_detail_screen.dart';

class NewArrivalsList extends StatelessWidget {
  final bool? isOnDetailPage;

  const NewArrivalsList({Key? key, this.isOnDetailPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearchController searchController = Get.put(SearchController());
    return GetBuilder<HomeController>(builder: (controller) {
      if (controller.newArrivals != null || controller.youMayAlsoLike != null) {
        return SizedBox(
          height: isOnDetailPage == true ? 280 : 250.sp,
          width: 1.sw,
          child: ListView.builder(
              itemCount: isOnDetailPage == true
                  ? controller.youMayAlsoLike!.data!.site!.route!.node!
                      .products!.edges!.length
                  : controller.newArrivals!.data!.site!.route!.node!.products!
                      .edges!.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var item = isOnDetailPage == true
                    ? controller.youMayAlsoLike!.data!.site!.route!.node!
                        .products!.edges![index]
                    : controller.newArrivals!.data!.site!.route!.node!.products!
                        .edges![index];
                var format = NumberFormat.simpleCurrency(
                    locale: Platform.localeName,
                    name: item.node!.prices!.price!.currencyCode!);
                return GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push( MaterialPageRoute(builder: (context)=> ProductDetail(
                    //   edge: item,
                    //   currencySymbol: format.currencySymbol,
                    // )));

                    searchController.setRecentViewName(
                      '${item.node!.sku}-${item.node!.name}',
                    );
                    searchController.setRecentViewImage(
                        '${item.node!.images!.edges![0].node!.url}');
                    log('data is :---------------------------------- ${item.node!.sku}-${item.node!.name}');
                    // preferences!.setBool(PrefsKey.isCartExist, true);
                    isOnDetailPage == true

                        ?   Navigator.of(context).push( MaterialPageRoute(builder: (context)=> ProductDetail(
                      edge: item,
                      currencySymbol: format.currencySymbol,
                    )))
                        :
                    Navigator.of(context).push( MaterialPageRoute(builder: (context)=> ProductDetail(
                    edge: item,
                    currencySymbol: format.currencySymbol,
                    )));

                  },
                  child: Container(
                    width: 129.sp,
                    padding: EdgeInsets.only(left: 15.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 168.sp,
                          width: 129.sp,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(item
                                      .node!.images!.edges!.first.node!.url!))),
                        ),
                        HelperUtility.customText(
                            title: item.node!.name!,
                            color: ColorConstants.blackColor,
                            fontSize: 10.sp,
                            textAlign: TextAlign.left,
                            fontWeight: FontWeight.w500),
                        SizedBox(
                          height: 8.sp,
                        ),
                        const Icon(
                          Icons.circle,
                          color: Color.fromRGBO(240, 197, 194, 1),
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
                              fontWeight: FontWeight.w500),
                        ),
                        /* SizedBox(
                          height: 14.sp,
                        ),
                        if (isOnDetailPage == true)
                          addButton(() {
                            Get.to(
                                () => ProductDetail(
                                      edge: item,
                                      currencySymbol: format.currencySymbol,
                                    ),
                                preventDuplicates: false);
                          }) */
                      ],
                    ),
                  ),
                );
              }),
        );
      } else {
        return Container();
      }
    });
  }

  Widget addButton(VoidCallback callback) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            border: Border.all(color: ColorConstants.blackColor)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.sp),
          child: Center(
              child: Text(
            'Add',
            style: CustomTextStyle.smallTextStyle
                .copyWith(fontWeight: FontWeight.w500, fontSize: 12.sp),
          )),
        ),
      ),
    );
  }
}
