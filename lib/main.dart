// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jbeauty/data/shared_perf_manager.dart';
import 'package:jbeauty/firebase_options.dart';
import 'package:jbeauty/route/app_router.dart';
import 'package:jbeauty/style/style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

late AppLocalizations tr;
// import 'package:firebase_ui_auth/firebase_ui_auth.dart';
Future<void> initialize() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPerfManager.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
  ]);

  /// This is used to set the orientation of the app to portrait only
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

void main() async {
  initialize();

  /// provider scope is used to provide the providers to the app
  runApp(const ProviderScope(child: MyApp()));
}

final appRouter = AppRouter();

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var locale = ref.watch(currentLocalProvider).currentLocal;
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      locale: locale,
      onGenerateTitle: (context) {
        tr = AppLocalizations.of(context)!;
        return tr.app_name;
      },
      // title: tr.app_name,
      theme: Style.getThemeData(ref),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: appRouter.config(),
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          }),
          child: child!,
        );
      },
    );
  }
}

class ThemeModeButtons extends ConsumerWidget {
  const ThemeModeButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isExpanded = ref.watch(isExpandedProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: () {
          if (isExpanded) {
            ref.read(isExpandedProvider.notifier).state = false;
          } else {
            ref.read(isExpandedProvider.notifier).state = true;
          }
        },
        child: AnimatedContainer(
          width: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Theme.of(context).colorScheme.primary,
          ),
          height: isExpanded ? 130 : 55,
          duration: const Duration(milliseconds: 500),
          child: getchild(ref),
        ),
      ),
    );
  }

  /// this method is used to get the child widget based on the theme mode and the isExpanded state
  Widget getchild(WidgetRef ref) {
    bool isExpanded = ref.watch(isExpandedProvider);
    double size = 30;

    if (!isExpanded) {
      return getChildFromThemeMode(size);
    } else {
      var items = getIconButtons(ref, size);
      return SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(height: 10),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return items[index];
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
            itemCount: items.length,
          ),
        ],
      ));
    }
  }

  Widget getChildFromThemeMode(double size) {
    var theme = SharedPerfManager.themeMode;

    switch (theme) {
      case ThemeMode.dark:
        return RotatingIconButton(icon: Icons.dark_mode, size: size);
      case ThemeMode.light:
        return RotatingIconButton(icon: Icons.light_mode, size: size);
      case ThemeMode.system:
        return RotatingIconButton(icon: Icons.settings, size: size);
      default:
        return RotatingIconButton(icon: Icons.settings, size: size);
    }
  }

  /// this method is used to get the list of icons based on the theme mode
  List<Widget> getIconButtons(WidgetRef ref, double size) {
    Widget systemicon = InkWell(
      onTap: () {
        ref.read(currentThemeProvider).toggleTheme(ThemeMode.system);
        ref.read(isExpandedProvider.notifier).state = false;
      },
      child: Icon(
        Icons.settings,
        size: size,
      ),
    );

    Widget darkicon = InkWell(
      onTap: () {
        ref.read(currentThemeProvider).toggleTheme(ThemeMode.dark);
        ref.read(isExpandedProvider.notifier).state = false;
      },
      child: Icon(
        Icons.dark_mode,
        size: size,
      ),
    );

    Widget lighticon = InkWell(
      onTap: () {
        ref.read(currentThemeProvider).toggleTheme(ThemeMode.light);
        ref.read(isExpandedProvider.notifier).state = false;
      },
      child: Icon(
        Icons.light_mode,
        size: size,
      ),
    );

    /// return list of icons based on theme mode the selected theme mode will be at the top
    var theme = SharedPerfManager.themeMode;
    switch (theme) {
      case ThemeMode.dark:
        return [darkicon, lighticon, systemicon];
      case ThemeMode.light:
        return [lighticon, darkicon, systemicon];
      case ThemeMode.system:
        return [systemicon, darkicon, lighticon];
      default:
        return [systemicon, darkicon, lighticon];
    }
  }

}
/// this provider is used to store the state of the theme mode button
final isExpandedProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

class RotatingIconButton extends StatefulWidget {
  const RotatingIconButton({super.key, this.icon, this.onPressed, this.size});

  final IconData? icon;
  final VoidCallback? onPressed;
  final double? size;

  @override
  _RotatingIconButtonState createState() => _RotatingIconButtonState();
}

class _RotatingIconButtonState extends State<RotatingIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  // final int _animationCycles = 0;
  // final int _maxAnimationCycles = 3;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    // ..addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     _animationCycles++;
    //     if (_animationCycles >= _maxAnimationCycles) {
    //       _animationController.stop();
    //     } else {
    //       _animationController.reset();
    //       _animationController.forward();
    //     }
    //   }
    // });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.rotate(
          /// rotate the icon 3 times
          angle: _animation.value * 6.3,
          child:
              // IconButton(
              //   icon:
              Icon(widget.icon, size: widget.size),
          // onPressed: () {
          //   widget.onPressed?.call();
          // },
          // ),
        );
      },
    );
  }
}
