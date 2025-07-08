# ProdActivity Garmin App

A productivity timer app for Garmin Connect IQ devices.

## Inspiration
I built this app to help myself stay focused during work sessions — especially when balancing screen time with physical movement. I liked the idea of a Pomodoro-style timer on my watch, but with a twist: alternating between focused work, light activity, and quiet rest to encourage both mental clarity and physical reset.

This project also served as a way to explore Monkey C and the Garmin Connect IQ SDK. I wanted a hands-on experience building something from scratch, rather than following a tutorial. It was a chance to learn how to manage view transitions, timers, and button input, while also designing for devices with limited UI capabilities and varying screen sizes.

I designed the initial layout in Figma before coding to visualize the flow and ensure a clean, user-friendly interface across screens.
![UI Sketch](resources/ProdActivity.png)
[Figma Project](https://www.figma.com/design/s1s3FtbuyGUism4TGBdWSz/ProdActivity?node-id=0-1&m=dev&t=rTEZnanWa2IXcoxC-1)

## Compatibility & Supported Devices

- Designed and tested primarily on Garmin fenix 8 (47mm).
- Targets Connect IQ API version 5.1.1 and above.
- Some UI elements use hardcoded positioning. This approach is recognized as suboptimal and can be enhanced by adopting relative layout techniques (e.g., percentages of screen dimensions) to improve device compatibility.
- Assumes presence of physical buttons (Up, Down, Back, Enter); touchscreen-only and buttonless devices not fully supported.

## Installation

- Build using the Garmin Connect IQ SDK (version 5.1.1 or later).
- Deploy to device via Garmin Express or simulator.
- Compatible with fenix 8.

## Controls

- Use Up/Down buttons to adjust session length.
- Press Enter to confirm selection.
- Use Back button to cancel or go back.
- Use Back and Enter to pause/resume Timers.
- Use Down during Timer phases to set remaining Time = 5 seconds. (Helps with debugging and Testing!)

## Features

- **Loading Screen:**  
  Custom loading view with centered title and background.

- **Session Duration Selection:**  
  Interactive screen to set your session length using a slider, with min/max labels and real-time updates.

- **Custom Length Timers:**
  Allows users to define personalized durations for Focus, Active, Rest, and Interval phases tailored to their study or work routines.

- **Transitions:**  
  Smooth transitions between loading and main setup screens.

- **Consistent UI:**  
  Shared background drawing for a unified look across all screens.

- **Button Navigation:**  
  Use device buttons to adjust session length and confirm your choice.

## File Structure

- `source/ProdActivityApp.mc` - Main application logic.
- `source/delegates/NullDelegate.mc` - Null delegate placeholder.
- `source/delegates/SessionLengthDelegate.mc` - Handles input for session length view.
- `source/delegates/SummaryDelegate.mc` - Handles input for summary view.
- `source/delegates/TimerDelegate.mc` - Handles input for timer view.
- `source/utils/BackgroundUtils.mc` - Shared background drawing utilities.
- `source/utils/DurationLimits.mc` - Duration limit constants.
- `source/utils/DurationType.mc` - Duration type constants.
- `source/utils/SessionFlow.mc` - Defines the session flow logic.
- `source/utils/TimerFlow.mc` - Defines the timer flow logic.
- `source/views/LoadingView.mc` - Loading screen view.
- `source/views/SessionLengthView.mc` - Session duration selection view.
- `source/views/SummaryView.mc` - Summary screen view.
- `source/views/TimerView.mc` - Timer countdown and phase view.

## Reflection
This project helped me strengthen my object-oriented programming skills by working extensively with Views and Delegates in the Garmin Connect IQ framework. I gained hands-on experience with Toybox.WatchUi and Toybox.Graphics, learning how to structure watch applications, design user interfaces, manage layouts, and write clean, reusable functions.

Along the way, I improved my debugging skills and developed a better understanding of UI constraints on wearable devices, especially regarding screen size and input methods. Overall, it was a valuable deep dive into wearable app development and system design.

## Next Steps
Planned enhancements for the app include:
- Implementing touch controls to support touchscreen devices alongside button input.
- Refining visual styling for a cleaner, more consistent user interface.
- Replacing hardcoded UI element positioning with relative layouts to ensure compatibility across various Garmin devices.
- Adding average heart rate tracking during Focus, Active, and Rest phases to provide users with meaningful health insights.
- Introducing vibration notifications to accommodate users with hearing impairments or those who prefer silent alerts.
- These improvements aim to increase usability, accessibility, and device compatibility, making the app more versatile and user-friendly.
