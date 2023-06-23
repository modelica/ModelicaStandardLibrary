within Modelica.Electrical.Analog.Lines.Functions;
record LineGeometry
 extends Modelica.Icons.Record;
  parameter Integer n=3 "Number of wires" annotation (Evaluate=true);
  parameter Modelica.Units.SI.Length x[n] "Horizontal abscissas of conductors";
  parameter Modelica.Units.SI.Length y[n] "Vertical abscissas of conductors";
  parameter Modelica.Units.SI.Length r[n] "Conductor radii";
  parameter Real R1[n]   "Resistance per length of conductors (ohm/m)";
  parameter Real k_s[n]=fill(0.7,n) "ratio of GMR to actual conductor radius";
  parameter Modelica.Units.SI.Resistivity rho=100 "earth resistivity";
  parameter Modelica.Units.SI.Frequency f=50 "line frequency";
  annotation (Documentation(info="<html>
<p>This record contains the line geometry and resistances of a multi-conductor line.</p>
<p>It will be used by functions LineZmatrix and LineCmatrix that compute longitudinal (flow) and transverse (cross) line matrices.</p>
<p>Even though frequency is not part of the line geometry, it is a parameter needed by LineZmatrix and therefore it is included here.</p>
</html>", revisions="<html>
<li><em>May, 2021</em> 
        Massimo Ceraolo of the University of Pisa <br> 
        originally created</li> 
</html>"));
end LineGeometry;
