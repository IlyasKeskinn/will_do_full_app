import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:will_do_full_app/enums/image_constants.dart';
import 'package:will_do_full_app/product/constants/color_constants.dart';
import 'package:will_do_full_app/product/constants/string_const.dart';
import 'package:will_do_full_app/product/widget/homepage/todo_tile.dart';
import 'package:will_do_full_app/product/widget/text/subtitle_text.dart';
import 'package:will_do_full_app/product/widget/text/title_text.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          foregroundColor: ColorConst.white,
          onPressed: () {},
          backgroundColor: ColorConst.primaryColor,
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            const _Appbar(), //_EmptyTask(),
            Padding(
              padding: context.paddingNormal,
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: context.paddingNormal,
                      fillColor: ColorConst.darkgrey,
                      filled: true,
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.search),
                      hintText: AppText.homesearchTask,
                    ),
                  ),
                  context.emptySizedHeightBoxLow,
                  SizedBox(
                    height: context.dynamicHeight(0.7),
                    child: ListView.builder(
                      itemCount: 14,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: context.onlyTopPaddingNormal,
                          child: const ToDoTileWidget(
                            taskName: 'taskName',
                            isTaskCompleted: false,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: const _NavigationBar(),
      ),
    );
  }
}

class _Appbar extends StatelessWidget {
  const _Appbar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.onlyTopPaddingLow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list_outlined),
          ),
          TitleText(value: AppText.appName),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                ImageConstants.avatar.toPath,
                height: 50,
                width: 50,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _EmptyTask extends StatelessWidget {
  const _EmptyTask();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.onlyTopPaddingHigh,
      child: Column(
        children: [
          Image.asset(
            ImageConstants.checklist.toPath,
            height: context.dynamicHeight(0.4),
          ),
          const SizedBox(
            height: 10,
          ),
          TitleText(value: AppText.homeWhatdo),
          const SizedBox(
            height: 10,
          ),
          SubtitleText(value: AppText.homehowAddTask)
        ],
      ),
    );
  }
}

class _NavigationBar extends StatelessWidget {
  const _NavigationBar();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: ColorConst.primaryColor,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_outlined),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.watch_later_outlined),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_outlined),
          label: '',
        ),
      ],
    );
  }
}
