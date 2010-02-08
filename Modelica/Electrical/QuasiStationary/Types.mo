within Modelica.Electrical.QuasiStationary;
package Types "Definiton of complex data and operations"
  extends Modelica.Icons.Library2;

  record Reference
    Modelica.SIunits.Angle gamma;
    function equalityConstraint
      input Reference reference1;
      input Reference reference2;
      output Real residue[0];
    algorithm
      assert(abs(reference1.gamma - reference2.gamma) < 1E-6*2*Modelica.Constants.pi, "Reference angles should be equal!");
    end equalityConstraint;
  end Reference;
end Types;
