import os
import textwrap
for dir in os.scandir('.\\scripts'):
  if not dir.name.startswith('.') and dir.is_dir():
    with open(f"{dir.path}\\instprogresstext.txt", "r") as file:
      progresstext = file.read()
    print(textwrap.dedent(f'''
      Section "{dir.name}" Sec{''.join(x for x in dir.name.title() if not x.isspace())}
        SetOutPath "$INSTDIR"
        File /nonfatal /a /r "{dir.path}\"
    ''').strip())

    if os.path.isfile(f"{dir.path}\\instprogresstext.txt"):
      with open(f"{dir.path}\\instprogresstext.txt", "r") as file:
        progresstext = file.read()
      print(f'DetailPrint \'{progresstext}\'')

    print(textwrap.dedent(f'''
        nsExec::ExecToLog '"$INSTDIR\\{dir.name}\\inst.bat"'
        Pop $0
      SectionEnd
    ''').strip())