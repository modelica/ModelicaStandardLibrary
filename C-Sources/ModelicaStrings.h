/*
   Copyright (C) 2002-2004, Modelica Association and DLR.

   The content of this file is free software; it can be redistributed 
   and/or modified under the terms of the Modelica license, see the 
   license conditions and the accompanying disclaimer in file
   ModelicaLicense.txt or in Modelica.UsersGuide.ModelicaLicense. 
*/

extern const char* ModelicaStrings_character(const char* string1, int index);
extern int ModelicaStrings_count(const char* string, const char* searchString, int caseSensitive);
extern int ModelicaStrings_find(const char* string, const char* searchString, int caseSensitive, int startIndex);
extern int ModelicaStrings_isEmpty(const char* string1);
extern int ModelicaStrings_isEqual(const char* string1, const char* string2, int caseSensitive);
extern const char* ModelicaStrings_repeat(int n, const char* string1);
extern const char* ModelicaStrings_replace(const char* string, const char* searchString,
                                           const char* replaceString, int caseSensitive,
                                           int startIndex, int replaceAll);
extern const char* ModelicaStrings_substring(const char* string1, int index, int length);
extern const char* ModelicaStrings_toLower(const char* string1);
extern const char* ModelicaStrings_toUpper(const char* string1);


