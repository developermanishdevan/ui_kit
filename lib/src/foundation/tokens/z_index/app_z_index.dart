/// Specifies predefined Z-Index values when layered stacks exist (e.g. Navigation bars vs Page content vs Modals).
class AppZIndex {
  AppZIndex._();

  /// Under everything
  static const int background = -1;

  /// Default content
  static const int normal = 0;

  /// Dropdowns and selectable lists overlaying content
  static const int dropdown = 1000;

  /// Sticky headers.
  static const int sticky = 1020;

  /// Menus & Navigation bars fixed on screen top/bottom.
  static const int fixed = 1030;

  /// Modal backdrop
  static const int modalBackdrop = 1040;

  /// Real Modals & Dialogs
  static const int modal = 1050;

  /// Popovers
  static const int popover = 1060;

  /// Tooltips at top of everything
  static const int tooltip = 1070;
}
