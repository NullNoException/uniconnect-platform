#!/bin/sh
# setup-husky.sh - Script to install and setup Husky git hooks

echo "🐶 Setting up Husky git hooks for UniConnect..."

# Ensure we are in the root directory
if [ ! -d ".git" ]; then
  echo "❌ Error: This script must be run from the root of the repository."
  exit 1
fi

# Setup Husky paths
mkdir -p .husky/_

# Install Husky if not already installed
if ! command -v husky &> /dev/null; then
  if command -v npm &> /dev/null; then
    echo "📦 Installing Husky via npm..."
    npm install husky --save-dev
  elif command -v dart &> /dev/null; then
    echo "📦 Installing Husky via Dart..."
    cd src/customer_app && dart pub add --dev husky
    cd ../..
  else
    echo "⚠️ Neither npm nor dart found. Please install Husky manually."
  fi
fi

# Set Git to use our hooks path
echo "🔧 Configuring Git hooks path..."
git config core.hooksPath .husky

# Make the hooks executable
echo "🔐 Making hooks executable..."
chmod +x .husky/pre-commit .husky/commit-msg .husky/_/husky.sh

echo "✅ Husky setup complete! Git hooks are now installed."
echo "   Pre-commit hook will run code formatting and linting."
echo "   Commit-msg hook will enforce conventional commit messages."
