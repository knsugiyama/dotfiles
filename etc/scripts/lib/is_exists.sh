is_exists() {
    which "$1" >/dev/null 2>&1
    return $?
}
