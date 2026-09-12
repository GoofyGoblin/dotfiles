{ config, pkgs, ... }:

{ home.username = "winter";
    home.homeDirectory = "/home/winter";
    programs.git.enable = true;
    home.stateVersion = "26.05";
    programs.zsh = {
        enable = true;
        oh-my-zsh = {
            enable = true;
            plugins = [
        	"git"
        	"dirhistory"
        	"history"
            ];
    	};
        initExtra = '' 
            source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh 
            source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 
        '';
    };
    home.file.".config/sway".source = .config/sway;
    home.file.".config/nvim".source = .config/nvim;
    home.file.".config/waybar".source = .config/waybar;
    home.file.".config/tmux".source = .config/tmux;
    home.file.".config/nsxiv".source = .config/nsxiv;
    home.file.".config/dunst".source = .config/dunst;

    #scripts for homescreen changing shit


    home.packages = with pkgs; [
	zsh-autosuggestions
	nsxiv
	zsh-syntax-highlighting
	neovim
	ripgrep
	nil
	nixpkgs-fmt
	nodejs
	waybar
	fzf
    ];
}

