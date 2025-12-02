import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:travel_claim/views/components/customButton.dart';
import 'package:travel_claim/views/style/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateController extends GetxController {
  Future<void> checkVersion() async {
    final newVersion = NewVersionPlus(
      androidId: 'com.myg.travel_claim',
      iOSId: '1562152755', // <-- your real iOS App Store ID
    );

    final status = await newVersion.getVersionStatus();
// _showUpdateDialog(status);

    if (status != null && status.canUpdate) {
      _showUpdateDialog(status);
    }
  }

  // void _showUpdateDialog(VersionStatus? status) {
  //   Get.defaultDialog(
  //     title: "Update Available - v${status?.storeVersion}",
  //     content: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text("What's New:"),
  //         SizedBox(height: 8),
  //         Text(status?.releaseNotes ?? 'No release notes available.'),
  //       ],
  //     ),
  //     barrierDismissible: false,
  //     textConfirm: "Update",
  //     confirmTextColor: Get.theme.colorScheme.onPrimary,
  //     onConfirm: () async{
  //         final url = status?.appStoreLink;
  //       if (await canLaunchUrl(Uri.parse(url??""))) {
  //         await launchUrl(Uri.parse(url??""), mode: LaunchMode.externalApplication);
  //       } else {
  //         Get.snackbar('Error', 'Could not launch update URL');
  //       }
  //     },
  //     textCancel: "Later",
  //   );
  // }

  Future<bool> _showUpdateDialog(VersionStatus? status) async {
    bool? result = await Get.dialog<bool>(
      AlertDialog(
        title: Text("Update Available - v${status?.storeVersion}"),
        content: Text(status?.releaseNotes ?? 'No release notes available.'),
        actions: [
          Row(
            children: [
              Expanded(
                child: Custombutton(
                    onTap: () => Get.back(result: true),
                    buttonName: "Later",
                    buttonColor: Colors.white,
                    buttonBorderColor: Colors.grey.shade400,
                    buttonTextColor: primaryColor),
                // TextButton(
                //   onPressed: () => Get.back(result: true),
                //   child: const Text("Discard"),
                // ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Custombutton(
                    onTap: () async {
                      final url = status?.appStoreLink;
                      if (await canLaunchUrl(Uri.parse(url ?? ""))) {
                        await launchUrl(Uri.parse(url ?? ""),
                            mode: LaunchMode.externalApplication);
                      } else {
                        Get.snackbar('Error', 'Could not launch update URL');
                      }
                    },
                    buttonName: "Update",
                    buttonColor: primaryColor,
                    buttonTextColor: Colors.white),
              )
            ],
          ),

          // AppButton(
          //   onPressed:,
          //   child: const Text("Save"),
          // ),
        ],
      ),
      barrierDismissible: false,
    );

    return result ?? false;
  }
}
