import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class CarouselSection extends StatelessWidget {
  const CarouselSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Carousel',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Base UI  >  Carousel',
              style: AppTypography.bodySm.copyWith(
                color: theme.bodySecondaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s4),

        LayoutBuilder(
          builder: (context, constraints) {
            final isLarge = constraints.maxWidth > 992;

            if (isLarge) {
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildSlidesOnlyCard(context)),
                      const SizedBox(width: AppSpacing.s4),
                      Expanded(child: _buildControlsCard(context)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.s4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildIndicatorsCard(context)),
                      const SizedBox(width: AppSpacing.s4),
                      Expanded(child: _buildCaptionsCard(context)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.s4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildCrossfadeCard(context)),
                      const SizedBox(width: AppSpacing.s4),
                      Expanded(child: _buildIndividualIntervalCard(context)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.s4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildDarkVariantCard(context)),
                      const SizedBox(width: AppSpacing.s4),
                      Expanded(child: _buildDisableTouchCard(context)),
                    ],
                  ),
                ],
              );
            }

            return Column(
              children: [
                _buildSlidesOnlyCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildControlsCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildIndicatorsCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildCaptionsCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildCrossfadeCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildIndividualIntervalCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildDarkVariantCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildDisableTouchCard(context),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildCardHeader(BuildContext context, String title, String subtitle) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.h5.copyWith(
            fontWeight: AppTypography.semiBold,
            color: theme.textEmphasis,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: AppTypography.bodySm.copyWith(
            color: theme.bodySecondaryColor,
            height: 1.5,
          ),
        ),
        const SizedBox(height: AppSpacing.s4),
      ],
    );
  }

  List<AppCarouselItem> _getDemoItems() {
    return [
      AppCarouselItem(
        child: Image.network(
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800&auto=format&fit=crop',
          fit: BoxFit.cover,
        ),
      ),
      AppCarouselItem(
        child: Image.network(
          'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?w=800&auto=format&fit=crop',
          fit: BoxFit.cover,
        ),
      ),
      AppCarouselItem(
        child: Image.network(
          'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800&auto=format&fit=crop',
          fit: BoxFit.cover,
        ),
      ),
    ];
  }

  Widget _buildSlidesOnlyCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Slides Only',
            'Here’s a carousel with slides only. Note the presence of the .d-block and .img-fluid on carousel images.',
          ),
          AppCarousel(
            items: _getDemoItems(),
            showControls: false,
            showIndicators: false,
          ),
        ],
      ),
    );
  }

  Widget _buildControlsCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'With Controls',
            'Adding in the previous and next controls:',
          ),
          AppCarousel(items: _getDemoItems(), showIndicators: false),
        ],
      ),
    );
  }

  Widget _buildIndicatorsCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'With Indicators',
            'You can also add the indicators to the carousel, alongside the controls, too.',
          ),
          AppCarousel(items: _getDemoItems()),
        ],
      ),
    );
  }

  Widget _buildCaptionsCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'With Captions',
            'Add captions to your slides easily with the .carousel-caption element within any .carousel-item.',
          ),
          AppCarousel(
            items: [
              AppCarouselItem(
                child: Image.network(
                  'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=800&auto=format&fit=crop',
                  fit: BoxFit.cover,
                ),
                caption: Column(
                  children: const [
                    Text(
                      'First slide label',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Some representative placeholder content for the first slide.',
                    ),
                  ],
                ),
              ),
              AppCarouselItem(
                child: Image.network(
                  'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=800&auto=format&fit=crop',
                  fit: BoxFit.cover,
                ),
                caption: Column(
                  children: const [
                    Text(
                      'Second slide label',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Some representative placeholder content for the second slide.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCrossfadeCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Crossfade',
            'Add .carousel-fade to your carousel to animate slides with a fade transition instead of a slide.',
          ),
          AppCarousel(items: _getDemoItems(), isFade: true),
        ],
      ),
    );
  }

  Widget _buildIndividualIntervalCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Individual interval',
            'Add data-bs-interval="" to a .carousel-item to change the amount of time to delay.',
          ),
          AppCarousel(
            items: [
              AppCarouselItem(
                child: Image.network(
                  'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800&auto=format&fit=crop',
                  fit: BoxFit.cover,
                ),
                interval: const Duration(seconds: 10),
              ),
              AppCarouselItem(
                child: Image.network(
                  'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?w=800&auto=format&fit=crop',
                  fit: BoxFit.cover,
                ),
                interval: const Duration(seconds: 2),
              ),
              AppCarouselItem(
                child: Image.network(
                  'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800&auto=format&fit=crop',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDarkVariantCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Dark Variant',
            'Add .carousel-dark to the .carousel for darker controls, indicators, and captions.',
          ),
          AppCarousel(
            items: [
              AppCarouselItem(
                child: Container(color: Colors.grey[200]),
                caption: Column(
                  children: const [
                    Text(
                      'First slide label',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text('Light background needs dark controls.'),
                  ],
                ),
              ),
              AppCarouselItem(
                child: Container(color: Colors.grey[300]),
                caption: Column(
                  children: const [
                    Text(
                      'Second slide label',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text('Dark variant handles this perfectly.'),
                  ],
                ),
              ),
            ],
            isDark: true,
          ),
        ],
      ),
    );
  }

  Widget _buildDisableTouchCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Disable touch swiping',
            'Carousels support swiping left/right on touchscreen devices to move between slides. This can be disabled.',
          ),
          AppCarousel(
            items: _getDemoItems(),
            allowTouchSwipe: false,
            autoplay: false,
          ),
        ],
      ),
    );
  }
}
