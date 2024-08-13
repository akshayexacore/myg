import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart' as picker;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:travel_claim/configs/app_config.dart';
import 'package:travel_claim/resources/myg_repository.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/components/customButton.dart';
import 'package:travel_claim/views/const/appassets.dart';
import 'package:travel_claim/views/style/colors.dart';

class FilePicker extends StatefulWidget {
  List<String> selectedFiles;
  final ValueChanged<List<String>> onChanged;
  final bool multiple;

  FilePicker(
      {super.key,
      required this.onChanged,
      required this.selectedFiles,
      this.multiple = false});

  @override
  State<FilePicker> createState() => _FilePickerState();
}

class _FilePickerState extends State<FilePicker> {
  @override
  Widget build(BuildContext context) {
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
        if (widget.selectedFiles.isNotEmpty) gapHC(10),
        if (widget.selectedFiles.isNotEmpty) ts("Files", Colors.black),
        if (widget.selectedFiles.isNotEmpty) gapHC(3),
        if (widget.selectedFiles.isNotEmpty)
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Row(
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
                        child: ts(widget.selectedFiles[index].split("/").last,
                            Colors.black)),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.selectedFiles.removeAt(index);
                            widget.onChanged.call(widget.selectedFiles);
                          });
                        },
                        child: CircleAvatar(
                          radius: 10,
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 16,
                          ),
                          backgroundColor: Colors.black87,
                        ))
                  ],
                );
              },
              separatorBuilder: (context, index) => SizedBox(
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
                          onTap: pickFromCamera,
                          child: Column(
                            children: [
                              CircleAvatar(
                                  radius:
                                      MediaQuery.sizeOf(context).width * 0.1,
                                  child: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: primaryColor,
                                  ),
                                  backgroundColor: greyLight),
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
                          onTap: pickFromGallery,
                          child: Column(
                            children: [
                              CircleAvatar(
                                  radius:
                                      MediaQuery.sizeOf(context).width * 0.1,
                                  child: const Icon(
                                    Icons.photo_library_sharp,
                                    color: primaryColor,
                                  ),
                                  backgroundColor: greyLight),
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
                          onTap: pickFromFiles,
                          child: Column(
                            children: [
                              CircleAvatar(
                                  radius:
                                      MediaQuery.sizeOf(context).width * 0.1,
                                  child: const Icon(
                                    Icons.picture_as_pdf_rounded,
                                    color: primaryColor,
                                  ),
                                  backgroundColor: greyLight),
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

  pickFromFiles() async {
    Get.back();
    picker.FilePickerResult? result = await picker.FilePicker.platform
        .pickFiles(allowedExtensions: ['pdf'], type: picker.FileType.custom);

    if (result != null) {
      final file = XFile(result.files.single.path!);
      String newFile = await uploadFile(file.path);
      if (newFile.isNotEmpty) {
        setState(() {
          widget.selectedFiles.add(newFile);
          widget.onChanged.call(widget.selectedFiles);
        });
      }
    }
  }

  void pickFromCamera() async {
    Get.back();
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      String newFile = await uploadFile(photo.path);
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

  void pickFromGallery() async {
    Get.back();
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      String newFile = await uploadFile(photo.path);
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

  Future<String> uploadFile(String file) async {
    // Get the application directory

    var response = await MygRepository().uploadFile(file);
    if (response.success) {
      return response.path;
    } else {
      return '';
    }
    /*Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    // Copy the file to the application directory
    String newFilePath = '$appDocPath/${XFile(file).name}';
    await File(file).copy(newFilePath);

    return newFilePath;*/
  }
}
