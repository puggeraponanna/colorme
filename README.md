# ColorMe Framework

A simple, YAML-based colorscheme generator for various applications.

## How it works

1.  **Define Colors**: Add a YAML file to the `schemes/` directory with your color definitions.
2.  **Create Templates**: Add a YAML file to the `templates/` directory defining how the colors should be mapped to an app's configuration.
3.  **Build**: Run `python3 builder.py` to generate the themes in the `output/` directory.

## Directory Structure

- `schemes/`: Source color definitions (YAML).
- `templates/`: Templates for different apps (YAML).
- `output/`: Generated colorschemes.
- `builder.py`: The build script.
