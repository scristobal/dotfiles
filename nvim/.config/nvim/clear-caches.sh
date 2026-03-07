#!/usr/bin/env bash
set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

TARGETS=(
  "$HOME/.local/share/nvim/lazy"
  "$HOME/.local/share/nvim"
  "$HOME/.local/state/nvim"
  "$HOME/.cache/nvim"
  "$HOME/.config/nvim/lazy-lock.json"
)

echo -e "${BOLD}${CYAN}🧹 Neovim Cache Cleaner${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Show what will be deleted
echo -e "${BOLD}The following will be deleted:${NC}"
any_found=false
for target in "${TARGETS[@]}"; do
  if [ -e "$target" ]; then
    size=$(du -sh "$target" 2>/dev/null | cut -f1)
    echo -e "  ${RED}✗${NC} $target ${YELLOW}(${size})${NC}"
    any_found=true
  else
    echo -e "  ${GREEN}·${NC} $target ${YELLOW}(not found, skipping)${NC}"
  fi
done

if [ "$any_found" = false ]; then
  echo -e "\n${GREEN}Nothing to clean — all paths are already gone.${NC}"
  exit 0
fi

echo ""
read -rp "$(echo -e "${BOLD}Proceed? [y/N]:${NC} ")" confirm

if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
  echo -e "\n${YELLOW}Aborted.${NC}"
  exit 0
fi

echo ""
for target in "${TARGETS[@]}"; do
  if [ -e "$target" ]; then
    rm -rf "$target"
    echo -e "  ${RED}✗${NC} Deleted: $target"
  fi
done

echo ""
echo -e "${GREEN}${BOLD}✓ Done!${NC} Reopen Neovim — Lazy.nvim will bootstrap and reinstall everything."
