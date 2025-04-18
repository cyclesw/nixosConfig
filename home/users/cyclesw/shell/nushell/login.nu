if (is-terminal --stdin) {
    echo $"hello ($env.USER)"
} else {
    exec zsh;
}
