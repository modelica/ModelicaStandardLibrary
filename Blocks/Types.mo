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
    
    annotation (Documentation(info="<html>
  
</html>"));
    extends Modelica.Icons.Enumeration;
    
    constant Integer HoldLastPoint=0 
      "Hold the last table point outside of the table scope";
    constant Integer LastTwoPoints=1 
      "Extrapolate linearly through the last two table points outside of the table scope";
    constant Integer Periodic=2 "Repeat the table scope periodically";
    
    type Temp 
      "Temporary type of Extrapolation with choices for menus (until enumerations are available)" 
      
      extends Modelica.Icons.TypeInteger;
      annotation (choices(
        choice=Modelica.Blocks.Types.Extrapolation.HoldLastPoint 
            "hold last point (constant extrapolation)",
        choice=Modelica.Blocks.Types.Extrapolation.LastTwoPoints 
            "last two points (linear extrapolation)",
        choice=Modelica.Blocks.Types.Extrapolation.Periodic 
            "periodic (repeat table)"), Documentation(info="<html>
<p>
Type of extrapolation in a table.
</p>
 
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>choice</b></td>
      <td><b>Meaning of choice</b></td>
  </tr>
 
  <tr><td>HoldLastPoint</td>
      <td>Hold the last table point outside of the table scope</td>
  </tr>
  <tr><td>LastTwoPoints</td>
      <td>Extrapolate linearly through the last two table points
          outside of the table scope</td>
  </tr>
  <tr><td>Periodic</td>
      <td>Repeat the table scope periodically</td>
  </tr>
</table>
</html>"));
    end Temp;
  end Extrapolation;
  
  package Init 
    "Type, constants and menu choices to define initialization of blocks" 
    extends Modelica.Icons.Enumeration;
    constant Integer NoInit=1 
      "no initialization (start values are used as guess values with fixed=false)";
    constant Integer SteadyState=2 "steady state initialization";
    constant Integer InitialState=3 "initialization with initial states";
    constant Integer InitialOutput=4 
      "initialization with initial outputs (and steady state of the states if possibles)";
    
    type Temp 
      "Temporary type of initialization with choices for menus (until enumerations are available)" 
      extends Modelica.Icons.TypeInteger(min=1,max=4);
      
      annotation (Evaluate=true, choices(
          choice=Modelica.Blocks.Types.Init.NoInit 
            "no initialization (start values are used as guess values with fixed=false)",
          choice=Modelica.Blocks.Types.Init.SteadyState 
            "steady state initialization",
          choice=Modelica.Blocks.Types.Init.InitialState 
            "initialization with initial states",
          choice=Modelica.Blocks.Types.Init.InitialOutput 
            "initialization with initial outputs (and steady state of the states if possibles)"));
    end Temp;
    annotation (Documentation(revisions="<html>
 
</html>"));
  end Init;
  
  package Smoothness 
    "Type, constants and menu choices to define the smoothness of table interpolation" 
    
    annotation (Documentation(info="<html>
   
</html>"));
    extends Modelica.Icons.Enumeration;
    
    constant Integer LinearSegments=0 "Table points are linearly interpolated";
    constant Integer ContinuousDerivative=1 
      "Table points are interpolated such that the first derivative is continuous";
    
    type Temp 
      "Temporary type of Smoothness with choices for menus (until enumerations are available)" 
      
      extends Modelica.Icons.TypeInteger;
      annotation (choices(
        choice=Modelica.Blocks.Types.Smoothness.LinearSegments 
            "linear segments",
        choice=Modelica.Blocks.Types.Smoothness.ContinuousDerivative 
            "continuous derivative"), Documentation(info="<html>
<p>
Smoothness of interpolation in a table.
</p>
 
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>choice</b></td>
      <td><b>Meaning of choice</b></td>
  </tr>
 
  <tr><td>LinearSegments</td>
      <td>Table points are linearly interpolated</td>
  </tr>
  <tr><td>ContinuousDerivative</td>
      <td>Table points are interpolated such that the
          first derivative is continuous</td>
  </tr>
</table>
</html>"));
    end Temp;
  end Smoothness;
  
end Types;
