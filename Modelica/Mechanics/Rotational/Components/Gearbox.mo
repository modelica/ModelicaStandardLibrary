within Modelica.Mechanics.Rotational.Components;
model Gearbox "Realistic model of a gearbox (based on LossyGear)"
  extends Modelica.Mechanics.Rotational.Icons.Gearbox;
  extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlangesAndSupport;

  parameter Real ratio(start=1)
    "Transmission ratio (flange_a.phi/flange_b.phi)";
  parameter Real lossTable[:, 5]=[0, 1, 1, 0, 0]
    "Array for mesh efficiencies and bearing friction depending on speed (see docu of LossyGear)";
  parameter SI.RotationalSpringConstant c(final min=Modelica.Constants.small,
      start=1.0e5) "Gear elasticity (spring constant)";
  parameter SI.RotationalDampingConstant d(final min=0, start=0)
    "Gear damping (relative damping)";
  parameter SI.Angle b(final min=0) = 0 "Total backlash";
  parameter StateSelect stateSelect=StateSelect.prefer
    "Priority to use phi_rel and w_rel as states"
    annotation (HideResult=true, Dialog(tab="Advanced"));
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialConditionalHeatPort(
      final T=293.15);
  SI.Angle phi_rel(
    start=0,
    stateSelect=stateSelect,
    nominal=1e-4) = flange_b.phi - lossyGear.flange_b.phi
    "Relative rotation angle over gear elasticity (= flange_b.phi - lossyGear.flange_b.phi)";
  SI.AngularVelocity w_rel(
    start=0,
    stateSelect=stateSelect) = der(phi_rel)
    "Relative angular velocity over gear elasticity (= der(phi_rel))";
  SI.AngularAcceleration a_rel(start=0) = der(w_rel)
    "Relative angular acceleration over gear elasticity (= der(w_rel))";

  Rotational.Components.LossyGear lossyGear(
    final ratio=ratio,
    final lossTable=lossTable,
    final useSupport=true,
    final useHeatPort=true) annotation (Placement(transformation(extent={{-60,
            -20},{-20,20}})));
  Rotational.Components.ElastoBacklash elastoBacklash(
    final b=b,
    final c=c,
    final phi_rel0=0,
    final d=d,
    final useHeatPort=true) annotation (Placement(transformation(extent={{
            20,-20},{60,20}})));
equation
  connect(flange_a, lossyGear.flange_a) annotation (Line(points={{-100,0},{
          -90,0},{-90,0},{-80,0},{-80,0},{-60,0}}));
  connect(lossyGear.flange_b, elastoBacklash.flange_a) annotation (Line(
        points={{-20,0},{-10,0},{0,0},{20,0}}));
  connect(elastoBacklash.flange_b, flange_b) annotation (Line(points={{60,0},
          {70,0},{70,0},{80,0},{80,0},{100,0}}));
  connect(elastoBacklash.heatPort, internalHeatPort) annotation (Line(
      points={{20,-20},{20,-60},{-100,-60},{-100,-80}}, color={191,0,0}));
  connect(lossyGear.heatPort, internalHeatPort) annotation (Line(
      points={{-60,-20},{-60,-60},{-100,-60},{-100,-80}}, color={191,0,0}));
  connect(lossyGear.support, internalSupport) annotation (Line(
      points={{-40,-20},{-40,-40},{0,-40},{0,-80}}));
  annotation (
    Documentation(info="<html>
<p>This component models the essential effects of a gearbox, in
particular</p>
<ul>
  <li>in component <strong>lossyGear</strong>
    <ul>
      <li>gear <strong>efficiency</strong> due to friction between the teeth</li>
      <li><strong>bearing friction</strong></li>
    </ul></li>
  <li>in component <strong>elastoBacklash</strong>
    <ul>
      <li>gear <strong>elasticity</strong></li>
      <li><strong>damping</strong></li>
      <li><strong>backlash</strong></li>
    </ul></li>
</ul>
<p>The inertia of the gear wheels is not modeled. If necessary,
inertia has to be taken into account by connecting components of
model Inertia to the left and/or the right flange of component
Gearbox.
</p>

</html>"),
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}),graphics={Text(
              extent={{-150,150},{150,110}},
              textColor={0,0,255},
              textString="%name"),Text(
              extent={{-150,70},{150,100}},
              textString="ratio=%ratio, c=%c"),Line(
              visible=useHeatPort,
              points={{-100,-100},{-100,-30},{0,-30}},
              color={191,0,0},
              pattern=LinePattern.Dot)}));
end Gearbox;
