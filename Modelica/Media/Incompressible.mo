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
    constant Modelica.SIunits.Time timeUnit = 1;
    constant Modelica.SIunits.Temperature Ta = 1;
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
    import Poly = Modelica.Media.Incompressible.TableBased.Polynomials_Temp;

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
    constant Modelica.SIunits.Temperature T_min
      "Minimum temperature valid for medium model";
    constant Modelica.SIunits.Temperature T_max
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
                                         Poly.fitting(tableDensity[:,1],tableDensity[:,2],npolDensity) else
                                           zeros(npolDensity+1);
    final constant Real poly_Cp[:] = if hasHeatCapacity then
                                         Poly.fitting(tableHeatCapacity[:,1],tableHeatCapacity[:,2],npolHeatCapacity) else
                                           zeros(npolHeatCapacity+1);
    final constant Real poly_eta[:] = if hasViscosity then
                                         Poly.fitting(invTK, Math.log(tableViscosity[:,2]),npolViscosity) else
                                           zeros(npolViscosity+1);
    final constant Real poly_pVap[:] = if hasVaporPressure then
                                         Poly.fitting(tableVaporPressure[:,1],tableVaporPressure[:,2],npolVaporPressure) else
                                            zeros(npolVaporPressure+1);
    final constant Real poly_lam[:] = if size(tableConductivity,1)>0 then
                                         Poly.fitting(tableConductivity[:,1],tableConductivity[:,2],npolConductivity) else
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
    //  redeclare parameter SpecificHeatCapacity R=Modelica.Constants.R,

      SI.SpecificHeatCapacity cp "Specific heat capacity";
      parameter SI.Temperature T_start = 298.15 "Initial temperature";
    equation
      assert(hasDensity,"Medium " + mediumName +
                        " can not be used without assigning tableDensity.");
      assert(T >= T_min and T <= T_max, "Temperature T (= " + String(T) +
             " K) is not in the allowed range (" + String(T_min) +
             " K <= T <= " + String(T_max) + " K) required from medium model \""
             + mediumName + "\".");
      R = Modelica.Constants.R/MM_const;
      cp = Poly.evaluate(poly_Cp,if TinK then T else T_degC);
      h = if enthalpyOfT then h_T(T) else  h_pT(p,T,densityOfT);
      u = h - (if singleState then  reference_p/d else state.p/d);
      d = Poly.evaluate(poly_rho,if TinK then T else T_degC);
      state.T = T;
      state.p = p;
      MM = MM_const;
      annotation(Documentation(info="<html>
<p>
Note that the inner energy neglects the pressure dependence, which is only
true for an incompressible medium with d = constant. The neglected term is
p-reference_p)/rho*(T/rho)*(partial rho /partial T). This is very small for
liquids due to proportionality to 1/d^2, but can be problematic for gases that are
modeled incompressible.
</p>
<p>It should be noted that incompressible media only have 1 state per control volume (usually T),
but have both T and p as inputs for fully correct properties. The error of using only T-dependent
properties is small, therefore a Boolean flag enthalpyOfT exists. If it is true, the
enumeration Choices.independentVariables  is set to  Choices.independentVariables.T otherwise
it is set to Choices.independentVariables.pT.</p>
<p>
Enthalpy is never a function of T only (h = h(T) + (p-reference_p)/d), but the
error is also small and non-linear systems can be avoided. In particular,
non-linear systems are small and local as opposed to large and over all volumes.
</p>

<p>
Entropy is calculated as
</p>
<pre>
  s = s0 + integral(Cp(T)/T,dt)
</pre>
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
      cv := Poly.evaluate(poly_Cp,if TinK then state.T else state.T - 273.15);
     annotation(smoothOrder=2);
    end specificHeatCapacityCv;

    redeclare function extends specificHeatCapacityCp
      "Specific heat capacity at constant volume (or pressure) of medium"

    algorithm
      assert(hasHeatCapacity,"Specific Heat Capacity, Cv, is not defined for medium "
                                             + mediumName + ".");
      cp := Poly.evaluate(poly_Cp,if TinK then state.T else state.T - 273.15);
     annotation(smoothOrder=2);
    end specificHeatCapacityCp;

    redeclare function extends dynamicViscosity
      "Return dynamic viscosity as a function of the thermodynamic state record"

    algorithm
      assert(size(tableViscosity,1)>0,"DynamicViscosity, eta, is not defined for medium "
                                             + mediumName + ".");
      eta := Math.exp(Poly.evaluate(poly_eta, 1/state.T));
     annotation(smoothOrder=2);
    end dynamicViscosity;

    redeclare function extends thermalConductivity
      "Return thermal conductivity as a function of the thermodynamic state record"

    algorithm
      assert(size(tableConductivity,1)>0,"ThermalConductivity, lambda, is not defined for medium "
                                             + mediumName + ".");
      lambda := Poly.evaluate(poly_lam,if TinK then state.T else Cv.to_degC(state.T));
     annotation(smoothOrder=2);
    end thermalConductivity;

    function s_T "Compute specific entropy"
      extends Modelica.Icons.Function;
      input Temperature T "Temperature";
      output SpecificEntropy s "Specific entropy";
    algorithm
      s := s0 + (if TinK then
        Poly.integralValue(poly_Cp[1:npol],T, T0) else
        Poly.integralValue(poly_Cp[1:npol],Cv.to_degC(T),Cv.to_degC(T0)))
        + Modelica.Math.log(T/T0)*
        Poly.evaluate(poly_Cp,if TinK then 0 else Modelica.Constants.T_zero);
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
      import Modelica.SIunits.Conversions.to_degC;
      extends Modelica.Icons.Function;
      input SI.Temperature T "Temperature";
      output SI.SpecificEnthalpy h "Specific enthalpy at p, T";
    algorithm
      h :=h0 + Poly.integralValue(poly_Cp, if TinK then T else Cv.to_degC(T), if TinK then
      T0 else Cv.to_degC(T0));
     annotation(derivative=h_T_der);
    end h_T;

    function h_T_der "Compute specific enthalpy from temperature"
      import Modelica.SIunits.Conversions.to_degC;
      extends Modelica.Icons.Function;
      input SI.Temperature T "Temperature";
      input Real dT "Temperature derivative";
      output Real dh "Derivative of Specific enthalpy at T";
    algorithm
      dh :=Poly.evaluate(poly_Cp, if TinK then T else Cv.to_degC(T))*dT;
     annotation(smoothOrder=1);
    end h_T_der;

    function h_pT "Compute specific enthalpy from pressure and temperature"
      import Modelica.SIunits.Conversions.to_degC;
      extends Modelica.Icons.Function;
      input SI.Pressure p "Pressure";
      input SI.Temperature T "Temperature";
      input Boolean densityOfT = false
        "Include or neglect density derivative dependence of enthalpy" annotation(Evaluate);
      output SI.SpecificEnthalpy h "Specific enthalpy at p, T";
    algorithm
      h :=h0 + Poly.integralValue(poly_Cp, if TinK then T else Cv.to_degC(T), if TinK then
      T0 else Cv.to_degC(T0)) + (p - reference_p)/Poly.evaluate(poly_rho, if TinK then
              T else Cv.to_degC(T))
        *(if densityOfT then (1 + T/Poly.evaluate(poly_rho, if TinK then T else Cv.to_degC(T))
      *Poly.derivativeValue(poly_rho,if TinK then T else Cv.to_degC(T))) else 1.0);
     annotation(smoothOrder=2);
    end h_pT;

    function density_T "Return density as function of temperature"
      extends Modelica.Icons.Function;

      input Temperature T "Temperature";
      output Density d "Density";
    algorithm
      d := Poly.evaluate(poly_rho,if TinK then T else Cv.to_degC(T));
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
      d := Poly.evaluate(poly_rho,if TinK then state.T else Cv.to_degC(state.T));
     annotation(Inline=true,smoothOrder=2);
    end density;

    redeclare function extends specificEnthalpy
      "Return specific enthalpy as a function of the thermodynamic state record"
    algorithm
      h := if enthalpyOfT then h_T(state.T) else h_pT(state.p,state.T);
     annotation(Inline=true,smoothOrder=2);
    end specificEnthalpy;

    redeclare function extends specificInternalEnergy
      "Return specific internal energy as a function of the thermodynamic state record"
    algorithm
      u := (if enthalpyOfT then h_T(state.T) else h_pT(state.p,state.T)) - (if singleState then  reference_p else state.p)/density(state);
     annotation(Inline=true,smoothOrder=2);
    end specificInternalEnergy;

    function T_ph "Compute temperature from pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      output Temperature T "Temperature";
    protected
      package Internal
        "Solve h(T) for T with given h (use only indirectly via temperature_phX)"
        extends Modelica.Media.Common.OneNonLinearEquation;

        redeclare record extends f_nonlinear_Data
          "Superfluous record, fix later when better structure of inverse functions exists"
            constant Real[5] dummy = {1,2,3,4,5};
        end f_nonlinear_Data;

        redeclare function extends f_nonlinear "P is smuggled in via vector"
        algorithm
          y := if singleState then h_T(x) else h_pT(p,x);
        end f_nonlinear;

      end Internal;
    algorithm
     T := Internal.solve(h, T_min, T_max, p, {1}, Internal.f_nonlinear_Data());
      annotation(Inline=false, LateInline=true, inverse(h=h_pT(p,T)));
    end T_ph;

    function T_ps "Compute temperature from pressure and specific enthalpy"
      extends Modelica.Icons.Function;

      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      output Temperature T "Temperature";
    protected
      package Internal
        "Solve h(T) for T with given h (use only indirectly via temperature_phX)"
        extends Modelica.Media.Common.OneNonLinearEquation;

        redeclare record extends f_nonlinear_Data
          "Superfluous record, fix later when better structure of inverse functions exists"
            constant Real[5] dummy = {1,2,3,4,5};
        end f_nonlinear_Data;

        redeclare function extends f_nonlinear "P is smuggled in via vector"
        algorithm
          y := s_T(x);
        end f_nonlinear;

      end Internal;
    algorithm
     T := Internal.solve(s, T_min, T_max, p, {1}, Internal.f_nonlinear_Data());
    end T_ps;

    package Polynomials_Temp
      "Temporary Functions operating on polynomials (including polynomial fitting); only to be used in Modelica.Media.Incompressible.TableBased"
      extends Modelica.Icons.Package;

      function evaluate "Evaluate polynomial at a given abscissa value"
        extends Modelica.Icons.Function;
        input Real p[:]
          "Polynomial coefficients (p[1] is coefficient of highest power)";
        input Real u "Abscissa value";
        output Real y "Value of polynomial at u";
      algorithm
        y := p[1];
        for j in 2:size(p, 1) loop
          y := p[j] + u*y;
        end for;
        annotation(derivative(zeroDerivative=p)=evaluate_der);
      end evaluate;

      function evaluateWithRange
        "Evaluate polynomial at a given abscissa value with linear extrapolation outside of the defined range"
        extends Modelica.Icons.Function;
        input Real p[:]
          "Polynomial coefficients (p[1] is coefficient of highest power)";
        input Real uMin "Polynomial valid in the range uMin .. uMax";
        input Real uMax "Polynomial valid in the range uMin .. uMax";
        input Real u "Abscissa value";
        output Real y
          "Value of polynomial at u. Outside of uMin,uMax, linear extrapolation is used";
      algorithm
        if u < uMin then
          y := evaluate(p, uMin) - evaluate_der(
                  p,
                  uMin,
                  uMin - u);
        elseif u > uMax then
          y := evaluate(p, uMax) + evaluate_der(
                  p,
                  uMax,
                  u - uMax);
        else
          y := evaluate(p, u);
        end if;
        annotation (derivative(
            zeroDerivative=p,
            zeroDerivative=uMin,
            zeroDerivative=uMax) = evaluateWithRange_der);
      end evaluateWithRange;

      function derivative "Derivative of polynomial"
        extends Modelica.Icons.Function;
        input Real p1[:]
          "Polynomial coefficients (p1[1] is coefficient of highest power)";
        output Real p2[size(p1, 1) - 1] "Derivative of polynomial p1";
      protected
        Integer n=size(p1, 1);
      algorithm
        for j in 1:n-1 loop
          p2[j] := p1[j]*(n - j);
        end for;
      end derivative;

      function derivativeValue
        "Value of derivative of polynomial at abscissa value u"
        extends Modelica.Icons.Function;
        input Real p[:]
          "Polynomial coefficients (p[1] is coefficient of highest power)";
        input Real u "Abscissa value";
        output Real y "Value of derivative of polynomial at u";
      protected
        Integer n=size(p, 1);
      algorithm
        y := p[1]*(n - 1);
        for j in 2:size(p, 1)-1 loop
          y := p[j]*(n - j) + u*y;
        end for;
        annotation(derivative(zeroDerivative=p)=derivativeValue_der);
      end derivativeValue;

      function secondDerivativeValue
        "Value of 2nd derivative of polynomial at abscissa value u"
        extends Modelica.Icons.Function;
        input Real p[:]
          "Polynomial coefficients (p[1] is coefficient of highest power)";
        input Real u "Abscissa value";
        output Real y "Value of 2nd derivative of polynomial at u";
      protected
        Integer n=size(p, 1);
      algorithm
        y := p[1]*(n - 1)*(n - 2);
        for j in 2:size(p, 1)-2 loop
          y := p[j]*(n - j)*(n - j - 1) + u*y;
        end for;
      end secondDerivativeValue;

      function integral "Indefinite integral of polynomial p(u)"
        extends Modelica.Icons.Function;
        input Real p1[:]
          "Polynomial coefficients (p1[1] is coefficient of highest power)";
        output Real p2[size(p1, 1) + 1]
          "Polynomial coefficients of indefinite integral of polynomial p1 (polynomial p2 + C is the indefinite integral of p1, where C is an arbitrary constant)";
      protected
        Integer n=size(p1, 1) + 1 "Degree of output polynomial";
      algorithm
        for j in 1:n-1 loop
          p2[j] := p1[j]/(n-j);
        end for;
        p2[n] := 0.0;
      end integral;

      function integralValue "Integral of polynomial p(u) from u_low to u_high"
        extends Modelica.Icons.Function;
        input Real p[:] "Polynomial coefficients";
        input Real u_high "High integrand value";
        input Real u_low=0 "Low integrand value, default 0";
        output Real integral=0.0
          "Integral of polynomial p from u_low to u_high";
      protected
        Integer n=size(p, 1) "Degree of integrated polynomial";
        Real y_low=0 "Value at lower integrand";
      algorithm
        for j in 1:n loop
          integral := u_high*(p[j]/(n - j + 1) + integral);
          y_low := u_low*(p[j]/(n - j + 1) + y_low);
        end for;
        integral := integral - y_low;
        annotation(derivative(zeroDerivative=p)=integralValue_der);
      end integralValue;

      function fitting
        "Computes the coefficients of a polynomial that fits a set of data points in a least-squares sense"
        extends Modelica.Icons.Function;
        input Real u[:] "Abscissa data values";
        input Real y[size(u, 1)] "Ordinate data values";
        input Integer n(min=1)
          "Order of desired polynomial that fits the data points (u,y)";
        output Real p[n + 1]
          "Polynomial coefficients of polynomial that fits the date points";
      protected
        Real V[size(u, 1), n + 1] "Vandermonde matrix";
      algorithm
        // Construct Vandermonde matrix
        V[:, n + 1] := ones(size(u, 1));
        for j in n:-1:1 loop
          V[:, j] := {u[i] * V[i, j + 1] for i in 1:size(u,1)};
        end for;

        // Solve least squares problem
        p :=Modelica.Math.Matrices.leastSquares(V, y);
        annotation (Documentation(info="<html>
<p>
Polynomials.fitting(u,y,n) computes the coefficients of a polynomial
p(u) of degree \"n\" that fits the data \"p(u[i]) - y[i]\"
in a least squares sense. The polynomial is
returned as a vector p[n+1] that has the following definition:
</p>
<pre>
  p(u) = p[1]*u^n + p[2]*u^(n-1) + ... + p[n]*u + p[n+1];
</pre>
</html>"));
      end fitting;

      function evaluate_der
        "Evaluate derivative of polynomial at a given abscissa value"
        extends Modelica.Icons.Function;
        input Real p[:]
          "Polynomial coefficients (p[1] is coefficient of highest power)";
        input Real u "Abscissa value";
        input Real du "Delta of abscissa value";
        output Real dy "Value of derivative of polynomial at u";
      protected
        Integer n=size(p, 1);
      algorithm
        dy := p[1]*(n - 1);
        for j in 2:size(p, 1)-1 loop
          dy := p[j]*(n - j) + u*dy;
        end for;
        dy := dy*du;
      end evaluate_der;

      function evaluateWithRange_der
        "Evaluate derivative of polynomial at a given abscissa value with extrapolation outside of the defined range"
        extends Modelica.Icons.Function;
        input Real p[:]
          "Polynomial coefficients (p[1] is coefficient of highest power)";
        input Real uMin "Polynomial valid in the range uMin .. uMax";
        input Real uMax "Polynomial valid in the range uMin .. uMax";
        input Real u "Abscissa value";
        input Real du "Delta of abscissa value";
        output Real dy "Value of derivative of polynomial at u";
      algorithm
        if u < uMin then
          dy := evaluate_der(
                  p,
                  uMin,
                  du);
        elseif u > uMax then
          dy := evaluate_der(
                  p,
                  uMax,
                  du);
        else
          dy := evaluate_der(
                  p,
                  u,
                  du);
        end if;
      end evaluateWithRange_der;

      function integralValue_der
        "Time derivative of integral of polynomial p(u) from u_low to u_high, assuming only u_high as time-dependent (Leibniz rule)"
        extends Modelica.Icons.Function;
        input Real p[:] "Polynomial coefficients";
        input Real u_high "High integrand value";
        input Real u_low=0 "Low integrand value, default 0";
        input Real du_high "High integrand value";
        input Real du_low=0 "Low integrand value, default 0";
        output Real dintegral=0.0
          "Integral of polynomial p from u_low to u_high";
      algorithm
        dintegral := evaluate(p,u_high)*du_high;
      end integralValue_der;

      function derivativeValue_der
        "Time derivative of derivative of polynomial"
        extends Modelica.Icons.Function;
        input Real p[:]
          "Polynomial coefficients (p[1] is coefficient of highest power)";
        input Real u "Abscissa value";
        input Real du "Delta of abscissa value";
        output Real dy
          "Time-derivative of derivative of polynomial w.r.t. input variable at u";
      protected
        Integer n=size(p, 1);
      algorithm
        dy := secondDerivativeValue(p,u)*du;
      end derivativeValue_der;
      annotation (Documentation(info="<html>
<p>
This package contains functions to operate on polynomials,
in particular to determine the derivative and the integral
of a polynomial and to use a polynomial to fit a given set
of data points.
</p>

<p>
Copyright &copy; 2004-2019, Modelica Association and contributors
</p>
</html>",     revisions="<html>
<ul>
<li><em>Oct. 22, 2004</em> by Martin Otter (DLR):<br>
       Renamed functions to not have abbreviations.<br>
       Based fitting on LAPACK<br>
       New function to return the polynomial of an indefinite integral</li>
<li><em>Sept. 3, 2004</em> by Jonas Eborn (Scynamics):<br>
       polyderval, polyintval added</li>
<li><em>March 1, 2004</em> by Martin Otter (DLR):<br>
       first version implemented</li>
</ul>
</html>"));
    end Polynomials_Temp;

  annotation(Documentation(info="<html>
<p>
This is the base package for medium models of incompressible fluids based on
tables. The minimal data to provide for a useful medium description is tables
of density and heat capacity as functions of temperature.
</p>

<p>It should be noted that incompressible media only have 1 state per control volume (usually T),
but have both T and p as inputs for fully correct properties. The error of using only T-dependent
properties is small, therefore a Boolean flag enthalpyOfT exists. If it is true, the
enumeration Choices.independentVariables  is set to  Choices.independentVariables.T otherwise
it is set to Choices.independentVariables.pT.</p>

<h4>Using the package TableBased</h4>
<p>
To implement a new medium model, create a package that <strong>extends</strong> TableBased
and provides one or more of the constant tables:
</p>

<pre>
tableDensity        = [T, d];
tableHeatCapacity   = [T, Cp];
tableConductivity   = [T, lam];
tableViscosity      = [T, eta];
tableVaporPressure  = [T, pVap];
</pre>

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
However, enthalpy can not be independent of pressure since h = u - p/d. For liquids
it is anyway
common to neglect this dependence since for constant density the neglected term
is (p - p0)/d, which in comparison with cp is very small for most liquids. For
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
