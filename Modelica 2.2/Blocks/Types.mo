package Types "Constants and types with choices, especially to build menus"
  extends Modelica.Icons.Library;

  annotation (preferedView="info", Documentation(info="<HTML>
<p>
In this package <b>types</b> and <b>constants</b> are defined that are used
in library Modelica.Blocks. The types have additional annotation choices
definitions that define the menus to be built up in the graphical
user interface when the type is used as parameter in a declaration.
</p>
</HTML>"));
  package Extrapolation
    "Type, constants and menu choices to define the extrapolation of time table interpolation"

    annotation (preferedView="text");
    extends Modelica.Icons.Library;

    constant Integer HoldLastPoint=0;
    constant Integer LastTwoPoints=1;
    constant Integer Periodic=2;

    type Temp
      "Temporary type of Extrapolation with choices for menus (until enumerations are available)"

      extends Integer;
      annotation (choices(
        choice=Modelica.Blocks.Types.Extrapolation.HoldLastPoint
            "hold last point (constant extrapolation)",
        choice=Modelica.Blocks.Types.Extrapolation.LastTwoPoints
            "last two points (linear extrapolation)",
        choice=Modelica.Blocks.Types.Extrapolation.Periodic
            "periodic (repeat table)"));
    end Temp;
  end Extrapolation;

  package Smoothness
    "Type, constants and menu choices to define the smoothness of table interpolation"

    annotation (preferedView="text");
    extends Modelica.Icons.Library;

    constant Integer LinearSegments=0;
    constant Integer ContinuousDerivative=1;

    type Temp
      "Temporary type of Smoothness with choices for menus (until enumerations are available)"

      extends Integer;
      annotation (choices(
        choice=Modelica.Blocks.Types.Smoothness.LinearSegments
            "linear segments",
        choice=Modelica.Blocks.Types.Smoothness.ContinuousDerivative
            "continuous derivative"));
    end Temp;
  end Smoothness;

end Types;
