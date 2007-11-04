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
      
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
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
      package Sensors 
        partial model AbsoluteSensor 
          "Base model to measure a single absolute flange variable" 
          
          extends Modelica.Icons.RotationalSensor;
          extends ObsoleteModelica3.Icons.ObsoleteBlock;
          
          Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a 
            "(left) flange to be measured (flange axis directed INTO cut plane)"
            annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
                  rotation=0)));
          Modelica.Blocks.Interfaces.RealOutput y "Sensor signal" 
            annotation (Placement(transformation(extent={{100,-10},{120,10}},
                  rotation=0)));
          annotation (
            Window(
              x=0.39,
              y=0.05,
              width=0.6,
              height=0.6),
            Documentation(info="<html>
<p>
This is the base class of a 1D rotational component with one flange and one
output signal y in order to measure an absolute kinematic quantity in the flange
and to provide the measured signal as output signal for further processing
with the blocks of package Modelica.Blocks.
</p>
 
</HTML>
"),         Icon(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-100},{100,100}},
                grid={1,1}), graphics={
                Line(points={{-70,0},{-90,0}}, color={0,0,0}),
                Line(points={{70,0},{100,0}}, color={0,0,127}),
                Text(
                  extent={{150,80},{-150,120}},
                  textString="%name",
                  lineColor={0,0,255})}),
            Diagram(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-100},{100,100}},
                grid={1,1}), graphics={Line(points={{-70,0},{-90,0}}, color={0,
                      0,0}), Line(points={{70,0},{100,0}}, color={0,0,255})}));
        end AbsoluteSensor;
        
        partial model RelativeSensor 
          "Base model to measure a single relative variable between two flanges" 
          
          extends Modelica.Icons.RotationalSensor;
          extends ObsoleteModelica3.Icons.ObsoleteBlock;
          
          Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a 
            "(left) driving flange (flange axis directed INTO cut plane)" 
            annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
                  rotation=0)));
          Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b 
            "(right) driven flange (flange axis directed OUT OF cut plane)" 
            annotation (Placement(transformation(extent={{90,-10},{110,10}},
                  rotation=0)));
          Modelica.Blocks.Interfaces.RealOutput y "Sensor signal" 
            annotation (Placement(transformation(
                origin={0,-110},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          annotation (
            Window(
              x=0.37,
              y=0.02,
              width=0.6,
              height=0.65),
            Documentation(info="<html>
<p>
This is a base class for 1D rotational components with two rigidly connected
flanges and one output signal y in order to measure relative kinematic quantities
between the two flanges or the cut-torque in the flange and
to provide the measured signal as output signal for further processing
with the blocks of package Modelica.Blocks.
</p>
 
</HTML>
"),         Icon(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-100},{100,100}},
                grid={1,1}), graphics={
                Line(points={{-70,0},{-90,0}}, color={0,0,0}),
                Line(points={{70,0},{90,0}}, color={0,0,0}),
                Line(points={{0,-100},{0,-70}}, color={0,0,127}),
                Text(
                  extent={{-150,70},{150,110}},
                  textString="%name",
                  lineColor={0,0,255})}),
            Diagram(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-100},{100,100}},
                grid={1,1}), graphics={
                Line(points={{-70,0},{-90,0}}, color={0,0,0}),
                Line(points={{70,0},{90,0}}, color={0,0,0}),
                Line(points={{0,-100},{0,-70}}, color={0,0,255})}));
        end RelativeSensor;
      end Sensors;
      
      package Interfaces 
        partial model Bearing 
          "Base class for interface classes with bearing connector" 
          extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;
          extends ObsoleteModelica3.Icons.ObsoleteBlock;
          
          Modelica.SIunits.Torque tau_support;
          
          Modelica.Mechanics.Rotational.Interfaces.Flange_a bearing 
            "Flange of bearing" 
                           annotation (Placement(transformation(extent={{-10,-110},
                    {10,-90}}, rotation=0)));
          annotation (
            Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                    -100},{100,100}}), graphics={Rectangle(
                  extent={{-20,-80},{20,-120}}, 
                  lineColor={192,192,192}, 
                  fillColor={192,192,192}, 
                  fillPattern=FillPattern.Solid)}),
            Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                    {100,100}}), graphics={Rectangle(
                  extent={{-20,-80},{20,-120}}, 
                  lineColor={192,192,192}, 
                  fillColor={192,192,192}, 
                  fillPattern=FillPattern.Solid)}),
            Documentation(info="<html>
<p>
This is a 1D rotational component with two flanges and an additional bearing flange.
It is a superclass for the two components TwoFlangesAndBearing and TwoFlangesAndBearingH.</p>
 
</HTML>
"));
          
        end Bearing;
        
        partial model TwoFlangesAndBearing 
          "Base class for a equation-based component with two rotational 1D flanges and one rotational 1D bearing flange" 
          
          extends ObsoleteModelica3.Mechanics.Rotational.Interfaces.Bearing;
          
          Modelica.SIunits.Angle phi_a;
          Modelica.SIunits.Angle phi_b;
          
          annotation (Documentation(info="<html>
<p>
This is a 1D rotational component with two flanges and an additional bearing flange.
It is used e.g. to build up equation-based parts of a drive train.</p>
 
</HTML>
"));
        equation 
          if cardinality(bearing) == 0 then
            bearing.phi = 0;
          else
            bearing.tau = tau_support;
          end if;
          
          0 = flange_a.tau + flange_b.tau + tau_support;
          
          phi_a = flange_a.phi - bearing.phi;
          phi_b = flange_b.phi - bearing.phi;
        end TwoFlangesAndBearing;
        
        partial model TwoFlangesAndBearingH 
          "Base class for a hierarchically composed component with two rotational 1D flanges and one rotational bearing flange" 
          
          extends ObsoleteModelica3.Mechanics.Rotational.Interfaces.Bearing;
          
          Adapter adapter(bearingConnected=cardinality(bearing) > 1) 
            annotation (Placement(transformation(
                origin={0,-60},
                extent={{-10,-10},{10,10}},
                rotation=90)));
        protected 
          encapsulated model Adapter 
            import Modelica;
            import ObsoleteModelica3;
            import TwoFlanges = 
              Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;
            extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;
            extends ObsoleteModelica3.Icons.ObsoleteBlock;
            parameter Boolean bearingConnected;
            
            annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                      -100},{100,100}}), graphics={Rectangle(
                    extent={{-90,10},{90,-10}}, 
                    lineColor={192,192,192}, 
                    fillColor={192,192,192}, 
                    fillPattern=FillPattern.Solid), Text(
                    extent={{-150,60},{150,20}}, 
                    textString="%name", 
                    lineColor={0,0,255})}));
          equation 
            flange_a.phi = flange_b.phi;
            
            if bearingConnected then
              0 = flange_a.tau + flange_b.tau;
            else
              0 = flange_a.phi;
            end if;
          end Adapter;
        equation 
          tau_support = -adapter.flange_b.tau;
          connect(adapter.flange_a, bearing) annotation (Line(points={{
                  -6.12323e-016,-70},{0,-70},{0,-100}}, color={0,0,0}));
          annotation (Documentation(info="<html>
<p>
This is a 1D rotational component with two flanges and an additional bearing flange.
It is used e.g. to build up parts of a drive train consisting
of several base components.</p>
 
</HTML>
"));
        end TwoFlangesAndBearingH;
      end Interfaces;
      
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
      
      model GearEfficiency "Obsolete component (use model LossyGear instead)" 
        extends 
          ObsoleteModelica3.Mechanics.Rotational.Interfaces.TwoFlangesAndBearing;
        extends ObsoleteModelica3.Icons.ObsoleteBlock;
        
        parameter Real eta(
          min=Modelica.Constants.small,
          max=1) = 1 "Efficiency";
        Modelica.SIunits.Angle phi;
        Modelica.SIunits.Power power_a "Energy flowing into flange_a (= power)";
        Boolean driving_a 
          "True, if energy is flowing INTO and not out of flange flange_a";
        
        annotation (
          Window(
            x=0.23,
            y=0.06,
            width=0.69,
            height=0.62),
          Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={1,1}), graphics={
              Text(
                extent={{-150,100},{150,60}}, 
                textString="%name", 
                lineColor={0,0,255}), 
              Rectangle(
                extent={{-100,20},{100,-20}}, 
                lineColor={0,0,0}, 
                fillPattern=FillPattern.HorizontalCylinder, 
                fillColor={192,192,192}), 
              Line(points={{-30,-40},{30,-40}}, color={0,0,0}), 
              Line(points={{0,-40},{0,-90}}, color={0,0,0}), 
              Polygon(
                points={{-30,-20},{60,-20},{60,-80},{70,-80},{50,-100},{30,-80},
                    {40,-80},{40,-30},{-30,-30},{-30,-20},{-30,-20}}, 
                lineColor={0,0,0}, 
                fillColor={255,0,0}, 
                fillPattern=FillPattern.Solid), 
              Text(
                extent={{-150,60},{150,20}}, 
                lineColor={0,0,0}, 
                textString="eta=%eta"), 
              Line(points={{30,-50},{20,-60}}, color={0,0,0}), 
              Line(points={{30,-40},{10,-60}}, color={0,0,0}), 
              Line(points={{20,-40},{0,-60}}, color={0,0,0}), 
              Line(points={{10,-40},{-10,-60}}, color={0,0,0}), 
              Line(points={{0,-40},{-20,-60}}, color={0,0,0}), 
              Line(points={{-10,-40},{-30,-60}}, color={0,0,0}), 
              Line(points={{-20,-40},{-30,-50}}, color={0,0,0})}),
          obsolete=
              "This model can get stuck due when the torque direction varies, use LossyGear instead.",
          Documentation(info="<html>
<p>
THIS COMPONENT IS <b>OBSOLETE</b> and should <b>no longer be used</b>. It is only
kept for <b>backward compatibility</b> purposes. Use model
Modelica.Mechanics.Rotational.LossyGear instead which implements
gear efficiency in a much more reliable way.
</p>
<p>
This component consists of two rigidly connected flanges flange_a and flange_b without
inertia where an <b>efficency</b> coefficient <b>eta</b> reduces the driven
torque as function of the driving torque depending on the direction
of the energy flow, i.e., energy is always lost. This can be seen as a
simple model of the Coulomb friction acting between the teeth of a
gearbox.
</p>
<p>
Note, that most gearbox manufacturers provide tables of the
efficiency of a gearbox as function of the angular velocity
(efficiency becomes zero, if the angular velocity is zero).
However, such a table is practically useless for simulation purposes,
because in gearboxes always two types of friction is present:
(1) Friction in the <b>bearings</b> and (2) friction between
the teeth of the gear. (1) leads to a velocity dependent, additive
loss-torque, whereas (2) leads to a torque-dependent reduction of the
driving torque. The gearbox manufacturers measure both effects
together and determine the gear efficiency from it, although for
simulation purposes the two effects need to be separated.
Assume for example that only constant bearing friction, i.e.,
bearingTorque=const., is present, i.e.,
</p>
<pre>
   (1)  loadTorque = motorTorque - sign(w)*bearingTorque
</pre>
<p>
Gearbox manufacturers use the loss-formula
</p>
<pre>
   (2)  loadTorque = eta*motorTorque
</pre>
<p>
Comparing (1) and (2) gives a formulat for the efficiency eta:
</p>
<pre>
   eta = (1 - sign(w)*bearingTorque/motorTorque)
</pre>
<p>
When the motorTorque becomes smaller as the bearingTorque,
(2) is useless, because the efficiency is zero. To summarize,
be careful to determine the gear <b>efficiency</b> of this element
from tables of the gear manufacturers.
</p>
 
</HTML>
"),       Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={1,1}), graphics={
              Rectangle(
                extent={{-96,20},{96,-21}}, 
                lineColor={0,0,0}, 
                fillPattern=FillPattern.HorizontalCylinder, 
                fillColor={192,192,192}), 
              Line(points={{-30,-40},{30,-40}}, color={0,0,0}), 
              Line(points={{0,60},{0,40}}, color={0,0,0}), 
              Line(points={{-30,40},{29,40}}, color={0,0,0}), 
              Line(points={{0,-40},{0,-90}}, color={0,0,0}), 
              Polygon(
                points={{-30,-20},{60,-20},{60,-80},{70,-80},{50,-100},{30,-80},
                    {40,-80},{40,-30},{-30,-30},{-30,-20},{-30,-20}}, 
                lineColor={0,0,0}, 
                fillColor={255,0,0}, 
                fillPattern=FillPattern.Solid), 
              Text(
                extent={{16,83},{84,70}}, 
                lineColor={128,128,128}, 
                textString="rotation axis"), 
              Polygon(
                points={{12,76},{-8,81},{-8,71},{12,76}}, 
                lineColor={128,128,128}, 
                fillColor={128,128,128}, 
                fillPattern=FillPattern.Solid), 
              Line(points={{-78,76},{-7,76}}, color={128,128,128}), 
              Line(points={{30,-50},{20,-60}}, color={0,0,0}), 
              Line(points={{30,-40},{10,-60}}, color={0,0,0}), 
              Line(points={{20,-40},{0,-60}}, color={0,0,0}), 
              Line(points={{10,-40},{-10,-60}}, color={0,0,0}), 
              Line(points={{0,-40},{-20,-60}}, color={0,0,0}), 
              Line(points={{-10,-40},{-30,-60}}, color={0,0,0}), 
              Line(points={{-20,-40},{-30,-50}}, color={0,0,0})}));
        
      equation 
        phi = phi_a;
        phi = phi_b;
        power_a = flange_a.tau*der(phi);
        driving_a = power_a >= 0;
        flange_b.tau = -(if driving_a then eta*flange_a.tau else flange_a.tau/eta);
      end GearEfficiency;
      
      model Gear "Realistic model of a gearbox" 
        extends 
          ObsoleteModelica3.Mechanics.Rotational.Interfaces.TwoFlangesAndBearingH;
        
        parameter Real ratio=1 "transmission ratio (flange_a.phi/flange_b.phi)";
        parameter Real eta(
          min=Modelica.Constants.small,
          max=1) = 1 "Gear efficiency";
        parameter Real friction_pos[:, 2]=[0, 1] 
          "[w,tau] positive sliding friction characteristic (w>=0)";
        parameter Real peak(final min=1) = 1 
          "peak*friction_pos[1,2] = maximum friction torque at zero velocity";
        parameter Real c(
          final unit="N.m/rad",
          final min=Modelica.Constants.small) = 1.e5 
          "Gear elasticity (spring constant)";
        parameter Real d(
          final unit="N.m.s/rad",
          final min=0) = 0 "(relative) gear damping";
        parameter Modelica.SIunits.Angle b(final min=0)=0 "Total backlash";
        
        annotation (
          Documentation(info="<html>
<p>
This component models the essential effects of a gearbox, in particular
gear <b>efficiency</b> due to friction between the teeth, <b>bearing friction</b>,
gear <b>elasticity</b> and <b>damping</b>, <b>backlash</b>.
The inertia of the gear wheels is not modeled. If necessary, inertia
has to be taken into account by connecting components of model Inertia
to the left and/or the right flange.
</p>
 
</HTML>
"),       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Rectangle(
                extent={{-40,60},{40,-60}}, 
                lineColor={0,0,0}, 
                pattern=LinePattern.Solid, 
                lineThickness=1, 
                fillPattern=FillPattern.HorizontalCylinder, 
                fillColor={192,192,192}), 
              Polygon(
                points={{-60,-80},{-46,-80},{-20,-20},{20,-20},{46,-80},{60,-80},
                    {60,-90},{-60,-90},{-60,-80}}, 
                lineColor={0,0,0}, 
                fillColor={0,0,0}, 
                fillPattern=FillPattern.Solid), 
              Rectangle(
                extent={{-100,10},{-60,-10}}, 
                lineColor={0,0,0}, 
                fillPattern=FillPattern.HorizontalCylinder, 
                fillColor={192,192,192}), 
              Rectangle(
                extent={{60,10},{100,-10}}, 
                lineColor={0,0,0}, 
                fillPattern=FillPattern.HorizontalCylinder, 
                fillColor={192,192,192}), 
              Polygon(
                points={{-60,10},{-60,20},{-40,40},{-40,-40},{-60,-20},{-60,10}}, 
                  
                lineColor={0,0,0}, 
                fillPattern=FillPattern.HorizontalCylinder, 
                fillColor={128,128,128}), 
              Polygon(
                points={{60,20},{40,40},{40,-40},{60,-20},{60,20}}, 
                lineColor={128,128,128}, 
                fillColor={128,128,128}, 
                fillPattern=FillPattern.Solid), 
              Text(
                extent={{-150,110},{150,70}}, 
                textString="%name=%ratio", 
                lineColor={0,0,255}), 
              Text(
                extent={{-150,-160},{150,-120}}, 
                lineColor={0,0,0}, 
                textString="c=%c")}),
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}), graphics={
              Text(
                extent={{2,29},{46,22}}, 
                lineColor={128,128,128}, 
                textString="rotation axis"), 
              Polygon(
                points={{4,25},{-4,27},{-4,23},{4,25}}, 
                lineColor={128,128,128}, 
                fillColor={128,128,128}, 
                fillPattern=FillPattern.Solid), 
              Line(points={{-36,25},{-3,25}}, color={128,128,128})}));
        
        Modelica.Mechanics.Rotational.IdealGear gearRatio(final ratio=ratio) 
          annotation (Placement(transformation(extent={{-70,-10},{-50,10}},
                rotation=0)));
        ObsoleteModelica3.Mechanics.Rotational.GearEfficiency gearEfficiency(
                                      final eta=eta) 
          annotation (Placement(transformation(extent={{-30,-10},{-10,10}},
                rotation=0)));
        Modelica.Mechanics.Rotational.ElastoBacklash elastoBacklash(
          final b=b,
          final c=c,
          final phi_rel0=0,
          final d=d) annotation (Placement(transformation(extent={{50,-10},{70,10}},
                rotation=0)));
        Modelica.Mechanics.Rotational.BearingFriction bearingFriction(final 
            tau_pos=friction_pos, final peak=peak) 
          annotation (Placement(transformation(extent={{10,-10},{30,10}}, rotation=
                  0)));
      equation 
        connect(flange_a, gearRatio.flange_a) 
          annotation (Line(points={{-100,0},{-70,0}}, color={0,0,0}));
        connect(gearRatio.flange_b, gearEfficiency.flange_a) 
          annotation (Line(points={{-50,0},{-30,0}}, color={0,0,0}));
        connect(gearEfficiency.flange_b, bearingFriction.flange_a) 
          annotation (Line(points={{-10,0},{10,0}}, color={0,0,0}));
        connect(bearingFriction.flange_b, elastoBacklash.flange_a) 
          annotation (Line(points={{30,0},{50,0}}, color={0,0,0}));
        connect(elastoBacklash.flange_b, flange_b) 
          annotation (Line(points={{70,0},{100,0}}, color={0,0,0}));
        connect(gearEfficiency.bearing, adapter.flange_b) annotation (Line(points={{-20,-10},
                {-20,-40},{6.12323e-016,-40},{6.12323e-016,-50}},           color={
                0,0,0}));
        connect(bearingFriction.support, adapter.flange_b) annotation (Line(
            points={{20,-10},{20,-40},{6.12323e-016,-40},{6.12323e-016,-50}}, 
            color={0,0,0}, 
            smooth=Smooth.None));
        connect(gearRatio.support, adapter.flange_b) annotation (Line(
            points={{-60,-10},{-60,-40},{6.12323e-016,-40},{6.12323e-016,-50}}, 
              
            color={0,0,0}, 
            smooth=Smooth.None));
      end Gear;
    end Rotational;
  end Mechanics;
end ObsoleteModelica3;
