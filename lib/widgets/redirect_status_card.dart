import 'package:flutter/material.dart';

class RedirectStatusCard extends StatelessWidget {
  const RedirectStatusCard({
    super.key,
    this.title,
    this.message,
    this.icon,
    this.child,
  }) : assert(
         child != null || (title != null && message != null && icon != null),
         'Either child or title, message, and icon must be provided.',
       );

  final String? title;
  final String? message;
  final IconData? icon;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primary.withValues(alpha: 0.16),
              colorScheme.surface,
              colorScheme.secondary.withValues(alpha: 0.10),
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final availableWidth = constraints.maxWidth - 48;
              final availableHeight = constraints.maxHeight - 48;

              final cardWidth = availableWidth.clamp(320.0, 560.0);

              final cardMinHeight = availableHeight >= 360
                  ? 360.0
                  : availableHeight;

              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: cardWidth,
                    maxWidth: cardWidth,
                    minHeight: cardMinHeight,
                    maxHeight: availableHeight,
                  ),
                  child: Card(
                    elevation: 0,
                    color: colorScheme.surface.withValues(alpha: 0.92),
                    surfaceTintColor: colorScheme.primary.withValues(
                      alpha: 0.12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                      side: BorderSide(
                        color: colorScheme.primary.withValues(alpha: 0.12),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 32,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const _MiestaTitle(),
                          const SizedBox(height: 24),
                          child ??
                              _DefaultContent(
                                title: title!,
                                message: message!,
                                icon: icon!,
                              ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _DefaultContent extends StatelessWidget {
  const _DefaultContent({
    required this.title,
    required this.message,
    required this.icon,
  });

  final String title;
  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 34,
          backgroundColor: colorScheme.primary.withValues(alpha: 0.12),
          child: Icon(
            icon,
            size: 34,
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          title,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineMedium?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          message,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.78),
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

class _MiestaTitle extends StatelessWidget {
  const _MiestaTitle();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: theme.textTheme.displaySmall?.copyWith(
          fontFamily: 'Yellowtail',
          fontSize: 56,
          height: 1,
        ),
        children: [
          TextSpan(
            text: 'Mi',
            style: TextStyle(
              color: colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: 'esta',
            style: TextStyle(
              color: colorScheme.onSurface.withValues(alpha: 0.96),
            ),
          ),
        ],
      ),
    );
  }
}
