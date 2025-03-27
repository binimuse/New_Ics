import 'package:new_ics/app/modules/my_order/models/order_model_all_appllication.dart';

class GroupedAppliaction {
  CurrentCountry documentType;
  List<ApplicationDocument> document;

  GroupedAppliaction({required this.documentType, required this.document});
}
