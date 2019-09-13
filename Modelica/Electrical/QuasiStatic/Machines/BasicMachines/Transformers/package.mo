within Modelica.Electrical.QuasiStatic.Machines.BasicMachines;
package Transformers "Library for technical 3phase transformers"
  extends Modelica.Icons.Package;
  annotation (Documentation(info="<html>
This package contains components to model technical three-phase transformers:
<ul>
<li>Transformer: transformer model to choose connection / vector group</li>
<li>Yy: Transformers with primary Y / secondary y</li>
<li>Yd: Transformers with primary Y / secondary d</li>
<li>Yz: Transformers with primary Y / secondary zig-zag</li>
<li>Dy: Transformers with primary D / secondary y</li>
<li>Dd: Transformers with primary D / secondary d</li>
<li>Dz: Transformers with primary D / secondary zig-zag</li>
</ul>
<p>
Transformers are modeled by an ideal transformer, adding primary and secondary winding resistances and stray inductances.<br>
All transformers extend from the base model <em>PartialTransformer</em>, adding the primary and secondary connection.<br>
<strong>VectorGroup</strong> defines the phase shift between primary and secondary voltages, expressed by a number phase shift/30 degree
(i.e., the hour on a clock face). Therefore each transformer is identified by two characters and a two-digit number,
e.g., Yd11 ... primary connection Y (star), secondary connection d (delta), vector group 11 (phase shift 330 degree)<br>
With the \"supermodel\" <em>Transformer</em> the user may choose primary and secondary connection as well as the vector group.<br>
It calculates winding ratio as well as primary and secondary winding resistances and stray inductances,
distributing them equally to primary and secondary winding, from the following parameters:
</p>
<ul>
<li>nominal frequency</li>
<li>primary voltage (RMS line-to-line)</li>
<li>secondary voltage (RMS line-to-line)</li>
<li>nominal apparent power</li>
<li>impedance voltage drop</li>
<li>short-circuit copper losses</li>
</ul>
The <strong>impedance voltage drop</strong> indicates the (absolute value of the) voltage drop at nominal load (current) as well as
the voltage we have to apply to the primary winding to achieve nominal current in the short-circuited secondary winding.
<p>
<strong>Please pay attention</strong> to proper grounding of the primary and secondary part of the whole circuit.<br>
The primary and secondary starpoint are available as connectors, if the connection is not delta (D or d).<br>
<strong>In some cases (Yy or Yz) it may be necessary to ground one of the transformer's starpoints
even though the source's and/or load's starpoint are grounded; you may use a reasonable high earthing resistance.</strong>
</p>
<strong>Limitations and assumptions:</strong><br>
<ul>
<li>number of phases is limited to 3, therefore definition as a constant m=3</li>
<li>symmetry of the three phases resp. limbs</li>
<li>saturation is neglected, i.e., inductances are constant</li>
<li>magnetizing current is neglected</li>
<li>magnetizing losses are neglected</li>
<li>additional (stray) losses are neglected</li>
</ul>
<strong>Further development:</strong>
<ul>
<li>modeling magnetizing current, including saturation</li>
<li>temperature dependency of winding resistances</li>
</ul>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</dl>
</html>",
      revisions="<html>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer<br>
       first stable release</li>
  <li> v2.2.0 2011/02/10 Anton Haumer<br>
       conditional ThermalPort for all machines</li>
  </ul>
</html>"),
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Polygon(
          origin={10,10},
          fillColor={135,135,135},
          fillPattern=FillPattern.VerticalCylinder,
          points={{-80,50},{-60,30},{-60,-50},{-80,-70},{-80,50}}),
        Polygon(
          origin={10,10},
          fillColor={135,135,135},
          fillPattern=FillPattern.VerticalCylinder,
          points={{60,50},{40,30},{40,-50},{60,-70},{60,50}}),
        Polygon(
          origin={10,10},
          fillColor={135,135,135},
          fillPattern=FillPattern.VerticalCylinder,
          points={{-10,40},{-20,30},{-20,-50},{-10,-60},{0,-50},{0,30},{-10,
              40}}),
        Polygon(
          origin={10,10},
          fillColor={135,135,135},
          fillPattern=FillPattern.VerticalCylinder,
          points={{-80,50},{60,50},{40,30},{0,30},{-10,40},{-20,30},{-60,30},
              {-80,50}}),
        Polygon(
          origin={10,10},
          fillColor={135,135,135},
          fillPattern=FillPattern.VerticalCylinder,
          points={{-80,-70},{60,-70},{40,-50},{0,-50},{-10,-60},{-20,-50},{
              -60,-50},{-80,-70}}),
        Rectangle(
          origin={10,10},
          lineColor={213,170,255},
          fillColor={213,170,255},
          fillPattern=FillPattern.VerticalCylinder,
          extent={{-88,-46},{-52,26}}),
        Rectangle(
          origin={10,10},
          lineColor={170,213,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.VerticalCylinder,
          extent={{-94,-38},{-46,18}}),
        Rectangle(
          origin={10,10},
          lineColor={213,170,255},
          fillColor={213,170,255},
          fillPattern=FillPattern.VerticalCylinder,
          extent={{-28,-46},{8,26}}),
        Rectangle(
          origin={10,10},
          lineColor={170,213,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.VerticalCylinder,
          extent={{-34,-38},{14,18}}),
        Rectangle(
          origin={10,10},
          lineColor={213,170,255},
          fillColor={213,170,255},
          fillPattern=FillPattern.VerticalCylinder,
          extent={{32,-46},{68,26}}),
        Rectangle(
          origin={10,10},
          lineColor={170,213,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.VerticalCylinder,
          extent={{26,-38},{74,18}})}));
end Transformers;
