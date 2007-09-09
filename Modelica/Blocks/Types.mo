within Modelica.Blocks;
package Types 
  "Library of constants and types with choices, especially to build menus" 
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
  <tr><td valign=\"top\"><b>choice</b></td>
      <td valign=\"top\"><b>Meaning of choice</b></td>
  </tr>
 
  <tr><td valign=\"top\">HoldLastPoint</td>
      <td valign=\"top\">Hold the last table point outside of the table scope</td>
  </tr>
  <tr><td valign=\"top\">LastTwoPoints</td>
      <td valign=\"top\">Extrapolate linearly through the last two table points
          outside of the table scope</td>
  </tr>
  <tr><td valign=\"top\">Periodic</td>
      <td valign=\"top\">Repeat the table scope periodically</td>
  </tr>
</table>
</html>"));
    end Temp;
  end Extrapolation;
  
  package Init 
    "Type, constants and menu choices to define initialization of blocks" 
    annotation (Documentation(info="<html>
 
</html>"));
    
    extends Modelica.Icons.Enumeration;
    constant Integer NoInit=1 
      "no initialization (start values are used as guess values with fixed=false)";
    constant Integer SteadyState=2 
      "steady state initialization (derivatives of states are zero)";
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
            "steady state initialization (derivatives of states are zero)",
          choice=Modelica.Blocks.Types.Init.InitialState 
            "initialization with initial states",
          choice=Modelica.Blocks.Types.Init.InitialOutput 
            "initialization with initial outputs (and steady state of the states if possibles)"));
    end Temp;
    
  end Init;
  
  package InitPID 
    "Type, constants and menu choices to define initialization of PID and LimPID blocks" 
    annotation (Documentation(info="<html>
<p>
This initialization type is identical to Types.Init and has just one
additional option <b>DoNotUse_InitialIntegratorState</b>. This options
is only introduced in order that the default initialization for the
Continuous.PID and Continuous.LimPID blocks are backward 
compatible. In Modelica 2.2, the integrators have been initialized
with their given states wheresas the D-part has not been initialized.
The option \"DoNotUse_InitialIntegratorState\" leads to this
initialization definition.
</p>

</html>"));
    
    extends Modelica.Icons.Enumeration;
    constant Integer NoInit=1 
      "no initialization (start values are used as guess values with fixed=false)";
    constant Integer SteadyState=2 
      "steady state initialization (derivatives of states are zero)";
    constant Integer InitialState=3 "initialization with initial states";
    constant Integer InitialOutput=4 
      "initialization with initial outputs (and steady state of the states if possibles)";
    constant Integer DoNotUse_InitialIntegratorState=5 
      "don't use, only for backward compatibility (initialize only integrator state)";
    
    type Temp 
      "Temporary type of initialization with choices for menus (until enumerations are available)" 
      extends Modelica.Icons.TypeInteger(min=1,max=5);
      
      annotation (Evaluate=true, choices(
          choice=Modelica.Blocks.Types.Init.NoInit 
            "no initialization (start values are used as guess values with fixed=false)",
          choice=Modelica.Blocks.Types.Init.SteadyState 
            "steady state initialization (derivatives of states are zero)",
          choice=Modelica.Blocks.Types.Init.InitialState 
            "initialization with initial states",
          choice=Modelica.Blocks.Types.Init.InitialOutput 
            "initialization with initial outputs (and steady state of the states if possibles)",
          choice=Modelica.Blocks.Types.Init.DoNotUse_InitialIntegratorState 
            "don't use, only for backward compatibility (initialize only integrator state)"));
    end Temp;
    
  end InitPID;
  
  package SimpleController 
    "Type, constants and menu choices to define a simple controller type" 
    
    annotation (Documentation(info="<html>
 
</html>"));
    extends Modelica.Icons.Enumeration;
    constant Integer P=1 "P controller";
    constant Integer PI=2 "PI controller";
    constant Integer PD=3 "PD controller";
    constant Integer PID=4 "PID controller";
    
    type Temp 
      "Temporary type of simple controller type with choices for menus (until enumerations are available)" 
      extends Modelica.Icons.TypeInteger(min=1,max=4);
      
      annotation (Evaluate=true, choices(
          choice=Modelica.Blocks.Types.SimpleController.P "P controller",
          choice=Modelica.Blocks.Types.SimpleController.PI "PI controller",
          choice=Modelica.Blocks.Types.SimpleController.PD "PD controller",
          choice=Modelica.Blocks.Types.SimpleController.PID "PID controller"));
    end Temp;
    
  end SimpleController;
  
  package Smoothness 
    "Type, constants and menu choices to define the smoothness of table interpolation" 
    
    annotation (Documentation(info="<html>
<p>
Interpolation type of a table
</p>
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
  <tr><td valign=\"top\"><b>choice</b></td>
      <td valign=\"top\"><b>Meaning of choice</b></td>
  </tr>
 
  <tr><td valign=\"top\">LinearSegments</td>
      <td valign=\"top\">Table points are linearly interpolated</td>
  </tr>
  <tr><td valign=\"top\">ContinuousDerivative</td>
      <td valign=\"top\">Table points are interpolated such that the
          first derivative is continuous</td>
  </tr>
</table>
</html>"));
    end Temp;
  end Smoothness;
  
  package StateSelection 
    "Type, constants and menu choices to define state selection of variables" 
    
    annotation (Documentation(info="<html>
<p>
Type to define the stateSelection attribute.
</p>
</html>"));
    
    extends Modelica.Icons.Enumeration;
    constant Integer Never=1 "Never (never use as state)";
    constant Integer Avoid=2 "Avoid (avoid to use as state)";
    constant Integer Default=3 "Default (default behaviour)";
    constant Integer Prefer=4 "Prefer (use as state if possible)";
    constant Integer Always=5 "Always (always use as state)";
    
    type Temp 
      "Temporary type of state selection with choices for menus (until enumerations are available)" 
      extends Modelica.Icons.TypeInteger(min=1,max=5);
      
      annotation (Evaluate=true, choices(
          choice=Modelica.Blocks.Types.StateSelection.Never 
            "Never (never use as state)",
          choice=Modelica.Blocks.Types.StateSelection.Avoid 
            "Avoid (avoid to use as state)",
          choice=Modelica.Blocks.Types.StateSelection.Default 
            "Default (default behaviour)",
          choice=Modelica.Blocks.Types.StateSelection.Prefer 
            "Prefer (use as state if possible)",
          choice=Modelica.Blocks.Types.StateSelection.Always 
            "Always (always use as state)"));
    end Temp;
    
  end StateSelection;
end Types;
