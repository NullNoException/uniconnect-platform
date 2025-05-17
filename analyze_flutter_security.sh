#!/bin/bash
# A script to perform security analysis on the Flutter app
# Usage: ./analyze_flutter_security.sh

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Starting Flutter security analysis...${NC}"

# Go to the Flutter app directory
cd "$(dirname "$0")/src/customer_app" || { echo "Failed to navigate to customer_app directory"; exit 1; }

echo -e "${BLUE}Checking for Flutter updates...${NC}"
flutter upgrade

echo -e "${BLUE}Getting dependencies...${NC}"
flutter pub get

echo -e "${BLUE}Running Flutter analyzer...${NC}"
flutter analyze

# Check for insecure code patterns
# echo -e "${BLUE}Checking for potential security issues in code...${NC}"

# echo -e "${YELLOW}Scanning for hardcoded secrets...${NC}"
# SECRETS=$(grep -r --include="*.dart" "apiKey\|secret\|password\|token\|SECRET_" lib --color=always || echo "")
# if [ -n "$SECRETS" ]; then
#   echo -e "${RED}Potential hardcoded secrets found:${NC}"
#   echo "$SECRETS"
# else
#   echo -e "${GREEN}No suspicious hardcoded strings found.${NC}"
# fi

echo -e "${YELLOW}Checking for insecure SSL/TLS usage...${NC}"
INSECURE_SSL=$(grep -r --include="*.dart" "allowInsecureConnections: true\|checkCertificate: false\|validateCertificate: false" lib --color=always || echo "")
if [ -n "$INSECURE_SSL" ]; then
  echo -e "${RED}Insecure SSL/TLS usage found:${NC}"
  echo "$INSECURE_SSL"
else
  echo -e "${GREEN}No insecure SSL/TLS usage found.${NC}"
fi

echo -e "${YELLOW}Checking for insecure random number generation...${NC}"
INSECURE_RANDOM=$(grep -r --include="*.dart" "Random(" lib --color=always || echo "")
if [ -n "$INSECURE_RANDOM" ]; then
  echo -e "${YELLOW}Potential insecure random number generation:${NC}"
  echo "$INSECURE_RANDOM"
  echo -e "${YELLOW}TIP: Consider using 'Random.secure()' for security-sensitive operations.${NC}"
else
  echo -e "${GREEN}No insecure random generators found.${NC}"
fi

echo -e "${YELLOW}Checking for SQL injection risks...${NC}"
SQL_INJECTION=$(grep -r --include="*.dart" "rawQuery\|rawInsert\|rawUpdate\|rawDelete" lib --color=always || echo "")
if [ -n "$SQL_INJECTION" ]; then
  echo -e "${RED}Potential SQL injection risks:${NC}"
  echo "$SQL_INJECTION"
else
  echo -e "${GREEN}No raw SQL usage found.${NC}"
fi

echo -e "${YELLOW}Checking for outdated dependencies...${NC}"
flutter pub outdated

echo -e "${BLUE}Security analysis complete.${NC}"
