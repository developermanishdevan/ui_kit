# 🏗️ Enterprise UI Kit — Master Implementation Guide

> **Version:** 1.0.0 | **Flutter SDK:** ≥3.11.0 | **Dart SDK:** ≥3.0.0
> **Total Components:** 160+ across 12 categories

---

## 📋 Table of Contents

| # | Guide File | Coverage |
|---|-----------|----------|
| 1 | [GUIDE_01_SETUP.md](./docs/guides/GUIDE_01_SETUP.md) | Project setup, pubspec, folder scaffold |
| 2 | [GUIDE_02_FOUNDATION.md](./docs/guides/GUIDE_02_FOUNDATION.md) | Design tokens, colors, typography, spacing, etc. |
| 3 | [GUIDE_03_THEME.md](./docs/guides/GUIDE_03_THEME.md) | AppTheme, light/dark, extensions, controller |
| 4 | [GUIDE_04_LAYOUT.md](./docs/guides/GUIDE_04_LAYOUT.md) | Scaffold, screens, flex, grid, scroll, slivers |
| 5 | [GUIDE_05_NAVIGATION.md](./docs/guides/GUIDE_05_NAVIGATION.md) | AppBar, BottomNav, Drawer, TabBar, routing |
| 6 | [GUIDE_06_BUTTONS.md](./docs/guides/GUIDE_06_BUTTONS.md) | All 20+ button variants |
| 7 | [GUIDE_07_INPUTS.md](./docs/guides/GUIDE_07_INPUTS.md) | All 25+ input/form field variants |
| 8 | [GUIDE_08_SELECTION.md](./docs/guides/GUIDE_08_SELECTION.md) | Checkbox, Radio, Switch, Chips, etc. |
| 9 | [GUIDE_09_DATA_DISPLAY.md](./docs/guides/GUIDE_09_DATA_DISPLAY.md) | Cards, Table, Avatar, Badge, Timeline, etc. |
| 10 | [GUIDE_10_FEEDBACK.md](./docs/guides/GUIDE_10_FEEDBACK.md) | Loaders, Shimmer, Snackbar, States, Dialogs |
| 11 | [GUIDE_11_OVERLAYS.md](./docs/guides/GUIDE_11_OVERLAYS.md) | BottomSheet, Modal, Tooltip, Context Menu |
| 12 | [GUIDE_12_MEDIA.md](./docs/guides/GUIDE_12_MEDIA.md) | Image, Video, Audio, Lottie, Icon |
| 13 | [GUIDE_13_ANIMATIONS.md](./docs/guides/GUIDE_13_ANIMATIONS.md) | Fade, Scale, Slide, Staggered, Transitions |
| 14 | [GUIDE_14_ADVANCED.md](./docs/guides/GUIDE_14_ADVANCED.md) | Forms, Guards, Async wrappers, Analytics |
| 15 | [GUIDE_15_GALLERY.md](./docs/guides/GUIDE_15_GALLERY.md) | ui_gallery_app setup & component showcase |
| 16 | [GUIDE_16_TESTING.md](./docs/guides/GUIDE_16_TESTING.md) | Unit, widget, golden tests strategy |

---

## 🏛️ Architecture Overview

```
ui_kit (Flutter Package)
│
├── lib/
│   ├── ui_kit.dart              ← Single barrel export
│   └── src/
│       ├── foundation/          ← Design tokens + base classes
│       ├── theme/               ← Light/dark theme + extensions
│       ├── responsive/          ← Breakpoints + responsive builder
│       ├── accessibility/       ← Semantics + a11y helpers
│       ├── layout/              ← Structural + scroll widgets
│       ├── navigation/          ← Nav patterns
│       ├── components/          ← All UI components (8 sub-categories)
│       ├── animations/          ← Animation wrappers
│       └── utils/               ← Validators, formatters, extensions
│
├── ui_gallery_app/              ← Standalone Flutter app (showcase)
└── test/                        ← Widget + golden tests
```

---

## 🔑 Core Design Principles

1. **Token-First** — Every spacing, color, radius value comes from a token constant. No magic numbers.
2. **Theme-Aware** — Every component reads from `Theme.of(context)` + custom `ThemeExtension`s.
3. **Accessible** — Semantic labels, minimum tap targets (48×48), contrast ratios enforced.
4. **Responsive** — All components adapt via `AppResponsiveBuilder` + `AppBreakpoints`.
5. **Barrel Export** — One import: `import 'package:ui_kit/ui_kit.dart'`.
6. **Zero External Dependencies** (foundation) — Only Flutter SDK in core. Optional deps for media/animations.

---

## 📦 Dependency Strategy

### Core (zero deps)
Foundation, theme, layout, navigation, buttons, inputs, selection, data display, feedback, overlays — **pure Flutter SDK only**.

### Optional Dependencies (add as needed per feature)
| Package | Used For | Category |
|---------|----------|----------|
| `cached_network_image` | `AppCachedImage` | media |
| `flutter_svg` | `AppSvgImage` | media |
| `lottie` | `AppLottieAnimation` | media |
| `video_player` | `AppVideoPlayerWrapper` | media |
| `just_audio` | `AppAudioPlayerWrapper` | media |
| `flutter_animate` | `AppStaggeredAnimation` | animations |
| `shimmer` | `AppShimmer` | feedback |

---

## 🚀 Implementation Order (Recommended)

Follow this sequence to avoid dependency issues:

```
Phase 1 (Foundation)     → GUIDE_01 → GUIDE_02 → GUIDE_03
Phase 2 (Layout+Nav)     → GUIDE_04 → GUIDE_05
Phase 3 (Core UI)        → GUIDE_06 → GUIDE_07 → GUIDE_08
Phase 4 (Data+Feedback)  → GUIDE_09 → GUIDE_10 → GUIDE_11
Phase 5 (Media+Anim)     → GUIDE_12 → GUIDE_13
Phase 6 (Advanced)       → GUIDE_14
Phase 7 (Gallery+Tests)  → GUIDE_15 → GUIDE_16
```

---

## 📁 File Naming Convention

| Type | Convention | Example |
|------|-----------|---------|
| Widget file | `snake_case.dart` | `app_primary_button.dart` |
| Class name | `PascalCase` | `AppPrimaryButton` |
| Token constant | `SCREAMING_SNAKE` inside class | `AppSpacing.md` |
| Private helpers | `_camelCase` | `_buildContent()` |
| Test file | `*_test.dart` | `app_primary_button_test.dart` |

---

## 🔗 Quick Reference

- **All exports** → `lib/ui_kit.dart`
- **Token values** → `lib/src/foundation/tokens/`
- **Theme setup** → `lib/src/theme/app_theme.dart`
- **Component base** → `lib/src/foundation/base/app_base_widget.dart`
- **Gallery entry** → `ui_gallery_app/lib/main.dart`
