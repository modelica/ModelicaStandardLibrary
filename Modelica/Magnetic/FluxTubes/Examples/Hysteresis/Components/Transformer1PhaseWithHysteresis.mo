within Modelica.Magnetic.FluxTubes.Examples.Hysteresis.Components;
model Transformer1PhaseWithHysteresis
  "Single-phase transformer with ferromagnetic core and hysteresis"

  Modelica.Electrical.Analog.Interfaces.NegativePin n1 "Negative pin of primary winding" annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}), iconTransformation(extent={{-110,-110},{-90,-90}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p1 "Positive pin of primary winding" annotation (Placement(transformation(extent={{-110,90},{-90,110}}), iconTransformation(extent={{-110,90},{-90,110}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n2 "Negative pin of secondary winding" annotation (Placement(transformation(extent={{90,-110},{110,-90}}), iconTransformation(extent={{90,-110},{110,-90}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p2 "Positive pin of secondary winding" annotation (Placement(transformation(extent={{90,90},{110,110}}), iconTransformation(extent={{90,90},{110,110}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature tempSource annotation (Placement(transformation(extent={{-94,-54},{-86,-46}})));

  // Tab: Electrical //Group:Primary Winding
  parameter Integer N1=10 "Primary turns"
    annotation(Dialog(tab="Electrical", group="Primary winding"));
  parameter SI.Length L1(displayUnit="mm") = 1.2*2*(a+b)
    "Mean primary turn length"
    annotation(Dialog(tab="Electrical", group="Primary winding"));
  parameter SI.Length d1(displayUnit="mm") = 0.5e-3
    "Wire diameter of primary turns"
    annotation(Dialog(tab="Electrical", group="Primary winding"));
  parameter SI.Resistivity rho1 = 1.678e-8
    "Resistivity of primary winding (at 20degC)"
    annotation(Dialog(tab="Electrical", group="Primary winding"));
  parameter SI.LinearTemperatureCoefficient alpha1 = 0
    "Temperature coefficient of primary turns" annotation(Dialog(tab="Electrical", group="Primary winding"));

  // Tab: Electrical //Group:Secondary Winding
  parameter Integer N2=10 "Secondary turns"
    annotation(Dialog(tab="Electrical", group="Secondary winding"));
  parameter SI.Length L2(displayUnit="mm") = L1
    "Mean secondary turn length"
    annotation(Dialog(tab="Electrical", group="Secondary winding"));
  parameter SI.Length d2(displayUnit="mm") = d1
    "Wire diameter of secondary turns"
    annotation(Dialog(tab="Electrical", group="Secondary winding"));
  parameter SI.Resistivity rho2 = rho1
    "Resistivity of secondary winding (at 20degC)"
    annotation(Dialog(tab="Electrical", group="Secondary winding"));

  parameter SI.LinearTemperatureCoefficient alpha2 = alpha1
    "Temperature coefficient of secondary turns" annotation(Dialog(tab="Electrical", group="Secondary winding"));

  parameter SI.Length l1(displayUnit="mm") = 40e-3
    "Mean Length l1 of core" annotation (Dialog(tab="Core", group="Geometry", groupImage="modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/Hysteresis/Components/Transformer1PhaseWithHysteresis/Core_SinglePhase.png"));
  parameter SI.Length l2(displayUnit="mm") = 60e-3
    "Mean Length l2 of core" annotation (Dialog(tab="Core", group="Geometry"));
  parameter SI.Length a(displayUnit="mm") = 15e-3 "Height of core" annotation (Dialog(tab="Core", group="Geometry"));
  parameter SI.Length b(displayUnit="mm") = 10e-3 "Width of core" annotation (Dialog(tab="Core", group="Geometry"));

  //
  parameter FluxTubes.Material.HysteresisEverettParameter.BaseData mat=
      FluxTubes.Material.HysteresisEverettParameter.BaseData()
    "Parameter set of ferromagnetic Hysteresis" annotation (Dialog(tab="Core",
        group="Material"), choicesAllMatching=true);

  output SI.Voltage v1 "Primary voltage drop";
  output SI.Voltage v2 "Secondary voltage drop";

  output SI.Resistance R1 "Primary resistance of Winding";
  output SI.Resistance R2 "Secondary resistance of Winding";

  output SI.Current i1 "Primary current";
  output SI.Current i2 "Secondary current";

  output SI.MagneticFluxDensity B "Magnetic Flux Density of Core";
  output SI.MagneticFieldStrength Hstat
    "Ferromagnetic portion of magnetic field strength";
  output SI.MagneticFieldStrength Heddy
    "Eddy current portion of magnetic field strength";
  output SI.MagneticFieldStrength H
    "Total magnetic field strength of core";

  //output SI.Resistance R1

  parameter Real MagRelStart=0 "Initial magnetization of Core (-1..1)"
    annotation (Dialog(tab="Core", group="Initialization"));
  parameter Boolean MagRelFixed = false "Fixed" annotation (Dialog(tab="Core", group="Initialization"),choices(checkBox=true));

  parameter SI.MagneticFieldStrength HStart=0
    "Initial magnetic field strength of Core"
    annotation (Dialog(tab="Core", group="Initialization"));
  parameter Boolean HFixed = false "Fixed"
    annotation (Dialog(tab="Core", group="Initialization"),choices(checkBox=true));
  parameter SI.ElectricCurrent I1Start=0
    "Initial primary current through winding" annotation (Dialog(tab="Core", group="Initialization"));
  parameter Boolean I1Fixed = false "Fixed" annotation (Dialog(tab="Core", group="Initialization"),choices(checkBox=true));

  output SI.Power LossPowerWinding "Winding losses";
  output SI.Power LossPowerStat "Ferromagnetic hysteresis losses";
  output SI.Power LossPowerEddy "Eddy current losses";

  extends Interfaces.ConditionalHeatPort;
  parameter Boolean EddyCurrents = false "Enable eddy currents"
    annotation(Dialog(tab="Losses and heat", group="Eddy currents"), choices(checkBox=true));
  parameter SI.Conductivity sigma = mat.sigma
    "Conductivity of core material" annotation (Dialog(tab="Losses and heat", group="Eddy currents", enable=EddyCurrents));
  parameter SI.Length t(displayUnit="mm") = 0.5e-3
    "Thickness of lamination" annotation (Dialog(tab="Losses and heat", group="Eddy currents", enable=EddyCurrents));
  parameter SI.Length L_l1=10e-3 "Length of leakage of primary Winding" annotation (Dialog(tab="Leakage"));
  parameter SI.Area A_l1=10e-6
    "Cross section of leakage of primary Winding" annotation (Dialog(tab="Leakage"));
  parameter Real mu_rel1=1
    "Constant relative permeability of primary leakage (>0 required)" annotation (Dialog(tab="Leakage"));
  parameter SI.Length L_l2=10e-3
    "Length of leakage of secondary Winding" annotation (Dialog(tab="Leakage"));
  parameter SI.Area A_l2=10e-6
    "Cross section of leakage of secondary Winding" annotation (Dialog(tab="Leakage"));
  parameter Real mu_rel2=1
    "Constant relative permeability of secondary leakage (>0 required)" annotation (Dialog(tab="Leakage"));

protected
  Basic.Ground ground
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Basic.ElectroMagneticConverterWithLeakageInductance winding1(
    N=N1,
    L=L_l1,
    A=A_l1,
    mu_rel=mu_rel1,
    i(start=I1Start, fixed=I1Fixed)) annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Basic.ElectroMagneticConverterWithLeakageInductance winding2(
    N=N2,
    L=L_l2,
    mu_rel=mu_rel2,
    A=A_l2) annotation (Placement(transformation(extent={{60,-20},{40,0}})));

  Modelica.Electrical.Analog.Basic.Resistor resistor1(
    R=rho1*N1*L1/(pi/4*d1^2),
    useHeatPort=true,
    alpha=alpha1,
    T_ref=293.15) annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor2(
    R=rho2*N2*L2/(pi/4*d2^2),
    useHeatPort=true,
    alpha=alpha2,
    T_ref=293.15) annotation (Placement(transformation(extent={{70,-10},{90,10}})));

public
  Shapes.HysteresisAndMagnets.GenericHystTellinenEverett core(
    mat=mat,
    l=2*(l1 + l2),
    A=a*b,
    includeEddyCurrents=EddyCurrents,
    sigma=sigma,
    d=t,
    H(start=HStart, fixed=HFixed),
    MagRel(start=MagRelStart, fixed=MagRelFixed))
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
equation
  v1 =p1.v - n1.v;
  i1 =resistor1.i;
  R1 =resistor1.R_actual;

  v2 =p2.v - n2.v;
  i2 =resistor2.i;
  R2 =resistor2.R_actual;

  B =core.B;
  Hstat =core.Hstat;
  Heddy =core.Heddy;
  H =core.H;
  //der(MagRel)=0;

  tempSource.T = if useHeatPort then T_heatPort else T;

  LossPowerWinding =resistor1.LossPower + resistor2.LossPower;
                                                  //AvgWinding.y;
  LossPowerStat =core.LossPowerStat;
  LossPowerEddy =core.LossPowerEddy;
  LossPower = LossPowerWinding + LossPowerEddy + LossPowerStat;

  connect(winding1.port_n, ground.port) annotation (Line(points={{-40,-20},{-40,-30},{0,-30}}, color={255,127,0}));
  connect(resistor1.n, winding1.p) annotation (Line(points={{-70,0},{-60,0}}, color={0,0,255}));
  connect(resistor1.p, p1) annotation (Line(points={{-90,0},{-100,0},{-100,100}}, color={0,0,255}));
  connect(resistor2.n, p2) annotation (Line(points={{90,0},{100,0},{100,100}}, color={0,0,255}));
  connect(winding1.n, n1) annotation (Line(points={{-60,-19.8},{-60,-100},{-100,-100}}, color={0,0,255}));
  connect(tempSource.port, resistor1.heatPort) annotation (Line(points={{-86,-50},{-80,-50},{-80,-10}}, color={191,0,0}));
  connect(resistor2.heatPort, tempSource.port) annotation (Line(points={{80,-10},{80,-50},{-86,-50}}, color={191,0,0}));
  connect(winding2.port_n, ground.port) annotation (Line(points={{40,-20},{40,-30},{0,-30}}, color={255,127,0}));
  connect(winding2.n, resistor2.p) annotation (Line(points={{60,-19.8},{70,-19.8},{70,0}}, color={0,0,255}));
  connect(n2, winding2.p) annotation (Line(points={{100,-100},{94,-100},{94,20},{60,20},{60,0}}, color={0,0,255}));
  connect(core.port_p, winding1.port_p) annotation (Line(points={{-10,10},{-40,10},{-40,0}}, color={255,127,0}));
  connect(core.port_n, winding2.port_p) annotation (Line(points={{10,10},{40,10},{40,0}}, color={255,127,0}));
  annotation (defaultComponentName="transformer", Icon(graphics={
        Polygon(
          points={{50,60},{30,40},{30,-40},{50,-60},{50,60}},
          fillColor={255,128,0},
          fillPattern=FillPattern.VerticalCylinder),
        Polygon(
          points={{-50,60},{-30,40},{-30,-40},{-50,-60},{-50,60}},
          fillColor={255,128,0},
          fillPattern=FillPattern.VerticalCylinder),
        Rectangle(
          extent={{-68,36},{-12,-36}},
          lineColor={0,128,255},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,128,255}),
        Rectangle(
          extent={{20,20},{60,-20}},
          lineColor={128,0,255},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={128,0,255}),
        Text(
          extent={{150,150},{-150,110}},
          textColor={0,0,255},
          textString="%name"),
        Polygon(
          points={{-10,60},{10,40},{10,-20},{-10,-40},{-10,60}},
          fillColor={255,128,0},
          fillPattern=FillPattern.VerticalCylinder,
          origin={10,-50},
          rotation=90),
        Polygon(
          points={{-10,20},{-30,0},{-30,-60},{-10,-80},{-10,-44.0625},{-10,20}},
          fillColor={255,128,0},
          fillPattern=FillPattern.VerticalCylinder,
          origin={-30,70},
          rotation=90),
        Line(points={{-100,90},{-100,36},{-68,36}}, color={0,0,255}),
        Line(points={{-100,-90},{-100,-36},{-68,-36}}, color={0,0,255}),
        Line(points={{100,-90},{100,-20},{60,-20}}, color={0,0,255}),
        Line(points={{100,90},{100,20},{60,20}}, color={0,0,255})}),
    Documentation(info="<html>
<p>
Simple model of a single-phase transformer with a primary and a secondary winding and a magnetic core. The core is modeled with <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenEverett\">GenericHystTellinenEverett</a> flux tube elements. Thus, this element considers static and dynamic hysteresis.
</p>

<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <caption><strong>Fig. 1:</strong> Sketch of the modelled transformer with magnetic core, primary and secondary winding</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/Hysteresis/Components/Transformer1PhaseWithHysteresis/Core_SinglePhase.png\">
   </td>
  </tr>
</table>

</html>"));
end Transformer1PhaseWithHysteresis;
