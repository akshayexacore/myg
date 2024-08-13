import 'package:flutter/material.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/const/appassets.dart';

class NodatainprofileScreen extends StatefulWidget {
  const NodatainprofileScreen({super.key});

  @override
  State<NodatainprofileScreen> createState() => _NodatainprofileScreenState();
}

class _NodatainprofileScreenState extends State<NodatainprofileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar("Profile"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppAssets.warning,),
            gapHC(20),
            tss("Your data is being fetched;please be patient", Colors.black, 15.0)

          ],
        ),
      ),

    ));
  }
}
