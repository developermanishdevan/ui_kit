import 'package:ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';

class AvatarSection extends StatelessWidget {
  const AvatarSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    // Sample image URLs - using high quality random portraits
    const avatarUrl = 'https://i.pravatar.cc/300?img=11';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Avatars',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Base UI  >  Avatars',
              style: AppTypography.bodySm.copyWith(
                color: theme.bodySecondaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s4),

        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 900) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildBasicExample(context, avatarUrl)),
                  const SizedBox(width: AppSpacing.s4),
                  Expanded(
                    child: _buildRoundedCircleExample(context, avatarUrl),
                  ),
                ],
              );
            }
            return Column(
              children: [
                _buildBasicExample(context, avatarUrl),
                const SizedBox(height: AppSpacing.s4),
                _buildRoundedCircleExample(context, avatarUrl),
              ],
            );
          },
        ),

        const SizedBox(height: AppSpacing.s4),
        _buildShapesAndThumbnails(context, avatarUrl),

        const SizedBox(height: AppSpacing.s4),
        _buildAvatarGroupExample(context, avatarUrl),
      ],
    );
  }

  Widget _buildBasicExample(BuildContext context, String url) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardTitle(context, 'Basic Example'),
          Text(
            'Create and group avatars of different sizes and shapes with the css classes.',
            style: AppTypography.bodySm.copyWith(
              color: Theme.of(
                context,
              ).extension<AppColorsExtension>()!.bodySecondaryColor,
            ),
          ),
          const SizedBox(height: AppSpacing.s4),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              _buildAvatarWithSize(
                context,
                AppAvatar.xs(imageUrl: url),
                'avatar-xs',
              ),
              _buildAvatarWithSize(
                context,
                AppAvatar.sm(imageUrl: url),
                'avatar-sm',
              ),
              _buildAvatarWithSize(
                context,
                AppAvatar.md(imageUrl: url),
                'avatar-md',
              ),
              _buildAvatarWithSize(
                context,
                AppAvatar.lg(imageUrl: url),
                'avatar-lg',
              ),
              _buildAvatarWithSize(
                context,
                AppAvatar.xl(imageUrl: url),
                'avatar-xl',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoundedCircleExample(BuildContext context, String url) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardTitle(context, 'Rounded Circle'),
          Text(
            'Using AppAvatarShape.circle creates the rounded avatar.',
            style: AppTypography.bodySm.copyWith(
              color: Theme.of(
                context,
              ).extension<AppColorsExtension>()!.bodySecondaryColor,
            ),
          ),
          const SizedBox(height: AppSpacing.s4),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              _buildAvatarWithSize(
                context,
                AppAvatar.md(imageUrl: url, shape: AppAvatarShape.circle),
                'avatar-md',
              ),
              _buildAvatarWithSize(
                context,
                AppAvatar.lg(imageUrl: url, shape: AppAvatarShape.circle),
                'avatar-lg',
              ),
              _buildAvatarWithSize(
                context,
                AppAvatar.xl(imageUrl: url, shape: AppAvatarShape.circle),
                'avatar-xl',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShapesAndThumbnails(BuildContext context, String url) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardTitle(context, 'Images Shapes & Thumbnails'),
          Text(
            'Avatars with different sizes, shapes and optional border thumbnails.',
            style: AppTypography.bodySm.copyWith(
              color: Theme.of(
                context,
              ).extension<AppColorsExtension>()!.bodySecondaryColor,
            ),
          ),
          const SizedBox(height: AppSpacing.s4),
          Wrap(
            spacing: 30,
            runSpacing: 20,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              _buildAvatarWithSize(
                context,
                AppAvatar(
                  imageUrl: url,
                  size: 120,
                  shape: AppAvatarShape.rounded,
                ),
                '.rounded',
              ),
              _buildAvatarWithSize(
                context,
                AppAvatar(
                  imageUrl: url,
                  size: 120,
                  shape: AppAvatarShape.circle,
                ),
                '.rounded-circle',
              ),
              _buildAvatarWithSize(
                context,
                AppAvatar(
                  imageUrl: url,
                  size: 120,
                  shape: AppAvatarShape.square,
                  hasThumbnail: true,
                ),
                '.thumbnail',
              ),
              _buildAvatarWithSize(
                context,
                AppAvatar(
                  imageUrl: url,
                  size: 120,
                  shape: AppAvatarShape.circle,
                  hasThumbnail: true,
                ),
                '.rounded-circle .thumbnail',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarGroupExample(BuildContext context, String url) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardTitle(context, 'Avatar Group'),
          Text(
            'Group multiple avatars together completely stacked using AppAvatarGroup.',
            style: AppTypography.bodySm.copyWith(
              color: Theme.of(
                context,
              ).extension<AppColorsExtension>()!.bodySecondaryColor,
            ),
          ),
          const SizedBox(height: AppSpacing.s4),
          Wrap(
            spacing: 40,
            runSpacing: 20,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              _buildAvatarWithSize(
                context,
                AppAvatarGroup(
                  avatars: List.generate(
                    4,
                    (index) => AppAvatar.md(
                      imageUrl: 'https://i.pravatar.cc/300?img=${11 + index}',
                      shape: AppAvatarShape.circle,
                    ),
                  ),
                ),
                'avatar-group',
              ),
              _buildAvatarWithSize(
                context,
                AppAvatarGroup(
                  max: 3,
                  avatars: List.generate(
                    6,
                    (index) => AppAvatar.md(
                      imageUrl: 'https://i.pravatar.cc/300?img=${20 + index}',
                      shape: AppAvatarShape.circle,
                    ),
                  ),
                ),
                'avatar-group with overflow',
              ),
              _buildAvatarWithSize(
                context,
                AppAvatarGroup(
                  max: 4,
                  avatars: List.generate(
                    8,
                    (index) => AppAvatar(
                      size: AppAvatarSize.lg,
                      imageUrl: 'https://i.pravatar.cc/300?img=${30 + index}',
                      shape: AppAvatarShape.rounded,
                    ),
                  ),
                ),
                'avatar-group (.rounded lg)',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarWithSize(
    BuildContext context,
    Widget avatar,
    String label,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        avatar,
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTypography.bodySm.copyWith(
            color: Theme.of(
              context,
            ).extension<AppColorsExtension>()!.bodySecondaryColor,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }

  Widget _buildCardTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s4),
      child: Text(
        title,
        style: AppTypography.h6.copyWith(
          fontWeight: AppTypography.semiBold,
          color: Theme.of(
            context,
          ).extension<AppColorsExtension>()!.textEmphasis,
        ),
      ),
    );
  }
}
