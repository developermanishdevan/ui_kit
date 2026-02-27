import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class TimelineSection extends StatelessWidget {
  const TimelineSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Timeline', style: AppTypography.h4),
          const SizedBox(height: 24),
          _buildBasicTimeline(context),
          const SizedBox(height: 24),
          _buildAlternateTimeline(context),
          const SizedBox(height: 24),
          _buildTimelineVariants(context),
          const SizedBox(height: 24),
          _buildHorizontalTimeline(context),
        ],
      ),
    );
  }

  Widget _buildBasicTimeline(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Basic Timeline', style: AppTypography.h5),
          const SizedBox(height: 16),
          AppTimeline(
            items: [
              AppTimelineItem(
                title: const Text('Order Placed'),
                subtitle: const Text(
                  'Your order has been successfully placed.',
                ),
                timestamp: const Text('09:20 AM'),
                isActive: true,
              ),
              AppTimelineItem(
                title: const Text('Processing'),
                subtitle: const Text('We are currently processing your order.'),
                timestamp: const Text('10:45 AM'),
              ),
              AppTimelineItem(
                title: const Text('Shipped'),
                subtitle: const Text('Your order is on the way to you.'),
                timestamp: const Text('Yesterday'),
              ),
              AppTimelineItem(
                title: const Text('Delivered'),
                subtitle: const Text('Order has been delivered.'),
                timestamp: const Text('Now'),
                variant: AppTimelineVariant.success,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAlternateTimeline(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Alternate Timeline', style: AppTypography.h5),
          const SizedBox(height: 16),
          AppTimeline(
            position: AppTimelinePosition.alternate,
            items: [
              AppTimelineItem(
                title: const Text('Step One'),
                subtitle: const Text('Initial configuration phase'),
                timestamp: const Text('Oct 10'),
                variant: AppTimelineVariant.info,
              ),
              AppTimelineItem(
                title: const Text('Step Two'),
                content: const AppBadge(label: 'In Progress'),
                timestamp: const Text('Oct 12'),
                isActive: true,
              ),
              AppTimelineItem(
                title: const Text('Step Three'),
                subtitle: const Text('Final verification and QA'),
                timestamp: const Text('Oct 15'),
                variant: AppTimelineVariant.warning,
              ),
              AppTimelineItem(
                title: const Text('Step Four'),
                subtitle: const Text('Deployment and monitoring'),
                timestamp: const Text('Oct 20'),
                variant: AppTimelineVariant.success,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineVariants(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Color Variants', style: AppTypography.h5),
          const SizedBox(height: 16),
          AppTimeline(
            items: [
              const AppTimelineItem(
                title: Text('Primary Signal'),
                variant: AppTimelineVariant.primary,
                isActive: true,
              ),
              const AppTimelineItem(
                title: Text('Success Signal'),
                variant: AppTimelineVariant.success,
              ),
              const AppTimelineItem(
                title: Text('Danger Signal'),
                variant: AppTimelineVariant.danger,
              ),
              const AppTimelineItem(
                title: Text('Warning Signal'),
                variant: AppTimelineVariant.warning,
              ),
              const AppTimelineItem(
                title: Text('Info Signal'),
                variant: AppTimelineVariant.info,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalTimeline(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Horizontal Timeline', style: AppTypography.h5),
          const SizedBox(height: 16),
          AppTimeline(
            axis: Axis.horizontal,
            items: const [
              AppTimelineItem(
                title: Text('2021'),
                subtitle: Text('Project Started'),
                variant: AppTimelineVariant.secondary,
              ),
              AppTimelineItem(
                title: Text('2022'),
                subtitle: Text('MVP Released'),
                isActive: true,
              ),
              AppTimelineItem(
                title: Text('2023'),
                subtitle: Text('Global Expansion'),
                variant: AppTimelineVariant.info,
              ),
              AppTimelineItem(
                title: Text('2024'),
                subtitle: Text('Next Gen Launch'),
                variant: AppTimelineVariant.success,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
