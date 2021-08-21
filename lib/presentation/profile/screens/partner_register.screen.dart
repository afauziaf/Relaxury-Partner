import 'dart:io';

import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:relaxury_partner/global/routes/name.route.dart';
import 'package:relaxury_partner/presentation/profile/screens/partner_register_confirmation.screen.dart';
import '../../../controllers/profile.controller.dart';
import '../../../global/helpers/snackbar.helper.dart';
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

class PartnerRegisterScreen extends StatefulWidget {
  PartnerRegisterScreen({Key? key}) : super(key: key);

  @override
  _PartnerRegisterScreenState createState() => _PartnerRegisterScreenState();
}

class _PartnerRegisterScreenState extends State<PartnerRegisterScreen> {
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
                "Partner Register",
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
                                    decoration: inputDecoration.copyWith(
                                      hintText: "Nickname",
                                      prefixIcon: Icon(Icons.person),
                                    ),
                                    validator: (value) {
                                      if (value != null && value.length > 0) {
                                        return null;
                                      } else {
                                        return "Username is required";
                                      }
                                    },
                                  ),

                                  Gutter(),

                                  FormBuilderDropdown(
                                    name: 'gender',
                                    decoration: inputDecoration.copyWith(
                                      hintText: "Gender",
                                      prefixIcon: Icon(Icons.transgender),
                                    ),
                                    items: genderList
                                        .map((gender) => DropdownMenuItem(
                                              value: gender.id,
                                              child: Text(gender.name!.capitalizeFirst.toString()),
                                            ))
                                        .toList(),
                                    validator: (value) {
                                      if (value != null) {
                                        return null;
                                      } else {
                                        return "Gender is required";
                                      }
                                    },
                                  ),

                                  Gutter(),

                                  // Birthday
                                  FormBuilderDateTimePicker(
                                    name: 'birthday',
                                    inputType: InputType.date,
                                    format: DateFormat('dd/MM/yyyy'),
                                    decoration: inputDecoration.copyWith(
                                      hintText: "Birthday",
                                      prefixIcon: Icon(Icons.cake),
                                      suffixIcon: Icon(Icons.today),
                                    ),
                                    validator: (value) {
                                      if (value != null) {
                                        if (value.isAfter(DateTime.now())) {
                                          return "Birthday is valid";
                                        } else {
                                          return null;
                                        }
                                      } else {
                                        return "Birthday is required";
                                      }
                                    },
                                  ),

                                  Gutter(),

                                  // Height
                                  FormBuilderTextField(
                                    name: "height",
                                    cursorColor: primaryColor,
                                    keyboardType: TextInputType.number,
                                    decoration: inputDecoration.copyWith(hintText: "Height", prefixIcon: Icon(Icons.accessibility), suffixText: "cm"),
                                    validator: (value) {
                                      if (value != null && value.length > 0) {
                                        if (int.parse(value) < 200) {
                                          return null;
                                        } else {
                                          return "Please enter value smaller than 200";
                                        }
                                      } else {
                                        return "Username is required";
                                      }
                                    },
                                  ),

                                  Gutter(),

                                  // Weight
                                  FormBuilderTextField(
                                    name: "weight",
                                    cursorColor: primaryColor,
                                    keyboardType: TextInputType.number,
                                    decoration: inputDecoration.copyWith(hintText: "Weight", prefixIcon: Icon(Icons.accessibility), suffixText: "Kg"),
                                    validator: (value) {
                                      if (value != null && value.length > 0) {
                                        if (int.parse(value) < 200) {
                                          return null;
                                        } else {
                                          return "Please enter value smaller than 200";
                                        }
                                      } else {
                                        return "Weight is required";
                                      }
                                    },
                                  ),

                                  Gutter(),

                                  // Bust
                                  FormBuilderTextField(
                                    name: "bust",
                                    cursorColor: primaryColor,
                                    keyboardType: TextInputType.number,
                                    decoration: inputDecoration.copyWith(hintText: "Bust", prefixIcon: Icon(Icons.accessibility), suffixText: "cm"),
                                    validator: (value) {
                                      if (value != null && value.length > 0) {
                                        if (int.parse(value) < 200) {
                                          return null;
                                        } else {
                                          return "Please enter value smaller than 200";
                                        }
                                      } else {
                                        return "Bust is required";
                                      }
                                    },
                                  ),

                                  Gutter(),

                                  // Waist
                                  FormBuilderTextField(
                                    name: "waist",
                                    cursorColor: primaryColor,
                                    keyboardType: TextInputType.number,
                                    decoration: inputDecoration.copyWith(hintText: "Waist", prefixIcon: Icon(Icons.accessibility), suffixText: "cm"),
                                    validator: (value) {
                                      if (value != null && value.length > 0) {
                                        if (int.parse(value) < 200) {
                                          return null;
                                        } else {
                                          return "Please enter value smaller than 200";
                                        }
                                      } else {
                                        return "Waist is required";
                                      }
                                    },
                                  ),

                                  Gutter(),

                                  // Hips
                                  FormBuilderTextField(
                                    name: "hips",
                                    cursorColor: primaryColor,
                                    keyboardType: TextInputType.number,
                                    decoration: inputDecoration.copyWith(hintText: "Hips", prefixIcon: Icon(Icons.accessibility), suffixText: "cm"),
                                    validator: (value) {
                                      if (value != null && value.length > 0) {
                                        if (int.parse(value) < 200) {
                                          return null;
                                        } else {
                                          return "Please enter value smaller than 200";
                                        }
                                      } else {
                                        return "Hips is required";
                                      }
                                    },
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
                                  if (controller.partnerModel.serviceList.isNotEmpty) Gutter(),
                                  ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.partnerModel.serviceList.length,
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
                                                  Icon(Icons.book),
                                                  Gutter(),
                                                  Expanded(
                                                    child: FormBuilderDropdown(
                                                      name: 'serivce_$index',
                                                      decoration: inputDecoration.copyWith(
                                                        hintText: "Select your Service",
                                                      ),
                                                      items: serviceList
                                                          .map((service) => DropdownMenuItem(
                                                                value: service.id,
                                                                child: Text(service.name!.capitalizeFirst.toString()),
                                                              ))
                                                          .toList(),
                                                      validator: (value) {
                                                        if (value != null) {
                                                          return null;
                                                        } else {
                                                          return "Service is required";
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Gutter(),
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        controller.partnerModel.serviceList.removeAt(index);
                                                      });
                                                    },
                                                    child: Icon(Icons.clear),
                                                  ),
                                                  Gutter(),
                                                  Expanded(
                                                    child: FormBuilderTextField(
                                                      name: 'serivce_price_$index',
                                                      cursorColor: primaryColor,
                                                      keyboardType: TextInputType.number,
                                                      decoration: inputDecoration.copyWith(hintText: "Price", suffixText: " \$"),
                                                      onChanged: (value) {
                                                        if (value != null) controller.partnerModel.serviceList[index].price = double.parse(value);
                                                      },
                                                      validator: (value) {
                                                        if (value != null && value.length > 0) {
                                                          if (int.parse(value) > 0) {
                                                            return null;
                                                          } else {
                                                            return "Please enter value larger than 0";
                                                          }
                                                        } else {
                                                          return "Price is required";
                                                        }
                                                      },
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
                                  Gutter(),
                                  if (serviceList.isNotEmpty)
                                    Container(
                                      decoration: DottedDecoration(
                                        shape: Shape.box,
                                        borderRadius: BorderRadius.circular(borderRadius),
                                      ),
                                      child: ListTile(
                                        onTap: () {
                                          setState(() {
                                            controller.partnerModel.serviceList.add(serviceList.first);
                                          });
                                        },
                                        leading: Icon(Icons.add),
                                        title: Text(
                                          "Add a new Services",
                                          style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
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
                                                child: FormBuilderDropdown(
                                                  name: 'province',
                                                  decoration: inputDecoration.copyWith(
                                                    hintText: "Select your Province",
                                                  ),
                                                  onChanged: (value) {
                                                    getWardList(value as int);
                                                  },
                                                  items: provinceList
                                                      .map((province) => DropdownMenuItem(
                                                            value: province.id,
                                                            child: Text(province.nameProvince!.capitalizeFirst.toString()),
                                                          ))
                                                      .toList(),
                                                  validator: (value) {
                                                    if (value != null) {
                                                      return null;
                                                    } else {
                                                      return "Province is required";
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (wardList.isNotEmpty) Gutter(),
                                          Container(
                                            constraints: BoxConstraints(
                                              maxHeight: Get.height * 0.5,
                                            ),
                                            child: ListView.separated(
                                              // physics: NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: wardList.length,
                                              itemBuilder: (context, index) => ListTile(
                                                leading: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      if (controller.partnerModel.wardIdList.contains(wardList[index].id)) {
                                                        controller.partnerModel.wardIdList.remove(wardList[index].id);
                                                      } else {
                                                        controller.partnerModel.wardIdList.add(wardList[index].id!);
                                                      }
                                                    });
                                                  },
                                                  child: Icon(
                                                    controller.partnerModel.wardIdList.contains(wardList[index].id) ? Icons.radio_button_checked : Icons.radio_button_off,
                                                  ),
                                                ),
                                                title: Text(wardList[index].nameWard!.capitalizeFirst.toString()),
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
                                    itemCount: controller.partnerModel.gallery.length + 1,
                                    itemBuilder: (BuildContext context, int index) => PartnerGalleryItem(
                                      file: index + 1 > controller.partnerModel.gallery.length ? null : controller.partnerModel.gallery[index],
                                      onTap: index + 1 > controller.partnerModel.gallery.length
                                          ? () async {
                                              FilePickerResult? result = await FilePicker.platform.pickFiles(
                                                type: FileType.custom,
                                                allowedExtensions: ['jpg', 'png'],
                                              );

                                              if (result != null) {
                                                setState(() {
                                                  controller.partnerModel.gallery.add(new File(result.files.single.path!));
                                                });
                                              } else {
                                                // User canceled the picker
                                              }
                                            }
                                          : null,
                                      removeGallery: index + 1 > controller.partnerModel.gallery.length
                                          ? null
                                          : () {
                                              setState(() {
                                                controller.partnerModel.gallery.remove(controller.partnerModel.gallery[index]);
                                              });
                                            },
                                    ),
                                    staggeredTileBuilder: (int index) => new StaggeredTile.count(2, 3),
                                    mainAxisSpacing: gutter,
                                    crossAxisSpacing: gutter,
                                  )
                                ],
                              ),

                              Gutter(scale: 2),

                              GFButton(
                                onPressed: () async {
                                  final validationSuccess = _formKey.currentState!.validate();

                                  if (validationSuccess) {
                                    _formKey.currentState!.save();

                                    if (controller.partnerModel.serviceList.isEmpty) {
                                      AlertSnackbar.open(title: "Service required", message: "You need at least one service", status: AlertType.warning);
                                    } else if (controller.partnerModel.wardIdList.isEmpty) {
                                      AlertSnackbar.open(title: "Ward required", message: "You need at least one ward", status: AlertType.warning);
                                    } else if (controller.partnerModel.gallery.length < 2) {
                                      AlertSnackbar.open(title: "Gallery required", message: "You need at least two image", status: AlertType.warning);
                                    } else {
                                      controller.partnerModel.nickname = _formKey.currentState!.fields['nickname']!.value.toString().trim();
                                      controller.partnerModel.genderId = (_formKey.currentState!.fields['gender']!.value);
                                      controller.partnerModel.birthday = (_formKey.currentState!.fields['birthday']!.value as DateTime).millisecondsSinceEpoch;
                                      controller.partnerModel.height = int.parse((_formKey.currentState!.fields['height']!.value));
                                      controller.partnerModel.weight = int.parse((_formKey.currentState!.fields['weight']!.value));
                                      controller.partnerModel.bust = int.parse((_formKey.currentState!.fields['bust']!.value));
                                      controller.partnerModel.waist = int.parse((_formKey.currentState!.fields['waist']!.value));
                                      controller.partnerModel.hips = int.parse((_formKey.currentState!.fields['hips']!.value));
                                      controller.partnerModel.provinceId = (_formKey.currentState!.fields['province']!.value);

                                      print("Nickname: " + controller.partnerModel.nickname.toString());
                                      print("Gender Id: " + controller.partnerModel.genderId.toString());
                                      print("Birthday: " + controller.partnerModel.birthday.toString());
                                      print("Height: " + controller.partnerModel.height.toString());
                                      print("Weight: " + controller.partnerModel.weight.toString());
                                      print("Bust: " + controller.partnerModel.bust.toString());
                                      print("Waist: " + controller.partnerModel.waist.toString());
                                      print("Hips: " + controller.partnerModel.hips.toString());
                                      for (ServiceModel serviceModel in controller.partnerModel.serviceList) {
                                        print("\tService List: " + serviceModel.name.toString() + " - " + serviceModel.price.toString());
                                      }
                                      print("Province Id: " + controller.partnerModel.provinceId.toString());
                                      print("Ward Id List: " + controller.partnerModel.wardIdList.length.toString());
                                      print("Gallery List: " + controller.partnerModel.gallery.toString());

                                      Get.to(() => PartnerRegisterConfirmationScreen());
                                    }
                                  }
                                },
                                text: "Submit",
                                size: GFSize.LARGE,
                                borderShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
                                textStyle: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                                color: primaryColor,
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

class PartnerGalleryItem extends StatefulWidget {
  const PartnerGalleryItem({
    Key? key,
    this.file,
    this.onTap,
    this.removeGallery,
  }) : super(key: key);

  final File? file;
  final Function()? onTap;
  final Function()? removeGallery;

  @override
  _PartnerGalleryItemState createState() => _PartnerGalleryItemState();
}

class _PartnerGalleryItemState extends State<PartnerGalleryItem> {
  @override
  Widget build(BuildContext context) {
    if (widget.file != null) {
      return Card(
        elevation: 3,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: widget.file!.path.contains('.mp4')
            ? Container(
                child: Stack(
                  children: [
                    Positioned(
                      top: gutter / 2,
                      left: gutter / 2,
                      child: Icon(Icons.movie),
                    ),
                    Positioned(
                      top: gutter / 2,
                      right: gutter / 2,
                      child: GestureDetector(
                        onTap: () {
                          if (widget.removeGallery != null) widget.removeGallery!();
                        },
                        child: Icon(Icons.clear),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.file(
                        widget.file!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: gutter / 2,
                      left: gutter / 2,
                      child: Icon(Icons.image),
                    ),
                    Positioned(
                      top: gutter / 2,
                      right: gutter / 2,
                      child: GestureDetector(
                        onTap: () {
                          if (widget.removeGallery != null) widget.removeGallery!();
                        },
                        child: Icon(Icons.clear),
                      ),
                    ),
                  ],
                ),
              ),
      );
    } else {
      return GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: EdgeInsets.all(gutter),
          decoration: DottedDecoration(
            shape: Shape.box,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_a_photo),
                Gutter(),
                Text("Add an image", textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      );
    }
  }
}
