within Modelica.Magnetic.FundamentalWave.Interfaces;
partial model PartialBasicInductionMachine
  "Partial model for induction machine"
  extends Electrical.Machines.Interfaces.PartialBasicMachine(Jr(start=0.29));
  constant Integer m=3 "Number of phases";
  parameter Integer p(min=1, start=2) "Number of pole pairs (Integer)";
  parameter Modelica.SIunits.Frequency fsNominal(start=50) "Nominal frequency";
  parameter Real effectiveStatorTurns = 1 "Effective number of stator turns";

  parameter Modelica.SIunits.Resistance Rs "Warm stator resistance per phase" 
     annotation(Dialog(group="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Inductance Lssigma(start=3*(1 - sqrt(1 - 0.0667))/(2*pi*fsNominal))
    "Stator stray inductance per phase" 
     annotation(Dialog(group="Nominal resistances and inductances"));

  // Stator voltages and currents
  output Modelica.SIunits.Voltage vs[m] = plug_sp.pin.v - plug_sn.pin.v
    "Stator instantaneous voltages";
  output Modelica.SIunits.Current is[m] = plug_sp.pin.i
    "Stator instantaneous currents";

  Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_sp(
    final m=m) 
    annotation (Placement(transformation(extent={{50,90},{70,110}},
          rotation=0)));
  Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_sn(
    final m=m) 
    annotation (Placement(transformation(extent={{-70,90},{-50,110}},
          rotation=0)));
  Modelica.Magnetic.FundamentalWave.Machines.Components.SymmetricMultiPhaseWinding
    statorWinding(
    final m=m,
    final R=Rs,
    final Lsigma=Lssigma,
    final effectiveTurns=effectiveStatorTurns)
    "Symmetric stator winding including resistances and stray inductances" 
    annotation (Placement(transformation(
        origin={0,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(statorWinding.plug_n, plug_sn) annotation (Line(
      points={{-10,40},{-10,60},{-60,60},{-60,100}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(plug_sp, statorWinding.plug_p) annotation (Line(
      points={{60,100},{60,60},{10,60},{10,40}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Documentation(info="<HTML>
Partial model for induction machine models
</HTML>"),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}),
            graphics),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Line(points={{-50,100},{-20,100},{-20,70}},
            color={0,0,255}), Line(points={{50,100},{20,100},{20,70}},
            color={0,0,255}),
        Rectangle(
          extent={{-40,60},{80,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,128,0}),
        Rectangle(
          extent={{-40,70},{40,50}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-50,-90},{-40,-90},{-10,-20},{40,-20},{70,-90},{80,-90},{80,-100},
              {-50,-100},{-50,-90}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}));
end PartialBasicInductionMachine;
