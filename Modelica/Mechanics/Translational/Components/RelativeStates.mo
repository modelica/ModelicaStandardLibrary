within Modelica.Mechanics.Translational.Components;
model RelativeStates "Definition of relative state variables"
  extends Translational.Interfaces.PartialTwoFlanges;
  parameter StateSelect stateSelect=StateSelect.prefer
    "Priority to use the relative angle and relative speed as states";
  SI.Position s_rel(start=0, stateSelect=StateSelect.prefer)
    "Relative position used as state variable";
  SI.Velocity v_rel(start=0, stateSelect=StateSelect.prefer)
    "Relative velocity used as state variable";
  SI.Acceleration a_rel(start=0) "Relative angular acceleration";

equation
  s_rel = flange_b.s - flange_a.s;
  v_rel = der(s_rel);
  a_rel = der(v_rel);
  flange_a.f = 0;
  flange_b.f = 0;
  annotation (
    Documentation(info="<html>
<p>
Usually, the absolute position and the absolute velocity of
Modelica.Mechanics.Translational.Inertia models are used as state variables.
In some circumstances, relative quantities are better suited, e.g.,
because it may be easier to supply initial values.
In such cases, model <strong>RelativeStates</strong> allows the definition of state variables
in the following way:
</p>
<ul>
<li> Connect an instance of this model between two flange connectors.</li>
<li> The <strong>relative position</strong> and the <strong>relative velocity</strong>
     between the two connectors are used as <strong>state variables</strong>.</li>
</ul>
<p>
An example is given in the next figure
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/Components/relativeStates.png\" alt=\"Relative states\">
</div>

<p>
Here, the relative position and the relative velocity between
the two masses are used as state variables. Additionally, the
simulator selects either the absolute position and absolute
velocity of model mass1 or of model mass2 as state variables.
</p>

</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={ Line(
              points={{-100,0},{100,0}},
              pattern=LinePattern.Dot,
          color={0,127,0}),
        Ellipse(
          extent={{-40,40},{40,-40}},
          lineColor={52,219,218},
          fillColor={52,219,218},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-40,40},{40,-40}},
          textString="S",
          textColor={0,0,255}),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255})}));
end RelativeStates;
