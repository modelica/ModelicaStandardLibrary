package Types "Constants and types with choices, especially to build menus" 
  
  annotation (Documentation(info="<html>
<p>
In this package <b>types</b> and <b>constants</b> are defined that are used in the
Interpolation library. The types have additional annotation choices
definitions that define the menus to be built up in the graphical
user interface when the type is used as parameter in a declaration.
</p>
</html>"));
  
package Parametrization 
    "Type, constants and menu choices for types of Bspline parameterization, as temporary solution until enumerations are available" 
  annotation (preferedView="text");
  extends Modelica.Icons.Library;
    
  constant Integer Equidistant=1 "not recommended";
  constant Integer ChordLength=2;
  constant Integer Centripetal=3 "recommended";
  constant Integer Foley=4;
  constant Integer Angular=5;
  constant Integer AreaBased=6;
    
  type Temp 
      "Temporary type of Parametrization type with choices for menus (until enumerations are available)" 
      
    extends Integer(min=1,max=6);
      
    annotation (Evaluate=true, choices(
        choice=Modelica_Interpolation.Types.Parametrization.Equidistant 
            "Equidistant (not recommended)",
        choice=Modelica_Interpolation.Types.Parametrization.ChordLength 
            "ChordLength",
        choice=Modelica_Interpolation.Types.Parametrization.Centripetal 
            "Centripetal (recommended)",
        choice=Modelica_Interpolation.Types.Parametrization.Foley "Foley",
        choice=Modelica_Interpolation.Types.Parametrization.Angular "Angular",
        choice=Modelica_Interpolation.Types.Parametrization.AreaBased 
            "AreaBased"));
  end Temp;
    
end Parametrization;
end Types;
