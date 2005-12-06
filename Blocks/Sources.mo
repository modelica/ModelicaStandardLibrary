package Sources "Signal source blocks generating Real and Boolean signals" 
  block RealExpression "Set output signal to a time varying Real expression" 
    Blocks.Interfaces.RealOutput y=0.0 "Value of Real output" 
      annotation (extent=[100, -10; 120, 10], Dialog(group=
            "Time varying output signal"));
    
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.29,
        y=0.23,
        width=0.6,
        height=0.6),
      Icon(
        Rectangle(extent=[-100,40; 100,-40],   style(
            color=0,
            fillColor=30,
            fillPattern=11)),
        Text(
          extent=[-96,15; 96,-15],
          string="%y",
          style(
            color=0,
            fillColor=2,
            fillPattern=1)), Text(extent=[-150,90; 140,50],     string="%name")),
      Diagram);
    
  end RealExpression;
  
  block IntegerExpression 
    "Set output signal to a time varying Integer expression" 
    Blocks.Interfaces.IntegerOutput y=0 "Value of Integer output" 
      annotation (extent=[100, -10; 120, 10], Dialog(group=
            "Time varying output signal"));
    
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.29,
        y=0.23,
        width=0.6,
        height=0.6),
      Icon(
        Rectangle(extent=[-100,40; 100,-40],   style(
            color=0,
            fillColor=30,
            fillPattern=11)),
        Text(
          extent=[-96,15; 96,-15],
          string="%y",
          style(
            color=0,
            fillColor=2,
            fillPattern=1)), Text(extent=[-150,90; 140,50],     string="%name")),
      Diagram);
    
  end IntegerExpression;
  
  block BooleanExpression 
    "Set output signal to a time varying Boolean expression" 
    Blocks.Interfaces.BooleanOutput y=false "Value of Boolean output" 
      annotation (extent=[100, -10; 120, 10], Dialog(group=
            "Time varying output signal"));
    
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.29,
        y=0.23,
        width=0.6,
        height=0.6),
      Icon(
        Rectangle(extent=[-100,40; 100,-40],   style(
            color=0,
            fillColor=30,
            fillPattern=11)),
        Text(
          extent=[-96,15; 96,-15],
          string="%y",
          style(
            color=0,
            fillColor=2,
            fillPattern=1)), Text(extent=[-150,90; 140,50],     string="%name"),
  Polygon(points=[100,10; 120,0; 100,-10; 100,10],
             style(color=DynamicSelect(5, if y > 0.5 then 2 else 5),
              fillColor=DynamicSelect(7, if y > 0.5 then 2 else 7)))),
      Diagram);
    
  end BooleanExpression;
  import Modelica.Blocks.Interfaces;
  import Modelica.SIunits;
      extends Modelica.Icons.Library;
  
      annotation(preferedView="info",
        Coordsys(
          extent=[0, 0; 430, 442],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.06,
          y=0.1,
          width=0.43,
          height=0.65,
          library=1,
          autolayout=1),
        Documentation(info="<HTML>
<p>
This package contains <b>source</b> components, i.e., blocks which
have only output signals. These blocks are used as signal generators.
</p>
<p>The following <b>sources</b> are provided to generate <b>Real</b> signals:</p>
<pre>
  <b>Clock</b>             Generate actual time.
  <b>Constant</b>          Generate constant signals.
  <b>Step</b>              Generate step signals.
  <b>Ramp</b>              Generate ramp signals.
  <b>Sine</b>              Generate sine signals.
  <b>ExpSine</b>           Generate exponentially damped sine signals.
  <b>Exponentials</b>      Generate a rising and falling exponential signal.
  <b>Pulse</b>             Generate pulse signals.
  <b>SawTooth</b>          Generate sawtooth signals.
  <b>Trapezoid</b>         Generate trapezoidal signals.
  <b>KinematicPTP</b>      Generate an acceleration signal to move as fast as
                    possible along a distance within given kinematic constraints.
  <b>TimeTable</b>         Generate a (possibly discontinuous) signal by
                    linear interpolation in a table.
</pre
<p>
The following <b>sources</b> are provided to generate <b>Boolean</b> signals:
</p>
<pre>
  <b>BooleanExpression</b> Generate signal by a Boolean expression
  <b>BooleanConstant</b>   Generate constant signals.
  <b>BooleanStep</b>       Generate step signals.
  <b>BooleanPulse</b>      Generate pulse signals.
  <b>SampleTrigger</b>     Generate sample triggers.
</pre>
<p>The following <b>sources</b> are provided to generate <b>Integer</b> signals:</p>
<pre>
  <b>IntegerConstant</b>   Generate constant signals.
  <b>IntegerStep</b>       Generate step signals.
</pre>
<p>
All Real source signals (with the exception of the Constant source)
have at least the following two parameters:
</p>
<pre>
   <b>offset</b>       Value which is added to the signal.
   <b>startTime</b>    Start time of signal. For time &lt; startTime,
                the output y is set to offset.
</pre>
<p>
The <b>offset</b> parameter is especially useful in order to shift
the corresponding source, such that at initial time the system
is stationary. To determine the corresponding value of offset,
usually requires a trimming calculation.
</p>
</HTML>
", revisions="<html>
<ul>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Integer sources added. Step, TimeTable and BooleanStep slightly changed.</li>
<li><i>Nov. 8, 1999</i>
       by <a href=\"mailto:clauss@eas.iis.fhg.de\">Christoph Clau&szlig;</a>,
       <A HREF=\"mailto:schneider@eas.iis.fhg.de\">schneider@eas.iis.fhg.de</A>,
       <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       New sources: Exponentials, TimeTable. Trapezoid slightly enhanced
       (nperiod=-1 is an infinite number of periods).</li>
<li><i>Oct. 31, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       <a href=\"mailto:clauss@eas.iis.fhg.de\">Christoph Clau&szlig;</a>,
       <A HREF=\"mailto:schneider@eas.iis.fhg.de\">schneider@eas.iis.fhg.de</A>,
       All sources vectorized. New sources: ExpSine, Trapezoid,
       BooleanConstant, BooleanStep, BooleanPulse, SampleTrigger.
       Improved documentation, especially detailed description of
       signals in diagram layer.</li>
<li><i>June 29, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized a first version, based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist.</li>
</ul>
</html>"));
      block Clock "Generate actual time signal " 
        parameter Real offset=0 "Offset of output signal";
        parameter SIunits.Time startTime=0 
      "Output = offset for time < startTime";
        extends Interfaces.SO;
    
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[1, 1],
            component=[20, 20]),
          Window(
            x=0.26,
            y=0,
            width=0.36,
            height=0.52),
          Icon(
            Ellipse(extent=[-80, 80; 80, -80], style(color=9)),
            Line(points=[0, 80; 0, 60], style(color=9)),
            Line(points=[80, 0; 60, 0], style(color=9)),
            Line(points=[0, -80; 0, -60], style(color=9)),
            Line(points=[-80, 0; -60, 0], style(color=9)),
            Line(points=[37, 70; 26, 50], style(color=9)),
            Line(points=[70, 38; 49, 26], style(color=9)),
            Line(points=[71, -37; 52, -27], style(color=9)),
            Line(points=[39, -70; 29, -51], style(color=9)),
            Line(points=[-39, -70; -29, -52], style(color=9)),
            Line(points=[-71, -37; -50, -26], style(color=9)),
            Line(points=[-71, 37; -54, 28], style(color=9)),
            Line(points=[-38, 70; -28, 51], style(color=9)),
            Line(points=[0, 0; -50, 50], style(color=0, thickness=2)),
            Line(points=[0, 0; 40, 0], style(color=0, thickness=2)),
            Text(
              extent=[-150, -150; 150, -110],
              string="startTime=%startTime",
              style(color=0))),
          Diagram(
            Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
                   fillColor=8)),
            Line(points=[-80, 68; -80, -80], style(color=8)),
            Line(points=[-80, 0; -10, 0; 60, 70], style(color=0, thickness=2)),
            Line(points=[-90, -70; 82, -70], style(color=8)),
            Polygon(points=[90, -70; 68, -62; 68, -78; 90, -70], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Polygon(points=[-34, 0; -37, -13; -30, -13; -34, 0], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Line(points=[-34, -13; -34, -70], style(
                color=8,
                pattern=1,
                thickness=1,
                arrow=0)),
            Polygon(points=[-34, -69; -37, -56; -31, -56; -34, -69; -34, -69],
                style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Text(
              extent=[-81, -25; -35, -43],
              string="offset",
              style(color=9)),
            Text(
              extent=[-33, -71; 13, -89],
              string="startTime",
              style(color=9)),
            Text(
              extent=[-66, 92; -25, 72],
              string="y",
              style(color=9)),
            Text(
              extent=[70, -80; 94, -100],
              string="time",
              style(color=9)),
            Line(points=[-10, 0; -10, -70], style(color=8, pattern=2)),
            Line(points=[-10, 0; 50, 0], style(color=8, pattern=2)),
            Line(points=[50, 0; 50, 60], style(color=8, pattern=2)),
            Text(
              extent=[35, 33; 50, 23],
              string="1",
              style(color=9)),
            Text(
              extent=[14, 13; 32, 1],
              string="1",
              style(color=9))));
    
      equation 
        y = offset + (if time < startTime then 0 else time - startTime);
      end Clock;
  
      block Constant "Generate constant signal of type Real" 
        parameter Real k=1 "Constant output value";
        extends Interfaces.SO;
    
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.29,
            y=0.19,
            width=0.6,
            height=0.6),
          Icon(
            Line(points=[-80, 68; -80, -80], style(color=8)),
            Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
                   fillColor=8)),
            Line(points=[-90, -70; 82, -70], style(color=8)),
            Polygon(points=[90, -70; 68, -62; 68, -78; 90, -70], style(color=8,
                   fillColor=8)),
            Line(points=[-80, 0; 80, 0], style(color=0)),
            Text(
              extent=[-150, -150; 150, -110],
              string="k=%k",
              style(color=0))),
          Diagram(
            Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
                   fillColor=8)),
            Line(points=[-80, 68; -80, -80], style(color=8)),
            Line(points=[-80, 0; 80, 0], style(color=0, thickness=2)),
            Line(points=[-90, -70; 82, -70], style(color=8)),
            Polygon(points=[90, -70; 68, -62; 68, -78; 90, -70], style(color=8,
                   fillColor=8)),
            Text(
              extent=[-75, 94; -22, 76],
              string="y",
              style(color=9)),
            Text(
              extent=[70, -80; 94, -100],
              string="time",
              style(color=9)),
            Text(
              extent=[-101, 8; -81, -12],
              string="k",
              style(color=9))));
      equation 
        y = k;
      end Constant;
  
      block Step "Generate step signal of type Real" 
        parameter Real height=1 "Height of step";
        extends Interfaces.SignalSource;
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[1, 1],
            component=[20, 20]),
          Window(
            x=0.38,
            y=0.11,
            width=0.6,
            height=0.6),
          Icon(
            Line(points=[-80, 68; -80, -80], style(color=8)),
            Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
                   fillColor=8)),
            Line(points=[-90, -70; 82, -70], style(color=8)),
            Polygon(points=[90, -70; 68, -62; 68, -78; 90, -70], style(color=8,
                   fillColor=8)),
            Line(points=[-80, -70; 0, -70; 0, 50; 80, 50], style(color=0)),
            Text(
              extent=[-150, -150; 150, -110],
              string="startTime=%startTime",
              style(color=0))),
          Diagram(
            Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
                   fillColor=8)),
            Line(points=[-80, 68; -80, -80], style(color=8)),
            Line(points=[-80, -18; 0, -18; 0, 50; 80, 50], style(color=0,
                  thickness=2)),
            Line(points=[-90, -70; 82, -70], style(color=8)),
            Polygon(points=[90, -70; 68, -62; 68, -78; 90, -70], style(color=8,
                   fillColor=8)),
            Text(
              extent=[70, -80; 94, -100],
              string="time",
              style(color=9)),
            Text(
              extent=[-21, -72; 25, -90],
              string="startTime",
              style(color=9)),
            Line(points=[0, -17; 0, -71], style(color=8, pattern=2)),
            Text(
              extent=[-68, -36; -22, -54],
              string="offset",
              style(color=9)),
            Line(points=[-13, 50; -13, -17], style(
                color=8,
                pattern=1,
                thickness=1,
                arrow=0)),
            Polygon(points=[2, 50; -19, 50; 2, 50], style(color=8, pattern=2)),
            Polygon(points=[-13, -17; -16, -4; -10, -4; -13, -17; -13, -17],
                style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Polygon(points=[-13, 50; -16, 37; -9, 37; -13, 50], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Text(
              extent=[-68, 26; -22, 8],
              string="height",
              style(color=9)),
            Polygon(points=[-13, -69; -16, -56; -10, -56; -13, -69; -13, -69],
                style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Line(points=[-13, -18; -13, -70], style(
                color=8,
                pattern=1,
                thickness=1,
                arrow=0)),
            Polygon(points=[-13, -18; -16, -31; -9, -31; -13, -18], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Text(
              extent=[-72, 100; -31, 80],
              string="y",
              style(color=9))));
    
      equation 
        y = offset + (if time < startTime then 0 else height);
      end Step;
  
      block Ramp "Generate ramp signal" 
        parameter Real height=1 "Height of ramps";
        parameter Real duration(min=Modelica.Constants.small) = 2 
      "Durations of ramp";
        parameter Real offset=0 "Offset of output signal";
        parameter SIunits.Time startTime=0 
      "Output = offset for time < startTime";
        extends Interfaces.SO;
    
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[1, 1],
            component=[20, 20]),
          Window(
            x=0.19,
            y=0.02,
            width=0.59,
            height=0.77),
          Icon(
            Line(points=[-80, 68; -80, -80], style(color=8)),
            Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
                   fillColor=8)),
            Line(points=[-90, -70; 82, -70], style(color=8)),
            Polygon(points=[90, -70; 68, -62; 68, -78; 90, -70], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Line(points=[-80, -70; -40, -70; 31, 38], style(color=0)),
            Text(
              extent=[-150, -150; 150, -110],
              string="duration=%duration",
              style(color=0)),
            Line(points=[31, 38; 86, 38], style(color=0))),
          Diagram(
            Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
                   fillColor=8)),
            Line(points=[-80, 68; -80, -80], style(color=8)),
            Line(points=[-80, -20; -20, -20; 50, 50], style(color=0, thickness=
                    2)),
            Line(points=[-90, -70; 82, -70], style(color=8)),
            Polygon(points=[90, -70; 68, -62; 68, -78; 90, -70], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Polygon(points=[-40, -20; -42, -30; -37, -30; -40, -20], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Line(points=[-40, -20; -40, -70], style(
                color=8,
                pattern=1,
                thickness=1,
                arrow=0)),
            Polygon(points=[-40, -70; -43, -60; -38, -60; -40, -70; -40, -70],
                style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Text(
              extent=[-80, -33; -41, -49],
              string="offset",
              style(color=9)),
            Text(
              extent=[-40, -70; 6, -88],
              string="startTime",
              style(color=9)),
            Text(
              extent=[-66, 92; -25, 72],
              string="y",
              style(color=9)),
            Text(
              extent=[70, -80; 94, -100],
              string="time",
              style(color=9)),
            Line(points=[-20, -20; -20, -70], style(color=8, pattern=2)),
            Line(points=[-19, -20; 50, -20], style(
                color=8,
                pattern=1,
                thickness=1,
                arrow=0)),
            Line(points=[50, 50; 101, 50], style(color=0, thickness=2)),
            Line(points=[50, 50; 50, -20], style(
                color=8,
                pattern=1,
                thickness=1,
                arrow=0)),
            Polygon(points=[50, -20; 42, -18; 42, -22; 50, -20], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Polygon(points=[-20, -20; -11, -18; -11, -22; -20, -20], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Polygon(points=[50, 50; 48, 40; 53, 40; 50, 50], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Polygon(points=[50, -20; 47, -10; 52, -10; 50, -20; 50, -20], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Text(
              extent=[53, 25; 82, 7],
              string="height",
              style(color=9)),
            Text(
              extent=[0, -17; 35, -37],
              string="duration",
              style(color=9))));
      equation 
        y = offset + (if time < startTime then 0 else if time < (startTime +
          duration) then (time - startTime)*height/duration else height);
      end Ramp;
  
      block Sine "Generate sine signal" 
        parameter Real amplitude=1 "Amplitude of sine wave";
        parameter SIunits.Frequency freqHz=1 "Frequency of sine wave";
        parameter SIunits.Angle phase=0 "Phase of sine wave";
        parameter Real offset=0 "Offset of output signal";
        parameter SIunits.Time startTime=0 
      "Output = offset for time < startTime";
        extends Interfaces.SO;
  protected 
        constant Real pi=Modelica.Constants.pi;
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[1, 1],
            component=[20, 20]),
          Window(
            x=0.23,
            y=0.08,
            width=0.66,
            height=0.68),
          Icon(
            Line(points=[-80, 68; -80, -80], style(color=8)),
            Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
                   fillColor=8)),
            Line(points=[-90, 0; 68, 0], style(color=8)),
            Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8,
                  fillColor=8)),
            Line(points=[-80, 0; -68.7, 34.2; -61.5, 53.1; -55.1, 66.4; -49.4,
                  74.6; -43.8, 79.1; -38.2, 79.8; -32.6, 76.6; -26.9, 69.7; -21.3,
                   59.4; -14.9, 44.1; -6.83, 21.2; 10.1, -30.8; 17.3, -50.2;
                  23.7, -64.2; 29.3, -73.1; 35, -78.4; 40.6, -80; 46.2, -77.6;
                  51.9, -71.5; 57.5, -61.9; 63.9, -47.2; 72, -24.8; 80, 0],
                style(color=0)),
            Text(
              extent=[-147, -152; 153, -112],
              string="freqHz=%freqHz",
              style(color=0))),
          Diagram(
            Line(points=[-80, -90; -80, 84], style(color=8)),
            Polygon(points=[-80, 100; -86, 84; -74, 84; -80, 100], style(color=
                    8, fillColor=8)),
            Line(points=[-99, -40; 85, -40], style(color=8)),
            Polygon(points=[101, -40; 85, -34; 85, -46; 101, -40], style(color=
                    8, fillColor=8)),
            Line(points=[-40, 0; -31.6, 34.2; -26.1, 53.1; -21.3, 66.4; -17.1,
                  74.6; -12.9, 79.1; -8.64, 79.8; -4.42, 76.6; -0.201, 69.7;
                  4.02, 59.4; 8.84, 44.1; 14.9, 21.2; 27.5, -30.8; 33, -50.2;
                  37.8, -64.2; 42, -73.1; 46.2, -78.4; 50.5, -80; 54.7, -77.6;
                  58.9, -71.5; 63.1, -61.9; 67.9, -47.2; 74, -24.8; 80, 0],
                style(color=0, thickness=2)),
            Line(points=[-41, -2; -80, -2], style(color=0, thickness=2)),
            Text(
              extent=[-128, 7; -82, -11],
              string="offset",
              style(color=9)),
            Line(points=[-41, -2; -41, -40], style(color=8, pattern=2)),
            Text(
              extent=[-60, -43; -14, -61],
              string="startTime",
              style(color=9)),
            Text(
              extent=[84, -52; 108, -72],
              string="time",
              style(color=9)),
            Text(
              extent=[-74, 106; -33, 86],
              string="y",
              style(color=9)),
            Line(points=[-9, 79; 43, 79], style(color=8, pattern=2)),
            Line(points=[-42, -1; 50, 0], style(color=8, pattern=2)),
            Polygon(points=[33, 80; 30, 67; 37, 67; 33, 80], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Text(
              extent=[37, 57; 83, 39],
              string="amplitude",
              style(color=9)),
            Polygon(points=[33, 1; 30, 14; 36, 14; 33, 1; 33, 1], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Line(points=[33, 79; 33, 0], style(
                color=8,
                pattern=1,
                thickness=1,
                arrow=0))));
      equation 
        y = offset + (if time < startTime then 0 else amplitude*
          Modelica.Math.sin(2*pi*freqHz*(time - startTime) + phase));
      end Sine;
  
      block ExpSine "Generate exponentially damped sine signal" 
        parameter Real amplitude=1 "Amplitude of sine wave";
        parameter SIunits.Frequency freqHz=2 "Frequency of sine wave";
        parameter SIunits.Angle phase=0 "Phase of sine wave";
        parameter SIunits.Damping damping=1 "Damping coefficient of sine wave";
        parameter Real offset=0 "Offset of output signal";
        parameter SIunits.Time startTime=0 
      "Output = offset for time < startTime";
        extends Interfaces.SO;
  protected 
        constant Real pi=Modelica.Constants.pi;
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[1, 1],
            component=[20, 20]),
          Window(
            x=0.18,
            y=0.05,
            width=0.6,
            height=0.63),
          Icon(
            Line(points=[-80, 68; -80, -80], style(color=8)),
            Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
                   fillColor=8)),
            Line(points=[-90, 0; 68, 0], style(color=8)),
            Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8,
                  fillColor=8)),
            Line(points=[-80, 0; -75.2, 32.3; -72, 50.3; -68.7, 64.5; -65.5,
                  74.2; -62.3, 79.3; -59.1, 79.6; -55.9, 75.3; -52.7, 67.1; -48.6,
                   52.2; -43, 25.8; -35, -13.9; -30.2, -33.7; -26.1, -45.9; -22.1,
                   -53.2; -18.1, -55.3; -14.1, -52.5; -10.1, -45.3; -5.23, -32.1;
                   8.44, 13.7; 13.3, 26.4; 18.1, 34.8; 22.1, 38; 26.9, 37.2;
                  31.8, 31.8; 38.2, 19.4; 51.1, -10.5; 57.5, -21.2; 63.1, -25.9;
                   68.7, -25.9; 75.2, -20.5; 80, -13.8], style(color=0)),
            Text(
              extent=[-147, -152; 153, -112],
              string="freqHz=%freqHz",
              style(color=0))),
          Diagram(
            Line(points=[-80, -90; -80, 84], style(color=8)),
            Polygon(points=[-80, 100; -86, 84; -74, 84; -80, 100], style(color=
                    8, fillColor=8)),
            Line(points=[-99, -40; 85, -40], style(color=8)),
            Polygon(points=[101, -40; 85, -34; 85, -46; 101, -40], style(color=
                    8, fillColor=8)),
            Line(points=[-50, 0; -46.1, 28.2; -43.5, 44; -40.9, 56.4; -38.2,
                  64.9; -35.6, 69.4; -33, 69.6; -30.4, 65.9; -27.8, 58.7; -24.5,
                   45.7; -19.9, 22.5; -13.4, -12.2; -9.5, -29.5; -6.23, -40.1;
                  -2.96, -46.5; 0.302, -48.4; 3.57, -45.9; 6.83, -39.6; 10.8, -28.1;
                   21.9, 12; 25.8, 23.1; 29.7, 30.5; 33, 33.3; 36.9, 32.5; 40.8,
                   27.8; 46, 16.9; 56.5, -9.2; 61.7, -18.6; 66.3, -22.7; 70.9,
                  -22.6; 76.1, -18; 80, -12.1], style(color=0, thickness=2)),
            Text(
              extent=[-106, 10; -83, -10],
              string="offset",
              style(color=9)),
            Text(
              extent=[-72, -36; -26, -54],
              string="startTime",
              style(color=9)),
            Text(
              extent=[84, -52; 108, -72],
              string="time",
              style(color=9)),
            Text(
              extent=[-79, 104; -39, 87],
              string="y",
              style(color=9)),
            Line(points=[-50, 0; 18, 0], style(color=8, pattern=2)),
            Line(points=[-50, 0; -81, 0], style(color=0, thickness=2)),
            Line(points=[-50, 77; -50, 0], style(color=8, pattern=2)),
            Line(points=[18, -1; 18, 76], style(color=8, pattern=2)),
            Line(points=[18, 73; -50, 73], style(color=8)),
            Text(
              extent=[-42, 88; 9, 74],
              string="1/freqHz",
              style(color=9)),
            Polygon(points=[-49, 73; -40, 75; -40, 71; -49, 73], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Polygon(points=[18, 73; 10, 75; 10, 71; 18, 73], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Line(points=[-50, -61; -19, -61], style(color=8)),
            Polygon(points=[-18, -61; -26, -59; -26, -63; -18, -61], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Text(
              extent=[-51, -63; -27, -75],
              string="t",
              style(color=9)),
            Text(
              extent=[-82, -67; 108, -96],
              string="amplitude*exp(-damping*t)*sin(2*pi*freqHz*t+phase)",
              style(color=9)),
            Line(points=[-50, 0; -50, -40], style(color=8, pattern=2)),
            Line(points=[-50, -54; -50, -72], style(color=8, pattern=2)),
            Line(points=[-15, -77; -1, -48], style(color=8, pattern=2))));
      equation 
        y = offset + (if time < startTime then 0 else amplitude*
          Modelica.Math.exp(-(time - startTime)*damping)*Modelica.Math.sin(2*pi
          *freqHz*(time - startTime) + phase));
      end ExpSine;
  
      model Exponentials "Generate a rising and falling exponential signal" 
    
        parameter Real outMax=1 "Height of output for infinite riseTime";
        parameter SIunits.Time riseTime(min=0) = 0.5 "Rise time";
        parameter SIunits.Time riseTimeConst(min=Modelica.Constants.small)=
          0.1 "Rise time constant";
        parameter SIunits.Time fallTimeConst(min=Modelica.Constants.small)=
          riseTimeConst "Fall time constant";
        parameter Real offset=0 "Offset of output signal";
        parameter SIunits.Time startTime=0 
      "Output = offset for time < startTime";
        extends Interfaces.SO;
  protected 
        Real y_riseTime;
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[1, 1],
            component=[20, 20]),
          Window(
            x=0.03,
            y=0.05,
            width=0.85,
            height=0.74),
          Icon(
            Line(points=[-90, -70; 68, -70], style(color=8)),
            Polygon(points=[90, -70; 68, -62; 68, -78; 90, -70], style(color=8,
                   fillColor=8)),
            Line(points=[-80, -70; -77.2, -55.3; -74.3, -42.1; -70.8, -27.6; -67.3,
                   -15; -63.7, -4.08; -59.5, 7.18; -55.3, 16.7; -50.3, 26; -44.6,
                   34.5; -38.3, 42.1; -31.2, 48.6; -22.7, 54.3; -12.1, 59.2; -10,
                   60; -7.88, 47.5; -5.05, 32.7; -2.22, 19.8; 0.606, 8.45; 4.14,
                   -3.7; 7.68, -14; 11.9, -24.2; 16.2, -32.6; 21.1, -40.5; 26.8,
                   -47.4; 33.1, -53.3; 40.9, -58.5; 50.8, -62.8; 60, -65.4],
                style(color=0)),
            Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
                   fillColor=8)),
            Line(points=[-80, 68; -80, -80], style(color=8)),
            Text(
              extent=[-150, -150; 150, -110],
              string="riseTime=%riseTime",
              style(color=0))),
          Diagram(
            Line(points=[-100, -70; 84, -70], style(color=8)),
            Polygon(points=[100, -70; 84, -64; 84, -76; 100, -70], style(color=
                    8, fillColor=8)),
            Line(points=[-40, -30; -37.2, -15.3; -34.3, -2.1; -30.8, 12.4; -27.3,
                   25; -23.7, 35.92; -19.5, 47.18; -15.3, 56.7; -10.3, 66; -4.6,
                   74.5; 1.7, 82.1; 8.8, 88.6; 17.3, 94.3; 27.9, 99.2; 30, 100;
                   32.12, 87.5; 34.95, 72.7; 37.78, 59.8; 40.606, 48.45; 44.14,
                   36.3; 47.68, 26; 51.9, 15.8; 56.2, 7.4; 61.1, -0.5; 66.8, -7.4;
                   73.1, -13.3; 80.9, -18.5; 90.8, -22.8; 100, -25.4], style(
                  color=0, thickness=2)),
            Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
                   fillColor=8)),
            Line(points=[-80, 68; -80, -80], style(color=8)),
            Text(
              extent=[-70, 91; -29, 71],
              string="y",
              style(color=9)),
            Text(
              extent=[-78, -43; -46, -56],
              string="offset",
              style(color=9)),
            Polygon(points=[-40, -70; -43, -60; -38, -60; -40, -70; -40, -70],
                style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Line(points=[-40, -29; -40, -60], style(
                color=8,
                pattern=1,
                thickness=1,
                arrow=0)),
            Polygon(points=[-40, -30; -42, -40; -37, -40; -40, -30], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Line(points=[-39, -30; -80, -30], style(color=0, thickness=2)),
            Text(
              extent=[-59, -71; -13, -89],
              string="startTime",
              style(color=9)),
            Polygon(points=[-41, -30; -32, -28; -32, -32; -41, -30], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Line(points=[-40, -30; 29, -30], style(
                color=8,
                pattern=1,
                thickness=1,
                arrow=0)),
            Polygon(points=[29, -30; 21, -28; 21, -32; 29, -30], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Text(
              extent=[-26, -12; 19, -28],
              string="riseTime",
              style(color=9)),
            Text(
              extent=[78, -76; 102, -96],
              string="time",
              style(color=9)),
            Line(points=[30, 100; 30, -34], style(color=8, pattern=2))));
      equation 
        y_riseTime = outMax*(1 - Modelica.Math.exp(-riseTime/riseTimeConst));
        y = offset + (if (time < startTime) then 0 else if (time < (startTime
           + riseTime)) then outMax*(1 - Modelica.Math.exp(-(time - startTime)/riseTimeConst)) else 
                y_riseTime*Modelica.Math.exp(-(time - startTime - riseTime)/
          fallTimeConst));
    
      end Exponentials;
  
      block Pulse "Generate pulse signal of type Real" 
        parameter Real amplitude=1 "Amplitude of pulse";
        parameter Real width(
          final min=Modelica.Constants.small,
          final max=100) = 50 "Width of pulse in % of periods";
        parameter Modelica.SIunits.Time period(final min=Modelica.Constants.small)=1 
      "Time for one period";
        parameter Real offset=0 "Offset of output signals";
        parameter Modelica.SIunits.Time startTime=0 
      "Output = offset for time < startTime";
        extends Modelica.Blocks.Interfaces.SO;
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[1, 1],
            component=[20, 20]),
          Window(
            x=0.29,
            y=0.05,
            width=0.59,
            height=0.72),
          Icon(
            Line(points=[-80, 68; -80, -80], style(color=8)),
            Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
                   fillColor=8)),
            Line(points=[-90, -70; 82, -70], style(color=8)),
            Polygon(points=[90, -70; 68, -62; 68, -78; 90, -70], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Line(points=[-80, -70; -40, -70; -40, 44; 0, 44; 0, -70; 40, -70;
                  40, 44; 79, 44], style(color=0)),
            Text(
              extent=[-147, -152; 153, -112],
              string="period=%period",
              style(color=0))),
          Diagram(
            Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
                   fillColor=8)),
            Line(points=[-80, 68; -80, -80], style(color=8)),
            Line(points=[-90, -70; 82, -70], style(color=8)),
            Polygon(points=[90, -70; 68, -62; 68, -78; 90, -70], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Polygon(points=[-34, 1; -37, -12; -30, -12; -34, 1], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Line(points=[-34, -1; -34, -70], style(
                color=8,
                pattern=1,
                thickness=1,
                arrow=0)),
            Polygon(points=[-33, -70; -36, -57; -30, -57; -33, -70; -33, -70],
                style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Text(
              extent=[-78, -24; -35, -36],
              string="offset",
              style(color=9)),
            Text(
              extent=[-31, -69; 15, -87],
              string="startTime",
              style(color=9)),
            Text(
              extent=[-76, 99; -35, 79],
              string="y",
              style(color=9)),
            Text(
              extent=[70, -80; 94, -100],
              string="time",
              style(color=9)),
            Line(points=[-10, 0; -10, -70], style(color=8, pattern=2)),
            Line(points=[-80, 0; -10, 0; -10, 50; 30, 50; 30, 0; 50, 0; 50, 50;
                   90, 50], style(color=0, thickness=2)),
            Line(points=[-10, 88; -10, 49], style(color=8, pattern=2)),
            Line(points=[30, 74; 30, 50], style(color=9, pattern=2)),
            Line(points=[50, 88; 50, 50], style(color=8, pattern=2)),
            Line(points=[-10, 83; 51, 83], style(color=8)),
            Line(points=[-10, 69; 30, 69], style(color=8)),
            Text(
              extent=[0, 97; 46, 85],
              string="period",
              style(color=9)),
            Text(
              extent=[-9, 81; 30, 69],
              string="width",
              style(color=9)),
            Line(points=[-43, 50; -10, 50], style(color=8, pattern=2)),
            Line(points=[-34, 50; -34, 1], style(
                color=8,
                pattern=1,
                thickness=1,
                arrow=0)),
            Text(
              extent=[-78, 34; -37, 20],
              string="amplitude",
              style(color=9)),
            Polygon(points=[-34, 49; -37, 36; -30, 36; -34, 49], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Polygon(points=[-34, 1; -37, 14; -31, 14; -34, 1; -34, 1], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Line(points=[90, 50; 90, 0; 100, 0], style(color=0, thickness=2)),
            Polygon(points=[-10, 69; -1, 71; -1, 67; -10, 69], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Polygon(points=[30, 69; 22, 71; 22, 67; 30, 69], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Polygon(points=[-10, 83; -1, 85; -1, 81; -10, 83], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Polygon(points=[50, 83; 42, 85; 42, 81; 50, 83], style(
                color=8,
                fillColor=8,
                fillPattern=1))));
  protected 
        Modelica.SIunits.Time T0(final start=startTime) 
      "Start time of current period";
        Modelica.SIunits.Time T_width = period*width/100;
      equation 
        when sample(startTime, period) then
          T0 = time;
        end when;
        y = offset + (if time < startTime or time >= T0 + T_width then 0 else 
          amplitude);
      end Pulse;
  
      block SawTooth "Generate saw tooth signal" 
        parameter Real amplitude=1 "Amplitude of saw tooth";
        parameter SIunits.Time period(final min=Modelica.Constants.small) = 1 
      "Time for one period";
        parameter Real offset=0 "Offset of output signals";
        parameter SIunits.Time startTime=0 
      "Output = offset for time < startTime";
        extends Interfaces.SO;
  protected 
        SIunits.Time T0(final start=startTime) "Start time of current period";
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[1, 1],
            component=[20, 20]),
          Window(
            x=0.21,
            y=0.11,
            width=0.55,
            height=0.71),
          Icon(
            Line(points=[-80, 68; -80, -80], style(color=8)),
            Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
                   fillColor=8)),
            Line(points=[-90, -70; 82, -70], style(color=8)),
            Polygon(points=[90, -70; 68, -62; 68, -78; 90, -70], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Line(points=[-80, -70; -60, -70; 0, 40; 0, -70; 60, 41; 60, -70],
                style(color=0)),
            Text(
              extent=[-147, -152; 153, -112],
              string="period=%period",
              style(color=0))),
          Diagram(
            Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
                   fillColor=8)),
            Line(points=[-80, 68; -80, -80], style(color=8)),
            Line(points=[-90, -70; 82, -70], style(color=8)),
            Polygon(points=[90, -70; 68, -62; 68, -78; 90, -70], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Polygon(points=[-34, -19; -37, -32; -30, -32; -34, -19], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Line(points=[-34, -20; -34, -70], style(
                color=8,
                pattern=1,
                thickness=1,
                arrow=0)),
            Polygon(points=[-34, -70; -37, -57; -31, -57; -34, -70; -34, -70],
                style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Text(
              extent=[-78, -24; -35, -36],
              string="offset",
              style(color=9)),
            Text(
              extent=[-31, -69; 15, -87],
              string="startTime",
              style(color=9)),
            Text(
              extent=[-76, 99; -35, 79],
              string="y",
              style(color=9)),
            Text(
              extent=[70, -80; 94, -100],
              string="time",
              style(color=9)),
            Line(points=[-10, -20; -10, -70], style(color=8, pattern=2)),
            Line(points=[-10, 88; -10, -20], style(color=8, pattern=2)),
            Line(points=[30, 88; 30, 59], style(color=8, pattern=2)),
            Line(points=[-10, 83; 30, 83], style(color=8)),
            Text(
              extent=[-12, 97; 34, 85],
              string="period",
              style(color=9)),
            Line(points=[-44, 60; 30, 60], style(color=8, pattern=2)),
            Line(points=[-34, 47; -34, -7], style(
                color=8,
                pattern=1,
                thickness=1,
                arrow=0)),
            Text(
              extent=[-78, 34; -37, 20],
              string="amplitude",
              style(color=9)),
            Polygon(points=[-34, 60; -37, 47; -30, 47; -34, 60], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Polygon(points=[-34, -20; -37, -7; -31, -7; -34, -20; -34, -20],
                style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Polygon(points=[-10, 83; -1, 85; -1, 81; -10, 83], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Polygon(points=[30, 83; 22, 85; 22, 81; 30, 83], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Line(points=[-80, -20; -10, -20; 30, 60; 30, -20; 72, 60; 72, -20],
                 style(color=0, thickness=2))));
      equation 
        when sample(startTime, period) then
          T0 = time;
        end when;
        y = offset + (if time < startTime then 0 else (amplitude/period)*(time
           - T0));
      end SawTooth;
  
      block Trapezoid "Generate trapezoidal signal of type Real" 
        parameter Real amplitude=1 "Amplitude of trapezoid";
        parameter SIunits.Time rising(final min=0) = 0 
      "Rising duration of trapezoid";
        parameter SIunits.Time width(final min=0) = 0.5 
      "Width duration of trapezoid";
        parameter SIunits.Time falling(final min=0) = 0 
      "Falling duration of trapezoid";
        parameter SIunits.Time period(final min=Modelica.Constants.small) = 1 
      "Time for one period";
        parameter Integer nperiod=-1 
      "Number of periods (< 0 means infinite number of periods)";
        parameter Real offset=0 "Offset of output signal";
        parameter SIunits.Time startTime=0 
      "Output = offset for time < startTime";
        extends Interfaces.SO;
  protected 
        parameter SIunits.Time T_rising=rising 
      "End time of rising phase within one period";
        parameter SIunits.Time T_width=T_rising + width 
      "End time of width phase within one period";
        parameter SIunits.Time T_falling=T_width + falling 
      "End time of falling phase within one period";
        SIunits.Time T0(final start=startTime) "Start time of current period";
        Integer counter(start=nperiod) "Period counter";
        Integer counter2(start=nperiod);
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[1, 1],
            component=[20, 20]),
          Window(
            x=0.35,
            y=0,
            width=0.49,
            height=0.58),
          Icon(
            Line(points=[-80, 68; -80, -80], style(color=8)),
            Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
                   fillColor=8)),
            Line(points=[-90, -70; 82, -70], style(color=8)),
            Polygon(points=[90, -70; 68, -62; 68, -78; 90, -70], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Text(
              extent=[-147, -152; 153, -112],
              string="period=%period",
              style(color=0)),
            Line(points=[-81, -70; -60, -70; -30, 40; 9, 40; 39, -70; 61, -70;
                  90, 40], style(color=0))),
          Diagram(
            Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
                   fillColor=8)),
            Line(points=[-80, 68; -80, -80], style(color=8)),
            Line(points=[-90, -70; 82, -70], style(color=8)),
            Polygon(points=[90, -70; 68, -62; 68, -78; 90, -70], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Polygon(points=[-45, -30; -47, -41; -43, -41; -45, -30], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Line(points=[-45, -31; -45, -70], style(
                color=8,
                pattern=1,
                thickness=1,
                arrow=0)),
            Polygon(points=[-45, -70; -47, -60; -43, -60; -45, -70; -45, -70],
                style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Text(
              extent=[-86, -43; -43, -55],
              string="offset",
              style(color=9)),
            Text(
              extent=[-47, -69; -1, -87],
              string="startTime",
              style(color=9)),
            Text(
              extent=[-76, 99; -35, 79],
              string="y",
              style(color=9)),
            Text(
              extent=[70, -80; 94, -100],
              string="time",
              style(color=9)),
            Line(points=[-29, 82; -30, -70], style(color=8, pattern=2)),
            Line(points=[-10, 59; -10, 40], style(color=8, pattern=2)),
            Line(points=[20, 59; 20, 39], style(color=9, pattern=2)),
            Line(points=[40, 59; 40, -30], style(color=8, pattern=2)),
            Line(points=[-20, 76; 61, 76], style(color=8)),
            Line(points=[-29, 56; 40, 56], style(color=8)),
            Text(
              extent=[-2, 86; 25, 77],
              string="period",
              style(color=9)),
            Text(
              extent=[-8, 70; 21, 60],
              string="width",
              style(color=9)),
            Line(points=[-42, 40; -10, 40], style(color=8, pattern=2)),
            Line(points=[-39, 40; -39, -19], style(
                color=8,
                pattern=1,
                thickness=1,
                arrow=0)),
            Text(
              extent=[-77, 14; -40, 0],
              string="amplitude",
              style(color=9)),
            Polygon(points=[-29, 56; -22, 58; -22, 54; -29, 56], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Polygon(points=[-10, 56; -17, 58; -17, 54; -10, 56], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Polygon(points=[-29, 76; -20, 78; -20, 74; -29, 76], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Polygon(points=[61, 76; 53, 78; 53, 74; 61, 76], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Line(points=[-80, -30; -30, -30; -10, 40; 20, 40; 40, -30; 60, -30;
                   80, 40; 100, 40], style(color=0, thickness=2)),
            Polygon(points=[-39, 40; -41, 29; -37, 29; -39, 40], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Polygon(points=[-39, -29; -41, -19; -37, -19; -39, -29; -39, -29],
                style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Line(points=[61, 84; 60, -30], style(color=8, pattern=2)),
            Polygon(points=[39, 56; 32, 58; 32, 54; 39, 56], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Polygon(points=[20, 56; 27, 58; 27, 54; 20, 56], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Polygon(points=[20, 56; 13, 58; 13, 54; 20, 56], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Polygon(points=[-12, 56; -5, 58; -5, 54; -12, 56], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Text(
              extent=[-34, 70; -5, 60],
              string="rising",
              style(color=9)),
            Text(
              extent=[16, 70; 45, 60],
              string="falling",
              style(color=9))));
      equation 
        when pre(counter2) <> 0 and sample(startTime, period) then
          T0 = time;
          counter2 = pre(counter);
          counter = pre(counter) - (if pre(counter) > 0 then 1 else 0);
        end when;
        y = offset + (if (time < startTime or counter2 == 0 or time >= T0 +
          T_falling) then 0 else if (time < T0 + T_rising) then (time - T0)*
          amplitude/T_rising else if (time < T0 + T_width) then amplitude else 
          (T0 + T_falling - time)*amplitude/(T_falling - T_width));
      end Trapezoid;
  
      block KinematicPTP 
    "Move as fast as possible along a distance within given kinematic constraints" 
    
        parameter Real deltaq[:]={1} "Distance to move";
        parameter Real qd_max[:](final min=Modelica.Constants.small) = {1} 
      "Maximum velocities der(q)";
        parameter Real qdd_max[:](final min=Modelica.Constants.small) = {1} 
      "Maximum accelerations der(qd)";
        parameter SIunits.Time startTime=0 
      "Time instant at which movement starts";
    
        extends Interfaces.MO(final nout=max([size(deltaq, 1); size(qd_max, 1);
               size(qdd_max, 1)]));
    
  protected 
        parameter Real p_deltaq[nout]=(if size(deltaq, 1) == 1 then ones(nout)*
            deltaq[1] else deltaq);
        parameter Real p_qd_max[nout]=(if size(qd_max, 1) == 1 then ones(nout)*
            qd_max[1] else qd_max);
        parameter Real p_qdd_max[nout]=(if size(qdd_max, 1) == 1 then ones(nout)
            *qdd_max[1] else qdd_max);
        Real sd_max;
        Real sdd_max;
        Real sdd;
        Real aux1[nout];
        Real aux2[nout];
        SIunits.Time Ta1;
        SIunits.Time Ta2;
        SIunits.Time Tv;
        SIunits.Time Te;
        Boolean noWphase;
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[1, 1],
            component=[20, 20]),
          Window(
            x=0.17,
            y=0.05,
            width=0.69,
            height=0.72),
          Icon(
            Line(points=[-80, 78; -80, -82], style(color=8)),
            Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 88; -80, 90], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Line(points=[-90, 0; 82, 0], style(color=8)),
            Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Line(points=[-80, 0; -70, 0; -70, 70; -30, 70; -30, 0; 20, 0; 20, -70;
                   60, -70; 60, 0; 68, 0], style(color=0, thickness=1)),
            Text(
              extent=[2, 80; 80, 20],
              string="acc",
              style(color=8)),
            Text(
              extent=[-150, -150; 150, -110],
              string="deltaq=%deltaq",
              style(color=0))),
          Diagram(
            Rectangle(extent=[-100, -100; 100, 100], style(
                color=3,
                gradient=0,
                fillColor=0,
                fillPattern=0)),
            Line(points=[-80, 78; -80, -82], style(color=8)),
            Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 88; -80, 90], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Line(points=[-90, 0; 82, 0], style(color=8)),
            Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Line(points=[-80, 0; -70, 0; -70, 70; -30, 70; -30, 0; 20, 0; 20, -70;
                   60, -70; 60, 0; 68, 0], style(color=0, thickness=2)),
            Text(
              extent=[-76, 98; -19, 83],
              string="acceleration",
              style(color=8)),
            Text(
              extent=[69, 24; 91, 12],
              string="time",
              style(color=8))),
          Documentation(info="
<HTML>
<p>
The goal is to move as <b>fast</b> as possible along a distance
<b>deltaq</b>
under given <b>kinematical constraints</b>. The distance can be a positional or
angular range. In robotics such a movement is called <b>PTP</b> (Point-To-Point).
This source block generates the <b>acceleration</b> qdd of this signal
as output. After integrating the output two times, the position q is
obtained. The signal is constructed in such a way that it is not possible
to move faster, given the <b>maximally</b> allowed <b>velocity</b> qd_max and
the <b>maximally</b> allowed <b>acceleration</b> qdd_max.
</p>
<p>
If several distances are given (vector deltaq has more than 1 element),
an acceleration output vector is constructed such that all signals
are in the same periods in the acceleration, constant velocity
and deceleration phase. This means that only one of the signals
is at its limits whereas the others are sychnronized in such a way
that the end point is reached at the same time instant.
</p>
<p>
This element is useful to generate a reference signal for a controller
which controls a drive train or in combination with model
Modelica.Mechanics.Rotational.<b>Accelerate</b> to drive
a flange according to a given acceleration.
</p>
<p><b>Release Notes:</b></p>
<ul>
<li><i>June 27, 2001</i>
       by Bernhard Bachmann.<br>
       Bug fixed that element is also correct if startTime is not zero.</li>
<li><i>Nov. 3, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Vectorized and moved from Rotational to Blocks.Sources.</li>
<li><i>June 29, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       realized.</li>
</ul>
</HTML>
"));
      equation 
        for i in 1:nout loop
          aux1[i] = p_deltaq[i]/p_qd_max[i];
          aux2[i] = p_deltaq[i]/p_qdd_max[i];
        end for;
        sd_max = 1/max(abs(aux1));
        sdd_max = 1/max(abs(aux2));
    
        Ta1 = sqrt(1/sdd_max);
        Ta2 = sd_max/sdd_max;
        noWphase = Ta2 >= Ta1;
        Tv = if noWphase then Ta1 else 1/sd_max;
        Te = if noWphase then Ta1 + Ta1 else Tv + Ta2;
    
        // path-acceleration
        sdd = if time < startTime then 0 else ((if noWphase then (if time < Ta1
           + startTime then sdd_max else (if time < Te + startTime then -
          sdd_max else 0)) else (if time < Ta2 + startTime then sdd_max else (
          if time < Tv + startTime then 0 else (if time < Te + startTime then -
          sdd_max else 0)))));
    
        // acceleration
        y = p_deltaq*sdd;
      end KinematicPTP;
  
      block TimeTable 
    "Generate a (possibly discontinuous) signal by linear interpolation in a table" 
    
        parameter Real table[:, 2]=[0, 0; 1, 1; 2, 4] 
      "Table matrix (time = first column)";
        parameter Real offset=0 "Offset of output signal";
        parameter SIunits.Time startTime=0 
      "Output = offset for time < startTime";
        extends Interfaces.SO;
  protected 
        Real a "Interpolation coefficients a of actual interval (y=a*x+b)";
        Real b "Interpolation coefficients b of actual interval (y=a*x+b)";
        Integer last(start=1) "Last used lower grid index";
        SIunits.Time nextEvent(start=0) "Next event instant";
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[1, 1],
            component=[20, 20]),
          Window(
            x=0.26,
            y=0.01,
            width=0.7,
            height=0.82),
          Icon(
            Line(points=[-80, 68; -80, -80], style(color=8)),
            Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
                   fillColor=8)),
            Line(points=[-90, -70; 82, -70], style(color=8)),
            Polygon(points=[90, -70; 68, -62; 68, -78; 90, -70], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Rectangle(extent=[-48, 70; 2, -50], style(
                color=7,
                fillColor=8,
                fillPattern=1)),
            Line(points=[-48, -50; -48, 70; 52, 70; 52, -50; -48, -50; -48, -20;
                   52, -20; 52, 10; -48, 10; -48, 40; 52, 40; 52, 70; 2, 70; 2,
                   -51], style(color=0)),
            Text(
              extent=[-150, -150; 150, -110],
              string="offset=%offset",
              style(color=0))),
          Diagram(
            Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
                   fillColor=8)),
            Line(points=[-80, 68; -80, -80], style(color=8)),
            Line(points=[-90, -70; 82, -70], style(color=8)),
            Polygon(points=[90, -70; 68, -62; 68, -78; 90, -70], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Rectangle(extent=[-20, 90; 30, -30], style(
                color=7,
                fillColor=8,
                fillPattern=1)),
            Line(points=[-20, -30; -20, 90; 80, 90; 80, -30; -20, -30; -20, 0;
                  80, 0; 80, 30; -20, 30; -20, 60; 80, 60; 80, 90; 30, 90; 30,
                  -31], style(color=0)),
            Text(
              extent=[-77, -42; -38, -58],
              string="offset",
              style(color=9)),
            Polygon(points=[-31, -30; -33, -40; -28, -40; -31, -30], style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Polygon(points=[-30, -70; -33, -60; -28, -60; -30, -70; -30, -70],
                style(
                color=8,
                fillColor=8,
                fillPattern=1)),
            Line(points=[-31, -31; -31, -70], style(
                color=8,
                pattern=1,
                thickness=1,
                arrow=0)),
            Line(points=[-20, -20; -20, -70], style(color=8, pattern=2)),
            Text(
              extent=[-38, -70; 8, -88],
              string="startTime",
              style(color=9)),
            Line(points=[-20, -30; -80, -30], style(color=8, pattern=2)),
            Text(
              extent=[-73, 93; -41, 78],
              string="y",
              style(color=9)),
            Text(
              extent=[66, -81; 91, -93],
              string="time",
              style(color=9)),
            Text(
              extent=[-15, 83; 24, 68],
              string="time",
              style(color=0)),
            Text(
              extent=[33, 83; 76, 67],
              string="y",
              style(color=0))),
          Documentation(info="<HTML>
<p>
This block generates an output signal by <b>linear interpolation</b> in
a table. The time points and function values are stored in a matrix
<b>table[i,j]</b>, where the first column table[:,1] contains the
time points and the second column contains the data to be interpolated.
The table interpolation has the following proporties:
</p>
<ul>
<li>The time points need to be <b>monotonically increasing</b>. </li>
<li><b>Discontinuities</b> are allowed, by providing the same
    time point twice in the table. </li>
<li>Values <b>outside</b> of the table range, are computed by
    <b>extrapolation</b> through the last or first two points of the
    table.</li>
<li>If the table has only <b>one row</b>, no interpolation is performed and
    the function value is just returned independantly of the
    actual time instant.</li>
<li>Via parameters <b>startTime</b> and <b>offset</b> the curve defined
    by the table can be shifted both in time and in the ordinate value.
<li>The table is implemented in a numerically sound way by
    generating <b>time events</b> at interval boundaries,
    in order to not integrate over a discontinuous or not differentiable
    points.
</li>
</ul>
<p>
Example:
</p>
<pre>
   table = [0  0
            1  0
            1  1
            2  4
            3  9
            4 16]
If, e.g., time = 1.0, the output y =  0.0 (before event), 1.0 (after event)
    e.g., time = 1.5, the output y =  2.5,
    e.g., time = 2.0, the output y =  4.0,
    e.g., time = 5.0, the output y = 23.0 (i.e. extrapolation).
</pre>
<p><b>Release Notes:</b></p>
<ul>
<li><i>Oct. 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Corrected interface from
<pre>
    parameter Real table[:, :]=[0, 0; 1, 1; 2, 4];
</pre>
       to
<pre>
    parameter Real table[:, <b>2</b>]=[0, 0; 1, 1; 2, 4];
</pre>
       </li>
<li><i>Nov. 7, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>
</HTML>
"));
        function getInterpolationCoefficients 
      "Determine interpolation coefficients and next time event" 
          input Real table[:, 2] "Table for interpolation";
          input Real offset "y-offset";
          input Real startTime "time-offset";
          input Real t "Actual time instant";
          input Integer last "Last used lower grid index";
          input Real TimeEps 
        "Relative epsilon to check for identical time instants";
          output Real a "Interpolation coefficients a (y=a*x + b)";
          output Real b "Interpolation coefficients b (y=a*x + b)";
          output Real nextEvent "Next event instant";
          output Integer next "New lower grid index";
    protected 
          Integer columns=2 "Column to be interpolated";
          Integer ncol=2 "Number of columns to be interpolated";
          Integer nrow=size(table, 1) "Number of table rows";
          Integer next0;
          Real tp;
          Real dt;
        algorithm 
          next := last;
          nextEvent := t - TimeEps*abs(t);
          // in case there are no more time events
          tp := t + TimeEps*abs(t) - startTime;
      
          if tp < 0.0 then
            // First event not yet reached
            nextEvent := startTime;
            a := 0;
            b := offset;
          elseif nrow < 2 then
            // Special action if table has only one row
            a := 0;
            b := offset + table[1, columns];
          else
        
              // Find next time event instant. Note, that two consecutive time instants
            // in the table may be identical due to a discontinuous point.
            while next < nrow and tp >= table[next, 1] loop
              next := next + 1;
            end while;
        
            // Define next time event, if last table entry not reached
            if next < nrow then
              nextEvent := startTime + table[next, 1];
            end if;
        
            // Determine interpolation coefficients
            next0 := next - 1;
            dt := table[next, 1] - table[next0, 1];
            if dt <= TimeEps*abs(table[next, 1]) then
              // Interpolation interval is not big enough, use "next" value
              a := 0;
              b := offset + table[next, columns];
            else
              a := (table[next, columns] - table[next0, columns])/dt;
              b := offset + table[next0, columns] - a*table[next0, 1];
            end if;
          end if;
          // Take into account startTime "a*(time - startTime) + b"
          b := b - a*startTime;
        end getInterpolationCoefficients;
      algorithm 
        when {time >= pre(nextEvent),initial()} then
          (a,b,nextEvent,last) := getInterpolationCoefficients(table, offset,
            startTime, time, last, 100*Modelica.Constants.eps);
        end when;
      equation 
        y = a*time + b;
      end TimeTable;
  
  model CombiTimeTable 
    "Table look-up with respect to time and linear/perodic extrapolation methods (data from matrix/file)" 
    
    parameter Boolean tableOnFile=false 
      "true, if table is defined on file or in function usertab" 
      annotation(Dialog(group="table data definition"));
    parameter Real table[:, :]=fill(0.0,0,2) 
      "table matrix (time = first column)" 
         annotation(Dialog(group="table data definition", enable = not tableOnFile));
    parameter String tableName="NoName" 
      "table name on file or in function usertab (see docu)" 
         annotation(Dialog(group="table data definition", enable = tableOnFile));
    parameter String fileName="NoName" "file where matrix is stored" 
         annotation(Dialog(group="table data definition", enable = tableOnFile));
    parameter Integer columns[:]=2:size(table, 2) 
      "columns of table to be interpolated" 
    annotation(Dialog(group="table data interpretation"));
    parameter Blocks.Types.Smoothness.Temp smoothness=Blocks.Types.Smoothness.LinearSegments 
      "smoothness of table interpolation" 
    annotation(Dialog(group="table data interpretation"));
    parameter Blocks.Types.Extrapolation.Temp extrapolation=Blocks.Types.Extrapolation.LastTwoPoints 
      "extrapolation of data outside the definition range" 
    annotation(Dialog(group="table data interpretation"));
    parameter Real offset[:]={0} "Offsets of output signals" 
    annotation(Dialog(group="table data interpretation"));
    parameter SI.Time startTime=0 "Output = offset for time < startTime" 
    annotation(Dialog(group="table data interpretation"));
    extends Modelica.Blocks.Interfaces.MO(final nout=max([size(columns, 1); size(offset, 1)]));
    final parameter Real t_min(fixed=false);
    final parameter Real t_max(fixed=false);
    
  protected 
    final parameter Real p_offset[nout]=(if size(offset, 1) == 1 then ones(nout)
         *offset[1] else offset);
    
    Integer tableID;
    
    function tableTimeInit 
      input Real timeIn;
      input Real startTime;
      input Integer ipoType;
      input Integer expoType;
      input String tableName;
      input String fileName;
      input Real table[:, :];
      input Integer colWise;
      output Integer tableID;
    external "C" tableID = dymTableTimeIni2(timeIn, startTime, ipoType,
        expoType, tableName, fileName, table, size(table, 1), size(table, 2),
        colWise);
    end tableTimeInit;
    
    function tableTimeIpo 
      input Integer tableID;
      input Integer icol;
      input Real timeIn;
      output Real value;
    external "C" value = dymTableTimeIpo2(tableID, icol, timeIn);
    end tableTimeIpo;
    
    function tableTimeTmin 
      input Integer tableID;
      output Real Tmin "minimum time value in table";
    external "C" Tmin = dymTableTimeTmin(tableID);
    end tableTimeTmin;
    
    function tableTimeTmax 
      input Integer tableID;
      output Real Tmax "maximum time value in table";
    external "C" Tmax = dymTableTimeTmax(tableID);
    end tableTimeTmax;
    annotation (
      Documentation(info="<HTML>
<p>
This block generates an output signal y[:] by <b>linear interpolation</b> in
a table. The time points and function values are stored in a matrix
<b>table[i,j]</b>, where the first column table[:,1] contains the
time points and the other columns contain the data to be interpolated.
Via parameter <b>columns</b> it can be defined which columns of the
table are interpolated. If, e.g., columns={2,4}, it is assumed that
2 output signals are present and that the first output is computed
by interpolation of column 2 and the second output is computed
by interpolation of column 4 of the table matrix.
The table interpolation has the following properties:
</p>
<ul>
<li>The time points need to be <b>monotonically increasing</b>. </li>
<li><b>Discontinuities</b> are allowed, by providing the same
    time point twice in the table. </li>
<li>Values <b>outside</b> of the table range, are computed by
    extrapolation according to the setting of parameter
    <b>extrapolation</b>:
<pre>
  extrapolation = 0: hold the first or last value of the table,
                     if outside of the range.
                = 1: extrapolate through the last or first two
                     points of the table.
                = 2: periodically repeat the table data
                     (periodical function).
</pre></li>
<li>Via parameter <b>smoothness</b> it is defined how the data is interpolated:
<pre>
  smoothness = 0: linear interpolation
             = 1: smooth interpolation with Akima Splines such
                  that der(y) is continuous.
</pre></li>
<li>If the table has only <b>one row</b>, no interpolation is performed and
    the table values of this row are just returned.</li>
<li>Via parameters <b>startTime</b> and <b>offset</b> the curve defined
    by the table can be shifted both in time and in the ordinate value.
    The time instants stored in the table are therefore <b>relative</b>
    to <b>startTime</b>.
    If time &lt; startTime, no interpolation is performed and the offset
    is used as ordinate value for all outputs.
<li>The table is implemented in a numerically sound way by
    generating <b>time events</b> at interval boundaries,
    in order to not integrate over a discontinuous or not differentiable
    points.
<li>For special applications it is sometimes needed to know the minimum
    and maximum time instant defined in the table as a parameter. For this
    reason parameters <b>t_min</b> and <b>t_max</b> are provided and can be access from
    the outside of the table object.
</li>
</ul>
<p>
Example:
</p>
<pre>
   table = [0  0
            1  0
            1  1
            2  4
            3  9
            4 16]; extrapolation = 1 (default)
If, e.g., time = 1.0, the output y =  0.0 (before event), 1.0 (after event)
    e.g., time = 1.5, the output y =  2.5,
    e.g., time = 2.0, the output y =  4.0,
    e.g., time = 5.0, the output y = 23.0 (i.e. extrapolation via last 2 points).
</pre>
<p>
The table matrix can be defined in the following ways:
</p>
<ol>
<li> Explicitly supplied as <b>parameter matrix</b> \"table\",
     and the other parameters have the following values:
<pre>
   tableName is \"NoName\" or has only blanks,
   fileName  is \"NoName\" or has only blanks.
</pre></li>
<li> <b>Read</b> from a <b>file</b> \"fileName\" where the matrix is stored as
      \"tableName\". Both ASCII and binary file format is possible.
      (the ASCII format is described below).
      It is most convenient to generate the binary file from Matlab
      (Matlab 4 storage format), e.g., by command
<pre>
   save tables.mat tab1 tab2 tab3 -V4
</pre>
      when the three tables tab1, tab2, tab3 should be
      used from the model.</li>
<li>  Statically stored in function \"usertab\" in file \"usertab.c\".
      The matrix is identified by \"tableName\". Parameter
      fileName = \"NoName\" or has only blanks.</li>
</ol>
<p>
Table definition methods (1) and (3) do <b>not</b> allocate dynamic memory,
and do not access files, whereas method (2) does. Therefore (1) and (3)
are suited for hardware-in-the-loop simulation (e.g. with dSpace hardware).
When the constant \"NO_FILE\" is defined in \"usertab.c\", all parts of the
source code of method (2) are removed by the C-preprocessor, such that
no dynamic memory allocation and no access to files takes place.
</p>
<p>
If tables are read from an ASCII-file, the file need to have the
following structure (\"-----\" is not part of the file content):
</p>
<pre>
-----------------------------------------------------
#1
double tab1(6,2)   # comment line
  0   0
  1   0
  1   1
  2   4
  3   9
  4  16
double tab2(6,2)   # another comment line
  0   0
  2   0
  2   2
  4   8
  6  18
  8  32
-----------------------------------------------------
</pre>
<p>
Note, that the first two characters in the file need to be
\"#1\". Afterwards, the corresponding matrix has to be declared
with type, name and actual dimensions. Finally, in successive
rows of the file, the elements of the matrix have to be given.
Several matrices may be defined one after another.
</p>
<p><b>Release Notes:</b></p>
<ul>
<li><i>March 31, 2001</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Used CombiTableTime as a basis and added the
       arguments <b>extrapolation, columns, startTime</b>.
       This allows periodic function definitions. </li>
</ul>
</HTML>
"),   Icon(
        Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
              fillColor=8)),
        Line(points=[-80, 68; -80, -80], style(color=8)),
        Line(points=[-90, -70; 82, -70], style(color=8)),
        Polygon(points=[90, -70; 68, -62; 68, -78; 90, -70], style(
            color=8,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-48, 70; 2, -50], style(
            color=7,
            fillColor=49,
            fillPattern=1)),
        Line(points=[-48, -50; -48, 70; 52, 70; 52, -50; -48, -50; -48, -20; 52,
                -20; 52, 10; -48, 10; -48, 40; 52, 40; 52, 70; 2, 70; 2, -51],
            style(color=0))),
      Diagram(
        Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
              fillColor=8)),
        Line(points=[-80, 68; -80, -80], style(color=8)),
        Line(points=[-90, -70; 82, -70], style(color=8)),
        Polygon(points=[90, -70; 68, -62; 68, -78; 90, -70], style(
            color=8,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-20, 90; 20, -30], style(
            color=7,
            fillColor=8,
            fillPattern=1)),
        Line(points=[-20, -30; -20, 90; 80, 90; 80, -30; -20, -30; -20, 0; 80,
              0; 80, 30; -20, 30; -20, 60; 80, 60; 80, 90; 20, 90; 20, -30],
            style(color=0)),
        Text(
          extent=[-77, -42; -38, -58],
          string="offset",
          style(color=9)),
        Polygon(points=[-31, -30; -33, -40; -28, -40; -31, -30], style(
            color=8,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[-30, -70; -33, -60; -28, -60; -30, -70; -30, -70],
            style(
            color=8,
            fillColor=8,
            fillPattern=1)),
        Line(points=[-31, -31; -31, -70], style(
            color=8,
            pattern=1,
            thickness=1,
            arrow=0)),
        Line(points=[-20, -30; -20, -70], style(color=8, pattern=2)),
        Text(
          extent=[-38, -70; 8, -88],
          string="startTime",
          style(color=9)),
        Line(points=[-20, -30; -80, -30], style(color=8, pattern=2)),
        Text(
          extent=[-73, 93; -41, 78],
          style(color=9),
          string="y"),
        Text(
          extent=[66, -81; 91, -93],
          string="time",
          style(color=9)),
        Text(
          extent=[-19, 83; 20, 68],
          string="time",
          style(color=0)),
        Text(
          extent=[21,82; 50,68],
          style(color=0),
          string="y[1]"),
        Line(points=[50, 90; 50, -30], style(color=0)),
        Line(points=[80, 0; 100, 0]),
        Text(extent=[34, -30; 71, -42], string="columns"),
        Text(
          extent=[51,82; 80,68],
          style(color=0),
          string="y[2]")));
  equation 
    if tableOnFile then
      assert(tableName<>"NoName", "tableOnFile = true and no table name given");
    end if;
    if not tableOnFile then
      assert(size(table,1) > 0 and size(table,2) > 0, "tableOnFile = false and parameter table is an empty matrix");
    end if;
    for i in 1:nout loop
      y[i] = p_offset[i] + tableTimeIpo(tableID, columns[i], time);
    end for;
    when initial() then
      tableID=tableTimeInit(0.0, startTime, smoothness,
        extrapolation, (if not tableOnFile then "NoName" else tableName),
                       (if not tableOnFile then "NoName" else fileName), table, 0);
    end when;
  initial equation
      t_min=tableTimeTmin(tableID);
      t_max=tableTimeTmax(tableID);
  end CombiTimeTable;
  
    block BooleanConstant "Generate constant signal of type Boolean" 
      parameter Boolean k=true "Constant output value";
      extends Interfaces.partialBooleanSource;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.29,
          y=0.23,
          width=0.6,
          height=0.6),
        Icon(Line(points=[-80, 0; 80, 0], style(color=0)), Text(
            extent=[-150, -140; 150, -110],
            style(color=0),
            string="%k")),
        Diagram(
          Line(points=[-80, 0; 80, 0], style(color=0, thickness=2)),
          Text(
            extent=[-83, 20; -63, 0],
            string="k",
            style(color=9)),
          Text(
            extent=[-100, 6; -80, -6],
            string="true",
            style(color=9)),
          Text(
            extent=[-104, -58; -78, -70],
            string="false",
            style(color=9))));
    equation 
      y = k;
    end BooleanConstant;
  
    block BooleanStep "Generate step signal of type Boolean" 
      parameter Modelica.SIunits.Time startTime=0 "Time instant of step start";
      parameter Boolean startValue = false "Output before startTime";
    
      extends Interfaces.partialBooleanSource;
      annotation (Icon(Line(points=[-80, -70; 0, -70; 0, 50; 80, 50], style(color=
                 0)), Text(
            extent=[-150, -140; 150, -110],
            style(color=0),
            string="%startTime")),
                              Diagram(
          Line(points=[-80, -70; 0, -70; 0, 50; 80, 50], style(color=0, thickness=
                 2)),
          Text(
            extent=[-25,-76; 21,-94],
            string="startTime",
            style(color=0, rgbcolor={0,0,0})),
          Polygon(points=[2, 50; -80, 50; 2, 50], style(color=8, pattern=2)),
          Text(
            extent=[-130,56; -86,42],
            string="not startValue",
            style(color=0, rgbcolor={0,0,0})),
          Text(
            extent=[-126,-64; -94,-78],
            string="startValue",
            style(color=0, rgbcolor={0,0,0}))));
    equation 
     y = if time >= startTime then not startValue else startValue;
    end BooleanStep;
  
    block BooleanPulse "Generate pulse signal of type Boolean" 
    
      parameter Real width(
        final min=Modelica.Constants.small,
        final max=100) = 50 "Width of pulse in % of period";
      parameter Modelica.SIunits.Time period(final min=Modelica.Constants.small)=
         1 "Time for one period";
      parameter Modelica.SIunits.Time startTime=0 "Time instant of first pulse";
      extends Modelica.Blocks.Interfaces.partialBooleanSource;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.32,
          y=0.08,
          width=0.6,
          height=0.6),
        Icon(Text(
            extent=[-150, -140; 150, -110],
            style(color=0),
            string="%period"),
                             Line(points=[-80, -70; -40, -70; -40, 44; 0, 44; 0,
                -70; 40, -70; 40, 44; 79, 44], style(color=0))),
        Diagram(
          Text(
            extent=[-60, -72; -14, -90],
            string="startTime",
          style(color=0, rgbcolor={0,0,0})),
          Line(points=[-78, -70; -40, -70; -40, 20; 20, 20; 20, -70; 50, -70; 50,
                  20; 100, 20], style(color=0, thickness=2)),
          Line(points=[-40, 61; -40, 21], style(color=8, pattern=2)),
          Line(points=[20, 44; 20, 20], style(color=9, pattern=2)),
          Line(points=[50, 58; 50, 20], style(color=8, pattern=2)),
          Line(points=[-40, 53; 50, 53], style(color=8)),
          Line(points=[-40, 35; 20, 35], style(color=8)),
          Text(
            extent=[-30, 67; 16, 55],
            string="period",
          style(color=0, rgbcolor={0,0,0})),
          Text(
            extent=[-35, 49; 14, 37],
            string="width",
          style(color=0, rgbcolor={0,0,0})),
          Line(points=[-80, 20; -41, 20], style(color=8, pattern=2)),
          Polygon(points=[-40, 35; -31, 37; -31, 33; -40, 35], style(
              color=8,
              fillColor=8,
              fillPattern=1)),
          Polygon(points=[20, 35; 12, 37; 12, 33; 20, 35], style(
              color=8,
              fillColor=8,
              fillPattern=1)),
          Polygon(points=[-40, 53; -31, 55; -31, 51; -40, 53], style(
              color=8,
              fillColor=8,
              fillPattern=1)),
          Polygon(points=[50, 53; 42, 55; 42, 51; 50, 53], style(
              color=8,
              fillColor=8,
              fillPattern=1)),
          Text(
            extent=[-109, 28; -77, 14],
            string="true",
          style(color=0, rgbcolor={0,0,0})),
          Text(
            extent=[-101, -56; -80, -71],
            string="false",
          style(color=0, rgbcolor={0,0,0}))));
  protected 
      parameter Modelica.SIunits.Time Twidth=period*width/100 
      "width of one pulse"                                              annotation(Hide=true);
      discrete Modelica.SIunits.Time pulsStart "Start time of pulse" 
                                                 annotation(Hide=true);
    initial equation 
      pulsStart = startTime;
    equation 
        when sample(startTime, period) then
          pulsStart = time;
        end when;
        y = time >= pulsStart and time < pulsStart + Twidth;
    end BooleanPulse;
  
    block SampleTrigger "Generate sample trigger signal" 
      parameter Modelica.SIunits.Time period(final min=Modelica.Constants.small)=
         0.01 "Sample period";
      parameter Modelica.SIunits.Time startTime=0 
      "Time instant of first sample trigger";
      extends Interfaces.partialBooleanSource;
    
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.22,
          y=0.02,
          width=0.58,
          height=0.8),
        Icon(
          Line(points=[-60, -70; -60, 70], style(color=0)),
          Line(points=[-20, -70; -20, 70], style(color=0)),
          Line(points=[20, -70; 20, 70], style(color=0)),
          Line(points=[60, -70; 60, 70], style(color=0)),
          Text(
            extent=[-150, -140; 150, -110],
            style(color=0),
            string="%period")),
        Diagram(
          Text(
            extent=[-53, -71; -7, -89],
            string="startTime",
            style(color=0, rgbcolor={0,0,0})),
          Line(points=[-30, 47; -30, 19], style(color=8, pattern=2)),
          Line(points=[0, 47; 0, 18], style(color=8, pattern=2)),
          Line(points=[-30, 41; 0, 41], style(color=8)),
          Text(
            extent=[-37, 61; 9, 49],
            string="period",
            style(color=0, rgbcolor={0,0,0})),
          Line(points=[-80, 19; -30, 19], style(color=8, pattern=2)),
          Polygon(points=[-30, 41; -21, 43; -21, 39; -30, 41], style(
              color=8,
              fillColor=8,
              fillPattern=1)),
          Polygon(points=[0, 41; -8, 43; -8, 39; 0, 41], style(
              color=8,
              fillColor=8,
              fillPattern=1)),
          Text(
            extent=[-100, 28; -80, 13],
            string="true",
            style(color=0, rgbcolor={0,0,0})),
          Text(
            extent=[-100, -56; -80, -71],
            string="false",
            style(color=0, rgbcolor={0,0,0})),
          Line(points=[0, -70; 0, 19], style(color=0, thickness=2)),
          Line(points=[-30, -70; -30, 19], style(color=0, thickness=2)),
          Line(points=[30, -70; 30, 19], style(color=0, thickness=2)),
          Line(points=[60, -70; 60, 19], style(color=0, thickness=2))));
    equation 
      y = sample(startTime, period);
    end SampleTrigger;
  
    block BooleanTable 
    "Generate a Boolean output signal based on a vector of time instants" 
    
      parameter Boolean startValue = false 
      "Start value of y. At time = table[1], y changes to 'not startValue'";
      parameter Modelica.SIunits.Time table[:] 
      "Vector of time points. At every time point, the output y gets its opposite value";
      extends Interfaces.partialBooleanSource;
      annotation (
        Icon(
          Rectangle(extent=[-18,70; 32,-50],  style(
              color=7,
              fillColor=8,
              fillPattern=1)),
          Line(points=[-18,-50; -18,70; 32,70; 32,-50; -18,-50; -18,-20; 32,-20; 32,
                10; -18,10; -18,40; 32,40; 32,70; 32,70; 32,-51],
              style(color=0))),
        Diagram(
          Rectangle(extent=[-34,66; 16,-54],   style(
              color=7,
              fillColor=8,
              fillPattern=1)),
          Line(points=[-34,-54; -34,66; 16,66; 16,-54; -34,-54; -34,-24; 16,
              -24; 16,6; -34,6; -34,36; 16,36; 16,66; 16,66; 16,-55],
              style(color=0)),
          Text(
            extent=[-29,59; 10,44],
            string="time",
            style(color=0))),
        Documentation(info=""));
    
  protected 
      function getFirstIndex "Get first index of table and check table" 
        input Real table[:] "Vector of time instants";
        input Modelica.SIunits.Time simulationStartTime "Simulation start time";
        input Boolean startValue "Value of y for y < table[1]";
        output Integer index "First index to be used";
        output Modelica.SIunits.Time nextTime "Time instant of first event";
        output Boolean y "Value of y at simulationStartTime";
    protected 
        Modelica.SIunits.Time t_last;
        Integer j;
        Integer n=size(table,1) "Number of table points";
      algorithm 
        if size(table,1) == 0 then
           index :=0;
           nextTime :=-Modelica.Constants.inf;
           y :=startValue;
        elseif size(table,1) == 1 then
           index :=1;
           if table[1] > simulationStartTime then
              nextTime :=table[1];
              y        :=startValue;
           else
              nextTime :=simulationStartTime;
              y        :=startValue;
           end if;
        else
        
        // Check whether time values are strict monotonically increasing
          t_last :=table[1];
          for i in 2:n loop
             assert(table[i] > t_last,
               "Time values of table not strict monotonically increasing: table[" +
               String(i-1) + "] = " + String(table[i-1]) + "table[" + String(i)   +
               "] = " + String(table[i]));
          end for;
        
          // Determine first index in table
          j := 1;
          y := startValue;
          while j < n and table[j] <= simulationStartTime loop
            y :=not  y;
            j := j + 1;
          end while;
        
          if j == 1 then
             nextTime := table[1];
             y        := startValue;
          elseif j == n and table[n] <= simulationStartTime then
             nextTime := simulationStartTime - 1;
             y        :=not  y;
          else
             nextTime := table[j];
          end if;
        
          index := j;
        end if;
      end getFirstIndex;
    
      parameter Integer n = size(table,1) "Number of table points";
      Modelica.SIunits.Time nextTime;
      Integer index "Index of actual table entry";
    initial algorithm 
      (index, nextTime, y) :=getFirstIndex(table, time, startValue);
    algorithm 
      when time >= pre(nextTime) and n > 0 then
         if index < n then
            index    := index + 1;
            nextTime := table[index];
            y        :=not  y;
         elseif index == n then
            index := index + 1;
            y     :=not  y;
         end if;
      end when;
    end BooleanTable;
  
  block IntegerConstant "Generate constant signal of type Integer" 
    parameter Integer k=1 "Constant output value";
    extends Interfaces.IntegerSO;
    
    annotation (Icon(
        Line(points=[-80, 68; -80, -80], style(color=8)),
        Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
              fillColor=8)),
        Line(points=[-90, -70; 82, -70], style(color=8)),
        Polygon(points=[90, -70; 68, -62; 68, -78; 90, -70], style(color=8,
              fillColor=8)),
        Line(points=[-80, 0; 80, 0], style(color=0)),
        Text(
          extent=[-150, -150; 150, -110],
          string="k=%k",
          style(color=0))), Diagram(
        Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
              fillColor=8)),
        Line(points=[-80, 68; -80, -80], style(color=8)),
        Line(points=[-80, 0; 80, 0], style(color=0, thickness=2)),
        Line(points=[-90, -70; 82, -70], style(color=8)),
        Polygon(points=[90, -70; 68, -62; 68, -78; 90, -70], style(color=8,
              fillColor=8)),
        Text(
          extent=[-75, 94; -22, 76],
          string="outPort",
          style(color=9)),
        Text(
          extent=[70, -80; 94, -100],
          string="time",
          style(color=9)),
        Text(
          extent=[-101, 8; -81, -12],
          string="k",
          style(color=9))));
  equation 
    y = k;
  end IntegerConstant;
  
  block IntegerStep "Generate step signal of type Integer" 
    parameter Integer height=1 "Height of step";
    extends Interfaces.IntegerSignalSource;
    annotation (Icon(
        Line(points=[-80, 68; -80, -80], style(color=8)),
        Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
              fillColor=8)),
        Line(points=[-90, -70; 82, -70], style(color=8)),
        Polygon(points=[90, -70; 68, -62; 68, -78; 90, -70], style(color=8,
              fillColor=8)),
        Line(points=[-80, -70; 0, -70; 0, 50; 80, 50], style(color=0)),
        Text(
          extent=[-150, -150; 150, -110],
          string="startTime=%startTime",
          style(color=0))), Diagram(
        Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
              fillColor=8)),
        Line(points=[-80, 68; -80, -80], style(color=8)),
        Line(points=[-80, -18; 0, -18; 0, 50; 80, 50], style(color=0, thickness=
               2)),
        Line(points=[-90, -70; 82, -70], style(color=8)),
        Polygon(points=[90, -70; 68, -62; 68, -78; 90, -70], style(color=8,
              fillColor=8)),
        Text(
          extent=[70, -80; 94, -100],
          string="time",
          style(color=9)),
        Text(
          extent=[-21, -72; 25, -90],
          string="startTime",
          style(color=9)),
        Line(points=[0, -17; 0, -71], style(color=8, pattern=2)),
        Text(
          extent=[-68, -36; -22, -54],
          string="offset",
          style(color=9)),
        Line(points=[-13, 50; -13, -17], style(
            color=8,
            pattern=1,
            thickness=1,
            arrow=0)),
        Polygon(points=[2, 50; -19, 50; 2, 50], style(color=8, pattern=2)),
        Polygon(points=[-13, -17; -16, -4; -10, -4; -13, -17; -13, -17], style(
            color=8,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[-13, 50; -16, 37; -9, 37; -13, 50], style(
            color=8,
            fillColor=8,
            fillPattern=1)),
        Text(
          extent=[-68, 26; -22, 8],
          string="height",
          style(color=9)),
        Polygon(points=[-13, -69; -16, -56; -10, -56; -13, -69; -13, -69],
            style(
            color=8,
            fillColor=8,
            fillPattern=1)),
        Line(points=[-13, -18; -13, -70], style(
            color=8,
            pattern=1,
            thickness=1,
            arrow=0)),
        Polygon(points=[-13, -18; -16, -31; -9, -31; -13, -18], style(
            color=8,
            fillColor=8,
            fillPattern=1)),
        Text(
          extent=[-72, 100; -31, 80],
          string="outPort",
          style(color=9))));
  equation 
    y = offset + (if time < startTime then 0 else height);
  end IntegerStep;
  
end Sources;
