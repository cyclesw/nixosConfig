# Common ls aliases and sort them by type and then name
# Inspired by https://github.com/nushell/nushell/issues/7190

# alias the built-in ls command to ls-builtins
alias ls-builtin = ls

# List the filenames, sizes, and modification times of items in a directory.
def ls [
    --all (-a),         # Show hidden files
    --long (-l),        # Get all available columns for each entry (slower; columns are platform-dependent)
    --short-names (-s), # Only print the file names, and not the path
    --full-paths (-f),  # display paths as absolute paths
    --du (-d),          # Display the apparent directory size ("disk usage") in place of the directory metadata size
    --directory (-D),   # List the specified directory itself instead of its contents
    --mime-type (-m),   # Show mime-type in type column instead of 'file' (based on filenames only; files' contents are not examined)
    --threads (-t),     # Use multiple threads to list contents. Output will be non-deterministic.
    ...pattern: glob,   # The glob pattern to use.
]: [ nothing -> table ] {
    let pattern = if ($pattern | is-empty) { [ '.' ] } else { $pattern }
    (ls-builtin
        --all=$all
        --long=$long
        --short-names=$short_names
        --full-paths=$full_paths
        --du=$du
        --directory=$directory
        --mime-type=$mime_type
        --threads=$threads
        ...$pattern
    ) | sort-by type name -i
}

alias ll  = ls -l
alias la  = ls -a
alias lla = ls -la

alias cat = bat

$env.PATH = ($env.PATH | 
    split row (char esep) |
    prepend /home/myuser/.apps |
    append /usr/bin/env
)
{ ||
    if (which direnv | is-empty) {
        return
    }

    direnv export json | from json | default {} | load-env
}

$env.NIXPKGS_ALLOW_UNFREE = 1   # 允许非自由软件
$env.NIXOS_OZONE_WL = "1"
$env.TEST = 1