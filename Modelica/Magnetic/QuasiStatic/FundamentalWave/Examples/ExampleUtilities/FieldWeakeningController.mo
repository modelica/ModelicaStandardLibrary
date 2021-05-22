within Modelica.Magnetic.QuasiStatic.FundamentalWave.Examples.ExampleUtilities;
block FieldWeakeningController "Filed weakening for a QS SMPM"
  extends Blocks.Icons.Block;
  parameter Modelica.Units.SI.Voltage VNominal "Nominal rms voltage per phase";
  parameter Modelica.Units.SI.Current IMax "Maximum rms current per phase";
  parameter Real kp=1 "Proportional gain of field weakening controller";
  parameter Modelica.Units.SI.Time Ti=1e-6 "Integral time constant of field weakening controller";
  Blocks.Interfaces.RealInput iqRef
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Blocks.Interfaces.RealInput vs "Stator voltage magnitude" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Blocks.Interfaces.RealOutput is "Stator current magnitude"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Blocks.Interfaces.RealOutput id "Stator direct axis current"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Blocks.Interfaces.RealOutput iq "Stator quadrature axis current"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Blocks.Sources.Constant vRef(k=VNominal)
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Blocks.Continuous.LimPID  PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=kp,
    Ti=Ti,
    yMax=0,
    yMin=-IMax)
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Blocks.Math.RectangularToPolar rectangularToPolar
    annotation (Placement(transformation(extent={{48,-10},{68,10}})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Examples.ExampleUtilities.SpacePhasorLimiter
    spacePhasorLimiter(yMax=IMax)
    annotation (Placement(transformation(extent={{12,-70},{32,-50}})));
equation
  connect(vRef.y, PID.u_s)
    annotation (Line(points={{-59,60},{-42,60}}, color={0,0,127}));
  connect(PID.y, id)
    annotation (Line(points={{-19,60},{110,60}}, color={0,0,127}));
  connect(PID.y, rectangularToPolar.u_re) annotation (Line(points={{-19,60},{40,
          60},{40,6},{46,6}}, color={0,0,127}));
  connect(rectangularToPolar.y_abs, is)
    annotation (Line(points={{69,6},{80,6},{80,0},{110,0}}, color={0,0,127}));
  connect(vs, PID.u_m) annotation (Line(points={{0,-120},{0,-80},{-30,-80},{-30,
          48}}, color={0,0,127}));
  connect(spacePhasorLimiter.y, iq)
    annotation (Line(points={{33,-60},{110,-60}}, color={0,0,127}));
  connect(PID.y, spacePhasorLimiter.u1) annotation (Line(points={{-19,60},{0,60},
          {0,-54},{10,-54}}, color={0,0,127}));
  connect(spacePhasorLimiter.y, rectangularToPolar.u_im) annotation (Line(
        points={{33,-60},{40,-60},{40,-6},{46,-6}}, color={0,0,127}));
  connect(spacePhasorLimiter.u2, iqRef) annotation (Line(points={{10,-66},{-80,-66},
          {-80,0},{-120,0}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
Controls <code>id</code> to keep the voltage <code>vs</code> &le; <code>VNominal</code>, limiting first <code>iq</code> to keep <code>is</code> &le; <code>IMax</code> if possible.
</p>
</html>"), Icon(graphics={
        Text(
          extent={{-90,20},{-50,-20}},
          textColor={0,0,0},
          textString="idRef"),
        Text(
          extent={{60,80},{100,40}},
          textColor={0,0,0},
          textString="id"),
        Text(
          extent={{60,-40},{100,-80}},
          textColor={0,0,0},
          textString="iq"),
        Text(
          extent={{60,20},{100,-20}},
          textColor={0,0,0},
          textString="is"),
        Text(
          extent={{-20,-60},{20,-100}},
          textColor={0,0,0},
          textString="vs")}));
end FieldWeakeningController;
