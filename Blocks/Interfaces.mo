package Interfaces "Connectors and partial models for input/output blocks" 
  
  extends Modelica.Icons.Library;
  
  annotation( Window(
      x=0.05,
      y=0.09,
      width=0.72,
      height=0.71,
      library=1,
      autolayout=1),
    Documentation(info="<HTML>
<p>
This package contains interface definitions for
<b>continuous</b> input/output blocks. In particular it
contains the following <b>connector</b> classes:
</p>

<pre>
  <b>InPort</b>           Connector with input        signals of type Real.
  <b>OutPort</b>          Connector with output       signals of type Real.
  <b>BooleanInPort</b>    Connector with input        signals of type Boolean.
  <b>BooleanOutPort</b>   Connector with output       signals of type Boolean.
  <b>IntegerInPort</b>    Connector with input        signals of type Integer.
  <b>IntegerOutPort</b>   Connector with output       signals of type Integer.

  <b>RealPort</b>         Connector with input/output signals of type Real.
  <b>BooleanPort</b>      Connector with input/output signals of type Real.
  <b>IntegerPort</b>      Connector with input/output signals of type Real.
</pre>

<p>The following <b>partial</b> block classes are provided
to model <b>continuous</b> control blocks:</p>

<pre>
  <b>BlockIcon</b>     Basic graphical layout of continuous block
  <b>SO</b>            Single Output continuous control block
  <b>MO</b>            Multiple Output continuous control block
  <b>SISO</b>          Single Input Single Output continuous control block
  <b>SI2SO</b>         2 Single Input / 1 Single Output continuous control block
  <b>SIMO</b>          Single Input Multiple Output continuous control block
  <b>MISO</b>          Multiple Input Single Output continuous control block
  <b>MIMO</b>          Multiple Input Multiple Output continuous control block
  <b>MIMOs</b>         Multiple Input Multiple Output continuous control block
                with same number of inputs and outputs
  <b>MI2MO</b>         2 Multiple Input / Multiple Output continuous
                control block
  <b>SignalSource</b>  Base class for continuous signal sources
  <b>SVcontrol</b>     Single-Variable continuous controller
  <b>MVcontrol</b>     Multi-Variable continuous controller
</pre>

<p>
The following <b>partial</b> block classes are provided
to model <b>Boolean</b> control blocks:
</p>

<pre>
  <b>BooleanBlockIcon</b>     Basic graphical layout of Boolean block
  <b>BooleanSISO</b>          Single Input Single Output control block
                       with signals of type Boolean
  <b>BooleanMIMOs</b>         Multiple Input Multiple Output control block
                       with same number of inputs and outputs
  <b>MI2BooleanMOs</b>        2 Multiple Input / Boolean Multiple Output
                       block with same signal lengths
  <b>BooleanSignalSource</b>  Base class for Boolean signal sources
  <b>IntegerMIBooleanMOs</b>  Multiple Integer Input Multiple Boolean Output control block
                       with same number of inputs and outputs
</pre>

<p>
The following <b>partial</b> block classes are provided
to model <b>Integer</b> control blocks:
</p>

<pre>
  <b>IntegerBlockIcon</b>     Basic graphical layout of Integer block
  <b>IntegerMO</b>            Multiple Output control block
  <b>IntegerSignalSource</b>  Base class for Integer signal sources
</pre>

<p>In addition, a subpackage <b>BusAdaptors</b> is temporarily provided
in order to make a signal bus concept available. It will be removed,
when the package Block is revised exploiting new Modelica features.</p>

<dl>
<dt><b>Main Author:</b>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e. V. (DLR)<br>
    Oberpfaffenhofen<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
</dl>
<br>

<p><b>Release Notes:</b></p>
<ul>
<li><i>Oct. 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Added several new interfaces. <a href=\"../Documentation/ChangeNotes1.5.html\">Detailed description</a> available.
<li><i>Oct. 24, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       RealInputSignal renamed to InPort. RealOutputSignal renamed to
       OutPort. GraphBlock renamed to BlockIcon. SISOreal renamed to
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
<br>


<p><b>Copyright &copy; 1999-2002, Modelica Association and DLR.</b></p>

<p><i>
The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".
</i></p>
</HTML>
"));
  connector InPort "Connector with input signals of type Real" 
    parameter Integer n=1 "Dimension of signal vector";
    replaceable type SignalType = Real "type of signal";
    input SignalType signal[n] "Real input signals";
    
    annotation(
      Coordsys(extent=[-100, -100; 100, 100]),
      Icon(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100], style(
              color=3, fillColor=3))),
      Diagram(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100], style(
              color=3, fillColor=3)), Text(
          extent=[-100, -120; 100, -220],
          string="%name",
          style(color=3))),
      Terminal(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100], style(
             color=3, fillColor=3))));
  end InPort;
  
  connector OutPort "Connector with output signals of type Real" 
    parameter Integer n=1 "Dimension of signal vector";
    replaceable type SignalType = Real "type of signal";
    output SignalType signal[n] "Real output signals";
    
    annotation(
      Coordsys(extent=[-100, -100; 100, 100]),
      Icon(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100], style(
              color=3, fillColor=7))),
      Diagram(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100], style(
              color=3, fillColor=7)), Text(
          extent=[-100, -120; 100, -220],
          string="%name",
          style(color=3))),
      Terminal(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100], style(
             color=3, fillColor=7))));
  end OutPort;
  
  connector BooleanInPort "Connector with input signals of type Boolean" 
    parameter Integer n=1 "Dimension of signal vector";
    input Boolean signal[n] "Boolean input signals";
    
    annotation(
      Icon(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100], style(
              color=5, fillColor=5))),
      Diagram(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100], style(
              color=5, fillColor=5)), Text(
          extent=[-100, -120; 100, -220],
          string="%name",
          style(color=5))),
      Terminal(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100], style(
             color=5, fillColor=5))));
  end BooleanInPort;
  
  connector BooleanOutPort "Connector with output signals of type Boolean" 
    parameter Integer n=1 "Dimension of signal vector";
    output Boolean signal[n] "Boolean output signals";
    
    annotation(
      Coordsys(extent=[-100, -100; 100, 100]),
      Icon(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100], style(
              color=5, fillColor=7))),
      Diagram(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100], style(
              color=5, fillColor=7)), Text(
          extent=[-100, -120; 100, -220],
          string="%name",
          style(color=5))),
      Terminal(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100], style(
             color=5, fillColor=7))));
  end BooleanOutPort;
  
  connector IntegerInPort "Connector with input signals of type Integer" 
    parameter Integer n=1 "Dimension of signal vector";
    input Integer signal[n] "Integer input signals";
    
    annotation(
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Icon(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100], style(
              color=45, fillColor=45))),
      Diagram(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100], style(
              color=45, fillColor=45)), Text(
          extent=[-100, -120; 100, -220],
          string="%name",
          style(color=45))),
      Terminal(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100], style(
             color=5, fillColor=5))),
      Window(
        x=0.4,
        y=0.4,
        width=0.6,
        height=0.6));
  end IntegerInPort;
  
  connector IntegerOutPort "Connector with output signals of type Integer" 
    parameter Integer n=1 "Dimension of signal vector";
    output Integer signal[n] "Integer output signals";
    
    annotation(
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Icon(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100], style(
              color=45, fillColor=7))),
      Diagram(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100], style(
              color=45, fillColor=7)), Text(
          extent=[-100, -120; 100, -220],
          string="%name",
          style(color=45))),
      Terminal(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100], style(
             color=5, fillColor=7))),
      Window(
        x=0.4,
        y=0.4,
        width=0.6,
        height=0.6));
  end IntegerOutPort;
  
  partial block BlockIcon "Basic graphical layout of continuous block" 
    annotation( Icon(Rectangle(extent=[-100, -100; 100, 100], style(color=3,
              fillColor=7)), Text(extent=[-150, 150; 150, 110], string="%name")));
  end BlockIcon;
  
  partial block SO "Single Output continuous control block" 
    extends BlockIcon;
    
    OutPort outPort(final n=1) "Connector of Real output signal" annotation(
        extent=[100, -10; 120, 10]);
    annotation(
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.25,
        y=0.02,
        width=0.6,
        height=0.6),
      Diagram);
    output Real y;
  equation 
    y = outPort.signal[1];
  end SO;
  
  partial block MO "Multiple Output continuous control block" 
    extends BlockIcon;
    
    parameter Integer nout(min=1)=  1 "Number of outputs";
    OutPort outPort(final n=nout) "Connector of Real output signals" 
      annotation( extent=[100, -10; 120, 10]);
    annotation(
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.13,
        y=0.03,
        width=0.6,
        height=0.6),
      Documentation(info="
"));
    output Real y[nout];
  equation 
    y = outPort.signal;
  end MO;
  
  partial block SISO "Single Input Single Output continuous control block" 
    extends BlockIcon;
    
    InPort inPort(final n=1) "Connector of Real input signal" annotation(
        extent=[-140, -20; -100, 20]);
    OutPort outPort(final n=1) "Connector of Real output signal" annotation(
        extent=[100, -10; 120, 10]);
    output Real y;
    
    annotation( Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]), Window(
        x=0.32,
        y=0.07,
        width=0.6,
        height=0.6));
  protected 
    Real u=inPort.signal[1];
  equation 
    y = outPort.signal[1];
  end SISO;
  
  partial block SI2SO 
    "2 Single Input / 1 Single Output continuous control block" 
    extends BlockIcon;
    
    InPort inPort1(final n=1) "Connector of Real input signal 1" annotation(
        extent=[-140, 40; -100, 80]);
    InPort inPort2(final n=1) "Connector of Real input signal 2" annotation(
        extent=[-140, -80; -100, -40]);
    OutPort outPort(final n=1) "Connector of Real output signal" annotation(
        extent=[100, -10; 120, 10]);
    output Real y "Output signal";
    
    annotation( Documentation(info="<html><p>
Block has two Input vectors inPort1.signal and inPort2.signal and one
output vector outPort.signal. All vectors have one element.</p></html>
"));
  protected 
    Real u1=inPort1.signal[1] "Input signal 1";
    Real u2=inPort2.signal[1] "Input signal 2";
  equation 
    y = outPort.signal[1];
  end SI2SO;
  
  partial block SIMO "Single Input Multiple Output continuous control block" 
    extends BlockIcon;
    parameter Integer nout=1 "Number of outputs";
    InPort inPort(final n=1) "Connector of Real input signal" annotation(
        extent=[-140, -20; -100, 20]);
    OutPort outPort(final n=nout) "Connector of Real output signals" 
      annotation( extent=[100, -10; 120, 10]);
    output Real y[nout] "Output signals";
    
    annotation( Documentation(info="<HTML>
<p>Block has one continuous input signal and a vector of continuous output
signals.</p>
</HTML>
"));
  protected 
    Real u=inPort.signal[1] "Input signal";
  equation 
    y = outPort.signal;
  end SIMO;
  
  partial block MISO "Multiple Input Single Output continuous control block" 
    extends BlockIcon;
    parameter Integer nin=1 "Number of inputs";
    InPort inPort(final n=nin) "Connector of Real input signals" annotation(
        extent=[-140, -20; -100, 20]);
    OutPort outPort(final n=1) "Connector of Real output signal" annotation(
        extent=[100, -10; 120, 10]);
    output Real y "Output signal";
    
    annotation( Documentation(info="<HTML>
<p>
Block has a vector of continuous input signals and
one continuous output signal.
</p>
</HTML>
"));
  protected 
    Real u[:]=inPort.signal "Input signals";
  equation 
    y = outPort.signal[1];
  end MISO;
  
  partial block MIMO "Multiple Input Multiple Output continuous control block" 
    
    extends BlockIcon;
    parameter Integer nin=1 "Number of inputs";
    parameter Integer nout=1 "Number of outputs";
    InPort inPort(final n=nin) "Connector of Real input signals" annotation(
        extent=[-140, -20; -100, 20]);
    OutPort outPort(final n=nout) "Connector of Real output signals" 
      annotation( extent=[100, -10; 120, 10]);
    output Real y[nout] "Output signals";
    annotation( Documentation(info="<HTML>
<p>
Block has a continuous input and a continuous output signal vector.
The signal sizes of the input and output vector may be different.
</p>
</HTML>
"));
  protected 
    Real u[:]=inPort.signal "Input signals";
  equation 
    y = outPort.signal;
  end MIMO;
  
  partial block MIMOs 
    "Multiple Input Multiple Output continuous control block with same number of inputs and outputs"
    
    
    extends BlockIcon;
    parameter Integer n=1 "Number of inputs (= number of outputs)";
    InPort inPort(final n=n) "Connector of Real input signals" annotation(
        extent=[-140, -20; -100, 20]);
    OutPort outPort(final n=n) "Connector of Real output signals" annotation(
        extent=[100, -10; 120, 10]);
    output Real y[n] "Output signals";
    annotation(
      Documentation(info="<HTML>
<p>
Block has a continuous input and a continuous output signal vector
where the signal sizes of the input and output vector are identical.
</p>
</HTML>
"),   Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.28,
        y=0.16,
        width=0.6,
        height=0.6));
  protected 
    Real u[:]=inPort.signal "Input signals";
  equation 
    y = outPort.signal;
  end MIMOs;
  
  partial block MI2MO 
    "2 Multiple Input / Multiple Output continuous control block" 
    extends BlockIcon;
    
    parameter Integer n=1 "Dimension of input and output vectors.";
    
    InPort inPort1(final n=n) "Connector 1 of Real input signals" annotation(
        extent=[-140, 40; -100, 80]);
    InPort inPort2(final n=n) "Connector 2 of Real input signals" annotation(
        extent=[-140, -80; -100, -40]);
    OutPort outPort(final n=n) "Connector of Real output signals" annotation(
        extent=[100, -10; 120, 10]);
    output Real y[n] "Output signals";
    annotation(
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.31,
        y=0.07,
        width=0.6,
        height=0.6),
      Documentation(info="
Block has two Input vectors inPort1.signal and inPort2.signal and one
output vector outPort.signal. All vectors have the same number of elements.
"));
  protected 
    Real u1[:]=inPort1.signal "Input signals 1";
    Real u2[:]=inPort2.signal "Input signals 2";
  equation 
    y = outPort.signal;
  end MI2MO;
  
  partial block SignalSource "Base class for continuous signal source" 
    extends MO;
    parameter Real offset[:]={0} "offset of output signal";
    parameter SI.Time startTime[:]={0} "output = offset for time < startTime";
  end SignalSource;
  
  partial block SVcontrol "Single-Variable continuous controller" 
    extends BlockIcon;
    
  protected 
    Real u_s "Scalar setpoint input signal";
    Real u_m "Scalar measurement input signal";
  public 
    InPort inPort_s(final n=1) "Connector of setpoint input signal" annotation(
       extent=[-140, -20; -100, 20]);
    InPort inPort_m(final n=1) "Connector of measurement input signal" 
      annotation( extent=[20, -100; -20, -140], rotation=-90);
    OutPort outPort(final n=1) "Connector of actuator output signal" 
      annotation( extent=[100, -10; 120, 10]);
    output Real y "Scalar actuator output signal";
    annotation(
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
        height=0.46));
  equation 
    u_s = inPort_s.signal[1];
    u_m = inPort_m.signal[1];
    y = outPort.signal[1];
  end SVcontrol;
  
  partial block MVcontrol "Multi-Variable continuous controller" 
    extends BlockIcon;
    
    parameter Integer nu_s=1 "Number of setpoint inputs";
    parameter Integer nu_m=1 "Number of measurement inputs";
    parameter Integer ny=1 "Number of actuator outputs";
    InPort inPort_s(final n=nu_s) "Connector of setpoint input signals" 
      annotation( extent=[-140, -20; -100, 20]);
    InPort inPort_m(final n=nu_m) "Connector of measurement input signals" 
      annotation( extent=[20, -100; -20, -140], rotation=-90);
    OutPort outPort(final n=ny) "Connector of actuator output signals" 
      annotation( extent=[100, -10; 120, 10]);
    annotation( Diagram(
        Text(extent=[-100, 36; -140, 26], string="(setpoint)"),
        Text(extent=[102, 24; 142, 14], string="(actuator)"),
        Text(extent=[-75, -108; -25, -98], string=" (measurement)")));
  end MVcontrol;
  
  partial block BooleanBlockIcon "Basic graphical layout of Boolean block" 
    annotation( Icon(Rectangle(extent=[-100, -100; 100, 100], style(color=5,
              fillColor=7)), Text(extent=[-150, 150; 150, 110], string="%name")));
  end BooleanBlockIcon;
  
  partial block BooleanSISO 
    "Single Input Single Output control block with signals of type Boolean" 
    extends BooleanBlockIcon;
    
  public 
    BooleanInPort inPort(final n=1) "Connector of Boolean input signal" 
      annotation( extent=[-140, -20; -100, 20]);
    BooleanOutPort outPort(final n=1) "Connector of Boolean output signal" 
      annotation( extent=[100, -10; 120, 10]);
    output Boolean y;
    
    annotation( Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]), Window(
        x=0.37,
        y=0.14,
        width=0.6,
        height=0.6));
  protected 
    Boolean u=inPort.signal[1];
  equation 
    y = outPort.signal[1];
  end BooleanSISO;
  
  partial block BooleanMIMOs 
    "Multiple Input Multiple Output continuous control block with same number of inputs and outputs of boolean type"
    
    
    extends BooleanBlockIcon;
    parameter Integer n=1 "Number of inputs (= number of outputs)";
    BooleanInPort inPort(final n=n) "Connector of Boolean input signals" 
      annotation( extent=[-140, -20; -100, 20]);
    BooleanOutPort outPort(final n=n) "Connector of Boolean output signals" 
      annotation( extent=[100, -10; 120, 10]);
    output Boolean y[n] "Output signals";
    annotation( Documentation(info="<HTML>
<p>
Block has a continuous input and a continuous output signal vector
where the signal sizes of the input and output vector are identical
and of type boolean.
</p>
</HTML>
"));
  protected 
    Boolean u[:]=inPort.signal "Input signals";
  equation 
    y = outPort.signal;
  end BooleanMIMOs;
  
  partial block MI2BooleanMOs 
    "2 Multiple Input / Boolean Multiple Output block with same signal lengths"
    
    
    extends BooleanBlockIcon;
    parameter Integer n=1 "Dimension of input and output vectors.";
    InPort inPort1(final n=n) "Connector 1 of Boolean input signals" 
      annotation( extent=[-140, 40; -100, 80]);
    InPort inPort2(final n=n) "Connector 2 of Boolean input signals" 
      annotation( extent=[-140, -80; -100, -40]);
    BooleanOutPort outPort(final n=n) "Connector of Boolean output signals" 
      annotation( extent=[100, -10; 120, 10]);
    annotation( Documentation(info="<html>
<p>Block has two Boolean input vectors u1 and u2 and one Boolean output
vector y. All vectors have the same number of elements.</p>
</html>
"));
  end MI2BooleanMOs;
  
  partial block BooleanSignalSource "Base class for Boolean signal sources" 
    extends BooleanBlockIcon;
    parameter Integer nout(min=1)=  1 "Number of Boolean outputs";
    BooleanOutPort outPort(final n=nout) "Connector of Boolean output signal" 
      annotation( extent=[100, -10; 120, 10]);
    annotation(
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
              fillColor=8))));
  end BooleanSignalSource;
  
  partial block IntegerBlockIcon "Basic graphical layout of Integer block" 
    annotation( Icon(Rectangle(extent=[-100, -100; 100, 100], style(color=45,
              fillColor=7)), Text(extent=[-150, 150; 150, 110], string="%name")));
  end IntegerBlockIcon;
  
  partial block IntegerMO "Multiple Integer Output continuous control block" 
    extends IntegerBlockIcon;
    
    parameter Integer nout(min=1)=  1 "Number of outputs";
    IntegerOutPort outPort(final n=nout) "Connector of Integer output signals" 
      annotation( extent=[100, -10; 120, 10]);
    output Integer y[nout];
  equation 
    y = outPort.signal;
  end IntegerMO;
  
  partial block IntegerSignalSource 
    "Base class for continuous Integer signal source" 
    extends IntegerMO;
    parameter Integer offset[:]={0} "offset of output signal";
    parameter SI.Time startTime[:]={0} "output = offset for time < startTime";
  end IntegerSignalSource;
  
  partial block IntegerMIBooleanMOs 
    "Multiple Integer Input Multiple Boolean Output continuous control block with same number of inputs and outputs"
    
    
    extends BooleanBlockIcon;
    parameter Integer n=1 "Number of inputs (= number of outputs)";
    IntegerInPort inPort(final n=n) "Connector of Integer input signals" 
      annotation( extent=[-140, -20; -100, 20]);
    BooleanOutPort outPort(final n=n) "Connector of Boolean output signals" 
      annotation( extent=[100, -10; 120, 10]);
    output Boolean y[n] "Boolean output signals";
    annotation( Documentation(info="<HTML>
<p>
Block has a continuous integer input and a continuous boolean output signal vector
where the signal sizes of the input and output vector are identical.
</p>
</HTML>
"));
  protected 
    Integer u[n]=inPort.signal "Input signals";
  equation 
    y = outPort.signal;
  end IntegerMIBooleanMOs;
  
  connector RealPort "Real port (both input/output possible)" 
    replaceable type SignalType = Real;
    extends SignalType;
  end RealPort;
  
  /*connector RealPort "Connector with input signals of type Real"
    parameter Integer n=1 "Dimension of signal vector";
    replaceable type SignalType = Real "type of signal";
    SignalType signal[n] "Real input signals";

    annotation (
      Icon(
        Polygon(
          points=[-100, 100; 100, 0; -100, -100; -100, 100],
          style(color=3, fillColor=3))),
      Diagram(
        Polygon(
          points=[-100, 100; 100, 0; -100, -100; -100, 100],
          style(color=3, fillColor=3)),
        Text(
          extent=[-100, -120; 100, -220],
          string="%name",
          style(color=3))),
      Terminal(
        Polygon(
          points=[-100, 100; 100, 0; -100, -100; -100, 100],
          style(color=3, fillColor=3))));
  end RealPort; */
  
  connector BooleanPort = Boolean "Boolean port (both input/output possible)";
  
  connector IntegerPort = Integer "Integer port (both input/output possible)";
  
  package BusAdaptors 
    "Components to send signals to the bus or receive signals from the bus" 
    
    extends Modelica.Icons.Library;
    
    block SendReal "Send Real signal to bus" 
      Internal.OutputReal toBus annotation( extent=[100, -10; 120, 10]);
      InPort inPort(final n=1) annotation( extent=[-140, -20; -100, 20]);
      annotation( Icon(
          Rectangle(extent=[-100, 40; 100, -40], style(color=73, fillColor=7)),
          Text(
            extent=[-144, 96; 144, 46],
            string="%name",
            style(color=0)),
          Text(
            extent=[-100, 30; 100, -30],
            string="send",
            style(color=73, fillColor=42))), Documentation(info="<HTML>
<p>
Converts an InPort connector to a signal which can be connected to the
signal bus. Connect connector 'toBus' with the signal bus. A pop-up
dialog appears which allows to specify the signal from the bus
which is set equal to the signal of the InPort connector.
</p>

</HTML>
"));
    equation 
      toBus = inPort.signal[1];
    end SendReal;
    
    block SendBoolean "Send Boolean signal to bus" 
      Internal.OutputBoolean toBus annotation( extent=[100, -10; 120, 10]);
      BooleanInPort inPort(final n=1) annotation( extent=[-140, -20; -100, 20]);
      annotation( Icon(
          Rectangle(extent=[-100, 40; 100, -40], style(color=81, fillColor=7)),
          Text(
            extent=[-144, 96; 144, 46],
            string="%name",
            style(color=0)),
          Text(
            extent=[-100, 30; 100, -30],
            string="send",
            style(color=81, fillColor=42))), Documentation(info="<HTML>
<p>
Converts a BooleanInPort connector to a signal which can be connected to the
signal bus. Connect connector 'toBus' with the signal bus. A pop-up
dialog appears which allows to specify the signal from the bus
which is set equal to the signal of the BooleanInPort connector.
</p>

</HTML>
"));
    equation 
      toBus = inPort.signal[1];
    end SendBoolean;
    
    block SendInteger "Send Integer signal to bus" 
      Internal.OutputInteger toBus annotation( extent=[100, -10; 120, 10]);
      IntegerInPort inPort(final n=1) annotation( extent=[-140, -20; -100, 20]);
      annotation( Icon(
          Rectangle(extent=[-100, 40; 100, -40], style(color=45, fillColor=7)),
          Text(
            extent=[-144, 96; 144, 46],
            string="%name",
            style(color=0)),
          Text(
            extent=[-100, 30; 100, -30],
            string="send",
            style(color=45, fillColor=42))), Documentation(info="<HTML>
<p>
Converts an IntegerInPort connector to a signal which can be connected to the
signal bus. Connect connector 'toBus' with the signal bus. A pop-up
dialog appears which allows to specify the signal from the bus
which is set equal to the signal of the IntegerInPort connector.
</p>

</HTML>
"));
    equation 
      toBus = inPort.signal[1];
    end SendInteger;
    
    block ReceiveReal "Receive Real signal from bus" 
      Internal.InputReal fromBus annotation( extent=[-120, -10; -100, 10]);
      OutPort outPort(final n=1) annotation( extent=[100, -10; 120, 10]);
      annotation( Icon(
          Rectangle(extent=[-100, 40; 100, -40], style(color=73, fillColor=7)),
          Text(
            extent=[-100, 30; 100, -30],
            string="receive",
            style(color=73, fillColor=42)),
          Text(
            extent=[-144, 96; 144, 46],
            string="%name",
            style(color=0))), Documentation(info="<HTML>
<p>
Converts a signal from the signal bus to an OutPort connector. Use this
element by connecting connector 'fromBus' with the signal bus. A pop-up
dialog appears which allows to specify the signal from the bus
which is set equal to the signal of the OutPort connector.
</p>

</HTML>
"));
    equation 
      fromBus = outPort.signal[1];
    end ReceiveReal;
    
    block ReceiveBoolean "Receive Boolean signal from bus" 
      Internal.InputBoolean fromBus annotation( extent=[-120, -10; -100, 10]);
      BooleanOutPort outPort(final n=1) annotation( extent=[100, -10; 120, 10]);
      annotation( Icon(
          Rectangle(extent=[-100, 40; 100, -40], style(color=81, fillColor=7)),
          Text(
            extent=[-100, 30; 100, -30],
            string="receive",
            style(color=81, fillColor=42)),
          Text(
            extent=[-144, 96; 144, 46],
            string="%name",
            style(color=0))), Documentation(info="<HTML>
<p>
Converts a signal from the signal bus to a BooleanOutPort connector. Use this
element by connecting connector 'fromBus' with the signal bus. A pop-up
dialog appears which allows to specify the signal from the bus
which is set equal to the signal of the BooleanOutPort connector.
</p>

</HTML>
"));
    equation 
      fromBus = outPort.signal[1];
    end ReceiveBoolean;
    
    block ReceiveInteger "Receive Integer signal from bus" 
      Internal.InputInteger fromBus annotation( extent=[-120, -10; -100, 10]);
      IntegerOutPort outPort(final n=1) annotation( extent=[100, -10; 120, 10]);
      annotation( Icon(
          Rectangle(extent=[-100, 40; 100, -40], style(color=45, fillColor=7)),
          Text(
            extent=[-100, 30; 100, -30],
            string="receive",
            style(color=45, fillColor=42)),
          Text(
            extent=[-144, 96; 144, 46],
            string="%name",
            style(color=0))), Documentation(info="<HTML>
<p>
Converts a signal from the signal bus to an IntegerOutPort connector. Use this
element by connecting connector 'fromBus' with the signal bus. A pop-up
dialog appears which allows to specify the signal from the bus
which is set equal to the signal of the IntegerOutPort connector.
</p>

</HTML>
"));
    equation 
      fromBus = outPort.signal[1];
    end ReceiveInteger;
    
    package Internal 
      "Internal connector definitions only to be used from models of package BusAdaptors"
      
      
      extends Modelica.Icons.Library;
      
      connector InputReal = input Real "'input Real' variable as connector" 
        annotation( Icon(Rectangle(extent=[-100, 100; 100, -100], style(
              color=77,
              fillColor=77,
              fillPattern=1)), Text(
            extent=[-132, -100; 132, -198],
            string="%name",
            style(color=77))), Diagram(Rectangle(extent=[-100, 100; 100, -100],
                style(
              color=77,
              fillColor=77,
              fillPattern=1)), Text(
            extent=[-132, -100; 132, -198],
            string="%name",
            style(color=77))));
      connector InputBoolean = input Boolean 
        "'input Boolean' variable as connector" annotation( Icon(Rectangle(
              extent=[-100, 100; 100, -100], style(
              color=77,
              fillColor=77,
              fillPattern=1)), Text(
            extent=[-132, -100; 132, -198],
            string="%name",
            style(color=77))), Diagram(Rectangle(extent=[-100, 100; 100, -100],
                style(
              color=77,
              fillColor=77,
              fillPattern=1)), Text(
            extent=[-132, -100; 132, -198],
            string="%name",
            style(color=77))));
      connector InputInteger = input Integer 
        "'input Integer' variable as connector" annotation( Icon(Rectangle(
              extent=[-100, 100; 100, -100], style(
              color=77,
              fillColor=77,
              fillPattern=1)), Text(
            extent=[-132, -100; 132, -198],
            string="%name",
            style(color=77))), Diagram(Rectangle(extent=[-100, 100; 100, -100],
                style(
              color=77,
              fillColor=77,
              fillPattern=1)), Text(
            extent=[-132, -100; 132, -198],
            string="%name",
            style(color=77))));
      connector OutputReal = output Real "'output Real' variable as connector" 
        annotation( Icon(Rectangle(extent=[-100, 100; 100, -100], style(
              color=77,
              fillColor=77,
              fillPattern=1)), Text(
            extent=[-132, -100; 132, -198],
            string="%name",
            style(color=77))), Diagram(Rectangle(extent=[-100, 100; 100, -100],
                style(
              color=77,
              fillColor=77,
              fillPattern=1)), Text(
            extent=[-132, -100; 132, -198],
            string="%name",
            style(color=77))));
      connector OutputBoolean = output Boolean 
        "'output Boolean' variable as connector" annotation( Icon(Rectangle(
              extent=[-100, 100; 100, -100], style(
              color=77,
              fillColor=77,
              fillPattern=1)), Text(
            extent=[-132, -100; 132, -198],
            string="%name",
            style(color=77))), Diagram(Rectangle(extent=[-100, 100; 100, -100],
                style(
              color=77,
              fillColor=77,
              fillPattern=1)), Text(
            extent=[-132, -100; 132, -198],
            string="%name",
            style(color=77))));
      connector OutputInteger = output Integer 
        "'output Integer' variable as connector" annotation( Icon(Rectangle(
              extent=[-100, 100; 100, -100], style(
              color=77,
              fillColor=77,
              fillPattern=1)), Text(
            extent=[-132, -100; 132, -198],
            string="%name",
            style(color=77))), Diagram(Rectangle(extent=[-100, 100; 100, -100],
                style(
              color=77,
              fillColor=77,
              fillPattern=1)), Text(
            extent=[-132, -100; 132, -198],
            string="%name",
            style(color=77))));
    end Internal;
  end BusAdaptors;
end Interfaces;
