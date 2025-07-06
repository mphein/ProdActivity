# ProdActivity Garmin App

A productivity timer app for Garmin Connect IQ devices.

## Features

- **Loading Screen:**  
  Custom loading view with centered title and background.

- **Session Duration Selection:**  
  Interactive screen to set your session length using a slider, with min/max labels and real-time updates.

- **Transitions:**  
  Smooth transitions between loading and main setup screens.

- **Consistent UI:**  
  Shared background drawing for a unified look across all screens.

- **Button Navigation:**  
  Use device buttons to adjust session length and confirm your choice.

## File Structure

- `source/ProdActivityApp.mc` - Main application logic.
- `source/LoadingView.mc` - Loading screen view.
- `source/SessionLengthView.mc` - Session duration selection view.
- `source/SessionLengthDelegate.mc` - Handles input for session length view.
- `source/BackgroundUtils.mc` - Shared background drawing utilities.

## Future Additions
I would like to add/change:
  - Touch Controls
  - Refine Styling
  - Change hardcoded positioning of UI Elements
    - May not work on other watches
  