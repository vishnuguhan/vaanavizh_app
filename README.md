# VaanAvizh App

A Flutter game built with the Flame game engine featuring Tamil poems (VaanAvizh).

## About the Game

This is an interactive game where players control a character that moves around collecting Tamil poem words. The game uses the Flame game engine for smooth animations and collision detection.

### Features

- **Interactive Gameplay**: Tap anywhere on the screen to move your character
- **Collectibles**: Collect 5 Tamil poem words scattered across the game world
- **Beautiful UI**: Night sky-themed background with stars and gradient effects
- **Score Tracking**: Track your progress as you collect poems
- **Smooth Animations**: Built with Flame engine for optimal performance

### Game Components

1. **Player**: A blue animated character that responds to touch input
2. **Poem Collectibles**: Star-shaped collectibles with Tamil text
3. **Background**: Animated starry night sky with game title and instructions
4. **Collision Detection**: Automatic collection when player touches poems

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / Xcode for mobile development

### Installation

1. Clone the repository:
```bash
git clone https://github.com/vishnuguhan/vaanavizh_app.git
cd vaanavizh_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Building for Production

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

**Web:**
```bash
flutter build web
```

## Project Structure

```
lib/
├── main.dart                          # App entry point
├── game/
│   └── vaanavizh_game.dart           # Main game logic
└── components/
    ├── player.dart                    # Player component
    ├── poem_collectible.dart          # Collectible poems
    └── background.dart                # Game background
```

## Technologies Used

- **Flutter**: UI framework for cross-platform development
- **Flame**: 2D game engine for Flutter
- **Dart**: Programming language

## How to Play

1. Launch the game
2. Tap anywhere on the screen to move your character
3. Collect all 5 Tamil poem words by moving into them
4. Track your progress at the bottom of the screen
5. Collect all poems to win!

## Tamil Poem Words

The game features these Tamil words from VaanAvizh poems:
- வானம் (Vaanam - Sky)
- அவிழ் (Avizh - Bloom)
- கவிதை (Kavithai - Poetry)
- இசை (Isai - Music)
- நிலவு (Nilavu - Moon)

## Development

This project uses:
- Flame engine version: 1.18.0
- Flutter SDK: 3.0.0+
- Material Design 3

## License

This project is open source and available under the MIT License.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
