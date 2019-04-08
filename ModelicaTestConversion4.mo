package ModelicaTestConversion4
  extends Modelica.Icons.ExamplesPackage;
  package Constants
    extends Modelica.Icons.ExamplesPackage;
    model Issue194 "Conversion test for #194"
      extends Modelica.Icons.Example;
      Modelica.Blocks.Sources.Constant constantBlock(
        k=Modelica.Constants.mue_0);
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/194\">#194</a>.
</p>
</html>"));
    end Issue194;
  end Constants;

  package Electrical
    extends Modelica.Icons.ExamplesPackage;
    package Digital
      extends Modelica.Icons.ExamplesPackage;
      model Issue758 "Conversion test for #758"
        extends Modelica.Icons.Example;
        Modelica.Electrical.Digital.Sources.Set set(
          x=Modelica.Electrical.Digital.Interfaces.Logic.'U');
        Modelica.Electrical.Digital.Converters.LogicToXO1 logicToXO1_1(n=1);
        Modelica.Electrical.Digital.Converters.LogicToXO1Z logicToXO1Z(n=1);
      equation 
        connect(set.y, logicToXO1_1.x[1]);
        connect(set.y, logicToXO1Z.x[1]);
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/758\">#758</a>.
</p>
</html>"));
      end Issue758;
    end Digital;
  end Electrical;

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
        annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2780\">#2780</a>.
</p>
</html>"));
      end Issue2780;
    end Dissipation;
  end Fluid;

  package Mechanics
    extends Modelica.Icons.ExamplesPackage;

    package MultiBody
      extends Modelica.Icons.ExamplesPackage;
      model Issue194 "Conversion test for #194"
        extends Modelica.Icons.Example;
        inner Modelica.Mechanics.MultiBody.World world(
          gravityType=Modelica.Mechanics.MultiBody.Types.GravityTypes.PointGravity,
          mue=3.986004418e14);
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/194\">#194</a>.
</p>
</html>"));
      end Issue194;

      function gravityAccelerationIssue194
        import Modelica.Mechanics.MultiBody.Types.GravityTypes;
        extends Modelica.Mechanics.MultiBody.Forces.Internal.standardGravityAcceleration(
          gravityType=GravityTypes.PointGravity,
          mue=3);
      annotation(Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/194\">#194</a>.
</p>
</html>"));
      end gravityAccelerationIssue194;

      model Issue2425 "Conversion test for #2425"
        extends Modelica.Icons.Example;
        inner Modelica.Mechanics.MultiBody.World world;
        Modelica.Mechanics.MultiBody.Sensors.Internal.ZeroForceAndTorque zeroForceAndTorque;
      equation
        connect(world.frame_b, zeroForceAndTorque.frame_a);
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2425\">#2425</a>.
</p>
</html>"));
      end Issue2425;
    end MultiBody;

    package Rotational
      extends Modelica.Icons.ExamplesPackage;
      model Issue194 "Conversion test for #194"
        extends Modelica.Icons.Example;
        Modelica.Mechanics.Rotational.Components.Brake brake(mue_pos=[0,0.5], fn_max=1);
        Modelica.Mechanics.Rotational.Components.Clutch clutch(mue_pos=[0,0.5], fn_max=1);
        Modelica.Mechanics.Rotational.Components.OneWayClutch oneWayClutch(mue_pos=[0,0.5], fn_max=1);
        Modelica.Mechanics.Rotational.Components.Inertia inertia(J=1);
        Modelica.Mechanics.Rotational.Components.Inertia inertia1(J=1);
        Modelica.Mechanics.Rotational.Components.Inertia inertia2(J=1);
        Modelica.Blocks.Sources.Constant const(k=1);
      equation
        connect(brake.flange_b, inertia.flange_a);
        connect(inertia.flange_b, clutch.flange_a);
        connect(clutch.flange_b, inertia1.flange_a);
        connect(inertia.flange_b, oneWayClutch.flange_a);
        connect(oneWayClutch.flange_b, inertia2.flange_a);
        connect(const.y, brake.f_normalized);
        connect(const.y, clutch.f_normalized);
        connect(const.y, oneWayClutch.f_normalized);
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/194\">#194</a>.
</p>
</html>"));
      end Issue194;
    end Rotational;

    package Translational
      extends Modelica.Icons.ExamplesPackage;
      model Issue194 "Conversion test for #194"
        extends Modelica.Icons.Example;
        Modelica.Mechanics.Translational.Components.Brake brake(
          mue_pos=[0,0.5], fn_max=1);
        Modelica.Mechanics.Translational.Components.Mass mass(m=1);
        Modelica.Blocks.Sources.Constant const(k=1);
      equation
        connect(brake.flange_b, mass.flange_a);
        connect(const.y, brake.f_normalized);
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/194\">#194</a>.
</p>
</html>"));
      end Issue194;
    end Translational;
  end Mechanics;
  annotation(uses(Modelica(version="3.2.3")));
end ModelicaTestConversion4;
