within Modelica.Mechanics.Rotational.Components;
model RelativeStates "Definition of relative state variables"
  extends Rotational.Interfaces.PartialTwoFlanges;
  parameter StateSelect stateSelect=StateSelect.prefer
    "Priority to use the relative angle and relative speed as states";
  parameter SI.Angle phi_nominal(
    displayUnit="rad",
    min=0.0) = 1.0 "Nominal value of the relative angle (used for scaling)";

  SI.Angle phi_rel(
    start=0,
    stateSelect=stateSelect,
    nominal=if phi_nominal >= Modelica.Constants.eps then phi_nominal else
        1) "Relative rotation angle used as state variable";
  SI.AngularVelocity w_rel(start=0, stateSelect=stateSelect)
    "Relative angular velocity used as state variable";
  SI.AngularAcceleration a_rel(start=0) "Relative angular acceleration";

equation
  phi_rel = flange_b.phi - flange_a.phi;
  w_rel = der(phi_rel);
  a_rel = der(w_rel);
  flange_a.tau = 0;
  flange_b.tau = 0;
  annotation (
    Documentation(info="<html>
<p>
Usually, the absolute angle and the absolute angular velocity of
Modelica.Mechanics.Rotational.Components.Inertia models are used as state variables.
In some circumstances, relative quantities are better suited, e.g.,
because it may be easier to supply initial values.
In such cases, model <strong>RelativeStates</strong> allows the definition of state variables
in the following way:
</p>
<ul>
<li> Connect an instance of this model between two flange connectors.</li>
<li> The <strong>relative rotation angle</strong> and the <strong>relative angular velocity</strong>
     between the two connectors are used as <strong>state variables</strong>.</li>
</ul>
<p>
An example is given in the next figure
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/Components/relativeStates.png\" alt=\"Model with relative states\">
</div>

<p>
Here, the relative angle and the relative angular velocity between
the two inertias are used as state variables. Additionally, the
simulator selects either the absolute angle and absolute angular
velocity of model inertia1 or of model inertia2 as state variables.
</p>

<p>
See also the discussion
<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.StateSelection\">State Selection</a>
in the User's Guide of the Rotational library.
</p>
</html>"),
    Icon(
    coordinateSystem(preserveAspectRatio=true,
      extent={{-100.0,-100.0},{100.0,100.0}}),
      graphics={
    Line(points={{-100,0},{100,0}},
      pattern=LinePattern.Dot),
    Ellipse(
      lineColor={52,219,218},
      fillColor={52,219,218},
      fillPattern=FillPattern.Solid,
      extent={{-40.0,-40.0},{40.0,40.0}}),
    Text(textColor={0,0,255},
      extent={{-40,-40},{40,40}},
      textString="S"),
    Text(
      extent={{-150,90},{150,50}},
      textString="%name",
      textColor={0,0,255})}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={Ellipse(
          extent={{-40,40},{40,-40}},
          lineColor={52,219,218},
          fillColor={52,219,218},
          fillPattern=FillPattern.Solid),
            Text(
              extent={{-40,40},{40,-40}},
              textString="S",
              textColor={0,0,255}),Line(
              points={{40,0},{96,0}},
              pattern=LinePattern.Dash),Line(points={{-100,-10},{-100,-80}},
          color={160,160,164}),Line(points={{100,-10},{100,-80}}, color={
          160,160,164}),Polygon(
              points={{80,-65},{80,-55},{100,-60},{80,-65}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),Line(points={{-100,-60},{80,-60}},
          color={160,160,164}),Text(
              extent={{-30,-70},{30,-90}},
              textString="w_rel",
              textColor={0,0,255}),Line(points={{-76,80},{-5,80}}, color={
          128,128,128}),Polygon(
              points={{14,80},{-6,85},{-6,75},{14,80}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),Text(
              extent={{18,87},{86,74}},
              textColor={128,128,128},
              textString="rotation axis"),Line(
              points={{-96,0},{-40,0}},
              pattern=LinePattern.Dash)}));
end RelativeStates;
