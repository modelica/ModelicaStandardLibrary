within Modelica.Magnetic.FluxTubes.Basic;
model ElectroMagneticConverterWithLeakageInductance
  "Electromagnetic energy conversion with a leakage inductance"

  Magnetic.FluxTubes.Interfaces.PositiveMagneticPort port_p
    "Positive magnetic port" annotation (Placement(transformation(extent={{90,
            90},{110,110}}), iconTransformation(extent={{90,90},{110,110}})));
  Magnetic.FluxTubes.Interfaces.NegativeMagneticPort port_n
    "Negative magnetic port" annotation (Placement(transformation(extent={{110,
            -110},{90,-90}}), iconTransformation(extent={{110,-110},{90,-90}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p "Positive electrical pin"
    annotation (Placement(transformation(extent={{-90,90},{-110,110}}), iconTransformation(extent={{-90,90},{-110,110}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n "Negative electrical pin"
    annotation (Placement(transformation(extent={{-110,-108},{-90,-88}}), iconTransformation(extent={{-110,-108},{-90,-88}})));
  SI.Voltage v "Voltage";
  SI.Current i(start=0, stateSelect=StateSelect.prefer) "Current";
  SI.MagneticPotentialDifference V_m "Magnetic potential difference";
  SI.MagneticFlux Phi(stateSelect=StateSelect.never)
    "Total Magnetic flux coupled into magnetic circuit (= Phi_ind + Phi_leak)";
  SI.MagneticFlux Phi_ind(stateSelect=StateSelect.never)
    "Magnetic flux of converter";
  SI.MagneticFlux Phi_leak(stateSelect=StateSelect.never)
    "Magnetic flux of leakage inductance";
  parameter Real N(start=1, min=Modelica.Constants.eps) "Number of turns";

  parameter SI.Length L=10e-3 "Length in direction of flux"
    annotation (Dialog(tab="Leakage inductance"));
  parameter SI.Area A=10e-6 "Area of cross-section"
    annotation (Dialog(tab="Leakage inductance"));
  parameter SI.RelativePermeability mu_rel(min=Modelica.Constants.eps) = 1
    "Constant relative permeability of leakage inductance (> 0 required)"
    annotation (Dialog(tab="Leakage inductance"));
  final parameter SI.Permeance G_m=Modelica.Constants.mu_0*mu_rel*A/L
    "Magnetic permeance of leakage inductance";

  // For information only
  SI.MagneticFlux Psi "Flux linkage";
  SI.Inductance L_stat "Static inductance abs(Psi/i)";

protected
  constant Real eps=100*Modelica.Constants.eps;
equation
  v = p.v - n.v;
  0 = p.i + n.i;
  i = p.i;

  V_m = port_p.V_m - port_n.V_m;
  0 = port_p.Phi + port_n.Phi;
  Phi = port_p.Phi;

  // Converter equations
  V_m = i*N "Ampere's law";
  N*der(Phi_ind) = -v "Faraday's law";

  // Leakage equations
  Phi_leak = G_m*V_m;
  Phi = Phi_ind + Phi_leak;

  // For information only
  Psi = N*Phi_ind;
  //use of abs() for positive results; due to Modelica sign conventions for flow into connectors
  L_stat = noEvent(if abs(i) > eps then abs(Psi/i) else abs(Psi/eps));

  annotation (
    defaultComponentName="converter",
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={                    Polygon(
              points={{-136,103},{-126,100},{-136,97},{-136,103}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),Line(points={{-152,100},{-127,100}},
                color={160,160,164}),
                                Line(points={{-152,-100},{-127,-100}}, color={160,160,164}),
                         Polygon(
          points={{-142,-97},{-152,-100},{-142,-103},{-142,-97}},
          lineColor={160,160,164},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),    Text(
              extent={{-143,-96},{-126,-81}},
              textColor={160,160,164},
              textString="i"),Text(
              extent={{-152,103},{-135,118}},
              textColor={160,160,164},
              textString="i"),       Polygon(
              points={{143,-97},{153,-100},{143,-103},{143,-97}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),Line(points={{127,-100},{152,-100}},
          color={160,160,164}),Text(
              extent={{130,-96},{146,-81}},
              textColor={160,160,164},
              textString="Phi"),Text(
              extent={{130,102},{147,117}},
          textString="Phi",
          textColor={160,160,164}),
                              Line(points={{126,100},{151,100}}, color={160,160,164}),
          Polygon(
          points={{136,103},{126,100},{136,97},{136,103}},
          lineColor={160,160,164},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid)}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-30,100},{-90,100}},
                                         color={0,0,255}),
        Line(points={{-30,-100},{-90,-100}},
                                           color={0,0,255}),
        Ellipse(extent={{-4,-34},{64,34}}, lineColor={255,127,0}),
        Line(points={{30,-100},{30,0}},  color={255,127,0}),
        Line(points={{30,0},{30,100}}, color={255,127,0}),
        Line(points={{30,100},{90,100}},color={255,127,0}),
        Line(points={{30,-100},{90,-100}},
                                         color={255,127,0}),
        Text(
          extent={{-150,150},{150,110}},
          textColor={0,0,255},
          textString="%name"),
        Rectangle(
          extent={{72,28},{88,-24}},
          lineColor={255,128,0},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255}),
        Line(
          points={{80,28},{80,100}},
          color={255,128,0}),
        Line(
          points={{80,-24},{80,-100}},
          color={255,128,0}),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-23,45},
          rotation=270),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-23,15},
          rotation=270),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-23,-15},
          rotation=270),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-23,-45},
          rotation=270),
        Line(points={{-30,60},{-30,100}}, color={28,108,200}),
        Line(points={{-30,-100},{-30,-60}}, color={28,108,200})}),
    Documentation(info="<html>
<p>
Same as <a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter\">ElectroMagneticConverter</a> with an additional leakage path on the magnetic side (leakage inductance, leakage flux). This model may improve stability especially when the magnetic circuit contains more than one electromagnetic converter.
</p>
</html>"));
end ElectroMagneticConverterWithLeakageInductance;
