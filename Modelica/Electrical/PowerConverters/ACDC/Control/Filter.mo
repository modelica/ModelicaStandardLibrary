within Modelica.Electrical.PowerConverters.ACDC.Control;
block Filter "PT1 + all-pass filter"
  extends Modelica.Blocks.Interfaces.SISO;
  import Modelica.Constants.pi;
  parameter SI.Frequency f=50 "Mains Frequency";
  parameter SI.Frequency fCut=2*f "Cut off frequency";
  final parameter Integer na(final min=2) = 2
    "Count of 1st order all-pass";
  final parameter SI.Frequency fa=f/tan(pi/na - atan(f/fCut)
      /(2*na)) "Characteristic frequency of all-pass filter";
  parameter Real yStart=0 "Start value of output";
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    final k=1,
    final T=1/(2*pi*fCut),
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=yStart)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Continuous.TransferFunction transferFunction[na](
    each final b={-1/(2*pi*fa),1},
    each final a={+1/(2*pi*fa),1},
    each initType=Modelica.Blocks.Types.Init.InitialOutput,
    each y_start=yStart)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
equation
  for j in 1:na - 1 loop
    connect(transferFunction[j].y, transferFunction[j + 1].u);
  end for;
  connect(u, firstOrder.u) annotation (Line(
      points={{-120,0},{-62,0}}, color={0,0,127}));
  connect(firstOrder.y, transferFunction[1].u) annotation (Line(
      points={{-39,0},{38,0}}, color={0,0,127}));
  connect(transferFunction[na].y, y) annotation (Line(
      points={{61,0},{110,0}}, color={0,0,127}));
  annotation (
    Documentation(info="<html>
<p>First order filter with cut-off frequency <code>fCut</code>. The phase shift of the filter is compensated by a series of two first order all-pass filters tuned on supply frequency <code>f</code>.</p>
</html>"),
    Icon(graphics={Polygon(
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid,
                points={{-80,90},{-88,68},{-72,68},{-80,90}}),Line(
                points={{-80,78},{-80,-90}},
                color={192,192,192}),Polygon(
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid,
                points={{90,-80},{68,-72},{68,-88},{90,-80}}),Line(
                points={{-90,-80},{82,-80}},
                color={192,192,192}),Rectangle(
                lineColor={160,160,164},
                fillColor={255,255,255},
                fillPattern=FillPattern.Backward,
                extent={{-80,-80},{22,8}}),Line(
                origin={3.333,-8.667},
                points={{-83.333,34.667},{24.667,34.667},{42.667,-71.333}},
                color={0,0,127},
                smooth=Smooth.Bezier)}));
end Filter;
