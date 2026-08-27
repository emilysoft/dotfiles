# Media

This module configures all media creation and consumption applications. It covers video editing, audio, image editing, screen recording and media playback.

## Files

### `default.nix`
When the media profile is enabled, installs:

- **DJ**: Mixxx (DJ controller software)
- **Music production**: LMMS (digital audio workstation)
- **Image editing**: GIMP, Pinta, gcolor3 (color picker)
- **Audio editing**: Audacity, Reaper (DAW)
- **Video editing**: Kdenlive, Video Trimmer, HandBrake (conversion)

OBS Studio (recording/streaming) and EasyEffects (real-time audio processing) are enabled at the home level in `home/nit/home.nix` rather than through this module.

This suite covers all media creation and consumption needs, from basic editing to professional production.

### `spicetify.nix`
Configures **Spicetify** for Spotify customization with extensions:

- **adblockify**: blocks ads
- **beautifulLyrics**: displays enhanced lyrics
- **shuffle**: improves shuffle playback control

Used to improve the Spotify experience by removing ads and adding features that the official app does not offer in the free version.

### `mpv.nix`
Configures **MPV** as the video player with custom profiles: standard profile with taskbar progress and image viewer mode with ModernZ osc configuration. Includes modernz and thumbfast scripts. MPV is chosen for being the most powerful and configurable video player available on Linux.

### `recorder.nix`
Defines a custom package for **recorder**, a bash script that wraps wf-recorder for screen recording. Simplifies the recording process with a single command instead of having to remember complex wf-recorder options. Installed globally through `essentials.nix`.

## Directories

| Directory | Description |
|---|---|
| `recorder/` | Contains the `recorder.sh` script that performs screen recording. |