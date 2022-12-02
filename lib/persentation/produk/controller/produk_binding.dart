import 'package:get/get.dart';
import 'package:ht_flutter_getx_listproduk/persentation/produk/controller/produk_controller.dart';

class ProdukBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProdukController>(
      () => ProdukController(),
    );
  }
}
