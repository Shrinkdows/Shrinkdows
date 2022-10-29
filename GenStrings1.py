import os
import textwrap
for dir in os.scandir('.\\scripts'):
  if not dir.name.startswith('.') and dir.is_dir():
    PascalName = ''.join(x for x in dir.name.title() if not x.isspace())
    with open(f"{dir.path}\\description.txt", "r") as file:
      description = file.read()
    print(textwrap.dedent(f'''
      LangString DESC_Sec{PascalName} ${{LANG_ENGLISH}} '{description}'
    ''').strip())