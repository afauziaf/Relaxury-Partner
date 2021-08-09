import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../services/country.service.dart';

import '../../../global/helpers/shimmer.helper.dart';
import '../../../global/themes/input.theme.dart';
import '../../../global/themes/layout.theme.dart';
import '../../../global/widgets/gutter.dart';

class CountryPickerBottomSheet extends StatefulWidget {
  const CountryPickerBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  _CountryPickerBottomSheetState createState() => _CountryPickerBottomSheetState();
}

class _CountryPickerBottomSheetState extends State<CountryPickerBottomSheet> {
  TextEditingController _searchInputController = TextEditingController();
  bool __dataLoaded = false;
  List<CountryModel> _countryList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.5 + MediaQuery.of(context).viewInsets.bottom,
      padding: EdgeInsets.symmetric(horizontal: padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(padding),
          topRight: Radius.circular(padding),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: padding,
            child: Center(
              child: Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  color: Colors.grey.shade200,
                ),
              ),
            ),
          ),
          TextField(
            controller: _searchInputController,
            onChanged: (value) {
              setState(() {});
            },
            decoration: inputDecoration.copyWith(
              contentPadding: EdgeInsets.all(gutter / 2),
              prefixIcon: Icon(Icons.search),
              isDense: true,
              hintText: "Search",
            ),
          ),
          Expanded(
            child: __dataLoaded
                ? Scrollbar(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: gutter),
                      shrinkWrap: true,
                      itemCount: _countryList.where((element) => element.name.toLowerCase().contains(_searchInputController.text)).length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            dense: true,
                            onTap: () => Get.back<CountryModel>(result: _countryList.where((element) => element.name.toLowerCase().contains(_searchInputController.text)).toList().elementAt(index)),
                            leading: Container(
                              height: 40,
                              width: 40,
                              child: Center(child: SvgPicture.network(_countryList.where((element) => element.name.toLowerCase().contains(_searchInputController.text)).toList().elementAt(index).flag)),
                            ),
                            title: Text(_countryList.where((element) => element.name.toLowerCase().contains(_searchInputController.text)).toList().elementAt(index).name, style: Get.textTheme.bodyText1),
                            subtitle: Text(_countryList.where((element) => element.name.toLowerCase().contains(_searchInputController.text)).toList().elementAt(index).nativeName, style: Get.textTheme.bodyText2!.copyWith(fontSize: 14, color: Colors.grey)),
                            trailing: Text("(" + _countryList.where((element) => element.name.toLowerCase().contains(_searchInputController.text)).toList().elementAt(index).callingCodes[0] + " +)", style: Get.textTheme.bodyText1),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Gutter(),
                    ),
                  )
                : FutureBuilder(
                    future: CountryProvider().getCountryList(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        __dataLoaded = true;
                        _countryList = snapshot.data as List<CountryModel>;

                        return ListView.separated(
                          padding: EdgeInsets.symmetric(vertical: gutter),
                          shrinkWrap: true,
                          itemCount: _searchInputController.text.length > 0 ? _countryList.where((element) => element.name.contains(_searchInputController.text)).length : _countryList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                dense: true,
                                onTap: () => Get.back<CountryModel>(result: _countryList.where((element) => element.name.toLowerCase().contains(_searchInputController.text)).toList().elementAt(index)),
                                leading: Container(
                                  height: 40,
                                  width: 40,
                                  child: Center(child: SvgPicture.network(_countryList.where((element) => element.name.toLowerCase().contains(_searchInputController.text)).toList().elementAt(index).flag)),
                                ),
                                title: Text(_countryList.where((element) => element.name.toLowerCase().contains(_searchInputController.text)).toList().elementAt(index).name, style: Get.textTheme.bodyText1),
                                subtitle: Text(_countryList.where((element) => element.name.toLowerCase().contains(_searchInputController.text)).toList().elementAt(index).nativeName, style: Get.textTheme.bodyText2!.copyWith(fontSize: 14, color: Colors.grey)),
                                trailing: Text("(" + _countryList.where((element) => element.name.toLowerCase().contains(_searchInputController.text)).toList().elementAt(index).callingCodes[0] + " +)", style: Get.textTheme.bodyText1),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Gutter(),
                        );
                      } else {
                        __dataLoaded = false;

                        return ListView.separated(
                          padding: EdgeInsets.symmetric(vertical: gutter),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => ListTile(
                            leading: ShimmerHelper.retangular(height: 40, width: 40),
                            title: ShimmerHelper.retangular(height: 16),
                            subtitle: ShimmerHelper.retangular(height: 16),
                          ),
                          separatorBuilder: (context, index) => Gutter(),
                          itemCount: 3,
                        );
                      }
                    },
                  ),
          )
        ],
      ),
    );
  }
}
