within Modelica.Electrical.Machines.Examples.ControlledDCDrives.Utilities;
block Filter "Filter or sample current or voltage"
  extends Blocks.Interfaces.SISO;
  import Modelica.Electrical.Machines.Examples.ControlledDCDrives.Utilities.FilterType;
  parameter FilterType filterType=Modelica.Electrical.Machines.Examples.ControlledDCDrives.Utilities.FilterType.FirstOrder
    "Type of filter: FirstOrder, Mean or Sampler";
  parameter SI.Frequency fS "Switching frequency";
  parameter SI.Time Td=0.5/fS "Dead time = filter time constant";
  parameter Real y0=0 "Initial value of output";
  Blocks.Continuous.FirstOrder firstOrder(
    k=1,
    T=Td,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=y0) if filterType==FilterType.FirstOrder
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Blocks.Math.Mean
       mean(f=fS, y0=y0) if filterType==FilterType.Mean
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
  Blocks.Discrete.ZeroOrderHold zeroOrderHold(
    samplePeriod=1/fS,
    startTime=0.5/fS,
    ySample(fixed=true, start=y0)) if filterType==FilterType.Sampler
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
equation
  connect(u, firstOrder.u)
    annotation (Line(points={{-120,0},{-12,0}}, color={0,0,127}));
  connect(firstOrder.y, y)
    annotation (Line(points={{11,0},{110,0}}, color={0,0,127}));
  connect(u, mean.u) annotation (Line(points={{-120,0},{-80,0},{-80,-80},{-12,
          -80}}, color={0,0,127}));
  connect(u, zeroOrderHold.u) annotation (Line(points={{-120,0},{-80,0},{-80,
          -40},{-12,-40}}, color={0,0,127}));
  connect(y, zeroOrderHold.y) annotation (Line(points={{110,0},{80,0},{80,-40},{
          11,-40}}, color={0,0,127}));
  connect(y, mean.y) annotation (Line(points={{110,0},{80,0},{80,-80},{11,-80}},
        color={0,0,127}));
end Filter;
