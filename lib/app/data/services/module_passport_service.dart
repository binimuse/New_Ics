import 'package:dio/dio.dart' hide Headers;
import 'package:new_ics/app/data/models/passport/base_country.dart';
import 'package:new_ics/app/data/models/passport/base_document_type.dart';
import 'package:new_ics/app/data/models/passport/base_embassiy.dart';
import 'package:new_ics/app/data/models/passport/base_occupation.dart';
import 'package:new_ics/app/data/models/passport/base_regions.dart';
import 'package:new_ics/app/data/models/passport/passport_page_price.dart';
import 'package:new_ics/app/data/models/passport/passport_page_size.dart';
import 'package:new_ics/app/data/models/passport/passport_responce.dart';
import 'package:new_ics/app/data/models/passport/passport_type.dart';
import 'package:new_ics/app/data/models/passport/passport_urgency_type.dart';
import 'package:new_ics/app/utils/constants.dart';

import 'package:retrofit/retrofit.dart';

part 'module_passport_service.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class PassportService {
  factory PassportService(Dio dio) = _PassportService;

  @GET(Constants.getPassportType)
  Future<List<PassportTypeResponse>> getPassportTypeResponse();

  @GET(Constants.getPassportpagesize)
  Future<List<BasePassportPageSize>> getPassportPageSize();

  @GET(Constants.getPassporturgencylevel)
  Future<List<BasePassportUrgencyType>> getPassporturgencylevel();

  @GET(Constants.getregion)
  Future<List<BaseRegionResponce>> getregions(
    @Path("country_id") String country_id,
  );

  @GET(Constants.getpassportprice)
  Future<List<BasePassportPrice>> getPassportPrice();

  @GET(Constants.getcountry)
  Future<List<BaseCountry>> getCountry();

  @GET(Constants.getbranch)
  Future<List<BaseEmbassies>> getembassy(@Path("country_id") String country_id);

  @GET(Constants.getoccupation)
  Future<List<BaseOccupation>> getoccupation();

  @GET(Constants.getdocumenttype)
  Future<List<BasedocumentCategoryType>> getdocumenttype(
    @Path("code") String code,
  );

  @POST(Constants.sendPassportData)
  Future<PassportResponce> sendPassport({@Body() required FormData formData});
}
