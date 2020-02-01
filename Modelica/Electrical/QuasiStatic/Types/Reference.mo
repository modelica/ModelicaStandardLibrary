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
Equality constraint for the reference angle, according to the <a href=\"https://specification.modelica.org/v3.4/Ch9.html#equation-operators-for-overconstrained-connection-based-equation-systems1\">Section 9.4 (Equation Operators for Overconstrained Connection-Based Equation Systems) of the Modelica 3.4 specification</a>.
</html>"));
  end equalityConstraint;
  annotation (Documentation(info="<html>
Reference angle, used in the quasi-static AC connectors.
</html>"));
end Reference;
