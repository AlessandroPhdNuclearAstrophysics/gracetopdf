# Makefile for gracetopdf
# A shell script to convert Grace plot files to PDF

# Installation directories
PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin
MANDIR = $(PREFIX)/share/man/man1
COMPLETIONDIR = $(PREFIX)/share/bash-completion/completions
ZSHCOMPLETIONDIR = $(PREFIX)/share/zsh/site-functions

# Script and documentation files
SCRIPT = gracetopdf
MANPAGE = gracetopdf.1
COMPLETION = bash_completion/gracetopdf
ZSHCOMPLETION = zsh_completion/_gracetopdf

# Default target
.PHONY: all
all: check

# Check syntax and dependencies
.PHONY: check
check:
	@echo "Checking script syntax..."
	@bash -n $(SCRIPT) && echo "✓ Script syntax is valid"
	@echo "Checking for required commands..."
	@command -v install >/dev/null 2>&1 || { echo "✗ install command not found"; exit 1; }
	@echo "✓ Installation tools available"

# Install the script and man page
.PHONY: install
install: check
	@echo "Installing $(SCRIPT)..."
	install -d $(DESTDIR)$(BINDIR)
	install -m 755 $(SCRIPT) $(DESTDIR)$(BINDIR)/$(SCRIPT)
	@echo "Creating alias xmgracetopdf..."
	ln -sf $(SCRIPT) $(DESTDIR)$(BINDIR)/xmgracetopdf
	@echo "Installing man page..."
	install -d $(DESTDIR)$(MANDIR)
	install -m 644 $(MANPAGE) $(DESTDIR)$(MANDIR)/$(MANPAGE)
	@echo "Creating man page alias..."
	ln -sf $(MANPAGE) $(DESTDIR)$(MANDIR)/xmgracetopdf.1
	@echo "Installing bash completion..."
	install -d $(DESTDIR)$(COMPLETIONDIR)
	install -m 644 $(COMPLETION) $(DESTDIR)$(COMPLETIONDIR)/$(SCRIPT)
	@echo "Installing zsh completion..."
	install -d $(DESTDIR)$(ZSHCOMPLETIONDIR)
	install -m 644 $(ZSHCOMPLETION) $(DESTDIR)$(ZSHCOMPLETIONDIR)/_$(SCRIPT)
	@echo "✓ Installation completed successfully"
	@echo ""
	@echo "The script has been installed to: $(BINDIR)/$(SCRIPT)"
	@echo "Alias created: $(BINDIR)/xmgracetopdf -> $(SCRIPT)"
	@echo "The man page has been installed to: $(MANDIR)/$(MANPAGE)"
	@echo "Bash completion has been installed to: $(COMPLETIONDIR)/$(SCRIPT)"
	@echo "Zsh completion has been installed to: $(ZSHCOMPLETIONDIR)/_$(SCRIPT)"
	@echo ""
	@echo "You can now run 'gracetopdf --help' or 'man gracetopdf' for usage information."
	@echo "Restart your shell or run 'source /etc/bash_completion' to enable autocompletion."

# Uninstall the script and man page
.PHONY: uninstall
uninstall:
	@echo "Uninstalling $(SCRIPT)..."
	rm -f $(DESTDIR)$(BINDIR)/$(SCRIPT)
	rm -f $(DESTDIR)$(BINDIR)/xmgracetopdf
	rm -f $(DESTDIR)$(MANDIR)/$(MANPAGE)
	rm -f $(DESTDIR)$(MANDIR)/xmgracetopdf.1
	rm -f $(DESTDIR)$(COMPLETIONDIR)/$(SCRIPT)
	rm -f $(DESTDIR)$(ZSHCOMPLETIONDIR)/_$(SCRIPT)
	@echo "✓ Uninstallation completed"

# Install to user's home directory
.PHONY: install-user
install-user: check
	@echo "Installing $(SCRIPT) to user directory..."
	install -d $(HOME)/.local/bin
	install -m 755 $(SCRIPT) $(HOME)/.local/bin/$(SCRIPT)
	@echo "Creating alias xmgracetopdf..."
	ln -sf $(SCRIPT) $(HOME)/.local/bin/xmgracetopdf
	install -d $(HOME)/.local/share/man/man1
	install -m 644 $(MANPAGE) $(HOME)/.local/share/man/man1/$(MANPAGE)
	@echo "Creating man page alias..."
	ln -sf $(MANPAGE) $(HOME)/.local/share/man/man1/xmgracetopdf.1
	install -d $(HOME)/.local/share/bash-completion/completions
	install -m 644 $(COMPLETION) $(HOME)/.local/share/bash-completion/completions/$(SCRIPT)
	install -d $(HOME)/.local/share/zsh/site-functions
	install -m 644 $(ZSHCOMPLETION) $(HOME)/.local/share/zsh/site-functions/_$(SCRIPT)
	@echo "✓ User installation completed"
	@echo ""
	@echo "The script has been installed to: $(HOME)/.local/bin/$(SCRIPT)"
	@echo "Alias created: $(HOME)/.local/bin/xmgracetopdf -> $(SCRIPT)"
	@echo "The man page has been installed to: $(HOME)/.local/share/man/man1/$(MANPAGE)"
	@echo "Bash completion has been installed to: $(HOME)/.local/share/bash-completion/completions/$(SCRIPT)"
	@echo "Zsh completion has been installed to: $(HOME)/.local/share/zsh/site-functions/_$(SCRIPT)"
	@echo ""
	@echo "Make sure $(HOME)/.local/bin is in your PATH."
	@echo "You can add it by running: echo 'export PATH=\"\$$HOME/.local/bin:\$$PATH\"' >> ~/.bashrc"
	@echo "To enable bash completion, add this to your ~/.bashrc:"
	@echo "  source $(HOME)/.local/share/bash-completion/completions/$(SCRIPT)"
	@echo "For zsh completion, add $(HOME)/.local/share/zsh/site-functions to your fpath in ~/.zshrc"

# Uninstall from user's home directory
.PHONY: uninstall-user
uninstall-user:
	@echo "Uninstalling $(SCRIPT) from user directory..."
	rm -f $(HOME)/.local/bin/$(SCRIPT)
	rm -f $(HOME)/.local/bin/xmgracetopdf
	rm -f $(HOME)/.local/share/man/man1/$(MANPAGE)
	rm -f $(HOME)/.local/share/man/man1/xmgracetopdf.1
	rm -f $(HOME)/.local/share/bash-completion/completions/$(SCRIPT)
	rm -f $(HOME)/.local/share/zsh/site-functions/_$(SCRIPT)
	@echo "✓ User uninstallation completed"

# Test the script with sample commands
.PHONY: test
test: check
	@echo "Testing script help output..."
	./$(SCRIPT) --help >/dev/null
	./$(SCRIPT) --version >/dev/null
	@echo "✓ Basic functionality tests passed"

# Test bash completion
.PHONY: test-completion
test-completion: check
	@echo "Testing bash completion..."
	./test_completion.sh
	@echo "✓ Bash completion tests passed"

.PHONY: test_clean
test_clean:
	@echo "Cleaning up test artifacts..."
	rm -f *.pdf *.ps
	@echo "✓ Test artifacts cleaned up"

# Check runtime dependencies
.PHONY: check-deps
check-deps:
	@echo "Checking runtime dependencies..."
	@command -v gracebat >/dev/null 2>&1 && echo "✓ grace (gracebat) is available" || echo "✗ grace (gracebat) not found - install xmgrace package"
	@command -v ps2pdf >/dev/null 2>&1 && echo "✓ ghostscript (ps2pdf) is available" || echo "✗ ghostscript (ps2pdf) not found - install ghostscript package"

# Display installation help
.PHONY: help
help:
	@echo "gracetopdf Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  all            - Check script syntax (default target)"
	@echo "  check          - Check script syntax and installation tools"
	@echo "  check-deps     - Check runtime dependencies"
	@echo "  test           - Run basic functionality tests"
	@echo "  test-completion - Test bash completion functionality"
	@echo "  test_clean     - Clean up test artifacts"
	@echo "  install        - Install system-wide (requires sudo)"
	@echo "  install-user   - Install to user's home directory"
	@echo "  uninstall      - Uninstall system-wide (requires sudo)"
	@echo "  uninstall-user - Uninstall from user's home directory"
	@echo "  help           - Show this help message"
	@echo ""
	@echo "Installation examples:"
	@echo "  make install-user          # Install to ~/.local/bin"
	@echo "  sudo make install          # Install system-wide"
	@echo "  sudo make PREFIX=/opt install  # Install to custom prefix"
	@echo ""
	@echo "Environment variables:"
	@echo "  PREFIX         - Installation prefix (default: /usr/local)"
	@echo "  DESTDIR        - Destination directory for staged installs"
