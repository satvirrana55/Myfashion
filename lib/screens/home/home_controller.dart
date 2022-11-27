import 'package:mi_studio/constants/export.dart';
import 'package:mi_studio/models/base_model.dart';
import 'package:mi_studio/models/bottom_bar_item_model.dart';
import 'package:mi_studio/network/constants/graph_ql_query.dart';
import 'package:mi_studio/network/network_services/big_commerece_graphQl/graph_ql_services.dart';
import 'package:mi_studio/widgets/loader_dialog.dart';

import '../../models/products_model.dart';

class HomeController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> drawerOptionsList = [
    "Best Seller",
    "New Arrivals",
    "Dresses",
    "Tops",
    "Jumpsuits",
    "Trousers",
    "Skirts",
    "Outdoors"
  ];
  List<BottomBarItemModel> categoryList = [
    BottomBarItemModel(title: "Best Seller", imagePath: AppImages.outDoorImage),
    BottomBarItemModel(title: "Dresses", imagePath: AppImages.dressesImage),
    BottomBarItemModel(title: "Tops", imagePath: AppImages.topsImage),
    BottomBarItemModel(title: "JumpSuits", imagePath: AppImages.jumpSuitImage),
    BottomBarItemModel(title: "Trousers", imagePath: AppImages.trouserImage),
    BottomBarItemModel(title: "Skirts", imagePath: AppImages.skirtsImage),
    BottomBarItemModel(title: "OutDoors", imagePath: AppImages.outDoorImage),
  ];
  TextEditingController searchController = TextEditingController();

  toggleDrawer() async {
    if (scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.openEndDrawer();
    } else {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  ProductsModel? _bestSeller;
  ProductsModel? get bestSeller => _bestSeller;
  ProductsModel? _categories;
  ProductsModel? get categories => _categories;

  ProductsModel? _newArrivals;
  ProductsModel? get newArrivals => _newArrivals;

  ProductsModel? _youMayAlsoLike;
  ProductsModel? get youMayAlsoLike => _youMayAlsoLike;

  final GraphQlServices _graphQlServices = GraphQlServices();

  void fetchBestSeller(BuildContext context) async {
    BaseModel<ProductsModel> response =
        await _graphQlServices.fetchProductFromUrl(context, {
      "query": GraphQlQuery.productQuery('best-seller'),
      "variables": {"urlPath": "/shop-all"}
    });
    _bestSeller = response.data;
    update();
  }
  void fetchCategories(BuildContext context,String url) async {
    LoaderDialog.showLoadingDialog(context);
    BaseModel<ProductsModel> response =
    await _graphQlServices.fetchProductFromUrl(context, {
      "query": GraphQlQuery.productQuery(url),
      "variables": {"urlPath": "/shop-all"}
    });
    _categories = response.data;
    // Navigator.pop(context);
    Get.back();
    update();
  }

  void fetchNewArrivals(BuildContext context) async {
    BaseModel<ProductsModel> response =
        await _graphQlServices.fetchProductFromUrl(context, {
      "query": GraphQlQuery.productQuery('new-arrivals'),
      "variables": {"urlPath": "/shop-all"}
    });
    _newArrivals = response.data!;
    update();
  }

  void fetchYouMayAlsoLike(BuildContext context) async {
    BaseModel<ProductsModel> response =
        await _graphQlServices.fetchProductFromUrl(context, {
      "query": GraphQlQuery.productQuery('youmayalsolike'),
      "variables": {"urlPath": "/shop-all"}
    });
    _youMayAlsoLike = response.data!;
    update();
  }
}
