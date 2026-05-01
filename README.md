# Random Color Generator

A simple Flutter application that changes the background color on every tap and tracks the color history.

## Features
* Generates random color from a pool of 16.7 million colors using system entropy (microseconds) and `List.shuffle` instead of the `dart:math` library.
* A list at the bottom tracks all previously generated colors.
* The history list automatically scrolls to the newest color whenever a change occurs.
* The "Hello there" text and history borders dynamically switch between black and white based on the background's luminance to ensure readability.
