import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:ht_flutter_getx_listproduk/data/network/api_repository.dart';
import 'package:ht_flutter_getx_listproduk/data/network/services/api_call_status.dart';
import 'package:ht_flutter_getx_listproduk/data/network/services/base_client.dart';
import 'package:ht_flutter_getx_listproduk/domain/models/produk_model.dart';
import 'package:ht_flutter_getx_listproduk/persentation/produk/pages/page_produk.dart';

import '../../../core/components/custom_snackbar.dart';

class ProdukController extends GetxController {
  final data = <ProdukModel>[].obs;
  final apiCallStatus = ApiCallStatus.holding.obs;

  RxBool editFormProduk = false.obs;

  getDataListOrder() async {
    await BaseClient.safeApiCall(
      ApiRepository.todosApiUrl, // url
      RequestType.get, // request type (get,post,delete,put)
      onLoading: () {
        apiCallStatus.value = ApiCallStatus.loading;
      },
      onSuccess: (response) {
        print("get success");
        print(response.data);
        data.value = List<dynamic>.from(response.data)
            .map((itemWord) => ProdukModel.fromJson(itemWord))
            .toList();
        apiCallStatus.value = ApiCallStatus.success;
      },
      onError: (error) {
        BaseClient.handleApiError(error);
        apiCallStatus.value = ApiCallStatus.error;
      },
    );
  }

  getDeleteListProduk(int index) async {
    Timer(const Duration(seconds: 2), () async {
      data.removeAt(index);
      data.refresh();
      CustomSnackBar.showCustomToast(message: "Data Berhasil didelete");
      apiCallStatus.value = ApiCallStatus.success;
    });


  }

  getUpdateDetailListProduk(int index, List<dynamic> dataProduk) async {
    Timer(const Duration(seconds: 2), () async {
      try {
        data.value.elementAt(index).title = dataProduk[0]["title"];
        data.value.elementAt(index).category = dataProduk[0]["category"];
        data.value.elementAt(index).price =
            double.parse(dataProduk[0]["price"].toString());
        data.value.elementAt(index).description = dataProduk[0]["description"];

        CustomSnackBar.showCustomToast(message: "Data berhasil diupdate");
      } catch (e) {
        CustomSnackBar.showCustomErrorToast(message: "Data gagal diupdate");
      }
      data.refresh();
      apiCallStatus.value = ApiCallStatus.success;
    });

    //for update all element
    // data.value.forEach((element) {
    //   element.title = dataProduk[0]["title"];
    //   element.category = dataProduk[0]["category"];
    //   element.price = dataProduk[0]["price"];
    //   element.description = dataProduk[0]["description"];
    // });

  }

  getAddDetailListProduk(List<dynamic> dataProduk) async {
    Timer(const Duration(seconds: 2), () async {
      data.value.addAll(List<dynamic>.from(dataProduk)
          .map((itemWord) => ProdukModel.fromJson(itemWord))
          .toList());
      CustomSnackBar.showCustomToast(message: "Data berhasil ditambahkan");
      data.refresh();
      apiCallStatus.value = ApiCallStatus.success;
    });

    //dummy test
    // data.value.addAll(List<dynamic>.from([{
    //   "image": "test1",
    //   "title":"test2",
    //   "category":"test3",
    //   "price": "test4",
    //   "description": "test5",
    // }]).map((itemWord) => ProdukModel.fromJson(itemWord))
    //     .toList()
    //     );
  }

  @override
  void onInit() {
    getDataListOrder();
    super.onInit();
  }
}
