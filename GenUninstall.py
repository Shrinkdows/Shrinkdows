import os
import textwrap
for dir in os.scandir('.\\scripts'):
  if not dir.name.startswith('.') and dir.is_dir():
    if os.path.isfile(f"{dir.path}\\uninstprogresstext.txt"):
      with open(f"{dir.path}\\uninstprogresstext.txt", "r") as file:
        progresstext = file.read()
      print(f'DetailPrint \'{progresstext}\'')
    print(textwrap.dedent(f'''
      nsExec::ExecToLog '"$INSTDIR\\{dir.name}\\uninst.bat"'
      Pop $0
      RMDir /r '$INSTDIR\\{dir.name}'
    ''').strip())