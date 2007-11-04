within ;
package ObsoleteModelica3 
  "Library that contains components from Modelica Standard Library 2.2.2 that have been removed from version 3.0" 
  package Blocks 
    package Interfaces 
      package Adaptors 
      model AdaptorReal 
          "Completely obsolete adaptor between 'old' and 'new' Real signal connectors (only for backward compatibility)" 
        extends ObsoleteModelica3.Icons.ObsoleteBlock;
        Modelica.Blocks.Interfaces.RealSignal newReal 
            "Connector of Modelica version 2.1"                annotation (                            Hide=true,
              Placement(transformation(extent={{100,-10},{120,10}}, rotation=0)));
        RealPort oldReal(final n=1) "Connector of Modelica version 1.6" annotation (Placement(
                transformation(extent={{-120,-10},{-100,10}}, rotation=0)));
          
        annotation(structurallyIncomplete,
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                    {100,100}}), graphics={
                Rectangle(
                  extent={{-100,40},{100,-40}}, 
                  lineColor={0,0,255}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid), 
                Text(
                  extent={{-144,96},{144,46}}, 
                  lineColor={0,0,0}, 
                  textString=""), 
                Text(
                  extent={{-88,22},{88,-24}}, 
                  lineColor={0,0,255}, 
                  fillColor={191,0,0}, 
                  fillPattern=FillPattern.Solid, 
                  textString="adaptor"), 
                Text(
                  extent={{-216,-58},{36,-80}}, 
                  lineColor={0,0,0}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  textString="port.signal")}),
                                      Documentation(info="<html>
<p>
Completely obsolete adaptor between the Real signal connector
of version 1.6 and version &ge; 2.1 of the Modelica Standard Library.
This block is only provided for backward compatibility.
</p>
</html>
"));
          
        protected 
        connector RealPort "Connector with signals of type Real" 
          parameter Integer n=1 "Dimension of signal vector" annotation (Hide=true);
          replaceable type SignalType = Real "type of signal";
          SignalType signal[n] "Real signals" annotation (Hide=true);
            
        end RealPort;
      equation 
        newReal = oldReal.signal[1];
      end AdaptorReal;
        
      model AdaptorBoolean 
          "Completely obsolete adaptor between 'old' and 'new' Boolean signal connectors (only for backward compatibility)" 
        extends ObsoleteModelica3.Icons.ObsoleteBlock;
        Modelica.Blocks.Interfaces.BooleanSignal newBoolean 
            "Connector of Modelica version 2.1" 
          annotation (                            Hide=true, Placement(
                transformation(extent={{100,-10},{120,10}}, rotation=0)));
        BooleanPort oldBoolean(final n=1) "Connector of Modelica version 1.6" annotation (Placement(
                transformation(extent={{-120,-10},{-100,10}}, rotation=0)));
          
        annotation(structurallyIncomplete,
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                    {100,100}}), graphics={
                Rectangle(
                  extent={{-100,40},{100,-40}}, 
                  lineColor={255,0,255}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid), 
                Text(
                  extent={{-144,96},{144,46}}, 
                  lineColor={0,0,0}, 
                  textString=""), 
                Text(
                  extent={{-88,22},{88,-24}}, 
                  lineColor={255,0,255}, 
                  textString="adaptor"), 
                Text(
                  extent={{-216,-58},{36,-80}}, 
                  lineColor={0,0,0}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  textString="port.signal")}),
                                      Documentation(info="<html>
<p>
Completely obsolete adaptor between the Real signal connector
of version 1.6 and version &ge; 2.1 of the Modelica Standard Library.
This block is only provided for backward compatibility.
</p>
</html>
"));
          
        protected 
        connector BooleanPort "Connector with signals of type Boolean" 
          parameter Integer n=1 "Dimension of signal vector" annotation (Hide=true);
          replaceable type SignalType = Boolean "type of signal";
          SignalType signal[n] "Boolean signals" annotation (Hide=true);
            
        end BooleanPort;
      equation 
          
        newBoolean = oldBoolean.signal[1];
          
      end AdaptorBoolean;
        
      model AdaptorInteger 
          "Completely obsolete adaptor between 'old' and 'new' Integer signal connectors (only for backward compatibility)" 
        extends ObsoleteModelica3.Icons.ObsoleteBlock;
        Modelica.Blocks.Interfaces.IntegerSignal newInteger 
            "Connector of Modelica version 2.1" 
          annotation (                            Hide=true, Placement(
                transformation(extent={{100,-10},{120,10}}, rotation=0)));
        IntegerPort oldInteger(final n=1) "Connector of Modelica version 1.6"  annotation (Placement(
                transformation(extent={{-120,-10},{-100,10}}, rotation=0)));
          
        annotation(structurallyIncomplete,
           Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                    {100,100}}), graphics={
                Rectangle(
                  extent={{-100,40},{100,-40}}, 
                  lineColor={255,127,0}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid), 
                Text(
                  extent={{-144,96},{144,46}}, 
                  lineColor={0,0,0}, 
                  textString=""), 
                Text(
                  extent={{-88,22},{88,-24}}, 
                  lineColor={255,127,0}, 
                  textString="adaptor"), 
                Text(
                  extent={{-216,-58},{36,-80}}, 
                  lineColor={0,0,0}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  textString="port.signal")}),
                                      Documentation(info="<html>
<p>
Completely obsolete adaptor between the Real signal connector
of version 1.6 and version &ge; 2.1 of the Modelica Standard Library.
This block is only provided for backward compatibility.
</p>
</html>
"));
          
        protected 
        connector IntegerPort "Connector with signals of type Integer" 
          parameter Integer n=1 "Dimension of signal vector" annotation (Hide=true);
          replaceable type SignalType = Integer "type of signal";
          SignalType signal[n] "Integer signals" annotation (Hide=true);
            
        end IntegerPort;
      equation 
          
        newInteger = oldInteger.signal[1];
          
      end AdaptorInteger;
      end Adaptors;
    end Interfaces;
    
    package Math 
      package UnitConversions 
        block ConvertAllUnits "Convert signal to a signal with different unit" 
          replaceable block ConversionBlock = 
              Modelica.Blocks.Interfaces.PartialConversionBlock 
            "Conversion block" 
            annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Internal replaceable block that is used to construct the
\"pull down menu\" of the available unit conversions.
</p>
</html>"));
          extends ConversionBlock;
          extends ObsoleteModelica3.Icons.ObsoleteBlock;
          
          annotation (
            defaultComponentName="convert",
            Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                    {100,100}}), graphics={Line(points={{-90,0},{30,0}}, color=
                      {191,0,0}), Polygon(
                  points={{90,0},{30,20},{30,-20},{90,0}}, 
                  lineColor={191,0,0}, 
                  fillColor={191,0,0}, 
                  fillPattern=FillPattern.Solid)}),
            Documentation(info="<html>
<p>This block implements the Modelica.SIunits.Conversions functions as a fixed causality block to
simplify their use. The block contains a replaceable block class <b>ConversionBlock</b> that can be
changed to be any of the blocks defined in Modelica.Blocks.Math.UnitConversions, and more generally, any
blocks that extend from Modelica.Blocks.Interfaces.PartialConversionBlock.
</p>

<p
The desired conversion can be selected in the parameter menu 
(the selected units are then displayed in the icon):</p>
</p>

<p>
<img src=\"../Modelica/Images/Blocks/ConvertAllUnits.png\">
</p>

</html>"));
        end ConvertAllUnits;
      end UnitConversions;
      
      block TwoInputs 
        "Change causality of input signals by defining that two input signals are identical (e.g. for inverse models)" 
        extends Modelica.Blocks.Interfaces.BlockIcon;
        extends ObsoleteModelica3.Icons.ObsoleteBlock;
            annotation(structurallyIncomplete,
              Window(
                x=0.15,
                y=0.21,
                width=0.6,
                height=0.6),
              Documentation(info="<HTML>
<p>
This block is used to enable asignment of values to variables preliminary
defined as outputs (e.g. useful for inverse model generation).
</p>

</HTML>
"),           Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics={Text(
                extent={{-95,50},{95,-50}}, 
                lineColor={0,0,127}, 
                textString="=")}));
            Modelica.Blocks.Interfaces.RealInput u1 
          "Connector of first Real input signal" 
              annotation (                                       layer="icon",
            Placement(transformation(extent={{-139.742,-19.0044},{-100,20}},
                rotation=0)));
            Modelica.Blocks.Interfaces.RealInput u2 
          "Connector of second Real input signal (u1=u2)" 
                                           annotation (
              layer="icon", Placement(transformation(
              origin={120,0},
              extent={{-20,-20},{20,20}},
              rotation=180)));
      equation 
            u1 = u2;
      end TwoInputs;
      
          block TwoOutputs 
        "Change causality of output signals by defining that two output signals are identical (e.g. for inverse models)" 
            extends Modelica.Blocks.Interfaces.BlockIcon;
            extends ObsoleteModelica3.Icons.ObsoleteBlock;
            annotation(structurallyIncomplete,
              Window(
                x=0.21,
                y=0.28,
                width=0.6,
                height=0.6),
              Documentation(info="
<HTML>
<p>
This block is used to enable calculation of values preliminary defined as inputs.
(e.g. useful for inverse model generation).
</p>

</HTML>
"),           Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics={Text(
                extent={{-95,50},{95,-50}}, 
                lineColor={0,0,127}, 
                textString="=")}));
            output Modelica.Blocks.Interfaces.RealOutput y1 
          "Connector of first Real output signal" 
              annotation (Placement(transformation(extent={{100,-10},{120,10}},
                rotation=0)));
            output Modelica.Blocks.Interfaces.RealOutput y2 
          "Connector of second Real output signal (y1=y2)" 
                                                   annotation (Placement(
              transformation(
              origin={-110.366,-0.90289},
              extent={{-10.0005,-10},{10.0005,10}},
              rotation=180)));
          equation 
            y1 = y2;
          end TwoOutputs;
    end Math;
    
  end Blocks;
  annotation (uses(Modelica(version="3.0-development")));
  package Icons 
    partial block ObsoleteBlock "Icon for an obsolete block" 
      
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics={Rectangle(
              extent={{-102,102},{102,-102}}, 
              lineColor={255,0,0}, 
              pattern=LinePattern.Dash, 
              lineThickness=2)}),        Documentation(info="<html>
<p>
This partial class is intended to design a <em>default icon
for an obsolete class</em> that will be removed from the
PowerTrain library later on.
<p>
</html>",
        revisions="<html>
<img src=\"../Extras/Images/dlr_logo.png\"  width=60 >
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <b>      Copyright &copy; 1999-2007, DLR Institute of Robotics and Mechatronics</b>
</html>"));
    equation 
      
    end ObsoleteBlock;

    partial class Enumeration "Icon for an enumeration (emulated by a package)" 
      
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Text(extent={{-138,164},{138,104}}, textString="%name"), 
            Ellipse(
              extent={{-100,100},{100,-100}}, 
              lineColor={255,0,127}, 
              fillColor={255,255,255}, 
              fillPattern=FillPattern.Solid), 
            Text(
              extent={{-100,100},{100,-100}}, 
              lineColor={255,0,127}, 
              fillColor={223,159,191}, 
              fillPattern=FillPattern.Solid, 
              textString="e")}),
                          Documentation(info="<html>
<p>
This icon is designed for an <b>enumeration</b>
(that is emulated by a package).
</p>
</html>"));
    end Enumeration;
  end Icons;
  
  package Mechanics 
    package MultiBody 
      package Types 
        type AngularVelocity_degs = Modelica.Icons.TypeReal(final quantity="AngularVelocity", final unit
              =    "deg/s") "Angular velocity type in deg/s";
        type AngularAcceleration_degs2 = Modelica.Icons.TypeReal (final 
              quantity =                                                         "AngularAcceleration",
              final unit="deg/s2") "Angular acceleration type in deg/s^2";
        package Init 
          "Type, constants and menu choices to define initialization, as temporary solution until enumerations are available" 
          
          annotation (Documentation(info="<html>
  
</html>"),         uses(Modelica(version="2.2.2")));
          extends ObsoleteModelica3.Icons.Enumeration;
          
          constant Integer Free=1;
          constant Integer PositionVelocity=2;
          constant Integer SteadyState=3;
          constant Integer Position=4;
          constant Integer Velocity=5;
          constant Integer VelocityAcceleration=6;
          constant Integer PositionVelocityAcceleration=7;
          
          type Temp 
            "Temporary type of Init with choices for menus (until enumerations are available)" 
            
            extends Modelica.Icons.TypeInteger;
            annotation (choices(
                choice=Modelica.Mechanics.MultiBody.Types.Init.Free 
                  "free (no initialization)",
                choice=Modelica.Mechanics.MultiBody.Types.Init.PositionVelocity 
                  "initialize generalized position and velocity variables",
                choice=Modelica.Mechanics.MultiBody.Types.Init.SteadyState 
                  "initialize in steady state (velocity and acceleration are zero)",
                choice=Modelica.Mechanics.MultiBody.Types.Init.Position 
                  "initialize only generalized position variable(s)",
                choice=Modelica.Mechanics.MultiBody.Types.Init.Velocity 
                  "initialize only generalized velocity variable(s)",
                choice=Modelica.Mechanics.MultiBody.Types.Init.VelocityAcceleration 
                  "initialize generalized velocity and acceleration variables",
                choice=Modelica.Mechanics.MultiBody.Types.Init.PositionVelocityAcceleration 
                  "initialize generalized position, velocity and acceleration variables"),
                Documentation(info="<html>
  
<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Types.Init.</b></th><th><b>Meaning</b></th></tr>
<tr><td valign=\"top\">Free</td>
    <td valign=\"top\">No initialization</td></tr>
 
<tr><td valign=\"top\">PositionVelocity</td>
    <td valign=\"top\">Initialize generalized position and velocity variables</td></tr>
 
<tr><td valign=\"top\">SteadyState</td>
    <td valign=\"top\">Initialize in steady state (velocity and acceleration are zero)</td></tr>
 
<tr><td valign=\"top\">Position </td>
    <td valign=\"top\">Initialize only generalized position variable(s)</td></tr>
 
<tr><td valign=\"top\">Velocity</td>
    <td valign=\"top\">Initialize only generalized velocity variable(s)</td></tr>
 
<tr><td valign=\"top\">VelocityAcceleration</td>
    <td valign=\"top\">Initialize generalized velocity and acceleration variables</td></tr>
 
<tr><td valign=\"top\">PositionVelocityAcceleration</td>
    <td valign=\"top\">Initialize generalized position, velocity and acceleration variables</td></tr>
 
</table>
 
</html>"));
            
          end Temp;
        end Init;
      end Types;
    end MultiBody;
    
    package Rotational 
      package Types 
        "Constants and types with choices, especially to build menus" 
        extends Modelica.Icons.Library;
        
        annotation (preferedView="info", Documentation(info="<HTML>
<p>
In this package <b>types</b> and <b>constants</b> are defined that are used
in library Modelica.Blocks. The types have additional annotation choices
definitions that define the menus to be built up in the graphical
user interface when the type is used as parameter in a declaration.
</p>
</HTML>"));
        
        package Init 
          "Type, constants and menu choices to define initialization of absolute rotational quantities" 
          extends ObsoleteModelica3.Icons.Enumeration;
          constant Integer NoInit=1 
            "no initialization (phi_start, w_start are guess values)";
          constant Integer SteadyState=2 
            "steady state initialization (der(phi)=der(w)=0)";
          constant Integer InitialState=3 
            "initialization with phi_start, w_start";
          constant Integer InitialAngle=4 "initialization with phi_start";
          constant Integer InitialSpeed=5 "initialization with w_start";
          constant Integer InitialAcceleration=6 "initialization with a_start";
          constant Integer InitialAngleAcceleration=7 
            "initialization with phi_start, a_start";
          constant Integer InitialSpeedAcceleration=8 
            "initialization with w_start, a_start";
          constant Integer InitialAngleSpeedAcceleration=9 
            "initialization with phi_start, w_start, a_start";
          
          type Temp 
            "Temporary type of absolute initialization with choices for menus (until enumerations are available)" 
            extends Modelica.Icons.TypeInteger(min=1,max=9);
            
            annotation (Evaluate=true, choices(
                choice=Modelica.Mechanics.Rotational.Types.Init.NoInit 
                  "no initialization (phi_start, w_start are guess values)",
                choice=Modelica.Mechanics.Rotational.Types.Init.SteadyState 
                  "steady state initialization (der(phi)=der(w)=0)",
                choice=Modelica.Mechanics.Rotational.Types.Init.InitialState 
                  "initialization with phi_start, w_start",
                choice=Modelica.Mechanics.Rotational.Types.Init.InitialAngle 
                  "initialization with phi_start",
                choice=Modelica.Mechanics.Rotational.Types.Init.InitialSpeed 
                  "initialization with w_start",
                choice=Modelica.Mechanics.Rotational.Types.Init.InitialAcceleration 
                  "initialization with a_start",
                choice=Modelica.Mechanics.Rotational.Types.Init.InitialAngleAcceleration 
                  "initialization with phi_start, a_start",
                choice=Modelica.Mechanics.Rotational.Types.Init.InitialSpeedAcceleration 
                  "initialization with w_start, a_start",
                choice=Modelica.Mechanics.Rotational.Types.Init.InitialAngleSpeedAcceleration 
                  "initialization with phi_start, w_start, a_start"));
          end Temp;
          
          annotation (Documentation(info="<html>
<p>
Type <b>Init</b> defines initialization of absolute rotational
quantities.
</p>
 
</html>"));
        end Init;
        
        package InitRel 
          "Type, constants and menu choices to define initialization of relative rotational quantities" 
          extends ObsoleteModelica3.Icons.Enumeration;
          constant Integer NoInit=1 
            "no initialization (phi_rel_start, w_rel_start are guess values)";
          constant Integer SteadyState=2 
            "steady state initialization (der(phi_rel)=der(w_rel)=0)";
          constant Integer InitialState=3 
            "initialization with phi_rel_start, w_rel_start";
          constant Integer InitialAngle=4 "initialization with phi_rel_start";
          constant Integer InitialSpeed=5 "initialization with w_rel_start";
          
          type Temp 
            "Temporary type of absolute initialization with choices for menus (until enumerations are available)" 
            extends Modelica.Icons.TypeInteger(min=1,max=5);
            
            annotation (Evaluate=true, choices(
                choice=Modelica.Mechanics.Rotational.Types.Init.NoInit 
                  "no initialization (phi_rel_start, w_rel_start are guess values)",
                choice=Modelica.Mechanics.Rotational.Types.Init.SteadyState 
                  "steady state initialization (der(phi)=der(w)=0)",
                choice=Modelica.Mechanics.Rotational.Types.Init.InitialState 
                  "initialization with phi_rel_start, w_rel_start",
                choice=Modelica.Mechanics.Rotational.Types.Init.InitialAngle 
                  "initialization with phi_rel_start",
                choice=Modelica.Mechanics.Rotational.Types.Init.InitialSpeed 
                  "initialization with w_rel_start"));
          end Temp;
          
          annotation (Documentation(info="<html>
<p>
Type <b>Init</b> defines initialization of relative rotational
quantities.
</p>
 
</html>"));
        end InitRel;
      end Types;
    end Rotational;
  end Mechanics;
end ObsoleteModelica3;
