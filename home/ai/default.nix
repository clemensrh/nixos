{ pkgs, ... }:
{
  home.packages = with pkgs; [
    github-copilot-cli
    # claude-code
    codex
    gemini-cli
    opencode
  ];
}
