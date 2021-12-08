within ModelicaServices;

package Interfaces
  "Interfaces of components requiring a tool specific implementation"
  extends ModelicaAnimationInterface.Icons.InternalPackage;

  package ExternalReferences "Functions to access external resources"
    extends ModelicaAnimationInterface.Icons.InternalPackage;
    partial function PartialLoadResource
        "Interface for tool specific function to return the absolute path name of a URI or local file name"
      extends ModelicaAnimationInterface.Icons.Function;
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
    extends ModelicaAnimationInterface.Icons.InternalPackage;
    partial function exitBase "Interface for tool specific function to terminate the execution of the Modelica environment"
      extends ModelicaAnimationInterface.Icons.Function;
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
Modelica Standard Library that requires a <strong>tool-specific implementation</strong>.
Definitions in this package should not be modified by tool vendors.
Instead, a tool vendor should provide a proper implementation of this library for the corresponding tool in ModelicaServices.
The default implementation is \"do nothing\".
In the Modelica Standard Library, the models and functions of ModelicaServices are used.
</p>
</html>"));
end Interfaces;
