import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_claim/configs/app_config.dart';
import 'package:travel_claim/modules/gallery/gallery_page.dart';
import 'package:travel_claim/modules/gallery/pdf_viewer.dart';
import 'package:travel_claim/modules/gallery/widgets/gallery_item.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/const/appassets.dart';
import 'package:path/path.dart';

class AttachedFileWidget extends StatelessWidget {
  final String file;
  const AttachedFileWidget({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    print(file);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (){
        if(extension(file).toLowerCase().endsWith('pdf')){
          Get.to(()=>PdfViewer(file: "${AppConfig.imageBaseUrl}$file"));
        }else{
          Navigator.push(
            Get.context!,
            MaterialPageRoute(
              builder: (context) => GalleryPhotoViewWrapper(
                galleryItems: [GalleryItem(id: "id:1", resource: "${AppConfig.imageBaseUrl}$file")],
                backgroundDecoration: const BoxDecoration(
                  color: Colors.black,
                ),
                initialIndex: 0,
                scrollDirection: Axis.horizontal,
              ),
            ),
          );
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          file
              .split("/")
              .last
              .toLowerCase()
              .endsWith('jpg') ||
              file
                  .split("/")
                  .last
                  .toLowerCase()
                  .endsWith('png')
              ? CachedNetworkImage(
            imageUrl:
            "${AppConfig.imageBaseUrl}${file}",
            height: 50,
          )
              : Image.asset(
            AppAssets.file,
            height: 30,
          ),
          gapWC(7),
          /*Expanded(
            child: Text(basename(file),textAlign: TextAlign.left,overflow: TextOverflow.fade,style: const TextStyle(
                fontFamily: 'Roboto',fontSize: 14,
                fontWeight: FontWeight.bold,color: Color(0xff333333))),
          ),*/
        ],
      ),
    );
  }
}
