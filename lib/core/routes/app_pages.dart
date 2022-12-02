import 'package:get/get.dart';
import 'package:ht_flutter_getx_listproduk/persentation/produk/controller/produk_binding.dart';
import 'package:ht_flutter_getx_listproduk/persentation/produk/pages/page_produk.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LIST_PRODUK;

  static final routes = [
    GetPage(
      name: _Paths.LIST_PRODUK,
      page: () => const ProdukPage(),
      binding: ProdukBinding(),
    ),
  ];
}
