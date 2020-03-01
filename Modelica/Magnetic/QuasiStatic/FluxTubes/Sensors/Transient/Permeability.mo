within Modelica.Magnetic.QuasiStatic.FluxTubes.Sensors.Transient;
model Permeability
"Determines permeability from flux and magnetic potential difference"

  parameter SI.Area A
  "Area of cross section penetrated by flux";
  parameter SI.Length l
  "Length associated with magnetic potential difference";

  Modelica.Blocks.Interfaces.RealInput Phi(unit="Wb") "Magnetic flux"
                    annotation (Placement(
        transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput V_m(unit="A")
  "Magnetic potential difference" annotation (
      Placement(transformation(extent={{-140,-80},
            {-100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput mu(unit="H/m") "Absolute permeability"
                   annotation (Placement(
        transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput mur(unit="1") "Relative permeability"
                            annotation (Placement(
        transformation(extent={{100,-70},{120,-50}})));

equation
  if noEvent(abs(V_m) < Modelica.Constants.eps) then
     mu = 0;
     mur = 0;
  else
     mu =Phi /V_m*l/A;
     mur = mu/Modelica.Constants.mu_0;
  end if;

  annotation ( Icon(
        coordinateSystem(preserveAspectRatio=false),
        graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{60,-60},{-60,60}},
          fillColor={255,170,85},
          fillPattern=FillPattern.Solid,
          textString="μ")}),
  Documentation(info="<html>
<p>This model determines the absolute and relative permeability from two real inputs:</p>
<ul>
<li>RMS magnetic potential difference,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/realV_m.png\" alt=\"V_m\"></li>
<li>RMS magnetic flux,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/realPhi.png\" alt=\"Phi\"></li>
</ul>
<p>In order to calculate the permeabilities, the area of cross section,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/A.png\" alt=\"l\">,
and the geometric length,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/l.png\" alt=\"l\">,
of the flux path have to be take into account</p>
<dl><dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/permeabilities.png\" alt=\"Permeabilities\">
</dd></dl>
<p>In case that the magnetic potential difference is close to zero, permeabilities yield:</p>
<dl><dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/permeabilities-0.png\" alt=\"Permeabilities=0\">
</dd></dl>
</html>"));
end Permeability;
