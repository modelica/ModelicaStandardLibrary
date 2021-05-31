within Modelica.Electrical.Analog.Lines.Functions;
record LineGeometry "Contains multi-wire line geometry data"
  extends Modelica.Icons.Record;
  parameter Integer n=3 "Number of wires" annotation (Evaluate=true);
  parameter Real x[:]={-1,0,1} "Horizontal abscissas of conductors (m)";
  parameter Real y[:]={8,10,8} "Vertical abscissas of conductors (m)";
  parameter Real r[:]=0.5e-3*{12,12,12} "Conductor radii  (m)";
  parameter Real R1[:]=1e-6*{177,177,177}
    "Resistance per length of conductors (ohm/m)";
  parameter Real k_s=0.75 "ratio of equivalent tubular radius to radius for all conductors";
  parameter Real rho=100 "earth resistivity";
  annotation (Documentation(info="<html>
<p>This record will contain the line geometry and resistances of a multi-conductor line.</p>
<p>This will be used by functions ComputeZ and ComputeY that will compute longitudinal (flow) and transverse (cross)  line matrices.</p>
</html>"));
end LineGeometry;
