rem delete all files that are not included with the distrubition

call clean.bat
rmdir /S /Q Test
del   /S /F clean.bat
del   /S /F distclean.bat
