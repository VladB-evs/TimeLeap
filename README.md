# TimeSight - macOS Menu Bar Time Zone App

## Overview
TimeSight is a lightweight macOS menu bar app that allows you to track multiple time zones effortlessly. Designed for professionals, travelers, and remote workers, it provides a quick and elegant way to check the time in up to three different locations right from the menu bar.

## Features
- 🕒 **Menu Bar Integration**: Displays selected time zones directly in the macOS menu bar.
- 🌎 **Multiple Time Zones**: Add and manage up to three time zones.
- 🎨 **Minimalist Design**: Clean and simple UI for a seamless experience.
- ⚡ **Quick Access**: Click the menu bar icon to open a detailed view with additional information.
- 📅 **Live Updates**: Automatically updates the time every second.

## Installation
### 1. Download & Install
- Clone the repository:
  ```sh
  git clone https://github.com/VladB-evs/TimeLeap
  cd TimeLeap
  ```
- Open `TimeSight.xcodeproj` in Xcode.
- Select `Product > Run` to build and launch the app.

### 2. Set Up the App
- The app runs in the menu bar with a clock icon.
- Click the icon to open the time zone selection menu.
- Choose up to three time zones to display.

## How It Works
### Menu Bar Display
The selected time zones appear in the menu bar in the format:
```
Berlin 12:30 | Manila 18:30 | New York 06:30
```
### Adding/Removing Time Zones
- Click the menu bar icon.
- Use the "Add Time Zone" menu to select new locations.
- Remove a time zone by clicking the ❌ next to it.

## Configuration
To ensure the app only appears in the menu bar (and not the Dock), the following setting is used in `Info.plist`:
```xml
<key>LSUIElement</key>
<true/>
```
This prevents the app from appearing in the Dock or App Switcher (Cmd + Tab).

## Contributing
Contributions are welcome! Feel free to submit a pull request with improvements or bug fixes.

## License
MIT License. See `LICENSE` for more details.

## Author
Developed by Vlad Bacila

