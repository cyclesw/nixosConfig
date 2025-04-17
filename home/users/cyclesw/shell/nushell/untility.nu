#!nushell

def nix-switch [name: string, path = "/etc/nixos/"] {
    nixos-rebuild switch --flake $"($path)#($name)"
}

def nix-clean [] {
    nix-env --profile /nix/var/nix/profiles/system --delete-generations +3   
    nix-collect-garbage --delete-older-than 7d
}

def find_process [name] {
    ps | where name =~ $"($name)"
}