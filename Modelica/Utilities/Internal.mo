within Modelica.Utilities;
package Internal
  "Internal components that a user should usually not directly utilize"
  extends Modelica.Icons.InternalPackage;
  import Modelica.Units.SI;

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
in packages Files and Systems.
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
end Internal;
