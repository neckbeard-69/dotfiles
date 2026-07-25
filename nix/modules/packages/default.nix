{ pkgs, ... }:

{
  environment.systemPackages =
    (import ./cli.nix { inherit pkgs; })
    ++ (import ./shell.nix { inherit pkgs; })
    ++ (import ./editors.nix { inherit pkgs; })
    ++ (import ./dev.nix { inherit pkgs; })
    ++ (import ./desktop.nix { inherit pkgs; })
    ++ (import ./wayland.nix { inherit pkgs; })
    ++ (import ./system.nix { inherit pkgs; });
}
