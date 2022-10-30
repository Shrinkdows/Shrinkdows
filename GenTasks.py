import os
import textwrap
for dir in os.scandir('.\\components'):
  if not dir.name.startswith('.') and dir.is_dir():
    print(textwrap.dedent(f'''
      Section "{dir.name}" Sec{''.join(x for x in dir.name.title() if not x.isspace())}
    ''').strip())

    if os.path.isfile(f"{dir.path}\\standard.txt"):
      print(textwrap.dedent(f'''
          SectionIn 2 3 4
      ''').strip())
    else:
      print(textwrap.dedent(f'''
          SectionIn 3
      ''').strip())

    print(textwrap.dedent(f'''
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