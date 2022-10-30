import os
import textwrap
for dir in os.scandir('.\\components'):
  if not dir.name.startswith('.') and dir.is_dir():
    PascalName = ''.join(x for x in dir.name.title() if not x.isspace())
    with open(f"{dir.path}\\description.txt", "r") as file:
      description = file.read()
    print(textwrap.dedent(f'''
      !insertmacro MUI_DESCRIPTION_TEXT ${{Sec{PascalName}}} $(DESC_Sec{PascalName})
    ''').strip())
