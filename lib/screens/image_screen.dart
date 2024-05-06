import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/controllers/image_controller.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    Get.put(ImageController());
    super.initState();
  }

  int getNoOfItems(double w) {
    // if (w > 1300) return 5;
    // if (w > 1000) return 4;
    // if (w > 600) return 3;
    return w ~/ 600 + 2;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: GetBuilder<ImageController>(
            builder: (controller) => Stack(
                  children: [
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: getNoOfItems(size.width),
                      controller: controller.listScrollController,
                      children: List.generate(
                        controller.searchedImageList.isEmpty
                            ? controller.imageList.length
                            : controller.searchedImageList.length,
                        (index) {
                          var imageData = controller.searchedImageList.isEmpty
                              ? controller.imageList[index]
                              : controller.searchedImageList[index];
                          return InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Stack(
                                    children: [
                                      PhotoView(
                                          imageProvider: NetworkImage(
                                              imageData.largeImageURL ?? "")),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                            size: 30,
                                            color: Colors.white,
                                          ))
                                    ],
                                  );
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: imageData.largeImageURL ?? "",
                                    fit: BoxFit.fill,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        margin: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Row(
                                          children: [
                                            Text(
                                              "${imageData.views}",
                                              overflow:
                                                  TextOverflow.ellipsis,
                                            ),
                                            const Icon(
                                              Icons.favorite,
                                              size: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        margin: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Row(
                                          children: [
                                            Text(
                                              "${imageData.likes.toString()}",
                                              overflow:
                                                  TextOverflow.ellipsis,
                                            ),
                                            const Icon(
                                              Icons.visibility,
                                              size: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      margin: const EdgeInsets.all(15),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                          child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          controller.onSearchChanged(value);
                        },
                        decoration: InputDecoration(
                          hintText: "Search Photo",
                          suffixIcon: IconButton(
                              onPressed: () {
                                controller.clearSearchList();
                                searchController.clear();
                                FocusScope.of(context).unfocus();
                              },
                              icon: const Icon(Icons.close)),
                          border: InputBorder.none,
                        ),
                      )),
                    )
                  ],
                )));
  }
}
