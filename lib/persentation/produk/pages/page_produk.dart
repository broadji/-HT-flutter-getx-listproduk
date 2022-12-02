import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ht_flutter_getx_listproduk/core/components/widgets_animator.dart';
import 'package:ht_flutter_getx_listproduk/core/config/theme/app_fonts.dart';
import 'package:ht_flutter_getx_listproduk/core/config/theme/app_theme.dart';
import 'package:ht_flutter_getx_listproduk/core/utils/utils_read_more_text.dart';
import 'package:ht_flutter_getx_listproduk/persentation/produk/controller/produk_controller.dart';
import 'package:ht_flutter_getx_listproduk/persentation/produk/pages/detail_produk/page_detail_produk.dart';

import '../../../core/components/alert_dialog.dart';
import '../../../data/repositories/produk/produk_repository.dart';

final produkController = Get.put(ProdukController());

class ProdukPage extends StatefulWidget {
  const ProdukPage({Key? key}) : super(key: key);

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('List Produk'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Get.back();
                  Get.to(() => DetailProdukPage(index: 0,onUpdate: false,));
                },
                icon: Icon(Icons.add)),
            IconButton(
                onPressed: () {
                  AppTheme.changeTheme();
                },
                icon: Icon(Icons.sunny_snowing)),
            IconButton(
                onPressed: () {
                  AlertCostume.alertDialogConfirmation(context, "Apakah anda ingin me-refresh data?", "Data yang direfresh akan kembali kebentuk awal", (){
                    Navigator.pop(context);
                    ApiProduk().hitApiListOrder();});
                },
                icon: Icon(Icons.refresh)),
          ],
        ),
        body: listProduk());
  }
}

class listProduk extends StatelessWidget {

  listProduk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => WidgetsAnimator(
          apiCallStatus: produkController.apiCallStatus.value,
          loadingWidget: () => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: () => const Center(
            child: Text('Something went worng!'),
          ),
          successWidget: () => ListView.separated(
            itemCount: produkController.data.length,
            separatorBuilder: (_, __) => SizedBox(
              height: 10.h,
            ),
            itemBuilder: (ctx, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal:16.h, vertical:6.h),
              child: SizedBox(
                height: 160.h,
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                      color: Colors.transparent,
                  boxShadow: <BoxShadow> [
                    BoxShadow(
                      color: Color(0x26000000).withOpacity(0.1),
                      offset: Offset(0, 6),
                    ),
                  ]),
                  child: ClipRRect(
                    borderRadius:BorderRadius.circular(20),
                    child: GestureDetector(
                      onTap: (){
                        Get.back();
                        Get.to(() => DetailProdukPage(index: index,onUpdate: true,));
                      },
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: Container(
                                    color: Colors.grey,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            color: Colors.black,
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
                                              imageUrl:
                                              produkController.data[index].image.toString(),
                                            ),
                                          ),
                                          Container(
                                            color: Theme.of(context).primaryColorLight,
                                            child: Text(
                                              "\$ ${produkController.data[index].price.toString()}",
                                              style: AppFonts.buttonTextStyle.copyWith(
                                                  fontSize: AppFonts.buttonTextSize,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                              Expanded(
                                flex: 6,
                                child: Container(
                                  color:Colors.white,
                                  padding: EdgeInsets.fromLTRB(10.h,10.h,10.h,30.h),
                                  alignment: Alignment.topLeft,
                                  child: ListView(
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    children: [
                                      Text(
                                        produkController.data[index].title.toString(),
                                        maxLines: 2,
                                        style: AppFonts.bodyTextStyle.copyWith(
                                          fontSize: AppFonts.appBarTittleSize,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      ReadMoreText(
                                        produkController.data[index].description
                                            .toString(),
                                        trimLines: 4,
                                        colorClickableText: Colors.red,
                                        trimMode: TrimMode.Line,
                                        style: AppFonts.bodyTextStyle.copyWith(
                                            fontSize: AppFonts.body1TextSize,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black
                                        ),
                                        trimCollapsedText: '...Expand',
                                        trimExpandedText: ' Showless '
                                        ,
                                      ),
                                      SizedBox(height: 20,)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Positioned(
                            right: 14,
                            bottom: 10,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.star_rate_sharp),
                                  Text(produkController.data[index].rating!.rate
                                      .toString(),style: AppFonts.bodyTextStyle.copyWith(
                                      fontSize: AppFonts.body1TextSize,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black
                                  ),)
                                ]),),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
