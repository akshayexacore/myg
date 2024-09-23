
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart' as picker;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:travel_claim/configs/app_config.dart';
import 'package:travel_claim/modules/gallery/gallery_page.dart';
import 'package:travel_claim/modules/gallery/pdf_viewer.dart';
import 'package:travel_claim/modules/gallery/widgets/gallery_item.dart';
import 'package:travel_claim/resources/myg_repository.dart';
import 'package:travel_claim/views/components/app_dialog.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/components/customButton.dart';
import 'package:travel_claim/views/const/appassets.dart';
import 'package:travel_claim/views/style/colors.dart';
import 'package:path/path.dart';
class FilePicker extends StatefulWidget {
  List<String> selectedFiles;
  final ValueChanged<List<String>> onChanged;
  final bool multiple;
  late String errorMsg;

  FilePicker(
      {super.key,
      required this.onChanged,
      required this.selectedFiles,
      this.multiple = false,
        this.errorMsg = ''
      });

  @override
  State<FilePicker> createState() => _FilePickerState();
}

class _FilePickerState extends State<FilePicker> {
  @override
  Widget build(BuildContext context) {
    print(widget.errorMsg);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Custombutton(
                  onTap: () {
                    showUploadOptions();
                  },
                  buttonName: "Choose file",
                  buttonColor: primaryColor,
                  buttonTextColor: Colors.white),
            ),
          ],
        ),
        if (widget.errorMsg.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 12,top: 6),
            child: Text(widget.errorMsg,style: TextStyle(color: Theme.of(context).colorScheme.error,fontSize: 12,fontWeight: FontWeight.w400),),
          ),
        if (widget.errorMsg.isNotEmpty)
          gapHC(4),
        if (widget.selectedFiles.isNotEmpty) gapHC(10),
        if (widget.selectedFiles.isNotEmpty) ts("File", Colors.black),
        if (widget.selectedFiles.isNotEmpty) gapHC(3),
        if (widget.selectedFiles.isNotEmpty)
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    if(extension(widget.selectedFiles[index]).toLowerCase().endsWith('pdf')){
                      Get.to(()=>PdfViewer(file: "${AppConfig.imageBaseUrl}${widget.selectedFiles[index]}"));
                    }else{
                      Navigator.push(
                        Get.context!,
                        MaterialPageRoute(
                          builder: (context) => GalleryPhotoViewWrapper(
                            galleryItems: [GalleryItem(id: "id:1", resource: "${AppConfig.imageBaseUrl}${widget.selectedFiles[index]}")],
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
                    children: [
                      widget.selectedFiles[index]
                                  .split("/")
                                  .last
                                  .toLowerCase()
                                  .endsWith('jpg') ||
                              widget.selectedFiles[index]
                                  .split("/")
                                  .last
                                  .toLowerCase()
                                  .endsWith('png')
                          ? CachedNetworkImage(
                              imageUrl:
                                  "${AppConfig.imageBaseUrl}${widget.selectedFiles[index]}",
                              height: 70,
                            )
                          : Image.asset(
                              AppAssets.file,
                              height: 70,
                            ),
                      gapWC(10),
                      Expanded(
                          child: ts(''/*widget.selectedFiles[index].split("/").last*/,
                              Colors.black)),
                      gapWC(10),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                          onTap: () {
                            setState(() {
                              widget.selectedFiles.removeAt(index);
                              widget.onChanged.call(widget.selectedFiles);
                            });
                          },
                          child: const CircleAvatar(
                            radius: 14,
                            backgroundColor: primaryColor,
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ))
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
              itemCount: widget.selectedFiles.length),
      ],
    );
  }

  void showUploadOptions() {
    Get.bottomSheet(
        DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 1, width: MediaQuery.sizeOf(context).width),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: ()=> pickFromCamera(context),
                          child: Column(
                            children: [
                              CircleAvatar(
                                  radius:
                                      MediaQuery.sizeOf(context).width * 0.1,
                                  backgroundColor: greyLight,
                                  child: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: primaryColor,
                                  )),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                "Camera",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: ()=> pickFromGallery(context),
                          child: Column(
                            children: [
                              CircleAvatar(
                                  radius:
                                      MediaQuery.sizeOf(context).width * 0.1,
                                  backgroundColor: greyLight,
                                  child: const Icon(
                                    Icons.photo_library_sharp,
                                    color: primaryColor,
                                  )),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                "Gallery",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: ()=> pickFromFiles(context),
                          child: Column(
                            children: [
                              CircleAvatar(
                                  radius:
                                      MediaQuery.sizeOf(context).width * 0.1,
                                  backgroundColor: greyLight,
                                  child: const Icon(
                                    Icons.picture_as_pdf_rounded,
                                    color: primaryColor,
                                  )),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                "PDF",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            expand: false,
            maxChildSize: 1,
            initialChildSize: 0.4),
        backgroundColor: Colors.white);
  }

  pickFromFiles(BuildContext context) async {
    Get.back();
    picker.FilePickerResult? result = await picker.FilePicker.platform
        .pickFiles(allowedExtensions: ['pdf'], type: picker.FileType.custom);

    if (result != null) {
      final file = XFile(result.files.single.path!);

      int fileSizeInBytes = await file.length();
      double fileSizeInMB = fileSizeInBytes / (1024 * 1024);

      if (fileSizeInMB > 16) {
        AppDialog.showToast('File size exceeds the 16MB limit. Please choose a smaller file.',isError: true);
        return;
      }

      String newFile = await uploadFile(file.path,context);
      if (newFile.isNotEmpty) {
        setState(() {
          if (widget.multiple) {
            widget.selectedFiles.add(newFile);
          } else {
            widget.selectedFiles = [newFile];
          }
          widget.onChanged.call(widget.selectedFiles);
        });
      }
    }
  }

  void pickFromCamera(BuildContext context) async {
    Get.back();
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera,imageQuality: 80);
    if (photo != null) {

      int fileSizeInBytes = await photo.length();
      double fileSizeInMB = fileSizeInBytes / (1024 * 1024);

      if (fileSizeInMB > 16) {
        AppDialog.showToast('File size exceeds the 16MB limit. Please choose a smaller file.',isError: true);
        return;
      }


      String newFile = await uploadFile(photo.path,context);
      if (newFile.isNotEmpty) {
        setState(() {
          if (widget.multiple) {
            widget.selectedFiles.add(newFile);
          } else {
            widget.selectedFiles = [newFile];
          }
          widget.onChanged.call(widget.selectedFiles);
        });
      }
    }
  }

  void pickFromGallery(BuildContext context) async {
    Get.back();
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
    if (photo != null) {

      int fileSizeInBytes = await photo.length();
      double fileSizeInMB = fileSizeInBytes / (1024 * 1024);

      if (fileSizeInMB > 16) {
        AppDialog.showToast('File size exceeds the 16MB limit. Please choose a smaller file.',isError: true);
        return;
      }

      String newFile = await uploadFile(photo.path,context);
      if (newFile.isNotEmpty) {
        setState(() {
          if (widget.multiple) {
            widget.selectedFiles.add(newFile);
          } else {
            widget.selectedFiles = [newFile];
          }
          widget.onChanged.call(widget.selectedFiles);
        });
      }
    }
  }

  Future<String> uploadFile(String file,BuildContext context) async {
    try {
      print('file: $file');
      Get.context!.loaderOverlay.show();
      print('shown overlay');
      var response = await MygRepository().uploadFile(file);
      if (response.success) {
        widget.errorMsg = '';
        return response.path;
      } else {
        AppDialog.showToast(response.message,isError: true);
        return '';
      }
    }catch(_){
      AppDialog.showToast("Something went wrong! Try again.",isError: true);
      return '';
    }finally{
      Get.context!.loaderOverlay.hide();
    }
  }
}
