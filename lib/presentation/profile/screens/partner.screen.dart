import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../../controllers/profile.controller.dart';
import '../../../global/helpers/storage.dart';
import '../../../global/layouts/defauft.layout.dart';
import '../../../global/themes/color.theme.dart';
import '../../../global/themes/input.theme.dart';
import '../../../global/themes/layout.theme.dart';
import '../../../global/widgets/gutter.dart';
import 'package:intl/intl.dart';
import '../../../models/profile/gender.model.dart';
import '../../../models/profile/province.model.dart';
import '../../../models/profile/service.model.dart';
import '../../../models/profile/ward.model.dart';

class PartnerScreen extends StatefulWidget {
  PartnerScreen({Key? key}) : super(key: key);

  @override
  _PartnerScreenState createState() => _PartnerScreenState();
}

class _PartnerScreenState extends State<PartnerScreen> {
  ProfileController _profileController = Get.find();
  GlobalKey<FormBuilderState> _formKey = new GlobalKey<FormBuilderState>();

  List<GenderModel> genderList = [];
  List<ServiceModel> serviceList = [];
  List<ProvinceModel> provinceList = [];
  List<WardModel> wardList = [];

  getGenderList() async {
    genderList = await _profileController.getGenderList();
    setState(() {});
  }

  getServiceList() async {
    serviceList = await _profileController.getServiceList();
    setState(() {});
  }

  getProvinceList() async {
    provinceList = await _profileController.getProvinceList();
    setState(() {});
  }

  getWardList(int provinceId) async {
    wardList = await _profileController.getWardList(provinceId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      initState: (_profileController) {
        getGenderList();
        getServiceList();
        getProvinceList();
      },
      builder: (controller) {
        return DefaultLayout(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              brightness: Brightness.dark,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                "Partner",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: Container(
              color: Colors.white,
              height: double.infinity,
              width: double.infinity,
              child: IndexedStack(
                index: 0,
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.only(left: gutter, right: gutter, top: gutter, bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? (MediaQuery.of(context).viewInsets.bottom + gutter) : gutter),
                    child: Column(
                      children: [
                        FormBuilder(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // 1. Partner Information
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "1. Partner Infomation",
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
                                  ),

                                  Gutter(),

                                  // Username
                                  FormBuilderTextField(
                                    name: "nickname",
                                    cursorColor: primaryColor,
                                    readOnly: true,
                                    decoration: inputDecoration.copyWith(
                                      hintText: "Nickname",
                                      prefixIcon: Icon(Icons.person),
                                    ),
                                    initialValue: controller.userPartnerModel!.nickname,
                                  ),

                                  Gutter(),

                                  FormBuilderTextField(
                                    name: "gender",
                                    cursorColor: primaryColor,
                                    readOnly: true,
                                    decoration: inputDecoration.copyWith(
                                      hintText: "Gender",
                                      prefixIcon: Icon(Icons.transgender),
                                    ),
                                    initialValue: controller.genderList.where((element) => element.id == controller.userPartnerModel!.genderId).first.name.toString().capitalizeFirst.toString(),
                                  ),

                                  Gutter(),

                                  FormBuilderTextField(
                                    name: "birthday",
                                    cursorColor: primaryColor,
                                    readOnly: true,
                                    decoration: inputDecoration.copyWith(
                                      hintText: "Birthday",
                                      prefixIcon: Icon(Icons.cake),
                                      suffixIcon: Icon(Icons.today),
                                    ),
                                    initialValue: DateFormat('dd/MM/yyyy').format(controller.userPartnerModel!.birthday!),
                                  ),

                                  Gutter(),

                                  // Height
                                  FormBuilderTextField(
                                    name: "height",
                                    cursorColor: primaryColor,
                                    keyboardType: TextInputType.number,
                                    readOnly: true,
                                    decoration: inputDecoration.copyWith(
                                      prefixText: "Height: ",
                                      hintText: "Height",
                                      prefixIcon: Icon(Icons.accessibility),
                                      suffixText: "cm",
                                    ),
                                    initialValue: controller.userPartnerModel!.height.toString(),
                                  ),

                                  Gutter(),

                                  // Weight
                                  FormBuilderTextField(
                                    name: "weight",
                                    cursorColor: primaryColor,
                                    keyboardType: TextInputType.number,
                                    readOnly: true,
                                    decoration: inputDecoration.copyWith(
                                      prefixText: "Weight: ",
                                      hintText: "Weight",
                                      prefixIcon: Icon(Icons.accessibility),
                                      suffixText: "kg",
                                    ),
                                    initialValue: controller.userPartnerModel!.weight.toString(),
                                  ),

                                  Gutter(),

                                  // bust
                                  FormBuilderTextField(
                                    name: "bust",
                                    cursorColor: primaryColor,
                                    keyboardType: TextInputType.number,
                                    readOnly: true,
                                    decoration: inputDecoration.copyWith(
                                      prefixText: "Bust: ",
                                      hintText: "Bust",
                                      prefixIcon: Icon(Icons.accessibility),
                                      suffixText: "cm",
                                    ),
                                    initialValue: controller.userPartnerModel!.bust.toString(),
                                  ),

                                  Gutter(),

                                  // waist
                                  FormBuilderTextField(
                                    name: "waist",
                                    cursorColor: primaryColor,
                                    keyboardType: TextInputType.number,
                                    readOnly: true,
                                    decoration: inputDecoration.copyWith(
                                      prefixText: "Waist: ",
                                      hintText: "Waist",
                                      prefixIcon: Icon(Icons.accessibility),
                                      suffixText: "cm",
                                    ),
                                    initialValue: controller.userPartnerModel!.waist.toString(),
                                  ),

                                  Gutter(),

                                  // hips
                                  FormBuilderTextField(
                                    name: "hips",
                                    cursorColor: primaryColor,
                                    keyboardType: TextInputType.number,
                                    readOnly: true,
                                    decoration: inputDecoration.copyWith(
                                      prefixText: "Hips: ",
                                      hintText: "Hips",
                                      prefixIcon: Icon(Icons.accessibility),
                                      suffixText: "cm",
                                    ),
                                    initialValue: controller.userPartnerModel!.hips.toString(),
                                  ),
                                ],
                              ),

                              Gutter(scale: 2),

                              // 2. Partner Services
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "2. Partner Services",
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
                                  ),
                                  Gutter(),
                                  ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.userPartnerModel!.skill!.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
                                        margin: EdgeInsets.all(0),
                                        child: Container(
                                          padding: EdgeInsets.all(gutter),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: FormBuilderTextField(
                                                      name: 'serivce_name_$index',
                                                      cursorColor: primaryColor,
                                                      keyboardType: TextInputType.number,
                                                      readOnly: true,
                                                      decoration: inputDecoration.copyWith(hintText: "Name"),
                                                      initialValue: controller.userPartnerModel!.skill![index].nameSkill.toString(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Gutter(),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: FormBuilderTextField(
                                                      name: 'serivce_price_$index',
                                                      cursorColor: primaryColor,
                                                      keyboardType: TextInputType.number,
                                                      readOnly: true,
                                                      decoration: inputDecoration.copyWith(hintText: "Price", suffixText: " \$"),
                                                      initialValue: controller.userPartnerModel!.skill![index].price.toString(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) => Gutter(),
                                  ),
                                ],
                              ),

                              Gutter(scale: 2),

                              // 3. Partner Location
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "3. Partner Location ",
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
                                  ),
                                  Gutter(),
                                  Card(
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
                                    margin: EdgeInsets.all(0),
                                    child: Container(
                                      padding: EdgeInsets.all(gutter),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.location_city),
                                              Gutter(),
                                              Expanded(
                                                child: FormBuilderTextField(
                                                  name: 'province',
                                                  cursorColor: primaryColor,
                                                  keyboardType: TextInputType.number,
                                                  readOnly: true,
                                                  decoration: inputDecoration.copyWith(hintText: "Name"),
                                                  initialValue: controller.provinceList.where((element) => element.id == controller.userPartnerModel!.provinceId).first.nameProvince,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
                                              maxHeight: Get.height * 0.5,
                                            ),
                                            child: ListView.separated(
                                              physics: NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: controller.userPartnerModel!.districts!.length,
                                              itemBuilder: (context, index) => ListTile(
                                                leading: Icon(Icons.check),
                                                title: Text(controller.userPartnerModel!.districts![index].nameDistrict!),
                                              ),
                                              separatorBuilder: (context, index) => Gutter(scale: 0.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),

                              Gutter(scale: 2),

                              // 4. Partner Gallery
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "4. Partner Gallery",
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
                                  ),
                                  Gutter(),
                                  StaggeredGridView.countBuilder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    crossAxisCount: 4,
                                    itemCount: controller.userPartnerModel!.imageNude!.length,
                                    itemBuilder: (BuildContext context, int index) => Card(
                                      elevation: 3,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(borderRadius),
                                      ),
                                      child: Image.network(
                                        Storage(StorageName.baseUrl).read() + controller.userPartnerModel!.imageNude![index].img,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    staggeredTileBuilder: (int index) => new StaggeredTile.count(2, 3),
                                    mainAxisSpacing: gutter,
                                    crossAxisSpacing: gutter,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
