import 'package:flutter/cupertino.dart';
import 'package:ht_flutter_getx_listproduk/persentation/produk/pages/page_produk.dart';

class ApiProduk {
  hitApiListOrder(){
    return produkController.getDataListOrder();
  }

  loadDeleteListProduk(@required int index){
    return produkController.getDeleteListProduk(index);
  }

  loadUpdateDetailListProduk(@required int index, @required List<dynamic> data){
    return produkController.getUpdateDetailListProduk(index, data);
  }

  loadAddDetailListProduk(@required List<dynamic> data){
    return produkController.getAddDetailListProduk(data);
  }
}
