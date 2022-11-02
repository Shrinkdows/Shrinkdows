import os
import textwrap
for dir in os.scandir('.\\extratasks'):
  if not dir.name.startswith('.') and dir.is_dir():
    print(textwrap.dedent(f'''
        !insertmacro UMUI_ADDITIONALTASKS_IF_CKECKED STARTUP
          SetOutPath "$INSTDIR"
          File /nonfatal /a /r "{dir.path}\\"
          nsExec::ExecToLog '{dir.path}\\run.bat'
          pop $0
        !insertmacro UMUI_ADDITIONALTASKS_ENDIF
    ''').strip())
