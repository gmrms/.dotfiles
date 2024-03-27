# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11";


  environment.systemPackages = with pkgs; [
    #nix
    home-manager

    # cli tools
    eza         # ls
    bat         # cat
    zoxide      # cd
    eva         # calculator
    xclip       # copy paste

    # general
    lunarvim
    git

    # languages
    nodejs_21
    yarn
    zulu17      # java 17
    maven
  ];

  environment.interactiveShellInit = ''
    # Aliases
    eval "$(zoxide init zsh --cmd cd)"

    alias ls="exa --icons -l"
    alias cat="bat --style=auto"

    # Clip
    alias c="xclip"
    alias clipboard="xclip -selection clipboard"
    alias v="xclip -o"

    # Git
    alias g="git"
    alias gs="git status"
    alias ga="git add"
    alias gc="git commit -m"
    alias gca="git commit -am"
    alias gp="git push"
    alias gpl="git pull"
    alias gco="git checkout"

    # Maven
    alias m="mvn"
    alias mc="mvn clean"
    alias mi="mvn install"
    alias mci="mvn clean install"
    alias mcp="mvn clean package"

    # Docker
    alias d="docker"
    alias dc="docker compose"

    # Kubernetes
    alias k="kubectl"

    # SpringBoot
    alias spring-run="mvn spring-boot:run"
    alias spring-run-dev="mvn spring-boot:run -Dspring-boot.run.profiles=dev"
    alias spring-debug="mvn spring-boot:run -Dspring-boot.run.jvmArguments='-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005'"
    alias spring-debug-dev="mvn spring-boot:run -Dspring-boot.run.profiles=dev -Dspring-boot.run.jvmArguments='-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005'"
  '';


  users.defaultUserShell=pkgs.zsh;

  programs = {
     zsh = {
        enable = true;
        autosuggestions.enable = true;
        zsh-autoenv.enable = true;
        syntaxHighlighting.enable = true;
        ohMyZsh = {
           enable = true;
           theme = "robbyrussell";
           plugins = [
             "git"
             "npm"
             "history"
             "node"
             "rust"
             "deno"
           ];
        };
     };
  };

}
