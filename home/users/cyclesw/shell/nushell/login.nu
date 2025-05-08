if (is-terminal --stdin) {
    echo $"hello ($env.USER)"
} else {
    date now | save -a /tmp/login.txt
    exec zsh;
}
