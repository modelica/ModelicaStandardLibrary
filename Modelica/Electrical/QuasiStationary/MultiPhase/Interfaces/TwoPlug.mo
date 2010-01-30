within Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces;
partial model TwoPlug "Two plugs with pin-adapter"
  parameter Integer m(min=1) = 3 "number of phases";
  Modelica.SIunits.ComplexVoltage v[m];
  Modelica.SIunits.ComplexCurrent i[m];
  Modelica.SIunits.AngularVelocity omega = der(plug_p.reference.gamma);
  PositivePlug plug_p(final m=m) 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
           0)));
  NegativePlug plug_n(final m=m) 
    annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
  Basic.PlugToPins_p plugToPins_p(final m=m) 
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}}, rotation=
            0)));
  Basic.PlugToPins_n plugToPins_n(final m=m) 
    annotation (Placement(transformation(
        origin={70,0},
        extent={{-10,-10},{10,10}},
        rotation=180)));
equation
  v = plug_p.pin.v - plug_n.pin.v;
  i = plug_p.pin.i;
  connect(plug_p, plugToPins_p.plug_p) 
    annotation (Line(points={{-100,0},{-93,0},{-93,1.16573e-015},{-86,1.16573e-015},
          {-86,0},{-72,0}},
        color={85,170,255}));
  connect(plugToPins_n.plug_n, plug_n) 
    annotation (Line(points={{72,-2.44929e-016},{86,-2.44929e-016},{86,0},{100,
          0}},                               color={85,170,255}));
  annotation (Diagram(graphics),
                       Documentation(info="<html>
<p>
This partial model uses a <a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug\">positive</a>
and <a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug\">negative plug</a> and defines the complex voltage differences as well as the complex currents (into the positive plug). A <a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_p\">positive</a> and 
a <a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_n\">negative adapter</a> are used to give easy acces to the single pins of both plugs. Additionally, the angular velocity of the quasi stationary system is explicitely defined as variable. This model is mainly intended to be used with graphical representation of user models.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug\">PositivePlug</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug\">NegativePlug</a>,
</p>
</html>"));
end TwoPlug;
