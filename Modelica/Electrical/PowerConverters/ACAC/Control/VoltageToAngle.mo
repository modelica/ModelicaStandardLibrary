within Modelica.Electrical.PowerConverters.ACAC.Control;
block VoltageToAngle "Reference voltage to firing angle converter"
  extends Modelica.Blocks.Icons.Block;
  import Modelica.Constants.pi;
  parameter SI.Voltage VNominal "Nominal voltage";
  parameter PowerConverters.Types.Voltage2AngleType voltage2Angle=
      PowerConverters.Types.Voltage2AngleType.Lin "Select type of calculation";
  Modelica.Blocks.Interfaces.RealInput vRef "Reference voltage"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput firingAngle(
    unit="rad",
    displayUnit="deg",
    min=0,
    max=pi,
    start=pi) "Firing angle"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Math.Gain gain_v(final k=1/VNominal)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(final uMax=1, final uMin=0)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(final table=
    if voltage2Angle ==PowerConverters.Types.Voltage2AngleType.Lin then Lin
    elseif voltage2Angle ==PowerConverters.Types.Voltage2AngleType.H01 then H01
    else RMS, final extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Blocks.Math.Gain gain_alpha(final k=pi)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
protected
  constant Real Lin[:,2]=[0,1; 1,0];
  constant Real H01[:,2]=[0,1;
    7.85377E-05,0.995; 0.000314125,0.99; 0.000706684,0.985; 0.001256086,0.98;
    0.00196215,0.975; 0.007832473,0.95; 0.017562721,0.925; 0.031072921,0.9;
    0.048252035,0.875; 0.068958879,0.85; 0.093023287,0.825; 0.120247535,0.8;
    0.150407987,0.775; 0.183256979,0.75; 0.218524917,0.725; 0.255922582,0.7;
    0.295143624,0.675; 0.33586724,0.65; 0.377761016,0.625; 0.420483922,0.6;
    0.463689446,0.575; 0.507028849,0.55; 0.550154538,0.525; 0.592723531,0.5;
    0.634401018,0.475; 0.674864,0.45; 0.713804992,0.425; 0.750935807,0.4;
    0.785991389,0.375; 0.818733724,0.35; 0.848955796,0.325; 0.87648563,0.3;
    0.901190381,0.275; 0.922980502,0.25; 0.941813955,0.225; 0.957700455,0.2;
    0.97070568,0.175; 0.980955368,0.15; 0.988639134,0.125; 0.994013774,0.1;
    0.997405692,0.075; 0.999211945,0.05; 0.999899238,0.025; 0.999948191,0.02;
    0.999978053,0.015; 0.999993471,0.01; 0.999999181,0.005; 1,0];
  constant Real RMS[:,2]=[0,1;
    0.000906877,0.995; 0.002564847,0.99; 0.004711343,0.985; 0.007252334,0.98;
    0.010133194,0.975; 0.028608003,0.95; 0.052394349,0.925; 0.080318563,0.9;
    0.111626433,0.875; 0.14574274,0.85; 0.182186463,0.825; 0.22053266,0.8;
    0.260393008,0.775; 0.301405137,0.75; 0.343226628,0.725; 0.385531651,0.7;
    0.428009237,0.675; 0.470362569,0.65; 0.51230895,0.625; 0.553580231,0.6;
    0.593923537,0.575; 0.633102218,0.55; 0.670896923,0.525; 0.707106781,0.5;
    0.741550618,0.475; 0.774068203,0.45; 0.804521493,0.425; 0.83279585,0.4;
    0.858801222,0.375; 0.882473259,0.35; 0.903774359,0.325; 0.922694611,0.3;
    0.939252619,0.275; 0.953496168,0.25; 0.965502709,0.225; 0.975379591,0.2;
    0.983263999,0.175; 0.989322523,0.15; 0.99375024,0.125; 0.996769245,0.1;
    0.998626473,0.075; 0.999590707,0.05; 0.999948658,0.025; 0.999973701,0.02;
    0.999988902,0.015; 0.999996711,0.01; 0.999999589,0.005; 1,0];
equation
  connect(limiter.y, combiTable1Ds.u)
    annotation (Line(points={{-19,0},{-2,0}}, color={0,0,127}));
  connect(vRef, gain_v.u)
    annotation (Line(points={{-120,0},{-82,0}}, color={0,0,127}));
  connect(gain_alpha.y, firingAngle)
    annotation (Line(points={{61,0},{110,0}}, color={0,0,127}));
  connect(combiTable1Ds.y[1], gain_alpha.u)
    annotation (Line(points={{21,0},{38,0}}, color={0,0,127}));
  connect(gain_v.y, limiter.u)
    annotation (Line(points={{-59,0},{-42,0}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
This block calculates firing angle from desired voltage,
choosing either a linear (<code>Lin</code>) relationship or prescribing the first harmonic (<code>H01</code>)  or the root mean square (<code>RMS</code>) .
Since calculating the firing angle from both the H01 and the RMS involves a nonlinear equation,
both relationships have been precalculated and are interpolated from a table.
</p>
</html>"), Icon(coordinateSystem(grid={2,2}),
                graphics={
        Line(points={{-55.1,66.4},{-49.4,74.6},{-43.8,79.1},{-38.2,79.8},{-32.6,
              76.6},{-26.9,69.7},{-21.3,59.4},{-14.9,44.1},{-6.83,21.2},{0,0}},
                                                            smooth = Smooth.Bezier),
        Line(points={{-80,0},{80,0}}, color={28,108,200}),
        Line(points={{-55,66},{-55,0},{-80,0}}, color={0,0,0}),
        Line(points={{26,-68},{35,-78.4},{40.6,-80},{46.2,-77.6},{51.9,-71.5},{57.5,
              -61.9},{63.9,-47.2},{72,-24.8},{80,0}},       smooth = Smooth.Bezier),
        Line(points={{0,0},{26,0},{26,-68}}, color={0,0,0})}));
end VoltageToAngle;
