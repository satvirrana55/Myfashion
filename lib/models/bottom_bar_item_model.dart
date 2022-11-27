import '../constants/assets.dart';

class BottomBarItemModel {
  String? title;
  String? imagePath;

  BottomBarItemModel({this.title, this.imagePath});
}

List<BottomBarItemModel> bottomBarList = [
  BottomBarItemModel(imagePath: AppImages.homeIcon, title: "home"),
  BottomBarItemModel(
      imagePath: AppImages.newArrivalIcon, title: "new_arrival_"),
  BottomBarItemModel(imagePath: AppImages.cartIcon, title: "shop"),
  BottomBarItemModel(imagePath: AppImages.shopIcon, title: "cart"),
  BottomBarItemModel(imagePath: AppImages.profileIcon, title: "profile"),
];
