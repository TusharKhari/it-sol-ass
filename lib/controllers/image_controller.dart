import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../files/data.dart';
import '../models/image_model.dart';

class ImageController extends GetxController {
  ScrollController listScrollController = ScrollController();
  List<ImageModel> imageList = [];
  List<ImageModel> searchedImageList = [];

   int currentPage = 1;
  Timer? _debounce;

  void loadData({required List responseData,  bool isSearch = false}) {
    for (var element in responseData) {
      ImageModel image = ImageModel.fromJson(element);
      // print(element);
     isSearch ? searchedImageList.add(image) : imageList.add(image);
    }
    listScrollController.addListener(
      () {
        if (listScrollController.position.pixels >=
            listScrollController.position.maxScrollExtent) {
          log("${currentPage}");
          // loadData();
          getImagesResponse(currentPage++);
        }
      },
    );
    update();
  }


void clearSearchList(){
  searchedImageList.clear();
  update();
}

 onSearchChanged(String query) {
    if(query.isEmpty){
      clearSearchList();
    }else{
      if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
          getQueryImagesResponse(query);
    });
    }
}

  void getImagesResponse(int index)async{
     var res = await Dio().get("https://pixabay.com/api/?key=43750065-fe233a37f220a4b6b42684160&per_page=150&page=${index}&image_type=photo&pretty=true}");
     loadData(responseData: res.data["hits"]);
  }

  void getQueryImagesResponse(String query)async{
    log("${query.trim().replaceAll(" ", "+")}");
    var res = await Dio().get("https://pixabay.com/api/?key=43750065-fe233a37f220a4b6b42684160&per_page=150&image_type=photo&pretty=true&q=${query.trim().replaceAll(" ", "+")}");
    searchedImageList.clear();
    print(res.data);
     loadData(responseData: res.data["hits"], isSearch: true);
  }

    @override
  void onInit() {
    // TODO: implement onInit
     getImagesResponse(currentPage++);
     super.onInit();
  }
}
