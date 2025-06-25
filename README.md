# gracetopdf

A command-line utility to convert Grace plot files (.agr) to PDF format.

**Available as both `gracetopdf` and `xmgracetopdf` commands.**

## Description

`gracetopdf` is a shell script that provides a simple and efficient way to convert Grace (xmgrace) plot files to PDF format. Grace is a WYSIWYG 2D plotting tool, and this utility makes it easy to convert your plots to PDF for publication, sharing, or archival purposes.

The conversion process uses Grace's batch mode to generate high-quality EPS (Encapsulated PostScript) output, which is then converted to PDF using epstopdf, ensuring professional-quality results with correct orientation and proper page dimensions.

## Features

- Simple command-line interface
- Batch conversion of Grace files to PDF
- Configurable output resolution (DPI)
- Verbose mode for detailed operation feedback
- Automatic cleanup of temporary files
- Comprehensive error handling
- Man page documentation
- **Bash and Zsh autocompletion support** for commands, options, and files
- **Correct orientation and page size handling** via EPS intermediate format and epstopdf

## Installation

### Prerequisites

Before installing `gracetopdf`, ensure you have the following dependencies:

- **Grace (xmgrace)** - The Grace plotting tool
  ```bash
  # Ubuntu/Debian
  sudo apt-get install grace
  
  # CentOS/RHEL/Fedora
  sudo yum install grace  # or dnf install grace
  
  # macOS (with Homebrew)
  brew install grace
  ```

- **epstopdf** - For EPS to PDF conversion (part of TeX Live)
  ```bash
  # Ubuntu/Debian
  sudo apt-get install texlive-font-utils
  
  # CentOS/RHEL/Fedora
  sudo yum install texlive-epstopdf  # or dnf install texlive-epstopdf
  
  # macOS (with Homebrew)
  brew install --cask mactex
  # or for minimal installation:
  brew install texlive
  ```

### Installation Methods

#### Option 1: User Installation (Recommended)

Install to your user directory without requiring root privileges:

```bash
make install-user
```

This installs the script to `~/.local/bin/` and the man page to `~/.local/share/man/man1/`. Make sure `~/.local/bin` is in your PATH:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

**To enable bash autocompletion**, add this line to your `~/.bashrc`:

```bash
echo 'source ~/.local/share/bash-completion/completions/gracetopdf' >> ~/.bashrc
source ~/.bashrc
```

**For zsh users**, add the completion directory to your fpath in `~/.zshrc`:

```bash
echo 'fpath=(~/.local/share/zsh/site-functions $fpath)' >> ~/.zshrc
echo 'autoload -U compinit && compinit' >> ~/.zshrc
source ~/.zshrc
```

#### Option 2: System-wide Installation

Install system-wide (requires root privileges):

```bash
sudo make install
```

This installs to `/usr/local/bin/` and `/usr/local/share/man/man1/`. Both bash and zsh completion will be available system-wide after restarting your shell. 

**Note**: The installation also creates a symbolic link `xmgracetopdf` that points to `gracetopdf`, so you can use either command name.

#### Option 3: Custom Installation Directory

Install to a custom directory:

```bash
sudo make PREFIX=/opt install
```

### Verify Installation

After installation, verify everything works:

```bash
# Check if the script is accessible
gracetopdf --version

# Or use the alias
xmgracetopdf --version

# Check if the man page is available
man gracetopdf

# Or use the alias
man xmgracetopdf

# Check dependencies
make check-deps
```

## Autocompletion

`gracetopdf` includes bash and zsh autocompletion support that makes it easier to use the command. The completion provides:

- **Command options**: `--help`, `--verbose`, `--dpi`, `--version`, `-h`, `-v`, `-d`
- **DPI values**: Common values like 72, 96, 150, 300, 600, 1200
- **File completion**: 
  - `.agr` files for input
  - `.pdf` files for output
  - Directory navigation

### Manual Completion Testing

If you want to test the completion before installing:

```bash
# Source the completion script
source bash_completion/gracetopdf

# Test completion (press TAB after typing):
gracetopdf --<TAB>          # Shows all options
gracetopdf --dpi <TAB>      # Shows common DPI values  
gracetopdf <TAB>            # Shows .agr files
gracetopdf plot.agr <TAB>   # Shows .pdf files for output

# The alias also works with completion:
xmgracetopdf --<TAB>        # Same completion features
```

## Usage

### Command Aliases

The installation creates both `gracetopdf` and `xmgracetopdf` commands. Both are identical and can be used interchangeably:

```bash
gracetopdf plot.agr      # Main command
xmgracetopdf plot.agr    # Alias (same functionality)
```

The `xmgracetopdf` alias makes it clear that this tool is related to xmgrace/Grace.

### Basic Usage

```bash
# Convert a Grace file to PDF (output: plot.pdf)
gracetopdf plot.agr
# or
xmgracetopdf plot.agr

# Convert with a specific output filename
gracetopdf plot.agr output.pdf
```

### Advanced Usage

```bash
# Convert with high resolution
gracetopdf --dpi 600 plot.agr

# Convert with verbose output
gracetopdf --verbose plot.agr

# Combine options
gracetopdf --dpi 600 --verbose plot.agr high_res_plot.pdf
```

### Command-line Options

- `-h, --help` - Show help message
- `-v, --verbose` - Enable verbose output
- `-d, --dpi DPI` - Set output DPI (default: 300)
- `--version` - Show version information

## Examples

1. **Basic conversion:**
   ```bash
   gracetopdf experiment_data.agr
   ```

2. **High-quality output for publication:**
   ```bash
   gracetopdf --dpi 600 --verbose publication_figure.agr figure1.pdf
   ```

3. **Batch processing multiple files:**
   ```bash
   for file in *.agr; do
       gracetopdf "$file"
   done
   ```

## Development

### Testing

Run basic functionality tests:

```bash
make test
```

Check script syntax:

```bash
make check
```

Check runtime dependencies:

```bash
make check-deps
```

### Project Structure

```
gracetopdf/
├── gracetopdf                    # Main shell script
├── gracetopdf.1                  # Man page source
├── Makefile                      # Installation and build system
├── README.md                     # This file
├── LICENSE                       # MIT license
├── sample.agr                    # Sample Grace file for testing
├── test_completion.sh            # Completion testing script
├── bash_completion/
│   └── gracetopdf               # Bash completion script
└── zsh_completion/
    └── _gracetopdf              # Zsh completion script
```

## Uninstallation

### Remove User Installation

```bash
make uninstall-user
```

### Remove System Installation

```bash
sudo make uninstall
```

## Troubleshooting

### Common Issues

1. **"gracebat: command not found"**
   - Install the Grace package for your system
   - Check that `gracebat` is in your PATH

2. **"epstopdf: command not found"**
   - Install TeX Live font utilities for your system
   - Check that `epstopdf` is in your PATH

3. **Permission denied**
   - Ensure the script has execute permissions: `chmod +x gracetopdf`
   - For system installation, use `sudo`

4. **"Input file does not exist"**
   - Check the file path and ensure the Grace file exists
   - Verify you have read permissions for the file

5. **Output PDF has wrong orientation or rotation**
   - This issue has been resolved by using EPS as intermediate format with epstopdf
   - The script automatically uses the optimal conversion path via EPS→PDF

6. **Output PDF appears cropped or has wrong page size**
   - Now resolved by using epstopdf which properly handles EPS bounding boxes
   - epstopdf automatically determines the correct page size from EPS

### Getting Help

- Use `gracetopdf --help` for usage information
- Read the man page with `man gracetopdf`
- Check dependencies with `make check-deps`

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Contributing

Contributions are welcome! Please feel free to submit issues, feature requests, or pull requests.

## Author

Created by Alessandro Grassi.

## See Also

- [Grace Official Website](http://plasma-gate.weizmann.ac.il/Grace/)
- [TeX Live Documentation](https://www.tug.org/texlive/)
- `man grace`, `man gracebat`, `man epstopdf`
