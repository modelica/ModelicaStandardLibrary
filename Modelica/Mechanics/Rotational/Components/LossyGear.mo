within Modelica.Mechanics.Rotational.Components;
model LossyGear
  "Gear with mesh efficiency and bearing friction (stuck/rolling possible)"

  extends Modelica.Mechanics.Rotational.Icons.Gear;
  extends Modelica.Mechanics.Rotational.Interfaces.PartialElementaryTwoFlangesAndSupport2;

  import Modelica.Blocks.Types.{ExternalCombiTable1D, Extrapolation, Smoothness};
  import Modelica.Blocks.Tables.Internal.{getTable1DValue, getTable1DValueNoDer, getTable1DValueNoDer2};

  parameter Real ratio(start=1)
    "Transmission ratio (flange_a.phi/flange_b.phi)";
  parameter Real lossTable[:, 5]=[0, 1, 1, 0, 0]
    "Array for mesh efficiencies and bearing friction depending on speed";
  parameter Smoothness smoothness = Smoothness.LinearSegments
    "Smoothness of interpolation in lossTable table";
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
  SI.Angle phi_a
    "Angle between left shaft flange and support";
  SI.Angle phi_b
    "Angle between right shaft flange and support";

  Real sa(final unit="1") "Path parameter for acceleration and torque loss";
  SI.AngularVelocity w_a
    "Angular velocity of flange_a with respect to support";
  SI.AngularAcceleration a_a
    "Angular acceleration of flange_a with respect to support";

  Real interpolation_result[1, 4]
    "Result of interpolation in lossTable (= [eta_mf1, eta_mf2, tau_bf1, tau_bf2])";
  Real eta_mf1(unit="1") "Mesh efficiency in case that flange_a is driving";
  Real eta_mf2(unit="1") "Mesh efficiency in case that flange_b is driving";
  SI.Torque tau_bf_a "Bearing friction torque on flange_a side";
  SI.Torque tau_eta
    "Torque that determines the driving side (= if forwardSliding then flange_a.tau-tau_bf_a else if backwardSliding then flange_a.tau+tau_bf_a else flange_a.tau)";

  SI.Torque tau_bf1
    "Absolute resultant bearing friction torque with respect to flange_a in case that flange_a is driving (= |tau_bf_a*eta_mf1 + tau_bf_b/i|)";
  SI.Torque tau_bf2
    "Absolute resultant bearing friction torque with respect to flange_a in case that flange_b is driving (= |tau_bf_a/eta_mf2 + tau_bf_b/i|)";

  SI.Torque quadrant1 "Torque loss if w_a > 0 and flange_a.tau >= 0";
  SI.Torque quadrant2 "Torque loss if w_a > 0 and flange_a.tau < 0";
  SI.Torque quadrant3 "Torque loss if w_a < 0 and flange_a.tau >= 0";
  SI.Torque quadrant4 "Torque loss if w_a < 0 and flange_a.tau < 0";

  // Resultant friction torques at quadrant values for angular velocities near zero
  SI.Torque quadrant1_p
    "Torque loss at w_a = 0+ to determine driving side (flange_a.tau >= 0)";
  SI.Torque quadrant2_p
    "Torque loss at w_a = 0+ to determine driving side (flange_a.tau < 0)";
  SI.Torque quadrant3_m
    "Torque loss at w_a = 0- to determine driving side (flange_a.tau >=0)";
  SI.Torque quadrant4_m
    "Torque loss at w_a = 0- to determine driving side (flange_a.tau < 0)";

  SI.Torque tauLoss
    "Torque loss due to friction in the gear teeth and in the bearings";
  SI.Torque tauLossMax "Torque loss for positive speed";
  SI.Torque tauLossMin "Torque loss for negative speed";

  SI.Torque tauLossMax_p "Torque loss for positive speed";
  SI.Torque tauLossMin_m "Torque loss for negative speed";

  Boolean tau_aPos(start=true)
    "Only for backwards compatibility (was previously: true, if torque of flange_a is not negative)";
  Boolean tau_etaPos(start=true) "= true, if torque tau_eta is not negative";
  Boolean startForward(start=false) "= true, if starting to roll forward";
  Boolean startBackward(start=false) "= true, if starting to roll backward";
  Boolean locked(start=false) "= true, if gear is locked";

  Boolean ideal
    "= true, if losses are neglected (that is lossTable = [0, 1, 1, 0, 0])";

  constant Integer Unknown=3 "Value of mode is not known";
  constant Integer Free=2 "Element is not active";
  constant Integer Forward=1 "w_a > 0 (forward rolling)";
  constant Integer Stuck=0
    "w_a = 0 (forward rolling, locked or backward rolling)";
  constant Integer Backward=-1 "w_a < 0 (backward rolling)";
  Integer mode(
    final min=Backward,
    final max=Unknown,
    start=Free,
    fixed=true)
    "Mode of friction element (unknown, not active, forward/backward rolling, stuck)";

  SI.Torque tau_eta_p "tau_eta assuming positive omega";
  SI.Torque tau_eta_m "tau_eta assuming negative omega";
protected
  constant SI.AngularAcceleration unitAngularAcceleration=1;
  constant SI.Torque unitTorque=1;

  // get friction and eta information for omega=0
  parameter Real eta_mf1_0(unit="1")=
    if     smoothness == Smoothness.ConstantSegments then getTable1DValueNoDer(tableID, 1, 0)
    elseif smoothness == Smoothness.LinearSegments   then getTable1DValueNoDer2(tableID, 1, 0)
    else                                                  getTable1DValue(tableID, 1, 0);
  parameter Real eta_mf2_0(unit="1")=
    if     smoothness == Smoothness.ConstantSegments then getTable1DValueNoDer(tableID, 2, 0)
    elseif smoothness == Smoothness.LinearSegments   then getTable1DValueNoDer2(tableID, 2, 0)
    else                                                  getTable1DValue(tableID, 2, 0);
  parameter SI.Torque tau_bf1_0 = abs(
    if     smoothness == Smoothness.ConstantSegments then getTable1DValueNoDer(tableID, 3, 0)
    elseif smoothness == Smoothness.LinearSegments   then getTable1DValueNoDer2(tableID, 3, 0)
    else                                                  getTable1DValue(tableID, 3, 0));
  parameter SI.Torque tau_bf2_0 = abs(
    if     smoothness == Smoothness.ConstantSegments then getTable1DValueNoDer(tableID, 4, 0)
    elseif smoothness == Smoothness.LinearSegments   then getTable1DValueNoDer2(tableID, 4, 0)
    else                                                  getTable1DValue(tableID, 4, 0));
  parameter SI.Torque tau_bf_a_0=if Modelica.Math.isEqual(
          eta_mf1_0,
          1.0,
          Modelica.Constants.eps) and Modelica.Math.isEqual(
          eta_mf2_0,
          1.0,
          Modelica.Constants.eps) then tau_bf1_0/2 else (tau_bf1_0 -
      tau_bf2_0)/(eta_mf1_0 - 1.0/eta_mf2_0);
  // For eta_mf1_0=eta_mf2_0=1 the given bearing
  // friction can not be separated into a part
  // on side A or B, so it is done arbitrarily.
  // Calculate tau_bf_a_0 from the following equations
  //  tau_bf1_0=eta_mf1_0*tau_bf_a_0 + 1/ratio a_0
  //  tau_bf2_0=1/eta_mf2*tau_bf_a_0 + 1/ratio tau_bf_a_0

  final parameter ExternalCombiTable1D tableID = ExternalCombiTable1D(
    tableName="NoName",
    fileName="NoName",
    table=lossTable,
    columns={2,3,4,5},
    smoothness=smoothness,
    extrapolation=Extrapolation.LastTwoPoints,
    verboseRead=false) "External table object for sliding friction coefficient";

equation
  assert(abs(ratio) > 0,
    "Error in initialization of LossyGear: ratio may not be zero");
  assert(size(lossTable, 1) > 0 and size(lossTable, 2) > 0, "Parameter lossTable is an empty matrix");

  ideal = Modelica.Math.Matrices.isEqual(
        lossTable,
        [0, 1, 1, 0, 0],
        Modelica.Constants.eps);

  if ideal then
    interpolation_result = [1, 1, 0, 0];
    eta_mf1 = 1;
    eta_mf2 = 1;
    tau_bf1 = 0;
    tau_bf2 = 0;
  else
    for i in 1:size(interpolation_result,2) loop
      interpolation_result[1, i] =
        if     smoothness == Smoothness.ConstantSegments then getTable1DValueNoDer(tableID, i, noEvent(abs(w_a)))
        elseif smoothness == Smoothness.LinearSegments   then getTable1DValueNoDer2(tableID, i, noEvent(abs(w_a)))
        else                                                  getTable1DValue(tableID, i, noEvent(abs(w_a)));
    end for;
    eta_mf1 = interpolation_result[1, 1];
    eta_mf2 = interpolation_result[1, 2];
    tau_bf1 = noEvent(abs(interpolation_result[1, 3]));
    tau_bf2 = noEvent(abs(interpolation_result[1, 4]));
  end if;

  if Modelica.Math.isEqual(
          eta_mf1,
          1.0,
          Modelica.Constants.eps) and Modelica.Math.isEqual(
          eta_mf2,
          1.0,
          Modelica.Constants.eps) then
    // For eta_mf1=eta_mf2=1 the given bearing friction can not be
    // separated into a part on side A or B, so it is done arbitrarily.
    tau_bf_a = tau_bf1/2;
  else
    //calculate tau_bf_a from the following equations
    //tau_bf1 = eta_mf1*tau_bf_a + tau_bf_b / ratio
    //tau_bf2 = 1/eta_mf2*tau_bf_a + tau_bf_b / ratio
    tau_bf_a = (tau_bf1 - tau_bf2)/(eta_mf1 - 1.0/eta_mf2);
  end if;

  phi_a = flange_a.phi - phi_support;
  phi_b = flange_b.phi - phi_support;
  phi_a = ratio*phi_b;

  // Torque balance (no inertias)
  0 = flange_b.tau + ratio*(flange_a.tau - tauLoss);

  // Speed for friction element
  w_a = der(phi_a);
  a_a = der(w_a);

  // Determine driving side
  //assuming positive omega
  tau_eta_p = flange_a.tau - tau_bf_a_0;
  //assuming negative omega
  tau_eta_m = flange_a.tau + tau_bf_a_0;

  // assuming w>=0, take value at w=0 to decide rolling/stuck mode
  quadrant1_p = (1 - eta_mf1_0)*flange_a.tau + tau_bf1_0;
  quadrant2_p = (1 - 1/eta_mf2_0)*flange_a.tau + tau_bf2_0;
  tauLossMax_p = if noEvent(tau_eta_p > 0) then quadrant1_p else
    quadrant2_p;

  // assuming w<=0, take value at w=0 to decide rolling/stuck mode
  quadrant4_m = (1 - 1/eta_mf2_0)*flange_a.tau - tau_bf2_0;
  quadrant3_m = (1 - eta_mf1_0)*flange_a.tau - tau_bf1_0;
  tauLossMin_m = if noEvent(tau_eta_m > 0) then quadrant4_m else
    quadrant3_m;

  quadrant1 = (1 - eta_mf1)*flange_a.tau + tau_bf1;
  quadrant2 = (1 - 1/eta_mf2)*flange_a.tau + tau_bf2;
  quadrant4 = (1 - 1/eta_mf2)*flange_a.tau - tau_bf2;
  quadrant3 = (1 - eta_mf1)*flange_a.tau - tau_bf1;

  //tau eta: only for determination of driving side for calculation of tauloss
  tau_eta = if ideal then flange_a.tau else (if locked then flange_a.tau
     else (if (startForward or pre(mode) == Forward) then flange_a.tau -
    tau_bf_a else flange_a.tau + tau_bf_a));

  // Torque Losses
  tau_etaPos = tau_eta >= 0;
  tau_aPos = tau_etaPos;
  tauLossMax = if tau_etaPos then quadrant1 else quadrant2;
  tauLossMin = if tau_etaPos then quadrant4 else quadrant3;

  // Determine rolling/stuck mode when w_a = 0
  startForward = pre(mode) == Stuck and sa > tauLossMax_p/unitTorque or
    initial() and w_a > 0;
  startBackward = pre(mode) == Stuck and sa < tauLossMin_m/unitTorque or
    initial() and w_a < 0;
  locked = not (ideal or pre(mode) == Forward or startForward or pre(mode)
     == Backward or startBackward);

  /* Parameterized curve description a_a = f1(sa), tauLoss = f2(sa)
       In comparison to Modelica.Mechanics.Rotational.FrictionBase it is possible
       to simplify the following expression as mode == Stuck is assured in case
       of startForward or startBackward */
  tauLoss = if ideal then 0 else (if locked then sa*unitTorque else (if (
    startForward or pre(mode) == Forward) then tauLossMax else tauLossMin));

  a_a = unitAngularAcceleration*(if locked then 0 else sa - tauLoss/
    unitTorque);

  /* Finite state machine to fix configuration after the computation above
       The above equations are only dependent on pre(mode) and not on the actual
       value of mode. This prevents loops. So mode can be determined in one step. */
  mode = if ideal then Free else (if (pre(mode) == Forward or startForward)
     and w_a > 0 then Forward else if (pre(mode) == Backward or
    startBackward) and w_a < 0 then Backward else Stuck);

  lossPower = tauLoss*w_a;
  annotation (
    Documentation(info="<html>
<p>
This component models the gear ratio and the <strong>losses</strong> of
a standard gear box in a <strong>reliable</strong> way including the stuck phases
that may occur at zero speed. The gear boxes that can
be handled are fixed in the ground or on a moving support, have one input and one
output shaft, and are essentially described by the equations:
</p>
<blockquote><pre>
             flange_a.phi  = i*flange_b.phi;
-(flange_b.tau - tau_bf_b) = i*eta_mf*(flange_a.tau - tau_bf_a);

// or        -flange_b.tau = i*eta_mf*(flange_a.tau - tau_bf_a - tau_bf_b/(i*eta_mf));
</pre></blockquote>
<p>
where
</p>

<ul>
<li> <strong>i</strong> is the constant <strong>gear ratio</strong>,</li>

<li> <strong>eta_mf</strong> = eta_mf(w_a) is the <strong>mesh efficiency</strong> due to the
     friction between the teeth of the gear wheels,</li>

<li> <strong>tau_bf_a</strong> = tau_bf_a(w_a) is the <strong>bearing friction torque</strong>
     on the flange_a side,</li>

<li> <strong>tau_bf_b</strong> = tau_bf_b(w_a) is the <strong>bearing friction torque</strong>
     on the flange_b side, and</li>

<li><strong>w_a</strong> = der(flange_a.phi) is the speed of flange_a</li>
</ul>

<p>
The loss terms \"eta_mf\", \"tau_bf_a\" and \"tau_bf_b\" are functions of the
<em>absolute value</em> of the input shaft speed w_a and of the energy
flow direction. They are defined by parameter <strong>lossTable[:,5]
</strong> where the columns of this table have the following
meaning:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tbody>
    <tr>
      <td>|w_a|</td>
      <td>eta_mf1</td>
      <td>eta_mf2</td>
      <td>|tau_bf1|</td>
      <td>|tau_bf2|</td>
    </tr>
    <tr>
      <td align=\"center\">&hellip;</td>
      <td align=\"center\">&hellip;</td>
      <td align=\"center\">&hellip;</td>
      <td align=\"center\">&hellip;</td>
      <td align=\"center\">&hellip;</td>
    </tr>
    <tr>
      <td align=\"center\">&hellip;</td>
      <td align=\"center\">&hellip;</td>
      <td align=\"center\">&hellip;</td>
      <td align=\"center\">&hellip;</td>
      <td align=\"center\">&hellip;</td>
    </tr>
  </tbody>
</table>

<p>with</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tbody>
    <tr>
      <td>|w_a|</td>
      <td>Absolute value of angular velocity of input shaft flange_a</td>
    </tr>
    <tr>
      <td>eta_mf1</td>
      <td>Mesh efficiency in case that flange_a is driving</td>
    </tr>
    <tr>
      <td>eta_mf2</td>
      <td>Mesh efficiency in case that flange_b is driving</td>
    </tr>
    <tr>
      <td>|tau_bf1|</td>
      <td> Absolute resultant bearing friction torque with respect to flange_a
                        in case that flange_a is driving<br>
                        (= |tau_bf_a*eta_mf1 + tau_bf_b/i|)
                        </td>
    </tr>
    <tr>
      <td>|tau_bf2|</td>
      <td> Absolute resultant bearing friction torque with respect to flange_a
                        in case that flange_b is driving<br>
                        (= |tau_bf_a/eta_mf2 + tau_bf_b/i|)
                        </td>
    </tr>
  </tbody>
</table>
<p>
With these variables, the mesh efficiency and the bearing friction
are formally defined as:
</p>

<blockquote><pre>
<strong>if</strong> (flange_a.tau - tau_bf_a)*w_a &gt; 0 <strong>or</strong>
   (flange_a.tau - tau_bf_a) == 0 <strong>and</strong> w_a &gt; 0 <strong>then</strong>
   eta_mf := eta_mf1
   tau_bf := tau_bf1
<strong>elseif</strong> (flange_a.tau - tau_bf_a)*w_a &lt; 0 <strong>or</strong>
       (flange_a.tau - tau_bf_a) == 0 <strong>and</strong> w_a &lt; 0 <strong>then</strong>
   eta_mf := 1/eta_mf2
   tau_bf := tau_bf2
<strong>else</strong> // w_a == 0
   eta_mf and tau_bf are computed such that <strong>der</strong>(w_a) = 0
<strong>end if</strong>;
-flange_b.tau = i*(eta_mf*flange_a.tau - tau_bf);
</pre></blockquote>

<p>
Note, that the losses are modeled in a physically meaningful way taking
into account that at zero speed the movement may be locked due
to the friction in the gear teeth and/or in the bearings.
Due to this important property, this component can be used in
situations where the combination of the components
Modelica.Mechanics.Rotational.IdealGear and
Modelica.Mechanics.Rotational.GearEfficiency will fail because,
e.g., chattering occurs when using the
Modelica.Mechanics.Rotational.GearEfficiency model.
</p>

<h4>Acknowledgement</h4>
<ul>
<li> The essential idea to model efficiency
     in this way is from Christoph Pelchen, ZF Friedrichshafen.</li>
<li> The article (Pelchen et.al. 2002), see Literature below,
     and the first implementation of LossyGear (up to version 3.1 of package Modelica)
     contained a bug leading to a non-converging solution in cases where the
     driving side is not obvious.
     This was pointed out by Christian Bertsch and Max Westenkirchner, Bosch,
     and Christian Bertsch proposed a concrete solution how to fix this
     bug, see Literature below.</li>
</ul>

<h4>Literature</h4>

<ul>
<li>Pelchen C.,
Schweiger C.,
and <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Otter M.</a>:
&quot;<a href=\"https://www.modelica.org/events/Conference2002/papers/p33_Pelchen.pdf\">Modeling
and Simulating the Efficiency of Gearboxes and of Planetary Gearboxes</a>,&quot; in
<em>Proceedings of the 2nd International Modelica Conference, Oberpfaffenhofen, Germany,</em>
pp. 257-266, The Modelica Association and Institute of Robotics and Mechatronics,
Deutsches Zentrum f&uuml;r Luft- und Raumfahrt e. V., March 18-19, 2002.</li>

<li>Bertsch C. (2009):
&quot;<a href=\"modelica://Modelica/Resources/Documentation/Mechanics/Lossy-Gear-Bug_Solution.pdf\">Problem
with model LossyGear and a proposed solution</a>&quot;,
Ticket <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/108\">#108</a>,
Sept. 11, 2009.</li>
</ul>

</html>"),
       Icon(
    coordinateSystem(preserveAspectRatio=true,
        extent={{-100.0,-100.0},{100.0,100.0}}),
    graphics={
    Polygon(fillColor={161,35,41},
      pattern=LinePattern.None,
      fillPattern=FillPattern.Solid,
      points={{-110,50},{-80,50},{-80,80},{-90,80},{-70,100},{-50,80},{-60,80},{-60,30},{-110,30},{-110,50}}),
    Line(points={{-80.0,20.0},{-60.0,20.0}}),
    Text(textColor={0,0,255},
      extent={{-148.0,105.0},{152.0,145.0}},
      textString="%name"),
    Text(extent={{-145.0,-79.0},{155.0,-49.0}},
      textString="ratio=%ratio"),
    Line(visible=useHeatPort,
      points={{-100.0,-100.0},{-100.0,-30.0},{0.0,-30.0},{0.0,0.0}},
      color={191,0,0},
      pattern=LinePattern.Dot)}));
end LossyGear;
