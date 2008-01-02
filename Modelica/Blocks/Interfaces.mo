within Modelica.Blocks;
package Interfaces 
  "Library of connectors and partial models for input/output blocks" 
  import Modelica.SIunits;
    extends Modelica.Icons.Library;
  
    annotation(preferedView="info",
      Coordsys(
        extent=[0, 0; 733, 491],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.05,
        y=0.09,
        width=0.72,
        height=0.71,
        library=1,
        autolayout=1),
      Documentation(info="<HTML>
<p>
This package contains interface definitions for
<b>continuous</b> input/output blocks with Real,
Integer and Boolean signals. Furthermore, it contains
partial models for continuous and discrete blocks.
</p>

</HTML>
", revisions="<html>
<ul>
<li><i>Oct. 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Added several new interfaces. <a href=\"../Documentation/ChangeNotes1.5.html\">Detailed description</a> available.
<li><i>Oct. 24, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       RealInputSignal renamed to RealInput. RealOutputSignal renamed to
       output RealOutput. GraphBlock renamed to BlockIcon. SISOreal renamed to
       SISO. SOreal renamed to SO. I2SOreal renamed to M2SO.
       SignalGenerator renamed to SignalSource. Introduced the following
       new models: MIMO, MIMOs, SVcontrol, MVcontrol, DiscreteBlockIcon,
       DiscreteBlock, DiscreteSISO, DiscreteMIMO, DiscreteMIMOs,
       BooleanBlockIcon, BooleanSISO, BooleanSignalSource, MI2BooleanMOs.</li>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized a first version, based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist.</li>
</ul>
</html>
"));
  
connector RealSignal "Real port (both input/output possible)" 
  replaceable type SignalType = Real;
    
  extends SignalType;
    
    annotation (Documentation(info="<html>
<p>
Connector with one signal of type Real (no icon, no input/output prefix).
</p>
</html>"));
end RealSignal;
  
connector BooleanSignal = Boolean "Boolean port (both input/output possible)" 
    annotation (Documentation(info="<html>
<p>
Connector with one signal of type Boolean (no icon, no input/output prefix).
</p>
</html>"));
connector IntegerSignal = Integer "Integer port (both input/output possible)" 
    annotation (Documentation(info="<html>
<p>
Connector with one signal of type Icon (no icon, no input/output prefix).
</p>
</html>"));
  
connector RealInput = input RealSignal "'input Real' as connector" 
  annotation (defaultComponentName="u",
  Coordsys(extent=[-100, -100; 100, 100],
    grid=[1,1],
    component=[20,20],
      scale=0.2),
  Icon(coordinateSystem(extent=[-100,-100; 100,100]),
       Polygon(points=[-100,100; 100,0; -100,-100; -100,100], style(
          color=74,
          rgbcolor={0,0,127},
          fillColor=74,
          rgbfillColor={0,0,127}))),
  Diagram(Polygon(points=[0,50; 100,0; 0,-50; 0,50], style(
          color=74,
          rgbcolor={0,0,127},
          fillColor=74,
          rgbfillColor={0,0,127})),
                                  Text(
      extent=[-120,105; 100,60],
      string="%name",
        style(color=74, rgbcolor={0,0,127}))),
    Documentation(info="<html>
<p>
Connector with one input signal of type Real.
</p>
</html>"));
  
connector RealOutput = output RealSignal "'output Real' as connector" 
  annotation (defaultComponentName="y",
  Coordsys(extent=[-100, -100; 100, 100],
    grid=[1,1],
    component=[20,20]),
  Icon(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100], style(
          color=74,
          rgbcolor={0,0,127},
          fillColor=7,
          rgbfillColor={255,255,255}))),
  Diagram(Polygon(points=[-100,50; 0,0; -100,-50; -100,50], style(
          color=74,
          rgbcolor={0,0,127},
          fillColor=7,
          rgbfillColor={255,255,255})),
                                  Text(
      extent=[-100,140; 130,60],
      string="%name",
        style(color=74, rgbcolor={0,0,127}))),
    Documentation(info="<html>
<p>
Connector with one output signal of type Real.
</p>
</html>"));
  
connector BooleanInput = input BooleanSignal "'input Boolean' as connector" 
  annotation (defaultComponentName="u",
       Icon(coordinateSystem(extent=[-100,-100; 100,100]),
            Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100],
         style(color=5, fillColor=5))), Diagram(Polygon(points=[0,50; 100,0;
          0,-50; 0,50],                   style(color=5, fillColor=5)),
                                  Text(
      extent=[-120,105; 100,60],
      string="%name",
      style(color=5))),
  Coordsys(grid=[1,1], component=[20,20],
      scale=0.2),
    Documentation(info="<html>
<p>
Connector with one input signal of type Boolean.
</p>
</html>"));
  
connector BooleanOutput = output BooleanSignal "'output Boolean' as connector" 
                                  annotation (defaultComponentName="y",
  Coordsys(extent=[-100, -100; 100, 100],
    grid=[1,1],
    component=[20,20]),
  Icon(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100], style(color=
           5, fillColor=7))),
  Diagram(Polygon(points=[-100,50; 0,0; -100,-50; -100,50],          style(
          color=5, fillColor=7)), Text(
      extent=[-100,140; 130,60],
      string="%name",
      style(color=5))),
    Documentation(info="<html>
<p>
Connector with one output signal of type Boolean.
</p>
</html>"));
  
connector IntegerInput = input IntegerSignal "'input Integer' as connector" 
  annotation (defaultComponentName="u",
  Coordsys(
    extent=[-100, -100; 100, 100],
    grid=[1,1],
    component=[20,20],
      scale=0.2),
  Icon(coordinateSystem(extent=[-100,-100; 100,100]),
       Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100], style(color=
           45, fillColor=45))),
  Diagram(Polygon(points=[0,50; 100,0; 0,-50; 0,50],                 style(
          color=45, fillColor=45)), Text(
      extent=[-120,105; 100,60],
      style(color=45),
      string="%name")),
    Documentation(info="<html>
<p>
Connector with one input signal of type Integer.
</p>
</html>"));
  
connector IntegerOutput = output IntegerSignal "'output Integer' as connector" 
                                  annotation (defaultComponentName="y",
  Coordsys(
    extent=[-100, -100; 100, 100],
    grid=[1,1],
    component=[20,20]),
  Icon(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100], style(color=
           45, fillColor=7))),
  Diagram(Polygon(points=[-100,50; 0,0; -100,-50; -100,50],          style(
          color=45, fillColor=7)),  Text(
      extent=[-100,140; 130,60],
      style(color=45),
      string="%name")),
    Documentation(info="<html>
<p>
Connector with one output signal of type Integer.
</p>
</html>"));
  
    partial block BlockIcon "Basic graphical layout of input/output block" 
    
      annotation (
        Coordsys(extent=[-100, -100; 100, 100]),
        Window(
          x=0,
          y=0,
          width=0.6,
          height=0.6),
        Icon(Rectangle(extent=[-100, -100; 100, 100], style(
            color=74,
            rgbcolor={0,0,127},
            fillColor=7,
            rgbfillColor={255,255,255})),
                               Text(extent=[-150, 150; 150, 110], string=
                "%name")),
      Documentation(info="<html>
<p>
Block that has only the basic icon for an input/output
block (no declarations, no equations). Most blocks
of package Modelica.Blocks inherit directly or indirectly
from this block.
</p>
</html>"));
    equation 
    
    end BlockIcon;
  
    partial block SO "Single Output continuous control block" 
      extends BlockIcon;
    
      RealOutput y "Connector of Real output signal" 
        annotation (extent=[100, -10; 120, 10]);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.25,
          y=0.02,
          width=0.6,
          height=0.6),
        Diagram,
      Documentation(info="<html>
<p>
Block has one continuous Real output signal.
</p>
</html>"));
    end SO;
  
    partial block MO "Multiple Output continuous control block" 
      extends BlockIcon;
    
      parameter Integer nout(min=1) = 1 "Number of outputs";
      RealOutput y[nout] "Connector of Real output signals" 
        annotation (extent=[100, -10; 120, 10]);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.13,
          y=0.03,
          width=0.6,
          height=0.6),
        Documentation(info="<html>
<p>
Block has one continuous Real output signal vector.
</p>
</html>"));
    end MO;
  
    partial block SISO "Single Input Single Output continuous control block" 
      extends BlockIcon;
    
      RealInput u "Connector of Real input signal" 
        annotation (extent=[-140, -20; -100, 20]);
      RealOutput y "Connector of Real output signal" 
        annotation (extent=[100, -10; 120, 10]);
      annotation (Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]), Window(
          x=0.32,
          y=0.07,
          width=0.6,
          height=0.6),
      Documentation(info="<html>
<p>
Block has one continuous Real input and one continuous Real output signal.
</p>
</html>"));
    end SISO;
  
    partial block SI2SO 
    "2 Single Input / 1 Single Output continuous control block" 
      extends BlockIcon;
    
      RealInput u1 "Connector of Real input signal 1" 
        annotation (extent=[-140, 40; -100, 80]);
      RealInput u2 "Connector of Real input signal 2" 
        annotation (extent=[-140, -80; -100, -40]);
      RealOutput y "Connector of Real output signal" 
        annotation (extent=[100, -10; 120, 10]);
    
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.31,
          y=0.07,
          width=0.6,
          height=0.6),
        Documentation(info="<html>
<p>
Block has two continuous Real input signals u1 and u2 and one
continuous Real output signal y.
</p>
</html>"),
        Diagram);
    end SI2SO;
  
partial block SIMO "Single Input Multiple Output continuous control block" 
  extends BlockIcon;
  parameter Integer nout=1 "Number of outputs";
      RealInput u "Connector of Real input signal" 
        annotation (extent=[-140, -20; -100, 20]);
      RealOutput y[nout] "Connector of Real output signals" 
        annotation (extent=[100, -10; 120, 10]);
    
  annotation (Documentation(info="<HTML>
<p> Block has one continuous Real input signal and a
    vector of continuous Real output signals.</p>

</HTML>
"));
end SIMO;
  
    partial block MISO "Multiple Input Single Output continuous control block" 
    
      extends BlockIcon;
      parameter Integer nin=1 "Number of inputs";
      RealInput u[nin] "Connector of Real input signals" 
        annotation (extent=[-140, -20; -100, 20]);
      RealOutput y "Connector of Real output signal" 
        annotation (extent=[100, -10; 120, 10]);
      annotation (Documentation(info="<HTML>
<p>
Block has a vector of continuous Real input signals and
one continuous Real output signal.
</p>
</HTML>
"));
    end MISO;
  
    partial block MIMO 
    "Multiple Input Multiple Output continuous control block" 
    
      extends BlockIcon;
      parameter Integer nin=1 "Number of inputs";
      parameter Integer nout=1 "Number of outputs";
      RealInput u[nin] "Connector of Real input signals" 
        annotation (extent=[-140, -20; -100, 20]);
      RealOutput y[nout] "Connector of Real output signals" 
        annotation (extent=[100, -10; 120, 10]);
      annotation (Documentation(info="<HTML>
<p>
Block has a continuous Real input and a continuous Real output signal vector.
The signal sizes of the input and output vector may be different.
</p>
</HTML>
"));
    end MIMO;
  
    partial block MIMOs 
    "Multiple Input Multiple Output continuous control block with same number of inputs and outputs" 
    
      extends BlockIcon;
      parameter Integer n=1 "Number of inputs (= number of outputs)";
      RealInput u[n] "Connector of Real input signals" 
        annotation (extent=[-140, -20; -100, 20]);
      RealOutput y[n] "Connector of Real output signals" 
        annotation (extent=[100, -10; 120, 10]);
      annotation (
        Documentation(info="<HTML>
<p>
Block has a continuous Real input and a continuous Real output signal vector
where the signal sizes of the input and output vector are identical.
</p>
</HTML>
"),     Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.28,
          y=0.16,
          width=0.6,
          height=0.6));
    end MIMOs;
  
    partial block MI2MO 
    "2 Multiple Input / Multiple Output continuous control block" 
      extends BlockIcon;
    
      parameter Integer n=1 "Dimension of input and output vectors.";
    
      RealInput u1[n] "Connector 1 of Real input signals" 
        annotation (extent=[-140, 40; -100, 80]);
      RealInput u2[n] "Connector 2 of Real input signals" 
        annotation (extent=[-140, -80; -100, -40]);
      RealOutput y[n] "Connector of Real output signals" 
        annotation (extent=[100, -10; 120, 10]);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.31,
          y=0.07,
          width=0.6,
          height=0.6),
        Documentation(info="<html>
<p>
Block has two continuous Real input vectors u1 and u2 and one
continuous Real output vector y.
All vectors have the same number of elements.
</p>
</html>"),
        Diagram);
    end MI2MO;
  
    partial block SignalSource "Base class for continuous signal source" 
      extends SO;
      parameter Real offset=0 "Offset of output signal y";
      parameter SIunits.Time startTime=0 
      "Output y = offset for time < startTime";
    annotation (Documentation(info="<html>
<p>
Basic block for Real sources of package Blocks.Sources.
This component has one continuous Real output signal y
and two parameters (offset, startTime) to shift the
generated signal.
</p>
</html>"));
    end SignalSource;
  
    partial block SVcontrol "Single-Variable continuous controller" 
      extends BlockIcon;
    
      RealInput u_s "Connector of setpoint input signal" 
        annotation (extent=[-140, -20; -100, 20]);
      RealInput u_m "Connector of measurement input signal" 
        annotation (extent=[20, -100; -20, -140], rotation=-90);
      RealOutput y "Connector of actuator output signal" 
        annotation (extent=[100, -10; 120, 10]);
      annotation (
        Diagram(
          Text(extent=[-102, 34; -142, 24], string="(setpoint)"),
          Text(extent=[100, 24; 140, 14], string="(actuator)"),
          Text(extent=[-83, -112; -33, -102], string=" (measurement)")),
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.19,
          y=0.21,
          width=0.6,
          height=0.46),
      Documentation(info="<html>
<p>
Block has two continuous Real input signals and one
continuous Real output signal. The block is designed
to be used as base class for a corresponding controller.
</p>
</html>"));
    end SVcontrol;
  
    partial block MVcontrol "Multi-Variable continuous controller" 
      extends BlockIcon;
    
      parameter Integer nu_s=1 "Number of setpoint inputs";
      parameter Integer nu_m=1 "Number of measurement inputs";
      parameter Integer ny=1 "Number of actuator outputs";
      RealInput u_s[nu_s] "Connector of setpoint input signals" 
        annotation (extent=[-140, -20; -100, 20]);
      RealInput u_m[nu_m] "Connector of measurement input signals" 
        annotation (extent=[20, -100; -20, -140], rotation=-90);
      RealOutput y[ny] "Connector of actuator output signals" 
        annotation (extent=[100, -10; 120, 10]);
      annotation (
        Diagram(
          Text(extent=[-100, 36; -140, 26], string="(setpoint)"),
          Text(extent=[102, 24; 142, 14], string="(actuator)"),
          Text(extent=[-75, -108; -25, -98], string=" (measurement)")),
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.26,
          y=0.19,
          width=0.6,
          height=0.6),
      Documentation(info="<html>
<p>
Block has two continuous Real input signal vectors and one
continuous Real output signal vector. The block is designed
to be used as base class for a corresponding controller.
</p>
</html>"));
    end MVcontrol;
  
    partial block DiscreteBlockIcon 
    "Graphical layout of discrete block component icon" 
    
      annotation (Icon(Rectangle(extent=[-100, -100; 100, 100], style(color=3,
                fillColor=52)), Text(extent=[-150, 150; 150, 110], string=
                "%name")), Documentation(info="<html>
<p>
Block that has only the basic icon for an input/output,
discrete block (no declarations, no equations), e.g.,
from Blocks.Discrete.
</p>
</html>"));
    equation 
    
    end DiscreteBlockIcon;
  
    partial block DiscreteBlock "Base class of discrete control blocks" 
      extends DiscreteBlockIcon;
    
      parameter SI.Time samplePeriod(min=100*Modelica.Constants.eps) = 0.1 
      "Sample period of component";
      parameter SI.Time startTime=0 "First sample time instant";
  protected 
      output Boolean sampleTrigger "True, if sample time instant";
      output Boolean firstTrigger "Rising edge signals first sample instant";
    equation 
      sampleTrigger = sample(startTime, samplePeriod);
      when sampleTrigger then
        firstTrigger = time <= startTime + samplePeriod/2;
      end when;
    annotation (Documentation(info="<html>
<p>
Basic definitions of a discrete block of library
Blocks.Discrete.
</p>
</html>"));
    end DiscreteBlock;
  
    partial block DiscreteSISO 
    "Single Input Single Output discrete control block" 
    
      extends DiscreteBlock;
    
      Modelica.Blocks.Interfaces.RealInput u "Continuous input signal" 
                                  annotation (extent=[-140,
              -20; -100, 20]);
      Modelica.Blocks.Interfaces.RealOutput y "Continuous output signal" 
                                   annotation (extent=[100,
              -10; 120, 10]);
    annotation (Documentation(info="<html>
<p>
Block has one continuous input and one continuous output signal
which are sampled due to the defined <b>samplePeriod</b> parameter.
</p>
</html>"));
    end DiscreteSISO;
  
    partial block DiscreteMIMO 
    "Multiple Input Multiple Output discrete control block" 
    
      extends DiscreteBlock;
      parameter Integer nin=1 "Number of inputs";
      parameter Integer nout=1 "Number of outputs";
    
      Modelica.Blocks.Interfaces.RealInput u[nin] "Continuous input signals" 
                                   annotation (extent=[-140,
              -20; -100, 20]);
      Modelica.Blocks.Interfaces.RealOutput y[nout] "Continuous output signals"
                                    annotation (extent=[100,
              -10; 120, 10]);
    
      annotation (Documentation(info="<html>
<p>
Block has a continuous input and a continuous output signal vector
which are sampled due to the defined <b>samplePeriod</b> parameter.
</p>
</HTML>
"));
    end DiscreteMIMO;
  
    partial block DiscreteMIMOs 
    "Multiple Input Multiple Output discrete control block" 
      parameter Integer n=1 "Number of inputs (= number of outputs)";
      extends DiscreteBlock;
    
      Modelica.Blocks.Interfaces.RealInput u[n] "Continuous input signals" 
                                   annotation (extent=[-140,
              -20; -100, 20]);
      Modelica.Blocks.Interfaces.RealOutput y[n] "Continuous output signals" 
                                    annotation (extent=[100,
              -10; 120, 10]);
    
      annotation (Documentation(info="<html>
<p>
Block has a continuous input and a continuous output signal vector
where the signal sizes of the input and output vector are identical.
These signals are sampled due to the defined <b>samplePeriod</b> parameter.
</p>
</HTML>
"));
    
    end DiscreteMIMOs;
  
    partial block SVdiscrete "Discrete Single-Variable controller" 
      extends DiscreteBlock;
    
      Discrete.Sampler sampler_s(
        final samplePeriod=samplePeriod,
        final startTime=startTime) annotation (extent=[-100, -10; -80, 10]);
      Discrete.Sampler sampler_m(
        final samplePeriod=samplePeriod,
        final startTime=startTime) annotation (extent=[-10, -100; 10, -80],
          rotation=90);
      Modelica.Blocks.Interfaces.RealInput u_s 
      "Continuous scalar setpoint input signal"   annotation (extent=[-140, -20; -
            100, 20]);
      Modelica.Blocks.Interfaces.RealInput u_m 
      "Continuous scalar measurement input signal"   annotation (extent=[20, -100; -
            20, -140], rotation=-90);
      Modelica.Blocks.Interfaces.RealOutput y 
      "Continuous scalar actuator output signal"   annotation (extent=[100, -10; 120,
              10]);
      annotation (Diagram(
          Text(
            extent=[-100, 34; -140, 24],
            string="(setpoint)",
            style(color=0)),
          Text(
            extent=[100, 22; 130, 14],
            string="(actuator)",
            style(color=0)),
          Text(
            extent=[-70, -112; -20, -102],
            string=" (measurement)",
            style(color=0))), Documentation(info="<html>
<p>
Block has two continuous Real input signals and one
continuous Real output signal
that are sampled due to the defined <b>samplePeriod</b> parameter.
The block is designed
to be used as base class for a corresponding controller.
</p>
</html>"));
    equation 
      connect(u_s, sampler_s.u)           annotation (points=[-120, 0; -102, 0]);
      connect(u_m, sampler_m.u)           annotation (points=[0,-120; 0,-111; 0,
          -102; -7.34764e-016,-102]);
    end SVdiscrete;
  
    partial block MVdiscrete "Discrete Multi-Variable controller" 
      extends DiscreteBlock;
      parameter Integer nu_s=1 "Number of setpoint inputs";
      parameter Integer nu_m=1 "Number of measurement inputs";
      parameter Integer ny=1 "Number of actuator outputs";
      Discrete.Sampler sampler_s[nu_s](
        each final samplePeriod=samplePeriod,
        each final startTime=startTime) 
                                   annotation (extent=[-90, -10; -70, 10]);
      Discrete.Sampler sampler_m[nu_m](
        each final samplePeriod=samplePeriod,
        each final startTime=startTime) 
                                   annotation (extent=[-10, -90; 10, -70],
          rotation=90);
      Modelica.Blocks.Interfaces.RealInput u_s[nu_s] 
      "Continuous setpoint input signals"   annotation (extent=[-140, -20; -
            100, 20]);
      Modelica.Blocks.Interfaces.RealInput u_m[nu_m] 
      "Continuous measurement input signals"   annotation (extent=[20, -100;
            -20, -140], rotation=-90);
      Modelica.Blocks.Interfaces.RealOutput y[ny] 
      "Continuous actuator output signals"   annotation (extent=[100, -10;
            120, 10]);
      annotation (Diagram(
          Text(extent=[-100, -10; -80, -30], string="u_s"),
          Text(
            extent=[-98, 34; -138, 24],
            string="(setpoint)",
            style(color=0)),
          Text(
            extent=[98, 24; 138, 14],
            string="(actuator)",
            style(color=0)),
          Text(
            extent=[-62, -110; -12, -100],
            string=" (measurement)",
            style(color=0))), Documentation(info="<html>
<p>
Block has two continuous Real input signal vectors and one
continuous Real output signal vector. The vector signals
are sampled due to the defined <b>samplePeriod</b> parameter.
The block is designed
to be used as base class for a corresponding controller.
</p>
</html>"));
    equation 
      connect(u_s, sampler_s.u)           annotation (points=[-120, 0; -92, 0]);
      connect(u_m, sampler_m.u)           annotation (points=[0,-120; 0,-106; 0,
          -92; -7.34764e-016,-92]);
    end MVdiscrete;
  
    partial block BooleanBlockIcon "Basic graphical layout of Boolean block" 
    
      annotation (
        Coordsys(extent=[-100, -100; 100, 100]),
        Window(
          x=0.1,
          y=0.1,
          width=0.6,
          height=0.6),
        Icon(Rectangle(extent=[-100, -100; 100, 100], style(color=5,
                fillColor=7)), Text(extent=[-150, 150; 150, 110], string=
                "%name")),
      Documentation(info="<html>
<p>
Block that has only the basic icon for an input/output,
Boolean block (no declarations, no equations).
</p>
</html>"));
    equation 
    
    end BooleanBlockIcon;
  
    partial block BooleanSISO 
    "Single Input Single Output control block with signals of type Boolean" 
    
      extends BooleanBlockIcon;
    
  public 
      BooleanInput u "Connector of Boolean input signal" 
        annotation (extent=[-140, -20; -100, 20]);
      BooleanOutput y "Connector of Boolean output signal" 
        annotation (extent=[100, -10; 120, 10]);
    
      annotation (Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]), Window(
          x=0.37,
          y=0.14,
          width=0.6,
          height=0.6),
      Documentation(info="<html>
<p>
Block has one continuous Boolean input and one continuous Boolean output signal.
</p>
</html>"));
    end BooleanSISO;
  
partial block BooleanMIMOs 
    "Multiple Input Multiple Output continuous control block with same number of inputs and outputs of boolean type" 
    
  extends BooleanBlockIcon;
  parameter Integer n=1 "Number of inputs (= number of outputs)";
  BooleanInput u[n] "Connector of Boolean input signals" 
    annotation (extent=[-140, -20; -100, 20]);
  BooleanOutput y[n] "Connector of Boolean output signals" 
    annotation (extent=[100, -10; 120, 10]);
  annotation (Documentation(info="<HTML>
<p>
Block has a continuous Boolean input and a continuous Boolean output signal vector
where the signal sizes of the input and output vector are identical.
</p>
</HTML>
"));
end BooleanMIMOs;
  
partial block MI2BooleanMOs 
    "2 Multiple Input / Boolean Multiple Output block with same signal lengths" 
    
  extends BooleanBlockIcon;
  parameter Integer n=1 "Dimension of input and output vectors.";
  RealInput u1[n] "Connector 1 of Boolean input signals" 
    annotation (extent=[-140, 40; -100, 80]);
  RealInput u2[n] "Connector 2 of Boolean input signals" 
    annotation (extent=[-140, -80; -100, -40]);
  BooleanOutput y[n] "Connector of Boolean output signals" 
    annotation (extent=[100, -10; 120, 10]);
  annotation (Documentation(info="<html>
<p>Block has two Boolean input vectors u1 and u2 and one Boolean output
vector y. All vectors have the same number of elements.</p>
</html>
"));
end MI2BooleanMOs;
  
    partial block SI2BooleanSO "2 Single Input / Boolean Single Output block" 
    
      extends BooleanBlockIcon;
      input RealInput u1 "Connector 1 of Boolean input signals" 
        annotation (extent=[-140, 40; -100, 80]);
      input RealInput u2 "Connector 2 of Boolean input signals" 
        annotation (extent=[-140, -80; -100, -40]);
      output BooleanOutput y "Connector of Boolean output signals" 
        annotation (extent=[100, -10; 120, 10]);
      annotation (
        Coordsys(extent=[-100, -100; 100, 100]),
        Window(
          x=0.19,
          y=0.16,
          width=0.6,
          height=0.6),
        Documentation(info="<html>
<p>
Block has two Boolean input signals u1 and u2 and one Boolean output signal y.
</p>
</html>
"));
    end SI2BooleanSO;
  
    partial block BooleanSignalSource "Base class for Boolean signal sources" 
    
      extends BooleanBlockIcon;
      BooleanOutput y "Connector of Boolean output signal" 
        annotation (extent=[100, -10; 120, 10]);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.13,
          y=0.03,
          width=0.6,
          height=0.6),
        Icon(
          Line(points=[-80, 68; -80, -80], style(color=8)),
          Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
                 fillColor=8)),
          Line(points=[-90, -70; 68, -70], style(color=8)),
          Polygon(points=[90, -70; 68, -62; 68, -78; 90, -70], style(color=8,
                 fillColor=8))),
        Diagram,
      Documentation(info="<html>
<p>
Basic block for Boolean sources of package Blocks.Sources.
This component has one continuous Boolean output signal y.
</p>
</html>"));
    end BooleanSignalSource;
  
partial block IntegerBlockIcon "Basic graphical layout of Integer block" 
    
  annotation (Icon(Rectangle(extent=[-100, -100; 100, 100], style(color=45,
            fillColor=7)), Text(extent=[-150, 150; 150, 110], string="%name")),
        Documentation(info="<html>
<p>
Block that has only the basic icon for an input/output,
Integer block (no declarations, no equations).
</p>
</html>"));
equation 
    
end IntegerBlockIcon;
  
partial block IntegerSO "Single Integer Output continuous control block" 
  extends IntegerBlockIcon;
    
  IntegerOutput y "Connector of Integer output signal" 
    annotation (extent=[100, -10; 120, 10]);
    annotation (Documentation(info="<html>
<p>
Block has one continuous Integer output signal.
</p>
</html>"));
end IntegerSO;
  
partial block IntegerMO "Multiple Integer Output continuous control block" 
  extends IntegerBlockIcon;
    
  parameter Integer nout(min=1) = 1 "Number of outputs";
  IntegerOutput y[nout] "Connector of Integer output signals" 
    annotation (extent=[100, -10; 120, 10]);
    annotation (Documentation(info="<html>
<p>
Block has one continuous Integer output signal vector.
</p>
</html>"));
end IntegerMO;
  
partial block IntegerSignalSource 
    "Base class for continuous Integer signal source" 
  extends IntegerSO;
  parameter Integer offset=0 "Offset of output signal y";
  parameter SI.Time startTime=0 "Output y = offset for time < startTime";
    annotation (Documentation(info="<html>
<p>
Basic block for Integer sources of package Blocks.Sources.
This component has one continuous Integer output signal y
and two parameters (offset, startTime) to shift the
generated signal.
</p>
</html>"));
end IntegerSignalSource;
  
partial block IntegerSIBooleanSO 
    "Integer Input Boolean Output continuous control block" 
    
  extends BooleanBlockIcon;
  IntegerInput u "Connector of Integer input signal" 
    annotation (extent=[-140, -20; -100, 20]);
  BooleanOutput y "Connector of Boolean output signal" 
    annotation (extent=[100, -10; 120, 10]);
  annotation (Documentation(info="<HTML>
<p>
Block has a continuous Integer input and a continuous Boolean output signal.
</p>
</HTML>
"));
end IntegerSIBooleanSO;
  
partial block IntegerMIBooleanMOs 
    "Multiple Integer Input Multiple Boolean Output continuous control block with same number of inputs and outputs" 
    
  extends BooleanBlockIcon;
  parameter Integer n=1 "Number of inputs (= number of outputs)";
  IntegerInput u[n] "Connector of Integer input signals" 
    annotation (extent=[-140, -20; -100, 20]);
  BooleanOutput y[n] "Connector of Boolean output signals" 
    annotation (extent=[100, -10; 120, 10]);
  annotation (Documentation(info="<HTML>
<p>
Block has a continuous Integer input and a continuous Boolean output signal vector
where the signal sizes of the input and output vector are identical.
</p>
</HTML>
"));
end IntegerMIBooleanMOs;
  
  partial block partialBooleanBlockIcon 
    "Basic graphical layout of logical block" 
    
    annotation (Icon(
  Rectangle(extent=[-100,100; 100,-100],   style(
            color=0,
            fillColor=30,
            rgbfillColor={210,210,210},
            fillPattern=11)),
         Text(extent=[-150,150; 150,110],string="%name")), Documentation(info="<html>
<p>
Block that has only the basic icon for an input/output,
Boolean block (no declarations, no equations) used especially
in the Blocks.Logical library.
</p>
</html>"));
  equation 
    
  end partialBooleanBlockIcon;
  
  partial block partialBooleanSISO 
    "Partial block with 1 input and 1 output Boolean signal" 
    extends partialBooleanBlockIcon;
           Blocks.Interfaces.BooleanInput u "Connector of Boolean input signal"
                                            annotation(extent=[-140,-20; -100,20]);
           Blocks.Interfaces.BooleanOutput y 
      "Connector of Boolean output signal"   annotation(extent=[100,-10; 120,10]);
    
    annotation (Icon(
        Ellipse(extent=[-71,7; -85,-7], style(
            color=DynamicSelect(30, if u > 0.5 then 2 else 30),
            fillColor=DynamicSelect(30, if u > 0.5 then 2 else 30),
            fillPattern=1)),
   Ellipse(extent=[71,7; 85,-7],     style(
            color=DynamicSelect(30, if y > 0.5 then 2 else 30),
            fillColor=DynamicSelect(30, if y > 0.5 then 2 else 30),
            fillPattern=1))), Documentation(info="<html>
<p>
Block has one continuous Boolean input and one continuous Boolean output signal
with a 3D icon (e.g. used in Blocks.Logical library).
</p>
</html>"));
  equation 
    
  end partialBooleanSISO;
  
  partial block partialBooleanSI2SO 
    "Partial block with 2 input and 1 output Boolean signal" 
    extends partialBooleanBlockIcon;
           Blocks.Interfaces.BooleanInput u1 
      "Connector of first Boolean input signal" 
                                             annotation(extent=[-140,-20; -100,20]);
           Blocks.Interfaces.BooleanInput u2 
      "Connector of second Boolean input signal" 
                                             annotation(extent=[-140,-100; -100,-60]);
           Blocks.Interfaces.BooleanOutput y 
      "Connector of Boolean output signal"   annotation(extent=[100,-10; 120,10]);
    
    annotation (Icon(
   Ellipse(extent=[-71,7; -85,-7],    style(
            color=DynamicSelect(30, if u1 > 0.5 then 2 else 30),
            fillColor=DynamicSelect(30, if u1 > 0.5 then 2 else 30),
            fillPattern=1)),
        Ellipse(extent=[-71,-74; -85,-88], style(
            color=DynamicSelect(30, if u2 > 0.5 then 2 else 30),
            fillColor=DynamicSelect(30, if u2 > 0.5 then 2 else 30),
            fillPattern=1)),
   Ellipse(extent=[71,7; 85,-7],     style(
            color=DynamicSelect(30, if y > 0.5 then 2 else 30),
            fillColor=DynamicSelect(30, if y > 0.5 then 2 else 30),
            fillPattern=1))), Coordsys(grid=[1,1], component=[20,20]),
      Documentation(info="<html>
<p>
Block has two continuous Boolean input and one continuous Boolean output signal
with a 3D icon (e.g. used in Blocks.Logical library).
</p>
</html>"));
    
  end partialBooleanSI2SO;
  
  partial block partialBooleanSI3SO 
    "Partial block with 3 input and 1 output Boolean signal" 
    extends partialBooleanBlockIcon;
           Blocks.Interfaces.BooleanInput u1 
      "Connector of first Boolean input signal" 
                                             annotation(extent=[-140,60; -100,100]);
           Blocks.Interfaces.BooleanInput u2 
      "Connector of second Boolean input signal" 
                                             annotation(extent=[-140,-20; -100,20]);
           Blocks.Interfaces.BooleanInput u3 
      "Connector of third Boolean input signal" 
                                             annotation(extent=[-140,-100; -100,-60]);
           Blocks.Interfaces.BooleanOutput y 
      "Connector of Boolean output signal"   annotation(extent=[100,-10; 120,10]);
    
    annotation (Icon(
        Ellipse(extent=[-71,74; -85,88], style(
            color=DynamicSelect(30, if u1 > 0.5 then 2 else 30),
            fillColor=DynamicSelect(30, if u1 > 0.5 then 2 else 30),
            fillPattern=1)),
   Ellipse(extent=[-71,7; -85,-7],    style(
            color=DynamicSelect(30, if u2 > 0.5 then 2 else 30),
            fillColor=DynamicSelect(30, if u2 > 0.5 then 2 else 30),
            fillPattern=1)),
        Ellipse(extent=[-71,-74; -85,-88], style(
            color=DynamicSelect(30, if u3 > 0.5 then 2 else 30),
            fillColor=DynamicSelect(30, if u3 > 0.5 then 2 else 30),
            fillPattern=1)),
   Ellipse(extent=[71,7; 85,-7],     style(
            color=DynamicSelect(30, if y > 0.5 then 2 else 30),
            fillColor=DynamicSelect(30, if y > 0.5 then 2 else 30),
            fillPattern=1))), Coordsys(grid=[1,1], component=[20,20]),
      Documentation(info="<html>
Block has three continuous Boolean input and one continuous Boolean output signal
with a 3D icon (e.g. used in Blocks.Logical library).
</p>
</html>"));
  end partialBooleanSI3SO;
  
  partial block partialBooleanSI "Partial block with 1 input Boolean signal" 
    extends partialBooleanBlockIcon;
    
           Blocks.Interfaces.BooleanInput u "Connector of Boolean input signal"
                                            annotation(extent=[-140,-20; -100,20]);
    
    annotation (Icon(
        Ellipse(extent=[-71,7; -85,-7],    style(
            color=DynamicSelect(30, if u > 0.5 then 2 else 30),
            fillColor=DynamicSelect(30, if u > 0.5 then 2 else 30),
            fillPattern=1))), Documentation(info="<html>
<p>
Block has one continuous Boolean input signal
with a 3D icon (e.g. used in Blocks.Logical library).
</p>
</html>"));
  equation 
    
  end partialBooleanSI;
  
  partial block partialBooleanSO "Partial block with 1 output Boolean signal" 
    
           Blocks.Interfaces.BooleanOutput y 
      "Connector of Boolean output signal"   annotation(extent=[100,-10; 120,10]);
    extends partialBooleanBlockIcon;
    
    annotation (Icon(
   Ellipse(extent=[71,7; 85,-7],     style(
            color=DynamicSelect(30, if y > 0.5 then 2 else 30),
            fillColor=DynamicSelect(30, if y > 0.5 then 2 else 30),
            fillPattern=1))), Documentation(info="<html>
<p>
Block has one continuous Boolean output signal
with a 3D icon (e.g. used in Blocks.Logical library).
</p>
</html>"));
  equation 
    
  end partialBooleanSO;
  
  partial block partialBooleanSource 
    "Partial source block (has 1 output Boolean signal and an appropriate default icon)" 
    extends partialBooleanBlockIcon;
    
    Blocks.Interfaces.BooleanOutput y "Connector of Boolean output signal" 
      annotation (extent=[100,-10; 120,10]);
    
    annotation (Icon(
        Polygon(points=[-80,88; -88,66; -72,66; -80,88], style(
            color=5,
            fillColor=5)),
        Line(points=[-80,66; -80,-82], style(
            color=5,
            fillColor=5)),
        Line(points=[-90,-70; 72,-70], style(
            color=5,
            fillColor=5)),
        Polygon(points=[90,-70; 68,-62; 68,-78; 90,-70], style(
            color=5,
            fillColor=5)),
   Ellipse(extent=[71,7; 85,-7],     style(
            color=DynamicSelect(30, if y > 0.5 then 2 else 30),
            fillColor=DynamicSelect(30, if y > 0.5 then 2 else 30),
            fillPattern=1))),
        Diagram(
        Polygon(points=[-70,92; -76,70; -64,70; -70,92], style(
            color=10,
            rgbcolor={95,95,95},
            fillColor=10,
            rgbfillColor={95,95,95})),
        Line(points=[-70,70; -70,-88], style(
            color=10,
            rgbcolor={95,95,95},
            fillColor=10,
            rgbfillColor={95,95,95})),
        Line(points=[-90,-70; 68,-70], style(
            color=10,
            rgbcolor={95,95,95},
            fillColor=10,
            rgbfillColor={95,95,95})),
        Polygon(points=[90,-70; 68,-64; 68,-76; 90,-70], style(
            color=10,
            rgbcolor={95,95,95},
            fillColor=10,
            rgbfillColor={95,95,95})),
        Text(
          extent=[54,-80; 106,-92],
          string="time",
          style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=10,
            rgbfillColor={95,95,95})),
        Text(
          extent=[-64,92; -46,74],
          string="y",
          style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=10,
            rgbfillColor={95,95,95}))),
      Documentation(info="<html>
<p>
Basic block for Boolean sources of package Blocks.Sources.
This component has one continuous Boolean output signal y
and a 3D icon (e.g. used in Blocks.Logical library).
</p>
</html>"));
    
  end partialBooleanSource;
  
  partial block partialBooleanThresholdComparison 
    "Partial block to compare the Real input u with a threshold and provide the result as 1 Boolean output signal" 
    
    parameter Real threshold=0 "Comparison with respect to threshold";
    
    Blocks.Interfaces.RealInput u "Connector of Boolean input signal" 
                                  annotation(extent=[-140,-20; -100,20]);
    Blocks.Interfaces.BooleanOutput y "Connector of Boolean output signal" 
                                      annotation (extent=[100,-10; 120,10]);
    
    annotation (Icon(
  Rectangle(extent=[-100,100; 100,-100],   style(
            color=0,
            fillColor=30,
            rgbfillColor={210,210,210},
            fillPattern=11)),
            Text(
          extent=[-150,-140; 150,-110],
          style(color=0),
          string="%threshold"),
   Ellipse(extent=[71,7; 85,-7],     style(
            color=DynamicSelect(30, if y > 0.5 then 2 else 30),
            fillColor=DynamicSelect(30, if y > 0.5 then 2 else 30),
            fillPattern=1))),
        Diagram,
      Documentation(info="<html>
<p>
Block has one continuous Real input and one continuous Boolean output signal
as well as a 3D icon (e.g. used in Blocks.Logical library).
</p>
</html>"));
    
  end partialBooleanThresholdComparison;
  
  partial block partialBooleanComparison 
    "Partial block with 2 Real input and 1 Boolean output signal (the result of a comparison of the two Real inputs" 
    
    Blocks.Interfaces.RealInput u1 "Connector of first Boolean input signal" 
                                   annotation(extent=[-140,-20; -100,20]);
    Blocks.Interfaces.RealInput u2 "Connector of second Boolean input signal" 
                                   annotation(extent=[-140,-100; -100,-60]);
    Blocks.Interfaces.BooleanOutput y "Connector of Boolean output signal" 
      annotation (extent=[100,-10; 120,10]);
    
    annotation (Icon(
  Rectangle(extent=[-100,100; 100,-100],   style(
            color=0,
            fillColor=30,
            rgbfillColor={210,210,210},
            fillPattern=11)),
   Ellipse(extent=[73,7; 87,-7],     style(
            color=DynamicSelect(30, if y > 0.5 then 2 else 30),
            fillColor=DynamicSelect(30, if y > 0.5 then 2 else 30),
            fillPattern=1)),
        Ellipse(extent=[32,10; 52,-10],   style(fillPattern=1)),
        Line(points=[-100,-80; 42,-80; 42,0],    style(fillPattern=1))),
        Diagram,
      Documentation(info="<html>
<p>
Block has two continuous Real input and one continuous Boolean output signal
as a result of the comparision of the two input signals. The block
has a 3D icon (e.g. used in Blocks.Logical library).
</p>
</html>"));
    
  end partialBooleanComparison;
  
package Adaptors 
    "Obsolete package with components to send signals to a bus or receive signals from a bus (only for backward compatibility)" 
    
  extends Modelica.Icons.Library;
    
  block SendReal "Obsolete block to send Real signal to bus" 
    RealOutput toBus "Output signal to be connected to bus" annotation (extent=[100, -10; 120, 10]);
    RealInput u "Input signal to be send to bus" annotation (extent=[-140, -20; -100, 20]);
    annotation (Icon(
        Rectangle(extent=[-100, 40; 100, -40], style(color=73, fillColor=7)),
        Text(
          extent=[-144, 96; 144, 46],
          string="%name",
          style(color=0)),
        Text(
          extent=[-100, 30; 100, -30],
          string="send",
          style(color=73, fillColor=42))), Documentation(info="<html>
<p>
Obsolete block that was previously used to connect a Real signal
to a signal in a connector. This block is only provided for
backward compatibility.
</p>
 
<p>
It is much more convenient and more powerful to use \"expandable connectors\"
for signal buses, see example 
<a href=\"Modelica://Modelica.Blocks.Examples.BusUsage\">BusUsage</a>.
</p>
</html>
"));
  equation 
    toBus = u;
  end SendReal;
    
  block SendBoolean "Obsolete block to send Boolean signal to bus" 
    BooleanOutput toBus "Output signal to be connected to bus" annotation (extent=[100, -10; 120, 10]);
    BooleanInput u "Input signal to be send to bus" annotation (extent=[-140, -20; -100, 20]);
    annotation (Icon(
        Rectangle(extent=[-100, 40; 100, -40], style(color=81, fillColor=7)),
        Text(
          extent=[-144, 96; 144, 46],
          string="%name",
          style(color=0)),
        Text(
          extent=[-100, 30; 100, -30],
          string="send",
          style(color=81, fillColor=42))), Documentation(info="<html>
<p>
Obsolete block that was previously used to connect a Boolean signal
to a signal in a connector. This block is only provided for
backward compatibility.
</p>
 
<p>
It is much more convenient and more powerful to use \"expandable connectors\"
for signal buses, see example 
<a href=\"Modelica://Modelica.Blocks.Examples.BusUsage\">BusUsage</a>.
</p>
</html>
"));
  equation 
    toBus = u;
  end SendBoolean;
    
  block SendInteger "Obsolete block to send Integer signal to bus" 
    IntegerOutput toBus "Output signal to be connected to bus" annotation (extent=[100, -10; 120, 10]);
    IntegerInput u "Input signal to be send to bus" annotation (extent=[-140, -20; -100, 20]);
    annotation (Icon(
        Rectangle(extent=[-100, 40; 100, -40], style(color=45, fillColor=7)),
        Text(
          extent=[-144, 96; 144, 46],
          string="%name",
          style(color=0)),
        Text(
          extent=[-100, 30; 100, -30],
          string="send",
          style(color=45, fillColor=42))), Documentation(info="<html>
<p>
Obsolete block that was previously used to connect an Integer signal
to a signal in a connector. This block is only provided for
backward compatibility.
</p>
 
<p>
It is much more convenient and more powerful to use \"expandable connectors\"
for signal buses, see example 
<a href=\"Modelica://Modelica.Blocks.Examples.BusUsage\">BusUsage</a>.
</p>
</html>"));
  equation 
    toBus = u;
  end SendInteger;
    
  block ReceiveReal "Obsolete block to receive Real signal from bus" 
    RealInput fromBus "To be connected with signal on bus" annotation (extent=[-120, -10; -100, 10]);
    RealOutput y "Output signal to be received from bus" annotation (extent=[100, -10; 120, 10]);
    annotation (Icon(
        Rectangle(extent=[-100, 40; 100, -40], style(color=73, fillColor=7)),
        Text(
          extent=[-100, 30; 100, -30],
          string="receive",
          style(color=73, fillColor=42)),
        Text(
          extent=[-144, 96; 144, 46],
          string="%name",
          style(color=0))), Documentation(info="<html>
<p>
Obsolete block that was previously used to connect a Real signal
in a connector to an input of a block. This block is only provided for
backward compatibility.
</p>
 
<p>
It is much more convenient and more powerful to use \"expandable connectors\"
for signal buses, see example 
<a href=\"Modelica://Modelica.Blocks.Examples.BusUsage\">BusUsage</a>.
</p>
</html>"));
  equation 
    y = fromBus;
  end ReceiveReal;
    
  block ReceiveBoolean "Obsolete block to receive Boolean signal from bus" 
    BooleanInput fromBus "To be connected with signal on bus" annotation (extent=[-120, -10; -100, 10]);
    BooleanOutput y "Output signal to be received from bus" annotation (extent=[100, -10; 120, 10]);
    annotation (Icon(
        Rectangle(extent=[-100, 40; 100, -40], style(color=81, fillColor=7)),
        Text(
          extent=[-100, 30; 100, -30],
          string="receive",
          style(color=81, fillColor=42)),
        Text(
          extent=[-144, 96; 144, 46],
          string="%name",
          style(color=0))), Documentation(info="<html>
<p>
Obsolete block that was previously used to connect a Boolean signal
in a connector to an input of a block. This block is only provided for
backward compatibility.
</p>
 
<p>
It is much more convenient and more powerful to use \"expandable connectors\"
for signal buses, see example 
<a href=\"Modelica://Modelica.Blocks.Examples.BusUsage\">BusUsage</a>.
</p>
</html>"));
  equation 
    y = fromBus;
  end ReceiveBoolean;
    
  block ReceiveInteger "Obsolete block to receive Integer signal from bus" 
    IntegerInput fromBus "To be connected with signal on bus" annotation (extent=[-120, -10; -100, 10]);
    IntegerOutput y "Output signal to be received from bus" annotation (extent=[100, -10; 120, 10]);
    annotation (Icon(
        Rectangle(extent=[-100, 40; 100, -40], style(color=45, fillColor=7)),
        Text(
          extent=[-100, 30; 100, -30],
          string="receive",
          style(color=45, fillColor=42)),
        Text(
          extent=[-144, 96; 144, 46],
          string="%name",
          style(color=0))), Documentation(info="<html>
<p>
Obsolete block that was previously used to connect an Integer signal
in a connector to an input of a block. This block is only provided for
backward compatibility.
</p>
 
<p>
It is much more convenient and more powerful to use \"expandable connectors\"
for signal buses, see example 
<a href=\"Modelica://Modelica.Blocks.Examples.BusUsage\">BusUsage</a>.
</p>
</html>
"));
  equation 
    y = fromBus;
  end ReceiveInteger;
    
model AdaptorReal 
      "Completely obsolete adaptor between 'old' and 'new' Real signal connectors (only for backward compatibility)" 
  RealSignal newReal "Connector of Modelica version 2.1" annotation (extent=[100, -10; 120, 10], Hide=true);
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
  BooleanSignal newBoolean "Connector of Modelica version 2.1" 
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
  IntegerSignal newInteger "Connector of Modelica version 2.1" 
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
    
    annotation (Documentation(info="<html>
<p>
The components of this package should no longer be used.
They are only provided for backward compatibility.
It is much more convenient and more powerful to use \"expandable connectors\"
for signal buses, see example 
<a href=\"Modelica://Modelica.Blocks.Examples.BusUsage\">BusUsage</a>.
</p>
</html>"));
end Adaptors;
  
  partial block PartialConversionBlock 
    "Partial block defining the interface for conversion blocks" 
    
    RealInput u "Connector of Real input signal to be converted" 
      annotation (extent=[-140, -20; -100, 20]);
    RealOutput y 
      "Connector of Real output signal containing input signal u in another unit"
      annotation (extent=[100, -10; 120, 10]);
    annotation (Icon(
        Rectangle(extent=[-100, 100; 100, -100], style(
               color=74,
               rgbcolor={0,0,127},
               fillColor=7, rgbfillColor=
                {255,255,255})),
        Line(points=[-90, 0; 30, 0], style(color=42)),
        Polygon(points=[90, 0; 30, 20; 30, -20; 90, 0], style(color=42,
              fillColor=42)),
        Text(extent=[-115, 155; 115, 105], string="%name")),             Documentation(info="<html>
<p>
This block defines the interface of a conversion block that
converts from one unit into another one.
</p>

</html>"));
    
  end PartialConversionBlock;
end Interfaces;
