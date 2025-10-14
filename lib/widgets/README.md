# Common Widgets Documentation

This directory contains reusable widgets that have been extracted from the app to reduce code duplication and ensure consistent UI patterns across all screens.

## Available Common Widgets

### 1. CommonCardWidget (`common_card_widget.dart`)
Provides consistent card styling with shadows, borders, and padding.

**Usage:**
```dart
CommonCardWidget(
  child: YourContent(),
  padding: EdgeInsets.all(4.w),
  margin: EdgeInsets.symmetric(horizontal: 4.w),
  backgroundColor: Colors.white,
  borderRadius: 12,
  onTap: () => handleTap(),
)
```

**Variants:**
- `CompactCardWidget` - Smaller padding and margins
- `GradientCardWidget` - Card with gradient background

### 2. CommonStatWidget (`common_stat_widget.dart`)
Displays statistics with icons, values, and labels in a consistent format.

**Usage:**
```dart
CommonStatWidget(
  title: "Completion",
  value: "85%",
  icon: Icons.check_circle,
  color: Colors.green,
  onTap: () => handleTap(),
)
```

**Variants:**
- `CompactStatWidget` - Smaller version for tight spaces
- `ProgressSummaryWidget` - Simple title-value pairs

### 3. CommonAvatarWidget (`common_avatar_widget.dart`)
Handles profile images with fallback to text avatars.

**Usage:**
```dart
CommonAvatarWidget(
  imageUrl: "https://example.com/avatar.jpg",
  name: "John Doe",
  size: 60,
  showStatusDot: true,
  statusColor: Colors.green,
)
```

**Variants:**
- `SmallAvatarWidget` - Smaller version (40px default)
- `CircularIconWidget` - Icon in a circular container

### 4. CommonProgressWidget (`common_progress_widget.dart`)
Various progress indicators and charts.

**Usage:**
```dart
CommonProgressBarWidget(
  progress: 0.75,
  label: "Progress",
  value: "75%",
  progressColor: Colors.blue,
)

WeeklyProgressChartWidget(
  weekData: [
    {'day': 'Mon', 'height': 0.8, 'color': Colors.green, 'duration': '32 min'},
    // ... more days
  ],
  onDayTap: (day, duration, color) => showDetails(),
)
```

### 5. CommonButtonWidget (`common_button_widget.dart`)
Consistent button styling across the app.

**Usage:**
```dart
CommonButtonWidget(
  text: "Submit",
  onPressed: () => handleSubmit(),
  icon: Icons.send,
  backgroundColor: AppColor.primaryColor,
  isLoading: false,
)
```

**Variants:**
- `CompactButtonWidget` - Smaller version
- `IconButtonWidget` - Icon-only button
- `FloatingActionButtonWidget` - FAB wrapper

### 6. CommonTabWidget (`common_tab_widget.dart`)
Tab navigation components.

**Usage:**
```dart
CommonTabWidget(
  tabs: ["Tab 1", "Tab 2", "Tab 3"],
  selectedIndex: 0,
  onTabChanged: (index) => setState(() => selectedIndex = index),
)

WeekTabWidget(
  days: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
  selectedDayIndex: 0,
  onDaySelected: (index) => selectDay(index),
)
```

## Refactored Screens

The following screens have been refactored to use these common widgets:

1. **Exercise Screen** (`lib/Modules/exercise/exercise_screen.dart`)
   - Uses `CommonCardWidget` for dashboard and insights cards
   - Uses `CommonStatWidget` for progress statistics
   - Uses `WeeklyProgressChartWidget` for weekly progress
   - Uses `CircularIconWidget` for exercise icons
   - Uses `CompactCardWidget` for exercise items

2. **Doctor Home Screen** (`lib/Modules/doctor_home/doctor_home_screen.dart`)
   - Uses `CommonCardWidget` for hospital and doctor cards

3. **Diet Screen** (`lib/Modules/diet/diet_screen.dart`)
   - Uses `WeekTabWidget` for day selection
   - Uses `CommonCardWidget` for meal cards

## Benefits

1. **Consistency**: All cards, buttons, and UI elements now have consistent styling
2. **Maintainability**: Changes to common widgets automatically apply to all screens
3. **Reduced Code Duplication**: Eliminated repetitive styling code
4. **Reusability**: Easy to use across new screens
5. **Customization**: Each widget accepts parameters for customization while maintaining consistency

## Usage Guidelines

1. Always prefer common widgets over custom implementations
2. Use appropriate variants (Compact, Small, etc.) based on space constraints
3. Pass consistent colors and styling through the widget parameters
4. When creating new screens, check if existing common widgets can be used
5. If a new pattern emerges, consider creating a new common widget

## Future Enhancements

- Add more specialized widgets as patterns emerge
- Create theme-aware variants
- Add animation support to common widgets
- Create documentation with visual examples
