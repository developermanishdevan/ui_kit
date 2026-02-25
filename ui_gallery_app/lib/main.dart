import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

void main() {
  runApp(const UIGalleryApp());
}

class UIGalleryApp extends StatelessWidget {
  const UIGalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI Kit Gallery',
      theme: AppTheme.customLight(),
      darkTheme: AppTheme.customDark(),
      themeMode: ThemeMode.system,
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _selectedCategory = 'Buttons';

  final Map<String, Widget> _categories = {
    'Foundation': const FoundationShowcase(),
    'Layout': const LayoutShowcase(),
    'Navigation': const NavigationShowcase(),
    'Buttons': const ButtonsShowcase(),
    'Inputs': const InputsShowcase(),
    'Selection': const SelectionShowcase(),
    'Data Display': const DataDisplayShowcase(),
    'Feedback': const FeedbackShowcase(),
    'Overlays': const OverlaysShowcase(),
    'Media': const MediaShowcase(),
    'Animations': const AnimationsShowcase(),
    'Advanced': const AdvancedShowcase(),
  };

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text(_selectedCategory),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      drawer: Drawer(
        child: AppSidebar(
          header: const Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: AppText(
              'UI Kit Gallery',
              variant: AppTextVariant.headlineLarge,
            ),
          ),
          items: _categories.keys.map((type) {
            return AppListTile(
              title: type,
              leading: Icon(_getIconForCategory(type)),
              selected: _selectedCategory == type,
              onTap: () {
                setState(() => _selectedCategory = type);
                Navigator.pop(context); // Close drawer
              },
            );
          }).toList(),
        ),
      ),
      body: AppScreen(
        scrollable: true,
        padding: const EdgeInsets.all(AppSpacing.lg),
        child:
            _categories[_selectedCategory] ??
            const Center(child: Text('Not implemented')),
      ),
    );
  }

  IconData _getIconForCategory(String category) {
    switch (category) {
      case 'Foundation':
        return Icons.palette_outlined;
      case 'Layout':
        return Icons.layers_outlined;
      case 'Navigation':
        return Icons.navigation_outlined;
      case 'Buttons':
        return Icons.smart_button_outlined;
      case 'Inputs':
        return Icons.edit_note_outlined;
      case 'Selection':
        return Icons.check_box_outlined;
      case 'Data Display':
        return Icons.data_usage_outlined;
      case 'Feedback':
        return Icons.feedback_outlined;
      case 'Overlays':
        return Icons.layers_outlined;
      case 'Media':
        return Icons.image_outlined;
      case 'Animations':
        return Icons.animation_outlined;
      case 'Advanced':
        return Icons.code_outlined;
      default:
        return Icons.category_outlined;
    }
  }
}

// --- Category Showcase Widgets ---

class FoundationShowcase extends StatelessWidget {
  const FoundationShowcase({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSection(
          title: 'Typography',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText('Display Large', variant: AppTextVariant.displayLarge),
              AppText('Display Medium', variant: AppTextVariant.displayMedium),
              AppText('Display Small', variant: AppTextVariant.displaySmall),
              SizedBox(height: AppSpacing.md),
              AppText('Headline Large', variant: AppTextVariant.headlineLarge),
              AppText(
                'Headline Medium',
                variant: AppTextVariant.headlineMedium,
              ),
              AppText('Headline Small', variant: AppTextVariant.headlineSmall),
              SizedBox(height: AppSpacing.md),
              AppText('Body Large', variant: AppTextVariant.bodyLarge),
              AppText('Body Medium', variant: AppTextVariant.bodyMedium),
              AppText('Body Small', variant: AppTextVariant.bodySmall),
            ],
          ),
        ),
        SizedBox(height: AppSpacing.xl),
        AppSection(
          title: 'Colors',
          child: Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              _ColorBox(color: AppColors.primary, name: 'Primary'),
              _ColorBox(color: AppColors.secondary, name: 'Secondary'),
              _ColorBox(color: AppColors.success, name: 'Success'),
              _ColorBox(color: AppColors.warning, name: 'Warning'),
              _ColorBox(color: AppColors.error, name: 'Error'),
              _ColorBox(color: AppColors.info, name: 'Info'),
            ],
          ),
        ),
      ],
    );
  }
}

class _ColorBox extends StatelessWidget {
  final Color color;
  final String name;
  const _ColorBox({required this.color, required this.name});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: color,
            borderRadius: AppRadius.mdAll,
            boxShadow: AppShadows.sm,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        AppText(name, variant: AppTextVariant.labelSmall),
      ],
    );
  }
}

class LayoutShowcase extends StatelessWidget {
  const LayoutShowcase({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSection(
          title: 'Responsive Grid',
          child: AppResponsiveGrid(
            mobileColumns: 1,
            tabletColumns: 2,
            desktopColumns: 3,
            children: List.generate(
              3,
              (i) => AppCard(child: Center(child: Text('Item ${i + 1}'))),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        const AppSection(
          title: 'Flex Layouts',
          child: AppColumn(
            gap: AppSpacing.md,
            children: [
              AppRow(
                gap: AppSpacing.md,
                children: [
                  Expanded(child: AppCard(child: Text('Row Item 1'))),
                  Expanded(child: AppCard(child: Text('Row Item 2'))),
                ],
              ),
              AppCard(child: Text('Full Width Column Item')),
            ],
          ),
        ),
      ],
    );
  }
}

class NavigationShowcase extends StatelessWidget {
  const NavigationShowcase({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSection(
          title: 'Breadcrumbs',
          child: AppBreadcrumb(
            items: [
              AppBreadcrumbItem(label: 'Home', onTap: () {}),
              AppBreadcrumbItem(label: 'Settings', onTap: () {}),
              AppBreadcrumbItem(label: 'Profile'),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        AppSection(
          title: 'Tab Views',
          child: SizedBox(
            height: 200,
            child: AppTabView(
              tabs: const [
                AppTabBarItem(label: 'Profile', icon: Icons.person_outline),
                AppTabBarItem(
                  label: 'Settings',
                  icon: Icons.settings_outlined,
                  badge: 3,
                ),
              ],
              views: const [
                Center(child: Text('Profile Content')),
                Center(child: Text('Settings Content')),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ButtonsShowcase extends StatelessWidget {
  const ButtonsShowcase({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppSection(
          title: 'Button Variants',
          child: Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              AppPrimaryButton(label: 'Primary', onPressed: null),
              AppSecondaryButton(label: 'Secondary', onPressed: null),
              AppOutlineButton(label: 'Outline', onPressed: null),
              AppGhostButton(label: 'Ghost', onPressed: null),
              AppDestructiveButton(label: 'Destructive', onPressed: null),
              AppGradientButton(label: 'Gradient', onPressed: null),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        AppSection(
          title: 'Icon & Link Buttons',
          child: Wrap(
            spacing: AppSpacing.md,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              AppIconButton(icon: Icons.add, onPressed: () {}),
              AppLinkButton(label: 'Link Button', onPressed: () {}),
              const AppPrimaryButton(
                label: 'Loading',
                isLoading: true,
                onPressed: null,
              ),
              const AppPrimaryButton(
                label: 'Disabled',
                isDisabled: true,
                onPressed: null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InputsShowcase extends StatefulWidget {
  const InputsShowcase({super.key});
  @override
  State<InputsShowcase> createState() => _InputsShowcaseState();
}

class _InputsShowcaseState extends State<InputsShowcase> {
  String? _dropdownValue = 'Opt 1';

  @override
  Widget build(BuildContext context) {
    return AppColumn(
      gap: AppSpacing.lg,
      children: [
        const AppSection(
          title: 'Text Inputs',
          child: AppColumn(
            gap: AppSpacing.md,
            children: [
              AppTextField(label: 'Standard', hint: 'Enter text...'),
              AppPasswordField(label: 'Password', hint: '••••••••'),
              AppEmailField(label: 'Email'),
              AppPhoneField(label: 'Phone'),
              AppUrlField(label: 'URL'),
              AppSearchField(hint: 'Search...'),
              AppPinCodeField(label: 'Pin Code'),
            ],
          ),
        ),
        AppSection(
          title: 'Pickers & Complex',
          child: AppColumn(
            gap: AppSpacing.md,
            children: [
              AppDatePickerField(label: 'Date Picker', onChanged: (v) {}),
              AppRatingInput(rating: 3.5, onChanged: (v) {}),
              AppDropdown<String>(
                label: 'Dropdown',
                value: _dropdownValue,
                items: const [
                  AppDropdownItem(
                    value: 'Opt 1',
                    label: 'Option 1',
                    icon: Icons.star_outline,
                  ),
                  AppDropdownItem(
                    value: 'Opt 2',
                    label: 'Option 2',
                    icon: Icons.favorite_outline,
                  ),
                ],
                onChanged: (v) => setState(() => _dropdownValue = v),
              ),
              AppAsyncDropdown<String>(
                label: 'Async Dropdown',
                future: Future.delayed(
                  const Duration(seconds: 1),
                  () => [
                    const AppDropdownItem(value: 'a1', label: 'Async Opt 1'),
                    const AppDropdownItem(value: 'a2', label: 'Async Opt 2'),
                  ],
                ),
                value: null,
                onChanged: (v) {},
              ),
              const AppOtpField(label: 'OTP (4 digit)', length: 4),
              AppSlider(label: 'Range Slider', value: 0.7, onChanged: (v) {}),
            ],
          ),
        ),
      ],
    );
  }
}

class SelectionShowcase extends StatefulWidget {
  const SelectionShowcase({super.key});
  @override
  State<SelectionShowcase> createState() => _SelectionShowcaseState();
}

class _SelectionShowcaseState extends State<SelectionShowcase> {
  bool _check = true;
  bool _switch = false;
  int _radio = 1;
  Set<String> _tags = {'Tag 1'};

  @override
  Widget build(BuildContext context) {
    return AppColumn(
      gap: AppSpacing.lg,
      children: [
        AppSection(
          title: 'Binary Selection',
          child: Row(
            children: [
              AppCheckbox(
                label: 'Checkbox',
                value: _check,
                onChanged: (v) => setState(() => _check = v ?? false),
              ),
              const SizedBox(width: AppSpacing.xl),
              AppSwitch(
                label: 'Switch',
                value: _switch,
                onChanged: (v) => setState(() => _switch = v),
              ),
            ],
          ),
        ),
        AppSection(
          title: 'Radio Group',
          child: AppRadioGroup<int>(
            label: 'Choose one:',
            items: const [
              AppRadioItem(value: 1, label: 'Option 1'),
              AppRadioItem(value: 2, label: 'Option 2'),
            ],
            groupValue: _radio,
            onChanged: (v) => setState(() => _radio = v ?? 1),
          ),
        ),
        AppSection(
          title: 'Chips & Tags',
          child: AppColumn(
            gap: AppSpacing.md,
            children: [
              Wrap(
                spacing: AppSpacing.sm,
                children: [
                  AppChoiceChip(
                    label: 'Choice 1',
                    selected: true,
                    onSelected: (v) {},
                  ),
                  AppChoiceChip(
                    label: 'Choice 2',
                    selected: false,
                    onSelected: (v) {},
                  ),
                  AppFilterChip(
                    label: 'Filter',
                    selected: true,
                    onSelected: (v) {},
                  ),
                  AppInputChip(label: 'Removable', onDeleted: () {}),
                ],
              ),
              AppTagSelector(
                label: 'Multi-select Tags',
                options: const ['Tag 1', 'Tag 2', 'Tag 3', 'Tag 4'],
                selected: _tags,
                onChanged: (v) => setState(() => _tags = v),
              ),
            ],
          ),
        ),
        AppSection(
          title: 'Tiles & Cards',
          child: AppColumn(
            gap: AppSpacing.md,
            children: [
              AppSelectableTile(
                title: 'Selectable Tile',
                subtitle: 'Tap to select this item',
                selected: true,
                onTap: () {},
              ),
              AppSelectableCard(
                selected: false,
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.all(AppSpacing.md),
                  child: AppText('Selectable Card Content'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DataDisplayShowcase extends StatelessWidget {
  const DataDisplayShowcase({super.key});
  @override
  Widget build(BuildContext context) {
    return AppColumn(
      gap: AppSpacing.lg,
      children: [
        const AppSection(
          title: 'Avatars & Badges',
          child: Row(
            children: [
              AppAvatar(initials: 'JD'),
              SizedBox(width: AppSpacing.md),
              AppAvatarGroup(
                avatars: [
                  AppAvatar(initials: 'A'),
                  AppAvatar(initials: 'B'),
                  AppAvatar(initials: 'C'),
                ],
              ),
              SizedBox(width: AppSpacing.xl),
              AppBadge(label: 'Success', color: AppBadgeColor.success),
              SizedBox(width: AppSpacing.sm),
              AppBadge(label: 'Hot', color: AppBadgeColor.error, dot: true),
            ],
          ),
        ),
        const AppSection(
          title: 'Stats & Info',
          child: AppColumn(
            gap: AppSpacing.md,
            children: [
              AppStatCard(
                title: 'Monthly Active Users',
                value: '12.5k',
                trend: '+15.2%',
                trendPositive: true,
              ),
              AppRow(
                children: [
                  AppTag(label: 'Design System'),
                  SizedBox(width: AppSpacing.sm),
                  AppTag(label: 'Flutter', color: AppColors.secondaryLight),
                ],
              ),
            ],
          ),
        ),
        AppSection(
          title: 'Timeline',
          child: AppTimeline(
            items: [
              AppTimelineItem(
                title: 'Project Initialized',
                subtitle: 'Setup the base structure',
                time: '09:00 AM',
                icon: Icons.start,
                iconColor: AppColors.success,
              ),
              AppTimelineItem(
                title: 'Design Review',
                subtitle: 'Reviewing tokens and components',
                time: '11:00 AM',
                icon: Icons.visibility,
                iconColor: AppColors.warning,
              ),
              const AppTimelineItem(title: 'Deployment', time: '04:00 PM'),
            ],
          ),
        ),
        const AppSection(
          title: 'Rich Content',
          child: AppColumn(
            gap: AppSpacing.md,
            children: [
              AppRichText(
                items: [
                  AppRichTextItem(text: 'Check '),
                  AppRichTextItem(
                    text: 'this link',
                    style: TextStyle(
                      color: AppColors.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  AppRichTextItem(text: ' for more info or '),
                  AppRichTextItem(
                    text: 'BOLD TEXT',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              AppDivider(),
              AppListTile(
                title: 'Main Setting Item',
                subtitle: 'Configure your preferences here',
                leading: Icon(Icons.settings_outlined),
                trailing: Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FeedbackShowcase extends StatelessWidget {
  const FeedbackShowcase({super.key});
  @override
  Widget build(BuildContext context) {
    return AppColumn(
      gap: AppSpacing.lg,
      children: [
        const AppSection(
          title: 'Alerts',
          child: AppColumn(
            gap: AppSpacing.sm,
            children: [
              AppAlert(
                title: 'Note',
                message: 'This is a standard info alert.',
                type: AppAlertType.info,
              ),
              AppAlert(
                message: 'Operation completed successfully.',
                type: AppAlertType.success,
              ),
              AppAlert(
                title: 'Warning',
                message: 'Low disk space detected.',
                type: AppAlertType.warning,
              ),
            ],
          ),
        ),
        const AppSection(
          title: 'Skeletons & Loaders',
          child: AppColumn(
            gap: AppSpacing.md,
            children: [
              Row(
                children: [
                  AppSkeleton(height: 50, width: 50, isCircle: true),
                  SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: AppColumn(
                      gap: AppSpacing.xs,
                      children: [
                        AppSkeleton(height: 12, width: 100),
                        AppSkeleton(height: 12),
                      ],
                    ),
                  ),
                ],
              ),
              Center(child: AppLoader()),
            ],
          ),
        ),
        AppSection(
          title: 'Empty States',
          child: AppEmptyState(
            title: 'No results found',
            message:
                'Try adjusting your search filters to find what you are looking for.',
            icon: Icons.search_off_outlined,
            action: 'Clear Filters',
            onAction: () {},
          ),
        ),
      ],
    );
  }
}

class OverlaysShowcase extends StatelessWidget {
  const OverlaysShowcase({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSection(
          title: 'Dialogs & Modals',
          child: Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              AppPrimaryButton(
                label: 'Confirm Dialog',
                onPressed: () => AppConfirmationDialog.show(
                  context: context,
                  title: 'Delete Action',
                  message: 'Are you sure? This cannot be undone.',
                  isDestructive: true,
                  confirmLabel: 'Delete',
                ),
              ),
              AppPrimaryButton(
                label: 'Bottom Sheet',
                onPressed: () => AppBottomSheet.show(
                  context: context,
                  title: 'Select an option',
                  child: Column(
                    children: [
                      AppListTile(
                        title: 'Option A',
                        leading: const Icon(Icons.star_outline),
                        onTap: () {},
                      ),
                      AppListTile(
                        title: 'Option B',
                        leading: const Icon(Icons.star_outline),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
              AppPrimaryButton(
                label: 'Custom Modal',
                onPressed: () => AppModal.show(
                  context: context,
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(AppSpacing.xl),
                      child: AppText('This is a custom modal content'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        AppSection(
          title: 'Context & Tooltips',
          child: Wrap(
            spacing: AppSpacing.xl2,
            children: [
              AppTooltip(
                message: 'I am a tooltip!',
                child: AppText(
                  'Hover/Long press me',
                  variant: AppTextVariant.bodyMedium,
                ),
              ),
              AppContextMenu(
                items: [
                  AppContextMenuItem(
                    label: 'Edit',
                    icon: Icons.edit_outlined,
                    onTap: () {},
                  ),
                  AppContextMenuItem(
                    label: 'Delete',
                    icon: Icons.delete_outline,
                    onTap: () {},
                  ),
                ],
                child: AppCard(child: Text('Right Click / Long Press Me')),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MediaShowcase extends StatelessWidget {
  const MediaShowcase({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AppSection(
          title: 'Image',
          child: AppImage(
            source: 'https://picsum.photos/800/400',
            height: 200,
            width: double.infinity,
          ),
        ),
        SizedBox(height: AppSpacing.xl),
        AppSection(
          title: 'Icons',
          child: Wrap(
            spacing: AppSpacing.lg,
            children: [
              AppIcon(Icons.home, size: AppIconSizes.md),
              AppIcon(
                Icons.settings,
                size: AppIconSizes.lg,
                color: AppColors.secondary,
              ),
              AppIcon(
                Icons.face,
                size: AppIconSizes.xl,
                color: AppColors.success,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AnimationsShowcase extends StatelessWidget {
  const AnimationsShowcase({super.key});
  @override
  Widget build(BuildContext context) {
    return const AppColumn(
      gap: AppSpacing.xl,
      children: [
        AppSection(
          title: 'Entrance Animations',
          child: AppColumn(
            gap: AppSpacing.md,
            children: [
              AppFadeAnimation(child: AppCard(child: Text('Fade Animation'))),
              AppScaleAnimation(child: AppCard(child: Text('Scale Animation'))),
              AppSlideAnimation(child: AppCard(child: Text('Slide Animation'))),
            ],
          ),
        ),
        AppSection(
          title: 'Staggered Content',
          child: AppStaggeredAnimation(
            children: [
              AppCard(child: Text('Item 1')),
              AppCard(child: Text('Item 2')),
              AppCard(child: Text('Item 3')),
            ],
          ),
        ),
      ],
    );
  }
}

class AdvancedShowcase extends StatelessWidget {
  const AdvancedShowcase({super.key});
  @override
  Widget build(BuildContext context) {
    return AppColumn(
      gap: AppSpacing.xl,
      children: [
        AppSection(
          title: 'Async State Wrapper',
          child: AppAsyncStateWrapper<String>(
            status: AppAsyncStatus.success,
            data: 'Fresh data loaded from server!',
            builder: (data) => AppText(data, variant: AppTextVariant.bodyLarge),
          ),
        ),
        const AppSection(
          title: 'Form Section',
          child: AppFormSection(
            title: 'User Profile Details',
            description: 'This section groups related user inputs.',
            children: [
              AppTextField(label: 'Full Name'),
              AppTextField(label: 'Display Name'),
            ],
          ),
        ),
        const AppSection(
          title: 'Advanced Guards',
          child: AppColumn(
            gap: AppSpacing.md,
            children: [
              AppOfflineWrapper(
                isOnline: false, // Force show banner for demo
                child: AppCard(child: Text('Content with Offline Banner')),
              ),
              AppPermissionGate(
                hasPermission: true,
                child: AppCard(
                  child: Text('Protected content (Permission Granted)'),
                ),
              ),
              AppErrorBoundary(child: Text('Content within error boundary')),
            ],
          ),
        ),
      ],
    );
  }
}
