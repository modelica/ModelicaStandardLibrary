package Continuous "Continuous control blocks with internal states" 
  
  extends Modelica.Icons.Library;
  annotation( Window(
      x=0.05,
      y=0.09,
      width=0.35,
      height=0.74,
      library=1,
      autolayout=1),
   Documentation(info="<html>
<p>
This package contains basic <b>continuous</b> input/output blocks.
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
<li><i>June 30, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized a first version, based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist.
</li>
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
  block Integrator "Output the integral of the input signals" 
    parameter Real k[:]={1} "Integrator gains";
    parameter Real y0[:]=zeros(size(k, 1)) "Start values of integrators";
    extends Interfaces.MIMOs(final n=size(k, 1), y(start=y0));
    
    annotation(
      Documentation(info="<html>
<p>
This blocks computes output <b>y</b>=outPort.signal element-wise as
<i>integral</i> of the input <b>u</b>=inPort.signal multiplied with
the gain <i>k</i>:
</p>

<pre>
             k[i]
     y[i] = ------ u[i]
              s
</pre>

<p><b>Release Notes:</b></p>
<ul>
<li><i>Nov. 4, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Vectorized.</li>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>
</HTML>
"),   Icon(
        Line(points=[-80, 78; -80, -90], style(color=8)),
        Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(
            color=8,
            fillColor=8,
            fillPattern=1)),
        Line(points=[-90, -80; 82, -80], style(color=8)),
        Polygon(points=[90, -80; 68, -72; 68, -88; 90, -80], style(
            color=8,
            fillColor=8,
            fillPattern=1)),
        Text(
          extent=[0, -10; 60, -70],
          string="I",
          style(color=8)),
        Text(
          extent=[-150, -150; 150, -110],
          string="k=%k",
          style(color=0)),
        Line(points=[-80, -80; 80, 80])),
      Diagram(
        Rectangle(extent=[-60, 60; 60, -60]),
        Line(points=[-100, 0; -60, 0]),
        Line(points=[60, 0; 100, 0]),
        Text(
          extent=[-36, 60; 32, 2],
          string="k",
          style(color=0)),
        Text(
          extent=[-32, 0; 36, -58],
          string="s",
          style(color=0)),
        Line(points=[-46, 0; 46, 0], style(color=0))));
  equation 
    for i in 1:size(k, 1) loop
      der(y[i]) = k[i]*u[i];
    end for;
  end Integrator;
  
  block LimIntegrator "Integrator with limited values of the outputs" 
    parameter Real k[:]={1} "Integrator gains";
    parameter Real outMax[:]={1} "Upper limits of outputs";
    parameter Real outMin[:]=-outMax "Lower limits of outputs";
    parameter Real y0[:]=zeros(size(k, 1)) "Start values of integrators";
    
    extends Interfaces.MIMOs(final n=max([size(k, 1); size(outMax, 1); size(
          outMin, 1)]), y(start=y0));
    
  protected 
    parameter Real p_k[n]=(if size(k, 1) == 1 then ones(n)*k[1] else k);
    parameter Real p_outMax[n]=(if size(outMax, 1) == 1 then ones(n)*outMax[1] else 
              outMax);
    parameter Real p_outMin[n]=(if size(outMin, 1) == 1 then ones(n)*outMin[1] else 
              outMin);
    annotation(
      Documentation(info="<html>
<p>
This blocks computes <b>y</b>=outPort.signal element-wise as <i>integral</i>
of the input <b>u</b>=inPort.signal multiplied with the gain <i>k</i>. If the
integral reaches a given upper or lower <i>limit</i> and the
input will drive the integral outside of this bound, the
integration is halted and only restarted if the input drives
the integral away from the bounds.
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>Nov. 4, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Vectorized.</li>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.
</li>
</ul>

<p><b>Copyright &copy; 1999-2002, Modelica Association and DLR.</b></p>
</HTML>
"),   Icon(
        Line(points=[-80, 78; -80, -90], style(color=8)),
        Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
              fillColor=8)),
        Line(points=[-90, -80; 82, -80], style(color=8)),
        Polygon(points=[90, -80; 68, -72; 68, -88; 90, -80], style(color=8,
              fillColor=8)),
        Line(points=[-80, -80; 20, 20; 80, 20]),
        Text(
          extent=[0, -10; 60, -70],
          string="I",
          style(color=8)),
        Text(
          extent=[-150, -150; 150, -110],
          string="k=%k",
          style(color=0))),
      Diagram(
        Rectangle(extent=[-60, 60; 60, -60]),
        Text(
          extent=[-54, 46; -4, -48],
          string="lim",
          style(color=0)),
        Line(points=[-100, 0; -60, 0]),
        Line(points=[60, 0; 100, 0]),
        Text(
          extent=[-8, 60; 60, 2],
          string="k",
          style(color=0)),
        Text(
          extent=[-8, -2; 60, -60],
          string="s",
          style(color=0)),
        Line(points=[4, 0; 46, 0], style(color=0))));
  equation 
    for i in 1:n loop
      der(y[i]) = if y[i] < p_outMin[i] and u[i] < 0 or y[i] > p_outMax[i] and 
        u[i] > 0 then 0 else p_k[i]*u[i];
    end for;
  end LimIntegrator;
  
  block Derivative "Approximated derivative block" 
    parameter Real k[:]={1} "Gains";
    parameter SI.Time T[:](min=fill(Modelica.Constants.small, size(T, 1)))=  {0.01} 
      "Time constants (T>0 required; T=0 is ideal derivative block)";
    
    extends Interfaces.MIMOs(final n=max([size(k, 1); size(T, 1)]));
    
    output Real x[n] "State of block";
    
  protected 
    parameter Real p_k[n]=(if size(k, 1) == 1 then ones(n)*k[1] else k);
    parameter Real p_T[n]=(if size(T, 1) == 1 then ones(n)*T[1] else T);
    annotation(
      Documentation(info="<html>
<p>
This blocks defines the transfer function between the
input u=inPort.signal and the output y=outPort.signal
element-wise as <i>approximated derivative</i>:
</p>

<pre>
             k[i] * s
     y[i] = ------------ * u[i]
            T[i] * s + 1
</pre>

<p>
If you would like to be able to change easily between different
transfer functions (FirstOrder, SecondOrder, ... ) by changing
parameters, use the general block <b>TransferFunction</b> instead
and model a derivative block with parameters<br>
b = {k,0}, a = {T, 1}.
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>Nov. 15, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Special handling, if k is zero. Introduced, in order that
       the D-part of the PID controllers can be set to zero without
       introducing numerical problems.</li>

<li><i>Nov. 4, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Vectorized.</li>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>

</HTML>
"),   Icon(
        Line(points=[-80, 78; -80, -90], style(color=8)),
        Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
              fillColor=8)),
        Line(points=[-90, -80; 82, -80], style(color=8)),
        Polygon(points=[90, -80; 68, -72; 68, -88; 90, -80], style(color=8,
              fillColor=8)),
        Line(points=[-80, -80; -80, 60; -70, 17.95; -60, -11.46; -50, -32.05; -
              40, -46.45; -30, -56.53; -20, -63.58; -10, -68.51; 0, -71.96; 10,
                -74.37; 20, -76.06; 30, -77.25; 40, -78.07; 50, -78.65; 60, -
              79.06]),
        Text(
          extent=[0, 0; 60, 60],
          string="DT1",
          style(color=8)),
        Text(
          extent=[-150, -150; 150, -110],
          string="k=%k",
          style(color=0))),
      Diagram(
        Text(
          extent=[-54, 52; 50, 10],
          string="k s",
          style(color=0)),
        Text(
          extent=[-54, -6; 52, -52],
          string="T s + 1",
          style(color=0)),
        Line(points=[-50, 0; 50, 0], style(color=0)),
        Rectangle(extent=[-60, 60; 60, -60]),
        Line(points=[-100, 0; -60, 0]),
        Line(points=[60, 0; 100, 0])),
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.17,
        y=0.03,
        width=0.5,
        height=0.61));
  equation 
    for i in 1:n loop
      der(x[i]) = if noEvent(abs(p_k[i]) >= Modelica.Constants.eps) then (u[i] - x[i])/
        p_T[i] else 0;
      y[i] = if noEvent(abs(p_k[i]) >= Modelica.Constants.eps) then (p_k[i]/p_T[i])*(u[i]
          - x[i]) else 0;
    end for;
  end Derivative;
  
  block FirstOrder "First order transfer function block (= 1 pole)" 
    parameter Real k[:]={1} "Gain";
    parameter SI.Time T[:]={1} "Time Constant";
    
    extends Interfaces.MIMOs(final n=max([size(k, 1); size(T, 1)]));
    
  protected 
    parameter Real p_k[n]=(if size(k, 1) == 1 then ones(n)*k[1] else k);
    parameter Real p_T[n]=(if size(T, 1) == 1 then ones(n)*T[1] else T);
    annotation(
      Documentation(info="<html>
<p>
This blocks defines the transfer function between the input u=inPort.signal
and the output y=outPort.signal element-wise as <i>first order</i> system:
</p>

<pre>
               k[i]
     y[i] = ------------ * u[i]
            T[i] * s + 1
</pre>

<p>
If you would like to be able to change easily between different
transfer functions (FirstOrder, SecondOrder, ... ) by changing
parameters, use the general block <b>TransferFunction</b> instead
and model a first order SISO system with parameters<br>
b = {k}, a = {T, 1}.
</p>

<pre>
Example:

   parameter: k = {0.3}, T = {0.4}

   results in:

             0.3
      y = ----------- * u
          0.4 s + 1.0
</pre>

<p><b>Release Notes:</b></p>
<ul>
<li><i>Nov. 4, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Vectorized.</li>

<li><i>June 30, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>

</HTML>
"),   Icon(
        Line(points=[-80, 78; -80, -90], style(color=8)),
        Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 88; -80, 90], style(
            color=8,
            fillColor=8,
            fillPattern=1)),
        Line(points=[-90, -80; 82, -80], style(color=8)),
        Polygon(points=[90, -80; 68, -72; 68, -88; 90, -80], style(
            color=8,
            fillColor=8,
            fillPattern=1)),
        Line(points=[-80, -80; -70, -45.11; -60, -19.58; -50, -0.9087; -40,
              12.75; -30, 22.75; -20, 30.06; -10, 35.41; 0, 39.33; 10, 42.19;
              20, 44.29; 30, 45.82; 40, 46.94; 50, 47.76; 60, 48.36; 70, 48.8;
              80, 49.12]),
        Text(
          extent=[0, 0; 60, -60],
          string="PT1",
          style(color=8)),
        Text(
          extent=[-150, -150; 150, -110],
          string="T=%T",
          style(color=0))),
      Diagram(
        Text(
          extent=[-48, 52; 50, 8],
          string="k",
          style(color=0)),
        Text(
          extent=[-54, -6; 56, -56],
          string="T s + 1",
          style(color=0)),
        Line(points=[-50, 0; 50, 0], style(color=0)),
        Rectangle(extent=[-60, 60; 60, -60]),
        Line(points=[-100, 0; -60, 0]),
        Line(points=[60, 0; 100, 0])),
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.15,
        y=0.04,
        width=0.52,
        height=0.55));
  equation 
    for i in 1:n loop
      der(y[i]) = (p_k[i]*u[i] - y[i])/p_T[i];
    end for;
  end FirstOrder;
  
  block SecondOrder "Second order transfer function block (= 2 poles)" 
    parameter Real k[:]={1} "Gain";
    parameter Real w[:]={1} "Angular frequency";
    parameter Real D[:]={1} "Damping";
    
    extends Interfaces.MIMOs(final n=max([size(k, 1); size(w, 1); size(D, 1)]));
    output Real yd[n] "Derivative of y";
  protected 
    parameter Real p_k[n]=(if size(k, 1) == 1 then ones(n)*k[1] else k);
    parameter Real p_w[n]=(if size(w, 1) == 1 then ones(n)*w[1] else w);
    parameter Real p_D[n]=(if size(D, 1) == 1 then ones(n)*D[1] else D);
    annotation(
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.23,
        y=0.1,
        width=0.54,
        height=0.49),
      Documentation(info="<html>
<p>
This blocks defines the transfer function between the input u=inPort.signal and
the output y=outPort.signal element-wise as <i>second order</i> system:
</p>

<pre>
                             k[i]
     y[i] = ---------------------------------------- * u[i]
            ( s / w[i] )^2 + 2*D[i]*( s / w[i] ) + 1

</pre>

<p>
If you would like to be able to change easily between different
transfer functions (FirstOrder, SecondOrder, ... ) by changing
parameters, use the general model class <b>TransferFunction</b>
instead and model a second order SISO system with parameters<br>
b = {k}, a = {1/w^2, 2*D/w, 1}.
</p>

<pre>
Example:

   parameter: k =  {0.3},  w = {0.5},  D = {0.4}

   results in:

                  0.3
      y = ------------------- * u
          4.0 s^2 + 1.6 s + 1
</pre>

<p><b>Release Notes:</b></p>
<ul>
<li><i>Nov. 4, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Vectorized and state space representation changed, such
       that the output and its derivative are used as state.</li>

<li><i>June 30, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>

</HTML>
"),   Icon(
        Line(points=[-80, 78; -80, -90], style(color=8)),
        Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 88; -80, 90], style(
            color=8,
            fillColor=8,
            fillPattern=1)),
        Line(points=[-90, -80; 82, -80], style(color=8)),
        Polygon(points=[90, -80; 68, -72; 68, -88; 90, -80], style(
            color=8,
            fillColor=8,
            fillPattern=1)),
        Line(points=[-80, -80; -72, -68.53; -64, -39.5; -56, -2.522; -48, 32.75;
                -40, 58.8; -32, 71.51; -24, 70.49; -16, 58.45; -8, 40.06; 0,
              20.55; 8, 4.459; 16, -5.271; 24, -7.629; 32, -3.428; 40, 5.21; 48,
                15.56; 56, 25.03; 64, 31.66; 72, 34.5; 80, 33.61]),
        Text(
          extent=[0, -10; 60, -70],
          string="PT2",
          style(color=8)),
        Text(
          extent=[-150, -150; 150, -110],
          string="w=%w",
          style(color=0))),
      Diagram(
        Rectangle(extent=[-60, 60; 60, -60]),
        Text(
          extent=[-60, 60; 60, 14],
          string="k",
          style(color=0)),
        Text(
          extent=[-60, 8; -32, -20],
          string="s",
          style(color=0)),
        Line(points=[-100, 0; -60, 0]),
        Line(points=[60, 0; 100, 0]),
        Line(points=[-50, 14; 50, 14], style(color=0)),
        Line(points=[-54, -20; -38, -20], style(color=0)),
        Text(
          extent=[-52, -26; -36, -48],
          string="w",
          style(color=0)),
        Line(points=[-50, 2; -56, -8; -56, -28; -52, -46], style(color=0)),
        Line(points=[-40, 2; -34, -10; -34, -30; -38, -46], style(color=0)),
        Text(
          extent=[-34, 8; -22, -10],
          string="2",
          style(color=0)),
        Text(
          extent=[-34, -6; 6, -36],
          string="+2D",
          style(color=0)),
        Text(
          extent=[2, 8; 30, -20],
          string="s",
          style(color=0)),
        Line(points=[8, -20; 24, -20], style(color=0)),
        Text(
          extent=[10, -26; 26, -48],
          string="w",
          style(color=0)),
        Line(points=[12, 2; 6, -8; 6, -28; 10, -46], style(color=0)),
        Line(points=[22, 2; 28, -10; 28, -30; 24, -46], style(color=0)),
        Text(
          extent=[30, 2; 58, -42],
          string="+1",
          style(color=0))));
  equation 
    for i in 1:n loop
      der(y[i]) = yd[i];
      der(yd[i]) = p_w[i]*(p_w[i]*(p_k[i]*u[i] - y[i]) - 2*p_D[i]*yd[i]);
    end for;
  end SecondOrder;
  
  block PI "Proportional-Integral controller" 
    parameter Real k[:]={1} "Gain";
    parameter SI.Time T[:]={1} "Time Constant (T>0 required)";
    
    extends Interfaces.MIMOs(final n=max([size(k, 1); size(T, 1)]));
    output Real x[n] "State of block";
    
  protected 
    parameter Real p_k[n]=(if size(k, 1) == 1 then ones(n)*k[1] else k);
    parameter Real p_T[n]=(if size(T, 1) == 1 then ones(n)*T[1] else T);
    annotation(
      Documentation(info="<html>
<p>
This blocks defines the transfer function between the input u=inPort.signal and
the output y=outPort.signal element-wise as <i>PI</i> system:
</p>

<pre>
                        1
   y[i] = k[i] * (1 + ------ ) * u[i]
                      T[i]*s

                 T[i]*s + 1
        = k[i] * ----------- * u[i]
                    T[i]*s
</pre>

<p>
If you would like to be able to change easily between different
transfer functions (FirstOrder, SecondOrder, ... ) by changing
parameters, use the general model class <b>TransferFunction</b>
instead and model a PI SISO system with parameters<br>
b = {k*T, k}, a = {T, 0}.
</p>

<pre>
Example:

   parameter: k = {0.3},  T = {0.4}

   results in:

               0.4 s + 1
      y = 0.3 ----------- * u
                 0.4 s
</pre>

<p><b>Release Notes:</b></p>
<ul>
<li><i>Nov. 4, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Vectorized.</li>

<li><i>June 30, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>

</HTML>
"),   Icon(
        Line(points=[-80, 78; -80, -90], style(color=8)),
        Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 88; -80, 90], style(
            color=8,
            fillColor=8,
            fillPattern=1)),
        Line(points=[-90, -80; 82, -80], style(color=8)),
        Polygon(points=[90, -80; 68, -72; 68, -88; 90, -80], style(
            color=8,
            fillColor=8,
            fillPattern=1)),
        Line(points=[-80, -80; -80, -20; 60, 80], style(thickness=1)),
        Text(
          extent=[0, 6; 60, -56],
          string="PI",
          style(color=8)),
        Text(
          extent=[-150, -150; 150, -110],
          string="T=%T",
          style(color=0))),
      Diagram(
        Rectangle(extent=[-60, 60; 60, -60]),
        Text(
          extent=[-68, 24; -24, -18],
          string="k",
          style(color=0)),
        Text(
          extent=[-32, 48; 60, 0],
          string="T s + 1",
          style(color=0)),
        Text(
          extent=[-30, -8; 52, -40],
          string="T s",
          style(color=0)),
        Line(points=[-24, 0; 54, 0], style(color=0)),
        Line(points=[-100, 0; -60, 0]),
        Line(points=[62, 0; 100, 0])));
  equation 
    for i in 1:n loop
      der(x[i]) = u[i]/p_T[i];
      y[i] = p_k[i]*(x[i] + u[i]);
    end for;
  end PI;
  
  block PID "PID-controller in additive description form" 
    extends Interfaces.SISO;
    
    parameter Real k=1 "Gain";
    parameter SI.Time Ti(min=Modelica.Constants.small)=  0.5 
      "Time Constant of Integrator";
    parameter SI.Time Td(min=0)=  0.1 "Time Constant of Derivative block";
    parameter Real Nd(min=Modelica.Constants.small)=  10 
      "The higher Nd, the more ideal the derivative block";
    
    annotation( Icon(
        Line(points=[-80, 78; -80, -90], style(color=8)),
        Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
              fillColor=8)),
        Line(points=[-90, -80; 82, -80], style(color=8)),
        Polygon(points=[90, -80; 68, -72; 68, -88; 90, -80], style(color=8,
              fillColor=8)),
        Line(points=[-80, -80; -80, 50; -80, -20; 60, 80]),
        Text(
          extent=[-20, -20; 80, -60],
          string="PID",
          style(color=8)),
        Text(
          extent=[-150, -150; 150, -110],
          string="Ti=%Ti",
          style(color=0))), Documentation(info="<HTML>
<p>
This is the text-book version of a PID-controller.
For a more practically useful PID-controller, use
block LimPID.
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>Aug. 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>
</HTML>
"));
    Math.Gain P "Proportional part of PID controller" annotation( extent=[-60,
          60; -20, 100]);
    Integrator I(k={1/Ti}) "Integral part of PID controller" annotation( extent=
         [-60, -20; -20, 20]);
    Derivative D(k={Td}, T={max([Td/Nd, 100*Modelica.Constants.eps])}) 
      "Derivative part of PID controller" annotation( extent=[-60, -100; -20, -
          60]);
    Math.Gain Gain(k={k}) "Gain of PID controller" annotation( extent=[60, -10;
            80, 10]);
    Math.Add3 Add annotation( extent=[20, -10; 40, 10]);
  equation 
    connect(P.outPort, Add.inPort1) annotation( points=[-20, 80; 0, 80; 0, 8;
          20, 8]);
    connect(I.outPort, Add.inPort2) annotation( points=[-20, 0; 20, 0]);
    connect(D.outPort, Add.inPort3) annotation( points=[-20, -80; 0, -80; 0, -8;
            20, -8]);
    connect(Add.outPort, Gain.inPort) annotation( points=[40, 0; 60, 0]);
    connect(outPort, Gain.outPort) annotation( points=[100, 0; 80, 0]);
    connect(inPort, I.inPort) annotation( points=[-100, 0; -60, 0]);
    connect(inPort, P.inPort) annotation( points=[-100, 0; -80, 0; -80, 80; -60,
            80]);
    connect(inPort, D.inPort) annotation( points=[-100, 0; -80, 0; -80, -80; -
          60, -80]);
  end PID;
  
  block LimPID 
    "PID controller with limited output, anti-windup compensation and setpoint weighting"
    
    
    extends Interfaces.SVcontrol;
    
    parameter Real k(min=0)=  1 "Gain of PID block";
    parameter SI.Time Ti(min=Modelica.Constants.small)=  0.5 
      "Time constant of Integrator block";
    parameter SI.Time Td(min=0)=  0.1 "Time constant of Derivative block";
    parameter Real yMax=1 "Upper limit of output";
    parameter Real yMin=-yMax "Lower limit of output";
    parameter Real wp(min=0)=  1 
      "Set-point weight for Proportional block (0..1)";
    parameter Real wd(min=0)=  0 "Set-point weight for Derivative block (0..1)";
    parameter Real Ni(min=100*Modelica.Constants.eps)=  0.9 
      "Ni*Ti is time constant of anti-windup compensation";
    parameter Real Nd(min=100*Modelica.Constants.eps)=  10 
      "The higher Nd, the more ideal the derivative block";
    Nonlinear.Limiter limiter(uMax={yMax}, uMin={yMin}) annotation( extent=[70,
            -10; 90, 10]);
    annotation(
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.22,
        y=0.02,
        width=0.6,
        height=0.72),
      Icon(
        Line(points=[-80, 78; -80, -90], style(color=8)),
        Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
              fillColor=8)),
        Line(points=[-90, -80; 82, -80], style(color=8)),
        Polygon(points=[90, -80; 68, -72; 68, -88; 90, -80], style(color=8,
              fillColor=8)),
        Line(points=[-80, -80; -80, 50; -80, -20; 30, 60; 80, 60]),
        Text(
          extent=[-20, -20; 80, -60],
          string="PID",
          style(color=8))),
      Documentation(info="<HTML>
<p>
This is a PID controller incorporating several practical aspects.
It is designed according to chapter 3 of the book
</p>

<pre>
   K. Astroem, T. Haegglund: PID Controllers: Theory, Design, and Tuning.
                             2nd edition, 1995.
</pre>

<p>
Besides the additive <b>proportional, integral</b> and <b>derivative</b>
part of this controller, the following practical aspects are included:
</p>

<ul>
<li> The output of this controller is limited. If the controller is
     in its limits, anti-windup compensation is activated to drive
     the integrator state to zero. </li>

<li> The high-frequency gain of the derivative part is limited
     to avoid excessive amplification of measurement noise.</li>

<li> Setpoint weighting is present, which allows to weight
     the setpoint in the proportional and the derivative part
     independantly from the measurement. The controller will respond
     to load disturbances and measurement noise independantly of this setting
     (parameters wp, wd). However, setpoint changes will depend on this
     setting. For example, it is useful to set the setpoint weight wd
     for the derivative part to zero, if steps may occur in the
     setpoint signal.</li>
</ul>

<p><b>Release Notes:</b></p>
<ul>
<li><i>Aug. 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>

</HTML>
"));
    Math.Add addP(k1=wp, k2=-1) annotation( extent=[-80, 40; -60, 60]);
    Math.Add addD(k1=wd, k2=-1) annotation( extent=[-80, -10; -60, 10]);
    Math.Gain P annotation( extent=[-40, 40; -20, 60]);
    Integrator I(k={1/Ti}) annotation( extent=[-40, -60; -20, -40]);
    Derivative D(k={Td}, T={max([Td/Nd, 1.e-14])}) annotation( extent=[-40, -10;
            -20, 10]);
    Math.Gain gainPID(k={k}) annotation( extent=[30, -10; 50, 10]);
    Math.Add3 addPID annotation( extent=[0, -10; 20, 10]);
    Math.Add3 addI(k2=-1) annotation( extent=[-80, -60; -60, -40]);
    Math.Add addSat(k2=-1) annotation( extent=[70, -60; 90, -40], rotation=-90);
    Math.Gain gainTrack(k={1/(k*Ni)}) annotation( extent=[40, -80; 20, -60]);
  equation 
    assert(yMax >= yMin, "PID: Limits must be consistent");
    connect(inPort_s, addP.inPort1) annotation( points=[-102, 0; -96, 0; -96,
          56; -80, 56]);
    connect(inPort_m, addP.inPort2) annotation( points=[0, -100; 0, -92; -92, -
          92; -92, 44; -80, 44], style(thickness=2));
    connect(inPort_s, addD.inPort1) annotation( points=[-102, 0; -96, 0; -96, 6;
            -82, 6]);
    connect(inPort_m, addD.inPort2) annotation( points=[0, -100; 0, -92; -92, -
          92; -92, -6; -82, -6; -82, -6], style(thickness=2));
    connect(inPort_s, addI.inPort1) annotation( points=[-100, 0; -96, 0; -96, -
          42; -82, -42]);
    connect(inPort_m, addI.inPort2) annotation( points=[0, -104; 0, -92; -92, -
          92; -92, -50; -80, -50], style(thickness=2));
    connect(gainTrack.outPort, addI.inPort3) annotation( points=[20, -70; -88,
          -70; -88, -58; -80, -58]);
    connect(addP.outPort, P.inPort) annotation( points=[-60, 50; -40, 50; -40,
          50]);
    connect(addD.outPort, D.inPort) annotation( points=[-60, 0; -50, 0]);
    connect(addI.outPort, I.inPort) annotation( points=[-58, -50; -40, -50]);
    connect(P.outPort, addPID.inPort1) annotation( points=[-18, 50; -10, 50; -
          10, 8; 0, 8]);
    connect(D.outPort, addPID.inPort2) annotation( points=[-20, 0; -2, 0; -2, 0]);
    connect(I.outPort, addPID.inPort3) annotation( points=[-18, -50; -10, -50;
          -10, -8; -2, -8; -2, -8]);
    connect(addPID.outPort, gainPID.inPort) annotation( points=[21, 0; 28, 0]);
    connect(gainPID.outPort, addSat.inPort2) annotation( points=[50, 0; 60, 0;
          60, -30; 74, -30; 74, -40]);
    connect(addSat.outPort, gainTrack.inPort) annotation( points=[80, -62; 80,
          -70; 42, -70]);
    connect(gainPID.outPort, limiter.inPort) annotation( points=[50, 0; 70, 0]);
    connect(limiter.outPort, outPort) annotation( points=[90, 0; 100, 0]);
    connect(limiter.outPort, addSat.inPort1) annotation( points=[90, 0; 94, 0;
          94, -20; 86, -20; 86, -40]);
  end LimPID;
  
  block TransferFunction "Linear transfer function" 
    extends Interfaces.SISO;
    
    parameter Real b[:]={1} "Numerator coefficients of transfer function.";
    parameter Real a[:]={1,1} "Denominator coefficients of transfer function.";
    output Real x[size(a, 1) - 1] 
      "State of transfer function from controller canonical form";
    
  protected 
    parameter Integer na=size(a, 1) "Size of Denominator of transfer function.";
    parameter Integer nb(max=na)=  size(b, 1) 
      "Size of Numerator of transfer function.";
    parameter Integer nx=size(a, 1) - 1;
    Real x1dot "Derivative of first state of TransferFcn";
    Real xn "Highest order state of TransferFcn";
    annotation(
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.39,
        y=0.09,
        width=0.58,
        height=0.77),
      Documentation(info="<html>
<p>
This block defines the transfer function between the input
u=inPort.signal[1] and the output y=outPort.signal[1]
as (nb = dimension of b, na = dimension of a):
</p>

<pre>
           b[1]*s^[nb-1] + b[2]*s^[nb-2] + ... + b[nb]
   y(s) = --------------------------------------------- * u(s)
           a[1]*s^[na-1] + a[2]*s^[na-2] + ... + a[na]
</pre>

<p>
State variables <b>x</b> are defined according to <b>controller canonical</b>
form. Initial values of the states can be set as start values of <b>x</b>.
<p>

<p>
Example:
</p>

<pre>
     TransferFunction g(b = {2,4}, a = {1,3});
</pre>

<p>
results in the following transfer function:
</p>

<pre>
        2*s + 4
   y = --------- * u
         s + 3
</pre>

<p><b>Release Notes:</b></p>
<ul>
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized based on a realization of the corresponding
       Dymola library of Hilding Elmqvist.
</li>
</ul>

</HTML>
"),   Icon(
        Line(points=[-80, 0; 80, 0]),
        Text(extent=[-90, 10; 90, 90], string="b(s)"),
        Text(extent=[-90, -10; 90, -90], string="a(s)")),
      Diagram(
        Line(points=[40, 0; -40, 0], style(color=0)),
        Text(
          extent=[-55, 55; 55, 5],
          string="b(s)",
          style(color=0)),
        Text(
          extent=[-55, -5; 55, -55],
          string="a(s)",
          style(color=0)),
        Rectangle(extent=[-60, 60; 60, -60]),
        Line(points=[-100, 0; -60, 0]),
        Line(points=[60, 0; 100, 0])));
  equation 
    [der(x); xn] = [x1dot; x];
    [u] = transpose([a])*[x1dot; x];
    [y] = transpose([zeros(na - nb, 1); b])*[x1dot; x];
  end TransferFunction;
  
  block StateSpace "Linear state space system" 
    parameter Real A[:, size(A, 1)]=[1, 0; 0, 1] 
      "Matrix A of state space model";
    parameter Real B[size(A, 1), :]=[1; 1] "Matrix B of state space model";
    parameter Real C[:, size(A, 1)]=[1, 1] "Matrix C of state space model";
    parameter Real D[size(C, 1), size(B, 2)]=zeros(size(C, 1), size(B, 2)) 
      "Matrix D of state space model";
    
    extends Interfaces.MIMO(final nin=size(B, 2), final nout=size(C, 1));
    output Real x[size(A, 1)] "State vector";
    annotation(
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.2,
        y=0.03,
        width=0.64,
        height=0.73),
      Documentation(info="<html>
<p>
The State Space block defines the relation
between the input u=inPort.signal and the output
y=outPort.signal in state space form:
</p>

<pre>

    der(x) = A * x + B * u
        y  = C * x + D * u

</pre>

<p>
The input is a vector of length nu, the output is a vector
of length ny and nx is the number of states. Accordingly
</p>
<pre>
        A has the dimension: A(nx,nx),
        B has the dimension: B(nx,nu),
        C has the dimension: C(ny,nx),
        D has the dimension: D(ny,nu)
</pre>

<p>
Example:
</p>
<pre>
     parameter: A = [0.12, 2;3, 1.5]
     parameter: B = [2, 7;3, 1]
     parameter: C = [0.1, 2]
     parameter: D = zeros(ny,nu)
results in the following equations:

  [der(x[1])]   [0.12  2.00] [x[1]]   [2.0  7.0] [u[1]]
  [         ] = [          ]*[    ] + [        ]*[    ]
  [der(x[2])]   [3.00  1.50] [x[2]]   [0.1  2.0] [u[2]]

                             [x[1]]            [u[1]]
       y[1]   = [0.1  2.0] * [    ] + [0  0] * [    ]
                             [x[2]]            [u[2]]
</pre>
</HTML>
"),   Icon(
        Text(extent=[-90, 10; -10, 90], string="A"),
        Text(extent=[10, 10; 90, 90], string="B"),
        Text(extent=[-90, -10; -10, -90], string="C"),
        Text(extent=[10, -10; 90, -90], string="D"),
        Line(points=[0, -90; 0, 90], style(color=8)),
        Line(points=[-90, 0; 90, 0], style(color=8))),
      Diagram(
        Rectangle(extent=[-60, 60; 60, -60]),
        Text(
          extent=[-60, 40; 60, 0],
          string="sx=Ax+Bu",
          style(color=0)),
        Text(
          extent=[-60, 0; 60, -40],
          string=" y=Cx+Du",
          style(color=0)),
        Line(points=[-100, 0; -60, 0]),
        Line(points=[60, 0; 100, 0])));
  equation 
    der(x) = A*x + B*u;
    y = C*x + D*u;
  end StateSpace;
  
  block Der "Derivative of input (= analytic differentations)" 
    extends Interfaces.MIMOs;
    
    annotation( Icon(Text(extent=[-80, 76; 80, -82], string="der()")),
        Documentation(info="<HTML>
<p>
Defines that the output (= outPort.signal) is the <i>derivative</i>
of the input (=inPort.signal). Note, that Modelica.Blocks.Continuous.Derivative
computes the derivative in an approximate sense, where this block computes
the derivative exactly. This requires that the input signals are differentiated
by the Modelica translator, if these derivatives are not yet present in
the model.
</p>
</HTML>"));
  equation 
    for i in 1:n loop
      y[i] = der(u[i]);
    end for;
  end Der;
end Continuous;
