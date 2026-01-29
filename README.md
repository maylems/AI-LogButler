# AI LogButler

AI LogButler is a mobile application that transforms the way developers handle log analysis. Instead of spending hours deciphering cryptic error messages, you can now get instant, intelligent analysis powered by Google's Gemini AI. The app speaks your language - literally - with support for English, French, Chinese, and Arabic.

![Screenshot](https://github.com/user-attachments/assets/664640cc-37a8-4a0e-ab81-5b2773847388)

## What It Does

AI LogButler takes your raw log files and turns them into actionable insights. Whether you're debugging a JavaScript application, troubleshooting a Python server, or analyzing system logs, the app identifies problems, explains what went wrong, and tells you exactly how to fix it.

### Key Features

**Smart Analysis**
- Understands logs from 15+ different sources including JavaScript, Python, Java, Docker, Nginx, and system logs
- Provides structured analysis with problem identification, root causes, and step-by-step solutions
- Includes relevant code examples when they help explain the solution
- Categorizes issues by severity so you know what needs immediate attention

**Multi-Language Support**
- Full interface translation in English, French, Chinese, and Arabic
- AI analysis results delivered in your preferred language
- Right-to-left text support for Arabic users
- Language preferences are remembered between sessions

**Developer-Friendly Design**
- Clean, distraction-free interface focused on the task at hand
- Line numbers in the editor for easy reference
- One-tap log clearing for quick testing
- Results you can copy and share with your team

## How It Works

The process is straightforward:

1. **Paste Your Log**: Copy any log content into the editor
2. **Choose Your Language**: Pick from English, French, Chinese, or Arabic
3. **Tap Analyze**: The AI processes your log and returns structured results
4. **Get Solutions**: Review the problem, cause, and recommended fix

Behind the scenes, Google's Gemini AI analyzes patterns in your log data, identifies the type of log you're working with, and provides context-aware solutions based on best practices and common debugging scenarios.

## Technical Architecture

### Frontend (Flutter)
Built with Flutter for cross-platform compatibility, the app uses:
- Provider pattern for state management
- Material Design with a dark theme that's easy on the eyes during long debugging sessions
- Custom widgets optimized for log viewing and analysis
- Robust error handling with user-friendly messages

### Backend (Serverpod)
The server handles the heavy lifting:
- RESTful API endpoints with proper validation
- Integration with Google Gemini AI for analysis
- Structured JSON responses with error handling
- Scalable architecture ready for production use

### AI Integration
The magic happens with Google Gemini 2.5-flash-lite:
- Custom prompts engineered for consistent, structured output
- Language-aware analysis that adapts to your preferred language
- Pattern recognition for 15+ log types and programming languages
- JSON validation to ensure reliable data transfer

## Getting Started

### Prerequisites
- Flutter SDK 3.32.0 or higher
- Dart SDK 3.10.7 or higher  
- Google Gemini API key
- Basic familiarity with mobile app development

### Quick Setup

1. **Clone and Install**
   ```bash
   git clone https://github.com/maylems/AI-LogButler.git
   cd AI-LogButler
   ```

2. **Configure the Backend**
   ```bash
   cd ai_logb_server
   cp config/passwords.yaml.example config/passwords.yaml
   # Add your Gemini API key to passwords.yaml
   dart pub get
   ```

3. **Setup the Mobile App**
   ```bash
   cd ../ai_logb_flutter
   flutter pub get
   ```

4. **Start Development**
   ```bash
   # Terminal 1: Start the backend server
   cd ai_logb_server
   dart run bin/main.dart
   
   # Terminal 2: Run the Flutter app
   cd ../ai_logb_flutter
   flutter run
   ```

### Configuration Details

**Backend Setup**
Edit `ai_logb_server/config/passwords.yaml`:
```yaml
geminiApiKey: "your_gemini_api_key_here"
```

Get your API key from [Google AI Studio](https://makersuite.google.com/app/apikey).

**Mobile App Configuration**
If your server runs on a different port or host, update the server URL in `ai_logb_flutter/lib/main.dart`:
```dart
const String serverUrl = 'http://your-server:8080';
```

## Using AI LogButler

### Basic Workflow

1. **Launch the App**: Open AI LogButler on your device
2. **Set Language Preference**: Choose your preferred language on first launch
3. **Input Log Content**: Paste your log into the text editor
4. **Run Analysis**: Tap the analyze button and wait for results
5. **Review Solutions**: Examine the structured analysis and apply the recommended fixes

### Understanding the Results

Each analysis provides:

- **Problem**: A clear description of what went wrong
- **Likely Cause**: Technical explanation of the root cause
- **Recommended Fix**: Step-by-step solution instructions
- **Code Example**: Relevant code snippet when helpful
- **Severity**: ERROR, WARNING, or INFO classification
- **Log Type**: Detected category (JavaScript, Python, System, etc.)

### Supported Log Types

The AI can analyze logs from various environments:

**Programming Languages**
- JavaScript: Browser errors, Node.js issues, TypeScript problems
- Python: Tracebacks, import errors, Django/Flask application logs
- Java: JVM errors, Spring Boot logs, exception stack traces
- C#: .NET exceptions, ASP.NET Core logs, Entity Framework errors
- Go: Panic messages, goroutine issues, package-level problems
- Rust: Panic messages, Result type errors, Cargo build issues
- SQL: Database errors, query problems, connection issues

**Infrastructure & Tools**
- Docker: Container errors, build failures, runtime issues
- Bash: Shell script errors, command failures, exit codes
- Nginx: Web server errors, access log analysis, configuration issues
- Apache: HTTP server errors, virtual host problems, module issues

**System & Application**
- System: OS logs, kernel messages, service failures
- Application: Custom application logs, microservice errors
- Database: Connection errors, query failures, transaction issues
- Network: Protocol errors, connection timeouts, packet analysis

## Development Guide

### Project Structure
```
AI-LogButler/
├── ai_logb_flutter/          # Mobile application
│   ├── lib/
│   │   ├── main.dart         # App entry point
│   │   ├── notifiers/        # State management
│   │   ├── pages/           # Application screens
│   │   ├── widgets/         # Reusable UI components
│   │   ├── providers/       # Data management
│   │   └── localizations/   # Multi-language support
│   └── pubspec.yaml        # Flutter dependencies
├── ai_logb_server/          # Backend server
│   ├── lib/
│   │   ├── src/
│   │   │   ├── logs/       # Analysis endpoints
│   │   │   ├── model/      # Data models
│   │   │   └── generated/  # Auto-generated code
│   │   └── server.dart     # Server configuration
│   ├── config/             # Server settings
│   └── pubspec.yaml        # Server dependencies
└── ai_logb_client/         # Shared protocol code
    └── lib/
        └── protocol/       # Client-server communication
```

### Key Components

**Mobile App Components**
- `LogAnalysisNotifier`: Manages analysis state and API communication
- `LanguageProvider`: Handles language preferences and localization
- `LogEditor`: Text input widget with line numbers and formatting
- `ResultScreen`: Displays analysis results in a structured format

**Backend Components**
- `LogAnalysisEndpoint`: Main API endpoint for log analysis
- `Gemini Integration`: AI service for intelligent log processing
- `Protocol Serialization`: Type-safe data transfer between client and server

### Adding New Features

**Supporting New Log Types**
Update the AI prompt in `LogAnalysisEndpoint.analyzeLog` to include patterns for the new log type.

**Adding Languages**
1. Add translations in `ai_logb_flutter/lib/localizations/app_localizations.dart`
2. Update the language switch in the AI prompt
3. Test the full analysis flow in the new language

**Custom UI Components**
Create reusable widgets in `ai_logb_flutter/lib/widgets/` following the existing patterns.

### Testing

**Frontend Tests**
```bash
cd ai_logb_flutter
flutter test
```

**Backend Tests**
```bash
cd ai_logb_server
dart test
```

**Manual Testing Checklist**
- Test with each supported log type
- Verify analysis in all supported languages
- Check error handling for invalid inputs
- Test network connectivity issues

## API Documentation

### Analyze Log Endpoint
**Endpoint**: `POST /logAnalysis/analyzeLog`

**Request Body**:
```json
{
  "logContent": "string - Raw log text",
  "language": "string - Language code (en, fr, zh, ar)"
}
```

**Response**:
```json
{
  "problem": "string - Issue description",
  "likelyCause": "string - Root cause explanation", 
  "recommendedFix": "string - Solution steps",
  "codeExample": "string|null - Code snippet if applicable",
  "severity": "string - ERROR|WARNING|INFO",
  "logType": "string - Detected log category",
  "timestamp": "string - ISO 8601 timestamp"
}
```

### Health Check
**Endpoint**: `GET /logAnalysis/test`

**Response**: `"LogAnalysisEndpoint is working!"`

## Troubleshooting

### Common Issues

**Connection Problems**
If you see "Network error" or "Connection timeout":
1. Verify the backend server is running on port 8080
2. Check that your device can reach the server IP
3. Ensure no firewall is blocking the connection
4. Try accessing the server URL in a browser

**API Key Issues**
If analysis fails with "AI analysis failed":
1. Confirm your Gemini API key is valid
2. Check the key has sufficient quota
3. Verify the key is properly set in `passwords.yaml`
4. Test the key in Google's AI Studio

**Analysis Errors**
For "Invalid response" or parsing errors:
1. Ensure the log content contains recognizable patterns
2. Try with a shorter log sample
3. Check if the log type is supported
4. Verify the server has internet connectivity

**Performance Issues**
If analysis is slow or times out:
1. Check your internet connection speed
2. Reduce the log size for testing
3. Monitor your Gemini API usage limits
4. Consider server resources if hosting locally

### Debug Mode

Enable detailed logging by setting:
```bash
export SERVERPOD_LOG_LEVEL=debug
```

This will show detailed request/response information useful for troubleshooting.

## Contributing

We welcome contributions that improve AI LogButler. Here's how to get started:

### Reporting Issues
- Use GitHub Issues for bug reports and feature requests
- Include steps to reproduce any problems
- Provide sample logs when reporting analysis issues
- Specify your device type and app version

### Submitting Changes
1. Fork the repository on GitHub
2. Create a feature branch: `git checkout -b feature/your-feature-name`
3. Make your changes with clear commit messages
4. Test your changes thoroughly
5. Push to your fork: `git push origin feature/your-feature-name`
6. Open a Pull Request with a detailed description

### Code Standards
- Follow Dart and Flutter official style guides
- Write clear, self-documenting code
- Add comments for complex logic
- Include tests for new functionality
- Update documentation as needed

### Development Workflow
1. Set up your development environment as described in Getting Started
2. Create a new branch for your feature
3. Make incremental changes with frequent commits
4. Test both frontend and backend components
5. Ensure all tests pass before submitting

## License

This project is licensed under the MIT License. See the LICENSE file for the full text.

## Support

**Getting Help**
- Create an issue on GitHub for bugs and feature requests
- Check the troubleshooting section above for common problems
- Review the API documentation for integration questions

**Community**
- Star the repository if you find AI LogButler useful
- Share your experiences and log analysis success stories
- Contribute to making log analysis easier for developers everywhere

---

AI LogButler was created to solve a problem every developer faces: making sense of log files. By combining modern mobile development with advanced AI, we've created a tool that saves time, reduces frustration, and helps developers get back to building great software.

Whether you're debugging a production issue at 3 AM or trying to understand why your code isn't working, AI LogButler provides the insights you need, in the language you prefer, with the clarity you deserve.
