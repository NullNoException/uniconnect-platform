import 'package:flutter/material.dart';

class ResponsiveScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final List<Widget>? persistentFooterButtons;
  final double? maxContentWidth;
  final EdgeInsets? contentPadding;

  const ResponsiveScaffold({
    super.key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.drawer,
    this.endDrawer,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.persistentFooterButtons,
    this.maxContentWidth = 1200.0,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: _buildResponsiveBody(context),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      drawer: drawer,
      endDrawer: endDrawer,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      persistentFooterButtons: persistentFooterButtons,
    );
  }

  Widget? _buildResponsiveBody(BuildContext context) {
    if (body == null) return null;

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;

        // For smaller screens, use full width
        if (screenWidth <= 600 || maxContentWidth == null) {
          return _wrapWithPadding(body!);
        }

        // For larger screens, center content with max width
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxContentWidth!),
            child: _wrapWithPadding(body!),
          ),
        );
      },
    );
  }

  Widget _wrapWithPadding(Widget child) {
    if (contentPadding == null) {
      return child;
    }

    return Padding(padding: contentPadding!, child: child);
  }
}

class ResponsiveBreakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobile;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobile && width < desktop;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= desktop;
  }

  static ResponsiveScreenType getScreenType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < mobile) {
      return ResponsiveScreenType.mobile;
    } else if (width < desktop) {
      return ResponsiveScreenType.tablet;
    } else {
      return ResponsiveScreenType.desktop;
    }
  }
}

enum ResponsiveScreenType { mobile, tablet, desktop }

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ResponsiveScreenType screenType)
  builder;
  final Widget Function(BuildContext context)? mobile;
  final Widget Function(BuildContext context)? tablet;
  final Widget Function(BuildContext context)? desktop;

  const ResponsiveBuilder({super.key, required this.builder})
    : mobile = null,
      tablet = null,
      desktop = null;

  const ResponsiveBuilder.adaptive({
    super.key,
    this.mobile,
    this.tablet,
    this.desktop,
  }) : builder = _adaptiveBuilder;

  static Widget _adaptiveBuilder(
    BuildContext context,
    ResponsiveScreenType screenType,
  ) {
    // This will be overridden by the adaptive constructor
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    final screenType = ResponsiveBreakpoints.getScreenType(context);

    // Handle adaptive constructor
    if (mobile != null || tablet != null || desktop != null) {
      switch (screenType) {
        case ResponsiveScreenType.mobile:
          return mobile?.call(context) ??
              tablet?.call(context) ??
              desktop?.call(context) ??
              const SizedBox.shrink();
        case ResponsiveScreenType.tablet:
          return tablet?.call(context) ??
              desktop?.call(context) ??
              mobile?.call(context) ??
              const SizedBox.shrink();
        case ResponsiveScreenType.desktop:
          return desktop?.call(context) ??
              tablet?.call(context) ??
              mobile?.call(context) ??
              const SizedBox.shrink();
      }
    }

    return builder(context, screenType);
  }
}

class ResponsiveValue<T> {
  final T mobile;
  final T? tablet;
  final T? desktop;

  const ResponsiveValue({required this.mobile, this.tablet, this.desktop});

  T getValue(BuildContext context) {
    final screenType = ResponsiveBreakpoints.getScreenType(context);

    switch (screenType) {
      case ResponsiveScreenType.mobile:
        return mobile;
      case ResponsiveScreenType.tablet:
        return tablet ?? mobile;
      case ResponsiveScreenType.desktop:
        return desktop ?? tablet ?? mobile;
    }
  }
}
