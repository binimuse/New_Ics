import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_ics/app/common/model/basemodel.dart';
import 'package:new_ics/app/data/enums.dart';
import 'package:new_ics/app/modules/my_order/models/grouped_application.dart';
import 'package:new_ics/app/modules/my_order/models/order_model_all_appllication.dart';

class MyOrderController extends GetxController
    with SingleGetTickerProviderMixin {
  final count = 0.obs;
  var selectedRating = 0.obs;
  late TabController tabController;
  late TabController tabControllerorgin;
  late TabController tabControllervisa;
  late TabController tabControllerPassport;
  late TabController tabControllerTravel;
  final TextEditingController complaint = TextEditingController();
  late TabController nestedTabController;
  @override
  void onInit() {
    getPassportOrder();

    // getTravelApplication();
    // getDoc();
    tabController = TabController(length: 6, vsync: this);
    tabControllerorgin = TabController(length: 3, vsync: this);
    tabControllervisa = TabController(length: 3, vsync: this);
    tabControllerPassport = TabController(length: 3, vsync: this);
    tabControllerTravel = TabController(length: 3, vsync: this);
    nestedTabController = TabController(length: 2, vsync: this);

    super.onInit();
  }

  void getPassportOrder() {}

  RxList<IcsApplication> allApplicationModel = List<IcsApplication>.of([]).obs;

  var isfechedorder = false.obs;

  Rx<NetworkStatus> networkStatus = Rx(NetworkStatus.IDLE);

  List<CommonModel> base_document_types = [];

  // Future<void> getDoc() async {
  //   try {
  //     dynamic result = await graphQLCommonApi.query(getDocType.fetchData(), {});

  //     baseData.value = BaseDocModel.fromJson(result);

  //     base_document_types =
  //         baseData.value!.base_document_types.map((e) => e).toList();

  //     for (var documentType in base_document_types) {
  //       documents.add(
  //         OrginIDDocuments(documentTypeId: documentType.id, files: []),
  //       );
  //     }
  //   } catch (e, s) {
  //     print(e);
  //     print(s);
  //   }
  // }

  RxList<GroupedAppliaction> groupedAppliaction =
      List<GroupedAppliaction>.of([]).obs;

  List<CurrentCountry> documentspassport = [];
  groupDocumnats(String applicationid) {
    groupedAppliaction.clear();

    allApplicationModel.forEach((element) {
      if (element.id == applicationid) {
        element.applicationDocuments.forEach((element) {
          final docTypeID = element.documentType.id;
          int existingIndex = groupedAppliaction.indexWhere(
            (group) => group.documentType.id == docTypeID,
          );

          if (existingIndex != -1) {
            // If an existing OrderGroup is found, add the order to its list of orders
            groupedAppliaction[existingIndex].document.add(element);
          } else {
            // If no existing OrderGroup is found, create a new OrderGroup and add it to the list
            GroupedAppliaction newGroup = GroupedAppliaction(
              documentType: element.documentType,
              document: [element],
            );

            groupedAppliaction.add(newGroup);
          }
        });
      }
    });
  }

  // RxList<GroupedAppliactionResidency> groupedAppliactionResidency =
  //     List<GroupedAppliactionResidency>.of([]).obs;

  // groupDocumnatsForResidency(String applicationid) {
  //   groupedAppliactionResidency.clear();

  //   residencyModel.forEach((element) {
  //     if (element.id == applicationid) {
  //       element.residencyApplicationDocuments!.forEach((element) {
  //         final docTypeID = element.documentType.id;
  //         int existingIndex = groupedAppliactionResidency.indexWhere(
  //           (group) => group.documentType.id == docTypeID,
  //         );

  //         if (existingIndex != -1) {
  //           // If an existing OrderGroup is found, add the order to its list of orders
  //           groupedAppliactionResidency[existingIndex].document.add(element);
  //         } else {
  //           // If no existing OrderGroup is found, create a new OrderGroup and add it to the list
  //           GroupedAppliactionResidency newGroup = GroupedAppliactionResidency(
  //             documentType: element.documentType,
  //             document: [element],
  //           );

  //           groupedAppliactionResidency.add(newGroup);
  //         }
  //       });
  //     }
  //   });
  // }

  // RxList<GroupedAppliactionExitVisa> groupedAppliactionExitVisa =
  //     List<GroupedAppliactionExitVisa>.of([]).obs;

  // groupDocumnatsForExitVisa(String applicationid) {
  //   groupedAppliactionExitVisa.clear();

  //   icsExitVisaApplication.forEach((element) {
  //     if (element.id == applicationid) {
  //       element.exitVisaDocuments!.forEach((element) {
  //         final docTypeID = element.documentType!.id;
  //         int existingIndex = groupedAppliactionExitVisa.indexWhere(
  //           (group) => group.documentType.id == docTypeID,
  //         );

  //         if (existingIndex != -1) {
  //           // If an existing OrderGroup is found, add the order to its list of orders
  //           groupedAppliactionExitVisa[existingIndex].document.add(element);
  //         } else {
  //           // If no existing OrderGroup is found, create a new OrderGroup and add it to the list
  //           GroupedAppliactionExitVisa newGroup = GroupedAppliactionExitVisa(
  //             documentType: element.documentType!,
  //             document: [element],
  //           );

  //           groupedAppliactionExitVisa.add(newGroup);
  //         }
  //       });
  //     }
  //   });
  // }

  // RxList<GroupedAppliactionVisa> groupedAppliactionvisa =
  //     List<GroupedAppliactionVisa>.of([]).obs;

  // groupDocumnatsForVisa(String applicationid) {
  //   groupedAppliactionvisa.clear();

  //   allVisaApplicationModel.forEach((element) {
  //     if (element.id == applicationid) {
  //       element.visaApplicationDocuments.forEach((element) {
  //         final docTypeID = element.documentType.id;
  //         int existingIndex = groupedAppliactionvisa.indexWhere(
  //           (group) => group.documentType.id == docTypeID,
  //         );

  //         if (existingIndex != -1) {
  //           // If an existing OrderGroup is found, add the order to its list of orders
  //           groupedAppliactionvisa[existingIndex].document.add(element);
  //         } else {
  //           // If no existing OrderGroup is found, create a new OrderGroup and add it to the list
  //           GroupedAppliactionVisa newGroup = GroupedAppliactionVisa(
  //             documentType: element.documentType,
  //             document: [element],
  //           );

  //           groupedAppliactionvisa.add(newGroup);
  //         }
  //       });
  //     }
  //   });
  // }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    tabController.dispose();
    nestedTabController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
  //reupload

  var isSendStared = false.obs;
  var isSendDocSuccess = false.obs;
  var newDocId;
  Future<void> sendDoc(
    var documentTypeId,
    var path,
    var newApplicationId,
    bool isVisa,
  ) async {
    try {
      // file upload
      if (isVisa == false) {
        // forpassportAndOrgin(documentTypeId, path, newApplicationId);
      } else {
        //     forVisa(documentTypeId, path, newApplicationId);
      }
    } catch (e) {
      networkStatus.value = NetworkStatus.ERROR;
      isSendDocSuccess(false);
      print('Error: $e');
    }
  }

  // void forpassportAndOrgin(documentTypeId, path, newApplicationId) async {
  //   GraphQLClient graphQLClient;
  //   graphQLClient = GraphQLConfiguration().clientToQuery();

  //   final QueryResult result = await graphQLClient.mutate(
  //     MutationOptions(
  //       document: gql(NewDocApplications.newDoc),
  //       variables: <String, dynamic>{
  //         'objects': {
  //           'application_id': newApplicationId,
  //           'files': {'path': path},
  //           'document_type_id': documentTypeId,
  //         },
  //       },
  //     ),
  //   );

  //   if (result.hasException) {
  //     networkStatus.value = NetworkStatus.ERROR;
  //     print(result.exception.toString());
  //   } else {
  //     networkStatus.value = NetworkStatus.SUCCESS;
  //     isSendDocSuccess(true);

  //     AppToasts.showSuccess("Document uploaded successfully".tr);

  //     // Update the specific document and order
  //     documents.clear();
  //     Get.back();
  //     getOrginOrder();
  //   }
  // }

  // void forVisa(documentTypeId, path, newApplicationId) async {
  //   GraphQLClient graphQLClient;

  //   graphQLClient = GraphQLConfiguration().clientToQuery();

  //   final QueryResult result = await graphQLClient.mutate(
  //     MutationOptions(
  //       document: gql(NewDocApplicationsVisa.newDoc),
  //       variables: <String, dynamic>{
  //         'objects': {
  //           'visa_application_id': newApplicationId,
  //           'files': {'path': path},
  //           'document_type_id': documentTypeId,
  //         },
  //       },
  //     ),
  //   );

  //   if (result.hasException) {
  //     networkStatus.value = NetworkStatus.ERROR;
  //     print(result.exception.toString());
  //   } else {
  //     networkStatus.value = NetworkStatus.SUCCESS;
  //     isSendDocSuccess(true);

  //     AppToasts.showSuccess("Document uploaded successfully".tr);

  //     documents.clear();

  //     Get.back();
  //     // groupDocumnats(newApplicationId);

  //     getVisaApplication();
  //   }
  // }
}
