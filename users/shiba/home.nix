{ pkgs
, inputs
, ...
}: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    ./sops
    ./services
    ./programs
  ];

  home.stateVersion = "22.05";
  programs.home-manager.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  home.persistence."/persist/home/shiba" = {
    directories = [
      "Documents"
      "Downloads"
      "Music"
      "Pictures"
      "Sync"
      "Videos"
      ".local/share/Steam"
      ".local/share/qutebrowser"
      ".local/state/wireplumber"
      ".cache/tealdeer"
      ".factorio"
    ];
    allowOther = true;
  };

  home.packages = with pkgs; [
    # Fonts
    material-design-icons
    iosevka-bin
    (iosevka-bin.override { variant = "sgr-iosevka-term"; })
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })

    # Some programs e.g. inkscape use adwaita by default
    gnome.adwaita-icon-theme
  ];

  fonts.fontconfig.enable = true;

  home.pointerCursor = {
    name = "Catppuccin-Macchiato-Dark-Cursors";
    package = pkgs.catppuccin-cursors.macchiatoDark;
    x11.enable = true;
    gtk.enable = true;
    size = 32;
  };

  gtk = {
    enable = true;
    font = {
      name = "Mali";
      size = 14;
    };
    theme = {
      package = pkgs.pers-pkgs.catppuccin-gtk-macchiato-mauve;
      name = "Catppuccin-Macchiato-Mauve";
    };
    iconTheme = {
      package = pkgs.pers-pkgs.catppuccin-papirus-icon-theme.override {
        color = "cat-macchiato-mauve";
      };
      name = "Papirus-Dark";
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        charset = "utf-8";
        end_of_line = "lf";
        insert_final_newline = true;
        trim_trailing_whitespace = true;
        indent_style = "space";
      };
      "*.nix" = { indent_size = 2; };
      "*.lua" = { indent_size = 3; };
    };
  };
}
