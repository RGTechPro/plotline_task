# Plotline Tooltip API


‼️ The notification bar is considered a part of screen height in implementation

# Demo
## Install the apk

https://drive.google.com/file/d/1rJd3a7CWa-BaO22nrtV3ZiNvR8PEGN56/view?usp=sharing

# Generic

Tooltips provide text labels and the option to add images using an image picker, which helps explain the function of a button or other user interface action. You can wrap the button in a Tooltip widget, provide a message, and use an image picker to select or capture an image.

## TooltipProperties (Model)

### isHidden: `bool`

`required`

A boolean value that determines whether the tooltip is hidden (true) or visible (false).

### targetElement: `String`

`required`

A string that identifies the target UI element or button to which the tooltip is associated.

### tooltipText: `String`

`required`

A string that represents the text to be displayed within the tooltip.

### textSize: `Size`

`required`

A double value indicating the font size for the text inside the tooltip.

### padding: `double`

`required`

A double value specifying the padding (space) around the content inside the tooltip.

### textColor: `Color`

`required`

A Color object representing the text color for the tooltip content.

### backgroundColor: `Color`

`required`

A Color object defining the background color of the tooltip.

### cornerRadius: `double`

`required`

A double value representing the corner radius of the tooltip, which affects the appearance of the tooltip's edges.

### tooltipWidth: `double`

`required`

A double value indicating the width of the tooltip.

### arrowWidth: `double`

`required`

A double value specifying the width of the tooltip's arrow.

### arrowHeight: `double`

`required`

A double value representing the height of the tooltip's arrow.

### tooltipPosition: `TooltipPosition`

`required`

An instance of the TooltipPosition enum, indicating the position of the tooltip relative to the target element (e.g., top, bottom, left, right).

### image: `Uint8List`

A Uint8List that can hold an image for the tooltip. If no image is provided, it can be null.

### tooltipHeight: `double`

A double value that defines the height of the tooltip (unused in the code).

### aspectRatio: `double`

A double value specifying the aspect ratio of the tooltip (aspect ratio = width / height).

## MyTooltip properties

## child: `Widget`

`required`

The child which will act as the target element can be any widget that you want to associate with the tooltip.

## tooltipProperty: `TooltipProperties`

`required` 

The `tooltipProperty` parameter of the `MyTooltip` widget is responsible for determining the appearance, position, and other properties of the tooltip.

## Methods

# Usage

## Imports needed

```dart
import 'package:plotline_task/src/models/tooltip_model.dart';
import 'package:plotline_task/src/services/tooltip/my_tooltip.dart';
```

## Basic Usage

The below code block demonstrates the usage of the `MyTooltip` widget in Flutter. Here's a breakdown of the code:

Inside the `body` of the `Scaffold`, use the `MyToolTip` widget:

```dart
MyToolTip(
  tooltipProperty: TooltipProperties(
    // Define your tooltip properties here
    isHidden: false,
    targetElement: 'My Button',
    tooltipText: 'This is a button.',
    // Customize other properties like colors, size, etc.
  ),
  child: ElevatedButton(
    onPressed: () {
      // Button action here
    },
    child: Text('My Button'),
  ),
),

```

- Replace `tooltipProperty` with an instance of the `TooltipProperties` class, where you can define the properties of the tooltip, such as visibility (`isHidden`), target element (`targetElement`), tooltip text (`tooltipText`), and more.
- The `child` property of `MyTooltip` is used to specify the widget that will act as the target element for the tooltip. In this example, an `ElevatedButton` is used as the target element.

This code demonstrates a basic usage of the `MyTooltip` widget, allowing you to add tooltips to your Flutter UI elements and customize their appearance and behavior.

# Working Explained

![Screenshot 2023-10-11 at 11.35.23 PM.png](https://i.ibb.co/drhfyXn/Screenshot-2023-10-11-at-11-35-23-PM.png)

Here is a step-by-step explanation of the code image:

1. The `dispose()` function is called when the widget is disposed. It removes the overlay when the widget is disposed.
2. The `initiateOverlay()` function is called to show the overlay. It adds a post-frame callback to show the overlay after the frame is rendered.
3. The `showOverlay()` function is called to display the tooltip overlay. It gets the overlay state from the current context, calculates the position and size of the tooltip, and creates an overlay entry to display the tooltip.
4. The `setRelativePositionToTop()`, `setRelativePositionToLeft()`, `setRelativePositionToRight()`, and `setRelativePositionToBottom()` functions are used to set the relative position of the tooltip based on the tooltip position specified in the `widget.tooltipProperty`.
5. The `readjust()` function is called to readjust the position of the tooltip if it overflows from the screen boundary. It calculates the new position of the tooltip based on the screen dimensions and the tooltip size.
6. The `readjustTop()`, `readjustLeft()`, `readjustRight()`, `readjustBottom()`, and `readjustAuto()` functions handle different scenarios for readjusting the tooltip position based on its overflow.
7. The `buildOverlay()` function builds the tooltip overlay content. It creates a material container with the specified tooltip text, background color, and text color. It also includes an optional image if provided.
8. The `removeOverlay()` function is called to remove the overlay when it is no longer needed.
9. The `TooltipBox` widget is a stateful widget that handles the readjustment of the tooltip position and renders the tooltip content.
10. The `_TooltipBoxState` class manages the state of the `TooltipBox` widget and triggers the readjustment of the tooltip position after the frame is rendered.

This code is responsible for creating and displaying tooltip overlays with customisable positions, styles, and content

# Whimsical Flowchart
## [https://whimsical.com/HAcTMqaraEf9LabFvRBEFd](https://whimsical.com/HAcTMqaraEf9LabFvRBEFd)

<p float="left" align="center" margin="50px">

<img src='https://i.ibb.co/QkxY29h/Screenshot-1697049434.png' width=300 height=550>

<img src='https://i.ibb.co/9H5Hb8T/Screenshot-1697049429.png' width=300 height=550>

# On clicking the tooltip it will disappear

<img src='https://i.ibb.co/3knwgtS/ezgif-com-video-to-gif.gif' width=300 height=550>




# Handling edge cases

![Automatic position change if space not available.jpg](https://i.ibb.co/PYdPsKk/Automatic-position-change-if-space-not-available.jpg)

# File Structure

![Screenshot 2023-10-11 at 11.58.13 PM.png](https://i.ibb.co/ZTb7kvP/Screenshot-2023-10-11-at-11-58-13-PM.png)

#