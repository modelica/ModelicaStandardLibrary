within Modelica.Electrical.PowerConverters.ACAC.Control;
block SoftStartControl "Soft start control"
  extends Modelica.Blocks.Icons.Block;
  import ModeOfOperation =
    Modelica.Electrical.PowerConverters.Types.SoftStarterModeOfOperation;
  parameter SI.Time tRampUp "Start ramp duration";
  parameter Real vStart=0 "Start voltage / nominal voltage";
  parameter Real iMax "Maximum current / nominal current";
  parameter Real iMin=0.9*iMax "Lower threshold of current control";
  parameter SI.Current INominal "Nominal current";
parameter SI.Time tRampDown "Stop ramp duration";
  Modelica.Blocks.Interfaces.RealInput iRMS(unit="A") "Measured RMS current"
    annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput vRef(min=0, max=1, start=0) "Reference voltage"
    annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.BooleanInput start annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
protected
  PowerConverters.Types.SoftStarterModeOfOperation modeOfOperation;
  Real i=iRMS/INominal "Measured current";
  Boolean limit "Indicates current limitation";
initial equation
  if start then
    if vRef<1 then
      modeOfOperation=ModeOfOperation.Up;
    else
      modeOfOperation=ModeOfOperation.On;
    end if;
  else
    if vRef>0 then
      modeOfOperation=ModeOfOperation.Down;
    else
      modeOfOperation=ModeOfOperation.Off;
    end if;
  end if;
  limit = i>=iMax;
equation
  assert(iMax>iMin, "iMax has to be greater than iMin");
  when start then
    modeOfOperation = ModeOfOperation.Up;
  elsewhen vRef>=1 then
    modeOfOperation = ModeOfOperation.On;
  elsewhen not start then
    modeOfOperation = ModeOfOperation.Down;
  elsewhen vRef<=0 then
    modeOfOperation = ModeOfOperation.Off;
  end when;
  when start and vRef<vStart then
    reinit(vRef, vStart);
  end when;
  when i>=iMax then
    limit=true;
  elsewhen i<=iMin then
    limit=false;
  end when;
  if modeOfOperation==ModeOfOperation.Up and not limit then
    der(vRef) = (1 - vStart)/tRampUp;
  elseif modeOfOperation==ModeOfOperation.Down  and not limit then
    der(vRef) = -1/tRampDown;
  else
    der(vRef) = 0;
  end if;
  annotation (Documentation(info="<html>
<p>
This block models the functionality of a soft starter controller, controlling the output <code>vRef</code> in the range [0,1] with respect to nominal voltage.
</p>
<p>
Boolean input <code>start = true</code> causes the output <code>vRef</code> to be risen according to a ramp: <code>vRef = vStart + (1 - vStart)*(time - t0)/tRampUp</code>.
</p>
<p>
In case the current exceeds the specified maximum current <code>iMax</code> during the starting ramp, the ramp is stopped.
When the current falls below the lower threshold of current control <code>iMin &lt; iMax</code>, the ramp is continued.
</p>
<p>
Note: It is recommended to filter the measured current, e.g. using <a href=\"modelica://Modelica.Blocks.Continuous.Filter\">Modelica.Blocks.Continuous.Filter</a>
</p>
<p>
Boolean input <code>start = false</code> causes the output <code>vRef</code> to be lowered according to a ramp: <code>vRef = -(time - t0)/tRampDown</code>.
</p>
</html>"), Icon(graphics={
        Polygon(
          points={{-12,20},{-12,-4},{12,8},{-12,20}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-12,20},{-12,-20}}, color={0,0,255}),
        Line(points={{12,20},{12,-20}}, color={0,0,255}),
        Polygon(
          points={{-12,12},{-12,-12},{12,0},{-12,12}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={0,-8},
          rotation=180),
        Line(points={{-40,0},{-12,0}}, color={0,0,255}),
        Line(points={{12,0},{40,0}}, color={0,0,255}),
        Polygon(
          points={{-12,80},{-12,56},{12,68},{-12,80}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-12,80},{-12,40}}, color={0,0,255}),
        Line(points={{12,80},{12,40}}, color={0,0,255}),
        Polygon(
          points={{-12,12},{-12,-12},{12,0},{-12,12}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={0,52},
          rotation=180),
        Line(points={{-40,60},{-12,60}}, color={0,0,255}),
        Line(points={{12,60},{40,60}}, color={0,0,255}),
        Polygon(
          points={{-12,-40},{-12,-64},{12,-52},{-12,-40}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-12,-40},{-12,-80}}, color={0,0,255}),
        Line(points={{12,-40},{12,-80}}, color={0,0,255}),
        Polygon(
          points={{-12,12},{-12,-12},{12,0},{-12,12}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={0,-68},
          rotation=180),
        Line(points={{-40,-60},{-12,-60}}, color={0,0,255}),
        Line(points={{12,-60},{40,-60}}, color={0,0,255})}));
end SoftStartControl;
