import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:path/path.dart';
class PdfViewer extends StatefulWidget {
  final String file;
  const PdfViewer({Key? key, required this.file}) : super(key: key);

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  bool _isLoading = true;
  late PDFDocument document;
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
        child: _isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : PDFViewer(
          document: document,
        ),
      ),
    );
  }
}