import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:relaxury_partner/models/profile/commission_tree.model.dart';
import '../../../controllers/profile.controller.dart';
import '../../../global/themes/layout.theme.dart';
import '../../../global/widgets/empty_file_widget.dart';
import '../../../global/widgets/gutter.dart';

class CommissionTreeTab extends StatelessWidget {
  const CommissionTreeTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        if (controller.commissionTree!.children.length > 0) {
          return ListView.separated(
            padding: EdgeInsets.all(padding),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.commissionTree!.children.length,
            itemBuilder: (context, index) => CommissionChildItem(child: controller.commissionTree!.children[index]),
            separatorBuilder: (context, index) => Gutter(),
          );
        } else {
          return EmptyFileWidget();
        }
      },
    );
  }
}

class CommissionChildItem extends StatefulWidget {
  const CommissionChildItem({
    Key? key,
    required this.child,
  }) : super(key: key);

  final CommissionTree child;

  @override
  _CommissionChildItemState createState() => _CommissionChildItemState();
}

class _CommissionChildItemState extends State<CommissionChildItem> {
  bool expand = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.all(0),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              child: SvgPicture.asset('assets/icons/comission.svg'),
            ),
            title: Text(
              widget.child.name,
              maxLines: 1,
              style: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
            ),
            trailing: widget.child.children.isNotEmpty ? IconButton(onPressed: () => setState(() => expand = !expand), icon: Icon(!expand ? Icons.expand_more : Icons.expand_less)) : null,
          ),
        ),
        if (widget.child.children.isNotEmpty)
          Container(
            child: Column(
              children: [
                if (expand) Gutter(),
                if (expand)
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(gutter).copyWith(left: gutter, right: 0),
                    itemCount: widget.child.children.length,
                    itemBuilder: (context, index) => CommissionChildItem(child: widget.child.children[index]),
                    separatorBuilder: (context, index) => Gutter(),
                  )
              ],
            ),
          ),
      ],
    );
  }
}
