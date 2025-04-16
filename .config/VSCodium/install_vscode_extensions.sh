#!/bin/bash

# Script to install recommended VSCode extensions for Python development
# For Ubuntu Linux systems
# Created by Amazon Q

echo "Installing VSCode extensions for Python development..."

# Check if code command is available
if ! command -v code &> /dev/null; then
    echo "Error: VSCode command line tool not found."
    echo "Please make sure VSCode is installed and the 'code' command is in your PATH."
    echo "You may need to run: 'sudo ln -s /usr/share/code/bin/code /usr/local/bin/code'"
    exit 1
fi

# Install Python extensions
echo "Installing Python extensions..."
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-python.black-formatter
code --install-extension charliermarsh.ruff
code --install-extension kevinrose.vsc-python-indent
code --install-extension njpwerner.autodocstring

# Install Amazon Q
echo "Installing Amazon Q..."
code --install-extension amazonwebservices.amazon-q-vscode

# Install YAML support
echo "Installing YAML support..."
code --install-extension redhat.vscode-yaml

# Install Remote Development pack
echo "Installing Remote Development extensions..."
code --install-extension ms-vscode-remote.vscode-remote-extensionpack

echo "All extensions have been installed successfully!"
echo "Restart VSCode to activate all extensions."
