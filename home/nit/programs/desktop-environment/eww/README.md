# Eww Widgets

This directory contains the configuration for **Eww** (ElKowar's Wacky Widgets), the widget system used to create the status bar and other visual elements of the desktop.

## Files

| File | Description |
|---|---|
| `eww.yuck` | Defines the structure and layout of widgets in Yuck format (Eww's DSL). Configures the status bar with its components: clock, system info, workspace indicators, etc. |
| `eww.scss` | SCSS stylesheet that defines colors, fonts, sizes and borders of the widgets. Uses the Catppuccin Mocha palette to maintain consistency with the desktop theme. |
| `scripts/` | Contains helper scripts that feed widgets with dynamic system information (CPU usage, memory, battery, etc.). |

Eww is used because it allows creating highly customizable widgets that integrate perfectly with Niri and other Wayland environment components.
