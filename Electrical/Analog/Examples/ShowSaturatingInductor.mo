model ShowSaturatingInductor 
  "Simple demo to show behaviour of SaturatingInductor component" 
  extends Modelica.Icons.Example;
  parameter Modelica.SIunits.Inductance Lzer=2;
  parameter Modelica.SIunits.Inductance Lnom=1;
  parameter Modelica.SIunits.Current Inom=1;
  parameter Modelica.SIunits.Inductance Linf=0.5;
  parameter Modelica.SIunits.Voltage U=1.25;
  parameter Modelica.SIunits.Frequency f=1/(2*Modelica.Constants.pi);
  parameter Modelica.SIunits.Angle phase=Modelica.Constants.pi/2;
  output Modelica.SIunits.Voltage v;
  output Modelica.SIunits.Current i;
  annotation (
    Diagram,
    experiment(StopTime=6.2832, Interval=0.01),
    experimentSetupOutput(doublePrecision=true));
  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage1(
    V=U,
    phase=phase,
    freqHz=f) 
    annotation (extent=[-30,-10; -10,10],   rotation=-90);
  Modelica.Electrical.Analog.Basic.Ground Ground1 
    annotation (extent=[-30,-30; -10,-10]);
  Modelica.Electrical.Analog.Basic.SaturatingInductor SaturatingInductance1(
    Lzer=Lzer,
    Lnom=Lnom,
    Inom=Inom,
    Linf=Linf) 
    annotation(extent=[12,-4; 32,16],  rotation=-90);
equation 
  v=SaturatingInductance1.v;
  i=SaturatingInductance1.i;
  connect(SineVoltage1.n, Ground1.p) annotation (points=[-20,-10; -20,-10],
      style(color=3, rgbcolor={0,0,255}));
  connect(SineVoltage1.n, SaturatingInductance1.n) annotation(points=[-20,-10;
        22,-10; 22,-4], style(color=3, rgbcolor={0,0,255}));
  connect(SaturatingInductance1.p, SineVoltage1.p) annotation(points=[22,16; 22,
        26; -20,26; -20,10], style(color=3, rgbcolor={0,0,255}));
end ShowSaturatingInductor;
