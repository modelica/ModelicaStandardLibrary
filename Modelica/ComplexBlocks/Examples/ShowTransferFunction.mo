within Modelica.ComplexBlocks.Examples;
model ShowTransferFunction "Test complex transfer function block"
  extends Modelica.Icons.Example;
  parameter Modelica.Units.SI.Mass m = 0.2 "Mass";
  parameter Modelica.Units.SI.TranslationalDampingConstant d = 0.01 "Damping coefficient (not the damping ratio)";
  parameter Modelica.Units.SI.TranslationalSpringConstant c = 0.1 "Stiffness";
protected
  final constant Modelica.Units.SI.Mass oneUnitMass = 1
    "Helping constant to satisfy unit check";
  final constant Modelica.Units.SI.TranslationalDampingConstant oneUnitDampingConstant = 1
    "Helping constant to satisfy unit check";
  final constant Modelica.Units.SI.TranslationalSpringConstant oneUnitSpringConstant = 1
    "Helping constant to satisfy unit check";
public
  final parameter Real b[:]={-m/oneUnitMass} "Unitless numerator polynomial coefficients {-m} of the transfer function";
  final parameter Real a[:]={m/oneUnitMass, d/oneUnitDampingConstant, c/oneUnitSpringConstant}
    "Unitless denominator polynomial coefficients {m,d,c} of the transfer function";
  parameter Real wMin=0.01 "Lower bound for frequency sweep";
  parameter Real wMax=100 "Upper bound for frequency sweep";
  Real lg_w=log10(logFrequencySweep.y) "Logarithm of frequency";
  Real dB=20*log10(complexToPolar.len) "Magnitude of the transfer function in decibel";
  Modelica.Units.SI.Angle phi(displayUnit="deg")=complexToPolar.phi "Argument of the transfer function";
  Modelica.Blocks.Sources.LogFrequencySweep logFrequencySweep(
    duration=1,
    wMin=wMin,
    wMax=wMax) annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Modelica.ComplexBlocks.Sources.ComplexConstant const(k(re=1, im=0))
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.ComplexBlocks.ComplexMath.TransferFunction transferFunction(final b=b,
      final a=a)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.ComplexBlocks.ComplexMath.ComplexToPolar complexToPolar
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
equation
  connect(const.y, transferFunction.u)
    annotation (Line(points={{-59,0},{-50.5,0},{-42,0}}, color={85,170,255}));
  connect(logFrequencySweep.y, transferFunction.w)
    annotation (Line(points={{-59,-30},{-30,-30},{-30,-12}}, color={0,0,127}));
  connect(transferFunction.y, complexToPolar.u)
    annotation (Line(points={{-19,0},{-2,0}}, color={85,170,255}));
  annotation (
    experiment(StopTime=1, Interval=0.001), Documentation(info="<html>
<p>This example shows the response of a PT2 (mechanical spring-mass-damper system with
an acceleration acting on the mass) defined by its transfer function</p>
<blockquote><pre>
              -m
H(jw)=-------------------
      m*(jw)^2 + d*jw + c
</pre></blockquote>
<p>Frequency performs a logarithmic ramp from 0.01 to 100 s^-1.</p>
<p>
Plot the magnitude locus (in dB) dB versus lg_w and the phase locus versus lg_w.
</p>
</html>"));
end ShowTransferFunction;
