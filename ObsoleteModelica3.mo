within ;
package ObsoleteModelica3 
  "Library that contains components from Modelica Standard Library 2.2.2 that have been removed from version 3.0" 
  package Blocks 
    package Interfaces 
      package Adaptors 
      model AdaptorReal 
          "Completely obsolete adaptor between 'old' and 'new' Real signal connectors (only for backward compatibility)" 
        Modelica.Blocks.Interfaces.RealSignal newReal 
            "Connector of Modelica version 2.1"                annotation (extent=[100, -10; 120, 10], Hide=true);
        RealPort oldReal(final n=1) "Connector of Modelica version 1.6" annotation (extent=[-120, -10; -100, 10]);
          
        annotation(structurallyIncomplete,
          Icon(
            Rectangle(extent=[-100, 40; 100, -40], style(color=73, fillColor=7)),
            Text(
              extent=[-144, 96; 144, 46],
              style(color=0),
              string=""),
            Text(
              extent=[-88, 22; 88, -24],
              style(color=73, fillColor=42),
              string="adaptor"),
            Text(
              extent=[-216, -58; 36, -80],
              style(
                color=0,
                rgbcolor={0,0,0},
                fillColor=7,
                rgbfillColor={255,255,255},
                fillPattern=1),
              string="port.signal")), Documentation(info="<html>
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
        Modelica.Blocks.Interfaces.BooleanSignal newBoolean 
            "Connector of Modelica version 2.1" 
          annotation (extent=[100, -10; 120, 10], Hide=true);
        BooleanPort oldBoolean(final n=1) "Connector of Modelica version 1.6" annotation (extent=[-120, -10; -100, 10]);
          
        annotation(structurallyIncomplete,
          Icon(
            Rectangle(extent=[-100, 40; 100, -40], style(color=5, fillColor=7)),
            Text(
              extent=[-144, 96; 144, 46],
              style(color=0),
              string=""),
            Text(
              extent=[-88, 22; 88, -24],
              style(color=5),
              string="adaptor"),
            Text(
              extent=[-216, -58; 36, -80],
              style(
                color=0,
                rgbcolor={0,0,0},
                fillColor=7,
                rgbfillColor={255,255,255},
                fillPattern=1),
              string="port.signal")), Documentation(info="<html>
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
        Modelica.Blocks.Interfaces.IntegerSignal newInteger 
            "Connector of Modelica version 2.1" 
          annotation (extent=[100, -10; 120, 10], Hide=true);
        IntegerPort oldInteger(final n=1) "Connector of Modelica version 1.6"  annotation (extent=[-120, -10; -100, 10]);
          
        annotation(structurallyIncomplete,
           Icon(
            Rectangle(extent=[-100, 40; 100, -40], style(color=45, fillColor=7)),
            Text(
              extent=[-144, 96; 144, 46],
              style(color=0),
              string=""),
            Text(
              extent=[-88, 22; 88, -24],
              style(color=45),
              string="adaptor"),
            Text(
              extent=[-216, -58; 36, -80],
              style(
                color=0,
                rgbcolor={0,0,0},
                fillColor=7,
                rgbfillColor={255,255,255},
                fillPattern=1),
              string="port.signal")), Documentation(info="<html>
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
          
          annotation (
            defaultComponentName="convert",
            Icon(Line(points=[-90, 0; 30, 0],style(color=42)), Polygon(points=[90,
                    0; 30, 20; 30, -20; 90, 0], style(color=42, fillColor=42))),
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
            annotation(structurallyIncomplete,
              Coordsys(
                extent=[-100, -100; 100, 100],
                grid=[2, 2],
                component=[20, 20]),
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
"),           Icon(Text(
                  extent=[-95,50; 95,-50],
                  string="=",
              style(color=74, rgbcolor={0,0,127}))));
            Modelica.Blocks.Interfaces.RealInput u1 
          "Connector of first Real input signal" 
              annotation (extent=[-139.742, -19.0044; -100, 20], layer="icon");
            Modelica.Blocks.Interfaces.RealInput u2 
          "Connector of second Real input signal (u1=u2)" 
                                           annotation (
              extent=[100, -20; 140, 20],
              rotation=180,
              layer="icon");
      equation 
            u1 = u2;
      end TwoInputs;
      
          block TwoOutputs 
        "Change causality of output signals by defining that two output signals are identical (e.g. for inverse models)" 
            extends Modelica.Blocks.Interfaces.BlockIcon;
            annotation(structurallyIncomplete,
              Coordsys(
                extent=[-100, -100; 100, 100],
                grid=[2, 2],
                component=[20, 20]),
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
"),           Icon(Text(
                  extent=[-95,50; 95,-50],
                  string="=",
                  style(color=74, rgbcolor={0,0,127}))));
            output Modelica.Blocks.Interfaces.RealOutput y1 
          "Connector of first Real output signal" 
              annotation (extent=[100, -10; 120, 10]);
            output Modelica.Blocks.Interfaces.RealOutput y2 
          "Connector of second Real output signal (y1=y2)" 
                                                   annotation (extent=[-120.366, -10.9029;
                   -100.365, 9.09712], rotation=180);
          equation 
            y1 = y2;
          end TwoOutputs;
    end Math;
  end Blocks;
  annotation (uses(Modelica(version="3.0-development")));
end ObsoleteModelica3;
