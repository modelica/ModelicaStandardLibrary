within Modelica.Electrical.Machines.SpacePhasors.Functions;
function activePower
  "Calculate active power of voltage and current input"
  import Modelica.Constants.pi;
  extends Modelica.Icons.Function;
  input Modelica.SIunits.Voltage v[m] "phase voltages";
  input Modelica.SIunits.Current i[m] "phase currents";
  output Modelica.SIunits.Power p "Active power";
protected
  constant Integer m=3 "Number of phases";
  Modelica.SIunits.Voltage v_[2] "Voltage space phasor";
  Modelica.SIunits.Current i_[2] "Current space phasor";
algorithm
  v_ := zeros(2);
  i_ := zeros(2);
  for k in 1:m loop
    v_ := v_ + 2/m*{+cos((k - 1)/m*2*pi),+sin(+(k - 1)/m*2*pi)}*v[k];
    i_ := i_ + 2/m*{+cos((k - 1)/m*2*pi),+sin(+(k - 1)/m*2*pi)}*i[k];
  end for;
  p := m/2*(+v_[1]*i_[1] + v_[2]*i_[2]);
  annotation (Inline=true, Documentation(info="<html>
Transformation of three-phase voltages and currents to space phasors and calculate active power.
</html>"));
end activePower;
