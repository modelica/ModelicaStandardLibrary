within ModelicaTest.Fluid;
package TestUtilities
  "Contains test cases to for utilities in the Modelica.Fluid apckage"
  extends Modelica.Icons.ExamplesPackage;
  model Test01RegFun3
    "Test case 1 from https://trac.modelica.org/Modelica/ticket/495"
    Real x;

    // Results in error
    parameter Real a=15;
    parameter Real b=1.0;

    // Avoids error
    //Real a=15;
    //Real b=1.0;

  equation
    x = Modelica.Fluid.Utilities.regFun3(
      time,
      0,
      100,
      50,
      800/a,
      0,
      b/a);
    assert(50 <= x and x <= 800/a, "regFun3() does not work properly!");
    annotation (experiment(StopTime=100));
  end Test01RegFun3;

  model Test02RegFun3
    "Test case 2 from https://trac.modelica.org/Modelica/ticket/495"
    Real x;

    // Results in error
    //parameter Real a = 15;
    //parameter Real b = 1.0;

    // Avoids error
    Real a=15;
    Real b=1.0;

  equation
    x = Modelica.Fluid.Utilities.regFun3(
      time,
      0,
      100,
      50,
      800/a,
      0,
      b/a);
    assert(50 <= x and x <= 800/a, "regFun3() does not work properly!");
    annotation (experiment(StopTime=100));
  end Test02RegFun3;
end TestUtilities;
