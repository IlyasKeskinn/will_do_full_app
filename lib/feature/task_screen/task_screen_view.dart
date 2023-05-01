import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:will_do_full_app/product/constants/color_constants.dart';
import 'package:will_do_full_app/product/constants/string_const.dart';
import 'package:will_do_full_app/product/widget/buttons/primary_button.dart';
import 'package:will_do_full_app/product/widget/text/subtext.dart';
import 'package:will_do_full_app/product/widget/text/subtitle_text.dart';

class TaskScreenView extends ConsumerStatefulWidget {
  const TaskScreenView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskScreenViewState();
}

class _TaskScreenViewState extends ConsumerState<TaskScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
      ),
      body: Padding(
        padding: context.paddingNormal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            context.emptySizedHeightBoxLow3x,
            const TaskTitleDesc(),
            context.emptySizedHeightBoxLow3x,
            const TaskCategory(),
            context.emptySizedHeightBoxLow3x,
            const TaskPriority(),
            context.emptySizedHeightBoxLow3x,
            const DeleteTask(),
            const Spacer(),
            PrimaryButton(value: AppText.editTask, click: () {})
          ],
        ),
      ),
    );
  }
}

class DeleteTask extends StatelessWidget {
  const DeleteTask({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        textStyle: Theme.of(context).textTheme.titleMedium,
        padding: const EdgeInsets.all(0),
        foregroundColor: ColorConst.error,
      ),
      onPressed: () {},
      icon: const Icon(Icons.delete_outline),
      label: Text(AppText.deleteTask.toCapitalized()),
    );
  }
}

class TaskTitleDesc extends StatelessWidget {
  const TaskTitleDesc({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          //fix
          value: false,
          onChanged: (value) {},
          shape: const CircleBorder(),
          activeColor: ColorConst.grey,
        ),
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SubtitleText(
                value: 'Sonsuz Uzayin Derinliklerinde Kaybolan Galaksiler',
              ),
              context.emptySizedHeightBoxLow,
              const SubText(
                value:
                    'Dünya, insanlık için yaşanılabilir tek gezegen olarak bilinmektedir. Ancak son yıllarda, çevre kirli',
              )
            ],
          ),
        ),
        const Spacer(),
        IconButton(
          // Use the MdiIcons class for the IconData
          icon: const Icon(MdiIcons.pencilOutline),
          onPressed: () {},
        )
      ],
    );
  }
}

class TaskCategory extends StatelessWidget {
  const TaskCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(MdiIcons.tagOutline),
        Padding(
          padding: context.onlyLeftPaddingNormal,
          child: Expanded(
            flex: 8,
            child: SubtitleText(value: AppText.taskCategory.toCapitalized()),
          ),
        ),
        const Spacer(),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorConst.grey,
          ),
          child: Padding(
            padding:
                context.verticalPaddingNormal + context.horizontalPaddingMedium,
            child: const SubtitleText(value: 'Work'),
          ),
        )
      ],
    );
  }
}

class TaskPriority extends StatelessWidget {
  const TaskPriority({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(MdiIcons.flagOutline),
        Padding(
          padding: context.onlyLeftPaddingNormal,
          child: Expanded(
            flex: 8,
            child: SubtitleText(value: AppText.taskPriority.toCapitalized()),
          ),
        ),
        const Spacer(),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorConst.grey,
          ),
          child: Padding(
            padding:
                context.verticalPaddingNormal + context.horizontalPaddingMedium,
            child: const SubtitleText(value: 'No'),
          ),
        )
      ],
    );
  }
}
