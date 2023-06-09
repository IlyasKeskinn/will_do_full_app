import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:will_do_full_app/enums/image_constants.dart';
import 'package:will_do_full_app/feature/add_todos/add_task_view.dart';
import 'package:will_do_full_app/feature/home/home_provider.dart';
import 'package:will_do_full_app/feature/home/sub_view/home_search_delegate.dart';
import 'package:will_do_full_app/feature/profile/profile_view.dart';
import 'package:will_do_full_app/feature/task_screen/task_screen_view.dart';
import 'package:will_do_full_app/product/constants/color_constants.dart';
import 'package:will_do_full_app/product/constants/string_const.dart';
import 'package:will_do_full_app/product/model/users.dart';
import 'package:will_do_full_app/product/provider/profile_provider.dart';
import 'package:will_do_full_app/product/widget/homepage/todo_tile.dart';
import 'package:will_do_full_app/product/widget/text/subtitle_text.dart';
import 'package:will_do_full_app/product/widget/text/title_text.dart';

final _homeProvider = StateNotifierProvider<HomeProvider, HomeState>((ref) {
  return HomeProvider();
});
final _profileProvider =
    StateNotifierProvider<ProfileProvider, ProfileState>((ref) {
  return ProfileProvider();
});

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late final Users user;
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(_homeProvider.notifier).fetchItems(),
    );
    ref.read(_profileProvider.notifier).fetchuser();
  }

  @override
  Widget build(BuildContext context) {
    final todoItems = ref.watch(_homeProvider).todos;
    final userItem = ref.watch(_profileProvider).userItem;
    if (userItem == null) {
      // userItem henüz null ise, yükleme göstergesi gösterin
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      final profileImagePath = userItem.profileImage;
      return SafeArea(
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            foregroundColor: ColorConst.white,
            onPressed: () async {
              final response = await context.navigateToPage<bool>(
                const AddTaskView(),
                type: SlideType.LEFT,
              );
              if (response ?? false) {
                await ref.read(_homeProvider.notifier).fetchItems();
              }
            },
            backgroundColor: ColorConst.primaryColor,
            child: const Icon(Icons.add),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _Appbar(user: userItem),
                Stack(
                  children: [
                    Padding(
                      padding: context.paddingNormal,
                      child: Column(
                        children: [
                          TextField(
                            onTap: () {
                              showSearch(
                                context: context,
                                delegate: HomeSearchDelegate(
                                  todoItems: ref
                                      .watch(_homeProvider.notifier)
                                      .todoList,
                                ),
                              );
                            },
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
                          const TodoItems()
                        ],
                      ),
                    ),
                    if (todoItems.isNullOrEmpty)
                      const Center(child: _EmptyTask()),
                  ],
                )
              ],
            ),
          ),
          bottomNavigationBar: const _NavigationBar(),
        ),
      );
    }
  }
}

class TodoItems extends ConsumerWidget {
  const TodoItems({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoItems = ref.watch(_homeProvider).todos;
    return SizedBox(
      height: context.dynamicHeight(0.7),
      child: ListView.builder(
        itemCount: todoItems?.length ?? 0,
        itemBuilder: (context, index) {
          return Padding(
            padding: context.onlyTopPaddingNormal,
            child: InkWell(
              onTap: () {
                context
                    .navigateToPage(
                      type: SlideType.TOP,
                      TaskScreenView(
                        todosItem: todoItems![index],
                      ),
                    )
                    .then(
                      (value) => ref.read(_homeProvider.notifier).fetchItems(),
                    );
              },
              child: ToDoTileWidget(
                todoItem: todoItems?[index],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Appbar extends StatelessWidget {
  const _Appbar({required this.user});
  final Users user;
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
          InkWell(
            onTap: () {
              context.navigateToPage(
                const ProfileView(),
                type: SlideType.TOP,
              );
            },
            child: Hero(
              tag: 'profile-photo',
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: user.profileImage.isNullOrEmpty
                      ? Image.asset(
                          ImageConstants.avatar.toPath,
                          width: 50,
                          height: 50,
                        )
                      : Image.network(
                          //fix
                          user.profileImage!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                ),
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
