import os
import textwrap
for dir in os.scandir('.\\scripts'):
  if not dir.name.startswith('.') and dir.is_dir():
    print(textwrap.dedent(f'''
      !insertmacro UMUI_COMPONENT Sec{''.join(x for x in dir.name.title() if not x.isspace())}
    ''').strip())
