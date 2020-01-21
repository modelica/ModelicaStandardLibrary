within Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities;
model CurrentController "Current controller"
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  parameter Integer p "Number of pole pairs";
  parameter SI.Angle gamma0=0
    "Offset added to electrical rotor angle";
  Modelica.Blocks.Interfaces.RealInput id_rms annotation (Placement(
        transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput iq_rms annotation (Placement(
        transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealInput phi annotation (Placement(
        transformation(
        origin={0,-120},
        extent={{20,-20},{-20,20}},
        rotation=270)));
  Modelica.Blocks.Math.Gain toGamma(k=p) annotation (Placement(
        transformation(
        origin={0,-70},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput I[m]
    "Polyphase current phasors"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput gamma(unit="rad") "Reference angle of source"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Blocks.SingleToPolyphase singleToMultiPhase(final m=m)
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Modelica.ComplexBlocks.ComplexMath.RealToComplex realToComplex
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Modelica.Blocks.Sources.Constant const(final k=gamma0) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,-70})));
equation
  connect(phi, toGamma.u)
    annotation (Line(points={{0,-120},{0,-82}}, color={85,170,255}));
  connect(singleToMultiPhase.y, I) annotation (Line(
      points={{41,40},{110,40}}, color={85,170,255}));
  connect(toGamma.y, add.u1) annotation (Line(
      points={{0,-59},{0,-34},{38,-34}}, color={85,170,255}));
  connect(const.y, add.u2) annotation (Line(
      points={{30,-59},{30,-46},{38,-46}}, color={85,170,255}));
  connect(add.y, gamma) annotation (Line(
      points={{61,-40},{110,-40}}, color={85,170,255}));
  connect(id_rms, realToComplex.re) annotation (Line(
      points={{-120,60},{-60,60},{-60,46},{-42,46}}, color={85,170,255}));
  connect(iq_rms, realToComplex.im) annotation (Line(
      points={{-120,-60},{-60,-60},{-60,34},{-42,34}}, color={85,170,255}));
  connect(realToComplex.y, singleToMultiPhase.u) annotation (Line(
      points={{-19,40},{18,40}}, color={85,170,255}));
  annotation (defaultComponentName="currentController",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Text(
              extent={{-100,60},{20,40}},
              textColor={0,0,255},
              textString="id_rms"),Text(
              extent={{-100,-40},{20,-60}},
              textColor={0,0,255},
              textString="iq_rms"),     Text(
        extent={{-150,150},{150,110}},
        textString="%name",
        textColor={0,0,255})}),
    Documentation(info="<html>
<p>
This is a simple current controller.
The desired RMS values of d  and q component of the quasi-static space phasor current in rotor fixed coordinate system are the inputs <code>id_rms</code> and <code>iq_rms</code>.
Using the given rotor position input <code>phi</code>, the quasi-static <code>m</code>-phase output currents <code>i[m]</code> are calculated.
The model output can be used to feed a quasi-static current source with phase input to supply synchronous machines.
</p>
</html>"));
end CurrentController;
