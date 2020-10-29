#include "../../Modelica/Resources/C-Sources/ModelicaTime.h"
#include "Common.c"

#include <assert.h>
#include <string.h>

int main(int argc, char **argv) {
    int ms = 501;
    int sec = 30;
    int min = 44;
    int hour = 20;
    int mday = 29;
    int mon = 10;
    int year = 2020;
    const char *format = "%Y-%m-%d %H:%M:%S.%L";
    int maxSize = 128;
    const char *dateStr = ModelicaTime_strftime(ms, sec, min, hour, mday, mon, year, format, maxSize);
    ModelicaFormatMessage("Date: %s\n", dateStr);
    assert(0 == strcmp("2020-10-29 20:44:30.501", dateStr));
    ModelicaTime_strptime(&ms, &sec, &min, &hour, &mday, &mon, &year, "2000-09-30 06:45:01.123", format);
    assert(ms == 123);
    assert(sec == 1);
    assert(min == 45);
    assert(hour == 6);
    assert(mday == 30);
    assert(mon == 9);
    assert(year == 2000);
    return 0;
}
