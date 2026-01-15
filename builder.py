import os
import yaml
import re

def load_yaml(path):
    with open(path, 'r') as f:
        return yaml.safe_load(f)

def render_template(template_str, colors):
    def replace(match):
        key = match.group(1).strip()
        return colors.get(key, match.group(0))
    
    return re.sub(r'\{\{(.*?)\}\}', replace, template_str)

def main():
    schemes_dir = 'schemes'
    templates_dir = 'templates'
    output_dir = 'output'

    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    schemes = [f for f in os.listdir(schemes_dir) if f.endswith('.yaml')]
    templates = [f for f in os.listdir(templates_dir) if f.endswith('.yaml')]

    for scheme_file in schemes:
        scheme_path = os.path.join(schemes_dir, scheme_file)
        scheme_data = load_yaml(scheme_path)
        scheme_name = scheme_data.get('name', os.path.splitext(scheme_file)[0]).lower().replace(' ', '_')
        colors = scheme_data.get('colors', {})

        print(f"Processing scheme: {scheme_name}")

        for temp_file in templates:
            temp_path = os.path.join(templates_dir, temp_file)
            temp_data = load_yaml(temp_path)
            app_name = os.path.splitext(temp_file)[0]
            extension = temp_data.get('extension', '')
            template_str = temp_data.get('template', '')

            rendered = render_template(template_str, colors)

            output_app_dir = os.path.join(output_dir, app_name)
            if not os.path.exists(output_app_dir):
                os.makedirs(output_app_dir)

            output_filename = f"{scheme_name}{extension}"
            output_path = os.path.join(output_app_dir, output_filename)

            with open(output_path, 'w') as f:
                f.write(rendered)
            
            print(f"  Generated: {output_path}")

if __name__ == "__main__":
    main()
