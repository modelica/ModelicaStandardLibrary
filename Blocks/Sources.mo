package Sources 
  "Signal source blocks generating Real, Integer and Boolean signals" 
  
  extends Modelica.Icons.Library;
  
  annotation( Window(
      x=0.06,
      y=0.1,
      width=0.43,
      height=0.65,
      library=1,
      autolayout=1),
    Documentation(info="<html>
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
</pre>

<p>The following <b>sources</b> are provided to generate <b>Boolean</b> signals:</p>

<pre>
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
All sources are <b>vectorized</b>. This means that the output
is a vector of signals. The number of outputs is in correspondance
to the lenght of the parameter vectors defining the signals. Examples:
</p>

<pre>
    // output.signal[1] = 2*sin(2*pi*2.1);
    // output.signal[2] = 3*sin(2*pi*2.3);
    Modelica.Blocks.Sources.Sine s1(amplitude={2,3}, freqHz={2.1,2.2});

    // output.signal[1] = 3*sin(2*pi*2.1);
    // output.signal[2] = 3*sin(2*pi*2.3);
    Modelica.Blocks.Sources.Sine s2(amplitude={3}, freqHz={2.1,2.3});
</pre>

<p>
The first instance s1 consists of two sinusoidal output signals
with the given amplitudes and frequencies. The second instance s2
consists also of two sinusoidal output signals. Since the
amplitudes are the same for all output signals of s2, this value
has to be provided only once. This approached is used for all
parameters of signal sources: Whenever only a scalar value is
provided for one parameter, then this value is used for all output
signals.
</p>

<p>
All Real source signals (with the exception of the Constant source)
have at least the following two parameters:
</p>

<pre>
   <b>offset</b>       Value which is added to all signal values.
   <b>startTime</b>    Start time of signal. For time < startTime,
                the output is set to offset.
</pre>

<p>
The <b>offset</b> parameter is especially useful in order to shift
the corresponding source, such that at initial time the system
is stationary. To determine the corresponding value of offset,
usually requires a trimming calculation.
</p>

<dl>
<dt><b>Main Author:</b>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum fuer Luft und Raumfahrt e.V. (DLR)<br>
    Oberpfaffenhofen<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
</dl>
<br>

<p><b>Release Notes:</b></p>
<ul>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Integer sources added. Step, TimeTable and BooleanStep slightly changed
       (see <a href=\"../Documentation/ChangeNotes1.5.html\">Change Notes</a>).</li>

<li><i>November 8, 1999</i>
       by <a href=\"http://people.eas.iis.fhg.de/Christoph.Clauss/\">Christoph Clau&szlig;</a>,
       <a href=\"http://people.eas.iis.fhg.de/Andre.Schneider/\">Andr&eacute; Schneider</a> and
       <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       New sources: Exponentials, TimeTable. Trapezoid slightly enhanced
       (nperiod=-1 is an infinite number of periods).</li>

<li><i>October 31, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>,
       <a href=\"http://people.eas.iis.fhg.de/Christoph.Clauss/\">Christoph Clau&szlig;</a> and
       <a href=\"http://people.eas.iis.fhg.de/Andre.Schneider/\">Andr&eacute; Schneider</a>:
       All sources vectorized. New sources: ExpSine, Trapezoid,
       BooleanConstant, BooleanStep, BooleanPulse, SampleTrigger.
       Improved documentation, especially detailed description of
       signals in diagram layer.</li>

<li><i>June 29, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized a first version, based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist.</li>
</ul>
<br>


<p><b>Copyright &copy; 1999-2002, Modelica Association, DLR and Fraunhofer-Gesellschaft.</b></p>

<p><i>
The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".
</i></p>
</HTML>
"));
  block Clock "Generate actual time signals " 
    parameter Real offset[:]={0} "Offsets of output signals";
    parameter SI.Time startTime[:]={0} "Output = offset for time < startTime";
    extends Interfaces.MO(final nout=max([size(offset, 1); size(startTime, 1)]));
  protected 
    parameter Real p_offset[nout]=(if size(offset, 1) == 1 then ones(nout)*
        offset[1] else offset);
    parameter SI.Time p_startTime[nout]=(if size(startTime, 1) == 1 then ones(
        nout)*startTime[1] else startTime);
    
    annotation(
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
          string="outPort",
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
    for i in 1:nout loop
      outPort.signal[i] = p_offset[i] + (if time < p_startTime[i] then 0 else 
        time - p_startTime[i]);
    end for;
  end Clock;
  
  block Constant "Generate constant signals of type Real" 
    parameter Real k[:]={1} "Constant output values";
    extends Interfaces.MO(final nout=size(k, 1));
    
    annotation(
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
    outPort.signal = k;
  end Constant;
  
  block Step "Generate step signals of type Real" 
    parameter Real height[:]={1} "Heights of steps";
    extends Interfaces.SignalSource(final nout=max([size(height, 1); size(
          offset, 1); size(startTime, 1)]));
  protected 
    parameter Real p_height[nout]=(if size(height, 1) == 1 then ones(nout)*
        height[1] else height);
    parameter Real p_offset[nout]=(if size(offset, 1) == 1 then ones(nout)*
        offset[1] else offset);
    parameter SI.Time p_startTime[nout]=(if size(startTime, 1) == 1 then ones(
        nout)*startTime[1] else startTime);
    annotation( Icon(
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
    for i in 1:nout loop
      outPort.signal[i] = p_offset[i] + (if time < p_startTime[i] then 0 else 
        p_height[i]);
    end for;
  end Step;
  
  block Ramp "Generate ramp signals" 
    parameter Real height[:]={1} "Heights of ramps";
    parameter Real duration[:](min=Modelica.Constants.small)=  {2} 
      "Durations of ramps";
    parameter Real offset[:]={0} "Offsets of output signals";
    parameter SI.Time startTime[:]={0} "Output = offset for time < startTime";
    extends Interfaces.MO(final nout=max([size(height, 1); size(duration, 1);
          size(offset, 1); size(startTime, 1)]));
  protected 
    parameter Real p_height[nout]=(if size(height, 1) == 1 then ones(nout)*
        height[1] else height);
    parameter Real p_duration[nout]=(if size(duration, 1) == 1 then ones(nout)*
        duration[1] else duration);
    parameter Real p_offset[nout]=(if size(offset, 1) == 1 then ones(nout)*
        offset[1] else offset);
    parameter SI.Time p_startTime[nout]=(if size(startTime, 1) == 1 then ones(
        nout)*startTime[1] else startTime);
    
    annotation(
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
        Line(points=[-80, -20; -20, -20; 50, 50], style(color=0, thickness=2)),
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
          string="outPort",
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
    for i in 1:nout loop
      outPort.signal[i] = p_offset[i] + (if time < p_startTime[i] then 0 else 
        if time < (p_startTime[i] + p_duration[i]) then (time - p_startTime[i])
        *p_height[i]/p_duration[i] else p_height[i]);
    end for;
  end Ramp;
  
  block Sine "Generate sine signals" 
    parameter Real amplitude[:]={1} "Amplitudes of sine waves";
    parameter SI.Frequency freqHz[:]={1} "Frequencies of sine waves";
    parameter SI.Angle phase[:]={0} "Phases of sine waves";
    parameter Real offset[:]={0} "Offsets of output signals";
    parameter SI.Time startTime[:]={0} "Output = offset for time < startTime";
    extends Interfaces.MO(final nout=max([size(amplitude, 1); size(freqHz, 1);
          size(phase, 1); size(offset, 1); size(startTime, 1)]));
  protected 
    constant Real pi=Modelica.Constants.pi;
    parameter Real p_amplitude[nout]=(if size(amplitude, 1) == 1 then ones(nout)
         *amplitude[1] else amplitude);
    parameter Real p_freqHz[nout]=(if size(freqHz, 1) == 1 then ones(nout)*
        freqHz[1] else freqHz);
    parameter Real p_phase[nout]=(if size(phase, 1) == 1 then ones(nout)*phase[
        1] else phase);
    parameter Real p_offset[nout]=(if size(offset, 1) == 1 then ones(nout)*
        offset[1] else offset);
    parameter SI.Time p_startTime[nout]=(if size(startTime, 1) == 1 then ones(
        nout)*startTime[1] else startTime);
    annotation(
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
        Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8, fillColor=
                8)),
        Line(points=[-80, 0; -68.7, 34.2; -61.5, 53.1; -55.1, 66.4; -49.4, 74.6;
                -43.8, 79.1; -38.2, 79.8; -32.6, 76.6; -26.9, 69.7; -21.3, 59.4;
                -14.9, 44.1; -6.83, 21.2; 10.1, -30.8; 17.3, -50.2; 23.7, -64.2;
                29.3, -73.1; 35, -78.4; 40.6, -80; 46.2, -77.6; 51.9, -71.5;
              57.5, -61.9; 63.9, -47.2; 72, -24.8; 80, 0], style(color=0)),
        Text(
          extent=[-147, -152; 153, -112],
          string="freqHz=%freqHz",
          style(color=0))),
      Diagram(
        Line(points=[-80, -90; -80, 84], style(color=8)),
        Polygon(points=[-80, 100; -86, 84; -74, 84; -80, 100], style(color=8,
              fillColor=8)),
        Line(points=[-99, -40; 85, -40], style(color=8)),
        Polygon(points=[101, -40; 85, -34; 85, -46; 101, -40], style(color=8,
              fillColor=8)),
        Line(points=[-40, 0; -31.6, 34.2; -26.1, 53.1; -21.3, 66.4; -17.1, 74.6;
                -12.9, 79.1; -8.64, 79.8; -4.42, 76.6; -0.201, 69.7; 4.02, 59.4;
                8.84, 44.1; 14.9, 21.2; 27.5, -30.8; 33, -50.2; 37.8, -64.2; 42,
                -73.1; 46.2, -78.4; 50.5, -80; 54.7, -77.6; 58.9, -71.5; 63.1,
              -61.9; 67.9, -47.2; 74, -24.8; 80, 0], style(color=0, thickness=2)),
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
          string="outPort",
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
    for i in 1:nout loop
      outPort.signal[i] = p_offset[i] + (if time < p_startTime[i] then 0 else 
        p_amplitude[i]*Modelica.Math.sin(2*pi*p_freqHz[i]*(time - p_startTime[i]) +
        p_phase[i]));
    end for;
  end Sine;
  
  block ExpSine "Generate exponentially damped sine signals" 
    parameter Real amplitude[:]={1} "Amplitudes of sine waves";
    parameter SI.Frequency freqHz[:]={2} "Frequencies of sine waves";
    parameter SI.Angle phase[:]={0} "Phases of sine waves";
    parameter SI.Damping damping[:]={1} "Damping coefficients of sine waves";
    parameter Real offset[:]={0} "Offsets of output signals";
    parameter SI.Time startTime[:]={0} "Output = offset for time < startTime";
    extends Interfaces.MO(final nout=max([size(amplitude, 1); size(freqHz, 1);
          size(phase, 1); size(damping, 1); size(offset, 1); size(startTime, 1)]));
  protected 
    constant Real pi=Modelica.Constants.pi;
    parameter Real p_amplitude[nout]=(if size(amplitude, 1) == 1 then ones(nout)
         *amplitude[1] else amplitude);
    parameter Real p_freqHz[nout]=(if size(freqHz, 1) == 1 then ones(nout)*
        freqHz[1] else freqHz);
    parameter Real p_phase[nout]=(if size(phase, 1) == 1 then ones(nout)*phase[
        1] else phase);
    parameter Real p_damping[nout]=(if size(damping, 1) == 1 then ones(nout)*
        damping[1] else damping);
    parameter Real p_offset[nout]=(if size(offset, 1) == 1 then ones(nout)*
        offset[1] else offset);
    parameter SI.Time p_startTime[nout]=(if size(startTime, 1) == 1 then ones(
        nout)*startTime[1] else startTime);
    annotation(
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
        Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8, fillColor=
                8)),
        Line(points=[-80, 0; -75.2, 32.3; -72, 50.3; -68.7, 64.5; -65.5, 74.2;
              -62.3, 79.3; -59.1, 79.6; -55.9, 75.3; -52.7, 67.1; -48.6, 52.2;
              -43, 25.8; -35, -13.9; -30.2, -33.7; -26.1, -45.9; -22.1, -53.2;
              -18.1, -55.3; -14.1, -52.5; -10.1, -45.3; -5.23, -32.1; 8.44,
              13.7; 13.3, 26.4; 18.1, 34.8; 22.1, 38; 26.9, 37.2; 31.8, 31.8;
              38.2, 19.4; 51.1, -10.5; 57.5, -21.2; 63.1, -25.9; 68.7, -25.9;
              75.2, -20.5; 80, -13.8], style(color=0)),
        Text(
          extent=[-147, -152; 153, -112],
          string="freqHz=%freqHz",
          style(color=0))),
      Diagram(
        Line(points=[-80, -90; -80, 84], style(color=8)),
        Polygon(points=[-80, 100; -86, 84; -74, 84; -80, 100], style(color=8,
              fillColor=8)),
        Line(points=[-99, -40; 85, -40], style(color=8)),
        Polygon(points=[101, -40; 85, -34; 85, -46; 101, -40], style(color=8,
              fillColor=8)),
        Line(points=[-50, 0; -46.1, 28.2; -43.5, 44; -40.9, 56.4; -38.2, 64.9;
              -35.6, 69.4; -33, 69.6; -30.4, 65.9; -27.8, 58.7; -24.5, 45.7; -
              19.9, 22.5; -13.4, -12.2; -9.5, -29.5; -6.23, -40.1; -2.96, -46.5;
                0.302, -48.4; 3.57, -45.9; 6.83, -39.6; 10.8, -28.1; 21.9, 12;
              25.8, 23.1; 29.7, 30.5; 33, 33.3; 36.9, 32.5; 40.8, 27.8; 46,
              16.9; 56.5, -9.2; 61.7, -18.6; 66.3, -22.7; 70.9, -22.6; 76.1, -
              18; 80, -12.1], style(color=0, thickness=2)),
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
          string="outPort",
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
    for i in 1:nout loop
      outPort.signal[i] = p_offset[i] + (if time < p_startTime[i] then 0 else 
        p_amplitude[i]*Modelica.Math.exp(-(time - p_startTime[i])*p_damping[i])*Modelica.Math.sin(
         2*pi*p_freqHz[i]*(time - p_startTime[i]) + p_phase[i]));
    end for;
  end ExpSine;
  
  block Exponentials "Generate a rising and falling exponential signal" 
    parameter Real outMax[:]={1} "Height of output for infinite riseTime";
    parameter SI.Time riseTime[:](min=0)=  {0.5} "Rise time";
    parameter SI.Time riseTimeConst[:](min=Modelica.Constants.small)=  {0.1} 
      "Rise time constant";
    parameter SI.Time fallTimeConst[:](min=Modelica.Constants.small)=  riseTimeConst 
      "Fall time constant";
    parameter Real offset[:]={0} "Offsets of output signals";
    parameter SI.Time startTime[:]={0} "Output = offset for time < startTime";
    extends Interfaces.MO(final nout=max([size(outMax, 1); size(riseTime, 1);
          size(riseTimeConst, 1); size(fallTimeConst, 1); size(offset, 1); size(
           startTime, 1)]));
  protected 
    parameter Real p_outMax[nout]=(if size(outMax, 1) == 1 then ones(nout)*
        outMax[1] else outMax);
    parameter SI.Time p_riseTime[nout]=(if size(riseTime, 1) == 1 then ones(
        nout)*riseTime[1] else riseTime);
    parameter SI.Time p_riseTimeConst[nout]=(if size(riseTimeConst, 1) == 1 then 
              ones(nout)*riseTimeConst[1] else riseTimeConst);
    parameter SI.Time p_fallTimeConst[nout]=(if size(fallTimeConst, 1) == 1 then 
              ones(nout)*fallTimeConst[1] else fallTimeConst);
    parameter Real p_offset[nout]=(if size(offset, 1) == 1 then ones(nout)*
        offset[1] else offset);
    parameter SI.Time p_startTime[nout]=(if size(startTime, 1) == 1 then ones(
        nout)*startTime[1] else startTime);
    Real y_riseTime[nout];
    annotation(
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
              34.5; -38.3, 42.1; -31.2, 48.6; -22.7, 54.3; -12.1, 59.2; -10, 60;
                -7.88, 47.5; -5.05, 32.7; -2.22, 19.8; 0.606, 8.45; 4.14, -3.7;
                7.68, -14; 11.9, -24.2; 16.2, -32.6; 21.1, -40.5; 26.8, -47.4;
              33.1, -53.3; 40.9, -58.5; 50.8, -62.8; 60, -65.4], style(color=0)),
        Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
              fillColor=8)),
        Line(points=[-80, 68; -80, -80], style(color=8)),
        Text(
          extent=[-150, -150; 150, -110],
          string="riseTime=%riseTime",
          style(color=0))),
      Diagram(
        Line(points=[-100, -70; 84, -70], style(color=8)),
        Polygon(points=[100, -70; 84, -64; 84, -76; 100, -70], style(color=8,
              fillColor=8)),
        Line(points=[-40, -30; -37.2, -15.3; -34.3, -2.1; -30.8, 12.4; -27.3,
              25; -23.7, 35.92; -19.5, 47.18; -15.3, 56.7; -10.3, 66; -4.6,
              74.5; 1.7, 82.1; 8.8, 88.6; 17.3, 94.3; 27.9, 99.2; 30, 100;
              32.12, 87.5; 34.95, 72.7; 37.78, 59.8; 40.606, 48.45; 44.14, 36.3;
                47.68, 26; 51.9, 15.8; 56.2, 7.4; 61.1, -0.5; 66.8, -7.4; 73.1,
                -13.3; 80.9, -18.5; 90.8, -22.8; 100, -25.4], style(color=0,
              thickness=2)),
        Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
              fillColor=8)),
        Line(points=[-80, 68; -80, -80], style(color=8)),
        Text(
          extent=[-70, 91; -29, 71],
          string="outPort",
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
    for i in 1:nout loop
      y_riseTime[i] = p_outMax[i]*(1 - Modelica.Math.exp(-p_riseTime[i]/p_riseTimeConst[
        i]));
      outPort.signal[i] = p_offset[i] + (if (time < p_startTime[i]) then 0 else 
              if (time < (p_startTime[i] + p_riseTime[i])) then p_outMax[i]*(1
         - Modelica.Math.exp(-(time - p_startTime[i])/p_riseTimeConst[i])) else y_riseTime[i]
        *Modelica.Math.exp(-(time - p_startTime[i] - p_riseTime[i])/p_fallTimeConst[i]));
    end for;
    
  end Exponentials;
  
  block Pulse "Generate pulse signals of type Real" 
    parameter Real amplitude[:]={1} "Amplitudes of pulses";
    parameter Real width[:](
      final min=Modelica.Constants.small,
      final max=100)=  {50} "Widths of pulses in % of periods";
    parameter SI.Time period[:](final min=Modelica.Constants.small)=  {1} 
      "Times for one period";
    parameter Real offset[:]={0} "Offsets of output signals";
    parameter SI.Time startTime[:]={0} "Output = offset for time < startTime";
    extends Interfaces.MO(final nout=max([size(amplitude, 1); size(width, 1);
          size(period, 1); size(offset, 1); size(startTime, 1)]));
  protected 
    parameter Real p_amplitude[nout]=(if size(amplitude, 1) == 1 then ones(nout)
         *amplitude[1] else amplitude);
    parameter SI.Time p_period[nout]=(if size(period, 1) == 1 then ones(nout)*
        period[1] else period);
    parameter SI.Time p_width[nout]=diagonal(p_period)*(if size(width, 1) == 1 then 
              ones(nout)*width[1] else width)/100 "Width of one pulse";
    parameter Real p_offset[nout]=(if size(offset, 1) == 1 then ones(nout)*
        offset[1] else offset);
    parameter SI.Time p_startTime[nout]=(if size(startTime, 1) == 1 then ones(
        nout)*startTime[1] else startTime);
    SI.Time T0[nout](final start=p_startTime) "Start time of current period";
    annotation(
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
        Line(points=[-80, -70; -40, -70; -40, 44; 0, 44; 0, -70; 40, -70; 40,
              44; 79, 44], style(color=0)),
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
          string="outPort",
          style(color=9)),
        Text(
          extent=[70, -80; 94, -100],
          string="time",
          style(color=9)),
        Line(points=[-10, 0; -10, -70], style(color=8, pattern=2)),
        Line(points=[-80, 0; -10, 0; -10, 50; 30, 50; 30, 0; 50, 0; 50, 50; 90,
                50], style(color=0, thickness=2)),
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
  equation 
    for i in 1:nout loop
      when sample(p_startTime[i], p_period[i]) then
        T0[i] = time;
      end when;
      outPort.signal[i] = p_offset[i] + (if time < p_startTime[i] or time >= T0
        [i] + p_width[i] then 0 else p_amplitude[i]);
    end for;
  end Pulse;
  
  block SawTooth "Generate saw tooth signals" 
    parameter Real amplitude[:]={1} "Amplitudes of saw tooths";
    parameter SI.Time period[:](final min=Modelica.Constants.small)=  {1} 
      "Times for one period";
    parameter Real offset[:]={0} "Offsets of output signals";
    parameter SI.Time startTime[:]={0} "Output = offset for time < startTime";
    extends Interfaces.MO(final nout=max([size(amplitude, 1); size(period, 1);
          size(offset, 1); size(startTime, 1)]));
  protected 
    parameter Real p_amplitude[nout]=(if size(amplitude, 1) == 1 then ones(nout)
         *amplitude[1] else amplitude);
    parameter SI.Time p_period[nout]=(if size(period, 1) == 1 then ones(nout)*
        period[1] else period);
    parameter Real p_offset[nout]=(if size(offset, 1) == 1 then ones(nout)*
        offset[1] else offset);
    parameter SI.Time p_startTime[nout]=(if size(startTime, 1) == 1 then ones(
        nout)*startTime[1] else startTime);
    SI.Time T0[nout](final start=p_startTime) "Start time of current period";
    annotation(
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
        Line(points=[-80, -70; -60, -70; 0, 40; 0, -70; 60, 41; 60, -70], style(
             color=0)),
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
          string="outPort",
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
        Polygon(points=[-34, -20; -37, -7; -31, -7; -34, -20; -34, -20], style(
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
    for i in 1:nout loop
      when sample(p_startTime[i], p_period[i]) then
        T0[i] = time;
      end when;
      outPort.signal[i] = p_offset[i] + (if time < p_startTime[i] then 0 else (
        p_amplitude[i]/p_period[i])*(time - T0[i]));
    end for;
  end SawTooth;
  
  block Trapezoid "Generate trapezoidal signals of type Real" 
    parameter Real amplitude[:]={1} "Amplitudes of trapezoids";
    parameter SI.Time rising[:](final min=0)=  {0} 
      "Rising durations of trapezoids";
    parameter SI.Time width[:](final min=0)=  {0.5} 
      "Width durations of trapezoids";
    parameter SI.Time falling[:](final min=0)=  {0} 
      "Falling durations of trapezoids";
    parameter SI.Time period[:](final min=Modelica.Constants.small)=  {1} 
      "Time for one period";
    parameter Integer nperiod[:]={-1} 
      "Number of periods (< 0 means infinite number of periods)";
    parameter Real offset[:]={0} "Offsets of output signals";
    parameter SI.Time startTime[:]={0} "Output = offset for time < startTime";
    extends Interfaces.MO(final nout=max([size(amplitude, 1); size(rising, 1);
          size(width, 1); size(falling, 1); size(period, 1); size(nperiod, 1);
          size(offset, 1); size(startTime, 1)]));
  protected 
    parameter Real p_amplitude[nout]=(if size(amplitude, 1) == 1 then ones(nout)
         *amplitude[1] else amplitude);
    parameter SI.Time T_rising[nout]=(if size(rising, 1) == 1 then ones(nout)*
        rising[1] else rising) "End time of rising phase within one period";
    parameter SI.Time T_width[nout]=T_rising + (if size(width, 1) == 1 then 
        ones(nout)*width[1] else width) 
      "End time of width phase within one period";
    parameter SI.Time T_falling[nout]=T_width + (if size(falling, 1) == 1 then 
        ones(nout)*falling[1] else falling) 
      "End time of falling phase within one period";
    parameter SI.Time p_period[nout]=(if size(period, 1) == 1 then ones(nout)*
        period[1] else period) "Duration of one period";
    parameter Real p_offset[nout]=(if size(offset, 1) == 1 then ones(nout)*
        offset[1] else offset);
    parameter SI.Time p_startTime[nout]=(if size(startTime, 1) == 1 then ones(
        nout)*startTime[1] else startTime);
    SI.Time T0[nout](final start=p_startTime) "Start time of current period";
    Integer counter[nout](start=(if size(nperiod, 1) == 1 then ones(nout)*
          nperiod[1] else nperiod)) "Period counter";
    Integer counter2[nout](start=(if size(nperiod, 1) == 1 then ones(nout)*
          nperiod[1] else nperiod));
    annotation(
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
        Line(points=[-81, -70; -60, -70; -30, 40; 9, 40; 39, -70; 61, -70; 90,
              40], style(color=0))),
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
          string="outPort",
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
        Line(points=[-80, -30; -30, -30; -10, 40; 20, 40; 40, -30; 60, -30; 80,
                40; 100, 40], style(color=0, thickness=2)),
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
    for i in 1:nout loop
      when pre(counter2[i]) <> 0 and sample(p_startTime[i], p_period[i]) then
        T0[i] = time;
        counter2[i] = pre(counter[i]);
        counter[i] = pre(counter[i]) - (if pre(counter[i]) > 0 then 1 else 0);
      end when;
      outPort.signal[i] = p_offset[i] + (if (time < p_startTime[i] or counter2[
        i] == 0 or time >= T0[i] + T_falling[i]) then 0 else if (time < T0[i]
         + T_rising[i]) then (time - T0[i])*p_amplitude[i]/T_rising[i] else if 
        (time < T0[i] + T_width[i]) then p_amplitude[i] else (T0[i] + T_falling
        [i] - time)*p_amplitude[i]/(T_falling[i] - T_width[i]));
    end for;
  end Trapezoid;
  
  block KinematicPTP 
    "Move as fast as possible along a distance within given kinematic constraints"
    
    
    parameter Real deltaq[:]={1} "Distance to move";
    parameter Real qd_max[:](final min=Modelica.Constants.small)=  {1} 
      "Maximum velocities der(q)";
    parameter Real qdd_max[:](final min=Modelica.Constants.small)=  {1} 
      "Maximum accelerations der(qd)";
    parameter SI.Time startTime=0 "Time instant at which movement starts";
    
    extends Interfaces.MO(final nout=max([size(deltaq, 1); size(qd_max, 1);
          size(qdd_max, 1)]));
    
  protected 
    parameter Real p_deltaq[nout]=(if size(deltaq, 1) == 1 then ones(nout)*
        deltaq[1] else deltaq);
    parameter Real p_qd_max[nout]=(if size(qd_max, 1) == 1 then ones(nout)*
        qd_max[1] else qd_max);
    parameter Real p_qdd_max[nout]=(if size(qdd_max, 1) == 1 then ones(nout)*
        qdd_max[1] else qdd_max);
    Real sd_max;
    Real sdd_max;
    Real sdd;
    Real aux1[nout];
    Real aux2[nout];
    SI.Time Ta1;
    SI.Time Ta2;
    SI.Time Tv;
    SI.Time Te;
    Boolean noWphase;
    annotation(
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
      Documentation(info="<html>
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
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Vectorized and moved from Rotational to Blocks.Sources.</li>

<li><i>June 29, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
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
    sdd = if time < startTime then 0 else ((if noWphase then (if time < Ta1 +
      startTime then sdd_max else (if time < Te + startTime then -sdd_max else 
      0)) else (if time < Ta2 + startTime then sdd_max else (if time < Tv +
      startTime then 0 else (if time < Te + startTime then -sdd_max else 0)))));
    
    // acceleration
    outPort.signal = p_deltaq*sdd;
  end KinematicPTP;
  
  block TimeTable 
    "Generate a (possibly discontinuous) signal by linear interpolation in a table"
    
    
    parameter Real table[:, 2]=[0, 0; 1, 1; 2, 4] 
      "Table matrix (time = first column)";
    parameter Real offset[1]={0} "Offset of output signal";
    parameter SI.Time startTime[1]={0} "Output = offset for time < startTime";
    extends Interfaces.MO(final nout=1);
  protected 
    Real a "Interpolation coefficients a of actual interval (y=a*x+b)";
    Real b "Interpolation coefficients b of actual interval (y=a*x+b)";
    Integer last(start=1) "Last used lower grid index";
    SI.Time nextEvent(start=0) "Next event instant";
    annotation(
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
        Line(points=[-48, -50; -48, 70; 52, 70; 52, -50; -48, -50; -48, -20; 52,
                -20; 52, 10; -48, 10; -48, 40; 52, 40; 52, 70; 2, 70; 2, -51],
            style(color=0)),
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
        Line(points=[-20, -30; -20, 90; 80, 90; 80, -30; -20, -30; -20, 0; 80,
              0; 80, 30; -20, 30; -20, 60; 80, 60; 80, 90; 30, 90; 30, -31],
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
        Line(points=[-20, -20; -20, -70], style(color=8, pattern=2)),
        Text(
          extent=[-38, -70; 8, -88],
          string="startTime",
          style(color=9)),
        Line(points=[-20, -30; -80, -30], style(color=8, pattern=2)),
        Text(
          extent=[-73, 93; -41, 78],
          string="outPort",
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
          string="outPort",
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
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
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
      (a,b,nextEvent,last) := getInterpolationCoefficients(table, scalar(offset),
           scalar(startTime), time, last, 100*Modelica.Constants.eps);
    end when;
  equation 
    outPort.signal[1] = a*time + b;
  end TimeTable;
  
  block BooleanConstant "Generate constant signals of type Boolean" 
    parameter Boolean k[:]={true} "Constant output values";
    extends Interfaces.BooleanSignalSource(final nout=size(k, 1));
    
    annotation(
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
          string="outPort",
          style(color=9)),
        Text(
          extent=[70, -80; 94, -100],
          string="time",
          style(color=9)),
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
    outPort.signal = k;
  end BooleanConstant;
  
  block BooleanStep "Generate step signals of type Boolean" 
    parameter SI.Time startTime[:]={0} "Time instants of steps";
    parameter Boolean startValue[size(startTime, 1)]=fill(false, size(startTime,
          1)) "Output before startTime";
    extends Interfaces.BooleanSignalSource(final nout=size(startTime, 1));
    annotation( Icon(Line(points=[-80, -70; 0, -70; 0, 50; 80, 50], style(color=
               0)), Text(
          extent=[-150, -150; 150, -110],
          string="startTime=%startTime",
          style(color=0))), Diagram(
        Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
              fillColor=8)),
        Line(points=[-80, 68; -80, -80], style(color=8)),
        Line(points=[-80, -70; 0, -70; 0, 50; 80, 50], style(color=0, thickness=
               2)),
        Line(points=[-90, -70; 82, -70], style(color=8)),
        Polygon(points=[90, -70; 68, -62; 68, -78; 90, -70], style(color=8,
              fillColor=8)),
        Text(
          extent=[70, -80; 94, -100],
          string="time",
          style(color=9)),
        Text(
          extent=[-23, -74; 23, -92],
          string="startTime",
          style(color=9)),
        Polygon(points=[2, 50; -80, 50; 2, 50], style(color=8, pattern=2)),
        Text(
          extent=[-72, 100; -31, 80],
          string="outPort",
          style(color=9)),
        Text(
          extent=[-124, 58; -80, 44],
          string="not startValue",
          style(color=9)),
        Text(
          extent=[-112, -62; -80, -76],
          string="startValue",
          style(color=9))));
  equation 
    for i in 1:nout loop
      outPort.signal[i] = if time >= startTime[i] then not startValue[i] else 
        startValue[i];
    end for;
  end BooleanStep;
  
  block BooleanPulse "Generate pulse signals of type Boolean" 
    parameter Real width[:](
      final min=Modelica.Constants.small,
      final max=100)=  {50} "Widths of pulses in % of period";
    parameter SI.Time period[:](final min=Modelica.Constants.small)=  {1} 
      "Times for one period";
    parameter SI.Time startTime[:]={0} "Iime instants of first pulse";
    extends Interfaces.BooleanSignalSource(final nout=max([size(width, 1); size(
           period, 1); size(startTime, 1)]));
  protected 
    parameter SI.Time p_period[nout]=(if size(period, 1) == 1 then ones(nout)*
        period[1] else period);
    parameter SI.Time Twidth[nout]=diagonal(p_period)*(if size(width, 1) == 1 then 
              ones(nout)*width[1] else width)/100 "width of one pulse";
    parameter SI.Time p_startTime[nout]=(if size(startTime, 1) == 1 then ones(
        nout)*startTime[1] else startTime);
    SI.Time T0[nout](final start=p_startTime) "Start time of current period";
    annotation(
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
          extent=[-150, -150; 150, -110],
          string="period=%period",
          style(color=0)), Line(points=[-80, -70; -40, -70; -40, 44; 0, 44; 0,
              -70; 40, -70; 40, 44; 79, 44], style(color=0))),
      Diagram(
        Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
              fillColor=8)),
        Line(points=[-80, 68; -80, -80], style(color=8)),
        Line(points=[-90, -70; 82, -70], style(color=8)),
        Polygon(points=[90, -70; 68, -62; 68, -78; 90, -70], style(
            color=8,
            fillColor=8,
            fillPattern=1)),
        Text(
          extent=[-60, -72; -14, -90],
          string="startTime",
          style(color=9)),
        Text(
          extent=[-76, 99; -35, 79],
          string="outPort",
          style(color=9)),
        Text(
          extent=[70, -80; 94, -100],
          string="time",
          style(color=9)),
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
          style(color=9)),
        Text(
          extent=[-35, 49; 14, 37],
          string="width",
          style(color=9)),
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
          style(color=9)),
        Text(
          extent=[-101, -56; -80, -71],
          string="false",
          style(color=9))));
  equation 
    for i in 1:nout loop
      when sample(p_startTime[i], p_period[i]) then
        T0[i] = time;
      end when;
      outPort.signal[i] = time >= T0[i] and time < T0[i] + Twidth[i];
    end for;
  end BooleanPulse;
  
  block SampleTrigger "Generate sample trigger signals" 
    parameter SI.Time period[:](final min=Modelica.Constants.small)=  {0.01} 
      "Sample periods";
    parameter SI.Time startTime[:]={0} "Time instants of first sample triggers";
    extends Interfaces.BooleanSignalSource(final nout=max([size(period, 1);
          size(startTime, 1)]));
    
  protected 
    parameter SI.Time p_period[nout]=(if size(period, 1) == 1 then ones(nout)*
        period[1] else period);
    parameter SI.Time p_startTime[nout]=(if size(startTime, 1) == 1 then ones(
        nout)*startTime[1] else startTime);
    annotation(
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
          extent=[-150, -150; 150, -110],
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
        Text(
          extent=[-53, -71; -7, -89],
          string="startTime",
          style(color=9)),
        Text(
          extent=[-76, 99; -35, 79],
          string="outPort",
          style(color=9)),
        Text(
          extent=[70, -80; 94, -100],
          string="time",
          style(color=9)),
        Line(points=[-30, 47; -30, 19], style(color=8, pattern=2)),
        Line(points=[0, 47; 0, 18], style(color=8, pattern=2)),
        Line(points=[-30, 41; 0, 41], style(color=8)),
        Text(
          extent=[-37, 61; 9, 49],
          string="period",
          style(color=9)),
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
          style(color=9)),
        Text(
          extent=[-100, -56; -80, -71],
          string="false",
          style(color=9)),
        Line(points=[0, -70; 0, 19], style(color=0, thickness=2)),
        Line(points=[-30, -70; -30, 19], style(color=0, thickness=2)),
        Line(points=[30, -70; 30, 19], style(color=0, thickness=2)),
        Line(points=[60, -70; 60, 19], style(color=0, thickness=2))));
  equation 
    for i in 1:nout loop
      outPort.signal[i] = sample(p_startTime[i], p_period[i]);
    end for;
  end SampleTrigger;
  
  block IntegerConstant "Generate constant signals of type Integer" 
    parameter Integer k[:]={1} "Constant output values";
    extends Interfaces.IntegerMO(final nout=size(k, 1));
    
    annotation( Icon(
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
    outPort.signal = k;
  end IntegerConstant;
  
  block IntegerStep "Generate step signals of type Integer" 
    parameter Integer height[:]={1} "Heights of steps";
    extends Interfaces.IntegerSignalSource(final nout=max([size(height, 1);
          size(offset, 1); size(startTime, 1)]));
  protected 
    parameter Integer p_height[nout]=(if size(height, 1) == 1 then ones(nout)*
        height[1] else height);
    parameter Integer p_offset[nout]=(if size(offset, 1) == 1 then ones(nout)*
        offset[1] else offset);
    parameter SI.Time p_startTime[nout]=(if size(startTime, 1) == 1 then ones(
        nout)*startTime[1] else startTime);
    annotation( Icon(
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
    for i in 1:nout loop
      outPort.signal[i] = p_offset[i] + (if time < p_startTime[i] then 0 else 
        p_height[i]);
    end for;
  end IntegerStep;
end Sources;
