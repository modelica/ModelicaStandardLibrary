/* External utility functions for Modelica package
   Modelica.Functions.Strings.

   Release Notes:
      Aug. 19, 2004: by Martin Otter, DLR.
                     Changed according the decisions of the 37th 
                     design meeting in Lund (see minutes)
                     
      Jan.  7, 2002: by Martin Otter, DLR.
                     Implemented a first version

   Copyright (C) 2002-2004, Modelica Association and DLR.

   The content of this file is free software; it can be redistributed 
   and/or modified under the terms of the Modelica license, see the 
   license conditions and the accompanying disclaimer in file
   ModelicaLicense.txt or in Modelica.UsersGuide.ModelicaLicense. 
*/

#include <ctype.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>


#include "ModelicaStrings.h"
#include "ModelicaUtilities.h"

/* Utilities ------------------------------------------------------- */
   int ModelicaStrings_countIgnoreCase(const char* string, const char* searchString);
   int ModelicaStrings_isEqualIgnoreCase(const char* string1, const char* string2);
   const char* ModelicaStrings_replaceIgnoreCase(const char* string, const char* searchString,
                                                 const char* replaceString,
                                                 int startIndex, int replaceAll);

   #define BUFFER_LENGTH 1000
   static char buffer[BUFFER_LENGTH];  /* Buffer for temporary storage */
   #define BUFFER_LENGTH2 1000
   static char buffer2[BUFFER_LENGTH2];  /* Buffer2 for temporary storage */

   #undef max
   #define max(x,y) ((x) > (y) ? (x) : (y) )

  static void copyToBufferWithLowerCase
                   (const char*  string1   , const char* string2,
                    const char** bufString1, int* lenString1,
                    const char** bufString2, int* lenString2) {
    /* Copies "string1" and "string2" to the static buffer
       and transforms all letters to lower case. The function returns:
          bufString1, bufString2: pointers to the copied strings
          lenString1, lenString2: lengths of the strings
    */

    /* Get index of first occurrence of searchString in string ignoring case */
       int len1 = strlen(string1);
       int len2 = strlen(string2);
       char* str1;
       char* str2;

    /* Check whether buffer is big enough */
       if ( len1 + len2 + 2 > BUFFER_LENGTH )
          ModelicaFormatError("Internal buffer is too small (= %d) to hold the "
                        "requested %d characters", BUFFER_LENGTH, len1+len2+2);

    /* Define return arguments */
       str1 = buffer;
       str2 = buffer + len1 + 1;
       *bufString1 = str1;
       *bufString2 = str2;
       *lenString1 = len1;
       *lenString2 = len2;

    /* Copy strings to buffer */
       strcpy(str1, string1);
       strcpy(str2, string2);

    /* Transform to lower case letters */
       while ( *str1++ = tolower(*string1++) );
       while ( *str2++ = tolower(*string2++) );
  }


/* Functions ------------------------------------------------------- */


const char* ModelicaStrings_character(const char* string1, int index) {
  /* Get character of string1 at position index */

  char* ch;
  int   len1 = strlen(string1);

  if ( index < 1 || index > len1 ) {
     ch    = ModelicaAllocateString(0);
     ch[0] = '\0';
  } else {
     ch    = ModelicaAllocateString(1);
     ch[0] = string1[index-1];
     ch[1] = '\0';
  }

  return (const char*) ch;
};


int ModelicaStrings_count(const char* string, const char* searchString, int caseSensitive) {
  /* Count the number of occurrences of "searchString" in "string" */
     char* found;
     int   offset;
     int   count = 0;

     if ( caseSensitive == 0 ) return ModelicaStrings_countIgnoreCase(string, searchString);

     offset = strlen(searchString);
     while ( found = strstr(string, searchString) ) {
        count++;
        string = found + offset;
     }
     return count;
};


int ModelicaStrings_countIgnoreCase(const char* string, const char* searchString) {
  /* Count the number of occurrences of "searchString" in "string" ignoring case */
     char* found;
     int   count = 0;
     char* s1;
     char* s2;
     int   len1;
     int   len2;
     copyToBufferWithLowerCase(string, searchString, &s1, &len1, &s2, &len2);
     while ( found = strstr(s1, s2) ) {
        count++;
        s1 = found + len2;
     }
     return count;
};


int ModelicaStrings_find(const char* string, const char* searchString, 
                         int caseSensitive, int startIndex) {
  /* Get index of first occurrence of searchString in string
     starting at startIndex 
  */
     char* first = string;
     char* s1;
     char* s2;
     int   equal;

  // Find startIndex position
     while ( --startIndex ) {
       if ( *first == '\0' ) return 0;
       first++;
     }

  // Compare searchString with string
     if ( caseSensitive == 0 ) {
        while ( *first ) {
          s1 = first;
          s2 = searchString;
          equal = 0;
          while ( *s1 && *s2 ) {
            if ( tolower(*s1) != tolower(*s2) ) break;
            equal = 1;
          }
          if ( equal == 1) break;
          first++;
        }
     } else {
        while ( *first ) {
          s1 = first;
          s2 = searchString;
          equal = 0;
          while ( *s1 && *s2 ) {
            if ( *s1 != *s2 ) break;
            equal = 1;
          }
          if ( equal == 1) break;
          first++;
        }
     } 
     if ( equal == 1 ) return (first - string + 1); 
     return 0;
};


int ModelicaStrings_isEmpty(const char* string) {
   /* Return true, if empty string (no characters) */
   return (*string == '\0' ? 1 : 0);
};


int ModelicaStrings_isEqual(const char* string1, const char* string2, int caseSensitive) {
  /* Compare whether two strings are identical */

  if ( caseSensitive == 0 ) return ModelicaStrings_isEqualIgnoreCase(string1, string2);
  return ( strcmp(string1, string2) == 0 ? 1 : 0 );
};


int ModelicaStrings_isEqualIgnoreCase(const char* string1, const char* string2) {
  /* Compare whether two strings are identical ignoring case */

  char* c1 = (char*) string1;
  char* c2 = (char*) string2;

  if ( strlen(string1) != strlen(string2) ) return 0;
  while ( *c1 ) {
     if ( tolower(*c1) != tolower(*c2) ) return 0;
     c1++; c2++;
  }
  return 1;
};


const char* ModelicaStrings_repeat(int n, const char* string1) {
  /* Create string with n occurences of string1 */

  char* c = ModelicaAllocateString(n*strlen(string1));
  char* repeatedString = c;
  char* str;

  while ( n-- ) {
    str = string1;
    while (*str) {
      *c++ = *str++;
    }
  }
  *c = '\0';
  return (const char*) repeatedString;
};


const char* ModelicaStrings_replace(const char* string, const char* searchString,
                                    const char* replaceString, int caseSensitive,
                                    int startIndex, int replaceAll) {
  /* Replace all occurrences of 'searchString' in 'string' with 'replaceString' */

 if ( caseSensitive == 0  ) return 
    ModelicaStrings_replaceIgnoreCase(string, searchString, replaceString, startIndex, replaceAll);
 {
     int lenString      = strlen(string);
     int lenSearch      = strlen(searchString);
     int lenWith        = strlen(replaceString);
     int count          = ModelicaStrings_count(string, searchString, caseSensitive);
     int lenResult      = lenString + count*(lenWith - lenSearch);
     char* res          = ModelicaAllocateString(lenResult);
     const char* result = (const char*) res;

  /* Copy string and replace occurrences of searchString */
     if ( count == 0 ) {
        strcpy(res, string);
     } else {
        char* found;
        const char* c;
        int   n;
        while ( found = strstr(string, searchString) ) {
           n = found - string;
           while ( n-- && (*res++ = *string++) );
           n = lenWith;
           c = replaceString;
           while ( n-- && (*res++ = *c++) );
           string = string + lenSearch;
        }
        while ( *res++ = *string++ );
     }
     return result;
 }
};


const char* ModelicaStrings_replaceIgnoreCase(const char* string, const char* searchString,
                                              const char* replaceString,
                                              int startIndex, int replaceAll) {
  /* Replace all occurrences of 'searchString' in 'string' with 'replaceString'
     ignoring case
  */
     char* s1;
     char* s2;
     int   len1;
     int   len2;
     int   lenWith = strlen(replaceString);
     int   count;
     int   lenResult;
     char* res;
     const char *result;

     copyToBufferWithLowerCase(string, searchString, &s1, &len1, &s2, &len2);
     count     = ModelicaStrings_count(s1, s2, 1);
     lenResult = len1 + count*(lenWith - len2);
     res       = ModelicaAllocateString(lenResult);
     result    = (const char*) res;

  /* Copy string and replace occurrences of searchString */
     if ( count == 0 ) {
        strcpy(res, string);
     } else {
        char* found;
        const char* c;
        int   n;
        while ( found = strstr(s1, s2) ) {
           n = found - s1;
           while ( n-- && (*res++ = *string++) );
           n = lenWith;
           c = replaceString;
           while ( n-- && (*res++ = *c++) );
           s1     = found  + len2;
           string = string + len2;
        }
        while ( *res++ = *string++ );
     }
     return result;
};


const char* ModelicaStrings_substring(const char* string1, int index, int length) {
  /* Get string1(index:index+length-1), or less characters if string end
     reached, or empty string if index is out of range
  */
     char* string2;
     int len1 = strlen(string1);
     int len2;

  /* Check arguments */
     if ( length < 1 || index < 1 || index > len1 ) {
        /* Return empty string */
           string2 = ModelicaAllocateString(0);
           string2[0] = '\0';
           return (const char*) string2;
     }

  /* Generate and copy substring */
     len2 = (index+length-1 > len1 ? len1-index+1 : length);
     string2 = ModelicaAllocateString(len2);
     strncpy(string2, &string1[index-1], len2);
     string2[len2] = '\0';
     return (const char*) string2;
};


const char* ModelicaStrings_toLower(const char* string1) {
  /* Convert string to lower case */

  const char* string2 = ModelicaAllocateString(strlen(string1));
  char* c1 = (char*) string1;
  char* c2 = (char*) string2;

  while ( *c2++ = tolower(*c1++) );
  return string2;
};


const char* ModelicaStrings_toUpper(const char* string1) {
  /* Convert string to upper case */

  const char* string2 = ModelicaAllocateString(strlen(string1));
  char* c1 = (char*) string1;
  char* c2 = (char*) string2;

  while ( *c2++ = toupper(*c1++) );
  return string2;
};
