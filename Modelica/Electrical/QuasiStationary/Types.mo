within Modelica.Electrical.QuasiStationary;
package Types "Definition of types for quasistationary AC models"
  extends Modelica.Icons.TypesPackage;

  record Reference "Reference angle"
    Modelica.SIunits.Angle gamma;
    function equalityConstraint "Equality constraint for reference angle"
      input Reference reference1;
      input Reference reference2;
      output Real residue[0];
    algorithm
      assert(abs(reference1.gamma - reference2.gamma) < 1E-6*2*Modelica.Constants.pi,
        "Reference angles should be equal!");
      annotation (Documentation(info="<html>
Equality constraint for the reference angle, according to the Modelica Specification (Overdetermined connection sets).
</html>"));
    end equalityConstraint;
    annotation (Documentation(info="<html>
Reference angle, used in the quasi static AC connectors.
</html>"));
  end Reference;
  annotation (Documentation(info="<html>
Type definitions needed for quasistationary AC models.
</html>"));
end Types;
