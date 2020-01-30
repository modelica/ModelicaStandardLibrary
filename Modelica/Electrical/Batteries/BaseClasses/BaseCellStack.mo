within Modelica.Electrical.Batteries.BaseClasses;
partial model BaseCellStack
  "Battery with open-circuit voltage dependent on state of charge, self-discharge and inner resistance"
  extends Modelica.Electrical.Batteries.Icons.BatteryIcon(final displaySOC=SOC);
  parameter Integer Ns(final min=1)=1 "Number of serial connected cells";
  parameter Integer Np(final min=1)=1 "Number of parallel connected cells";
  replaceable parameter ParameterRecords.CellData cellData "Cell parameters"
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  parameter Real SOCtolerance=1e-9 "Tolerance to detect depleted of overcharged battery"
    annotation(Dialog(tab="Advanced"));
  extends Modelica.Electrical.Analog.Interfaces.TwoPin;
  SI.Current i = p.i "Current into the battery";
  SI.Power power = v*i "Power to the battery";
  output Real SOC(start=cellData.SOCmax) = limIntegrator.y "State of charge"
    annotation (Dialog(showStartAttribute=true));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
    annotation (Placement(transformation(extent={{-90,10},{-70,-10}})));
  Blocks.Continuous.LimIntegrator limIntegrator(
    final k=1/(Np*cellData.Qnom),
    outMax=1 - SOCtolerance,
    outMin=SOCtolerance,
      final initType=Modelica.Blocks.Types.Init.NoInit) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,30})));
  Modelica.Blocks.Tables.CombiTable1Ds ocv_soc(
    final table=cellData.OCV_SOC_internal,
    final smoothness=cellData.smoothness,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
  Modelica.Blocks.Math.Gain gainV(final k=Ns*cellData.OCVmax) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,30})));
  Modelica.Electrical.Analog.Sources.SignalVoltage ocv
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Electrical.Analog.Basic.Conductor selfDischarge(
    final G=Np*cellData.Idis/(Ns*cellData.OCVmax),
    T_ref=293.15,
    final useHeatPort=true)
    annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
  Modelica.Electrical.Analog.Basic.Resistor r0(
    final T_ref=cellData.T_ref,
    final alpha=cellData.alpha,
    final useHeatPort=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  extends Modelica.Electrical.Analog.Interfaces.PartialConditionalHeatPort;
equation
  assert(cellData.OCVmax > cellData.OCVmin, "Specify 0 <= OCVmin < OCVmax");
  assert(cellData.SOCmax > cellData.SOCmin, "Specify 0 <= SOCmin < SOCmax <= 1");
  assert(cellData.OCV_SOC[1, 1] >= 0, "Specify OCV(SOC) table with minimum SOC >= 0");
  assert(cellData.OCV_SOC[end, 1] <= 1,  "Specify OCV(SOC) table with maximum SOC <= 1");
  assert(cellData.OCV_SOC[1, 2] >= 0, "Specify OCV(SOC) table with minimum OCV/OCVmax >= 0");
  assert(cellData.OCV_SOC[end, 2] <= 1, "Specify OCV(SOC) table with maximum OCV/OCVmax <= 1");
  assert(SOC < cellData.SOCmax + SOCtolerance, "Battery overcharged!");
  assert(SOC > cellData.SOCmin - SOCtolerance, "Battery exhausted!");
  connect(gainV.y, ocv.v)
    annotation (Line(points={{-40,19},{-40,12}}, color={0,0,127}));
  connect(ocv_soc.y[1], gainV.u)
    annotation (Line(points={{-49,50},{-40,50},{-40,42}},
                                                      color={0,0,127}));
  connect(limIntegrator.y, ocv_soc.u)
    annotation (Line(points={{-80,41},{-80,50},{-72,50}}, color={0,0,127}));
  connect(currentSensor.n, ocv.p)
    annotation (Line(points={{-70,0},{-50,0}}, color={0,0,255}));
  connect(limIntegrator.u, currentSensor.i)
    annotation (Line(points={{-80,18},{-80,11}}, color={0,0,127}));
  connect(p, currentSensor.p)
    annotation (Line(points={{-100,0},{-90,0}}, color={0,0,255}));
  connect(ocv.n, r0.p)
    annotation (Line(points={{-30,0},{-10,0}}, color={0,0,255}));
  connect(currentSensor.p, selfDischarge.p) annotation (Line(points={{-90,0},{-90,
          -20},{-70,-20}},           color={0,0,255}));
  connect(ocv.n, selfDischarge.n)
    annotation (Line(points={{-30,0},{-30,-20},{-50,-20}}, color={0,0,255}));
  connect(selfDischarge.heatPort, internalHeatPort) annotation (Line(points={{-60,-30},
          {-60,-40},{0,-40},{0,-80}},      color={191,0,0}));
  connect(internalHeatPort, r0.heatPort) annotation (Line(points={{0,-80},{
          0,-10}},              color={191,0,0}));
  annotation (
    Documentation(info="<html>
<p>
The battery is modeled by open-circuit voltage (OCV) dependent on state of charge (SOC), a self-discharge component and an inner resistance.<br>
Parameters are collected in parameter record <a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.CellData\">cellData</a>.<br>
All losses are dissipated to the optional <code>heatPort</code>.
</p>
<p>
For details, see <a href=\"modelica://Modelica.Electrical.Batteries.UsersGuide.Concept\">concept</a> and <a href=\"modelica://Modelica.Electrical.Batteries.UsersGuide.Parameterization\">parameterization</a>.
</p>
<h4>Note</h4>
<p>
SOC &gt; SOCmax and SOC &lt; SOCmin triggers an error.
</p>
</html>"));
end BaseCellStack;
