<!-- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

# Copilot Instructions for gracetopdf

This is a shell script project for converting Grace plot files to PDF format. When working on this project, please follow these guidelines:

## Project Context
- This is a POSIX-compliant shell script that converts Grace (.agr) files to PDF
- The script uses `gracebat` (Grace batch mode) and `ps2pdf` (Ghostscript) for conversion
- Target platforms: Linux, macOS, and other Unix-like systems
- The project follows standard Unix conventions for command-line tools

## Code Style Guidelines
- Use POSIX-compliant shell syntax (#!/bin/bash but avoid Bash-specific features where possible)
- Follow defensive programming practices with `set -euo pipefail`
- Use meaningful variable names in UPPER_CASE for constants and lower_case for local variables
- Include comprehensive error handling and user feedback
- Maintain consistent indentation (4 spaces)
- Add descriptive comments for complex logic

## Documentation Standards
- Keep the man page (gracetopdf.1) in sync with script functionality
- Use proper troff formatting for the man page
- Update README.md when adding new features or changing usage
- Include examples in both man page and README
- Document all command-line options and their effects

## Testing Considerations
- Test on multiple shell environments (bash, dash, zsh)
- Verify compatibility with different versions of Grace and Ghostscript
- Test error conditions and edge cases
- Ensure proper cleanup of temporary files in all scenarios

## Installation and Packaging
- Follow FHS (Filesystem Hierarchy Standard) conventions
- Support both system-wide and user-local installations
- Use standard Makefile targets (install, uninstall, check, test)
- Ensure the script works from any working directory

## Dependencies
- External dependencies: grace (xmgrace), ghostscript
- Avoid adding unnecessary dependencies
- Check for required commands at runtime
- Provide helpful error messages for missing dependencies

## Security Considerations
- Validate all user inputs
- Use secure temporary file creation
- Avoid shell injection vulnerabilities
- Don't trust file extensions or names blindly

When suggesting code changes, prioritize:
1. Maintainability and readability
2. POSIX compliance and portability
3. Robust error handling
4. User experience and helpful feedback
5. Security best practices
