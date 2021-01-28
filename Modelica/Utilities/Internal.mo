within Modelica.Utilities;
package Internal
  "Internal components that a user should usually not directly utilize"
  extends Modelica.Icons.InternalPackage;
  import Modelica.Units.SI;
package PartialModelicaServices
    "Interfaces of components requiring a tool specific implementation"
    extends Modelica.Icons.InternalPackage;
  package Animation "Models and functions for 3-dim. animation"
    extends Modelica.Icons.Package;
  partial model PartialShape "Interface for 3D animation of elementary shapes"

    import Modelica.Mechanics.MultiBody.Frames;
    import Modelica.Mechanics.MultiBody.Types;

    parameter Types.ShapeType shapeType="box"
      "Type of shape (box, sphere, cylinder, pipecylinder, cone, pipe, beam, gearwheel, spring, <external shape>)";
    input Frames.Orientation R=Frames.nullRotation()
      "Orientation object to rotate the world frame into the object frame" annotation(Dialog);
    input SI.Position r[3]={0,0,0}
      "Position vector from origin of world frame to origin of object frame, resolved in world frame" annotation(Dialog);
    input SI.Position r_shape[3]={0,0,0}
      "Position vector from origin of object frame to shape origin, resolved in object frame" annotation(Dialog);
    input Real lengthDirection[3](each final unit="1")={1,0,0}
      "Vector in length direction, resolved in object frame" annotation(Dialog);
    input Real widthDirection[3](each final unit="1")={0,1,0}
      "Vector in width direction, resolved in object frame" annotation(Dialog);
    input SI.Length length=0 "Length of visual object" annotation(Dialog);
    input SI.Length width=0 "Width of visual object" annotation(Dialog);
    input SI.Length height=0 "Height of visual object" annotation(Dialog);
    input Types.ShapeExtra extra=0.0
      "Additional size data for some of the shape types" annotation(Dialog);
    input Real color[3]={255,0,0} "Color of shape" annotation(Dialog(colorSelector=true));
    input Types.SpecularCoefficient specularCoefficient = 0.7
      "Reflection of ambient light (= 0: light is completely absorbed)" annotation(Dialog);

    annotation (
      Documentation(info="<html>
<p>
This model is documented at
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape\">Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape</a>.
</p>
</html>"));

  end PartialShape;

    partial model PartialVector "Interface for 3D animation of a vector quantity (force, torque etc)"
      import Modelica.Mechanics.MultiBody.Types;
      import Modelica.Mechanics.MultiBody.Frames;

      input Frames.Orientation R=Frames.nullRotation()
        "Orientation object to rotate the world frame into the vector frame" annotation(Dialog);
      input SI.Position r[3]={0,0,0}
        "Position vector from origin of world frame to origin of vector frame, resolved in world frame" annotation(Dialog);
      input Real coordinates[3]={0,0,0}
        "Coordinates of the vector resolved in vector frame" annotation(Dialog);
      input Types.Color color=Types.Defaults.ArrowColor
        "Color of vector" annotation(Dialog(colorSelector=true));
      input Types.SpecularCoefficient specularCoefficient = 0.7
        "Material property describing the reflecting of ambient light (= 0 means, that light is completely absorbed)" annotation(Dialog);
      parameter Types.VectorQuantity quantity = Types.VectorQuantity.Force "Quantity of the coordinates";
      input Boolean headAtOrigin=false "= true, if the vector is pointing towards the origin of vector frame" annotation(Dialog);
      input Boolean twoHeadedArrow=false "= true, if the arrow has two heads after each other (pointing in the same direction)" annotation(Dialog);

      annotation (
        Documentation(info="<html>
<p>
This model is documented at
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Vector\">Modelica.Mechanics.MultiBody.Visualizers.Advanced.Vector</a>.
</p>
</html>"));
    end PartialVector;

    partial model PartialSurface "Interface for 3D animation of surfaces"

      import Modelica.Mechanics.MultiBody.Frames;
      import Modelica.Mechanics.MultiBody.Types;

      input Frames.Orientation R=Frames.nullRotation()
        "Orientation object to rotate the world frame into the surface frame"
        annotation(Dialog(group="Surface frame"));
      input SI.Position r_0[3]={0,0,0}
        "Position vector from origin of world frame to origin of surface frame, resolved in world frame"
        annotation(Dialog(group="Surface frame"));

      parameter Integer nu=2 "Number of points in u-Dimension" annotation(Dialog(group="Surface properties"));
      parameter Integer nv=2 "Number of points in v-Dimension" annotation(Dialog(group="Surface properties"));
      replaceable function surfaceCharacteristic =
        Modelica.Mechanics.MultiBody.Interfaces.partialSurfaceCharacteristic
        "Function defining the surface characteristic"
        annotation(choicesAllMatching=true,Dialog(group="Surface properties"));

      parameter Boolean wireframe=false "= true: 3D model will be displayed without faces"
        annotation (Dialog(group="Material properties"),choices(checkBox=true));
      parameter Boolean multiColoredSurface=false "= true: Color is defined for each surface point"
        annotation(Dialog(group="Material properties"),choices(checkBox=true));
      input Real color[3]={255,0,0} "Color of surface" annotation(Dialog(colorSelector=true,group="Material properties", enable=not multiColoredSurface));
      input Types.SpecularCoefficient specularCoefficient = 0.7
        "Reflection of ambient light (= 0: light is completely absorbed)"
        annotation(Dialog(group="Material properties"));
      input Real transparency=0 "Transparency of shape: 0 (= opaque) ... 1 (= fully transparent)"
        annotation(Dialog(group="Material properties"));

      annotation (Documentation(info="<html>
<p>
This model is documented at
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface\">Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface</a>.
</p>
</html>"));
    end PartialSurface;
  end Animation;

  package ExternalReferences "Functions to access external resources"
    extends Modelica.Icons.InternalPackage;
    partial function PartialLoadResource
        "Interface for tool specific function to return the absolute path name of a URI or local file name"
      extends Modelica.Icons.Function;
      input String uri "URI or local file name";
      output String fileReference "Absolute path name of file";
      annotation (Documentation(info="<html>
<p>
This partial function defines the function interface of a tool-specific implementation
in package ModelicaServices. The interface is documented at
<a href=\"modelica://Modelica.Utilities.Files.loadResource\">Modelica.Utilities.Internal.FileSystem.loadResource</a>.
</p>

</html>"));
    end PartialLoadResource;
  end ExternalReferences;

  package System "System dependent functions"
    extends Modelica.Icons.InternalPackage;
    partial function exitBase "Interface for tool specific function to terminate the execution of the Modelica environment"
      extends Modelica.Icons.Function;
      input Integer status=0 "Result to be returned by environment (0 means success)";
      annotation (Documentation(info="<html>
<p>
This partial function defines the function interface of a tool-specific implementation
in package ModelicaServices.
</p>
</html>"));
    end exitBase;
  end System;
    annotation (Documentation(info="<html>

<p>
This package contains interfaces of a set of functions and models used in the
Modelica Standard Library that requires a <strong>tool specific implementation</strong>.
There is an associated package called <strong>ModelicaServices</strong>. A tool vendor
should provide a proper implementation of this library for the corresponding
tool. The default implementation is \"do nothing\".
In the Modelica Standard Library, the models and functions of ModelicaServices
are used.
</p>
</html>"));
end PartialModelicaServices;

package FileSystem
    "Internal package with external functions as interface to the file system"
 extends Modelica.Icons.InternalPackage;

  impure function mkdir "Make directory (POSIX: 'mkdir')"
    extends Modelica.Icons.Function;
    input String directoryName "Make a new directory";
  external "C" ModelicaInternal_mkdir(directoryName) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaInternal.h\"", Library="ModelicaExternalC");
  end mkdir;

  impure function rmdir "Remove empty directory (POSIX function 'rmdir')"
    extends Modelica.Icons.Function;
    input String directoryName "Empty directory to be removed";
  external "C" ModelicaInternal_rmdir(directoryName) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaInternal.h\"", Library="ModelicaExternalC");
  end rmdir;

  impure function stat "Inquire file information (POSIX function 'stat')"
    extends Modelica.Icons.Function;
    input String name "Name of file, directory, pipe etc.";
    output Types.FileType fileType "Type of file";
  external "C" fileType = ModelicaInternal_stat(name) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaInternal.h\"", Library="ModelicaExternalC");
  end stat;

  impure function rename "Rename existing file or directory (C function 'rename')"
    extends Modelica.Icons.Function;
    input String oldName "Current name";
    input String newName "New name";
  external "C" ModelicaInternal_rename(oldName, newName) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaInternal.h\"", Library="ModelicaExternalC");
  end rename;

  impure function removeFile "Remove existing file (C function 'remove')"
    extends Modelica.Icons.Function;
    input String fileName "File to be removed";
  external "C" ModelicaInternal_removeFile(fileName) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaInternal.h\"", Library="ModelicaExternalC");
  end removeFile;

  impure function copyFile
      "Copy existing file (C functions 'fopen', 'fread', 'fwrite', 'fclose')"
    extends Modelica.Icons.Function;
    input String fromName "Name of file to be copied";
    input String toName "Name of copy of file";
  external "C" ModelicaInternal_copyFile(fromName, toName) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaInternal.h\"", Library="ModelicaExternalC");
  end copyFile;

  impure function readDirectory
      "Read names of a directory (POSIX functions opendir, readdir, closedir)"
    extends Modelica.Icons.Function;
    input String directory
        "Name of the directory from which information is desired";
    input Integer nNames
        "Number of names that are returned (inquire with getNumberOfFiles)";
    output String names[nNames]
        "All file and directory names in any order from the desired directory";
    external "C" ModelicaInternal_readDirectory(directory,nNames,names) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaInternal.h\"", Library="ModelicaExternalC");
  end readDirectory;

  impure function getNumberOfFiles
      "Get number of files and directories in a directory (POSIX functions opendir, readdir, closedir)"
    extends Modelica.Icons.Function;
    input String directory "Directory name";
    output Integer result
        "Number of files and directories present in 'directory'";
    external "C" result = ModelicaInternal_getNumberOfFiles(directory) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaInternal.h\"", Library="ModelicaExternalC");
  end getNumberOfFiles;

  annotation (
Documentation(info="<html>
<p>
Package <strong>Internal.FileSystem</strong> is an internal package that contains
low level functions as interface to the file system.
These functions should not be called directly in a scripting
environment since more convenient functions are provided
in packages <a href=\"modelica://Modelica.Utilities.Files\">Files</a> and <a href=\"modelica://Modelica.Utilities.System\">System</a>.
</p>
<p>
Note, the functions in this package are direct interfaces to
functions of POSIX and of the standard C library. Errors
occurring in these functions are treated by triggering
a Modelica assert. Therefore, the functions in this package
return only for a successful operation. Furthermore, the
representation of a string is hidden by this interface,
especially if the operating system supports Unicode characters.
</p>
</html>"));
end FileSystem;

  package Time "Internal package with external functions as interface to date and time"
    extends Modelica.Icons.InternalPackage;

    pure function diffTime "Convert local time to elapsed seconds since custom epoch year"
      extends Modelica.Icons.Function;
      input Integer ms "Millisecond";
      input Integer sec "Second";
      input Integer min "Minute";
      input Integer hour "Hour";
      input Integer day "Day";
      input Integer mon "Month";
      input Integer year "Year";
      input Integer epoch_year = 1970 "Reference year";
      output Real seconds "Elapsed seconds since start of epoch_year in the current time zone";
      external "C" seconds = ModelicaTime_difftime(ms, sec, min, hour, day, mon, year, epoch_year)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaTime.c\"");
      annotation (Documentation(info="<html>
TODO
</html>"));
    end diffTime;

    impure function getTime "Retrieve the local time (in the local time zone)"
      extends Modelica.Icons.Function;
      output Integer ms "Millisecond";
      output Integer sec "Second";
      output Integer min "Minute";
      output Integer hour "Hour";
      output Integer day "Day";
      output Integer mon "Month";
      output Integer year "Year";
      external "C" ModelicaInternal_getTime(ms, sec, min, hour, day, mon, year)
        annotation(Library="ModelicaExternalC");
      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
(ms, sec, min, hour, day, mon, year) = Internal.Time.<strong>getTime</strong>();
</pre></blockquote>
<h4>Description</h4>
<p>
Returns the local time at the time instant this function was called.
All returned values are of type Integer and have the following meaning:
</p>

<blockquote>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Argument</th>
    <th>Range</th>
    <th>Description</th></tr>

<tr><td>ms</td> <td>0&nbsp;&hellip;&nbsp;999</td>
    <td>Milli-seconds after seconds</td></tr>

<tr><td>sec</td> <td>0&nbsp;&hellip;&nbsp;59</td>
    <td>Seconds after minute</td></tr>

<tr><td>min</td> <td>0&nbsp;&hellip;&nbsp;59</td>
    <td>Minutes after hour</td></tr>

<tr><td>hour</td> <td>0&nbsp;&hellip;&nbsp;23</td>
    <td>Hours after midnight</td></tr>

<tr><td>day</td> <td>1&nbsp;&hellip;&nbsp;31</td>
    <td>Day of month</td></tr>

<tr><td>mon</td> <td>1&nbsp;&hellip;&nbsp;12</td>
    <td>Current month</td></tr>

<tr><td>year</td> <td>&ge; 1970</td>
    <td>Current year</td></tr>
</table>
</blockquote>

<h4>Example</h4>
<blockquote><pre>
(ms, sec, min, hour, mon, year) = getTime()   // = (281, 30, 13, 10, 15, 2, 2015)
                                              // Feb. 15, 2015 at 10:13 after 30.281 s
</pre></blockquote>
<h4>Note</h4>
<p>This function is impure!</p>
</html>",   revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end getTime;

    pure function localTime "Retrieve the local time (in the local time zone) from elapsed seconds since reference year"
      extends Modelica.Icons.Function;
      input Real seconds "Elapsed seconds since epoch_year";
      input Integer epoch_year = 1970 "Reference year";
      output Integer ms "Millisecond";
      output Integer sec "Second";
      output Integer min "Minute";
      output Integer hour "Hour";
      output Integer day "Day";
      output Integer mon "Month";
      output Integer year "Year";
      external "C90" ModelicaTime_localtime(ms, sec, min, hour, day, mon, year, seconds, epoch_year)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaTime.c\"");
      annotation (Documentation(info="<html>
TODO
</html>"));
    end localTime;

    pure function stringToTime "Retrieve the local time (in the local time zone) from formatted string"
      extends Modelica.Icons.Function;
      input String str "Formatted date and time string";
      input String format = "%Y-%m-%d %H:%M:%S" "Format string passed to strptime";
      output Integer ms "Millisecond";
      output Integer sec "Second";
      output Integer min "Minute";
      output Integer hour "Hour";
      output Integer day "Day";
      output Integer mon "Month";
      output Integer year "Year";
      external "C" ModelicaTime_strptime(ms, sec, min, hour, day, mon, year, str, format)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaTime.c\"");
      annotation (Documentation(info="<html>
TODO
</html>"));
    end stringToTime;

    pure function timeToString "Convert the local time (in the local time zone) to string"
      extends Modelica.Icons.Function;
      input Integer ms "Millisecond";
      input Integer sec "Second";
      input Integer min "Minute";
      input Integer hour "Hour";
      input Integer day "Day";
      input Integer mon "Month";
      input Integer year "Year";
      input String format = "%Y-%m-%d %H:%M:%S" "Format string passed to strftime";
      input Integer maxSize = 128 "Maximal length of formatted string";
      output String str "Formatted date and time string";
      external "C" str = ModelicaTime_strftime(ms, sec, min, hour, day, mon, year, format, maxSize)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaTime.c\"");
      annotation (Documentation(info="<html>
TODO
</html>"));
    end timeToString;

    function dayOfWeek "Return day of week for given date"
      extends Modelica.Icons.Function;
      input Integer year "Year";
      input Integer mon=1 "Month";
      input Integer day=1 "Day of month";
      output Integer dow(min=1, max=7) "Day of week: 1 = Monday, ..., 6 = Saturday, 7 = Sunday";
    protected
      constant Integer t[:] = {0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4};
      Integer y = year;
    algorithm
      assert(mon >= 1 and mon <= 12, "Month is out of range.");
      if mon < 3 then
        y := y - 1;
      end if;
      dow := mod(y + div(y, 4) - div(y, 100) + div(y, 400) + t[mon] + day, 7);
      // One-based indexing: Sunday is 7
      if dow == 0 then
        dow := 7;
      end if;
      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
dow = Internal.Time.<strong>dayOfWeek</strong>(year, mon, day);
</pre></blockquote>
<h4>Description</h4>
<p>
Returns the day of the week for a given date using Tomohiko Sakamoto's algorithm.
The returned Integer number of <code>dow</code> has the following meaning:
</p>

<blockquote>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Day of week</th>
    <th>Number</th></tr>

<tr><td>Monday</td> <td>1</td></tr>

<tr><td>Tuesday</td> <td>2</td></tr>

<tr><td>Wednesday</td> <td>3</td></tr>

<tr><td>Thursday</td> <td>4</td></tr>

<tr><td>Friday</td> <td>5</td></tr>

<tr><td>Saturday</td> <td>6</td></tr>

<tr><td>Sunday</td> <td>7</td></tr>

</table>
</blockquote>

<h4>Example</h4>
<blockquote><pre>
dow = dayOfWeek(2019, 12, 6) // = 5
                             // Dec. 06, 2019 (Saint Nicholas Day) is a Friday
dow = dayOfWeek(2020)        // = 3
                             // Jan. 01, 2020 (New Year's Day) is a Wednesday
</pre></blockquote>
</html>"));
    end dayOfWeek;

  annotation (
Documentation(info="<html>
<p>
Package <strong>Internal.Time</strong> is an internal package that contains
low level functions as interface to date and time.
These functions should not be called directly in a scripting
environment since more convenient functions are provided
in package <a href=\"modelica://Modelica.Utilities.Time\">Time</a>.
</p>
</html>"));
  end Time;
end Internal;
