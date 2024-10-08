import 'dart:io';

import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
class PdfViewer extends StatefulWidget {
  final String file;
  const PdfViewer({Key? key, required this.file}) : super(key: key);

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  bool _isLoading = true;
   PDFDocument? document;
  DownloadProgress? downloadProgress;

  @override
  void initState() {
    loadDocument();
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void loadDocument() async {

    PDFDocument.fromURLWithDownloadProgress(
      widget.file,
      downloadProgress: (downloadProgress) => setState(() {
        this.downloadProgress = downloadProgress;
      }),
      onDownloadComplete: (document) => setState(() {
        this.document = document;
        _isLoading = false;
      }),
    );
  }


//     Future<void> loadDocument() async {
//   try {
//     // Download the PDF to local storage
//     var dir = await getApplicationDocumentsDirectory();
//     String filePath = "${dir.path}/sample.pdf";

//     var response = await http.get(Uri.parse(widget.file));
    
//     if (response.statusCode != 200) {
//       throw Exception('Failed to load PDF: ${response.statusCode}');
//     }

//     File file = File(filePath);
//     await file.writeAsBytes(response.bodyBytes);

//     // Load the PDF document from the local file
//     PDFDocument doc = await PDFDocument.fromFile(file);
//     setState(() {
//       document = doc;
//       _isLoading = false;
//     });
//   } catch (e) {
//     print('Error loading PDF: $e');
//     setState(() {
//       _isLoading = false;
//     });
//   }
// }


  Widget buildProgress() {
    if (downloadProgress == null) return const SizedBox();

    String parseBytesToKBs(int? bytes) {
      if (bytes == null) return '0 KBs';

      return '${(bytes / 1000).toStringAsFixed(2)} KBs';
    }

    String progressString = parseBytesToKBs(downloadProgress!.downloaded);
    if (downloadProgress!.totalSize != null) {
      progressString += '/ ${parseBytesToKBs(downloadProgress!.totalSize)}';
    }

    return Column(
      children: [
        const SizedBox(height: 20),
        Text(progressString),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(basename(widget.file)),
      body: SafeArea(
        child: _isLoading ||document==null
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : PDFViewer(
          document: document!,
        ),
      ),
    );
  }
}