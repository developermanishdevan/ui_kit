# Guide 01 — Project Setup & Folder Scaffold

## 1.1 Update `pubspec.yaml`

```yaml
name: ui_kit
description: "Enterprise-grade Flutter UI component library with 160+ components."
version: 1.0.0
homepage: https://github.com/your-org/ui_kit

environment:
  sdk: ">=3.0.0 <4.0.0"
  flutter: ">=3.11.0"

dependencies:
  flutter:
    sdk: flutter

  # --- Optional: uncomment as you implement each category ---
  # cached_network_image: ^3.4.1   # AppCachedImage
  # flutter_svg: ^2.0.10           # AppSvgImage
  # lottie: ^3.1.2                 # AppLottieAnimation
  # video_player: ^2.9.1           # AppVideoPlayerWrapper
  # just_audio: ^0.9.40            # AppAudioPlayerWrapper
  # shimmer: ^3.0.0                # AppShimmer
  # flutter_animate: ^4.5.0        # AppStaggeredAnimation

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
  # golden_toolkit: ^0.15.0       # golden tests

flutter:
  # Add fonts when needed:
  # fonts:
  #   - family: Inter
  #     fonts:
  #       - asset: assets/fonts/Inter-Regular.ttf
  #       - asset: assets/fonts/Inter-Medium.ttf
  #         weight: 500
  #       - asset: assets/fonts/Inter-SemiBold.ttf
  #         weight: 600
  #       - asset: assets/fonts/Inter-Bold.ttf
  #         weight: 700
```

---

## 1.2 `analysis_options.yaml`

```yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  errors:
    missing_required_param: error
    missing_return: error
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"

linter:
  rules:
    - always_declare_return_types
    - always_put_required_named_parameters_first
    - avoid_empty_else
    - avoid_print
    - prefer_const_constructors
    - prefer_const_declarations
    - prefer_final_fields
    - sort_constructors_first
    - use_super_parameters
```

---

## 1.3 Full Folder Scaffold

Run this once to create all directories. Each folder will receive files in subsequent guides.

```
lib/
└── src/
    ├── foundation/
    │   ├── tokens/
    │   │   ├── colors/
    │   │   ├── typography/
    │   │   ├── spacing/
    │   │   ├── radius/
    │   │   ├── elevation/
    │   │   ├── shadows/
    │   │   ├── gradients/
    │   │   ├── opacity/
    │   │   ├── z_index/
    │   │   ├── breakpoints/
    │   │   ├── durations/
    │   │   ├── icon_sizes/
    │   │   └── border_styles/
    │   ├── config/
    │   └── base/
    ├── theme/
    ├── responsive/
    ├── accessibility/
    ├── layout/
    │   ├── structure/
    │   ├── flex/
    │   ├── grid/
    │   ├── slivers/
    │   └── scroll/
    ├── navigation/
    ├── components/
    │   ├── buttons/
    │   ├── inputs/
    │   ├── selection/
    │   ├── data_display/
    │   ├── feedback/
    │   ├── overlays/
    │   └── media/
    ├── animations/
    └── utils/
        ├── validators/
        ├── formatters/
        ├── helpers/
        └── extensions/
```

---

## 1.4 Barrel Export Entry Point

**`lib/ui_kit.dart`** — the single import users need:

```dart
library ui_kit;

// Foundation
export 'src/foundation/tokens/colors/app_colors.dart';
export 'src/foundation/tokens/typography/app_typography.dart';
export 'src/foundation/tokens/spacing/app_spacing.dart';
export 'src/foundation/tokens/radius/app_radius.dart';
export 'src/foundation/tokens/elevation/app_elevation.dart';
export 'src/foundation/tokens/shadows/app_shadows.dart';
export 'src/foundation/tokens/gradients/app_gradients.dart';
export 'src/foundation/tokens/opacity/app_opacity.dart';
export 'src/foundation/tokens/z_index/app_z_index.dart';
export 'src/foundation/tokens/breakpoints/app_breakpoints.dart';
export 'src/foundation/tokens/durations/app_durations.dart';
export 'src/foundation/tokens/icon_sizes/app_icon_sizes.dart';
export 'src/foundation/tokens/border_styles/app_border_styles.dart';
export 'src/foundation/config/app_brand.dart';
export 'src/foundation/config/app_ui_config.dart';
export 'src/foundation/config/feature_flags.dart';
export 'src/foundation/base/app_base_widget.dart';
export 'src/foundation/base/app_interactive_widget.dart';
export 'src/foundation/base/app_stateful_wrapper.dart';
export 'src/foundation/base/app_stateless_wrapper.dart';

// Theme
export 'src/theme/app_theme.dart';
export 'src/theme/light_theme.dart';
export 'src/theme/dark_theme.dart';
export 'src/theme/theme_extensions.dart';
export 'src/theme/theme_controller.dart';

// Responsive
export 'src/responsive/app_breakpoints.dart';
export 'src/responsive/app_responsive.dart';
export 'src/responsive/app_responsive_builder.dart';
export 'src/responsive/app_device_type.dart';

// Accessibility
export 'src/accessibility/app_semantics.dart';
export 'src/accessibility/app_accessible_button.dart';
export 'src/accessibility/app_text_scaler.dart';

// Layout
export 'src/layout/structure/app_scaffold/app_scaffold.dart';
export 'src/layout/structure/app_screen/app_screen.dart';
export 'src/layout/structure/app_container/app_container.dart';
export 'src/layout/structure/app_section/app_section.dart';
export 'src/layout/structure/app_safe_area/app_safe_area.dart';
export 'src/layout/structure/app_keyboard_aware_view/app_keyboard_aware_view.dart';
export 'src/layout/flex/app_row/app_row.dart';
export 'src/layout/flex/app_column/app_column.dart';
export 'src/layout/flex/app_wrap/app_wrap.dart';
export 'src/layout/flex/app_stack/app_stack.dart';
export 'src/layout/grid/app_grid/app_grid.dart';
export 'src/layout/grid/app_masonry_grid/app_masonry_grid.dart';
export 'src/layout/grid/app_responsive_grid/app_responsive_grid.dart';
export 'src/layout/slivers/app_sliver_appbar/app_sliver_appbar.dart';
export 'src/layout/slivers/app_sliver_list/app_sliver_list.dart';
export 'src/layout/slivers/app_sliver_grid/app_sliver_grid.dart';
export 'src/layout/scroll/app_list_view/app_list_view.dart';
export 'src/layout/scroll/app_separated_list_view/app_separated_list_view.dart';
export 'src/layout/scroll/app_page_view/app_page_view.dart';
export 'src/layout/scroll/app_infinite_scroll_list/app_infinite_scroll_list.dart';
export 'src/layout/scroll/app_pull_to_refresh/app_pull_to_refresh.dart';

// Navigation
export 'src/navigation/app_bar/app_app_bar.dart';
export 'src/navigation/bottom_navigation/app_bottom_navigation_bar.dart';
export 'src/navigation/navigation_rail/app_navigation_rail.dart';
export 'src/navigation/drawer/app_drawer.dart';
export 'src/navigation/tab_bar/app_tab_bar.dart';
export 'src/navigation/breadcrumb/app_breadcrumb.dart';
export 'src/navigation/route_transitions/app_route_transition.dart';
export 'src/navigation/sidebar/app_sidebar.dart';

// Components — Buttons
export 'src/components/buttons/base/app_base_button.dart';
export 'src/components/buttons/primary/app_primary_button.dart';
export 'src/components/buttons/secondary/app_secondary_button.dart';
export 'src/components/buttons/outline/app_outline_button.dart';
export 'src/components/buttons/ghost/app_ghost_button.dart';
export 'src/components/buttons/gradient/app_gradient_button.dart';
export 'src/components/buttons/destructive/app_destructive_button.dart';
export 'src/components/buttons/segmented/app_segmented_button.dart';
export 'src/components/buttons/toggle/app_toggle_button.dart';
export 'src/components/buttons/icon_button/app_icon_button.dart';
export 'src/components/buttons/floating/app_floating_button.dart';
export 'src/components/buttons/split_button/app_split_button.dart';
export 'src/components/buttons/link_button/app_link_button.dart';

// Components — Inputs
export 'src/components/inputs/text_field/app_text_field.dart';
export 'src/components/inputs/password_field/app_password_field.dart';
export 'src/components/inputs/search_field/app_search_field.dart';
export 'src/components/inputs/dropdown/app_dropdown.dart';
export 'src/components/inputs/async_dropdown/app_async_dropdown.dart';
export 'src/components/inputs/date_picker/app_date_picker_field.dart';
export 'src/components/inputs/time_picker/app_time_picker_field.dart';
export 'src/components/inputs/range_picker/app_date_range_picker.dart';
export 'src/components/inputs/slider/app_slider.dart';
export 'src/components/inputs/file_picker/app_file_picker.dart';
export 'src/components/inputs/image_picker/app_image_picker.dart';
export 'src/components/inputs/rating_input/app_rating_input.dart';
export 'src/components/inputs/otp_field/app_otp_field.dart';
export 'src/components/inputs/pin_code_field/app_pin_code_field.dart';
export 'src/components/inputs/email_field/app_email_field.dart';
export 'src/components/inputs/phone_field/app_phone_field.dart';
export 'src/components/inputs/url_field/app_url_field.dart';
export 'src/components/inputs/multiline_field/app_multiline_field.dart';

// Components — Selection
export 'src/components/selection/checkbox/app_checkbox.dart';
export 'src/components/selection/radio/app_radio.dart';
export 'src/components/selection/switch/app_switch.dart';
export 'src/components/selection/choice_chip/app_choice_chip.dart';
export 'src/components/selection/filter_chip/app_filter_chip.dart';
export 'src/components/selection/input_chip/app_input_chip.dart';
export 'src/components/selection/tag_selector/app_tag_selector.dart';
export 'src/components/selection/selectable_tile/app_selectable_tile.dart';
export 'src/components/selection/selectable_card/app_selectable_card.dart';
export 'src/components/selection/multi_select_list/app_multi_select_list.dart';

// Components — Data Display
export 'src/components/data_display/text/app_text.dart';
export 'src/components/data_display/rich_text/app_rich_text.dart';
export 'src/components/data_display/badge/app_badge.dart';
export 'src/components/data_display/avatar/app_avatar.dart';
export 'src/components/data_display/avatar_group/app_avatar_group.dart';
export 'src/components/data_display/divider/app_divider.dart';
export 'src/components/data_display/list_tile/app_list_tile.dart';
export 'src/components/data_display/expandable_tile/app_expandable_tile.dart';
export 'src/components/data_display/card/app_card.dart';
export 'src/components/data_display/stat_card/app_stat_card.dart';
export 'src/components/data_display/profile_card/app_profile_card.dart';
export 'src/components/data_display/product_card/app_product_card.dart';
export 'src/components/data_display/info_card/app_info_card.dart';
export 'src/components/data_display/table/app_table.dart';
export 'src/components/data_display/paginated_table/app_paginated_table.dart';
export 'src/components/data_display/timeline/app_timeline.dart';
export 'src/components/data_display/stepper/app_stepper.dart';
export 'src/components/data_display/accordion/app_accordion.dart';
export 'src/components/data_display/key_value_row/app_key_value_row.dart';
export 'src/components/data_display/tag/app_tag.dart';

// Components — Feedback
export 'src/components/feedback/loader/app_loader.dart';
export 'src/components/feedback/circular_loader/app_circular_loader.dart';
export 'src/components/feedback/linear_loader/app_linear_loader.dart';
export 'src/components/feedback/shimmer/app_shimmer.dart';
export 'src/components/feedback/skeleton/app_skeleton.dart';
export 'src/components/feedback/snackbar/app_snackbar.dart';
export 'src/components/feedback/toast/app_toast.dart';
export 'src/components/feedback/banner/app_banner.dart';
export 'src/components/feedback/alert/app_alert.dart';
export 'src/components/feedback/success_state/app_success_state.dart';
export 'src/components/feedback/error_state/app_error_state.dart';
export 'src/components/feedback/empty_state/app_empty_state.dart';
export 'src/components/feedback/no_internet_state/app_no_internet_state.dart';
export 'src/components/feedback/maintenance_state/app_maintenance_state.dart';
export 'src/components/feedback/permission_denied_state/app_permission_denied_state.dart';
export 'src/components/feedback/retry_wrapper/app_retry_wrapper.dart';

// Components — Overlays
export 'src/components/overlays/dialog/app_dialog.dart';
export 'src/components/overlays/confirmation_dialog/app_confirmation_dialog.dart';
export 'src/components/overlays/input_dialog/app_input_dialog.dart';
export 'src/components/overlays/full_screen_dialog/app_full_screen_dialog.dart';
export 'src/components/overlays/bottom_sheet/app_bottom_sheet.dart';
export 'src/components/overlays/draggable_bottom_sheet/app_draggable_bottom_sheet.dart';
export 'src/components/overlays/modal/app_modal.dart';
export 'src/components/overlays/popover/app_popover.dart';
export 'src/components/overlays/tooltip/app_tooltip.dart';
export 'src/components/overlays/context_menu/app_context_menu.dart';

// Components — Media
export 'src/components/media/image/app_image.dart';
export 'src/components/media/network_image/app_network_image.dart';
export 'src/components/media/icon/app_icon.dart';
export 'src/components/media/icon_badge/app_icon_badge.dart';
export 'src/components/media/hero_wrapper/app_hero_wrapper.dart';

// Animations
export 'src/animations/fade/app_fade_animation.dart';
export 'src/animations/scale/app_scale_animation.dart';
export 'src/animations/slide/app_slide_animation.dart';
export 'src/animations/rotate/app_rotate_animation.dart';
export 'src/animations/size/app_size_animation.dart';
export 'src/animations/staggered/app_staggered_animation.dart';
export 'src/animations/animated_switcher/app_animated_switcher.dart';
export 'src/animations/animated_container/app_animated_container.dart';
export 'src/animations/page_transition/app_page_transition.dart';
export 'src/animations/animation_controller_wrapper/app_animation_controller_wrapper.dart';

// Utils
export 'src/utils/validators/app_validators.dart';
export 'src/utils/formatters/app_formatters.dart';
export 'src/utils/helpers/app_helpers.dart';
export 'src/utils/extensions/app_extensions.dart';
```

---

## 1.5 Component File Template

Every component file follows this structure:

```dart
// lib/src/components/buttons/primary/app_primary_button.dart

import 'package:flutter/material.dart';
import '../../../foundation/tokens/colors/app_colors.dart';
import '../../../foundation/tokens/spacing/app_spacing.dart';
import '../../../foundation/tokens/radius/app_radius.dart';
import '../../../foundation/tokens/durations/app_durations.dart';
import '../base/app_base_button.dart';

/// A filled primary action button.
///
/// Usage:
/// ```dart
/// AppPrimaryButton(
///   label: 'Save',
///   onPressed: () {},
/// )
/// ```
class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.width,
    this.size = AppButtonSize.medium,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final IconData? icon;
  final double? width;
  final AppButtonSize size;

  @override
  Widget build(BuildContext context) {
    // Implementation here
    throw UnimplementedError();
  }
}
```
