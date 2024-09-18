within Modelica.Electrical.QuasiStatic.Types;
record Reference "Reference angle"
  SI.Angle gamma;
  function equalityConstraint "Equality constraint for reference angle"
    input Reference reference1;
    input Reference reference2;
    output Real residue[0];
  algorithm
    assert(abs(reference1.gamma - reference2.gamma) < 1E-6*2*Modelica.Constants.pi,
      "Reference angles should be equal!");
    annotation (Documentation(info="<html>
Equality constraint for the reference angle, according to the <a href=\"https://specification.modelica.org/maint/3.6/connectors-and-connections.html#equation-operators-for-overconstrained-connection-based-equation-systems1\">Section&nbsp;9.4 <em>Overconstrained Connections</em> of the Modelica&nbsp;3.6 specification</a>.
</html>"));
  end equalityConstraint;
  annotation (Documentation(info="<html>
Reference angle, used in the quasi-static AC connectors.
</html>"));
end Reference;
