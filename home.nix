{ config, pkgs, ... }:

{ home.username = "winter";
    home.homeDirectory = "/home/winter";
    programs.git = {
        enable = true;
        userName = "winterwinterwinter";
        userEmail = "hoh20677@gmail.com";
    };
    home.stateVersion = "26.05";
    programs.zsh = {
        enable = true;
        syntaxHighlighting = {
            enable = true;
        };
        oh-my-zsh = {
            enable = true;
            plugins = [
        	      "git"
                "fzf"
                "zsh-interactive-cd"
            ];
    	  };
        sessionVariables = {
          LANG = "en_US.UTF-8";
          PKG_CONFIG_PATH = "/usr/local/lib/pkgconfig/";
          QT_QPA_PLATFORM = "wayland";

          __NV_PRIME_RENDER_OFFLOAD = "1";
          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
          __VK_LAYER_NV_optimus = "NVIDIA_only";
        };
        shellAliases = {
          n = "nvim";
          h = "helix";
        };
        plugins = [
            {
              name = "zsh-autosuggestions";
              src = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
            }
        ];
        initExtra = ''
          typeset -A ZSH_HIGHLIGHT_STYLES
          ZSH_HIGHLIGHT_STYLES[default]='fg=#FFFFFF,bg=none'
          ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#FF5555,bold'
          ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#FF79C6,bold'
          ZSH_HIGHLIGHT_STYLES[alias]='fg=#50FA7B,bold'
          ZSH_HIGHLIGHT_STYLES[builtin]='fg=#8BE9FD,bold'
          ZSH_HIGHLIGHT_STYLES[function]='fg=#BD93F9'
          ZSH_HIGHLIGHT_STYLES[command]='fg=#3BFF45,bold'
          ZSH_HIGHLIGHT_STYLES[precommand]='fg=#FFB86C'
          ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#FFFFFF,bold'
          ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#50FA7B'
          ZSH_HIGHLIGHT_STYLES[path]='fg=#00FFFF,underline'
          ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#00FFFF'
          ZSH_HIGHLIGHT_STYLES[globbing]='fg=#FFB86C'
          ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#FF5555,bold'
          ZSH_HIGHLIGHT_STYLES[assign]='fg=#FFFFFF'
          ZSH_HIGHLIGHT_STYLES[redirection]='fg=#FF79C6'
          ZSH_HIGHLIGHT_STYLES[parameter]='fg=#FFFF00'
          ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#BD93F9'
          ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#00FFFF'
          ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#00FFFF'
          ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#00FFFF'
          ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=#00FFFF'
          ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=#FFB86C'
          ZSH_HIGHLIGHT_STYLES[argument]='fg=#FFFFFF'
          ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#ADAAAA,bold'
          ZSH_HIGHLIGHT_STYLES[command-not-found]='fg=#ADAAAA,bold'
          ZSH_HIGHLIGHT_STYLES[error]='fg=#ADAAAA,bold'
          ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=#FF5555'
          ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=#F1FA8C'
          ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=#8BE9FD'
          ZSH_HIGHLIGHT_STYLES[comment]='fg=#6272A4,italic'
          ZSH_HIGHLIGHT_STYLES[command-substitution]='fg=#BD93F9'
          ZSH_HIGHLIGHT_STYLES[process-substitution]='fg=#BD93F9'
          ZSH_HIGHLIGHT_STYLES[math-expression]='fg=#FFB86C'

          # Node Version Manager (NVM) manual fallback hook
          export NVM_DIR="$HOME/.nvm"
          [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
          [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
        '';
    };
    programs.oh-my-posh = {
	      enable = true;
	      enableZshIntegration = true;
        settings = builtins.fromTOML (builtins.readFile ./ohmyposh/config.omp.toml);
    };
    home.file.".config/sway".source = .config/sway;
    home.file.".config/nvim".source = .config/nvim;
    home.file.".config/waybar".source = .config/waybar;
    home.file.".config/tmux".source = .config/tmux;
    home.file.".config/nsxiv".source = .config/nsxiv;
    home.file.".config/dunst".source = .config/dunst;
    home.file.".config/rofi".source = .config/rofi;
    home.file.".config/foot".source = .config/foot;

    #scripts and .desktosp for homescreen changing shit

    #scripts
    home.file = {
        "./scripts" = {
            source = ./scripts;
            executable = true;
        };
    };

    #desktop
    xdg.desktopEntries.change-wallpaper = {
        name = "Change wallpaper";
        exec = "/home/winter/scripts/selectwallpaper.sh";
        type = "Application";
    };

    xdg.desktopEntries.gacha-wallpaper = {
        name = "Random wallpaper";
        exec = "/home/winter/scripts/set_random_wallpaper.sh";
        type = "Application";
    };

    gtk = {
        enable = true;
        theme = {
            name = "Adawaita-dark";
            package = pkgs.gnome-themes-extra;
        };
    };

    home.packages = with pkgs; [
	      zsh-autosuggestions
	      nsxiv
	      zsh-syntax-highlighting
	      neovim
	      ripgrep
	      nil
	      tmux
	      nixpkgs-fmt
	      nodejs
	      waybar
	      fzf
	      autotiling
        pywal16
        playerctl
        btop
        wiremix
        ncdu
        libnotify
        xrdb
        vesktop
        fastfetch
        lazygit
        gradia
        nautilus
        unrar
    ];
}

