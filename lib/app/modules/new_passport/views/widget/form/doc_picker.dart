import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_ics/app/common/app_toasts.dart';
import 'package:new_ics/app/common/fileupload/common_file_uploder.dart';
import 'package:new_ics/app/common/fileupload/pdfpicker.dart';
import 'package:new_ics/app/common/model/basemodel.dart';
import 'package:new_ics/app/data/enums.dart';
import 'package:new_ics/app/data/models/passport/base_document_type.dart';
import 'package:new_ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:new_ics/app/theme/app_colors.dart';
import 'package:new_ics/app/theme/app_text_styles.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class BuildDoc extends StatefulWidget {
  final BasedocumentCategoryType basedocumentCategoryType;
  final NewPassportController controller;

  const BuildDoc({
    required this.basedocumentCategoryType,
    required this.controller,
  });

  @override
  _BuildDocState createState() => _BuildDocState();
}

class _BuildDocState extends State<BuildDoc> {
  bool isUploading = false;
  double uploadProgress = 0.0;
  bool hasError = false;

  Future<void> openPdfPicker() async {
    widget.controller.networkStatus.value = NetworkStatus.LOADING;

    try {
      PlatformFile? pickedFile = await PdfPicker.pickPdfFile();
      if (pickedFile != null) {
        try {
          handleFilePickedSuccess(pickedFile);
        } catch (e, s) {
          widget.controller.networkStatus.value = NetworkStatus.ERROR;
          setState(() {
            hasError = true;
          });

          AppToasts.showError("error  while getting the URL.".tr);

          print("Error in geturl: $s");
        }
      }
      widget.controller.networkStatus.value = NetworkStatus.SUCCESS;
    } catch (e) {
      widget.controller.networkStatus.value = NetworkStatus.ERROR;

      // Handle the error
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        openPdfPicker();
      },
      child:
          hasError
              ? Container() // Return an empty Container when there's an error
              : Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryLighter.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.file_copy, color: AppColors.primary),
                    SizedBox(height: 1.h),
                    Text(
                      'Upload ${widget.basedocumentCategoryType.documentType.name}',
                      style: AppTextStyles.bodySmallBold.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount:
                            widget.controller.documents
                                .firstWhere(
                                  (element) =>
                                      element.documentTypeId ==
                                      widget.basedocumentCategoryType.id,
                                )
                                .files
                                .length,
                        itemBuilder: (BuildContext context, int index) {
                          final file =
                              widget.controller.documents
                                  .firstWhere(
                                    (element) =>
                                        element.documentTypeId ==
                                        widget.basedocumentCategoryType.id,
                                  )
                                  .files[index];
                          return FileItem(
                            file: file,
                            onDelete: () => deleteFile(index),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
    );
  }

  void deleteFile(int index) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDeleteDialog();
      },
    );

    if (confirmDelete == true) {
      setState(() {
        var documentEntry = widget.controller.documents.firstWhere(
          (element) =>
              element.documentTypeId == widget.basedocumentCategoryType.id,
        );
        documentEntry.files.removeAt(index);

        // If no files are left, remove the document entry
        if (documentEntry.files.isEmpty) {
          widget.controller.documents.remove(documentEntry);
        }
      });
    }
  }

  void handleFilePickedSuccess(PlatformFile pickedFile) {
    _handleFilePickedSuccess(pickedFile);
  }

  Future<void> _handleFilePickedSuccess(PlatformFile pickedFile) async {
    // Find the document entry for the current document type
    var documentEntry = widget.controller.documents.firstWhere(
      (element) => element.documentTypeId == widget.basedocumentCategoryType.id,
      orElse:
          () => PassportDocuments(
            documentTypeId: widget.basedocumentCategoryType.id,
            files: [],
          ),
    );

    // If the document entry doesn't exist, add it
    if (!widget.controller.documents.contains(documentEntry)) {
      widget.controller.documents.add(documentEntry);
    }

    // Add the picked file to the document entry
    documentEntry.files.add(pickedFile);

    // Update the UI
    setState(() {});
  }
}

class FileItem extends StatelessWidget {
  final PlatformFile file;
  final VoidCallback onDelete;

  const FileItem({required this.file, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(height: 18.h, child: PDFView(filePath: file.path!)),
        Positioned(
          top: 8.0,
          right: 8.0,
          child: GestureDetector(
            onTap: onDelete,
            child: Icon(Icons.delete, color: Colors.red),
          ),
        ),
      ],
    );
  }
}

class ConfirmDeleteDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Confirm Delete".tr, style: AppTextStyles.bodyLargeBold),
      content: Text(
        "Are you sure you want to delete the file?".tr,
        textAlign: TextAlign.start,
        style: AppTextStyles.captionRegular,
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(
              context,
            ).pop(false); // Return false if cancel is pressed
          },
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 5.h,
            width: 25.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primary],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(22)),
            ),
            child: Center(
              child: Text(
                "Cancel".tr,
                style: AppTextStyles.bodyLargeBold.copyWith(
                  color: AppColors.whiteOff,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop(true); // Return true if delete is pressed
          },
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 5.h,
            width: 25.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.danger, AppColors.danger],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(22)),
            ),
            child: Center(
              child: Text(
                "Delete".tr,
                style: AppTextStyles.bodyLargeBold.copyWith(
                  color: AppColors.whiteOff,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
