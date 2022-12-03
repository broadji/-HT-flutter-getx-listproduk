import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ht_flutter_getx_listproduk/core/components/alert_dialog.dart';
import 'package:ht_flutter_getx_listproduk/core/components/custom_button.dart';
import 'package:ht_flutter_getx_listproduk/core/components/custom_form.dart';
import 'package:ht_flutter_getx_listproduk/core/components/widgets_animator.dart';
import 'package:ht_flutter_getx_listproduk/core/config/theme/app_fonts.dart';
import 'package:ht_flutter_getx_listproduk/data/network/services/api_call_status.dart';
import 'package:ht_flutter_getx_listproduk/persentation/produk/controller/produk_controller.dart';
import 'package:ht_flutter_getx_listproduk/persentation/produk/pages/page_produk.dart';

import '../../../../data/repositories/produk/produk_repository.dart';

class DetailProdukPage extends StatefulWidget {
  final int index;
  final bool onUpdate;

  const DetailProdukPage({Key? key, required this.index, required this.onUpdate})
      : super(key: key);

  @override
  State<DetailProdukPage> createState() => _DetailProdukPageState();
}

class _DetailProdukPageState extends State<DetailProdukPage> {
  final produkController = Get.put(ProdukController());

  List<dynamic> _listDetailProduk = [];

  @override
  void initState() {
    if (widget.onUpdate == true) {
      produkController.editFormProduk.value = false;
      _listDetailProduk.add({
        "image": produkController.data[widget.index].image,
        "title": produkController.data[widget.index].title,
        "category": produkController.data[widget.index].category,
        "price": produkController.data[widget.index].price,
        "description": produkController.data[widget.index].description,
      });
    } else {
      print('masuk onUpdate detail');
      produkController.editFormProduk.value = true;
      _listDetailProduk.add({
        "image": "https://place-hold.it/300x500?text=Something%20Here",
        "title": "",
        "category": "",
        "price": 0,
        "description": "",
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Produk'),
          centerTitle: true,
          actions: widget.onUpdate == true
              ? [
                  IconButton(
                      onPressed: () {
                        AlertCostume.alertDialogConfirmation(
                            context, "Apakah anda ingin meng-edit data?", "",
                            () {
                          Navigator.pop(context);
                          produkController.editFormProduk.value = true;
                        });
                      },
                      icon: Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        AlertCostume.alertDialogConfirmation(
                            context,
                            "Apakah anda ingin me-refresh data?",
                            "Data yang direfresh akan kembali kebentuk awal",
                            () {
                          Navigator.pop(context);
                          produkController.apiCallStatus.value = ApiCallStatus.loading;
                          Get.back();
                          ApiProduk().loadDeleteListProduk(widget.index);

                        });
                      },
                      icon: Icon(Icons.delete_forever)),
                ]
              : [],
        ),
        body: Obx(() => WidgetsAnimator(
          apiCallStatus: produkController.apiCallStatus.value,
          loadingWidget: () => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: () => const Center(
            child: Text('Something went worng!'),
          ),
          successWidget: () { return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Container(
                  height: 400,
                  width: 400,
                  child: CachedNetworkImage(
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                      const CupertinoActivityIndicator(),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey,
                      ),
                      imageUrl: widget.onUpdate == true
                          ?_listDetailProduk[0]["image"]: produkController.data[widget.index].description
                          .toString()
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                dataForm(
                    typeVar: "String",
                    context: context,
                    title: "Title",
                    dataForm: widget.onUpdate == true
                        ? produkController.data[widget.index].title
                        .toString(): _listDetailProduk[0]["title"].toString()),
                dataForm(
                    typeVar: "String",
                    context: context,
                    title: "Category",
                    dataForm:  widget.onUpdate == true
                        ? produkController.data[widget.index].category
                        .toString(): _listDetailProduk[0]["category"].toString()),
                dataForm(
                    typeVar: "double",
                    context: context,
                    title: "Price",
                    dataForm: widget.onUpdate == true
                        ?"\$ ${produkController.data[widget.index].price.toString()}"
                        :  _listDetailProduk[0]["price"].toString()),
                dataForm(
                    typeVar: "String",
                    context: context,
                    title: "Description",
                    dataForm:  widget.onUpdate == true
                        ? produkController.data[widget.index].description
                        .toString(): _listDetailProduk[0]["description"].toString()
                ),
                SizedBox(
                  height: 20,
                ),
               Obx(()=> produkController.editFormProduk.value ==true || widget.onUpdate==false?
                CustomButtons.primaryButton(true,widget.onUpdate==true? 'Update':"Buat", false, null, () {
                  AlertCostume.alertDialogConfirmation(
                      context, widget.onUpdate==true?"Apakah anda ingin meng-update data?":"Apakah anda ingin menambah data?", "", () {
                    Navigator.pop(context);
                    Get.back();
                    produkController.apiCallStatus.value = ApiCallStatus.loading;
                    if(widget.onUpdate==true){ApiProduk().loadUpdateDetailListProduk(
                        widget.index, _listDetailProduk);

                    }else{
                      ApiProduk().loadAddDetailListProduk(
                          _listDetailProduk);
                    }
                  });
                }):Container(),)
              ],
            ),
          );},
        )));
    ;
  }

  Widget dataForm({
    required BuildContext context,
    required String title,
    required String dataForm,
    required String typeVar,
  }) {
    TextEditingController valueText = TextEditingController();
    valueText.text = _listDetailProduk[0][title.toLowerCase()].toString();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: AppFonts.appBarTextStyle.copyWith(
                  fontSize: AppFonts.appBarTittleSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(" :    "),
          Obx(()=>produkController.editFormProduk.value?
          Expanded(
                  flex: 7,
                  child: CustomForm.inputForm(context, "", true, valueText,
                      formType: typeVar,
                      onChanged: (value) {
                    if(typeVar == "String"){
                      _listDetailProduk[0][title.toLowerCase()] = value;
                    } else if(typeVar == "double"){
                      _listDetailProduk[0][title.toLowerCase()] = double.parse(value.replaceAll("\$ ", ""));
                    }
                    print(_listDetailProduk);
                  }, onUpdateingCompleted: (String) {
                    setState(() {});
                  }, onFocusChange: (value) {
                    setState(() {});
                  },
                      disableForm:
                          produkController.editFormProduk.value ? true : false,))
              : Expanded(
                  flex: 7,
                  child: Text(
                    dataForm.toString(),
                    style: AppFonts.appBarTextStyle
                        .copyWith(fontSize: AppFonts.headline6TextSize),
                  ),
                ))
        ],
      ),
    );
  }
}
