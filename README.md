# ColorMe Framework

A simple, YAML-based colorscheme generator for various applications.

## How it works

1.  **Define Colors**: Add a YAML file to the `schemes/` directory with your color definitions.
2.  **Create Templates**: Add a YAML file to the `templates/` directory defining how the colors should be mapped to an app's configuration.
3.  **Build**: Run `python3 builder.py` to generate the themes in the `output/` directory.

## Automation

You can build and apply colorschemes using the provided `Makefile`.

### 1. Build only
To generate all themes for all schemes:
```bash
make build
```

### 2. Build and Apply
To generate themes and copy them to your application config directories (defaulting to the `nord` scheme):
```bash
make apply
```
Or for a specific scheme:
```bash
./apply.sh catppuccin
```

> [!NOTE]
> The `apply` command copies files to `~/.config/nvim/`, `~/.config/tmux/tmux.conf.colors`, etc. You may need to add a `source` command to your main config files as indicated by the script output.

## Directory Structure
...
