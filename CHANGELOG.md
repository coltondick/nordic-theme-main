# Changelog

## v2.3.5 - Deduplication of keys

Removed duplicate keys causing warnings to be thrown in the log.

## v2.3.3 - Web Awesome color token support

This release adds Web Awesome color token support to both the Nordic and Nordic Blue themes.

Home Assistant is continuing to move parts of the frontend toward newer Web Awesome based components. These components use a newer `wa-color-*` token system for brand, neutral, success, warning, danger, surface, text, and focus colors. This release implements those tokens directly in the themes so newer controls inherit the Nordic palette consistently instead of falling back to Home Assistant defaults.

The supporting Home Assistant semantic color tokens were also added. These include primary and neutral fill states, feedback fill states, on-color tokens, border tokens, and form background tokens. The Web Awesome variables map back to those semantic tokens so the theme has a complete color chain for newer frontend components.

The standard Nordic theme uses the existing frost green accent family for brand and primary states. The Nordic Blue theme uses the frost steel blue and frost sky blue accent family so the blue variant keeps its intended identity.

### Added

- Added Web Awesome brand color tokens:
  - `wa-color-brand-fill-*`
  - `wa-color-brand-border-*`
  - `wa-color-brand-on-*`

- Added Web Awesome neutral color tokens:
  - `wa-color-neutral-fill-*`
  - `wa-color-neutral-border-*`
  - `wa-color-neutral-on-*`

- Added Web Awesome feedback color tokens:
  - `wa-color-success-*`
  - `wa-color-warning-*`
  - `wa-color-danger-*`

- Added Web Awesome surface and text tokens:
  - `wa-color-surface-default`
  - `wa-color-surface-lowered`
  - `wa-color-surface-raised`
  - `wa-color-surface-border`
  - `wa-color-text-normal`
  - `wa-color-text-quiet`
  - `wa-color-text-link`
  - `wa-color-text-link-visited`
  - `wa-color-focus`

- Added supporting Home Assistant semantic fill tokens:
  - `ha-color-fill-primary-quiet-*`
  - `ha-color-fill-primary-normal-*`
  - `ha-color-fill-primary-loud-resting`
  - `ha-color-fill-neutral-quiet-*`
  - `ha-color-fill-neutral-normal-*`
  - `ha-color-fill-neutral-loud-resting`

- Added feedback fill tokens:
  - `ha-color-fill-success-*`
  - `ha-color-fill-warning-*`
  - `ha-color-fill-danger-*`

- Added semantic foreground tokens:
  - `ha-color-on-primary-*`
  - `ha-color-on-neutral-*`
  - `ha-color-on-success-*`
  - `ha-color-on-warning-*`
  - `ha-color-on-danger-*`

- Added semantic border tokens:
  - `ha-color-border-*`
  - `ha-color-border-neutral-*`
  - `ha-color-border-success-*`
  - `ha-color-border-warning-*`
  - `ha-color-border-danger-*`

### Changed

- Updated the standard Nordic theme so Web Awesome brand states use the frost green accent family.
- Updated the Nordic Blue theme so Web Awesome brand states use the frost steel blue and frost sky blue accent family.
- Normalized the 2026.4 form background tokens in both light and dark modes.
- Preserved existing dropdown, list, menu, HACS, MDC, and Material compatibility hardening.
- Preserved the existing contrast-audited light and dark mode palettes.

### Fixed

- Prevented newer Web Awesome components from falling back to default Home Assistant colors.
- Improved consistency between older MDC/Material components and newer Web Awesome components.
- Fixed potential mismatched colors for newer buttons, forms, menus, and focus states.
- Fixed missing semantic token chains that could cause newer frontend components to ignore theme-specific accent colors.
- Ensured the Nordic Blue variant keeps blue branding across newer Web Awesome components.

### Notes

This release is focused on frontend compatibility and token coverage. It does not intentionally redesign the theme. The goal is to make new Home Assistant components inherit the same Nordic color language already used by the rest of the theme.
