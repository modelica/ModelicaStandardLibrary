within Modelica.Media;
package Incompressible
  "Medium model for T-dependent properties, defined by tables or polynomials"
  extends Modelica.Icons.VariantsPackage;
  import Modelica.Constants;
  import Modelica.Math;

  package Examples "Examples for incompressible media"
    extends Modelica.Icons.VariantsPackage;

  package Glycol47 "1,2-Propylene glycol, 47% mixture with water"
    extends TableBased(
      mediumName="Glycol-Water 47%",
      T_min = Cv.from_degC(-30), T_max = Cv.from_degC(100),
      TinK = false, T0=273.15,
      tableDensity=
        [-30, 1066; -20, 1062; -10, 1058; 0, 1054;
         20, 1044; 40, 1030; 60, 1015; 80, 999; 100, 984],
      tableHeatCapacity=
        [-30, 3450; -20, 3490; -10, 3520; 0, 3560;
         20, 3620; 40, 3690; 60, 3760; 80, 3820; 100, 3890],
      tableConductivity=
        [-30,0.397;  -20,0.396;  -10,0.395;  0,0.395;
         20,0.394;  40,0.393;  60,0.392;  80,0.391;  100,0.390],
      tableViscosity=
        [-30, 0.160; -20, 0.0743; -10, 0.0317; 0, 0.0190;
         20, 0.00626; 40, 0.00299; 60, 0.00162; 80, 0.00110; 100, 0.00081],
      tableVaporPressure=
        [0, 500; 20, 1.9e3; 40, 5.3e3; 60, 16e3; 80, 37e3; 100, 80e3]);
      annotation (Documentation(info="<html>

</html>"));
  end Glycol47;

  package Essotherm650 "Essotherm thermal oil"
    extends TableBased(
      mediumName="Essotherm 650",
      T_min = Cv.from_degC(0), T_max = Cv.from_degC(320),
      TinK = false, T0=273.15,
      tableDensity=
        [0, 909; 20, 897; 40, 884; 60, 871; 80, 859; 100, 846;
         150, 813; 200, 781; 250, 748; 300, 715; 320, 702],
      tableHeatCapacity=
        [0, 1770; 20, 1850; 40, 1920; 60, 1990; 80, 2060; 100, 2130;
         150, 2310; 200, 2490; 250, 2670; 300, 2850; 320, 2920],
      tableConductivity=
        [0,0.1302;  20,0.1288;  40,0.1274;  60,0.1260;  80,0.1246;  100,0.1232;
         150,0.1197;  200,0.1163;  250,0.1128;  300,0.1093;  320,0.1079],
      tableViscosity = [0, 14370; 20, 1917; 40, 424; 60, 134; 80, 54.5;
         100, 26.64; 150, 7.47; 200, 3.22; 250, 1.76; 300, 1.10; 320,0.94],
      tableVaporPressure=
        [160, 3; 180, 10; 200, 40; 220, 100; 240, 300; 260, 600;
         280, 1600; 300, 3e3; 320, 5.5e3]);
      annotation (Documentation(info="<html>

</html>"));
  end Essotherm650;

  model TestGlycol "Test Glycol47 Medium model"
    extends Modelica.Icons.Example;
    package Medium = Glycol47 "Medium model (Glycol47)";
    Medium.BaseProperties medium;

    Medium.DynamicViscosity eta=Medium.dynamicViscosity(medium.state);
    Medium.ThermalConductivity lambda=Medium.thermalConductivity(medium.state);
    Medium.SpecificEntropy s=Medium.specificEntropy(medium.state);
    Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(medium.state);
    Medium.SpecificInternalEnergy u=Medium.specificInternalEnergy(medium.state);
    Medium.SpecificInternalEnergy h=Medium.specificEnthalpy(medium.state);
    Medium.SpecificInternalEnergy d=Medium.density(medium.state);
    protected
    constant SI.Time timeUnit = 1;
    constant SI.Temperature Ta = 1;
  equation
    medium.p = 1.013e5;
    medium.T = Medium.T_min + time/timeUnit*Ta;
      annotation (experiment(StopTime=1.01));
  end TestGlycol;

  annotation (
    Documentation(info="<html>

<p>
This package provides a few examples of how to construct medium models for
incompressible fluids. The package contains:
</p>
<ul>
<li><strong>Glycol47</strong>, a model of 47% glycol water mixture, based on tables of
density and heat capacity as functions of temperature.</li>
<li><strong>Essotherm650</strong>, a medium model for thermal oil, also based on tables.</li>
</ul>

</html>"));
  end Examples;

  package Common "Common data structures"
    extends Modelica.Icons.Package;

    // Extended record for input to functions based on polynomials
    record BaseProps_Tpoly "Fluid state record"
      extends Modelica.Icons.Record;
      SI.Temperature T "Temperature";
      SI.Pressure p "Pressure";
      //    SI.Density d "Density";
    end BaseProps_Tpoly;

    //     record BaseProps_Tpoly_old "Fluid state record"
    //       extends Modelica.Media.Interfaces.PartialMedium.ThermodynamicState;
    //       //      SI.SpecificHeatCapacity cp "Specific heat capacity";
    //       SI.Temperature T "Temperature";
    //       SI.Pressure p "Pressure";
    //       //    SI.Density d "Density";
    //       parameter Real[:] poly_rho "Polynomial coefficients";
    //       parameter Real[:] poly_Cp "Polynomial coefficients";
    //       parameter Real[:] poly_eta "Polynomial coefficients";
    //       parameter Real[:] poly_pVap "Polynomial coefficients";
    //       parameter Real[:] poly_lam "Polynomial coefficients";
    //       parameter Real[:] invTK "Inverse T [1/K]";
    //     end BaseProps_Tpoly_old;
  end Common;

  package TableBased "Incompressible medium properties based on tables"
    import Modelica.Math.Polynomials;

    extends Modelica.Media.Interfaces.PartialMedium(
       ThermoStates = if enthalpyOfT then Modelica.Media.Interfaces.Choices.IndependentVariables.T
                                                                         else Modelica.Media.Interfaces.Choices.IndependentVariables.pT,
       final reducedX=true,
       final fixedX = true,
       mediumName="tableMedium",
       redeclare record ThermodynamicState=Common.BaseProps_Tpoly,
       singleState=true,
       reference_p = 1.013e5,
       Temperature(min = T_min, max = T_max));
    // Constants to be set in actual Medium
    constant Boolean enthalpyOfT=true
      "True if enthalpy is approximated as a function of T only, (p-dependence neglected)";
    constant Boolean densityOfT = size(tableDensity,1) > 1
      "True if density is a function of temperature";
    constant SI.Temperature T_min
      "Minimum temperature valid for medium model";
    constant SI.Temperature T_max
      "Maximum temperature valid for medium model";
    constant Temperature T0=273.15 "Reference Temperature";
    constant SpecificEnthalpy h0=0 "Reference enthalpy at T0, reference_p";
    constant SpecificEntropy s0=0 "Reference entropy at T0, reference_p";
    constant MolarMass MM_const=0.1 "Molar mass";
    constant Integer npol=2 "Degree of polynomial used for fitting";
    constant Integer npolDensity=npol
      "Degree of polynomial used for fitting rho(T)";
    constant Integer npolHeatCapacity=npol
      "Degree of polynomial used for fitting Cp(T)";
    constant Integer npolViscosity=npol
      "Degree of polynomial used for fitting eta(T)";
    constant Integer npolVaporPressure=npol
      "Degree of polynomial used for fitting pVap(T)";
    constant Integer npolConductivity=npol
      "Degree of polynomial used for fitting lambda(T)";
    constant Integer neta=size(tableViscosity,1)
      "Number of data points for viscosity";
    constant Real[:,2] tableDensity "Table for rho(T)";
    constant Real[:,2] tableHeatCapacity "Table for Cp(T)";
    constant Real[:,2] tableViscosity "Table for eta(T)";
    constant Real[:,2] tableVaporPressure "Table for pVap(T)";
    constant Real[:,2] tableConductivity "Table for lambda(T)";
    //    constant Real[:] TK=tableViscosity[:,1]+T0*ones(neta) "Temperature for Viscosity";
    constant Boolean TinK "True if T[K],Kelvin used for table temperatures";
    constant Boolean hasDensity = not (size(tableDensity,1)==0)
      "True if table tableDensity is present";
    constant Boolean hasHeatCapacity = not (size(tableHeatCapacity,1)==0)
      "True if table tableHeatCapacity is present";
    constant Boolean hasViscosity = not (size(tableViscosity,1)==0)
      "True if table tableViscosity is present";
    constant Boolean hasVaporPressure = not (size(tableVaporPressure,1)==0)
      "True if table tableVaporPressure is present";
    final constant Real invTK[neta] = if size(tableViscosity,1) > 0 then
        (if TinK then 1 ./ tableViscosity[:,1] else 1 ./ Cv.from_degC(tableViscosity[:,1])) else fill(0,neta);
    final constant Real poly_rho[:] = if hasDensity then
                                         Polynomials.fitting(tableDensity[:,1],tableDensity[:,2],npolDensity) else
                                           zeros(npolDensity+1);
    final constant Real poly_Cp[:] = if hasHeatCapacity then
                                         Polynomials.fitting(tableHeatCapacity[:,1],tableHeatCapacity[:,2],npolHeatCapacity) else
                                           zeros(npolHeatCapacity+1);
    final constant Real poly_eta[:] = if hasViscosity then
                                         Polynomials.fitting(invTK, Math.log(tableViscosity[:,2]),npolViscosity) else
                                           zeros(npolViscosity+1);
    final constant Real poly_pVap[:] = if hasVaporPressure then
                                         Polynomials.fitting(tableVaporPressure[:,1],tableVaporPressure[:,2],npolVaporPressure) else
                                            zeros(npolVaporPressure+1);
    final constant Real poly_lam[:] = if size(tableConductivity,1)>0 then
                                         Polynomials.fitting(tableConductivity[:,1],tableConductivity[:,2],npolConductivity) else
                                           zeros(npolConductivity+1);
    function invertTemp "Function to invert temperatures"
      extends Modelica.Icons.Function;
      input Real[:] table "Table temperature data";
      input Boolean Tink "Flag for Celsius or Kelvin";
      output Real invTable[size(table,1)] "Inverted temperatures";
    algorithm
      for i in 1:size(table,1) loop
        invTable[i] := if TinK then 1/table[i] else 1/Cv.from_degC(table[i]);
      end for;
      annotation(smoothOrder=3);
    end invertTemp;

    redeclare model extends BaseProperties(
      final standardOrderComponents=true,
      p_bar=Cv.to_bar(p),
      T_degC(start = T_start-273.15)=Cv.to_degC(T),
      T(start = T_start,
        stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default))
      "Base properties of T dependent medium"

      SI.SpecificHeatCapacity cp "Specific heat capacity";
      parameter SI.Temperature T_start = 298.15 "Initial temperature";
    equation
      assert(hasDensity,"Medium " + mediumName +
                        " can not be used without assigning tableDensity.");
      assert(T >= T_min and T <= T_max, "Temperature T (= " + String(T) +
             " K) is not in the allowed range (" + String(T_min) +
             " K <= T <= " + String(T_max) + " K) required from medium model \""
             + mediumName + "\".");
      R_s = Modelica.Constants.R/MM_const;
      cp = Polynomials.evaluate(poly_Cp,if TinK then T else T_degC);
      h = specificEnthalpyOfT(p,T,densityOfT);
      u = h - (if singleState then reference_p/d else state.p/d);
      d = Polynomials.evaluate(poly_rho,if TinK then T else T_degC);
      state.T = T;
      state.p = p;
      MM = MM_const;
      annotation(Documentation(info="<html>
<p>
Note that the inner energy neglects the pressure dependence, which is only
true for an incompressible medium with d = constant. The neglected term is
(p-reference_p)/rho*(T/rho)*(&part;rho /&part;T). This is very small for
liquids due to proportionality to 1/d^2, but can be problematic for gases that are
modeled incompressible.
</p>
<p>It should be noted that incompressible media only have 1 state per control volume (usually T),
but have both T and p as inputs for fully correct properties. The error of using only T-dependent
properties is small, therefore a Boolean flag enthalpyOfT exists. If it is true, the
enumeration Choices.IndependentVariables is set to Choices.IndependentVariables.T otherwise
it is set to Choices.IndependentVariables.pT.</p>
<p>
Enthalpy is never a function of T only (h = h(T) + (p-reference_p)/d), but the
error is also small and non-linear systems can be avoided. In particular,
non-linear systems are small and local as opposed to large and over all volumes.
</p>

<p>
Entropy is calculated as
</p>
<blockquote><pre>
s = s0 + integral(Cp(T)/T,dt)
</pre></blockquote>
<p>
which is only exactly true for a fluid with constant density d=d0.
</p>
</html>"));
    end BaseProperties;

    redeclare function extends setState_pTX
      "Returns state record, given pressure and temperature"
    algorithm
      state := ThermodynamicState(p=p,T=T);
      annotation(smoothOrder=3);
    end setState_pTX;

    redeclare function extends setState_dTX
      "Returns state record, given pressure and temperature"
    algorithm
      assert(false, "For incompressible media with d(T) only, state can not be set from density and temperature");
    end setState_dTX;

    function setState_pT "Returns state record as function of p and T"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      output ThermodynamicState state "Thermodynamic state";
    algorithm
      state.T := T;
      state.p := p;
      annotation(smoothOrder=3);
    end setState_pT;

    redeclare function extends setState_phX
      "Returns state record, given pressure and specific enthalpy"
    algorithm
      state :=ThermodynamicState(p=p,T=T_ph(p,h));
      annotation(Inline=true,smoothOrder=3);
    end setState_phX;

    function setState_ph "Returns state record as function of p and h"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      output ThermodynamicState state "Thermodynamic state";
    algorithm
      state :=ThermodynamicState(p=p,T=T_ph(p,h));
      annotation(Inline=true,smoothOrder=3);
    end setState_ph;

    redeclare function extends setState_psX
      "Returns state record, given pressure and specific entropy"
    algorithm
      state :=ThermodynamicState(p=p,T=T_ps(p,s));
      annotation(Inline=true,smoothOrder=3);
    end setState_psX;

    function setState_ps "Returns state record as function of p and s"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      output ThermodynamicState state "Thermodynamic state";
    algorithm
      state :=ThermodynamicState(p=p,T=T_ps(p,s));
      annotation(Inline=true,smoothOrder=3);
    end setState_ps;

    redeclare function extends setSmoothState
      "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
    algorithm
      state :=ThermodynamicState(p=Media.Common.smoothStep(x, state_a.p, state_b.p, x_small),
                                 T=Media.Common.smoothStep(x, state_a.T, state_b.T, x_small));
      annotation(Inline=true,smoothOrder=3);
    end setSmoothState;

    redeclare function extends specificHeatCapacityCv
      "Specific heat capacity at constant volume (or pressure) of medium"

    algorithm
      assert(hasHeatCapacity,"Specific Heat Capacity, Cv, is not defined for medium "
                                             + mediumName + ".");
      cv := Polynomials.evaluate(poly_Cp,if TinK then state.T else state.T - 273.15);
     annotation(smoothOrder=2);
    end specificHeatCapacityCv;

    redeclare function extends specificHeatCapacityCp
      "Specific heat capacity at constant volume (or pressure) of medium"

    algorithm
      assert(hasHeatCapacity,"Specific Heat Capacity, Cv, is not defined for medium "
                                             + mediumName + ".");
      cp := Polynomials.evaluate(poly_Cp,if TinK then state.T else state.T - 273.15);
     annotation(smoothOrder=2);
    end specificHeatCapacityCp;

    redeclare function extends dynamicViscosity
      "Return dynamic viscosity as a function of the thermodynamic state record"

    algorithm
      assert(size(tableViscosity,1)>0,"DynamicViscosity, eta, is not defined for medium "
                                             + mediumName + ".");
      eta := Math.exp(Polynomials.evaluate(poly_eta, 1/state.T));
     annotation(smoothOrder=2);
    end dynamicViscosity;

    redeclare function extends thermalConductivity
      "Return thermal conductivity as a function of the thermodynamic state record"

    algorithm
      assert(size(tableConductivity,1)>0,"ThermalConductivity, lambda, is not defined for medium "
                                             + mediumName + ".");
      lambda := Polynomials.evaluate(poly_lam,if TinK then state.T else Cv.to_degC(state.T));
     annotation(smoothOrder=2);
    end thermalConductivity;

    function s_T "Compute specific entropy"
      extends Modelica.Icons.Function;
      input Temperature T "Temperature";
      output SpecificEntropy s "Specific entropy";
    algorithm
      s := s0 + (if TinK then
        Polynomials.integralValue(poly_Cp[1:npol],T, T0) else
        Polynomials.integralValue(poly_Cp[1:npol],Cv.to_degC(T),Cv.to_degC(T0)))
        + Modelica.Math.log(T/T0)*
        Polynomials.evaluate(poly_Cp,if TinK then 0 else Modelica.Constants.T_zero);
     annotation(Inline=true,smoothOrder=2);
    end s_T;

    redeclare function extends specificEntropy
      "Return specific entropy as a function of the thermodynamic state record"

    protected
      Integer npol=size(poly_Cp,1)-1;
    algorithm
      assert(hasHeatCapacity,"Specific Entropy, s(T), is not defined for medium "
                                             + mediumName + ".");
      s := s_T(state.T);
     annotation(smoothOrder=2);
    end specificEntropy;

    function h_T "Compute specific enthalpy from temperature"
      import Modelica.Units.Conversions.to_degC;
      extends Modelica.Icons.Function;
      input SI.Temperature T "Temperature";
      output SI.SpecificEnthalpy h "Specific enthalpy at p, T";
    algorithm
      h :=h0 + Polynomials.integralValue(poly_Cp, if TinK then T else Cv.to_degC(T), if TinK then
      T0 else Cv.to_degC(T0));
     annotation(derivative=h_T_der);
    end h_T;

    function h_T_der "Compute specific enthalpy from temperature"
      import Modelica.Units.Conversions.to_degC;
      extends Modelica.Icons.Function;
      input SI.Temperature T "Temperature";
      input Real dT "Temperature derivative";
      output Real dh "Derivative of Specific enthalpy at T";
    algorithm
      dh :=Polynomials.evaluate(poly_Cp, if TinK then T else Cv.to_degC(T))*dT;
     annotation(smoothOrder=1);
    end h_T_der;

    function h_pT "Compute specific enthalpy from pressure and temperature"
      import Modelica.Units.Conversions.to_degC;
      extends Modelica.Icons.Function;
      input SI.Pressure p "Pressure";
      input SI.Temperature T "Temperature";
      input Boolean densityOfT = false "Include or neglect density derivative dependence of enthalpy";
      output SI.SpecificEnthalpy h "Specific enthalpy at p, T";
    algorithm
      h :=h0 + Polynomials.integralValue(poly_Cp, if TinK then T else Cv.to_degC(T), if TinK then
      T0 else Cv.to_degC(T0)) + (p - reference_p)/Polynomials.evaluate(poly_rho, if TinK then
              T else Cv.to_degC(T))
        *(if densityOfT then (1 + T/Polynomials.evaluate(poly_rho, if TinK then T else Cv.to_degC(T))
      *Polynomials.derivativeValue(poly_rho,if TinK then T else Cv.to_degC(T))) else 1.0);
     annotation(smoothOrder=2);
    end h_pT;

    function density_T "Return density as function of temperature"
      extends Modelica.Icons.Function;

      input Temperature T "Temperature";
      output Density d "Density";
    algorithm
      d := Polynomials.evaluate(poly_rho,if TinK then T else Cv.to_degC(T));
      annotation(Inline=true,smoothOrder=2);
    end density_T;

    redeclare function extends temperature
      "Return temperature as a function of the thermodynamic state record"
    algorithm
     T := state.T;
     annotation(Inline=true,smoothOrder=2);
    end temperature;

    redeclare function extends pressure
      "Return pressure as a function of the thermodynamic state record"
    algorithm
     p := state.p;
     annotation(Inline=true,smoothOrder=2);
    end pressure;

    redeclare function extends density
      "Return density as a function of the thermodynamic state record"
    algorithm
      d := Polynomials.evaluate(poly_rho,if TinK then state.T else Cv.to_degC(state.T));
     annotation(Inline=true,smoothOrder=2);
    end density;

    redeclare function extends specificEnthalpy
      "Return specific enthalpy as a function of the thermodynamic state record"
    algorithm
      h := specificEnthalpyOfT(state.p, state.T);
     annotation(Inline=true,smoothOrder=2);
    end specificEnthalpy;

    redeclare function extends specificInternalEnergy
      "Return specific internal energy as a function of the thermodynamic state record"
    algorithm
      u := specificEnthalpyOfT(state.p,state.T) - (if singleState then reference_p else state.p)/density(state);
     annotation(Inline=true,smoothOrder=2);
    end specificInternalEnergy;

    function T_ph "Compute temperature from pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      output Temperature T "Temperature";

    protected
      function f_nonlinear "Solve specificEnthalpyOfT(p,T) for T with given h"
        extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
      algorithm
        y := specificEnthalpyOfT(p=p, T=u) - h;
      end f_nonlinear;

    algorithm
      T := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
        function f_nonlinear(p=p, h=h), T_min, T_max);
      annotation(Inline=false, LateInline=true, inverse(h=specificEnthalpyOfT(p,T)));
    end T_ph;

    function T_ps "Compute temperature from pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure (unused)";
      input SpecificEntropy s "Specific entropy";
      output Temperature T "Temperature";

    protected
      function f_nonlinear "Solve s_T(T) for T with given s"
        extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
        input SpecificEntropy s "Specific entropy";
      algorithm
        y := s_T(T=u) - s;
      end f_nonlinear;

    algorithm
      T := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
        function f_nonlinear(s=s), T_min, T_max);
    end T_ps;

  protected
    function specificEnthalpyOfT
      "Return specific enthalpy from pressure and temperature, taking the flag enthalpyOfT into account"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input Boolean densityOfT = false "Include or neglect density derivative dependence of enthalpy";
      output SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := if enthalpyOfT then h_T(T) else h_pT(p, T, densityOfT);
      annotation(Inline=true,smoothOrder=2);
    end specificEnthalpyOfT;

  annotation(Documentation(info="<html>
<p>
This is the base package for medium models of incompressible fluids based on
tables. The minimal data to provide for a useful medium description is tables
of density and heat capacity as functions of temperature.
</p>

<p>It should be noted that incompressible media only have 1 state per control volume (usually T),
but have both T and p as inputs for fully correct properties. The error of using only T-dependent
properties is small, therefore a Boolean flag enthalpyOfT exists. If it is true, the
enumeration Choices.IndependentVariables is set to Choices.IndependentVariables.T otherwise
it is set to Choices.IndependentVariables.pT.</p>

<h4>Using the package TableBased</h4>
<p>
To implement a new medium model, create a package that <strong>extends</strong> TableBased
and provides one or more of the constant tables:
</p>

<blockquote><pre>
tableDensity        = [T, d];
tableHeatCapacity   = [T, Cp];
tableConductivity   = [T, lam];
tableViscosity      = [T, eta];
tableVaporPressure  = [T, pVap];
</pre></blockquote>

<p>
The table data is used to fit constant polynomials of order <strong>npol</strong>, the
temperature data points do not need to be same for different properties. Properties
like enthalpy, inner energy and entropy are calculated consistently from integrals
and derivatives of d(T) and Cp(T). The minimal
data for a useful medium model is thus density and heat capacity. Transport
properties and vapor pressure are optional, if the data tables are empty the corresponding
function calls can not be used.
</p>
</html>"));
  end TableBased;

  annotation (
    Documentation(info="<html>
<h4>Incompressible media package</h4>
<p>
This package provides a structure and examples of how to create simple
medium models of incompressible fluids, meaning fluids with very little
pressure influence on density. The medium properties is typically described
in terms of tables, functions or polynomial coefficients.
</p>
<h4>Definitions</h4>
<p>
The common meaning of <em>incompressible</em> is that properties like density
and enthalpy are independent of pressure. Thus properties are conveniently
described as functions of temperature, e.g., as polynomials density(T) and cp(T).
However, enthalpy and inner energy can not both be independent of pressure since h = u + p/d.
(Normally when T is held constant dh/dp&ge;0 and du/dp&le;0.)
For liquids it is anyway common to neglect this dependence for
both of them since for constant density the neglected term is (p - p0)/d,
which in comparison with cp is very small for most liquids. For
water, the equivalent change of temperature to increasing pressure 1 bar is
0.025 Kelvin.
</p>
<p>
Two Boolean flags are used to choose how enthalpy and inner energy is calculated:
</p>
<ul>
<li><strong>enthalpyOfT</strong>=true, means assuming that enthalpy is only a function
of temperature, neglecting the pressure dependent term.</li>
<li><strong>singleState</strong>=true, means also neglect the pressure influence on inner
energy, which makes all medium properties pure functions of temperature.</li>
</ul>
<p>
The default setting for both these flags is true, which enables the simulation tool
to choose temperature as the only medium state and avoids non-linear equation
systems, see the section about
<a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.StaticStateSelection\">Static
state selection</a> in the Modelica.Media User's Guide.
</p>

<h4>Contents</h4>
<p>
Currently, the package contains the following parts:
</p>
<ol>
<li> <a href=\"modelica://Modelica.Media.Incompressible.TableBased\">
      Table based medium models</a></li>
<li> <a href=\"modelica://Modelica.Media.Incompressible.Examples\">
      Example medium models</a></li>
</ol>

<p>
A few examples are given in the Examples package. The model
<a href=\"modelica://Modelica.Media.Incompressible.Examples.Glycol47\">
Examples.Glycol47</a> shows how the medium models can be used. For more
realistic examples of how to implement volume models with medium properties
look in the <a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage\">Medium
usage section</a> of the User's Guide.
</p>

</html>"));

end Incompressible;
