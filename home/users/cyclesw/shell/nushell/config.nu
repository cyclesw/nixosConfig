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


# Completions
# mainly pieced together from https://www.nushell.sh/cookbook/external_completers.html

# carapce completions https://www.nushell.sh/cookbook/external_completers.html#carapace-completer
# + fix https://www.nushell.sh/cookbook/external_completers.html#err-unknown-shorthand-flag-using-carapace
# enable the package and integration bellow
let carapace_completer = {|spans: list<string>|
    carapace $spans.0 nushell ...$spans
    | from json
    | if ($in | default [] | where value == $"($spans | last)ERR" | is-empty) { $in } else { null }
}
# some completions are only available through a bridge
# eg. tailscale
# https://carapace-sh.github.io/carapace-bin/setup.html#nushell
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'

# fish completions https://www.nushell.sh/cookbook/external_completers.html#fish-completer
let fish_completer = {|spans|
    fish --command $'complete "--do-complete=($spans | str join " ")"'
    | $"value(char tab)description(char newline)" + $in
    | from tsv --flexible --no-infer
}

# zoxide completions https://www.nushell.sh/cookbook/external_completers.html#zoxide-completer
let zoxide_completer = {|spans|
    $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
}

# multiple completions
# the default will be carapace, but you can also switch to fish
# https://www.nushell.sh/cookbook/external_completers.html#alias-completions
let multiple_completers = {|spans|
    ## alias fixer start https://www.nushell.sh/cookbook/external_completers.html#alias-completions
    let expanded_alias = scope aliases
    | where name == $spans.0
    | get -i 0.expansion

    let spans = if $expanded_alias != null {
    $spans
    | skip 1
    | prepend ($expanded_alias | split row ' ' | take 1)
    } else {
    $spans
    }
    ## alias fixer end

    match $spans.0 {
    __zoxide_z | __zoxide_zi => $zoxide_completer
    _ => $carapace_completer
    } | do $in $spans
}

$env.config = {
    show_banner: false,
    completions: {
    case_sensitive: false # case-sensitive completions
    quick: true           # set to false to prevent auto-selecting completions
    partial: true         # set to false to prevent partial filling of the prompt
    algorithm: "fuzzy"    # prefix or fuzzy
    external: {
        # set to false to prevent nushell looking into $env.PATH to find more suggestions
        enable: true 
        # set to lower can improve completion performance at the cost of omitting some options
        max_results: 100 
        completer: $multiple_completers
    }
    }
} 
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
<<<<<<<< HEAD:users/cyclesw/shell/nushell/config.nu
========
$env.NIXOS_OZONE_WL = "1"

>>>>>>>> 038cfba (update desktop config):home/users/cyclesw/shell/nushell/config.nu
