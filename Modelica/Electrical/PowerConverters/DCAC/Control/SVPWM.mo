within Modelica.Electrical.PowerConverters.DCAC.Control;
block SVPWM "Space vector pulse width modulation"
  parameter SI.Frequency f "Switching frequency";
  extends Modelica.Blocks.Interfaces.DiscreteBlock(final samplePeriod=1/f);
  import Modelica.Constants.small;
  import Modelica.Constants.eps;
  import Modelica.Constants.pi;
  import Modelica.Math.atan2;
  constant Integer m=3 "Number of phases";
  parameter Real uMax "Maximum length of space vector = half diagonal of hexagon";
  constant Boolean fire[6,m]=[true, false,false;
                              true, true, false;
                              false,true, false;
                              false,true, true;
                              false,false,true;
                              true, false,true] "Switching patterns";
  Modelica.Blocks.Interfaces.RealInput u[2] "Reference space phasor"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput fire_p[m] "Positive fire signal"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.BooleanOutput fire_n[m] "Negative fire signal"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
protected
  discrete Real uRef(start=0, fixed=true) "Length of reference vector";
  discrete SI.Angle phiRef(start=0, fixed=true) "Angle of reference vector within (-pi, +pi]";
  discrete SI.Angle phiPos(start=0, fixed=true) "Angle of reference vector within [0, 2*pi)";
  Integer ka(start=0, fixed=true), kb(start=0, fixed=true) "Switching patterns limiting the sector";
  discrete SI.Angle phiSec(start=0, fixed=true) "Angle of reference vector within sector within [0, pi/m)";
  discrete Real ta(start=0, fixed=true), tb(start=0, fixed=true), t0(start=1, fixed=true) "Relative time spans of vectors a, b, and 0";
  discrete SI.Time T0(start=startTime, fixed=true) "Start time of switching interval";
algorithm
  when sampleTrigger then
    //Limited relative reference signal
    uRef:=min(sqrt(u[1]^2 + u[2]^2)/(2/3*uMax), cos(pi/6));
    //Determine angle of reference signal within (-pi, +pi]
    phiRef:=if uRef < small then 0 else atan2(u[2], u[1]);
    //Shift angle to [0, 2*pi)
    // Note that phiRef is likely to be very close to zero, so the extra logic ensures that
    // we do not get values at 2*pi since that will look odd.
    phiPos:=max(0, phiRef + (if phiRef < -2*pi*Modelica.Constants.eps then 2*pi else 0));
    //Determine sector and neighbour sector
    ka:=min(integer(phiPos/(pi/m)), 2*m-1); // The min guards against roundoff
    kb:=mod(ka+1, 2*m);
    //Determine angle within sector in the range of [0, pi/m)
    phiSec:=phiPos - ka*pi/m;
    //Determine limited relative time spans
    //uRef*cos(phiSec)=tb*cos(pi/m) + ta;
    //uRef*sin(phiSec)=tb*sin(pi/m);
    tb:=min(uRef*sin(phiSec)/sin(pi/m), 1);
    ta:=min(uRef*cos(phiSec) - tb*cos(pi/m), 1);
    t0:=max(1 - ta - tb, 0);
    //Remember start time of switching interval
    T0:=time;
  end when;
equation
  //Distribute switching patterns t0/4 + ta/2 + tb/2 + t0/2 + tb/2 + ta/2 + t0/4
  if time<startTime then
    fire_p= fill(true, m);
  elseif time < T0 + samplePeriod * (t0/4) then
    fire_p= fill(false, m);
  elseif time < T0 + samplePeriod * (t0/4 + ta/2) then
    fire_p= fire[ka + 1, :];
  elseif time < T0 + samplePeriod * (t0/4 + ta/2 + tb/2) then
    fire_p= fire[kb + 1, :];
  elseif time < T0 + samplePeriod * (t0/4 + ta/2 + tb/2 + t0/2) then
    fire_p= fill(true, m);
  elseif time < T0 + samplePeriod * (t0/4 + ta/2 + tb/2 + t0/2 + tb/2) then
    fire_p= fire[kb + 1, :];
  elseif time < T0 + samplePeriod * (t0/4 + ta/2 + tb/2 + t0/2 + tb/2 + ta/2) then
    fire_p= fire[ka + 1, :];
  else
    fire_p= fill(false, m);
  end if;
  fire_n= not fire_p;
  annotation (defaultComponentName="svPWM", Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(points={{-80,30},{-36,30},{-36,50},{-10,50},{-10,30},{10,30},{10,50},
              {36,50},{36,30},{80,30}}, color={255,0,0}),
        Line(points={{-80,-10},{-70,-10},{-70,10},{-36,10},{-36,-10},{36,-10},{36,
              10},{70,10},{70,-10},{80,-10}}, color={0,0,255}),
        Line(points={{-80,-50},{-80,-30},{-70,-30},{-70,-50},{-10,-50},{-10,-30},
              {10,-30},{10,-50},{70,-50},{70,-30},{80,-30},{80,-50}}, color={0,0,
              0})}),    Documentation(info="<html>
<p>
For a three-phase system, 8 space vectors are available according to the following switching patterns:
</p>
<ul>
<li>0 [0,0,0] length 0</li>
<li>1 [1,0,0] 000&deg;</li>
<li>2 [1,1,0] 060&deg;</li>
<li>3 [0,1,0] 120&deg;</li>
<li>4 [0,1,1] 180&deg;</li>
<li>5 [0,0,1] 240&deg;</li>
<li>6 [1,0,1] 300&deg;</li>
<li>7 [1,1,1] length 0</li>
</ul>
<p>
Vector 1..6 form a hexagon, vector 0 and 7 are of length 0.
</p>
<p>
First, the space vector is limited,
and the sector of the hexagon is determined where the input space vector <u>u</u> is located;
then the angle of the space vector within this sector 0&le;&phi;&lt;60&deg; is calculated.
</p>
<p>
The input space vector is averaged by <u>u</u> = t<sub>a</sub>*<u>u</u><sub>a</sub> + t<sub>b</sub>*<u>u</u><sub>b</sub> + t<sub>0</sub>*0,
where <u>u</u><sub>a</sub> is the space vector at the left border of the sector
and <u>u</u><sub>b</sub> is the space vector at the right border of the sector.
If necessary, a zero length vector is applied additionally.
</p>
<p>
The relative time spans for averaging over one switching period are determined by the following equations:
</p>
<ul>
<li>Real part: <u>u</u>*cos(&phi;) = <u>u</u><sub>b</sub>*t<sub>b</sub>*cos(60&deg;) + <u>u</u><sub>a</sub>*t<sub>a</sub>*1</li>
<li>Imag.part: <u>u</u>*sin(&phi;) = <u>u</u><sub>b</sub>*t<sub>b</sub>*sin(60&deg;)</li>
<li>t<sub>a</sub> + t<sub>b</sub> + t<sub>0</sub> = 1</li>
</ul>
<p>
To obtain the positive fire signal, the switching time spans are distributed symmetrically:
t<sub>0</sub>/4 + t<sub>a</sub>/2 + t<sub>b</sub>/2 +t<sub>0</sub>/2 + t<sub>b</sub>/2 + t<sub>a</sub>/2 + t<sub>0</sub>/4
</p>
<p>
The switching pattern of the negative fire signal is just the inverse of the positive fire signal.
</p>
</html>"));
end SVPWM;
