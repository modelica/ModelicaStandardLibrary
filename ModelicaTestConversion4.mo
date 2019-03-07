package ModelicaTestConversion4
  extends Modelica.Icons.ExamplesPackage;
  package Fluid
    extends Modelica.Icons.ExamplesPackage;
    package Dissipation
      extends Modelica.Icons.ExamplesPackage;
      model Issue2780 "Conversion test for #2780"
        extends Modelica.Icons.Example;
        import Modelica.SIunits.ReynoldsNumber;
        parameter Real Re_check=2320 "Ideal transition point";
        parameter Real Re_lam_min=1000 "Start of transition";
        parameter Real Re_turb_leave=4000 "End of transition";
        parameter Real k=1e-5 "Relative roughness";
        parameter Real lambda_fric=0.4 "Darcy friction factor";

        parameter ReynoldsNumber Re_trans=
          Modelica.Fluid.Dissipation.Utilities.Functions.General.CubicInterpolation_DP(
          Re_check,
          Re_lam_min,
          Re_turb_leave,
          k,
          lambda_fric);

        parameter Real lambda = Modelica.Fluid.Dissipation.Utilities.Functions.General.CubicInterpolation_MFLOW(
          Re_check,
          Re_lam_min,
          Re_turb_leave,
          k)/Re_check^2 "Darcy friction factor";
        annotation(Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2780\">#2780</a>.
</p>
</html>"));
      end Issue2780;
    end Dissipation;
  end Fluid;
  annotation(uses(Modelica(version="3.2.3")));
end ModelicaTestConversion4;
