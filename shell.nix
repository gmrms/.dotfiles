let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-23.11";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

pkgs.mkShellNoCC {
  packages = with pkgs; [
   # cli tools
    eza         # ls
    bat         # cat
    zoxide      # cd
    eva         # calculator
    xclip       # copy paste

    # general
    lunarvim
    git
    docker

    # languages
    nodejs_21
    yarn
    zulu17      # java 17
    maven
  ];

  EDITOR="lvim";
  VISUAL="lvim";
  HF_TOKEN="***";
  
  GITHUB_TOKEN="***";
  GITHUB_USER="***";

  shellHook = ''
    # Aliases
    eval "$(zoxide init bash --cmd cd)"

    alias ls="eza --icons -la"
    alias cat="bat --style=auto"

    # Clip
    alias xc="xclip"
    alias c="xclip -selection clipboard"
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

}
