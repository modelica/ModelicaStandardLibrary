package Digital 
  
  annotation (
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.45,
      y=0.01,
      width=0.44,
      height=0.65,
      library=1,
      autolayout=1),
    Documentation(info="<html>
<p>
This package contains packages for digital electrical components, most of them are
similar to VHDL 1164 standard logic entities:
<ul>
<li>Interfaces: Definition of signals and interfaces</li>
<li>Tables: All truth tables needed</li>
<li>Delay: Transport and inertial delay</li>
<li>Basic: Basic logic without delay</li>
<li>Gates: Basic gates composed by basic components and inertial delay</li>
<li>Tristate: (not yet realized)</li>
<li>FlipFlops: (not yet realized) </li>
<li>Latches: (not yet realized)</li>
<li>TransferGates: (not yet realized)</li>
<li>Multiplexers (not yet realized)</li>
<li>Memory: Ram, Rom, (not yet realized)</li>
<li>Sources: Time-dependend signal sources</li>
<li>Converters</li>
<li>Examples</li>
</ul>
</p>
<p>
The logic values are coded by integer values. The following code table is necessary
for both setting of input and interpreting the output values.
</p>
<p><b>Code Table:</b></p>
<pre>
           Logic value       Integer code        Meaning
              'U'                 1              Uninitialized
              'X'                 2              Forcing Unknown
              '0'                 3              Forcing 0
              '1'                 4              Forcing 1
              'Z'                 5              High Impedance
              'W'                 6              Weak    Unknown
              'L'                 7              Weak    0
              'H'                 8              Weak    1
              '-'                 9              Don't care
</pre>
<p>
The library will be developed in two main steps. The first step contains the basic components and
the gates. In the next step the more complicated devices will be added. This is the first step of
the library.
</p>
<dl>
<dt>
<b>Main Authors:</b>
<dd>
    <a href=\"http://www.eas.iis.fhg.de/~clauss/\">Christoph Clau&szlig;</a>
    &lt;<a href=\"mailto:clauss@eas.iis.fhg.de\">clauss@eas.iis.fhg.de</a>&gt;<br>
    <a href=\"http://www.eas.iis.fhg.de/~schneider/\">Andr&eacute; Schneider</a>
    &lt;<a href=\"mailto:schneider@eas.iis.fhg.de\">schneider@eas.iis.fhg.de</a>&gt; <br>
    <a href=\"http://www.eas.iis.fhg.de/~donath/\">Ulrich; Donath</a>
    &lt;<a href=\"mailto:donath@eas.iis.fhg.de\">donath@eas.iis.fhg.de</a>&gt; technical adviser<br>
    Teresa Schlegel, programmer<br>
    Fraunhofer Institute for Integrated Circuits<br>
    Design Automation Department<br>
    Zeunerstra&szlig;e 38<br>
    D-01069 Dresden<br>
<p>
<dt>
<b>Version:</b>
<dd>
$Id$<br>
<p>
<dt>
<b>Copyright:</b>
<dd>
Copyright &copy; 1998-2004, Modelica Association and Fraunhofer-Gesellschaft.<br>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".</i><br>
<p>
</dl>
</HTML>
"), Diagram,
    uses(Modelica(version="2.1 Beta1")));
  
  package Interfaces 
    
    type LogicValueType = Integer;
    
    record LogicValue "Logic values and their coding" 
      constant Integer min=1;
      constant Integer max=9;
      constant Integer 'U'=1 "Uninitialized";
      constant Integer 'X'=2 "Forcing Unknown";
      constant Integer '0'=3 "Forcing 0";
      constant Integer '1'=4 "Forcing 1";
      constant Integer 'Z'=5 "High Impedance";
      constant Integer 'W'=6 "Weak    Unknown";
      constant Integer 'L'=7 "Weak    0";
      constant Integer 'H'=8 "Weak    1";
      constant Integer '-'=9 "Don't care";
    end LogicValue;
    
    connector DigitalSignal = LogicValueType 
      "Digital port (both input/output possible)";
    
    connector DigitalInput = input DigitalSignal 
      "input DigitalSignal as connector" 
      annotation (defaultComponentName="x",
        Icon(Rectangle(extent=[-100,-100; 100,100], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=78,
            rgbfillColor={127,0,127}))),
        Diagram(                      Text(
          extent=[-140,162; 100,102],
          string="%name",
          style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=78,
            rgbfillColor={127,0,127})),
             Rectangle(extent=[0,-100; 100,100],
                                               style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=78,
            rgbfillColor={127,0,127}))));
    
    connector DigitalOutput = output DigitalSignal 
      "output DigitalSignal as connector" 
      annotation (defaultComponentName="y", Icon(Polygon(points=[-100,100; 100,0; -100,-100; -100,100], style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=7,
          rgbfillColor={255,255,255}))),
                                       Diagram(
              Polygon(points=[-100,50; 0,0; -100,-50; -100,50], style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=7,
          rgbfillColor={255,255,255})), Text(
          extent=[-100,108; 140,48],
          string="%name",
        style(color=78, rgbcolor={127,0,127}))));
    
    partial block SISO "Single input, single output" 
      import D = Modelica.Electrical.Digital.Interfaces;
      D.DigitalInput x 
                   annotation (extent=[-110,-10; -90,10]);
      D.DigitalOutput y 
                    annotation (extent=[90,-10; 110,10]);
      annotation (Diagram(
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2)),
          Line(points=[-90,0; -50,0], style(color=78, rgbcolor={127,0,127})),
          Line(points=[50,0; 90,0], style(color=78, rgbcolor={127,0,127}))),  Icon(
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0, 
              rgbcolor={0,0,0}, 
              thickness=2, 
              fillColor=7, 
              rgbfillColor={255,255,255})),
          Line(points=[-90,0; -50,0], style(color=78, rgbcolor={127,0,127})),
          Line(points=[50,0; 92,0], style(color=78, rgbcolor={127,0,127}))));
    algorithm 
      
    end SISO;
    
    partial block MISO "Multiple input - single output" 
      import D = Modelica.Electrical.Digital.Interfaces;
      
      parameter Integer ninputs(final min=2) = 2 "Number of inputs";
      D.DigitalInput x[ninputs] annotation (extent=[-70,-80; -50,80]);
      D.DigitalOutput y 
                    annotation (extent=[90,-10; 110,10]);
    algorithm 
      annotation (Icon(
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0, 
              rgbcolor={0,0,0}, 
              thickness=2, 
              fillColor=7, 
              rgbfillColor={255,255,255})),
          Line(points=[50,0; 90,0], style(color=78, rgbcolor={127,0,127}))),
          Diagram(
          Rectangle(extent=[-50,100; 50,-100], style(color=0, thickness=2)),
          Line(points=[50,0; 90,0], style(color=78, rgbcolor={127,0,127}))));
    end MISO;
    
    partial block SISO_wide "Single input, single output, wide version" 
      import D = Modelica.Electrical.Digital.Interfaces;
      D.DigitalInput x 
                   annotation (extent=[-110,-10; -90,10]);
      D.DigitalOutput y 
                    annotation (extent=[90,-10; 110,10]);
    algorithm 
      
      annotation (Icon(
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0, 
              rgbcolor={0,0,0}, 
              thickness=2, 
              fillColor=7, 
              rgbfillColor={255,255,255})),
          Ellipse(extent=[50,10; 70,-10],   style(color=0, thickness=2)),
          Line(points=[-90,0; -50,0], style(color=78, rgbcolor={127,0,127})),
          Line(points=[70,0; 90,0], style(color=78, rgbcolor={127,0,127}))),
          Diagram(
          Ellipse(extent=[50,10; 70,-10],   style(color=0, thickness=2)),
          Rectangle(extent=[-50,100; 50,-100], style(color=0, thickness=2)),
          Line(points=[-90,0; -50,0], style(color=78, rgbcolor={127,0,127})),
          Line(points=[70,0; 90,0], style(color=78, rgbcolor={127,0,127}))));
    end SISO_wide;
    
    partial block MISO_wide "Multiple input, sigle output, wide version" 
      import D = Modelica.Electrical.Digital.Interfaces;
      parameter Integer ninputs(final min=2) = 2 "Number of inputs";
      D.DigitalInput x[ninputs] annotation (extent=[-70,-80; -50,80]);
      D.DigitalOutput y 
                    annotation (extent=[90,-10; 110,10]);
    algorithm 
      annotation (
        Icon(
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0, 
              rgbcolor={0,0,0}, 
              thickness=2, 
              fillColor=7, 
              rgbfillColor={255,255,255})),
          Ellipse(extent=[50,10; 70,-10],   style(color=0, thickness=2)),
          Line(points=[70,0; 92,0], style(color=78, rgbcolor={127,0,127}))),
        Diagram(
          Ellipse(extent=[50,10; 70,-10],   style(color=0, thickness=2)),
          Rectangle(extent=[-50,100; 50,-100], style(color=0, thickness=2)),
          Line(points=[-90,0; -50,0], style(color=78, rgbcolor={127,0,127})),
          Line(points=[70,0; 90,0], style(color=78, rgbcolor={127,0,127}))),
        DymolaStoredErrors);
    end MISO_wide;
    
  end Interfaces;
  
  package Tables 
    
    import D = Modelica.Electrical.Digital.Interfaces;
    import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
    
    constant D.LogicValueType andmap[L.max, L.max]=[
        L.'U', L.'U', L.'0', L.'U', L.'U', L.'U', L.'0', L.'U', L.'U';
        L.'U', L.'X', L.'0', L.'X', L.'X', L.'X', L.'0', L.'X', L.'X';
        L.'0', L.'0', L.'0', L.'0', L.'0', L.'0', L.'0', L.'0', L.'0';
        L.'U', L.'X', L.'0', L.'1', L.'X', L.'X', L.'0', L.'1', L.'X';
        L.'U', L.'X', L.'0', L.'X', L.'X', L.'X', L.'0', L.'X', L.'X';
        L.'U', L.'X', L.'0', L.'X', L.'X', L.'X', L.'0', L.'X', L.'X';
        L.'0', L.'0', L.'0', L.'0', L.'0', L.'0', L.'0', L.'0', L.'0';
        L.'U', L.'X', L.'0', L.'1', L.'X', L.'X', L.'0', L.'1', L.'X';
        L.'U', L.'X', L.'0', L.'X', L.'X', L.'X', L.'0', L.'X', L.'X'];
    
    constant D.LogicValueType ormap[L.max, L.max]=[
        L.'U', L.'U', L.'U', L.'1', L.'U', L.'U', L.'U', L.'1', L.'U';
        L.'U', L.'X', L.'X', L.'1', L.'X', L.'X', L.'X', L.'1', L.'X';
        L.'U', L.'X', L.'0', L.'1', L.'X', L.'X', L.'0', L.'1', L.'X';
        L.'1', L.'1', L.'1', L.'1', L.'1', L.'1', L.'1', L.'1', L.'1';
        L.'U', L.'X', L.'X', L.'1', L.'X', L.'X', L.'X', L.'1', L.'X';
        L.'U', L.'X', L.'X', L.'1', L.'X', L.'X', L.'X', L.'1', L.'X';
        L.'U', L.'X', L.'0', L.'1', L.'X', L.'X', L.'0', L.'1', L.'X';
        L.'1', L.'1', L.'1', L.'1', L.'1', L.'1', L.'1', L.'1', L.'1';
        L.'U', L.'X', L.'X', L.'1', L.'X', L.'X', L.'X', L.'1', L.'X'];
    
    constant D.LogicValueType notmap[L.max]={
        L.'U',L.'X',L.'1',L.'0',L.'X',L.'X',L.'1',L.'0',L.'X'};
    
    constant D.LogicValueType xormap[L.max, L.max]=[
        L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X';
        L.'U', L.'X', L.'0', L.'1', L.'X', L.'X', L.'0', L.'1', L.'X';
        L.'U', L.'X', L.'1', L.'0', L.'X', L.'X', L.'1', L.'0', L.'X';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X';
        L.'U', L.'X', L.'0', L.'1', L.'X', L.'X', L.'0', L.'1', L.'X';
        L.'U', L.'X', L.'1', L.'0', L.'X', L.'X', L.'1', L.'0', L.'X';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X'];
    
    constant D.LogicValueType tox01map[L.max]={
        L.'X',L.'X',L.'0',L.'1',L.'X',L.'X',L.'0',L.'1',L.'X'};
    
    constant D.LogicValueType tox01zmap[L.max]={
        L.'X',L.'X',L.'0',L.'1',L.'Z',L.'X',L.'0',L.'1',L.'Z'};
    
    constant D.LogicValueType toux01map[L.max]={
        L.'U',L.'X',L.'0',L.'1',L.'X',L.'X',L.'0',L.'1',L.'X'};
    
    constant Integer delaymap[9, 9]=[
        0, 0, -1, 1, 0, 0, -1, 1, 0;
        0, 0, -1, 1, 0, 0, -1, 1, 0;
        1, 1, 0, 1, 1, 1, 0, 1, 1;
        -1, -1, -1, 0, -1, -1, -1, 0, -1;
        0, 0, -1, 1, 0, 0, -1, 1, 0;
        0, 0, -1, 1, 0, 0, -1, 1, 0;
        1, 1, 0, 1, 1, 1, 0, 1, 1;
        -1, -1, -1, 0, -1, -1, -1, 0, -1;
        0, 0, -1, 1, 0, 0, -1, 1, 0];
  end Tables;
  
  package Delay "Delay blocks" 
    
    partial block DelayParams "Definition of delay parameters" 
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      parameter Modelica.SIunits.Time tLH=0 "rise inertial delay";
      parameter Modelica.SIunits.Time tHL=0 "fall inertial delay";
      parameter Digital.Interfaces.LogicValueType inity=L.'U' 
        "initial value of output";
    algorithm 
    end DelayParams;
    
    model TransportDelay "Transport delay with initial parameter" 
      import D = Modelica.Electrical.Digital.Interfaces;
      extends D.SISO;
      parameter Modelica.SIunits.Time Tdel=0 "delay time";
      parameter D.LogicValueType initout=D.LogicValue.'U' 
        "initial value of output";
      D.LogicValueType x_delayed;
    algorithm 
      x_delayed := integer(delay(x, Tdel));
      y := if Tdel > 0 then 
                          if time >= Tdel then x_delayed else 
                               initout else 
                            x;
      
      annotation (Documentation(info="<HTML>
<P>
Provide the input as output exactly delayed by <i>Tdel</i>.
If time less than <i>Tdel</i> the initial value <i>initout</i> holds.
</P>

</HTML>
", revisions="<HTML>
<ul>
<li><i>   </i>
       by ...<br>
       </li>
<li><i>August 11, 2003</i>
       by Christoph Clauss<br>
       realized.</li>
</ul>
</HTML>"),
    Icon( Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=79,
              rgbfillColor={170,85,255})),
          Text(
            extent=[-50,0; 50,60],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string="Transport"),
          Text(
            extent=[-40,-80; 40,-20],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string="delay")));
    equation 
      
    end TransportDelay;
    
    block InertialDelay "Inertial delay with initial parameter" 
      
      import D = Modelica.Electrical.Digital.Interfaces;
      parameter Modelica.SIunits.Time Tdel "minimum time to hold value";
      parameter D.LogicValueType inity "initial value of output";
      extends D.SISO;
    protected 
      D.LogicValueType y_auxiliary(start=inity, fixed=true);
      D.LogicValueType x_old(start=inity, fixed=true);
      discrete Modelica.SIunits.Time Tnext(start=Tdel, fixed=true);
    algorithm 
      
      when Tdel > 0 and change(x) then
        x_old := x;
        Tnext := time + Tdel;
      elsewhen time >= Tnext then
        y_auxiliary := x;
      end when;
      y := if Tdel > 0 then y_auxiliary else x;
      
      annotation (
        Documentation(info="<HTML>
<P>
Provides the input as output delayed by <i>Tdel</i> if the input holds its value for a longer time than <i>Tdel</i>.
If time is less than <i>Tdel</i> the initial value <i>initout</i> holds.
</P>
</HTML>
", revisions="<HTML>
<ul>
<li><i>   </i>
       by ...<br>
       </li>
<li><i>August 12, 2003   </i>
       by Christoph Clauss<br>
       reviced</li>
<li><i>March 19, 2003</i>
       by Martin Otter<br>
       realized.</li>
</ul>
</HTML>"),
        Diagram,
        Icon(
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=79,
              rgbfillColor={170,85,255})),
          Text(
            extent=[-50,20; 50,80],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string="Inertial"),
          Text(
            extent=[-40,-80; 40,-20],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string="delay")));
    equation 
      
    end InertialDelay;
    
    model InertialDelaySensitive 
      "Provide the input as output if it holds its value for a specific amount of time" 
      
      import D = Modelica.Electrical.Digital.Interfaces;
      parameter Modelica.SIunits.Time tLH=0 "rise inertial delay";
      parameter Modelica.SIunits.Time tHL=0 "fall inertial delay";
      parameter D.LogicValueType inity=D.LogicValue.'U' 
        "initial value of output";
      extends D.SISO;
    protected 
      D.LogicValueType delaymap[:, :]=Digital.Tables.delaymap 
        "specification of delay according to signal change";
      Modelica.SIunits.Time Tdel;
      // actual dealay time
      D.LogicValueType y_auxiliary(start=inity, fixed=true);
      D.LogicValueType x_old(start=inity, fixed=true);
      Integer lh;
      discrete Modelica.SIunits.Time Tnext;
    algorithm 
      when initial() then
        lh := delaymap[inity, x];
        Tnext := if (lh > 0) then tLH else (if (lh < 0) then tHL else 0);
      end when;
      when (tLH > 0 or tHL > 0) and change(x) then
        x_old := if pre(x) == 0 then inity else pre(x);
        lh := delaymap[x_old, x];
        Tdel := if (lh > 0) then tLH else (if (lh < 0) then tHL else 0);
        Tnext := time + Tdel;
        if (lh == 0 or abs(Tdel) < Modelica.Constants.SMALL) then
          y_auxiliary := x;
        end if;
        
      elsewhen time >= Tnext then
        y_auxiliary := x;
      end when;
      y := if ((tLH > 0 or tHL > 0)) then y_auxiliary else x;
      
      annotation (
        Documentation(info="<HTML>
<P>
Provides the input as output delayed by <i>Tdel</i> if the input holds its value for a longer time than <i>Tdel</i>.
If the time is less than <i>Tdel</i> the initial value <i>initout</i> holds.<br>
The delay <i>Tdel</i> depends on the values of the signal change. To calculate <i>Tdel</i>, the delaymap specified in
Digital.Tables is used. If the corresponding value is 1, then <i>tLH</i> is used, if it is -1, then <i>tHL</i>
is used, if it is zero, the input is not delayed.
</P>

</HTML>
", revisions="<HTML>

<ul>
<li><i>September 15, 2004  </i> color changed, names changed
       by Christoph Clauss<br>
       </li>
<li><i>May 12, 2004  </i> test <i>if Tdel=0</i> replaced
       by Christoph Clauss<br>
       </li>
<li><i>February 5, 2004 </i> handling of <i>tHL=0</i> or <i>tLH=0</i> revised   
       by Christoph Clauss<br>
       </li>
<li><i>October 12, 2003   </i>
       by Christoph Clauss<br>
       realized</li>
</HTML>"),
        Diagram,
        Icon(
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=79,
              rgbfillColor={170,85,255})),
          Text(
            extent=[-48,40; 50,100],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string="Inertial"),
          Text(
            extent=[-40,-20; 40,40],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string="delay"),
          Text(
            extent=[-50,-100; 50,-40],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string="sensitive")));
    equation 
      
    end InertialDelaySensitive;
  end Delay;
  
  package Basic "Basic logic without delay" 
    
    model Not "Not Logic" 
      import D = Modelica.Electrical.Digital.Interfaces;
      extends D.SISO_wide;
    protected 
      D.LogicValueType auxiliary(start=D.LogicValue.'0');
    equation 
      
      auxiliary = Modelica.Electrical.Digital.Tables.notmap[x];
      
      y = pre(auxiliary);
      annotation (
        Documentation(info="<HTML>
<P>
Not with 1 input value, without delay.
</P>
</HTML>
", revisions="<HTML>
<ul>
<li><i>   </i>
       by ...<br>
       </li>
<li><i>August 14, 2003</i>
       by Teresa Schlegel<br>
       realized.</li>
</ul>
</HTML>"),
        Icon(
          Text(
            extent=[-40,40; 40,80],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string="1"),
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255}))),
        Diagram);
      
    end Not;
    
    model And "And Logic with multiple input and one output" 
      import D = Modelica.Electrical.Digital.Interfaces;
      import DM = Modelica.Electrical.Digital.Tables;
      extends D.MISO;
    protected 
      D.LogicValueType auxiliary[ninputs](each start=D.LogicValue.'U');
    equation 
      auxiliary[1] = x[1];
      for i in 1:ninputs - 1 loop
        auxiliary[i + 1] = DM.andmap[auxiliary[i], x[i + 1]];
      end for;
      y = pre(auxiliary[ninputs]);
      
      annotation (
        Documentation(info="<HTML>
<P>
And with n input values, without delay.
</P>

</HTML>
", revisions="<HTML>

<ul>
<li><i>September 15, 2004</i> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><i>October 22, 2003</i>
       by Liane Jacobi<br>
       realized.</li>
</ul>
</HTML>"),
        Icon(
          Text(
            extent=[-40,40; 40,80],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string="&"),
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255}))),
        Diagram);
      
    end And;
    
    model Nand "Nand Logic with multiple input and one output" 
      import D = Modelica.Electrical.Digital.Interfaces;
      import DM = Modelica.Electrical.Digital.Tables;
      extends D.MISO_wide;
    protected 
      D.LogicValueType auxiliary[ninputs](each start=D.LogicValue.'U');
    equation 
      auxiliary[1] = x[1];
      for i in 1:ninputs - 1 loop
        auxiliary[i + 1] = DM.andmap[auxiliary[i], x[i + 1]];
      end for;
      y = pre(DM.notmap[auxiliary[ninputs]]);
      
      annotation (
        Documentation(info="<HTML>
<P>
Nand with n input values, without delay.
</P>

</HTML>
", revisions="<HTML>

<ul>
<li><i>September 15, 2004</i> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><i>October 22, 2003</i>
       by Liane Jacobi<br>
       realized.</li>
</ul>
</HTML>"),
        Icon(
          Text(
            extent=[-40,40; 40,80],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string="&"),
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255}))),
        Diagram);
      
    end Nand;
    
    model Or "Or Logic with multiple input and one output" 
      import D = Modelica.Electrical.Digital.Interfaces;
      import DM = Modelica.Electrical.Digital.Tables;
      extends D.MISO;
    protected 
      D.LogicValueType auxiliary[ninputs](each start=D.LogicValue.'U');
    equation 
      auxiliary[1] = x[1];
      for i in 1:ninputs - 1 loop
        auxiliary[i + 1] = DM.ormap[auxiliary[i], x[i + 1]];
      end for;
      y = pre(auxiliary[ninputs]);
      
      annotation (
        Documentation(info="<HTML>
<P>
Or with n input values, without delay.
</P>

</HTML>
", revisions="<HTML>

<ul>
<li><i>September 15, 2004</i> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><i>October 22, 2003</i>
       by Liane Jacobi<br>
       realized.</li>
</ul>
</HTML>"),
        Icon(
          Text(
            extent=[-40,40; 40,80],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string=">=1"),
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255}))),
        Diagram);
      
    end Or;
    
    model Nor "Nor Logic with multiple input and one output" 
      import D = Modelica.Electrical.Digital.Interfaces;
      import DM = Modelica.Electrical.Digital.Tables;
      extends D.MISO_wide;
    protected 
      D.LogicValueType auxiliary[ninputs](each start=D.LogicValue.'U');
    equation 
      auxiliary[1] = x[1];
      for i in 1:ninputs - 1 loop
        auxiliary[i + 1] = DM.ormap[auxiliary[i], x[i + 1]];
      end for;
      y = pre(DM.notmap[auxiliary[ninputs]]);
      
      annotation (
        Documentation(info="<HTML>
<P>
Nor with n input values, without delay.
</P>

</HTML>
", revisions="<HTML>

<ul>
<li><i>September 15, 2004</i> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><i>October 22, 2003</i>
       by Liane Jacobi<br>
       realized.</li>
</ul>
</HTML>"),
        Icon(
          Text(
            extent=[-40,40; 40,80],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string=">=1"),
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255}))),
        Diagram);
      
    end Nor;
    
    model Xor "Xor Logic with multiple input and one output" 
      import D = Modelica.Electrical.Digital.Interfaces;
      import DM = Modelica.Electrical.Digital.Tables;
      extends D.MISO;
    protected 
      D.LogicValueType auxiliary[ninputs](each start=D.LogicValue.'U');
    equation 
      auxiliary[1] = x[1];
      for i in 1:ninputs - 1 loop
        auxiliary[i + 1] = DM.xormap[auxiliary[i], x[i + 1]];
      end for;
      y = pre(auxiliary[ninputs]);
      
      annotation (
        Documentation(info="<HTML>
<P>
Xor with n input values, without delay.
</P>

</HTML>
", revisions="<HTML>

<ul>
<li><i>September 15, 2004</i> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><i>October 22, 2003</i>
       by Liane Jacobi<br>
       realized.</li>
</ul>
</HTML>"),
        Icon(
          Text(
            extent=[-40,40; 40,80],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string="=1"),
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255}))),
        Diagram);
      
    end Xor;
    
    model Xnor "Xnor Logic with multiple input and one output" 
      import D = Modelica.Electrical.Digital.Interfaces;
      import DM = Modelica.Electrical.Digital.Tables;
      extends D.MISO_wide;
    protected 
      D.LogicValueType auxiliary[ninputs](each start=D.LogicValue.'U');
    equation 
      auxiliary[1] = x[1];
      for i in 1:ninputs - 1 loop
        auxiliary[i + 1] = DM.xormap[auxiliary[i], x[i + 1]];
      end for;
      y = pre(DM.notmap[auxiliary[ninputs]]);
      
      annotation (
        Documentation(info="<HTML>
<P>
XNor with n input values, without delay.
</P>

</HTML>
", revisions="<HTML>

<ul>
<li><i>September 15, 2004</i> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><i>October 22, 2003</i>
       by Liane Jacobi<br>
       realized.</li>
</ul>
</HTML>"),
        Icon(
          Text(
            extent=[-40,40; 40,80],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string="="),
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255}))),
        Diagram);
      
    end Xnor;
  end Basic;
  
  package Gates "Logic gates including delay" 
    
    model InvGate 
      import D = Modelica.Electrical.Digital.Interfaces;
      extends Digital.Delay.DelayParams;
      extends D.SISO;
      Digital.Basic.Not Not1 annotation (extent=[-40, -20; 0, 20]);
      Delay.InertialDelaySensitive InertialDelaySensitive1(tLH=tLH, tHL=tHL) 
        annotation (extent=[0, -20; 40, 20]);
    equation 
      
      annotation (
        Documentation(info="<HTML>
<P>
InvGate with 1 input value, composed by Not and sensitive intertial delay.
</P>

</HTML>
", revisions="<HTML>
<ul>
<li><i>   </i>
       by ...<br>
       </li>
<li><i>August 14, 2003</i>
       by Teresa Schlegel<br>
       realized.</li>
</ul>
</HTML>"),
        Diagram,
        Icon(
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255})),
          Text(
            extent=[-40,80; 40,40],
            style(
              color=0,
              thickness=2,
              fillColor=47,
              fillPattern=1),
            string="1"),
          Text(
            extent=[-20,-60; 20,-100],
            string="Gate",
            style(color=0))));
      connect(InertialDelaySensitive1.y, y) annotation (points=[40,0; 100,0],
          style(color=78, rgbcolor={127,0,127}));
      
      connect(Not1.x, x) annotation (points=[-40,0; -100,0], style(color=78,
            rgbcolor={127,0,127}));
      connect(Not1.y, InertialDelaySensitive1.x) 
        annotation (points=[0,0; 0,0],  style(color=78, rgbcolor={127,0,127}));
    end InvGate;
    
    model AndGate "AndGate with multiple input" 
      import D = Modelica.Electrical.Digital.Interfaces;
      extends D.MISO;
      extends Digital.Delay.DelayParams;
      Basic.And And(ninputs=ninputs) 
                                  annotation (extent=[-40, -20; 0, 20]);
      Delay.InertialDelaySensitive InertialDelaySensitive1(
        tLH=tLH,
        tHL=tHL,
        inity=inity)     annotation (extent=[0, -20; 40, 20]);
      annotation (
        Documentation(info="<HTML>
<P>
AndGate with n input values, composed by And and sensitive intertial delay.
</P>

</HTML>
", revisions="<HTML>

<ul>
<li><i>September 15, 2004</i> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><i>October 22, 2003</i>
       by Liane Jacobi<br>
       realized.</li>
</ul>
</HTML>"),
        Icon(
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255})),
          Text(
            extent=[-40,80; 40,40],
            style(color=0, thickness=2),
            string="&"),
          Text(
            extent=[-20,-60; 20,-100],
            style(color=0, thickness=2),
            string="Gate")),
        Diagram);
    equation 
      
      connect(x, And.x) 
        annotation (points=[-100,0; -40,0],  style(color=2));
      connect(y, InertialDelaySensitive1.y) 
        annotation (points=[100,0; 30,0],  style(color=2));
      connect(And.y, InertialDelaySensitive1.x) 
        annotation (points=[0,0; 10,0],     style(color=2));
    end AndGate;
    
    model NandGate "NandGate with multiple input" 
      import D = Modelica.Electrical.Digital.Interfaces;
      
      extends Digital.Delay.DelayParams;
      extends D.MISO_wide;
      annotation (extent=[0, -20; 40, 20], Diagram,
        Icon(
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255})),
          Text(
            extent=[-40,40; 40,80],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string="&"),
          Text(
            extent=[-20,-60; 20,-100],
            style(color=0, thickness=2),
            string="Gate")),
        Documentation(revisions="<HTML>

<ul>
<li><i>September 15, 2004</i> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><i>October 22, 2003</i>
       by Liane Jacobi<br>
       realized.</li>
</ul>
</HTML>", info="<HTML>
<P>
NandGate with n input values, composed by Nand and sensitive intertial delay.
</P>

</HTML>"));
      annotation (
        Documentation(info="<HTML>
<P>
NandGate with n input values, composed by Nand and sensitive intertial delay.
</P>
<p><b>Release Notes:</b></p>
<ul>
<li><i>   </i>
       by ...<br>
       </li>
<li><i>October 22, 2003</i>
       by Liane Jacobi<br>
       realized.</li>
</ul>
</HTML>
"),     Icon(
          Text(
            extent=[-40,80; 40,40],
            style(color=0, thickness=2),
            string="&"),
          Text(
            extent=[-20, -40; 20, -80],
            style(color=0, thickness=2),
            string="Gate"),
          Ellipse(extent=[60, -10; 40, 10], style(color=0, thickness=2))),
        Diagram,
        DymolaStoredErrors);
      
      Basic.Nand Nand(ninputs=ninputs) 
                                    annotation (extent=[-42, -20; 4, 20]);
      Delay.InertialDelaySensitive InertialDelaySensitive1(
        tLH=tLH,
        tHL=tHL,
        inity=inity)     annotation (extent=[8, -20; 52, 20]);
    equation 
      
      connect(x, Nand.x) 
        annotation (points=[-100,0; -42,0],    style(color=2));
      connect(Nand.y, InertialDelaySensitive1.x) 
        annotation (points=[4,0; 19,0],      style(color=2));
      connect(InertialDelaySensitive1.y, y) 
        annotation (points=[41,0; 100,0],  style(color=2));
    end NandGate;
    
    model OrGate "OrGate with multiple input" 
      import D = Modelica.Electrical.Digital.Interfaces;
      
      extends Digital.Delay.DelayParams;
      extends D.MISO;
      Basic.Or Or(ninputs=ninputs) 
                                annotation (extent=[-40, -20; 0, 20]);
      Delay.InertialDelaySensitive InertialDelaySensitive1(
        tLH=tLH,
        tHL=tHL,
        inity=inity)     annotation (extent=[0, -20; 40, 20]);
      annotation (
        Documentation(info="<HTML>
<P>
OrGate with n input values, composed by Or and sensitive intertial delay.
</P>

</HTML>
", revisions="<HTML>

<ul>
<li><i>September 15, 2004</i> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><i>October 22, 2003</i>
       by Liane Jacobi<br>
       realized.</li>
</ul>
</HTML>"),
        Icon(
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255})),
          Text(
            extent=[-40,80; 40,40],
            style(color=0, thickness=2),
            string=">=1"),
          Text(
            extent=[-20,-60; 20,-100],
            style(color=0, thickness=2),
            string="Gate")),
        Diagram);
    equation 
      
      connect(Or.y, InertialDelaySensitive1.x) 
        annotation (points=[0,0; 10,0],     style(color=2));
      connect(x, Or.x) 
        annotation (points=[-100,0; -40,0],  style(color=2));
      connect(y, InertialDelaySensitive1.y) 
        annotation (points=[100,0; 30,0],  style(color=2));
    end OrGate;
    
    model NorGate "NorGate with multiple input" 
      import D = Modelica.Electrical.Digital.Interfaces;
      extends Digital.Delay.DelayParams;
      extends D.MISO_wide;
      Basic.Nor Nor(ninputs=ninputs) 
                                  annotation (extent=[-40, -20; 0, 20]);
      Delay.InertialDelaySensitive InertialDelaySensitive1(
        tLH=tLH,
        tHL=tHL,
        inity=inity)     annotation (extent=[0, -20; 40, 20]);
      annotation (
        Documentation(info="<HTML>
<P>
NorGate with n input values, composed by Nor and sensitive intertial delay.
</P>

</HTML>
", revisions="<HTML>

<ul>
<li><i>September 15, 2004</i> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><i>October 22, 2003</i>
       by Liane Jacobi<br>
       realized.</li>
</ul>
</HTML>"),
        Icon(
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255})),
          Text(
            extent=[-40,80; 40,40],
            style(color=0, thickness=2),
            string=">=1"),
          Text(
            extent=[-20,-60; 20,-100],
            style(color=0, thickness=2),
            string="Gate")),
        Diagram);
    equation 
      
      connect(Nor.y, InertialDelaySensitive1.x) 
        annotation (points=[0,0; 10,0],    style(color=2));
      connect(x, Nor.x) 
        annotation (points=[-100,0; -40,0],  style(color=2));
      connect(y, InertialDelaySensitive1.y) 
        annotation (points=[100,0; 30,0],  style(color=2));
    end NorGate;
    
    model XorGate "XorGate with multiple input" 
      import D = Modelica.Electrical.Digital.Interfaces;
      extends Digital.Delay.DelayParams;
      extends D.MISO;
      Basic.Xor Xor(ninputs=ninputs) 
                                  annotation (extent=[-40, -20; 0, 20]);
      Delay.InertialDelaySensitive InertialDelaySensitive1(
        tLH=tLH,
        tHL=tHL,
        inity=inity)     annotation (extent=[0, -20; 40, 20]);
      annotation (
        Documentation(info="<HTML>
<P>
XorGate with n input values, composed by Xor and sensitive intertial delay.
</P>

</HTML>
", revisions="<HTML>

<ul>
<li><i>September 15, 2004</i> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><i>October 22, 2003</i>
       by Liane Jacobi<br>
       realized.</li>
</ul>
</HTML>"),
        Icon(
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255})),
          Text(
            extent=[-40,80; 40,40],
            style(color=0, thickness=2),
            string="=1"),
          Text(
            extent=[-20,-60; 20,-100],
            style(color=0, thickness=2),
            string="Gate")),
        Diagram);
    equation 
      
      connect(x, Xor.x) 
        annotation (points=[-100,0; -40,0],  style(color=2));
      connect(Xor.y, InertialDelaySensitive1.x) 
        annotation (points=[0,0; 10,0],     style(color=2));
      connect(InertialDelaySensitive1.y, y) 
        annotation (points=[30,0; 100,0],  style(color=2));
    end XorGate;
    
    model XNorGate "XnorGate with multiple input" 
      import D = Modelica.Electrical.Digital.Interfaces;
      extends Digital.Delay.DelayParams;
      extends D.MISO_wide;
      Basic.Xnor Xnor(ninputs=ninputs) 
                                    annotation (extent=[-38, -20; 0, 20]);
      Delay.InertialDelaySensitive InertialDelaySensitive1(
        tLH=tLH,
        tHL=tHL,
        inity=inity)     annotation (extent=[0, -20; 40, 20]);
      annotation (
        Documentation(info="<HTML>
<P>
XNorGate with n input values, composed by XNor and sensitive intertial delay.
</P>

</HTML>
", revisions="<HTML>

<ul>
<li><i>September 15, 2004</i> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><i>October 22, 2003</i>
       by Liane Jacobi<br>
       realized.</li>
</ul>
</HTML>"),
        Icon(
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255})),
          Text(
            extent=[-40,80; 40,40],
            style(color=0, thickness=2),
            string="="),
          Text(
            extent=[-20,-60; 20,-100],
            style(color=0, thickness=2),
            string="Gate")),
        Diagram,
        DymolaStoredErrors);
    equation 
      
      connect(x, Xnor.x) 
        annotation (points=[-100,0; -38,0],    style(color=2));
      connect(InertialDelaySensitive1.y, y) 
        annotation (points=[30,0; 100,0],  style(color=2));
      connect(Xnor.y, InertialDelaySensitive1.x) 
        annotation (points=[0,0; 10,0],      style(color=2));
    end XNorGate;
    
  end Gates;
  
  package Sources 
    
    block Set "Digital Set Source" 
      import D = Modelica.Electrical.Digital.Interfaces;
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      parameter D.LogicValueType setvalue=L.'U' "Logic value to be set";
      D.DigitalOutput y 
                    annotation (extent=[90,-10; 110,10]);
    algorithm 
      assert(setvalue > 0 and setvalue < 10, "Parameter is no logic value");
      y := setvalue;
      annotation (Documentation(info="<HTML>
<P>
Sets a nine valued digital signal, which is specified by the <i>setval</i> parameter.
</P>
<P>
To specify <i>setval</i>, the integer code has to be used.
</P>
<p><b>Code Table:</b></p>
<pre>
           Logic value       Integer code        Meaning
              'U'                 1              Uninitialized
              'X'                 2              Forcing Unknown
              '0'                 3              Forcing 0
              '1'                 4              Forcing 1
              'Z'                 5              High Impedance
              'W'                 6              Weak    Unknown
              'L'                 7              Weak    0
              'H'                 8              Weak    1
              '-'                 9              Don't care
</pre>
<P>
If the logic values are imported by <br><b> import L = Modelica.Electrical.Digital.Interfaces.LogicValue; </b> <br>
they can be used to specify the parameter, e.g. <b>L.'0'</b> for forcing 0.
</P>

</HTML>
", revisions="<HTML>

<ul>
<li><i>   </i>
       by ...<br>
       </li>
<li><i>August 20, 2003</i>
       by Teresa Schlegel<br>
       realized.</li>
</ul>
</HTML>"),
    Icon( Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              thickness=2,
              fillColor=55)),
          Text(
            extent=[-40, 20; 40, 80],
            string="set",
            style(
              color=78,
              rgbcolor={127,0,127},
              thickness=2,
              fillPattern=1)),
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Line(points=[50,0; 90,0], style(color=78, rgbcolor={127,0,127}))));
    equation 
      
    end Set;
    
    block Step "Digital Step Source" 
      import D = Modelica.Electrical.Digital.Interfaces;
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      parameter D.LogicValueType before=L.'0' "Logic value before step";
      parameter D.LogicValueType after=L.'1' "Logic value after step";
      parameter Real stepTime=1 "step time";
      D.DigitalOutput y 
                    annotation (extent=[90,-10; 110,10]);
    algorithm 
      assert(before > 0 and before < 10, "Parameter is no logic value");
      assert(after > 0 and after < 10, "Parameter is no logic value");
      when initial() then
        y := before;
      end when;
      if stepTime <= time then
        y := after;
      else
        y := before;
      end if;
      annotation (
        Documentation(info="<HTML>
<P>
The step source output signal steps from the value <i>before</i> to the value <i>after</i>
at the time <i>stepTime</i>.
</P>
<P>
To specify the logic value parameters, the integer code has to be used.
</P>
<p><b>Code Table:</b></p>
<pre>
           Logic value       Integer code        Meaning
              'U'                 1              Uninitialized
              'X'                 2              Forcing Unknown
              '0'                 3              Forcing 0
              '1'                 4              Forcing 1
              'Z'                 5              High Impedance
              'W'                 6              Weak    Unknown
              'L'                 7              Weak    0
              'H'                 8              Weak    1
              '-'                 9              Don't care
</pre>
<P>
If the logic values are imported by <br><b> import L = Modelica.Electrical.Digital.Interfaces.LogicValue; </b> <br>
they can be used to specify the parameter, e.g. <b>L.'0'</b> for forcing 0.
</P>

</HTML>
", revisions="<HTML>

<ul>
<li><i>   </i>
       by ...<br>
       </li>
<li><i>August 20, 2003</i>
       by Teresa Schlegel<br>
       realized.</li>
</ul>
</HTML>"),
        Icon(
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              thickness=2,
              fillColor=55)),
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Line(points=[-20,-20; -2,-20; -2,20; 18,20], style(
              color=78,
              rgbcolor={127,0,127},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255},
              fillPattern=1)),
          Line(points=[50,0; 90,0], style(color=78, rgbcolor={127,0,127}))),
        Diagram);
    equation 
      
    end Step;
    
    block Table "Digital Tabular Source" 
      import D = Modelica.Electrical.Digital.Interfaces;
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      parameter D.LogicValueType setvalue[:]={1};
      parameter Real settime[size(setvalue, 1)]={1};
      parameter D.LogicValueType inity=L.'U';
      final parameter Integer n=size(setvalue, 1);
      D.DigitalOutput y 
                    annotation (extent=[90,-10; 110,10]);
    algorithm 
      if initial() then
        assert(inity > 0 and inity < 10, "Parameter inity is no logic value");
        assert(size(setvalue, 1) == size(settime, 1), "Table: size mismatch");
        assert(n > 0, "Table:size < 1");
        for i in 1:n loop
          assert(setvalue[i] > 0 and setvalue[i] < 10, "Table: not a logic value");
        end for;
      end if;
      y := inity;
      for i in 1:n loop
        if time >= settime[i] then
          y := setvalue[i];
        end if;
      end for;
      annotation (
        Documentation(info="<HTML>
<P>
The table source output signal steps to the values of the  <i>setval</i> table at the corresponding
timepoints in the <i>settime</i> table. <br>The initial value is specified by <i>initout</i>.
</P>
<P>
To specify the logic value parameters, the integer code has to be used.
</P>
<p><b>Code Table:</b></p>
<pre>
           Logic value       Integer code        Meaning
              'U'                 1              Uninitialized
              'X'                 2              Forcing Unknown
              '0'                 3              Forcing 0
              '1'                 4              Forcing 1
              'Z'                 5              High Impedance
              'W'                 6              Weak    Unknown
              'L'                 7              Weak    0
              'H'                 8              Weak    1
              '-'                 9              Don't care
</pre>
<P>
If the logic values are imported by <br><b> import L = Modelica.Electrical.Digital.Interfaces.LogicValue; </b> <br>
they can be used to specify the parameter, e.g. <b>L.'0'</b> for forcing 0.
</P>
</HTML>
", revisions="<HTML>

<ul>
<li><i>   </i>
       by ...<br>
       </li>
<li><i>August 20, 2003</i>
       by Teresa Schlegel<br>
       realized.</li>
</ul>
</HTML>"),
        Icon(
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              thickness=2,
              fillColor=55)),
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Line(points=[-20,80; -20,-80; 20,-80; 20,80; -20,80], style(
              color=78,
              rgbcolor={127,0,127},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255},
              fillPattern=1)),
          Line(points=[0,80; 0,-80], style(
              color=78,
              rgbcolor={127,0,127},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255},
              fillPattern=1)),
          Line(points=[-20,60; 20,60], style(
              color=78,
              rgbcolor={127,0,127},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255},
              fillPattern=1)),
          Line(points=[-20,40; 20,40], style(
              color=78,
              rgbcolor={127,0,127},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255},
              fillPattern=1)),
          Line(points=[-20,20; 20,20], style(
              color=78,
              rgbcolor={127,0,127},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255},
              fillPattern=1)),
          Line(points=[-20,0; 20,0], style(
              color=78,
              rgbcolor={127,0,127},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255},
              fillPattern=1)),
          Line(points=[-20,-20; 20,-20], style(
              color=78,
              rgbcolor={127,0,127},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255},
              fillPattern=1)),
          Line(points=[-20,-40; 20,-40], style(
              color=78,
              rgbcolor={127,0,127},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255},
              fillPattern=1)),
          Line(points=[-20,-60; 20,-60; 20,-58], style(
              color=78,
              rgbcolor={127,0,127},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255},
              fillPattern=1)),
          Line(points=[50,0; 90,0], style(color=78, rgbcolor={127,0,127}))),
        Diagram);
    equation 
      
    end Table;
    
    model Pulse "Digital Pulse Source" 
      import D = Modelica.Electrical.Digital.Interfaces;
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      parameter Real width(
        final min=Modelica.Constants.SMALL,
        final max=100) = 50 "Widths of pulses in % of periods";
      parameter Modelica.SIunits.Time period(final min=Modelica.Constants.SMALL)=
           1 "Times for one period";
      parameter Modelica.SIunits.Time startTime=0 
        "Output = offset for time < startTime";
      parameter D.LogicValueType pulse=L.'0';
      parameter D.LogicValueType quiet=L.'1';
      Modelica.SIunits.Time T0(final start=startTime) 
        "Start time of current period";
      parameter Integer nperiod=-1 
        "Number of periods (< 0 means infinite number of periods)";
      Integer np(start=0);
      D.DigitalOutput y 
                    annotation (extent=[90,-10; 110,10]);
    algorithm 
      if nperiod == 0 then
        y := quiet;
      elseif (nperiod >= np) or (nperiod < 0) then
        when sample(startTime, period) then
          T0 := time;
          if (nperiod > 0) then
            np := np + 1;
          end if;
        end when;
        y := if (time < startTime or time >= T0 + ((width*period)/
          100)) or not (nperiod >= np or nperiod < 0) then quiet else pulse;
      else
        y := quiet;
      end if;
      annotation (Documentation(info="<HTML>
<P>
The pulse source forms pulses between the  <i>quiet</i> value and the <i>pulse</i> value. 
The pulse length <i>width</i> is specified in percent of the period length <i>period</i>.
The number of periods is specified by <i>nperiod</i>. If <i>nperiod</i> is less than zero,
the number of periods is unlimited.
</P>
<P>
To specify the logic value parameters, the integer code has to be used.
</P>
<p><b>Code Table:</b></p>
<pre>
           Logic value       Integer code        Meaning
              'U'                 1              Uninitialized
              'X'                 2              Forcing Unknown
              '0'                 3              Forcing 0
              '1'                 4              Forcing 1
              'Z'                 5              High Impedance
              'W'                 6              Weak    Unknown
              'L'                 7              Weak    0
              'H'                 8              Weak    1
              '-'                 9              Don't care
</pre>
<P>
If the logic values are imported by <br><b> import L = Modelica.Electrical.Digital.Interfaces.LogicValue; </b> <br>
they can be used to specify the parameter, e.g. <b>L.'0'</b> for forcing 0.
</P>

</HTML>
", revisions="<HTML>

<ul>
<li><i>   </i>
       by ...<br>
       </li>
<li><i>September 2, 2003</i>
       by Christoph Clauss<br>
       realized.</li>
</ul>
</HTML>"),
    Icon( Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              thickness=2,
              fillColor=55)),
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Line(points=[-26,-10; -18,-10; -18,10; -8,10], style(
              color=78,
              rgbcolor={127,0,127},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255},
              fillPattern=1)),
          Line(points=[-8,10; -8,-10; 2,-10; 2,10; 12,10; 12,-10; 16,-10; 18,
                -10], style(
              color=78,
              rgbcolor={127,0,127},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255},
              fillPattern=1)),
          Line(points=[50,0; 90,0], style(color=78, rgbcolor={127,0,127}))));
    end Pulse;
  end Sources;
  
  package Converters 
    block LogicToXO1 "Conversion to XO1" 
      import D = Modelica.Electrical.Digital.Interfaces;
      D.DigitalInput x[n] 
                        annotation (extent=[-60, -10; -40, 10]);
      D.DigitalOutput y[n] 
                         annotation (extent=[40, -10; 60, 10]);
      parameter Integer n(final min=1) = 1 "signal width";
    algorithm 
      for i in 1:n loop
        y[i] := Modelica.Electrical.Digital.Tables.tox01map[x[i]];
      end for;
      annotation (
        Documentation(info="<HTML>
<P>
Conversion of a nine valued digital input into a X01 digital output without 
any delay according to IEEE 1164 To_X01 function.
</P>
<p><b>Conversion Table:</b></p>
<pre>
                          input                  output
                          'U' (coded by 1)       'X'  (coded by 2)
                          'X' (coded by 2)       'X'  (coded by 2)
                          '0' (coded by 3)       '0'  (coded by 3)
                          '1' (coded by 4)       '1'  (coded by 4)
                          'Z' (coded by 5)       'X'  (coded by 2)
                          'W' (coded by 6)       'X'  (coded by 2)
                          'L' (coded by 7)       '0'  (coded by 3)
                          'H' (coded by 8)       '1'  (coded by 4)
                          '-' (coded by 9)       'X'  (coded by 2)
</pre>
<P>
If the signal width is greater than 1 this conversion is done for each signal.
</P>
</HTML>
", revisions="<HTML>

<ul>
<li><i>September 15, 2004   </i>
       by Christoph Clauss name converted from cvt_to_x01 into LogicToX01<br>
       </li>
<li><i>November 5, 2003</i>
       by Christoph Clauss<br>
       realized.</li>
</ul>
</HTML>
"),     Icon(
          Rectangle(extent=[-40, 40; 40, -40], style(color=0, thickness=2)),
          Text(
            extent=[20, 40; -20, 0],
            style(color=0, thickness=2),
            string="To"),
          Text(
            extent=[-40, 0; 40, -40],
            style(color=0, thickness=2),
            string="x01"),
          Text(
            extent=[152,-100; -148,-40],
            string="%name",
            style(color=3, rgbcolor={0,0,255}))),
        Diagram);
    equation 
      
    end LogicToXO1;
    
    block LogicToXO1Z "Conversion to XO1Z" 
      import D = Modelica.Electrical.Digital.Interfaces;
      D.DigitalInput x[n] 
                        annotation (extent=[-60, -10; -40, 10]);
      D.DigitalOutput y[n] 
                         annotation (extent=[40, -10; 60, 10]);
      parameter Integer n(final min=1) = 1 "signal width";
    algorithm 
      for i in 1:n loop
        y[i] := Modelica.Electrical.Digital.Tables.tox01zmap[x[i]];
      end for;
      annotation (
        Documentation(info="<HTML>
<P>
Conversion of a nine valued digital input into a X01Z digital output without 
any delay according to IEEE 1164 To_X01Z function.
</P>
<p><b>Conversion Table:</b></p>
<pre>
                          input                  output
                          'U' (coded by 1)       'X'  (coded by 2)
                          'X' (coded by 2)       'X'  (coded by 2)
                          '0' (coded by 3)       '0'  (coded by 3)
                          '1' (coded by 4)       '1'  (coded by 4)
                          'Z' (coded by 5)       'Z'  (coded by 5)
                          'W' (coded by 6)       'X'  (coded by 2)
                          'L' (coded by 7)       '0'  (coded by 3)
                          'H' (coded by 8)       '1'  (coded by 4)
                          '-' (coded by 9)       'X'  (coded by 2)
</pre>
<P>
If the signal width is greater than 1 this conversion is done for each signal.
</P>

</HTML>
", revisions="<HTML>

<ul>
<li><i>September 15, 2004   </i>
       by Christoph Clauss name converted from cvt_to_x01z into LogicToX01Z<br>
       </li>
<li><i>November 5, 2003</i>
       by Christoph Clauss<br>
       realized.</li>
</ul>
</HTML>"),
        Icon(
          Text(
            extent=[40, 40; -40, 0],
            style(color=0, thickness=2),
            string="To"),
          Text(
            extent=[-40, 0; 40, -40],
            style(color=0, thickness=2),
            string="x01z"),
          Rectangle(extent=[-40, 40; 40, -40], style(color=0, thickness=2)),
          Text(
            extent=[152,-100; -148,-40],
            string="%name",
            style(color=3, rgbcolor={0,0,255}))),
        Diagram);
    equation 
      
    end LogicToXO1Z;
    
    block LogicToUX01 "Conversion to UXO1" 
      import D = Modelica.Electrical.Digital.Interfaces;
      D.DigitalInput x[n] 
                        annotation (extent=[-60, -10; -40, 10]);
      D.DigitalOutput y[n] 
                         annotation (extent=[40, -10; 60, 10]);
      parameter Integer n(final min=1) = 1 "signal width";
    algorithm 
      for i in 1:n loop
        y[i] := Modelica.Electrical.Digital.Tables.toux01map[x[i]];
      end for;
      annotation (
        Documentation(info="<HTML>
<P>
Conversion of a nine valued digital input into a UX01 digital output without 
any delay according to IEEE 1164 To_UX01 function.
</P>
<p><b>Conversion Table:</b></p>
<pre>
                          input                  output
                          'U' (coded by 1)       'U'  (coded by 1)
                          'X' (coded by 2)       'X'  (coded by 2)
                          '0' (coded by 3)       '0'  (coded by 3)
                          '1' (coded by 4)       '1'  (coded by 4)
                          'Z' (coded by 5)       'X'  (coded by 2)
                          'W' (coded by 6)       'X'  (coded by 2)
                          'L' (coded by 7)       '0'  (coded by 3)
                          'H' (coded by 8)       '1'  (coded by 4)
                          '-' (coded by 9)       'X'  (coded by 2)
</pre>
<P>
If the signal width is greater than 1 this conversion is done for each signal.
</P>
</HTML>
", revisions="<HTML>

<ul>
<li><i>September 15, 2004   </i>
       by Christoph Clauss name converted from cvt_to_ux01 into LogicToUX01<br>
       </li>
<li><i>November 5, 2003</i>
       by Christoph Clauss<br>
       realized.</li>
</ul>
</HTML>"),
        Icon(
          Text(
            extent=[-40, 0; 40, -40],
            style(color=0, thickness=2),
            string="ux01"),
          Rectangle(extent=[-40, 40; 40, -40], style(color=0, thickness=2)),
          Text(
            extent=[40, 40; -40, 0],
            style(color=0, thickness=2),
            string="To"),
          Text(
            extent=[152,-100; -148,-40],
            string="%name",
            style(color=3, rgbcolor={0,0,255}))),
        Diagram);
    equation 
      
    end LogicToUX01;
    
    block BooleanToDigital "Boolean to Digital converter" 
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      Modelica.Blocks.Interfaces.BooleanInput u[n] 
        annotation (extent=[-60, -10; -40, 10]);
      annotation (
        Documentation(info="<HTML>
<P>
Conversion of a Boolean input into a digital output without any delay according to:
</P>
<pre>
                          input      output
                          true       '1'  (coded by 4)
                          false      '0'  (coded by 3)
</pre>
<P>
If the signal width is greater than 1 this conversion is done for each signal.
</P>

</HTML>
", revisions="<HTML>
<ul>
<li><i>September 15, 2004   </i>
       by Christoph Clauss colors changed<br>
       </li>
<li><i>November 4, 2003</i>
       by Christoph Clauss<br>
       realized.</li>
</ul>
</HTML>"),
        extent=[-60, -10; -40, 10],
        DymolaStoredErrors,
        Icon(Polygon(points=[-40,-40; 40,40; 40,-40; -40,-40],   style(
              color=78,
              rgbcolor={127,0,127},
              fillColor=78,
              rgbfillColor={127,0,127},
              fillPattern=1)), Polygon(points=[-40,40; 40,40; -40,-40; -40,40],
                      style(
              color=5,
              fillColor=5,
              fillPattern=1)),
          Text(
            extent=[152,-100; -148,-40],
            string="%name",
            style(color=3, rgbcolor={0,0,255}))),
        Diagram);
      
      Digital.Interfaces.DigitalOutput DigitalOutput[n] 
        annotation (extent=[40, -10; 60, 10]);
      annotation (extent=[40, -10; 60, 10]);
      annotation (Diagram);
      parameter Integer n(final min=1) = 1 "signal width";
    algorithm 
      for i in 1:n loop
        DigitalOutput[i] := if u[i] then L.'1' else 
          L.'0';
      end for;
    end BooleanToDigital;
    
    block DigitalToBoolean "Digital to Boolean Converter" 
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      Digital.Interfaces.DigitalInput DigitalInput[n] 
        annotation (extent=[-60, -10; -40, 10]);
      Modelica.Blocks.Interfaces.BooleanOutput y[n] 
        annotation (extent=[40, -10; 60, 10]);
      annotation (Documentation(info="<HTML>
<P>
Conversion of a digital input into a Boolean output without any delay according to:
</P>
<pre>
                          input                 output
                          'U'  (coded by 1)     false     
                          'X'  (coded by 2)     false      
                          '0'  (coded by 3)     false     
                          '1'  (coded by 4)     true      
                          'Z'  (coded by 5)     false     
                          'W'  (coded by 6)     false      
                          'L'  (coded by 7)     false 
                          'H'  (coded by 8)     true      
                          '-'  (coded by 9)     false       
</pre>
<P>
If the signal width is greater than 1 this conversion is done for each signal.
</P>

</HTML>
", revisions="<HTML>
<ul>
<li><i>September 15, 2004   </i>
       by Christoph Clauss colors changed<br>
       </li>
<li><i>November 4, 2003</i>
       by Christoph Clauss<br>
       realized.</li>
</ul>
</HTML>"),
    Icon(Polygon(points=[-40,40; 40,40; -40,-40; -40,40],      style(
              color=78,
              rgbcolor={127,0,127},
              thickness=2,
              fillColor=78,
              rgbfillColor={127,0,127})),
                               Polygon(points=[-40,-40; 40,40; 40,-40; 34,-34;
                40,-40; -40,-40],   style(color=5, fillColor=5)),
          Text(
            extent=[152,-100; -148,-40],
            string="%name",
            style(color=3, rgbcolor={0,0,255}))));
      parameter Integer n(final min=1) = 1 "signal width";
    algorithm 
      for i in 1:n loop
        y[i] := if DigitalInput[i] == 4 or 
          DigitalInput[i] == 8 then true else false;
      end for;
    end DigitalToBoolean;
    
    block RealToDigital "Real to Digital converter" 
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      Modelica.Blocks.Interfaces.RealInput u[n] 
        annotation (extent=[-60, -10; -40, 10]);
      annotation (
        Documentation(info="<HTML>
<P>
Conversion of a real input into a digital output without any delay according to:
</P>
<pre>
                                 condition            output 
      first check:               input greater upp    lupp
      second check:              input larger low     llow
                                 else                 lmid
</pre>
<P>
If the signal width is greater than 1 this conversion is done for each signal.
</P>

</HTML>
", revisions="<HTML>
<ul>
<li><i>September 15, 2004   </i>
       by Christoph Clauss colors changed<br>
       </li>
<li><i>November 5, 2003</i>
       by Christoph Clauss<br>
       realized.</li>
</ul>
</HTML>"),
        extent=[-60, -10; -40, 10],
        DymolaStoredErrors,
        Icon(Polygon(points=[-40,-40; 40,40; 40,-40; -40,-40],   style(
              color=78,
              rgbcolor={127,0,127},
              fillColor=78,
              rgbfillColor={127,0,127},
              fillPattern=1)), Polygon(points=[-40,40; 40,40; -40,-40; -40,40],
                      style(fillPattern=1)),
          Text(
            extent=[148,-100; -152,-40],
            string="%name",
            style(color=3, rgbcolor={0,0,255}))));
      
      Digital.Interfaces.DigitalOutput DigitalOutput[n] 
        annotation (extent=[40, -10; 60, 10]);
      annotation (extent=[40, -10; 60, 10]);
      annotation (Diagram);
      parameter Integer n(final min=1) = 1 "signal width";
      parameter Real upper_limit=1 "upper limit";
      parameter Real lower_limit=0 "lower limit";
      parameter Digital.Interfaces.LogicValueType upper_value=L.'1' 
        "output if input > upper_limit";
      parameter Digital.Interfaces.LogicValueType lower_value=L.'0' 
        "output if input < lower_limit";
      parameter Digital.Interfaces.LogicValueType middle_value=L.'X' 
        "output else";
    algorithm 
      for i in 1:n loop
        DigitalOutput[i] := if u[i] > upper_limit then upper_value else 
          if u[i] < lower_limit then lower_value else middle_value;
      end for;
    end RealToDigital;
    
    block DigitalToReal "Digital to Real Converter" 
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      Digital.Interfaces.DigitalInput DigitalInput[n] 
        annotation (extent=[-60, -10; -40, 10]);
      Modelica.Blocks.Interfaces.RealOutput y[n] 
        annotation (extent=[40, -10; 60, 10]);
      annotation (Documentation(info="<HTML>
<P>
Conversion of a digital input into a Real output without any delay according to:
</P>
<pre>
                          input                 output
                          'U'  (coded by 1)     val_U     
                          'X'  (coded by 2)     val_X      
                          '0'  (coded by 3)     val_0     
                          '1'  (coded by 4)     val_1      
                          'Z'  (coded by 5)     val_Z     
                          'W'  (coded by 6)     val_W      
                          'L'  (coded by 7)     val_L 
                          'H'  (coded by 8)     val_H      
                          '-'  (coded by 9)     val_m       
</pre>
<P>
The values val... are given by parameters.</P>
<P>If the signal width is greater than 1 this conversion is done for each signal.
</P>

</HTML>
", revisions="<HTML>
<ul>
<li><i>September 15, 2004   </i>
       by Christoph Clauss colors changed<br>
       </li>
<li><i>November 5, 2003</i>
       by Christoph Clauss<br>
       realized.</li>
</ul>
</HTML>"),
    Icon(Polygon(points=[-40,40; 40,40; -40,-40; -40,40],      style(
              color=78,
              rgbcolor={127,0,127},
              fillColor=78,
              rgbfillColor={127,0,127})),
                               Polygon(points=[-40,-40; 40,-40; 40,40; -40,-40],
                     style(fillPattern=1)),
          Text(
            extent=[152,-100; -148,-40],
            string="%name",
            style(color=3, rgbcolor={0,0,255}))));
      parameter Integer n(final min=1) = 1 "signal width";
      parameter Real value_U=0.5 "value for digital U (uninitialized)";
      parameter Real value_X=0.5 "value for digital X (Forcing Unknown)";
      parameter Real value_0=0 "value for digital 0   (Forcing 0)";
      parameter Real value_1=1 "value for digital 1 (Forcing 1)";
      parameter Real value_Z=0.5 "value for digital Z (High Impedance)";
      parameter Real value_W=0.5 "value for digital W (Weak    Unknown)";
      parameter Real value_L=0 "value for digital L (Weak    0)";
      parameter Real value_H=1 "value for digital H (Weak    1)";
      parameter Real value_m=0.5 "value for digital m (Don´t care)";
    algorithm 
      for i in 1:n loop
       y[i]:= if DigitalInput[i] == L.'U' then value_U else 
                if DigitalInput[i] == L.'X' then value_X else if 
          DigitalInput[i] == L.'0' then value_0 else if DigitalInput[i] == L.'1' then 
               value_1 else if DigitalInput[i] == L.
          'Z' then value_Z else if DigitalInput[i] == L.'W' then value_W else 
                if DigitalInput[i] == L.'L' then value_L else if 
          DigitalInput[i] == L.'H' then value_H else value_m;
      end for;
    end DigitalToReal;
    
  end Converters;
  
  package Examples 
    
    model Halfadder "adding circuit for binary numbers without input carry bit" 
      
      annotation (
        Documentation(info="<HTML>
<P>
It is an adding circuit for binary numbers, which internally realizes the interconnection to 
And and to Xor in the final sum.
<br>
<br>
1 + 0 = 1<br>
0 + 1 = 1<br>
1 + 1 = 10<br>
0 + 0 = 0
<br>
<br>
tab<b>a</b> + tab<b>b</b> = <b>c</b>out
<br>(The carry of this adding is <b>s</b>out.) 
<br>
<br>and
<br> 
<br> 
tab<b>a</b> * tab<b>b</b> = <b>c</b>out
<br>  (It is an interconnection to And.)
<br>
<br>
tab<b>a</b> * tab<b>b</b> + tab<b>a</b> * tab<b>b</b> = tab<b>a</b> Xor tab<b>b</b> = <b>s</b>out
<br>(It is an interconnection to Xor.) 
<br>
<br>     
<pre>tab<b>a</b>     tab<b>b</b>     <b>c</b>out      <b>s</b>out       <b>t</b></pre>
       
 <pre>  1        0        1         0        1</pre>
 <pre>  0        1        1         0        2</pre>
 <pre>  1        1        0         1        3</pre>
 <pre>  0        0        0         0        4</pre>
   
<br>  
<br>
<b>t</b> is the pick-up instant of the next bit(s) in the simulation.  <br>
The simulation stop time should be 5 seconds. 
</P>
</HTML>
"),     Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon,
        Diagram,
        Window(
          x=0.2,
          y=0.06,
          width=0.62,
          height=0.69),
        experiment(StopTime=5),
        experimentSetupOutput);
    /* 
  Digital.Examples.Utilities.halfadder h(Tdel=0.3) 
                        annotation (extent=[-76, -84; 118, 104]);
*/
      Sources.Table taba(
        settime={1,2,3,4},
        setvalue={4,3,4,3},
        inity=3)   annotation (extent=[-80,20; -40,60]);
      Sources.Table tabb(
        setvalue={4,3},
        settime={2,4},
        inity=3)   annotation (extent=[-80,-60; -40,-20]);
      Utilities.halfadder h(Tdel=0.3) 
                            annotation (extent=[20,-30; 60,30]);
    equation 
      
      connect(tabb.y, h.b) annotation (points=[-40,-40; -20,-40; -20,-8.4; 30,
            -8.4], style(
          color=78,
          rgbcolor={127,0,127},
          thickness=2,
          fillColor=78,
          rgbfillColor={127,0,127},
          fillPattern=1));
      connect(taba.y, h.a) annotation (points=[-40,40; -20,40; -20,9; 30,9],
          style(
          color=78,
          rgbcolor={127,0,127},
          thickness=2,
          fillColor=78,
          rgbfillColor={127,0,127},
          fillPattern=1));
    end Halfadder;
    
    model Fulladder "adding circuit for binary numbers with input carry bit" 
      
      annotation (
        Documentation(info="<HTML>
<P>
<br>It is an adding circuit for binary numbers with input carry bit, which consists of two Halfadders.
<br>
<br>
tab<b>a</b>.y, tab<b>b</b>.y and tab<b>c</b>.y are the inputs of the Fulladder.
<br>
<b>c</b>out = <b>Or1</b>.y and <b>h</b>.s are the outputs of the Fulladder.
<br>
<br>
<b>t</b> is the pick-up instant of the next bit(s) in the simulation.   
<pre>   tab<b>a</b>.y   tab<b>b</b>.y   tab<b>c</b>.y   <b>c</b>out = <b>Or1</b>y      <b>h</b>.s       <b>t</b> </pre>
       
<pre>     1        0        0        0               1        1  
<pre>     0        1        0        0               1        2
<pre>     0        0        1        0               1        3
<pre>     1        1        0        1               0        4
<pre>     0        1        1        1               0        5
<pre>     1        0        1        1               0        6
<pre>     1        1        1        1               1        7
<pre>     0        0        0        0               0        8     
</P>
The simulation stop time should be 10 seconds.  
</HTML>
"),     Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon,
        Diagram,
        Window(
          x=0.2,
          y=0.06,
          width=0.62,
          height=0.69),
        experiment(StopTime=10),
        experimentSetupOutput(
          states=false,
          derivatives=false,
          inputs=false));
      Utilities.halfadder h(Tdel=0.1) annotation (extent=[20,20; 98,100]);
      Utilities.halfadder h1(Tdel=0.1) annotation (extent=[-80,-90; 0,-8]);
      Sources.Table tabb(
        setvalue={3,4,3,4,3,4,3},
        settime={1,2,3,4,6,7,8},
        inity=3)   annotation (extent=[-100, -80; -80, -60]);
      Sources.Table taba(
        setvalue={4,3,4,3,4,3},
        settime={1,2,4,5,6,8},
        inity=3)   annotation (extent=[-100, -40; -80, -20]);
      Sources.Table tabc(
        setvalue={3,4,3,4,3},
        settime={1,3,4,5,8},
        inity=3)   annotation (extent=[-100, 60; -80, 80]);
      Basic.Or Or1 annotation (extent=[20,-80; 98,-20]);
    equation 
      
      connect(taba.y, h1.a) annotation (points=[-80,-30; -74,-30; -74,-36.7;
            -60,-36.7], style(
          color=78,
          rgbcolor={127,0,127},
          thickness=2,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(tabb.y, h1.b) annotation (points=[-80,-70; -76,-70; -76,-60.48;
            -60,-60.48], style(
          color=78,
          rgbcolor={127,0,127},
          thickness=2,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(h1.s, h.b) annotation (points=[-20,-39.16; -12,-39.16; -12,-40; 0,
            -40; 0,48.8; 39.5,48.8], style(
          color=78,
          rgbcolor={127,0,127},
          thickness=2,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(tabc.y, h.a) annotation (points=[-80,70; -22.75,70; -22.75,72;
            39.5,72], style(
          color=78,
          rgbcolor={127,0,127},
          thickness=2,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(h.c, Or1.x[2]) annotation (points=[78.5,52; 86,52; 86,0; 20,0; 20,
            -48.5],             style(
          color=78,
          rgbcolor={127,0,127},
          thickness=2,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(h1.c, Or1.x[1]) annotation (points=[-20,-57.2; 10,-57.2; 10,-51.5;
            20,-51.5],   style(
          color=78,
          rgbcolor={127,0,127},
          thickness=2,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
    end Fulladder;
    
    model Adderchain "Adderchain consisting of four Fulladders" 
      
      annotation (
        Documentation(info="<HTML>
<P>
Four Fulladders are combined to built a four bit adder unit. 
<br>
<br>
In dependence on time five additions are carried out:
<br> 
<pre> at t = 0                            at t = 1        
<pre> a       0 0 0 0                       a      1 1 1 0                      
<pre> b    +  0 0 0 0                       b   +  1 0 1 1
<pre> <b>s     0 0 0 0 0</b>                      <b>s     1 0 0 1 0</b>
<pre>at t = 2                             at t = 3   
<pre> a       0 1 1 0                       a      1 1 1 0 
<pre> b    +  0 0 1 1                       b   +  1 0 1 0
<pre> <b>s     1 0 1 0 0</b>                      <b>s     0 0 0 1 1</b>
        
at t = 4
<pre> a      1 1 0 0
<pre> b   +  1 1 1 0
<pre> <b>s    0 0 1 0 1</b></pre>
To show the influence of delay a large delay time of 0.1s is choosen.
Furthermore, all signals are initialized with U, the unitialized value.
Please remember, that the nine logic values are coded by the numbers 1,...,9.
The summands a and b can be found at the output signals of the taba and tabb sources.
The result can be seen in the output signals of the Fulladders according to: 
<pre> a                      tab<b>a4</b>.y        tab<b>a3</b>.y        tab<b>a2</b>.y        tab<b>a1</b>.y
<pre> b                      tab<b>b4</b>.y        tab<b>b3</b>.y        tab<b>b2</b>.y        tab<b>b1</b>.y
<pre> sum      <b>A4.Or1</b>.y      <b>A4.s1</b>          <b>A3.s1</b>          <b>A2.s1</b>          <b>A1.s1</b>
</pre>
The simulation stop time has to be 5s.
        
</P>
</HTML>
"),     Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon,
        Diagram,
        Window(
          x=0.2,
          y=0.06,
          width=0.62,
          height=0.69),
        experiment(StopTime=5),
        experimentSetupOutput(
          states=false,
          derivatives=false,
          inputs=false));
      
      Utilities.fulladder A1 annotation (extent=[40, 0; 60, 20]);
      Utilities.fulladder A3 annotation (extent=[-40, 0; -20, 20]);
      Utilities.fulladder A2 annotation (extent=[0, 0; 20, 20]);
      Utilities.fulladder A4 annotation (extent=[-80, 0; -60, 20]);
      Sources.Table b4(
        inity=3,
        setvalue={4,3},
        settime={1,3}) annotation (extent=[-86, 38; -66, 58]);
      Sources.Table b1(
        setvalue={4,3,4},
        inity=3,
        settime={1,2,3}) annotation (extent=[32,38; 52,58]);
      Sources.Table b2(
        inity=3,
        setvalue={4},
        settime={4}) annotation (extent=[-6, 38; 14, 58]);
      Sources.Table b3(
        inity=3,
        setvalue={4},
        settime={1}) annotation (extent=[-46, 38; -26, 58]);
      Sources.Table a1(
        inity=3,
        setvalue={4,3,4},
        settime={1,2,3}) annotation (extent=[52,38; 72,58]);
      Sources.Table a2(
        inity=3,
        setvalue={4},
        settime={1}) annotation (extent=[8, 38; 28, 58]);
      Sources.Table a3(
        inity=3,
        setvalue={4,3},
        settime={1,4}) annotation (extent=[-32, 38; -12, 58]);
      Sources.Table a4(
        inity=3,
        setvalue={3},
        settime={1}) annotation (extent=[-72, 38; -52, 58]);
      Sources.Set Set1(setvalue=3) 
        annotation (extent=[72, 0; 92, 20], rotation=180);
    equation 
      
      connect(A4.a1, A3.out1) annotation (points=[-59.6,10; -40.6,10],
                                                                     style(
          color=78,
          rgbcolor={127,0,127},
          thickness=2,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(A3.a1, A2.out1) annotation (points=[-19.6,10; -0.6,10],
                                                                    style(
          color=78,
          rgbcolor={127,0,127},
          thickness=2,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(A2.a1, A1.out1) annotation (points=[20.4,10; 39.4,10],
                                                                   style(
          color=78,
          rgbcolor={127,0,127},
          thickness=2,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(A1.a1, Set1.y) annotation (points=[60.4,10; 66.2,10; 66.2,10; 72,
            10],                                                style(
          color=78,
          rgbcolor={127,0,127},
          thickness=2,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(a1.y, A1.a2) annotation (points=[72,48; 72,26; 56,26; 56,20.4],
                 style(
          color=78,
          rgbcolor={127,0,127},
          thickness=2,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(b1.y, A1.b1) annotation (points=[52,48; 52,26; 44,26; 44,20.4],
                   style(
          color=78,
          rgbcolor={127,0,127},
          thickness=2,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(a2.y, A2.a2) annotation (points=[28,48; 24,48; 24,26; 16,26; 16,
            20.4],
                 style(
          color=78,
          rgbcolor={127,0,127},
          thickness=2,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(b2.y, A2.b1) annotation (points=[14,48; 10,48; 10,26; 4,26; 4,
            20.4],
          style(
          color=78,
          rgbcolor={127,0,127},
          thickness=2,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(a3.y, A3.a2) annotation (points=[-12,48; -16,48; -16,26; -24,26;
            -24,20.4],
                     style(
          color=78,
          rgbcolor={127,0,127},
          thickness=2,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(b3.y, A3.b1) annotation (points=[-26,48; -30,48; -30,26; -36,26;
            -36,20.4], style(
          color=78,
          rgbcolor={127,0,127},
          thickness=2,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(a4.y, A4.a2) annotation (points=[-52,48; -56,48; -56,26; -64,26;
            -64,20.4],
                     style(
          color=78,
          rgbcolor={127,0,127},
          thickness=2,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(b4.y, A4.b1) annotation (points=[-66,48; -70,48; -70,26; -76,26;
            -76,20.4], style(
          color=78,
          rgbcolor={127,0,127},
          thickness=2,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
    end Adderchain;
    
    model D_FlipFlop "test of DFFL" 
      
      annotation (
        Documentation(info="<HTML>
<P>
Test of D-FlipFlop FlipFlops.Structure.DFFL.<br>
Simulate until time=200s.<br>
Show:  <br>
the clock signal  DFF.CLK.signal[1] <br>
the reset signal  DFF.rst.signal[1] <br>
the input signal  DFF.D.signal[1] <br>
the output signal  DFF.Q.signal[1] <br>
<br>
Only if reset is true, the output signal follows the input D, but clock edge triggered.
If the reset becomes false the output Q immediately (not clock edge triggered) becomes
false. Therefore, it is called an asynchronuous reset. Note that the D input needs a setup
time before the LH clock edge, which is caused by the delays.
</P>
</HTML>
"),     Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon,
        Diagram,
        Window(
          x=0.2,
          y=0.06,
          width=0.62,
          height=0.69));
      
      Utilities.DFFL DFF(
        tLHstage1=2,
        tHLstage1=2,
        tLHstage2=1,
        tHLstage2=1,
        tLHstage3=2,
        tHLstage3=2) annotation (extent=[-40, -40; 40, 40]);
      Sources.Pulse Pulse(period=20)  annotation (extent=[-92, -26; -72, -6]);
      Sources.Table Tab1(
        inity=3,
        setvalue={4,3,4,3},
        settime={50,100,145,200}) annotation (extent=[-92, 6; -72, 26]);
      Sources.Table Tab2(
        inity=3,
        setvalue={4,3,4,3},
        settime={22,140,150,180}) annotation (extent=[-50, -80; -30, -60]);
    equation 
      
      connect(Tab1.y, DFF.D) annotation (points=[-72,16; -40,16], style(
          color=78,
          rgbcolor={127,0,127},
          thickness=2,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(Pulse.y, DFF.CLK) annotation (points=[-72,-16; -40,-16], style(
          color=78,
          rgbcolor={127,0,127},
          thickness=2,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(Tab2.y, DFF.rst) annotation (points=[-30,-70; 0,-70; 0,-40], style(
          color=78,
          rgbcolor={127,0,127},
          thickness=2,
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
    end D_FlipFlop;
    
  package Utilities 
              model halfadder 
                Digital.Interfaces.DigitalInput b 
                  annotation (
                      extent=[-60, -38; -40, -18], rotation=0);
                Digital.Interfaces.DigitalOutput s 
                                     annotation (extent=[40,14; 60,34]);
                annotation (
                    Diagram, Icon(
                    Rectangle(
                      extent=[-40, 60; 40, -60], style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillColor=7,
                rgbfillColor={255,255,255})),
                    Text(
              extent=[-40, 60; 40, 20],
              style(color=0, gradient=2),
              string="halfadder"),
                    Text(
              extent=[-20, -20; 20, -60],
              style(color=0, gradient=2),
              string="+"),
                    Text(
              extent=[-46, 34; -20, 18],
              style(color=0),
              string="a"),
                    Text(
              extent=[-44, -22; -20, -38],
              style(color=0),
              string="b"),
                    Text(
              extent=[22, 30; 48, 14],
              style(color=0),
              string="s"),
                    Text(
              extent=[24, -10; 44, -26],
              style(color=0),
              string="c"),
                    Text(
                      extent=[-148,-60; 152,-120],
                      style(color=3, rgbcolor={0,0,255}),
                      string="%name")));
                Digital.Interfaces.DigitalInput a 
                  annotation (
                      extent=[-60, 20; -40, 40], rotation=0);
                Digital.Interfaces.DigitalOutput c 
                                     annotation (extent=[40, -30; 60, -10]);
                Gates.AndGate AndGate1(tLH=Tdel, tHL=Tdel) 
                  annotation (
                      extent=[-14,-34; 12,-6]);
                Gates.XorGate XorGate1(tLH=Tdel, tHL=Tdel) 
                  annotation (
                      extent=[-14,8; 12,40]);
                  parameter Real Tdel=0;
              equation 
        connect(AndGate1.y, c) annotation (points=[12,-20; 50,-20], style(
            color=78, 
            rgbcolor={127,0,127}, 
            fillColor=79, 
            rgbfillColor={170,85,255}, 
            fillPattern=1));
        connect(XorGate1.y, s) annotation (points=[12,24; 50,24], style(
            color=78, 
            rgbcolor={127,0,127}, 
            fillColor=79, 
            rgbfillColor={170,85,255}, 
            fillPattern=1));
        connect(b, AndGate1.x[1]) annotation (points=[-50,-28; -30,-28; -30,
              -20.7; -14,-20.7], style(
            color=78, 
            rgbcolor={127,0,127}, 
            fillColor=79, 
            rgbfillColor={170,85,255}, 
            fillPattern=1));
        connect(b, XorGate1.x[1]) annotation (points=[-50,-28; -30,-28; -30,
              23.2; -14,23.2], style(
            color=78, 
            rgbcolor={127,0,127}, 
            fillColor=79, 
            rgbfillColor={170,85,255}, 
            fillPattern=1));
        connect(a, XorGate1.x[2]) annotation (points=[-50,30; -34,30; -34,24.8;
              -14,24.8], style(
            color=78, 
            rgbcolor={127,0,127}, 
            fillColor=79, 
            rgbfillColor={170,85,255}, 
            fillPattern=1));
        connect(a, AndGate1.x[2]) annotation (points=[-50,30; -34,30; -34,-19.3;
              -14,-19.3], style(
            color=78, 
            rgbcolor={127,0,127}, 
            fillColor=79, 
            rgbfillColor={170,85,255}, 
            fillPattern=1));
              end halfadder;
      
    model fulladder "adding circuit for binary numbers with input carry bit" 
        
      annotation (
        Documentation(info="<HTML>
<P>
 <pre>   <b>a     b     c in     c out     s</b></pre>
       
 <pre>   1     1     1     0
 <pre>   0     0     0     0
 <pre>   1     0     0     1
 <pre>   0     1     0     1
   
       
       
</P>
</HTML>
"),     Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(Rectangle(extent=[-92, 92; 90, -88], style(color=45, fillColor=6)),
             Text(
            extent=[-66, 50; 68, -48],
            style(
              color=45,
              fillColor=6,
              fillPattern=1),
            string="Full Adder"),
          Text(
            extent=[-150,-96; 150,-151],
            style(color=3, rgbcolor={0,0,255}),
            string="%name")),
        Diagram,
        Window(
          x=0.2,
          y=0.06,
          width=0.62,
          height=0.69));
        
      Utilities.halfadder h(Tdel=0.1) annotation (extent=[-2,6; 74,80]);
      Utilities.halfadder h1(Tdel=0.1) annotation (extent=[-74,-68; -12,2]);
      Digital.Interfaces.DigitalInput a1 
        annotation (extent=[94,-10; 114,10],   rotation=180);
      Digital.Interfaces.DigitalInput a2 
        annotation (extent=[50,94; 70,114],   rotation=270);
      Digital.Interfaces.DigitalInput b1 
        annotation (extent=[-70,94; -50,114],   rotation=270);
      Digital.Interfaces.DigitalOutput s1 
        annotation (extent=[-12,-116; 10,-96],   rotation=270);
      Digital.Interfaces.DigitalOutput out1 
        annotation (extent=[-116,-10; -96,10],   rotation=180);
      Basic.Or Or1 annotation (extent=[20,-60; 58,-20]);
    equation 
        
        connect(h1.s, h.b) annotation (points=[-27.5,-24.6; 0,-24.6; 0,32.64;
              17,32.64], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1));
        connect(h.a, a1) annotation (points=[17,54.1; 0,54.1; 0,74; 88,74; 88,0;
              104,0], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1));
        connect(h1.a, a2) annotation (points=[-58.5,-22.5; -70,-22.5; -70,80;
              60,80; 60,104], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1));
        connect(b1, h1.b) annotation (points=[-60,104; -60,90; -82,90; -82,
              -42.8; -58.5,-42.8], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1));
        connect(s1, h.s) annotation (points=[-1,-106; -1,-94; 80,-94; 80,51.88;
              55,51.88], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1));
        connect(out1, Or1.y) annotation (points=[-106,0; -88,0; -88,-84; 58,-84;
              58,-40], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1));
        connect(h1.c, Or1.x[1]) annotation (points=[-27.5,-40; 4,-40; 4,-41; 20,
              -41], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1));
        connect(h.c, Or1.x[2]) annotation (points=[55,35.6; 70,35.6; 70,8; 4,8;
              4,-39; 20,-39], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1));
    end fulladder;
      
    model RSFF "R-S-Flip-Flop" 
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      Digital.Basic.Nor Nor_S annotation (extent=[-20, 20; 20, 60]);
      Digital.Basic.Nor Nor_R annotation (extent=[-20, -60; 20, -20]);
      annotation (
        Documentation(info="<HTML>
<P>
RS flipflop, composed by Basic Nor and a transport delay.
<br>
</P>
<p><b>Release Notes:</b></p>
<ul>
<li><i>   </i>
       by ...<br>
       </li>
<li><i>September 6, 2003</i>
       by Christoph Clauss<br>
       realized.</li>
</ul>
</HTML>
"),     Diagram(
          Text(
            extent=[-62, 62; -40, 48],
            style(
              color=0,
              fillColor=67,
              fillPattern=1),
            string="set"),
          Text(
            extent=[-62, -20; -34, -36],
            style(
              color=0,
              fillColor=67,
              fillPattern=1),
            string="reset"),
          Text(
            extent=[40, 60; 62, 46],
            style(
              color=0,
              fillColor=67,
              fillPattern=1),
            string="q"),
          Text(
            extent=[40, -40; 62, -54],
            style(
              color=0,
              fillColor=67,
              fillPattern=1),
            string="qn")),
        Icon(
          Rectangle(extent=[-60, 80; 60, -80], style(color=0, thickness=2)),
          Line(points=[-60, 0; 60, 0; 60, 2], style(color=0, thickness=2)),
          Text(
            extent=[-60, 80; 60, 0],
            style(color=0),
            string="S"),
          Text(
            extent=[-60, 0; 60, -80],
            style(color=0),
            string="R")));
        
      Digital.Interfaces.DigitalInput set 
                                    annotation (extent=[-80, 30; -60, 50]);
      Digital.Interfaces.DigitalInput reset 
                                      annotation (extent=[-80, -50; -60, -30]);
      Digital.Interfaces.DigitalOutput q 
                                   annotation (extent=[60, 30; 80, 50]);
      Digital.Interfaces.DigitalOutput qn "not q" 
        annotation (extent=[60, -50; 80, -30]);
      parameter Modelica.SIunits.Time Tdel=0.01;
      parameter Digital.Interfaces.LogicValueType QInit=L.'U';
      Digital.Delay.TransportDelay TDelay(Tdel=Tdel, initout=QInit) 
        annotation (extent=[10, -2; 30, 18], rotation=270);
    equation 
        connect(reset, Nor_R.x[1]) annotation (points=[-70,-40; -40,-40; -40,
              -41; -20,-41], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1));
        connect(TDelay.y, Nor_R.x[2]) annotation (points=[20,-2; 20,-8; -20,-8;
              -20,-39], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1));
        connect(q, Nor_R.y) annotation (points=[70,40; 44,40; 44,-40; 20,-40],
            style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1));
        connect(Nor_S.y, qn) annotation (points=[20,40; 38,40; 38,0; 56,0; 56,
              -40; 70,-40], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1));
        connect(Nor_S.y, TDelay.x) annotation (points=[20,40; 20,29; 20,18; 20,
              18], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1));
        connect(set, Nor_S.x[2]) annotation (points=[-70,40; -40,40; -40,41;
              -20,41], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1));
        connect(Nor_R.y, Nor_S.x[1]) annotation (points=[20,-40; 20,-14; -36,
              -14; -36,39; -20,39], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=79,
            rgbfillColor={170,85,255},
            fillPattern=1));
    end RSFF;
      
    model DFFL "D flipflop low active" 
        
      annotation (
        Documentation(info="<HTML>
<P>
<br>
Only if reset is true, the output signal follows the input D, but clock edge triggered.
If the reset becomes false the output Q immediately (not clock edge triggered) becomes
false. Therefore, it is called an asynchronuous reset. Note that the D input needs a setup
time before the LH clock edge, which is caused by the delays.
</P>
<p><b>Release Notes:</b></p>
<ul>
<li><i>   </i>
       by ...<br>
       </li>
<li><i>November 6, 2003</i>
       by Christoph Clauss<br>
       realized.</li>
</ul>
</HTML>
"),     Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-60, 70; 60, -70], style(
              color=0,
              thickness=2,
              fillColor=67)),
          Ellipse(extent=[60, 10; 80, -10], style(
              color=0,
              thickness=2,
              fillColor=67,
              fillPattern=1)),
          Line(points=[-60, -30; -50, -40; -60, -50], style(
              color=0,
              thickness=2,
              fillColor=67,
              fillPattern=1)),
          Ellipse(extent=[-10, -70; 10, -90], style(
              color=0,
              thickness=2,
              fillColor=67,
              fillPattern=1)),
          Line(points=[-90, 40; -60, 40], style(
                color=78,
                rgbcolor={127,0,127},
                thickness=2,
                fillColor=67,
                rgbfillColor={127,255,255},
                fillPattern=1)),
          Line(points=[-90, -40; -60, -40], style(
                color=78,
                rgbcolor={127,0,127},
                thickness=2,
                fillColor=67,
                rgbfillColor={127,255,255},
                fillPattern=1)),
          Line(points=[60,40; 88,40],   style(
                color=78,
                rgbcolor={127,0,127},
                thickness=2,
                fillColor=67,
                rgbfillColor={127,255,255},
                fillPattern=1)),
          Text(
            extent=[-56, 56; -34, 22],
            string="D",
            style(
              color=0,
              thickness=2,
              fillColor=67,
              fillPattern=1)),
          Text(
            extent=[36, 54; 58, 20],
            style(
              color=0,
              thickness=2,
              fillColor=67,
              fillPattern=1),
            string="Q"),
          Text(
            extent=[22, 20; 60, -22],
            style(
              color=0,
              thickness=2,
              fillColor=67,
              fillPattern=1),
            string="QB"),
          Text(
            extent=[-50, -20; -10, -62],
            style(
              color=0,
              thickness=2,
              fillColor=67,
              fillPattern=1),
            string="CLK"),
          Text(
            extent=[-18, -48; 18, -72],
            style(
              color=0,
              thickness=2,
              fillColor=67,
              fillPattern=1),
            string="rst"),
            Line(points=[80,0; 90,0; 90,-2], style(
                color=0,
                rgbcolor={0,0,0},
                fillColor=79,
                rgbfillColor={170,85,255},
                fillPattern=1))),
        Diagram(
          Text(extent=[18, 26; 38, 14], string="rst"),
          Text(extent=[-62, 48; -42, 36], string="cf"),
          Text(extent=[-62, 10; -42, -2], string="cbf"),
          Text(extent=[-2, 44; 18, 32], string="dl"),
          Text(extent=[0, 6; 20, -6], string="dbl"),
          Text(extent=[-102, -42; -82, -54], string="clk"),
          Text(extent=[-106, 34; -86, 22], string="d"),
          Text(extent=[-26, -86; -6, -98], string="rst"),
          Text(extent=[86,-6; 106,-18],   string="q"),
          Text(extent=[82,60; 102,48],  string="qb")),
        Window(
          x=0.2,
          y=0.06,
          width=0.62,
          height=0.69));
        
      Gates.NandGate NG1(tLH=tLHstage1, tHL=tHLstage1) 
        annotation (extent=[-80, 40; -60, 60]);
      Gates.NandGate NG2(tLH=tLHstage3, tHL=tHLstage3) 
        annotation (extent=[40, -80; 60, -60]);
      Gates.NandGate NG3(tLH=tLHstage1, tHL=tHLstage1, ninputs=3) 
        annotation (extent=[-80, -20; -60, 0]);
      Gates.NandGate NG4(tLH=tLHstage2, tHL=tHLstage2, ninputs=3) 
        annotation (extent=[-20, 40; 0, 60]);
      Gates.NandGate NG5(tLH=tLHstage2, tHL=tHLstage2, ninputs=3) 
        annotation (extent=[-20, -20; 0, 0]);
      Gates.NandGate NG6(tLH=tLHstage3, tHL=tHLstage3, ninputs=3) 
        annotation (extent=[40, -20; 60, 0]);
      Digital.Interfaces.DigitalOutput QB 
                                    annotation (extent=[90,-12; 110,8]);
      Digital.Interfaces.DigitalOutput Q 
                                   annotation (extent=[90,30; 110,50]);
      Digital.Interfaces.DigitalInput CLK "clock input" 
        annotation (extent=[-110,-50; -90,-30]);
      Digital.Interfaces.DigitalInput D "set input" 
        annotation (extent=[-110,30; -90,50]);
      Digital.Interfaces.DigitalInput rst "reset input" 
        annotation (extent=[-10,-110; 10,-90],   rotation=90);
      parameter Modelica.SIunits.Time tLHstage1=2 "LH delay at NG1 and NG3";
      parameter Modelica.SIunits.Time tHLstage1=2 "HL delay at NG1 and NG3";
      parameter Modelica.SIunits.Time tLHstage2=1 "LH delay at NG4 and NG5";
      parameter Modelica.SIunits.Time tHLstage2=1 "HL delay at NG4 and NG5";
      parameter Modelica.SIunits.Time tLHstage3=2 "LH delay at NG2 and NG6";
      parameter Modelica.SIunits.Time tHLstage3=2 "HL delay at NG2 and NG6";
    equation 
        
        connect(NG4.y, NG1.x[2]) annotation (points=[0,50; 14,50; 14,80; -80,80;
              -80,50.5], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=79,
            rgbfillColor={170,85,255},
            fillPattern=1));
        connect(NG4.y, NG5.x[3]) annotation (points=[0,50; 14,50; 14,20; -20,20;
              -20,-9.33333], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=79,
            rgbfillColor={170,85,255},
            fillPattern=1));
        connect(CLK, NG3.x[2]) annotation (points=[-100,-40; -86,-40; -86,-10;
              -80,-10], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=79,
            rgbfillColor={170,85,255},
            fillPattern=1));
        connect(CLK, NG5.x[1]) annotation (points=[-100,-40; -20,-40; -20,
              -10.6667], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=79,
            rgbfillColor={170,85,255},
            fillPattern=1));
        connect(NG3.y, NG5.x[2]) annotation (points=[-60,-10; -20,-10], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=79,
            rgbfillColor={170,85,255},
            fillPattern=1));
        connect(NG3.y, NG1.x[1]) annotation (points=[-60,-10; -56,-10; -56,28;
              -80,28; -80,49.5], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=79,
            rgbfillColor={170,85,255},
            fillPattern=1));
        connect(NG1.y, NG3.x[3]) annotation (points=[-60,50; -50,50; -50,16;
              -80,16; -80,-9.33333], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=79,
            rgbfillColor={170,85,255},
            fillPattern=1));
        connect(rst, NG3.x[1]) annotation (points=[0,-100; 0,-76; -80,-76; -80,
              -10.6667], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=79,
            rgbfillColor={170,85,255},
            fillPattern=1));
        connect(NG3.y, NG2.x[1]) annotation (points=[-60,-10; -56,-10; -56,
              -70.5; 40,-70.5], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=79,
            rgbfillColor={170,85,255},
            fillPattern=1));
        connect(NG5.y, NG6.x[2]) annotation (points=[0,-10; 40,-10], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=79,
            rgbfillColor={170,85,255},
            fillPattern=1));
        connect(NG5.y, NG4.x[1]) annotation (points=[0,-10; 0,14; -26,14; -26,
              49.3333; -20,49.3333], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=79,
            rgbfillColor={170,85,255},
            fillPattern=1));
        connect(D, NG4.x[3]) annotation (points=[-100,40; -88,40; -88,88; -20,
              88; -20,50.6667], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=79,
            rgbfillColor={170,85,255},
            fillPattern=1));
        connect(rst, NG4.x[2]) annotation (points=[0,-100; 0,-76; -38,-76; -38,
              50; -20,50], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=79,
            rgbfillColor={170,85,255},
            fillPattern=1));
        connect(rst, NG6.x[3]) annotation (points=[0,-100; 0,-76; 24,-76; 24,
              -9.33333; 40,-9.33333], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=79,
            rgbfillColor={170,85,255},
            fillPattern=1));
        connect(NG2.y, NG6.x[1]) annotation (points=[60,-70; 64,-70; 64,-38; 40,
              -38; 40,-10.6667], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=79,
            rgbfillColor={170,85,255},
            fillPattern=1));
        connect(NG6.y, NG2.x[2]) annotation (points=[60,-10; 64,-10; 64,-32; 48,
              -32; 48,-56; 40,-56; 40,-69.5], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=79,
            rgbfillColor={170,85,255},
            fillPattern=1));
        connect(NG2.y, Q) annotation (points=[60,-70; 78,-70; 78,40; 100,40],
            style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=79,
            rgbfillColor={170,85,255},
            fillPattern=1));
        connect(NG6.y, QB) annotation (points=[60,-10; 70,-10; 70,-2; 100,-2],
            style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=79,
            rgbfillColor={170,85,255},
            fillPattern=1));
    end DFFL;
  end Utilities;
    
  end Examples;
end Digital;
