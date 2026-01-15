# Contributing to Student Notes

Terima kasih atas minat Anda untuk berkontribusi pada Student Notes! 🎉

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Coding Guidelines](#coding-guidelines)
- [Commit Guidelines](#commit-guidelines)
- [Pull Request Process](#pull-request-process)
- [Reporting Bugs](#reporting-bugs)
- [Suggesting Features](#suggesting-features)

---

## 📜 Code of Conduct

### Our Pledge

We are committed to providing a welcoming and inspiring community for all.

### Our Standards

**Positive behavior includes:**
- Using welcoming and inclusive language
- Being respectful of differing viewpoints
- Gracefully accepting constructive criticism
- Focusing on what is best for the community
- Showing empathy towards other community members

**Unacceptable behavior includes:**
- Trolling, insulting/derogatory comments, and personal attacks
- Public or private harassment
- Publishing others' private information without permission
- Other conduct which could reasonably be considered inappropriate

---

## 🤝 How Can I Contribute?

### 1. Reporting Bugs

Before creating bug reports, please check existing issues. When creating a bug report, include:

- **Clear title** - Descriptive and specific
- **Steps to reproduce** - Detailed steps
- **Expected behavior** - What should happen
- **Actual behavior** - What actually happens
- **Screenshots** - If applicable
- **Environment** - Device, OS, app version

**Example:**
```markdown
**Title:** App crashes when deleting note with special characters

**Steps to Reproduce:**
1. Create a note with emoji in title
2. Try to delete the note
3. App crashes

**Expected:** Note should be deleted
**Actual:** App crashes with error

**Environment:**
- Device: Samsung Galaxy S21
- Android: 12
- App Version: 1.0.0
```

### 2. Suggesting Features

Feature suggestions are welcome! Please include:

- **Clear description** - What feature you want
- **Use case** - Why it's needed
- **Mockups** - If applicable
- **Implementation ideas** - If you have any

**Example:**
```markdown
**Feature:** Export notes to PDF

**Use Case:** Students want to print their notes or share them as PDF files.

**Implementation Ideas:**
- Add "Export" button in note detail screen
- Use pdf package to generate PDF
- Include note title, course, content, and timestamp
```

### 3. Code Contributions

We love code contributions! Here's how:

1. **Fork the repository**
2. **Create a feature branch**
3. **Make your changes**
4. **Test thoroughly**
5. **Submit a pull request**

---

## 🛠️ Development Setup

### Prerequisites

- Flutter SDK 3.9.2 or higher
- Dart SDK 3.9.2 or higher
- Android Studio / VS Code
- Git

### Setup Steps

1. **Fork and Clone**
```bash
git clone https://github.com/YOUR_USERNAME/student_notes.git
cd student_notes
```

2. **Install Dependencies**
```bash
flutter pub get
```

3. **Run the App**
```bash
flutter run
```

4. **Create Feature Branch**
```bash
git checkout -b feature/your-feature-name
```

### Project Structure

```
lib/
├── main.dart              # Entry point
├── models/                # Data models
├── database/              # Database layer
├── providers/             # State management
├── screens/               # UI screens
├── widgets/               # Reusable widgets
└── utils/                 # Utilities
```

---

## 📝 Coding Guidelines

### Dart Style Guide

Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style).

### Key Points

1. **Naming Conventions**
```dart
// Classes: PascalCase
class NoteProvider { }

// Variables & Functions: camelCase
String userName;
void loadNotes() { }

// Constants: camelCase with const
const String appName = 'Student Notes';

// Private: prefix with _
String _privateVariable;
```

2. **File Naming**
```
// Use snake_case for file names
note_provider.dart
home_screen.dart
custom_appbar.dart
```

3. **Code Organization**
```dart
// Order: imports, class, constructor, properties, methods
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  // Constructor
  const MyWidget({super.key});
  
  // Properties
  final String title;
  
  // Methods
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

4. **Comments**
```dart
// Use /// for documentation comments
/// Creates a new note in the database.
/// 
/// Returns the created [Note] object.
Future<Note> createNote(Note note) async {
  // Implementation
}

// Use // for inline comments
// TODO: Add validation
// FIXME: Handle edge case
```

5. **Error Handling**
```dart
// Always use try-catch for async operations
try {
  await database.insert(note);
} catch (e) {
  debugPrint('Error: $e');
  rethrow; // or handle appropriately
}
```

6. **Null Safety**
```dart
// Use null-aware operators
String? nullableString;
String nonNullable = nullableString ?? 'default';

// Use late for late initialization
late String lateString;

// Use ! only when absolutely sure
String definitelyNotNull = nullableString!;
```

### Flutter Best Practices

1. **Use const constructors**
```dart
const Text('Hello'); // Good
Text('Hello');       // Avoid if possible
```

2. **Extract widgets**
```dart
// Instead of nested widgets, extract to methods or classes
Widget _buildHeader() {
  return Container(...);
}
```

3. **Use Provider properly**
```dart
// For reading without listening
final provider = Provider.of<NoteProvider>(context, listen: false);

// For listening to changes
Consumer<NoteProvider>(
  builder: (context, provider, child) {
    return Text(provider.notes.length.toString());
  },
)
```

4. **Dispose resources**
```dart
@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
```

---

## 💬 Commit Guidelines

### Commit Message Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation changes
- **style**: Code style changes (formatting, etc.)
- **refactor**: Code refactoring
- **test**: Adding or updating tests
- **chore**: Maintenance tasks

### Examples

```bash
# Good commits
feat(notes): add export to PDF functionality
fix(search): resolve crash when searching special characters
docs(readme): update installation instructions
style(home): improve card layout spacing
refactor(database): optimize query performance
test(notes): add unit tests for CRUD operations
chore(deps): update dependencies to latest versions

# Bad commits
update stuff
fix bug
changes
wip
```

### Commit Message Rules

1. Use imperative mood ("add" not "added")
2. Don't capitalize first letter
3. No period at the end
4. Keep subject line under 50 characters
5. Separate subject from body with blank line
6. Wrap body at 72 characters
7. Explain what and why, not how

---

## 🔄 Pull Request Process

### Before Submitting

1. **Update your fork**
```bash
git fetch upstream
git merge upstream/main
```

2. **Run tests**
```bash
flutter test
```

3. **Check code quality**
```bash
flutter analyze
```

4. **Format code**
```bash
flutter format .
```

### PR Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Tested on Android
- [ ] Tested on iOS
- [ ] Added unit tests
- [ ] Added widget tests

## Screenshots (if applicable)
Add screenshots here

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex code
- [ ] Documentation updated
- [ ] No new warnings
- [ ] Tests pass
```

### PR Review Process

1. **Automated checks** - Must pass
2. **Code review** - At least 1 approval
3. **Testing** - Verify functionality
4. **Merge** - Squash and merge

### After PR is Merged

1. Delete your feature branch
2. Update your local main branch
3. Celebrate! 🎉

---

## 🐛 Reporting Bugs

### Bug Report Template

```markdown
**Bug Description**
A clear description of the bug

**To Reproduce**
Steps to reproduce:
1. Go to '...'
2. Click on '...'
3. Scroll down to '...'
4. See error

**Expected Behavior**
What you expected to happen

**Actual Behavior**
What actually happened

**Screenshots**
If applicable, add screenshots

**Environment**
- Device: [e.g., Samsung Galaxy S21]
- OS: [e.g., Android 12]
- App Version: [e.g., 1.0.0]
- Flutter Version: [e.g., 3.9.2]

**Additional Context**
Any other relevant information

**Possible Solution**
If you have ideas on how to fix
```

---

## 💡 Suggesting Features

### Feature Request Template

```markdown
**Feature Title**
Clear, concise title

**Problem Statement**
What problem does this solve?

**Proposed Solution**
How should it work?

**Alternatives Considered**
Other solutions you've thought about

**Additional Context**
Mockups, examples, references

**Priority**
- [ ] High
- [ ] Medium
- [ ] Low
```

---

## 🎯 Areas for Contribution

### High Priority

- [ ] Unit tests for models
- [ ] Widget tests for screens
- [ ] Integration tests
- [ ] Real Firebase integration
- [ ] Rich text editor
- [ ] Export to PDF

### Medium Priority

- [ ] Image attachments
- [ ] Voice notes
- [ ] Reminder notifications
- [ ] Cloud sync
- [ ] Collaboration features

### Low Priority

- [ ] Themes customization
- [ ] Font size options
- [ ] Backup/restore
- [ ] Analytics

### Documentation

- [ ] API documentation improvements
- [ ] Tutorial videos
- [ ] Code examples
- [ ] Translations

---

## 🌍 Internationalization

We welcome translations! To add a new language:

1. Create `lib/l10n/intl_<language_code>.arb`
2. Translate all strings
3. Update `l10n.yaml`
4. Test thoroughly
5. Submit PR

---

## 📚 Resources

### Learning Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Provider Package](https://pub.dev/packages/provider)
- [SQLite in Flutter](https://docs.flutter.dev/cookbook/persistence/sqlite)

### Community

- [Flutter Community](https://flutter.dev/community)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)
- [Flutter Discord](https://discord.gg/flutter)

---

## ❓ Questions?

If you have questions:

1. Check existing documentation
2. Search closed issues
3. Ask in discussions
4. Create a new issue

---

## 🙏 Thank You!

Thank you for contributing to Student Notes! Every contribution, no matter how small, is valuable and appreciated.

**Happy Coding! 🚀**

---

**Maintainers:**
- [Your Name] - Project Lead

**Contributors:**
- See [CONTRIBUTORS.md](CONTRIBUTORS.md) for full list

---

*Last Updated: January 15, 2026*
