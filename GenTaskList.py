import os
import textwrap
for dir in os.scandir('.\\extratasks'):
  if not dir.name.startswith('.') and dir.is_dir():
    if os.path.isfile(f"{dir.path}\\standard.txt"):
      print(textwrap.dedent(f'''
          !insertmacro UMUI_ADDITIONALTASKSPAGE_ADD_TASK Task{''.join(x for x in dir.name.title() if not x.isspace())} 1 "{dir.name}"
      ''').strip())
    else:
      print(textwrap.dedent(f'''
          !insertmacro UMUI_ADDITIONALTASKSPAGE_ADD_TASK Task{''.join(x for x in dir.name.title() if not x.isspace())} 0 "{dir.name}"
      ''').strip())
