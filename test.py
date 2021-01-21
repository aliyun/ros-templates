import os
import shutil
import yaml
import json

BASE_DIR = os.path.dirname(os.path.abspath(__file__))


def json2yaml(dic) -> (str, str):
    yml_content = ''
    for key in ('ROSTemplateFormatVersion', 'Description', 'Metadata', 'Parameters', 'Mappings',
                'Conditions', 'Resources', 'Outputs'):
        value = dic.get(key)
        if value:
            item = {key: value}
            y = yaml.dump(item, default_flow_style=False, encoding='utf-8', allow_unicode=True)

            yml_content += y.decode('utf8')
    return yml_content, dic.get('Description', '')


def main():
    child_dir = os.listdir(BASE_DIR)
    child_dir.sort()
    for i in child_dir:
        # i: ACM
        print(f'### {i}')
        print('| No.   | Name           | Description                     | Links        |')
        print('| ----- | -------------- | ------------------------------- | ------------ |')
        product_dir = os.path.join(BASE_DIR, i)
        if os.path.isdir(product_dir):
            json_dir = os.path.join(product_dir, 'JSON')
            yml_dir = os.path.join(product_dir, 'YAML')

            product_files = os.listdir(product_dir)

            if not os.path.exists(json_dir):
                os.mkdir(json_dir)
            if not os.path.exists(yml_dir):
                os.mkdir(yml_dir)
            for index, f in enumerate(product_files):
                # f: xxx.json
                f_name = f.replace('.json', '')
                product_path = os.path.join(product_dir, f)

                json_content = json.load(open(product_path))
                # 移动json模板
                shutil.move(product_path, json_dir)
                # 创建yaml模板
                yaml_content, description = json2yaml(json_content)
                with open(os.path.join(yml_dir, f'{f_name}.yml'), 'w') as fp:
                    fp.write(yaml_content)
                json_link = f'ResourceTemplates/{i}/JSON/{f_name}.json'
                yaml_link = f'ResourceTemplates/{i}/YAML/{f_name}.yml'
                print(f'| {index+1} | {f_name} | {description} | [YAML]({yaml_link}) [JSON]({json_link})|')
        # exit()


if __name__ == '__main__':
    print('## ResourceTemplates')
    main()
