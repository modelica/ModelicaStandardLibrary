rem delete temporary files that should not be added to the SVN

del /F /S *.mat buildlog.txt ds*.txt *.c dymosim.exe request stop
del /F /S *.mof
del /F /S *.bak-mo