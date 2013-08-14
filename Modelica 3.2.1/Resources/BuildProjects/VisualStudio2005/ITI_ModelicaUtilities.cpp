/**
 * ITI_ModelicaUtilities.cpp
 * ITI specific utility functions which can be called by external Modelica functions.
 * Copyright (c) ITI GmbH Germany
 * All rights reserved.
**/

#include <windows.h>
#include <stdio.h>
#include <ctype.h>
extern "C"
{
#include "../../C-Sources/ModelicaUtilities.h"
}

typedef void (*PFUNC_ModelicaMessage)(const char* string);
typedef void (*PFUNC_ModelicaError)(const char* string);
typedef char* (*PFUNC_ModelicaAllocateString)(size_t len);
typedef void (*PFUNC_ModelicaFreeAllAllocatedStrings)();
typedef void (*PFUNC_ModelicaTrace)(int tab, int kind, const char* caption, const char* text);

char* Trim(char* s);
void ModelicaFreeAllAllocatedStrings();
void ModelicaTrace(int tab, int kind, const char* caption, const char* text);

char* Trim(char* s) {
	char* ptr;
	if (!s)
	{
		return NULL;
	}
	if (!*s)
	{
		return s;
	}
	for (ptr = s + strlen(s) - 1; (ptr >= s) && (isspace(*ptr) || *ptr == '\n'); --ptr);
	ptr[1] = '\0';
	return s;
}

void ModelicaMessage(const char* string)
{
	PFUNC_ModelicaMessage ITI_ModelicaMessage = NULL;
	HINSTANCE hInstModelicaExternalC = LoadLibrary(TEXT("ModelicaExternalC.dll"));
	if (hInstModelicaExternalC)
	{
		ITI_ModelicaMessage = (PFUNC_ModelicaMessage) GetProcAddress(hInstModelicaExternalC, "ModelicaMessage");
	}

	if (ITI_ModelicaMessage)
	{
		char* buf = ModelicaAllocateString(strlen(string) + 1);
		if (buf)
		{
			strcpy(buf, string);
			Trim(buf);
			ITI_ModelicaMessage(buf);
		}
		else
		{
			printf(string);
		}
	}
	else
	{
		printf(string);
	}

	if (hInstModelicaExternalC)
	{
		FreeLibrary(hInstModelicaExternalC);
		hInstModelicaExternalC = NULL;
		ITI_ModelicaMessage = NULL;
	}
}

void ModelicaFormatMessage(const char* string, ...)
{
	va_list args;
	va_start(args, string);
	ModelicaVFormatMessage(string, args);
	va_end(args);
}

void ModelicaVFormatMessage(const char* string, va_list args)
{
	PFUNC_ModelicaMessage ITI_ModelicaMessage = NULL;
	HINSTANCE hInstModelicaExternalC = LoadLibrary(TEXT("ModelicaExternalC.dll"));
	if (hInstModelicaExternalC)
	{
		ITI_ModelicaMessage = (PFUNC_ModelicaMessage) GetProcAddress(hInstModelicaExternalC, "ModelicaMessage");
	}

	if (ITI_ModelicaMessage)
	{
		size_t count = 128;
		char* buf = NULL;
		int charsWritten;

		buf = (char*) malloc((count + 1)*sizeof(char));
		while ((charsWritten = vsnprintf(buf, count, string, args)) == -1)
		{
			count *= 2;
			buf = (char*) realloc((void*) buf, (count + 1)*sizeof(char));
		}

		buf[charsWritten] = '\0';
		count = strlen(buf) + 1;
		char* buf2 = ModelicaAllocateString(count);
		if (buf2)
		{
			strcpy(buf2, buf);
			free(buf);
			Trim(buf2);
			ITI_ModelicaMessage(buf2);
		}
		else
		{
			free(buf);
			vprintf(string, args);
		}
	}
	else
	{
		vprintf(string, args);
	}

	if (hInstModelicaExternalC)
	{
		FreeLibrary(hInstModelicaExternalC);
		hInstModelicaExternalC = NULL;
		ITI_ModelicaMessage = NULL;
	}
}

void ModelicaError(const char* string)
{
	PFUNC_ModelicaError ITI_ModelicaError = NULL;
	HINSTANCE hInstModelicaExternalC = LoadLibrary(TEXT("ModelicaExternalC.dll"));
	if (hInstModelicaExternalC)
	{
		ITI_ModelicaError = (PFUNC_ModelicaError) GetProcAddress(hInstModelicaExternalC, "ModelicaError");
	}

	if (ITI_ModelicaError)
	{
		char* buf = ModelicaAllocateString(strlen(string) + 1);
		if (buf)
		{
			strcpy(buf, string);
			Trim(buf);
			ITI_ModelicaError(buf);
		}
		else
		{
			printf(string);
		}
	}
	else
	{
		printf(string);
	}

	if (hInstModelicaExternalC)
	{
		FreeLibrary(hInstModelicaExternalC);
		hInstModelicaExternalC = NULL;
		ITI_ModelicaError = NULL;
	}
}

void ModelicaFormatError(const char* string, ...)
{
	va_list args;
	va_start(args, string);
	ModelicaVFormatError(string, args);
	va_end(args);
}

void ModelicaVFormatError(const char* string, va_list args)
{
	PFUNC_ModelicaError ITI_ModelicaError = NULL;
	HINSTANCE hInstModelicaExternalC = LoadLibrary(TEXT("ModelicaExternalC.dll"));
	if (hInstModelicaExternalC)
	{
		ITI_ModelicaError = (PFUNC_ModelicaError) GetProcAddress(hInstModelicaExternalC, "ModelicaError");
	}

	if (ITI_ModelicaError)
	{
		size_t count = 128;
		char* buf = NULL;
		int charsWritten;

		buf = (char*) malloc((count + 1)*sizeof(char));
		while ((charsWritten = vsnprintf(buf, count, string, args)) == -1)
		{
			count *= 2;
			buf = (char*) realloc((void*) buf, (count + 1)*sizeof(char));
		}

		buf[charsWritten] = '\0';
		count = strlen(buf) + 1;
		char* buf2 = ModelicaAllocateString(count);
		if (buf2)
		{
			strcpy(buf2, buf);
			free(buf);
			Trim(buf2);
			ITI_ModelicaError(buf2);
		}
		else
		{
			free(buf);
			vprintf(string, args);
		}
	}
	else
	{
		vprintf(string, args);
	}

	if (hInstModelicaExternalC)
	{
		FreeLibrary(hInstModelicaExternalC);
		hInstModelicaExternalC = NULL;
		ITI_ModelicaError = NULL;
	}
}

char* ModelicaAllocateString(size_t len)
{
	PFUNC_ModelicaAllocateString ITI_ModelicaAllocateString = NULL;
	char* res = NULL;
	HINSTANCE hInstModelicaExternalC = LoadLibrary(TEXT("ModelicaExternalC.dll"));
	if (hInstModelicaExternalC)
	{
		ITI_ModelicaAllocateString = (PFUNC_ModelicaAllocateString) GetProcAddress(hInstModelicaExternalC, "ModelicaAllocateString");
	}

	if (ITI_ModelicaAllocateString)
	{
		res = ITI_ModelicaAllocateString(len);
	}

	if (hInstModelicaExternalC)
	{
		FreeLibrary(hInstModelicaExternalC);
		hInstModelicaExternalC = NULL;
		ITI_ModelicaAllocateString = NULL;
	}

	return res;
}

char* ModelicaAllocateStringWithErrorReturn(size_t len)
{
	PFUNC_ModelicaAllocateString ITI_ModelicaAllocateString = NULL;
	char* res = NULL;
	HINSTANCE hInstModelicaExternalC = LoadLibrary(TEXT("ModelicaExternalC.dll"));
	if (hInstModelicaExternalC)
	{
		ITI_ModelicaAllocateString = (PFUNC_ModelicaAllocateString) GetProcAddress(hInstModelicaExternalC, "ModelicaAllocateStringWithErrorReturn");
	}

	if (ITI_ModelicaAllocateString)
	{
		res = ITI_ModelicaAllocateString(len);
	}

	if (hInstModelicaExternalC)
	{
		FreeLibrary(hInstModelicaExternalC);
		hInstModelicaExternalC = NULL;
		ITI_ModelicaAllocateString = NULL;
	}

	return res;
}

void ModelicaFreeAllAllocatedStrings()
{
	PFUNC_ModelicaFreeAllAllocatedStrings ITI_ModelicaFreeAllAllocatedStrings = NULL;
	HINSTANCE hInstModelicaExternalC = LoadLibrary(TEXT("ModelicaExternalC.dll"));
	if (hInstModelicaExternalC)
	{
		ITI_ModelicaFreeAllAllocatedStrings = (PFUNC_ModelicaFreeAllAllocatedStrings) GetProcAddress(hInstModelicaExternalC, "ModelicaFreeAllAllocatedStrings");
	}

	if (ITI_ModelicaFreeAllAllocatedStrings)
	{
		ITI_ModelicaFreeAllAllocatedStrings();
	}

	if (hInstModelicaExternalC)
	{
		FreeLibrary(hInstModelicaExternalC);
		hInstModelicaExternalC = NULL;
		ITI_ModelicaFreeAllAllocatedStrings = NULL;
	}
}

void ModelicaTrace(int tab, int kind, const char* caption, const char* text)
{
	PFUNC_ModelicaTrace ITI_ModelicaTrace = NULL;
	HINSTANCE hInstGlobalHlp = LoadLibrary(TEXT("globalHlp.dll"));
	if (hInstGlobalHlp)
	{
		ITI_ModelicaTrace = (PFUNC_ModelicaTrace) GetProcAddress(hInstGlobalHlp, "OutputTraceMessageA");
	}

	if (ITI_ModelicaTrace)
	{
		char* buf = ModelicaAllocateString(strlen(text) + 1);
		if (buf)
		{
			strcpy(buf, text);
			Trim(buf);
			ITI_ModelicaTrace(tab, kind, caption, buf);
		}
		else
		{
			printf("%s: %s\n", caption, text);
		}
	}
	else
	{
		printf("%s: %s\n", caption, text);
	}

	if (hInstGlobalHlp)
	{
		FreeLibrary(hInstGlobalHlp);
		hInstGlobalHlp = NULL;
		ITI_ModelicaTrace = NULL;
	}
}
