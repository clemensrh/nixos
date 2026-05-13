{
  config,
  ...
}:

{
  imports = [
    ./fzf.nix
    ./omp.nix
    ./zoxide.nix
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Custom aliases
    shellAliases = {
      # System management
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#snowflake";
      update = "sudo nix flake update /etc/nixos#snowflake";
      clean = "sudo nix-collect-garbage -d";

      # Directory navigation
      ll = "ls -lah";
      la = "ls -A";
      l = "ls -CF";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";

      # Git shortcuts
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline --graph --decorate";
      gd = "git diff";

      # Safety nets
      rm = "rm -i";
      cp = "cp -i";
      mv = "mv -i";

      # Utilities
      grep = "grep --color=auto";
      mkdir = "mkdir -pv";
      c = "clear";
    };

    initContent = ''
      # Additional zsh options
      setopt AUTO_CD              # Auto cd to a directory without typing cd
      setopt AUTO_PUSHD           # Push the old directory onto the stack
      setopt PUSHD_IGNORE_DUPS    # Don't push multiple copies
      setopt HIST_IGNORE_DUPS     # Don't record duplicate commands
      setopt HIST_FIND_NO_DUPS    # Don't show duplicates in search
      setopt SHARE_HISTORY        # Share history between sessions

      eval "$(zoxide init zsh)"

      # Key bindings
      bindkey '^[[A' history-search-backward
      bindkey '^[[B' history-search-forward

      export PATH="$HOME/.bun/bin:$PATH"
      export PORTLESS_HTTPS=1
    '';

    history = {
      size = 10000;
      save = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
      ignoreDups = true;
      share = true;
    };

    # Oh My Zsh integration
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "docker"
        "kubectl"
        "systemd"
      ];
    };
  };
}
