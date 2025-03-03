[System.Environment]::SetEnvironmentVariable("XDG_CONFIG_HOME", $HOME + '\.config', 'Machine')
[System.Environment]::SetEnvironmentVariable("XDG_DATA_HOME", $HOME + '\.local\share', 'Machine')
[System.Environment]::SetEnvironmentVariable("XDG_CACHE_HOME", $HOME + '\.local\cache', 'Machine')
[System.Environment]::SetEnvironmentVariable("XDG_STATE_HOME", $HOME + '\.local\state', 'Machine')
