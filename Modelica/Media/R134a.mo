within Modelica.Media;
package R134a "R134a: Medium model for R134a"
  extends Modelica.Icons.VariantsPackage;
  package Common
    extends Modelica.Icons.Package;

    record PhaseBoundaryProperties
      "Thermodynamic base properties on the phase boundary"
      extends Modelica.Icons.Record;

      SI.Density d "Density";
      SI.SpecificEnthalpy h "Enthalpy";
      SI.SpecificEnergy u "Inner energy";
      SI.SpecificEntropy s "Entropy";
      SI.SpecificHeatCapacity cp
        "Heat capacity at constant pressure";
      SI.SpecificHeatCapacity cv
        "Heat capacity at constant volume";
      SI.IsothermalCompressibility kappa "Isentropic exponent";
      SI.Velocity a "Velocity of sound";
      Modelica.Media.Interfaces.Types.IsobaricExpansionCoefficient beta
        "Isobaric expansion coefficient";
      SI.IsentropicExponent gamma "Isentropic exponent";
      SI.DerPressureByTemperature pt
        "Derivative of pressure w.r.t. temperature";
      SI.DerPressureByDensity pd
        "Derivative of pressure w.r.t. density";

    end PhaseBoundaryProperties;

    record InverseDerivatives_rhoT
      "Derivatives required for inversion of density and temperature functions w.r.t. pressure and enthalpy states"
      extends Modelica.Icons.Record;

      Integer phase "Number of phases";
      SI.Pressure p "Pressure";
      SI.Temperature T "Kelvin-temperature";
      SI.Density rho "Density";
      SI.SpecificEnthalpy h "Specific enthalpy";
      SI.SpecificHeatCapacity cv
        "Specific heat capacity at constant volume";
      Real pt "Derivative of pressure w.r.t. temperature";
      Real pd "Derivative of pressure w.r.t. density";
      Real dpT "dp/dT derivative of saturation curve";

    end InverseDerivatives_rhoT;

    record EOSIdealCoeff
      "Record for coefficients of ideal term of Helmholtz equation of state"
      extends Modelica.Icons.Record;

      parameter Integer nc=5 "No. of coefficients in a";
      parameter Real[nc] a
        "Coefficients of ideal term of Helmholtz equation of state";

    end EOSIdealCoeff;

    record EOSResidualCoeff
      "Record for coefficients of residual term of Helmholtz equation of state"
      extends Modelica.Icons.Record;

      parameter Integer nc=20 "No. of coefficients in c, d, t, n";
      parameter Integer ns1 "No. of zero coefficients in c";
      parameter Real[nc] c
        "Coefficients of residual term of Helmholtz equation of state";
      parameter Real[nc] d
        "Coefficients of residual term of Helmholtz equation of state";
      parameter Real[nc] t
        "Coefficients of residual term of Helmholtz equation of state";
      parameter Real[nc] n
        "Coefficients of residual term of Helmholtz equation of state";

    end EOSResidualCoeff;

    function CubicSplineDerEval "Derivative of cubic spline"
      extends Modelica.Icons.Function;

      input Real x "Input";
      input Real[4] coefs "Spline coefficients";
      output Real yder "Spline derivative";
    algorithm
      yder := coefs[3] + x*(2.0*coefs[2] + x*3.0*coefs[1]);

    end CubicSplineDerEval;

    function CubicSplineEval "Cubic spline"
      extends Modelica.Icons.Function;

      input Real x "Input";
      input Real[4] coefs "Spline coefficients";
      output Real y "Output";
    algorithm
      y := coefs[4] + x*(coefs[3] + x*(coefs[2] + x*coefs[1]));

    end CubicSplineEval;

    function cv2Phase
      "Compute isochoric specific heat capacity inside the two-phase region"
      extends Modelica.Icons.Function;

      input PhaseBoundaryProperties liq "Properties on the boiling curve";
      input PhaseBoundaryProperties vap "Properties on the condensation curve";
      input SI.MassFraction x "Vapour mass fraction";
      input SI.Temperature T "Temperature";
      input SI.Pressure p "Pressure";
      output SI.SpecificHeatCapacity cv "Isochoric specific heat capacity";
      output Real dpT "Derivative of pressure w.r.t. temperature";
    protected
      Real dxv "Derivative of vapour mass fraction w.r.t. specific volume";
      Real dvTl "Derivative of liquid specific volume w.r.t. temperature";
      Real dvTv "Derivative of vapour specific volume w.r.t. temperature";
      Real duTl "Derivative of liquid specific inner energy w.r.t. temperature";
      Real duTv "Derivative of vapour specific inner energy w.r.t. temperature";
      Real dxt "Derivative of vapour mass fraction w.r.t. temperature";
    algorithm
      dxv := if (liq.d <> vap.d) then liq.d*vap.d/(liq.d - vap.d) else 0.0;
      dpT := (vap.s - liq.s)*dxv;
      // wrong at critical point
      dvTl := (liq.pt - dpT)/liq.pd/liq.d/liq.d;
      dvTv := (vap.pt - dpT)/vap.pd/vap.d/vap.d;
      dxt := -dxv*(dvTl + x*(dvTv - dvTl));
      duTl := liq.cv + (T*liq.pt - p)*dvTl;
      duTv := vap.cv + (T*vap.pt - p)*dvTv;
      cv := duTl + x*(duTv - duTl) + dxt*(vap.u - liq.u);

    end cv2Phase;

    function FindInterval "Half-interval search algorithm"
      extends Modelica.Icons.Function;

      input Real x "Input";
      input Real[:] breaks "Grid points defining the intervals";
      output Integer i "Found interval number";
      output Integer error=0 "1=did not find interval";
    protected
      Integer n=scalar(size(breaks)) - 1 "Max value";
      Integer ix=1 "Min value";
      Integer m=n "New interval";
    algorithm
      i := 1;
      if ((x < breaks[1]) or (x >= breaks[n])) then
        error := 1;
      end if;
      if ((x < breaks[1]) or (x >= breaks[2])) then
        while m <> ix loop
          if (x < breaks[m]) then
            n := m;
          else
            ix := m;
          end if;
          m := integer(div(ix + n, 2));
        end while;
        i := ix;
      end if;

    end FindInterval;

    function helmholtzToBoundaryProps
      "Calculate phase boundary property record from dimensionless Helmholtz function"

      extends Modelica.Icons.Function;

      input Modelica.Media.Common.HelmholtzDerivs f
        "Dimensionless derivatives of Helmholtz function";
      output PhaseBoundaryProperties sat "Phase boundary property record";
    protected
      SI.Pressure p "Pressure";
    algorithm
      p := f.R_s*f.d*f.T*f.delta*f.fdelta;
      sat.d := f.d;
      sat.h := f.R_s*f.T*(f.tau*f.ftau + f.delta*f.fdelta);
      sat.s := f.R_s*(f.tau*f.ftau - f.f);
      sat.u := f.R_s*f.T*f.tau*f.ftau;
      sat.cp := f.R_s*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau
        *f.fdeltatau)^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
      sat.cv := f.R_s*(-f.tau*f.tau*f.ftautau);
      sat.pt := f.R_s*f.d*(f.delta*(f.fdelta - f.tau*f.fdeltatau));
      sat.pd := f.R_s*f.T*(f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta));
      sat.a := abs(f.R_s*f.T*(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta
         - ((f.delta*f.fdelta - f.delta*f.tau*f.fdeltatau)*(f.delta*f.fdelta -
        f.delta*f.tau*f.fdeltatau))/(f.tau*f.tau*f.ftautau)))^0.5;
      sat.kappa := 1/(f.d*f.R_s*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta));
      sat.beta := f.R_s*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau)*sat.kappa;
      sat.gamma := sat.a^2/f.R_s/f.T;

    end helmholtzToBoundaryProps;
  end Common;

  package R134a_ph "Medium model for R134a and p,h as states"

    extends Modelica.Media.Interfaces.PartialTwoPhaseMedium(
      ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.ph,
      mediumName="R134a_ph",
      substanceNames={"tetrafluoroethane"},
      singleState=false,
      SpecificEnthalpy(start=h_default, nominal=5.0e5),
      Density(start=4, nominal=500),
      AbsolutePressure(start=p_default, nominal=10e5),
      Temperature(start=T_default, nominal=350),
      smoothModel=false,
      onePhase=false,
      fluidConstants=r134aConstants,
      h_default=420e3);

    constant Boolean ph_explicit=true;
    constant Boolean dT_explicit=false;
    constant Modelica.Media.Interfaces.Types.FluidLimits[1] r134aLimits(
      each TMIN=169.85,
      each TMAX=455,
      each DMIN=0,
      each DMAX=1591.7,
      each PMIN=389.563789,
      each PMAX=7e7,
      each HMIN=0,
      each HMAX=0,
      each SMIN=0,
      each SMAX=0);

    constant Modelica.Media.Interfaces.Types.TwoPhase.FluidConstants[1]
      r134aConstants(
      each chemicalFormula="CF3CH2F",
      each structureFormula="1,1,1,2-tetrafluoroethane",
      each iupacName="tetrafluoroethane",
      each casRegistryNumber="811-97-2",
      each molarMass=R134aData.data.MM,
      each criticalMolarVolume=R134aData.data.MM/R134aData.data.DCRIT,
      each criticalTemperature=R134aData.data.TCRIT,
      each criticalPressure=R134aData.data.PCRIT,
      each triplePointTemperature=R134aData.data.TTRIPLE,
      each triplePointPressure=R134aData.data.PTRIPLE,
      each meltingPoint=172.15,
      each normalBoilingPoint=247.076,
      each acentricFactor=0.32684,
      each dipoleMoment=1.99,
      each hasCriticalData=true);

    redeclare record extends SaturationProperties
    end SaturationProperties;

    redeclare record extends ThermodynamicState "Thermodynamic state"
      SpecificEnthalpy h "Specific enthalpy";
      Density d "Density";
      Temperature T "Temperature";
      AbsolutePressure p "Pressure";

    end ThermodynamicState;

    redeclare replaceable model extends BaseProperties(
      h(stateSelect=StateSelect.prefer),
      d(stateSelect=StateSelect.default),
      T(stateSelect=StateSelect.default),
      p(stateSelect=StateSelect.prefer),
      sat(Tsat(start=273.0), psat(start=3.0e5))) "Base properties of R134a"
      Integer phase(
        min=0,
        max=2,
        start=1,
        fixed=false) "2 for two-phase, 1 for one-phase, 0 if not known";
      MassFraction quality "Quality of vapour";

    equation
      MM = R134aData.data.MM;
      phase = 0;

      T = temperature_ph(p, h);
      d = density_ph(p, h);
      sat.Tsat = saturationTemperature(p=p);
      sat.psat = p;
      quality = vapourQuality(state);

      u = h - p/d;
      R_s = R134aData.data.R_s;
      h = state.h;
      p = state.p;
      T = state.T;
      d = state.d;
      phase = state.phase;
    end BaseProperties;

    redeclare function extends setState_phX
      "Set state for pressure and specific enthalpy (X not used since single substance)"
    algorithm
      state := ThermodynamicState(phase=getPhase_ph(p, h), p=p, h=h, d=density_ph(p, h), T=temperature_ph(p, h));
      annotation (Documentation(info="<html>
<p>This function should be used by default in order to calculate the thermodynamic state record used as input by many functions.</p>
<p>
Example:
</p>
<blockquote><pre>
parameter Medium.AbsolutePressure p = 3e5;
parameter Medium.SpecificEnthalpy h = 4.2e5;

Medium.Density rho;

<strong>equation</strong>

rho = Medium.density(setState_phX(p, h, fill(0, Medium.nX)));
</pre></blockquote>
</html>",     revisions="<html>
<p>2020-01-20 Stefan Wischhusen: Converted into single line assignment for state record.</p>
</html>"));
    end setState_phX;

    redeclare function extends setState_dTX
      "Set state for density and temperature (X not used since single substance)"
    protected
      Modelica.Media.Common.HelmholtzDerivs f "Helmholtz derivatives";
      SI.SpecificHeatCapacity R_s "Specific gas constant";
      SaturationProperties sat "Saturation temperature and pressure";
      SI.Density dl "Liquid density";
      SI.Density dv "Vapor density";

    algorithm
      R_s := R134aData.data.R_s;
      sat := setSat_T(T);
      dl := bubbleDensity(sat);
      dv := dewDensity(sat);
      if d < dl and d > dv and T < R134aData.data.FTCRIT then
        f := Modelica.Media.Common.HelmholtzDerivs(
          d=d, T=T, R_s=R_s, delta=0, tau=0, f=0, fdelta=0,
          fdeltadelta=0, ftau=0, ftautau=0, fdeltatau=0);
        state.p := saturationPressure_sat(sat);
        state.h := (dl*dv/d*(dewEnthalpy(sat) - bubbleEnthalpy(sat))
                  - dv*dewEnthalpy(sat) + dl*bubbleEnthalpy(sat))/(dl - dv);
        state.phase := 2;
      else
        f := f_R134a(d=d, T=T);
        state.p := d*R_s*T*f.delta*f.fdelta;
        state.h := R_s*T*(f.tau*f.ftau + f.delta*f.fdelta);
        state.phase := 1;
      end if;
      state.T := T;
      state.d := d;
      annotation (Documentation(revisions="<html>
<p>2019-12-20  Francesco Casella and Stefan Wischhusen: Two-phase calculation corrected.</p>
<p>2012-08-01  Stefan Wischhusen: Corrected passing-error of inputs.</p>
</html>", info="<html>
<p>Although the medium package is explicit for pressure and specific enthalpy, this function may be used in order to calculate the thermodynamic state record used as input by many functions. It will calculate the missing states:</p>
<ul>
<li>pressure</li>
<li>specific enthalpy</li>
</ul>
<p>
Example:
</p>
<blockquote><pre>
parameter Medium.Density d = 4;
parameter Medium.Temperature T = 298;

Medium.SpecificEntropy s;

<strong>equation</strong>

s = Medium.specificEntropy(setState_dTX(d, T, fill(0, Medium.nX)));
</pre></blockquote>

</html>"));
    end setState_dTX;

    redeclare function extends setState_psX
      "Set state for pressure and specific entropy (X not used since single substance)"

    protected
      SI.Pressure delp=1e-2 "Iteration accuracy for pressure";
      SI.SpecificEntropy dels=1e-1
        "Iteration accuracy for entropy";
      Integer error "If newton iteration fails (too many calls)";
      Modelica.Media.Common.HelmholtzDerivs f "Helmholtz derivatives";
      SaturationProperties sat "Saturation temperature and pressure";
    algorithm
      state.p := p;
      state.phase := getPhase_ps(p, s);
      if state.phase == 1 then
        (state.d, state.T, error) := dtofpsOnePhase(
              p=p,
              s=s,
              delp=delp,
              dels=dels);
        f := f_R134a(d=state.d, T=state.T);
        state.h := R134aData.R_s*state.T*(f.tau*f.ftau + f.delta*f.fdelta);
      else
        state.h := hofpsTwoPhase(p, s);
        (state.d, state.T) := dt_ph(p, state.h);
      end if;

      annotation (Documentation(info="<html>
<p>This function may be used in order to calculate the thermodynamic state record used as input by many functions. It will calculate the missing states:</p>
<ul>
<li>density</li>
<li>pressure</li>
<li>specific enthalpy</li>
</ul>
<p>
Example:
</p>
<blockquote><pre>
parameter Medium.AbsolutePressure p = 3e5;
parameter Medium.SpecificEntropy s = 1.7e3;

Medium.SpecificEnthalpy h;

<strong>equation</strong>

h = Medium.specificEnthalpy(setState_psX(p, s, fill(0, Medium.nX)));
</pre></blockquote>
</html>", revisions="<html>
<p>2020-02-05 Stefan Wischhusen: Added missing property calculation for d and T.</p>
</html>"));
    end setState_psX;

    redeclare function extends setState_pTX
      "Set state for pressure and temperature (X not used since single substance)"

    protected
        SI.Pressure delp=1.0e-2
        "Relative error in p in iteration";

    algorithm
      Modelica.Media.R134a.R134a_ph.phaseBoundaryAssert(p, T);

      state := ThermodynamicState(
              d=dofpT(p, T, delp),
              T=T,
              h=hofpT(p, T, delp),
              p=p,
              phase=1);
      annotation (Inline=true, Documentation(info="<html>
<p>This function should be used by default in order to calculate the thermodynamic state record used as input by many functions.</p>
<p>
Example:
</p>
<blockquote><pre>
parameter Medium.AbsolutePressure p = 3e5;
parameter Medium.Temperature T = 290;

Medium.Density rho;

<strong>equation</strong>

rho = Medium.density(setState_pTX(p, T, fill(0, Medium.nX)));
</pre></blockquote>
<p>
Please note, that in contrast to setState_phX, setState_dTX and setState_psX this function can not calculate properties in the two-phase region since pressure and temperature are dependent variables. A guard function will be called if the temperature difference to the phase boundary is lower than 1K or the pressure difference to the critical pressure is lower than 1000 Pa.
</p>
</html>"));
    end setState_pTX;

    redeclare function extends setBubbleState
      "Return the thermodynamic state on the bubble line"
    algorithm
      if sat.psat < Modelica.Media.R134a.R134aData.data.FPCRIT then
        state.p := sat.psat;
        state.T := saturationTemperature(sat.psat);
        state.d := bubbleDensity(sat);
        state.h := bubbleEnthalpy(sat);
      else
        assert(sat.psat < Modelica.Media.R134a.R134aData.data.FPCRIT,
          "Function setBubbleState is only valid in two-phase regime");
      end if;
      annotation (Documentation(info="<html>
<p>This function shall be used in order to calculate the thermodynamic state record for the liquid phase boundary. It requires the saturation record as input which can be determined by both functions setSat_p and setSat_T:
</p>
<p>
Example:
</p>
<blockquote><pre>
Medium.AbsolutePressure p=3e5;
// Viscosity on the liquid phase boundary
SI.DynamicViscosity eta_liq;

equation

eta_liq = Medium.DynamicViscosity(Medium.setBubbleState(Medium.setSat_p(p)));
</pre></blockquote>

<h4> Restrictions</h4>
<p>It is only valid in the two-phase region (i.e., p<sub>triple</sub> &le; p &le; p<sub>crit</sub> ).
</p>
</html>"));
    end setBubbleState;

    redeclare function extends setDewState
      "Return the thermodynamic state on the dew line"
    algorithm
      if sat.psat < Modelica.Media.R134a.R134aData.data.FPCRIT then
        state.p := sat.psat;
        state.T := saturationTemperature(sat.psat);
        state.d := dewDensity(sat);
        state.h := dewEnthalpy(sat);
      else
        assert(sat.psat < Modelica.Media.R134a.R134aData.data.FPCRIT,
          "Function setDewState is only valid in two-phase regime");
      end if;
      annotation (Documentation(info="<html>
<p>This function shall be used in order to calculate the thermodynamic state record for the vapor phase boundary. It requires the saturation record as input which can be determined by both functions setSat_p and setSat_T:
</p>
<p>
Example:
</p>
<blockquote><pre>
Medium.AbsolutePressure p=3e5;
// Viscosity on the vapor phase boundary
SI.DynamicViscosity eta_vap;

equation

eta_vap = Medium.DynamicViscosity(Medium.setBubbleState(Medium.setSat_p(p)));
</pre></blockquote>

<h4> Restrictions</h4>
<p>It is only valid in the two-phase region (i.e., p<sub>triple</sub> &le; p &le; p<sub>crit</sub> ).
</p>
</html>"));
    end setDewState;

    redeclare function density_ph
      "Density as function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input Integer phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
      output Density d "Density";

    algorithm
      d := rho_props_ph(
            p,
            h,
            derivsOf_ph(
              p,
              h,
              getPhase_ph(p, h)));

      annotation (Inline=true, Documentation(info="<html>
<p>This function calculates the density of R134a from the state variables p (absolute pressure) and h (specific enthalpy). The density is modelled by the fundamental equation of state of Tillner-Roth and Baehr (1994).</p>

<div><img src=\"modelica://Modelica/Resources/Images/Media/R134a/log(p)d-Diagram-R134a.png\"/></div>

</html>"));
    end density_ph;

    redeclare function extends density
      "Density as function of pressure and specific enthalpy | use setState_phX function for input"

    algorithm
      d := state.d;

      annotation (Inline=true, Documentation(info="<html>
<p>
This function calculates the density of R134a from the state record
(e.g., use setState_phX function for input). The density is modelled
by the fundamental equation of state of Tillner-Roth and Baehr (1994).
</p>

<div><img src=\"modelica://Modelica/Resources/Images/Media/R134a/log(p)d-Diagram-R134a.png\"/></div>
</html>"));
    end density;

    redeclare function temperature_ph
      "Temperature as function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input Integer phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
      output Temperature T "Temperature";

    algorithm
      T := T_props_ph(
            p,
            h,
            derivsOf_ph(
              p,
              h,
              getPhase_ph(p, h)));

      annotation (Inline=true, Documentation(info="<html>
<p>This function calculates the Kelvin temperature of R134a from the state variables p (absolute pressure) and h (specific enthalpy). The temperature is modelled by the fundamental equation of state of Tillner-Roth and Baehr (1994).</p>

<div><img src=\"modelica://Modelica/Resources/Images/Media/R134a/log(p)h-Diagram-R134a.png\"/></div>

</html>"));
    end temperature_ph;

    redeclare function extends temperature
      "Temperature as function of pressure and specific enthalpy | use setState_phX function for input"

    algorithm
      T := state.T;

      annotation (Inline=true, Documentation(info="<html>
<p>This function calculates the Kelvin temperature of R134a from the state record (e.g., use setState_phX function for input). The temperature is modelled by the fundamental equation of state of Tillner-Roth and Baehr (1994).</p>
<div><img src=\"modelica://Modelica/Resources/Images/Media/R134a/log(p)h-Diagram-R134a.png\"/></div>
</html>"));
    end temperature;

    redeclare function extends pressure "Pressure w.r.t. thermodynamic state"
    algorithm
      p := state.p;
      annotation (Inline=true, Documentation(info="<html>
<p>This function is included for the sake of completeness.</p>
<div><img src=\"modelica://Modelica/Resources/Images/Media/R134a/log(p)h-Diagram-R134a.png\"/></div>
</html>"));
    end pressure;

    redeclare function extends specificInternalEnergy
      "Specific internal energy w.r.t. thermodynamic state"
    algorithm
      u := specificEnthalpy(state) - pressure(state)/density(state);

      annotation (Inline=true, Documentation(info="<html>
<p>This function calculates the specific internal energy of R134a from the state record (e.g., use setState_phX function for input). The specific internal energy is modelled by the fundamental equation of state of Tillner-Roth and Baehr (1994).</p>
<div><img src=\"modelica://Modelica/Resources/Images/Media/R134a/log(p)u-Diagram-R134a.png\"/></div>

</html>"));
    end specificInternalEnergy;

    redeclare function extends specificEnthalpy
      "Specific enthalpy w.r.t. thermodynamic state | use setState_phX function for input"

    algorithm
      h := state.h;

      annotation (Inline=true, Documentation(info="<html>
<p>This function is included for the sake of completeness.</p>
<div><img src=\"modelica://Modelica/Resources/Images/Media/R134a/log(p)h-Diagram-R134a.png\"/></div>
</html>"));
    end specificEnthalpy;

    redeclare function extends specificEntropy
      "Specific entropy w.r.t. thermodynamic state | use setState_phX function for input if necessary"

    protected
      Modelica.Media.Common.HelmholtzDerivs f "Helmholtz derivatives";
      Common.PhaseBoundaryProperties liq "Properties on liquid phase boundary";
      SaturationProperties sat "Saturation temperature and pressure";
      Common.PhaseBoundaryProperties vap "Properties on vapor phase boundary";

      SI.MassFraction x "Vapor quality";

    algorithm
      if getPhase_ph(state.p, state.h) == 2 then
        sat.psat := state.p;
        sat.Tsat := saturationTemperature(state.p);
        liq := R134a_liqofdT(T=state.T);
        vap := R134a_vapofdT(T=state.T);
        x := if liq.h <> vap.h then (state.h - liq.h)/(vap.h - liq.h) else if
          state.h >= vap.h then 1 else 0;
        s := liq.s + x*(vap.s - liq.s);
      else
        f := f_R134a(state.d, state.T);
        s := R134aData.R_s*(f.tau*f.ftau - f.f);
      end if;

      annotation (Documentation(info="<html>
<p>This function calculates the specific entropy of R134a from the state record (e.g., use setState_phX function for input). The specific entropy is modelled by the fundamental equation of state of Tillner-Roth and Baehr (1994).</p>
<div><img src=\"modelica://Modelica/Resources/Images/Media/R134a/log(p)s-Diagram-R134a.png\"/></div>
</html>"));
    end specificEntropy;

    redeclare function extends saturationTemperature
      "Saturation temperature in two-phase region"

    protected
      constant Real T_coef[:, :]=R134aData.Tcoef
        "Coefficients of cubic spline for Tsat(p)";
      constant Real p_breaks[:]=R134aData.pbreaks
        "Grid points of reduced pressure";
      Integer int "Interval number";
      Integer error "Interval for spline interpolation not found";
      Real pred "Reduced pressure";
      Real localx "Abscissa of local spline";
    algorithm
      pred := p/R134aData.data.FPCRIT;
      (int,error) := Common.FindInterval(pred, p_breaks);
      localx := pred - p_breaks[int];
      T := Common.CubicSplineEval(localx, T_coef[int, :]);

      // annotation(smoothOrder=5);
      annotation (derivative=saturationTemperature_der_p, Documentation(info="<html>
<p>This function calculates the saturation temperature of R134a from the state variable p (absolute pressure). It is modelled by cubic splines which are fitted with non-equidistant grid points derived from
the fundamental equation of state of Tillner-Roth and Baehr (1994) and the Maxwell criteria.
</p>
<h4> Restrictions</h4>
<p>It is only valid in the two-phase region (i.e., p<sub>triple</sub> &le; p &le; p<sub>crit</sub> ).
</p>
<div><img src=\"modelica://Modelica/Resources/Images/Media/R134a/log(p)Tsat-Diagram-R134a.png\"/></div>
</html>"));
    end saturationTemperature;

    redeclare function extends saturationTemperature_derp
      "Derivative of saturation temperature in two-phase region"

    protected
      constant Real T_coef[:, :]=R134aData.Tcoef
        "Coefficients of cubic spline for Tsat(p)";
      constant Real p_breaks[:]=R134aData.pbreaks
        "Grid points of reduced pressure";
      Integer int "Interval number";
      Integer error "Interval for spline interpolation not found";
      Real pred "Reduced pressure";
      Real localx "Abscissa of local spline";
    algorithm
      pred := p/R134aData.data.FPCRIT;
      (int,error) := Common.FindInterval(pred, p_breaks);
      localx := pred - p_breaks[int];
      dTp := Common.CubicSplineDerEval(localx, T_coef[int, :])/R134aData.data.FPCRIT;

      annotation (Documentation(info="<html>
<p>This function calculates the derivative of saturation temperature of R134a with regard to the state variable p (absolute pressure). The non-derivative function is <a href=\"modelica://Modelica.Media.R134a.R134a_ph.saturationTemperature\"> saturatuionTemperature</a>.
</p>
<h4> Restrictions</h4>
<p>It is only valid in the two-phase region (i.e., p<sub>triple</sub> &le; p &le; p<sub>crit</sub> ).
</p>
</html>"));
    end saturationTemperature_derp;

    function saturationTemperature_der_p
      "Time derivative of saturation temperature in two-phase region"
      extends Modelica.Icons.Function;

      input SI.AbsolutePressure p "Pressure";
      input Real der_p "Time derivative of pressure";
      output Real der_Tsat "Time derivative of saturation temperature";
    protected
      constant Real T_coef[:, :]=R134aData.Tcoef
        "Coefficients of cubic spline for Tsat(p)";
      constant Real p_breaks[:]=R134aData.pbreaks
        "Grid points of reduced pressure";
      Integer int "Interval number";
      Integer error "Interval for spline interpolation not found";
      Real pred "Reduced pressure";
      Real localx "Abscissa of local spline";
    algorithm
      pred := p/R134aData.data.FPCRIT;
      (int,error) := Common.FindInterval(pred, p_breaks);
      localx := pred - p_breaks[int];
      der_Tsat := Common.CubicSplineDerEval(localx, T_coef[int, :])/R134aData.data.FPCRIT
        *der_p;

      annotation (Documentation(info="<html>
<p>This function calculates the time derivative of saturation temperature of R134a with regard to the time derivative of p. The non-derivative function is <a href=\"modelica://Modelica.Media.R134a.R134a_ph.saturationTemperature\"> saturatuionTemperature</a>.
</p>
<h4> Restrictions</h4>
<p>It is only valid in the two-phase region (i.e., p<sub>triple</sub> &le; p &le; p<sub>crit</sub> ).
</p>
</html>"));
    end saturationTemperature_der_p;

    redeclare function extends bubbleDensity
      "Density of liquid phase w.r.t. saturation pressure | use setSat_p function for input"

    protected
      constant Real dl_coef[:, :]=R134aData.dlcoef
        "Coefficients of cubic spline for d_liq(p)";
      constant Real p_breaks[:]=R134aData.pbreaks
        "Grid points of reduced pressure";
      Integer int "Interval number";
      Integer error "Interval for spline interpolation not found";
      Real pred "Reduced pressure";
      Real localx "Abscissa of local spline";
    algorithm
      pred := min(sat.psat/R134aData.data.FPCRIT, 1.0);
      (int,error) := Common.FindInterval(pred, p_breaks);
      localx := pred - p_breaks[int];
      dl := R134aData.data.FDCRIT*Common.CubicSplineEval(localx, dl_coef[int, 1
        :4]);

      // annotation(smoothOrder=5);
      annotation (derivative=dBubbleDensity_dPressure_der_sat, Documentation(
            info="<html>
<p>This function calculates the liquid phase density of R134a from the state variable p (absolute pressure). It is modelled by cubic splines which are fitted with non-equidistant grid points derived from
the fundamental equation of state of Tillner-Roth and Baehr (1994) and the Maxwell criteria.
</p>
<h4> Restrictions</h4>
<p>It is only valid in the two-phase region (i.e., p<sub>triple</sub> &le; p &le; p<sub>crit</sub> ).
</p>
</html>"));
    end bubbleDensity;

    redeclare function extends dBubbleDensity_dPressure
      "Derivative of liquid density in two-phase region w.r.t. pressure"

    protected
      constant Real dl_coef[:, :]=R134aData.dlcoef
        "Coefficients of cubic spline for d_liq(p)";
      constant Real p_breaks[:]=R134aData.pbreaks
        "Grid points of reduced pressure";
      Integer int "Interval number";
      Integer error "Interval for spline interpolation not found";
      Real pred "Reduced pressure";
      Real localx "Abscissa of local spline";
    algorithm
      pred := min(sat.psat/R134aData.data.FPCRIT, 1.0);
      (int,error) := Common.FindInterval(pred, p_breaks);
      localx := pred - p_breaks[int];
      ddldp := R134aData.data.FDCRIT*Common.CubicSplineDerEval(localx, dl_coef[
        int, 1:4])/R134aData.data.FPCRIT;

      annotation (Documentation(info="<html>
<p>This function calculates the derivative of liquid density of R134a in the two-phase region with regard to the state variable p (absolute pressure). The non-derivative function is <a href=\"modelica://Modelica.Media.R134a.R134a_ph.bubbleDensity\"> bubbleDensity</a>.
</p>
<h4> Restrictions</h4>
<p>It is only valid in the two-phase region (i.e., p<sub>triple</sub> &le; p &le; p<sub>crit</sub> ).
</p>
</html>"));
    end dBubbleDensity_dPressure;

    function dBubbleDensity_dPressure_der_sat
      "Time derivative of liquid density in two-phase region w.r.t. pressure"
      extends Modelica.Icons.Function;

      input SaturationProperties sat
        "Saturation properties | pressure is used for interpolation";
      input SaturationProperties der_sat "Derivative of saturation properties";
      output Real der_ddldp
        "Time derivative of liquid density in two-phase region w.r.t. pressure";
    protected
      constant Real dl_coef[:, :]=R134aData.dlcoef
        "Coefficients of cubic spline for d_liq(p)";
      constant Real p_breaks[:]=R134aData.pbreaks
        "Grid points of reduced pressure";
      Integer int "Interval number";
      Integer error "Interval for spline interpolation not found";
      Real pred "Reduced pressure";
      Real localx "Abscissa of local spline";
    algorithm
      pred := min(sat.psat/R134aData.data.FPCRIT, 1.0);
      (int,error) := Common.FindInterval(pred, p_breaks);
      localx := pred - p_breaks[int];
      der_ddldp := R134aData.data.FDCRIT*Common.CubicSplineDerEval(localx,
        dl_coef[int, 1:4])/R134aData.data.FPCRIT*der_sat.psat;

      annotation (Documentation(info="<html>
<p>This function calculates the time derivative of liquid density of R134a with regard to the time derivative of p. The non-derivative function is <a href=\"modelica://Modelica.Media.R134a.R134a_ph.bubbleDensity\"> bubbleDensity</a>.
</p>
<h4> Restrictions</h4>
<p>It is only valid in the two-phase region (i.e., p<sub>triple</sub> &le; p &le; p<sub>crit</sub> ).
</p>
</html>"));
    end dBubbleDensity_dPressure_der_sat;

    redeclare function extends dewDensity
      "Density of vapor phase w.r.t. saturation pressure | use setSat_p function for input"

    protected
      constant Real dv_coef[:, :]=R134aData.dvcoef
        "Coefficients of cubic spline for d_vap(p)";
      constant Real p_breaks[:]=R134aData.pbreaks
        "Grid points of reduced pressure";
      Integer int "Interval number";
      Integer error "Interval for spline interpolation not found";
      Real pred "Reduced pressure";
      Real localx "Abscissa of local spline";
    algorithm
      pred := min(sat.psat/R134aData.data.FPCRIT, 1.0);
      (int,error) := Common.FindInterval(pred, p_breaks);
      localx := pred - p_breaks[int];
      dv := R134aData.data.FDCRIT*Common.CubicSplineEval(localx, dv_coef[int, 1
        :4]);

      // annotation(smoothOrder=5);
      annotation (derivative=dDewDensity_dPressure_der_sat, Documentation(info="<html>
<p>This function calculates the vapor phase density of R134a from the state variable p (absolute pressure). It is modelled by cubic splines which are fitted with non-equidistant grid points derived from
the fundamental equation of state of Tillner-Roth and Baehr (1994) and the Maxwell criteria.
</p>
<h4> Restrictions</h4>
<p>It is only valid in the two-phase region (i.e., p<sub>triple</sub> &le; p &le; p<sub>crit</sub> ).
</p>
</html>"));
    end dewDensity;

    redeclare function extends dDewDensity_dPressure
      "Derivative of vapor density in two-phase region w.r.t. pressure"

    protected
      constant Real dv_coef[:, :]=R134aData.dvcoef
        "Coefficients of cubic spline for d_vap(p)";
      constant Real p_breaks[:]=R134aData.pbreaks
        "Grid points of reduced pressure";
      Integer int "Interval number";
      Integer error "Interval for spline interpolation not found";
      Real pred "Reduced pressure";
      Real localx "Abscissa of local spline";
    algorithm
      pred := min(sat.psat/R134aData.data.FPCRIT, 1.0);
      (int,error) := Common.FindInterval(pred, p_breaks);
      localx := pred - p_breaks[int];
      ddvdp := R134aData.data.FDCRIT*Common.CubicSplineDerEval(localx, dv_coef[
        int, 1:4])/R134aData.data.FPCRIT;

      annotation (Documentation(info="<html>
<p>This function calculates the derivative of vapor density of R134a in two-phase region with regard to the state variable p (absolute pressure). The non-derivative function is <a href=\"modelica://Modelica.Media.R134a.R134a_ph.dewDensity\"> dewDensity</a>.
</p>
<h4> Restrictions</h4>
<p>It is only valid in the two-phase region (i.e., p<sub>triple</sub> &le; p &le; p<sub>crit</sub> ).
</p>
</html>"));
    end dDewDensity_dPressure;

    function dDewDensity_dPressure_der_sat
      "Time derivative of vapor density in two-phase region w.r.t. pressure"
      extends Modelica.Icons.Function;

      input SaturationProperties sat
        "Saturation properties | pressure is used for interpolation";
      input SaturationProperties der_sat "Derivative of saturation properties";
      output Real der_ddvdp
        "Time derivative of vapor density in two-phase region w.r.t. pressure";
    protected
      constant Real dv_coef[:, :]=R134aData.dvcoef
        "Coefficients of cubic spline for d_vap(p)";
      constant Real p_breaks[:]=R134aData.pbreaks
        "Grid points of reduced pressure";
      Integer int "Interval number";
      Integer error "Interval for spline interpolation not found";
      Real pred "Reduced pressure";
      Real localx "Abscissa of local spline";
    algorithm
      pred := min(sat.psat/R134aData.data.FPCRIT, 1.0);
      (int,error) := Common.FindInterval(pred, p_breaks);
      localx := pred - p_breaks[int];
      der_ddvdp := R134aData.data.FDCRIT*Common.CubicSplineDerEval(localx,
        dv_coef[int, 1:4])/R134aData.data.FPCRIT*der_sat.psat;

      annotation (Documentation(info="<html>
<p>This function calculates the time derivative of vapor density of R134a with regard to the time derivative of p. The non-derivative function is <a href=\"modelica://Modelica.Media.R134a.R134a_ph.dewDensity\"> dewDensity</a>.
</p>
<h4> Restrictions</h4>
<p>It is only valid in the two-phase region (i.e., p<sub>triple</sub> &le; p &le; p<sub>crit</sub> ).
</p>
</html>"));
    end dDewDensity_dPressure_der_sat;

    redeclare function extends bubbleEnthalpy
      "Specific enthalpy of liquid phase w.r.t. saturation pressure | use setSat_p function for input"

    protected
      constant Real hl_coef[:, :]=R134aData.hlcoef
        "Coefficients of cubic spline for h_liq(p)";
      constant Real p_breaks[:]=R134aData.pbreaks
        "Grid points of reduced pressure";
      Integer int "Interval number";
      Integer error "Interval for spline interpolation not found";
      Real pred "Reduced pressure";
      Real localx "Abscissa of local spline";
    algorithm
      pred := min(sat.psat/R134aData.data.FPCRIT, 1.0);
      (int,error) := Common.FindInterval(pred, p_breaks);
      localx := pred - p_breaks[int];
      hl := R134aData.data.HCRIT*Common.CubicSplineEval(localx, hl_coef[int, 1:
        4]);

      // annotation(smoothOrder=5);
      annotation (derivative=dBubbleEnthalpy_dPressure_der_sat, Documentation(
            info="<html>
<p>This function calculates the liquid phase enthalpy of R134a from the state variable p (absolute pressure). It is modelled by cubic splines which are fitted with non-equidistant grid points derived from
the fundamental equation of state of Tillner-Roth and Baehr (1994) and the Maxwell criteria.
</p>
<h4> Restrictions</h4>
<p>It is only valid in the two-phase region (i.e., p<sub>triple</sub> &le; p &le; p<sub>crit</sub> ).
</p>
</html>"));
    end bubbleEnthalpy;

    redeclare function extends dBubbleEnthalpy_dPressure
      "Derivative of liquid specific enthalpy in two-phase region w.r.t. pressure"

    protected
      constant Real hl_coef[:, :]=R134aData.hlcoef
        "Coefficients of cubic spline for h_liq(p)";
      constant Real p_breaks[:]=R134aData.pbreaks
        "Grid points of reduced pressure";
      Integer int "Interval number";
      Integer error "Interval for spline interpolation not found";
      Real pred "Reduced pressure";
      Real localx "Abscissa of local spline";
    algorithm
      pred := min(sat.psat/R134aData.data.FPCRIT, 1.0);
      (int,error) := Common.FindInterval(pred, p_breaks);
      localx := pred - p_breaks[int];
      dhldp := R134aData.data.HCRIT*Common.CubicSplineDerEval(localx, hl_coef[
        int, 1:4])/R134aData.data.FPCRIT;

      annotation (Documentation(info="<html>
<p>This function calculates the derivative of liquid enthalpy of R134a with regard to the state variable p (absolute pressure). The non-derivative function is <a href=\"modelica://Modelica.Media.R134a.R134a_ph.bubbleEnthalpy\"> bubbleEnthalpy</a>.
</p>
<h4> Restrictions</h4>
<p>It is only valid in the two-phase region (i.e., p<sub>triple</sub> &le; p &le; p<sub>crit</sub> ).
</p>
</html>"));
    end dBubbleEnthalpy_dPressure;

    function dBubbleEnthalpy_dPressure_der_sat
      "Time derivative of liquid specific enthalpy in two-phase region w.r.t. pressure"
      extends Modelica.Icons.Function;

      input SaturationProperties sat
        "Saturation properties | pressure is used for interpolation";
      input SaturationProperties der_sat "Derivative of saturation properties";
      output Real der_dhldp
        "Time derivative of liquid specific enthalpy in two-phase region w.r.t. pressure";
    protected
      constant Real hl_coef[:, :]=R134aData.hlcoef
        "Coefficients of cubic spline for h_liq(p)";
      constant Real p_breaks[:]=R134aData.pbreaks
        "Grid points of reduced pressure";
      Integer int "Interval number";
      Integer error "Interval for spline interpolation not found";
      Real pred "Reduced pressure";
      Real localx "Abscissa of local spline";
    algorithm
      pred := min(sat.psat/R134aData.data.FPCRIT, 1.0);
      (int,error) := Common.FindInterval(pred, p_breaks);
      localx := pred - p_breaks[int];
      der_dhldp := R134aData.data.HCRIT*Common.CubicSplineDerEval(localx,
        hl_coef[int, 1:4])/R134aData.data.FPCRIT*der_sat.psat;

      annotation (Documentation(info="<html>
<p>This function calculates the time derivative of liquid specific enthalpy of R134a with regard to the time derivative of p. The non-derivative function is <a href=\"modelica://Modelica.Media.R134a.R134a_ph.bubbleEnthalpy\"> bubbleEnthalpy</a>.
</p>
<h4> Restrictions</h4>
<p>It is only valid in the two-phase region (i.e., p<sub>triple</sub> &le; p &le; p<sub>crit</sub> ).
</p>
</html>"));
    end dBubbleEnthalpy_dPressure_der_sat;

    redeclare function extends dewEnthalpy
      "Specific enthalpy of vapor phase w.r.t. saturation pressure | use setSat_p function for input"

    protected
      constant Real hv_coef[:, :]=R134aData.hvcoef
        "Coefficients of cubic spline for h_vap(p)";
      constant Real p_breaks[:]=R134aData.pbreaks
        "Grid points of reduced pressure";
      Integer int "Interval number";
      Integer error "Interval for spline interpolation not found";
      Real pred "Reduced pressure";
      Real localx "Abscissa of local spline";
    algorithm
      pred := min(sat.psat/R134aData.data.FPCRIT, 1.0);
      (int,error) := Common.FindInterval(pred, p_breaks);
      localx := pred - p_breaks[int];
      hv := R134aData.data.HCRIT*Common.CubicSplineEval(localx, hv_coef[int, 1:
        4]);

      // annotation(smoothOrder=5);
      annotation (derivative=dDewEnthalpy_dPressure_der_sat, Documentation(info=
             "<html>
<p>This function calculates the vapor phase enthalpy of R134a from the state variable p (absolute pressure). It is modelled by cubic splines which are fitted with non-equidistant grid points derived from
the fundamental equation of state of Tillner-Roth and Baehr (1994) and the Maxwell criteria.
</p>
<h4> Restrictions</h4>
<p>It is only valid in the two-phase region (i.e., p<sub>triple</sub> &le; p &le; p<sub>crit</sub> ).
</p>
</html>"));
    end dewEnthalpy;

    redeclare function extends dDewEnthalpy_dPressure
      "Derivative of vapor specific enthalpy in two-phase region w.r.t. pressure"

    protected
      constant Real hv_coef[:, :]=R134aData.hvcoef
        "Coefficients of cubic spline for h_vap(p)";
      constant Real p_breaks[:]=R134aData.pbreaks
        "Grid points of reduced pressure";
      Integer int "Interval number";
      Integer error "Interval for spline interpolation not found";
      Real pred "Reduced pressure";
      Real localx "Abscissa of local spline";
    algorithm
      pred := min(sat.psat/R134aData.data.FPCRIT, 1.0);
      (int,error) := Common.FindInterval(pred, p_breaks);
      localx := pred - p_breaks[int];
      dhvdp := R134aData.data.HCRIT*Common.CubicSplineDerEval(localx, hv_coef[
        int, 1:4])/R134aData.data.FPCRIT;

      annotation (Documentation(info="<html>
<p>This function calculates the derivative of vapor enthalpy of R134a in the two-phase region with regard to the state variable p (absolute pressure). The non-derivative function is <a href=\"modelica://Modelica.Media.R134a.R134a_ph.dewEnthalpy\"> dewEnthalpy</a>.
</p>
<h4> Restrictions</h4>
<p>It is only valid in the two-phase region (i.e., p<sub>triple</sub> &le; p &le; p<sub>crit</sub> ).
</p>
</html>"));
    end dDewEnthalpy_dPressure;

    function dDewEnthalpy_dPressure_der_sat
      "Time derivative of vapor specific enthalpy in two-phase region w.r.t. pressure"
      extends Modelica.Icons.Function;

      input SaturationProperties sat
        "Saturation properties | pressure is used for interpolation";
      input SaturationProperties der_sat "Derivative of saturation properties";
      output Real der_dhvdp
        "Derivative of vapor specific enthalpy in two-phase region w.r.t. pressure";
    protected
      constant Real hv_coef[:, :]=R134aData.hvcoef
        "Coefficients of cubic spline for h_vap(p)";
      constant Real p_breaks[:]=R134aData.pbreaks
        "Grid points of reduced pressure";
      Integer int "Interval number";
      Integer error "Interval for spline interpolation not found";
      Real pred "Reduced pressure";
      Real localx "Abscissa of local spline";
    algorithm
      pred := min(sat.psat/R134aData.data.FPCRIT, 1.0);
      (int,error) := Common.FindInterval(pred, p_breaks);
      localx := pred - p_breaks[int];
      der_dhvdp := R134aData.data.HCRIT*Common.CubicSplineDerEval(localx,
        hv_coef[int, 1:4])/R134aData.data.FPCRIT*der_sat.psat;

      annotation (Documentation(info="<html>
<p>This function calculates the time derivative of vapor enthalpy of R134a with regard to the time derivative of p. The non-derivative function is <a href=\"modelica://Modelica.Media.R134a.R134a_ph.dewEnthalpy\"> dewEnthalpy</a>.
</p>
<h4> Restrictions</h4>
<p>It is only valid in the two-phase region (i.e., p<sub>triple</sub> &le; p &le; p<sub>crit</sub> ).
</p>
</html>"));
    end dDewEnthalpy_dPressure_der_sat;

    redeclare function extends dewEntropy
      "Specific entropy of vapor phase w.r.t. saturation pressure | use setSat_p function for input"

    protected
      constant Real sv_coef[:, :]=R134aData.svcoef
        "Coefficients of cubic spline for s_vap(p)";
      constant Real p_breaks[:]=R134aData.pbreaks
        "Grid points of reduced pressure";
      Integer int "Interval number";
      Integer error "Interval for spline interpolation not found";
      Real pred "Reduced pressure";
      Real localx "Abscissa of local spline";
    algorithm
      pred := min(sat.psat/R134aData.data.FPCRIT, 1.0);
      (int,error) := Common.FindInterval(pred, p_breaks);
      localx := pred - p_breaks[int];
      sv := R134aData.data.SCRIT*Common.CubicSplineEval(localx, sv_coef[int, 1:
        4]);

      // annotation(smoothOrder=5);
      annotation (derivative=dDewEntropy_dPressure_der_sat, Documentation(info="<html>
<p>This function calculates the vapor phase entropy of R134a from the state variable p (absolute pressure). It is modelled by cubic splines which are fitted with non-equidistant grid points derived from
the fundamental equation of state of Tillner-Roth and Baehr (1994) and the Maxwell criteria.
</p>
<h4> Restrictions</h4>
<p>It is only valid in the two-phase region (i.e., p<sub>triple</sub> &le; p &le; p<sub>crit</sub> ).
</p>
</html>"));
    end dewEntropy;

    function dDewEntropy_dPressure
      "Derivative of vapor specific entropy in two-phase region w.r.t. pressure | use setState_phX function for input"
      extends Modelica.Icons.Function;

      input SaturationProperties sat
        "Saturation properties | pressure is used for interpolation";
      output Real dsvdp
        "Derivative of vapor specific entropy in two-phase region w.r.t. pressure";
    protected
      constant Real sv_coef[:, :]=R134aData.svcoef
        "Coefficients of cubic spline for s_vap(p)";
      constant Real p_breaks[:]=R134aData.pbreaks
        "Grid points of reduced pressure";
      Integer int "Interval number";
      Integer error "Interval for spline interpolation not found";
      Real pred "Reduced pressure";
      Real localx "Abscissa of local spline";
    algorithm
      pred := min(sat.psat/R134aData.data.FPCRIT, 1.0);
      (int,error) := Common.FindInterval(pred, p_breaks);
      localx := pred - p_breaks[int];
      dsvdp := R134aData.data.SCRIT*Common.CubicSplineDerEval(localx, sv_coef[
        int, 1:4])/R134aData.data.FPCRIT;

      annotation (Documentation(info="<html>
<p>This function calculates the derivative of vapor entropy of R134a with regard to the state variable p (absolute pressure). The non-derivative function is <a href=\"modelica://Modelica.Media.R134a.R134a_ph.dewEntropy\"> dewEntropy</a>.
</p>
<h4> Restrictions</h4>
<p>It is only valid in the two-phase region (i.e., p<sub>triple</sub> &le; p &le; p<sub>crit</sub> ).
</p>
</html>"));
    end dDewEntropy_dPressure;

    function dDewEntropy_dPressure_der_sat
      "Time derivative of vapor specific entropy in two-phase region w.r.t. pressure | use setState_phX function for input"
      extends Modelica.Icons.Function;

      input SaturationProperties sat
        "Saturation properties | pressure is used for interpolation";
      input SaturationProperties der_sat "Derivative of saturation properties";
      output Real der_dsvdp
        "Derivative of vapor specific entropy in two-phase region w.r.t. pressure";
    protected
      constant Real sv_coef[:, :]=R134aData.svcoef
        "Coefficients of cubic spline for s_liq(p)";
      constant Real p_breaks[:]=R134aData.pbreaks
        "Grid points of reduced pressure";
      Integer int "Interval number";
      Integer error "Interval for spline interpolation not found";
      Real pred "Reduced pressure";
      Real localx "Abscissa of local spline";
    algorithm
      pred := min(sat.psat/R134aData.data.FPCRIT, 1.0);
      (int,error) := Common.FindInterval(pred, p_breaks);
      localx := pred - p_breaks[int];
      der_dsvdp := R134aData.data.SCRIT*Common.CubicSplineDerEval(localx,
        sv_coef[int, 1:4])/R134aData.data.FPCRIT*der_sat.psat;

      annotation (Documentation(info="<html>
<p>This function calculates the time derivative of vapor specific entropy of R134a with regard to the time derivative of p. The non-derivative function is <a href=\"modelica://Modelica.Media.R134a.R134a_ph.dewEntropy\"> dewEntropy</a>.
</p>
<h4> Restrictions</h4>
<p>It is only valid in the two-phase region (i.e., p<sub>triple</sub> &le; p &le; p<sub>crit</sub> ).
</p>
</html>"));
    end dDewEntropy_dPressure_der_sat;

    redeclare function extends bubbleEntropy
      "Specific entropy of liquid phase w.r.t. saturation pressure | use setSat_p function for input"
    protected
      constant Real sl_coef[:, :]=R134aData.slcoef
        "Coefficients of cubic spline for s_liq(p)";
      constant Real p_breaks[:]=R134aData.pbreaks
        "Grid points of reduced pressure";
      Integer int "Interval number";
      Integer error "Interval for spline interpolation not found";
      Real pred "Reduced pressure";
      Real localx "Abscissa of local spline";
    algorithm
      pred := min(sat.psat/R134aData.data.FPCRIT, 1.0);
      (int,error) := Common.FindInterval(pred, p_breaks);
      localx := pred - p_breaks[int];
      sl := R134aData.data.SCRIT*Common.CubicSplineEval(localx, sl_coef[int, 1:
        4]);

      // annotation(smoothOrder=5);
      annotation (derivative=dBubbleEntropy_dPressure_der_sat, Documentation(
            info="<html>
<p>This function calculates the liquid phase entropy of R134a from the state variable p (absolute pressure). It is modelled by cubic splines which are fitted with non-equidistant grid points derived from
the fundamental equation of state of Tillner-Roth and Baehr (1994) and the Maxwell criteria.
</p>
<h4> Restrictions</h4>
<p>It is only valid in the two-phase region (i.e., p<sub>triple</sub> &le; p &le; p<sub>crit</sub> ).
</p>
</html>"));
    end bubbleEntropy;

    function dBubbleEntropy_dPressure
      "Derivative of liquid specific entropy in two-phase region w.r.t. pressure | use setState_phX function for input"
      extends Modelica.Icons.Function;
      input SaturationProperties sat
        "Saturation properties | pressure is used for interpolation";
      output Real dsldp
        "Derivative of liquid specific entropy in two-phase region w.r.t. pressure";
    protected
      constant Real sl_coef[:, :]=R134aData.slcoef
        "Coefficients of cubic spline for s_liq(p)";
      constant Real p_breaks[:]=R134aData.pbreaks
        "Grid points of reduced pressure";
      Integer int "Interval number";
      Integer error "Interval for spline interpolation not found";
      Real pred "Reduced pressure";
      Real localx "Abscissa of local spline";
    algorithm
      pred := min(sat.psat/R134aData.data.FPCRIT, 1.0);
      (int,error) := Common.FindInterval(pred, p_breaks);
      localx := pred - p_breaks[int];
      dsldp := R134aData.data.SCRIT*Common.CubicSplineDerEval(localx, sl_coef[
        int, 1:4])/R134aData.data.FPCRIT;

      annotation (Documentation(info="<html>
<p>This function calculates the derivative of liquid entropy of R134a with regard to the state variable p (absolute pressure). The non-derivative function is <a href=\"modelica://Modelica.Media.R134a.R134a_ph.bubbleEntropy\"> bubbleEntropy</a>.
</p>
<h4> Restrictions</h4>
<p>It is only valid in the two-phase region (i.e., p<sub>triple</sub> &le; p &le; p<sub>crit</sub> ).
</p>
</html>"));
    end dBubbleEntropy_dPressure;

    function dBubbleEntropy_dPressure_der_sat
      "Time derivative of liquid specific entropy in two-phase region w.r.t. pressure | use setState_phX function for input"
      extends Modelica.Icons.Function;
      input SaturationProperties sat
        "Saturation properties | pressure is used for interpolation";
      input SaturationProperties der_sat "Derivative of saturation properties";
      output Real der_dsldp
        "Derivative of liquid specific entropy in two-phase region w.r.t. pressure";
    protected
      constant Real sl_coef[:, :]=R134aData.slcoef
        "Coefficients of cubic spline for s_liq(p)";
      constant Real p_breaks[:]=R134aData.pbreaks
        "Grid points of reduced pressure";
      Integer int "Interval number";
      Integer error "Interval for spline interpolation not found";
      Real pred "Reduced pressure";
      Real localx "Abscissa of local spline";
    algorithm
      pred := min(sat.psat/R134aData.data.FPCRIT, 1.0);
      (int,error) := Common.FindInterval(pred, p_breaks);
      localx := pred - p_breaks[int];
      der_dsldp := R134aData.data.SCRIT*Common.CubicSplineDerEval(localx,
        sl_coef[int, 1:4])/R134aData.data.FPCRIT*der_sat.psat;

      annotation (Documentation(info="<html>
<p>This function calculates the time derivative of liquid specific entropy of R134a with regard to the time derivative of p. The non-derivative function is <a href=\"modelica://Modelica.Media.R134a.R134a_ph.bubbleEntropy\"> bubbleEntropy</a>.
</p>
<h4> Restrictions</h4>
<p>It is only valid in the two-phase region (i.e., p<sub>triple</sub> &le; p &le; p<sub>crit</sub> ).
</p>
</html>"));
    end dBubbleEntropy_dPressure_der_sat;

    redeclare function extends saturationPressure
      "Saturation pressure w.r.t. temperature"

    protected
      constant Real pt_coef[:, :]=R134aData.ptcoef
        "Coefficients of cubic spline for psat(T)";
      constant Real T_breaks[:]=R134aData.Tbreaks
        "Grid points of reduced pressure";
      Real Tred "Reduced temperature";
      Integer int "Interval number";
      Integer error "Interval for spline interpolation not found";
      Real pred "Reduced pressure";
      Real localx "Abscissa of local spline";
    algorithm
      Tred := T/R134aData.data.FTCRIT;
      (int,error) := Common.FindInterval(Tred, T_breaks);
      localx := Tred - T_breaks[int];
      p := R134aData.data.FPCRIT*Common.CubicSplineEval(localx, pt_coef[int, :]);

      annotation (smoothOrder=5, Documentation(info="<html>
<p>This function calculates the saturation pressure of R134a from the state variable T (temperature). It is modelled by cubic splines which are fitted with non-equidistant grid points derived from the fundamental equation of state of Tillner-Roth and Baehr (1994) and the Maxwell criteria.
</p>
<h4> Restrictions</h4>
<p>It is only valid in the two-phase region (i.e., p<sub>triple</sub> &le; p &le; p<sub>crit</sub> ).
</p>
<div><img src=\"modelica://Modelica/Resources/Images/Media/R134a/log(p)Tsat-Diagram-R134a.png\"/></div>
</html>"));
    end saturationPressure;

    redeclare function extends specificHeatCapacityCp
      "Specific heat capacity at constant pressure | turns infinite in two-phase region! | use setState_phX function for input"

    protected
      Modelica.Media.Common.HelmholtzDerivs f "Helmholtz derivatives";

    algorithm
      f := f_R134a(state.d, state.T);
      cp := if getPhase_ph(state.p, state.h) == 2 then 0 else R134aData.R_s*(-f.tau
        *f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau*f.fdeltatau)^2/(2*
        f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));

      annotation (Documentation(info="<html>
<p>This function calculates the specific heat capacity of R134a at <strong>constant pressure</strong> from the state record (e.g., use setState_phX function for input). The specific heat capacity is modelled by the fundamental equation of state of Tillner-Roth and Baehr (1994).</p>
<h4> Restrictions</h4>
<p>This property is only defined in one-phase region.
</p>
<div><img src=\"modelica://Modelica/Resources/Images/Media/R134a/log(p)cp-Diagram-R134a.png\"/></div>
</html>"));
    end specificHeatCapacityCp;

    redeclare function extends specificHeatCapacityCv
      "Specific heat capacity at constant volume | use setState_phX function for input"

    protected
      Modelica.Media.Common.HelmholtzDerivs f "Helmholtz derivatives";
      Common.PhaseBoundaryProperties liq "Properties on liquid phase boundary";
      SaturationProperties sat "Saturation temperature and pressure";
      Common.PhaseBoundaryProperties vap "Properties on vapor phase boundary";

      SI.MassFraction x "Vapor quality";

    algorithm
      if getPhase_ph(state.p, state.h) == 2 then
        sat.psat := state.p;
        sat.Tsat := saturationTemperature(state.p);
        liq := R134a_liqofdT(T=state.T);
        vap := R134a_vapofdT(T=state.T);
        x := if liq.h <> vap.h then (state.h - liq.h)/(vap.h - liq.h) else if
          state.h >= vap.h then 1 else 0;
        cv := Common.cv2Phase(
              liq=liq,
              vap=vap,
              x=x,
              T=state.T,
              p=state.p);
      else
        f := f_R134a(state.d, state.T);
        cv := R134aData.R_s*(-f.tau*f.tau*f.ftautau);
      end if;

      annotation (Documentation(info="<html>
<p>This function calculates the specific heat capacity of R134a at <strong>constant volume</strong> from the state record (e.g., use setState_phX function for input). The specific heat capacity is modelled by the fundamental equation of state of Tillner-Roth and Baehr (1994).</p>
<p>
Please note, that the function can also be called in the two-phase region, but the output is not continuous for a phase transition (see Tillner-Roth and Baehr, 1994). Values in two-phase region are considerably higher than in one-phase domain. The following figure just shows one-phase properties.
</p>
<div><img src=\"modelica://Modelica/Resources/Images/Media/R134a/log(p)cv-Diagram-R134a.png\"/></div>
</html>"));
    end specificHeatCapacityCv;

    redeclare function extends dynamicViscosity
      "Dynamic viscosity w.r.t. temperature and density | use setState_phX function for input"

    protected
      Real omega_log "Log of collision integral";
      Real omega "Collision integral";

      constant Real K=0.021357 "Constant for low density term eta_star";
      constant SI.Length sigma=0.50647e-09 "Hard-sphere diameter";
      constant SI.Temperature epsilon_k=288.82 "Empirical factor";
      constant Real a[5]={2.218816e-01,-5.079322e-01,1.285776e-01,-8.328165e-02,
          -2.713173e-02} "Coefficients for term of collision integral";
      constant Real b[13]={-1.7999496,4.6692621e+01,-5.3460794e+02,
          3.3604074e+03,-1.3019164e+04,3.3414230e+04,-5.8711743e+04,
          7.1426686e+04,-5.9834012e+04,3.3652741e+04,-1.2027350e+04,
          2.4348205e+03,-2.0807957e+02}
        "Coefficients for term of 2nd viscosity virial coefficient";
      constant Real c[6]={-0.331249e-01,-0.468509e-03,0.156983,3.073830,-0.306398,
          0.215221} "Coefficients for term of residual viscosity";
      constant Real DCRIT_mol=4.9788 "Critical density in mol/l";
      Real d_red "Reduced density";
      Real B_eta "2nd viscosity virial coeff.";
      Real E "Temperature contribution to residual viscosity";
      Real eta_res "Residual part";
      Real eta_star "Dilute part";

    algorithm
      omega_log := 0;
      for i in 1:5 loop
        omega_log := omega_log + a[i]*(Modelica.Math.log(state.T/epsilon_k))^(i
           - 1);
      end for;
      omega := Modelica.Math.exp(omega_log);
      eta_star := (K*sqrt(R134aData.data.MM*1000))/((sigma*1e+09)^2*omega)*sqrt(
        state.T);

      d_red := state.d/R134aData.data.DCRIT;
      E := 1 + c[3]*state.T/R134aData.data.TCRIT;
      B_eta := 0;
      for i in 1:13 loop
        B_eta := B_eta + b[i]*(sqrt(state.T/epsilon_k))^(i - 1);
      end for;
      B_eta := B_eta*602.2137*(sigma)^3*DCRIT_mol;

      eta_res := (c[1] + B_eta*eta_star)*d_red + c[2]*d_red^2 + (c[5] + c[6]*
        d_red)/(c[4]*E - d_red) - c[5]/(c[4]*E);

      eta := (eta_star + eta_res*1e3)*1e-06;

      annotation (Documentation(info="<html>
<p>This function calculates the dynamic viscosity of R134a from the state record (e.g., use setState_phX function for input). The dynamic viscosity is modelled by the corresponding states method of Klein, McLinden and Laesecke (1997).</p>
<h4> Restrictions</h4>
<p>This property is only defined in one-phase region.
</p>
<h4>References</h4>
<dl><dt>Klein, McLinden and Laesecke: </dt>
<dd><strong>An improved extended corresponding states method for estimation of viscosity of pure refrigerants and mixtures</strong>.
Int. J. Refrig., Vol. 20, No.3, pp. 208-217, 1997.</dd>
</dl>
<div><img src=\"modelica://Modelica/Resources/Images/Media/R134a/log(p)eta-Diagram-R134a.png\"/></div>
</html>"));
    end dynamicViscosity;

    redeclare function extends thermalConductivity
      "Thermal conductivity w.r.t. thermodynamic state | use setState_phX function for input"

    protected
      Modelica.Media.Common.HelmholtzDerivs f "Helmholtz derivatives";
      Modelica.Media.Common.HelmholtzDerivs f_ref
        "Helmholtz derivatives for reference state";
      SI.ThermalConductivity lambda_dg
        "Dilute gas contribution to lambda";
      R134aData.CoeffsThermalConductivity coeff
        "Coefficients of thermal conductivity model";
      SI.ThermalConductivity lambda_reduced "Reduced lambda";
      SI.ThermalConductivity lambda_crit
        "Enhancement of lambda in the critical region";
      SI.ThermalConductivity chi_star "Correlation length";
      SI.ThermalConductivity chi_star_ref "Correlation length";
      SI.ThermalConductivity delta_chi "Chi_star - chi_star_ref";
      Real rho_molar "Molar density [mol/l]";
      Real dddp "Derivative of density w.r.t. pressure";
      Real dddp_ref "Derivative of density w.r.t. pressure for reference state";
      SI.Length xi "Correlation length";
      SI.SpecificHeatCapacity cp
        "Specific heat capacity at constant pressure";
      SI.SpecificHeatCapacity cv
        "Specific heat capacity at constant volume";
      SI.DynamicViscosity eta "Dynamic viscosity";
      SI.ThermalConductivity omega "Crossover function";
      SI.ThermalConductivity omega_0 "Crossover function";

    algorithm
      f := f_R134a(state.d, state.T);
      f_ref := f_R134a(state.d, coeff.T_ref);

      // dilute gas contribution
      lambda_dg := coeff.a_0 + coeff.a_1*state.T;

      // reduced lambda
      rho_molar := state.d/(R134aData.data.MM*1000);
      // [mol/L]
      lambda_reduced := 0;
      for i in 1:4 loop
        lambda_reduced := lambda_reduced + coeff.b[i]*(rho_molar/coeff.rho_crit)
          ^i;
      end for;
      lambda_reduced := lambda_reduced*coeff.lambda_reducing;

      // critical lambda
      dddp := 1/(f.R_s*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta));
      chi_star := state.d*coeff.p_crit*1e3/((coeff.rho_crit*R134aData.data.MM*
        1000)^2)*dddp;
      dddp_ref := 1/(f_ref.R_s*f_ref.T*f_ref.delta*(2.0*f_ref.fdelta + f_ref.delta
        *f_ref.fdeltadelta));
      chi_star_ref := state.d*coeff.p_crit*1e3/((coeff.rho_crit*R134aData.data.MM
        *1000)^2)*dddp_ref;
      delta_chi := max(1e-10, (chi_star - chi_star_ref));
      xi := coeff.xi_0*(1/coeff.GAMMA*(delta_chi))^(coeff.nu/coeff.gamma);
      cp := R134aData.data.R_s*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta
        *f.tau*f.fdeltatau)^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
      eta := dynamicViscosity(state=state);
      cv := specificHeatCapacityCv(state=state);
      omega := 2/Modelica.Constants.pi*(((cp - cv)/cp)*Modelica.Math.atan(coeff.q_d
        *xi) + cv/cp*coeff.q_d*xi);
      omega_0 := 2/Modelica.Constants.pi*(1 - Modelica.Math.exp(-1/((coeff.q_d*
        xi)^(-1) + 1/3*(coeff.q_d*xi*coeff.rho_crit/(state.d/(R134aData.data.MM
        *1000)))^2)));
      lambda_crit := state.d*cp*(1.03*Modelica.Constants.k*state.T)/(6*Modelica.Constants.pi
        *eta*xi)*(omega - omega_0);

      // conclusion
      lambda := max(lambda_dg + lambda_reduced + lambda_crit, 1e-8);

      annotation (Documentation(info="<html>
<p>This function calculates the thermal conductivity of R134a from the state record (e.g., use setState_phX function for input). The thermal conductivity is modelled by the corresponding states model of McLinden, Klein. and Perkins (2000).</p>
<h4> Restrictions</h4>
<p>This property is only defined in one-phase region.
</p>
<h4>References</h4>
<dl><dt>McLinden, Klein. and Perkins: </dt>
<dd><strong>An extended corresponding states model for the thermal conductivity
of refrigerants and refrigerant mixtures</strong>.
Int. J. Refrig., 23 (2000) 43-63.</dd>
</dl>
<div><img src=\"modelica://Modelica/Resources/Images/Media/R134a/log(p)lambda-Diagram-R134a.png\"/></div>
</html>"));
    end thermalConductivity;

    redeclare function extends surfaceTension
      "Surface tension as a function of temperature (below critical point)"

    protected
      Real tau "Reduced temperature";
      R134aData.CoeffsSurfaceTension coeff "Polynomial coefficients";
      SI.Temperature Tc=374.21 "Critical temperature";

    algorithm
      if sat.Tsat > Tc then
        tau := 0.0;
        sigma := 0.0;
      else
        tau := 1.0 - sat.Tsat/Tc;
        sigma := 0.0;
        for i in 1:coeff.nterm loop
          sigma := sigma + coeff.sigmak[i]*tau^coeff.sigexp[i];
        end for;
      end if;

      annotation (Documentation(info="<html>
<p>This function calculates the surface tension of R134a from the saturation record (e.g., use setSat_T function for input). The property is modelled by an approach of Okada and Higashi (1994).</p>
<h4> Restrictions</h4>
<p>This property is only defined in two-phase region.
</p>
<h4>References</h4>
<dl><dt>Okada and Higashi: </dt>
<dd><strong>Surface tension correlation of HFC-134a and HCFC-123</strong>.
Proceedings of the Joint Meeting of IIR Commissions B1, B2, E1, and E2, Padua, Italy, pp. 541-548, 1994.</dd>
</dl>
<div><img src=\"modelica://Modelica/Resources/Images/Media/R134a/Tsigma-Diagram-R134a.png\"/></div>
</html>"));
    end surfaceTension;

    redeclare function extends velocityOfSound
      "Velocity of sound w.r.t. thermodynamic state (only valid for one-phase)"
    protected
      Modelica.Media.Common.HelmholtzDerivs f "Helmholtz derivatives";
    algorithm

      if getPhase_ph(state.p, state.h) == 2 then
        a := 0;
        // assert(getPhase_ph(state.p, state.h)==1, "Function for velocity of sound is only valid for one-phase regime!");
      else
        f := f_R134a(state.d, state.T);
        a := abs(R134aData.data.R_s*state.T*(2*f.delta*f.fdelta + f.delta*f.delta
          *f.fdeltadelta - ((f.delta*f.fdelta - f.delta*f.tau*f.fdeltatau)*(f.delta
          *f.fdelta - f.delta*f.tau*f.fdeltatau))/(f.tau*f.tau*f.ftautau)))^0.5;
      end if;
      annotation (Documentation(info="<html>
<p>This function calculates the velocity of sound of R134a from the state record (e.g., use setState_phX function for input). The velocity of sound is modelled by the fundamental equation of state of Tillner-Roth and Baehr (1994).</p>
<h4> Restrictions</h4>
<p>This property is only defined in one-phase region.
</p>
<div><img src=\"modelica://Modelica/Resources/Images/Media/R134a/log(p)a-Diagram-R134a.png\"/></div>
</html>"));
    end velocityOfSound;

    redeclare function extends isothermalCompressibility
      "Isothermal compressibility w.r.t. thermodynamic state (only valid for one-phase)"
    protected
      Modelica.Media.Common.HelmholtzDerivs f "Helmholtz derivatives";
    algorithm
      if getPhase_ph(state.p, state.h) == 2 then
        kappa := 0;
        // assert(getPhase_ph(state.p, state.h)==1, "Function for isothermal compressibility is only valid for one-phase regime!");
      else
        f := f_R134a(state.d, state.T);
        kappa := 1/(state.d*R134aData.data.R_s*state.T*f.delta*(2.0*f.fdelta + f.delta
          *f.fdeltadelta));
      end if;
      annotation (Documentation(info="<html>
<p>This function calculates the isothermal compressibility of R134a from the state record (e.g., use setState_phX function for input). The isothermal compressibility is modelled by the fundamental equation of state of Tillner-Roth and Baehr (1994).</p>
<h4> Restrictions</h4>
<p>This property is only defined in one-phase region.
</p>
</html>"));
    end isothermalCompressibility;

    redeclare function extends isobaricExpansionCoefficient
      "Isobaric expansion coefficient w.r.t. thermodynamic state (only valid for one-phase)"
    protected
      Modelica.Media.Common.HelmholtzDerivs f "Helmholtz derivatives";
    algorithm
      if getPhase_ph(state.p, state.h) == 2 then
        beta := 0;
        // assert(getPhase_ph(state.p, state.h)==1, "Function for isobaric expansion coefficient is only valid for one-phase regime!");
      else
        f := f_R134a(state.d, state.T);
        beta := R134aData.data.R_s*state.d*f.delta*(f.fdelta - f.tau*f.fdeltatau)
          *isothermalCompressibility(state);
      end if;
      annotation (Documentation(info="<html>
<p>This function calculates the isobaric expansion coefficient of R134a from the state record (e.g., use setState_phX function for input). The isobaric expansion coefficient is modelled by the fundamental equation of state of Tillner-Roth and Baehr (1994).</p>
<h4> Restrictions</h4>
<p>This property is only defined in one-phase region.
</p>
</html>"));
    end isobaricExpansionCoefficient;

    redeclare function extends isentropicExponent
      "Isentropic exponent gamma w.r.t. thermodynamic state | not defined in two-phase region | use setState_phX function for input"

    algorithm
      gamma := density(state)/(if pressure(state) > 1e-6 then pressure(state)
         else 1e-6)*velocityOfSound(state)^2;

      annotation (Inline=true, Documentation(info="<html>
<p>This function calculates the isentropic exponent of R134a from the state record (e.g., use setState_phX function for input). The isentropic exponent is modelled by the fundamental equation of state of Tillner-Roth and Baehr (1994).</p>
<h4> Restrictions</h4>
<p>This property is only defined in one-phase region.
</p>
</html>"));
    end isentropicExponent;

    redeclare function extends specificGibbsEnergy
      "Specific gibbs energy w.r.t. thermodynamic state"
    algorithm
      g := state.h - state.T*specificEntropy(state);
      annotation (Documentation(info="<html>
<p>This function calculates the specific Gibbs energy of R134a from the state record (e.g., use setState_phX function for input). The isentropic exponent is modelled by the fundamental equation of state of Tillner-Roth and Baehr (1994).
</p>
</html>"));
    end specificGibbsEnergy;

    redeclare function extends specificHelmholtzEnergy
      "Helmholtz energy w.r.t. thermodynamic state"
    algorithm
      f := state.h - state.p/state.d - state.T*specificEntropy(state);
      annotation (Documentation(info="<html>
<p>This function calculates the specific Helmholtz energy of R134a from the state record (e.g., use setState_phX function for input). The Helmholtz energy is modelled by the fundamental equation of state of Tillner-Roth and Baehr (1994).
</p>
</html>"));
    end specificHelmholtzEnergy;

    redeclare function extends density_derh_p
      "Density derivative by specific enthalpy | use setState_phX function for input"

    protected
      Common.InverseDerivatives_rhoT derivs
        "Inverse derivatives for density and temperature";

    algorithm
      derivs := derivsOf_ph(
            state.p,
            state.h,
            getPhase_ph(p=state.p, h=state.h));
      ddhp := if getPhase_ph(p=state.p, h=state.h) == 2 then -state.d*state.d/(
        derivs.dpT*state.T) else -state.d*state.d*derivs.pt/(state.d*state.d*
        derivs.pd*derivs.cv + state.T*derivs.pt^2);

      annotation (Documentation(info="<html>
<p>This function calculates the density derivative w.r.t. specific enthalpy at constant pressure of R134a (e.g., use setState_phX function for input). The derivative is modelled by the fundamental equation of state of Tillner-Roth and Baehr (1994). It can be used for manual state transformations (e.g. from density to specific enthalpy).
</p>
</html>"));
    end density_derh_p;

    redeclare function extends density_derp_h
      "Density derivative by pressure | use setState_phX function for input"

    protected
      Common.InverseDerivatives_rhoT derivs
        "Inverse derivatives for density and temperature";

    algorithm
      derivs := derivsOf_ph(
            state.p,
            state.h,
            getPhase_ph(p=state.p, h=state.h));
      ddph := if getPhase_ph(p=state.p, h=state.h) == 2 then state.d*(state.d*
        derivs.cv/derivs.dpT + 1)/(derivs.dpT*state.T) else (state.d*(derivs.cv
        *state.d + derivs.pt))/(state.d*state.d*derivs.pd*derivs.cv + state.T*
        derivs.pt^2);

      annotation (Documentation(info="<html>
<p>This function calculates the density derivative w.r.t. absolute pressure at constant specific enthalpy of R134a (e.g., use setState_phX function for input). The derivative is modelled by the fundamental equation of state of Tillner-Roth and Baehr (1994). It can be used for manual state transformations (e.g. from density to pressure).
</p>
</html>"));
    end density_derp_h;

    redeclare function extends isentropicEnthalpy
      "Isentropic enthalpy of downstream pressure and upstream thermodynamic state (specific entropy)"
    algorithm
      h_is := specificEnthalpy_psX(
            p_downstream,
            specificEntropy(refState),
            reference_X);
      annotation (Documentation(info="<html>
<p>
This function calculates the specific enthalpy of R134a for an isentropic pressure change
from refState.p to p_downstream (e.g., use setState_phX function for input of refState).
</p>

<p>
The function can be used for instance to calculate an isentropic efficiency
of a compressor or calculate the power consumption (obtained from the isentropic enthalpy)
for a given efficiency.
</p>

<p>
Example:
</p>
<blockquote><pre>
  Medium.AbsolutePressure p_downstream=10e5;
  Medium.SpecificEnthalpy h_downstream=4.1e5;
  Medium.AbsolutePressure p_upstream=3e5;
  Medium.SpecificEnthalpy h_upstream=4.0e5;

  // Isentropic efficiency of a compressor:
  Real eta_is;

equation

  h_is = isentropicEnthalpy(p_downstream, Medium.setState_phX(p_upstream, h_upstream));

  eta_is = (h_is-h_upstream)/(h_downstream - h_upstream);
</pre></blockquote>

<h4>Restrictions</h4>
<p>
The isentropic efficiency function should not be applied in liquid region.
</p>
</html>"));
    end isentropicEnthalpy;

    function derivsOf_ph
      "Derivatives required for inversion of temperature and density functions"

      extends Modelica.Icons.Function;

      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input Integer phase "Number of phases";
      output Common.InverseDerivatives_rhoT derivs
        "Inverse derivatives for density and temperature";

    protected
      Modelica.Media.Common.HelmholtzDerivs f "Helmholtz derivatives";
      SaturationProperties sat "Saturation temperature and pressure";
      Common.PhaseBoundaryProperties liq "Properties on liquid phase boundary";
      Common.PhaseBoundaryProperties vap "Properties on vapor phase boundary";
      Modelica.Media.Common.NewtonDerivatives_ph newder "Newton derivatives";
      Real x "Vapor quality";
      Real dxv "1/(v_vap - v_liq)";
    algorithm
      derivs.p := p;
      derivs.h := h;
      derivs.phase := getPhase_ph(p, h);

      sat.psat := p;
      sat.Tsat := saturationTemperature(p);

      (derivs.rho,derivs.T) := dt_ph(p=p, h=h);

      if derivs.phase == 2 then
        liq := R134a_liqofdT(T=derivs.T);
        vap := R134a_vapofdT(T=derivs.T);
        x := if liq.h <> vap.h then (h - liq.h)/(vap.h - liq.h) else if h >=
          vap.h then 1 else 0;
        derivs.cv := Common.cv2Phase(
              liq=liq,
              vap=vap,
              x=x,
              p=p,
              T=derivs.T);
        dxv := if (liq.d <> vap.d) then liq.d*vap.d/(liq.d - vap.d) else 0.0;
        derivs.dpT := (vap.s - liq.s)*dxv;
      else
        f := f_R134a(d=derivs.rho, T=derivs.T);
        f.d := derivs.rho;
        f.T := derivs.T;
        f.R_s := R134aData.R_s;
        newder := Modelica.Media.Common.Helmholtz_ph(f=f);
        derivs.cv := -f.R_s*(f.tau*f.tau*f.ftautau);
        derivs.pd := newder.pd;
        derivs.pt := newder.pt;
        //derivs.dpT := 0;
      end if;

      annotation (Documentation(info="<html>
<p>This function calculates the derivatives required for an inversion of temperature and density function.
</p>
</html>"));
    end derivsOf_ph;

    function dt_ph
      "Density and temperature w.r.t. pressure and specific enthalpy"

      extends Modelica.Icons.Function;

      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      output Density d "Density";
      output Temperature T "Temperature";
    protected
      SaturationProperties sat(psat=p, Tsat=0)
        "Saturation temperature and pressure";
      SI.Pressure delp=1.0e-2 "Relative error in p in iteration";
      SI.SpecificEnthalpy delh=1.0e-2
        "Relative error in h in iteration";
      SI.SpecificEnthalpy hvapor=dewEnthalpy(sat=sat)
        "Vapor enthalpy";
      SI.SpecificEnthalpy hliquid=bubbleEnthalpy(sat=sat)
        "Liquid enthalpy";
      Integer error "Iteration error";
      Real x "Vapor quality";
      Real vvap "Specific volume vapor";
      Real vliq "Specific volume liquid";
    algorithm
      if ((h < hliquid) or (h > hvapor) or (p > R134aData.data.FPCRIT)) then
        (d,T,error) := Modelica.Media.R134a.R134a_ph.dtofphOnePhase(
              p,
              h,
              delp,
              delh);
      else
        vvap := 1/dewDensity(sat=sat);
        vliq := 1/bubbleDensity(sat=sat);
        x := (h - hliquid)/(hvapor - hliquid);
        error := 0;
        T := saturationTemperature(p);
        d := 1/(vliq + x*(vvap - vliq));
      end if;

      annotation (Documentation(info="<html>
<p>This function calculates the density and temperature of R134a from absolute pressure and specific enthalpy. In one-phase region the function calls the fundamental Helmholtz equation of Tillner-Roth (1994). In two-phase the density and temperature is computed from cubic splines for saturated pressure, liquid and vapor density.
</p>
<h4>Restrictions</h4>
The function cannot be inverted in a numerical way. Please use functions <a href=\"modelica://Modelica.Media.R134a.R134a_ph.rho_props_ph\">rho_props_ph</a> and <a href=\"modelica://Modelica.Media.R134a.R134a_ph.T_props_ph\">T_props_ph</a> for this purpose.
</html>"));
    end dt_ph;

    function dtofphOnePhase
      "Density and temperature w.r.t. pressure and specific enthalpy in one-phase region"

      extends Modelica.Icons.Function;

      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Enthalpy";
      input AbsolutePressure delp "Absolute error in p in iteration";
      input SpecificEnthalpy delh "Absolute error in h in iteration";

      output Density d "Density";
      output Temperature T "Temperature";
      output Integer error "1 if did not converged";

    protected
      constant Real p_breaks[:]=R134aData.pbreaks
        "Grid points of reduced pressure";
      constant Real hl_coef[:, 4]=R134aData.hlcoef
        "Coefficients of cubic spline for h_liq(p)";
      constant Real dl_coef[:, 4]=R134aData.dlcoef
        "Coefficients of cubic spline for rho_liq(p)";
      constant Real T_coef[:, 4]=R134aData.Tcoef
        "Coefficients of cubic spline for Tsat(p)";
      constant Real dv_coef[:, 4]=R134aData.dvcoef
        "Coefficients of cubic spline for rho_vap(p)";

      SI.SpecificEnthalpy hl "Liquid enthalpy";
      Boolean liquid "Is liquid";
      Boolean supercritical "Is supercritical";
      Integer int "Interval number";
      Real pred "Reduced pressure";
      Real localx "Abscissa of local spline";
      Integer i "Newton iteration number";
      Real dh "Difference in h";
      Real dp "Difference in p";
      Real damping "Damping constant";
      Real det "Determinant";
      Real deld "Density change";
      Real delt "Temperature change";
      Modelica.Media.Common.HelmholtzDerivs f "Helmholtz derivatives";
      Modelica.Media.Common.NewtonDerivatives_ph nDerivs "Newton derivatives";
      Boolean found "Iteration converged";
    algorithm
      i := 0;
      error := 0;
      found := false;
      damping := 1.0;
      //by default no damping
      pred := p/R134aData.data.FPCRIT;
      (int,error) := Common.FindInterval(pred, p_breaks);
      localx := pred - p_breaks[int];
      // set decent initial guesses for d and T
      supercritical := p > R134aData.data.FPCRIT;
      if supercritical then
        // iteration seems to work better if coming from high densities
        d := R134aData.data.FDCRIT*3.0;
        //      dTR.T := data.TCRIT + 10.0;
        // linear approximation that can be made generic
        T := 270.0 + 120.0*(h/R134aData.data.HCRIT);
      else
        liquid := h < 1.01*R134aData.data.HCRIT*Common.CubicSplineEval(localx,
          hl_coef[int, 1:4]);
        if liquid then
          damping := 0.3;
          //damping on the liquid side
          d := R134aData.data.FDCRIT*Common.CubicSplineEval(localx, dl_coef[int,1:4])*1.5;
          T := Common.CubicSplineEval(localx, T_coef[int, 1:4]);
        else
          d := R134aData.data.FDCRIT*Common.CubicSplineEval(localx, dv_coef[int,1:4])*0.95;
          T := Common.CubicSplineEval(localx, T_coef[int, 1:4]);
        end if;
      end if;

      // the Newton iteration
      while ((i < 50) and not found) loop
        f := f_R134a(d, T);
        // nDerivs are the symbolic derivatives needed in the iteration
        // for given d and T
        nDerivs := Modelica.Media.Common.Helmholtz_ph(f);
        dh := nDerivs.h - h;
        dp := nDerivs.p - p;
        if ((abs(dh) <= delh) and (abs(dp) <= delp)) then
          found := true;
          error := if not found then 1 else 0;
        end if;
        det := nDerivs.ht*nDerivs.pd - nDerivs.pt*nDerivs.hd;
        if abs(det) < 1e-10 then
          det := sign(det)*1e-10;
        end if;
        delt := (nDerivs.pd*dh - nDerivs.hd*dp)/det;
        deld := (nDerivs.ht*dp - nDerivs.pt*dh)/det;
        T := T - damping*delt;
        d := d - damping*deld;
        // Check for limit of state variables
        if T < R134aData.triple.TTRIPLE then
          T := R134aData.triple.TTRIPLE + 0.1;
        end if;
        if d <= 0.0 then
          d := R134aData.triple.DVTRIPLE;
        elseif d > 1.5*R134aData.triple.DLTRIPLE then
          d := R134aData.triple.DLTRIPLE;
        end if;
        i := i + 1;
      end while;

      annotation (Documentation(info="<html>
<p>This function calculates the density and temperature of R134a from absolute pressure and specific enthalpy in one-phase region. The function calls the fundamental Helmholtz equation of Tillner-Roth (1994) which is requiring density and temperature for input. Thus, a newton iteration is performed to determine density and temperature. The newton iteration stops if the inputs for pressure difference delp and specific enthalpy difference delh are larger than the actual differences derived from the newton iteration.
</p>
<h4>Restrictions</h4>
The function shall only be used for one-phase inputs since the fundamental equation is not valid for two-phase states.
</html>"));
    end dtofphOnePhase;

    function dtofpsOnePhase
      "Inverse iteration in one phase region (d,T) = f(p,s)"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input AbsolutePressure delp "Absolute iteration accuracy";
      input SpecificEntropy dels "Absolute iteration accuracy";
      output Density d "Density";
      output Temperature T "Temperature";
      output Integer error "Error flag: trouble if different from 0";

    protected
      constant Real p_breaks[:]=R134aData.pbreaks
        "Grid points of reduced pressure";
      constant Real dl_coef[:, 4]=R134aData.dlcoef
        "Coefficients of cubic spline for rho_liq(p)";
      constant Real dv_coef[:, 4]=R134aData.dvcoef
        "Coefficients of cubic spline for rho_vap(p)";
      constant Real sl_coef[:, 4]=R134aData.slcoef
        "Coefficients of cubic spline for s_liq(p)";
      constant Real sv_coef[:, 4]=R134aData.svcoef
        "Coefficients of cubic spline for s_vap(p)";
      constant Real T_coef[:, 4]=R134aData.Tcoef
        "Coefficients of cubic spline for Tsat(p)";
      Integer i "Newton iteration number";
      Real ds "Difference in s";
      Real dp "Difference in p";
      Real det "Determinant";
      Real deld "Density change";
      Real delt "Temperature change";
      Modelica.Media.Common.HelmholtzDerivs f
        "Dimensionless Helmholtz function and derivatives w.r.t. dimensionless d and T";
      Modelica.Media.Common.NewtonDerivatives_ps nDerivs "Newton derivatives";
      Boolean liquid "Is liquid";
      Boolean supercritical "Is supercritical";
      Boolean found "Iteration converged";
      Integer int "Interval number";
      Real pred "Reduced pressure";
      Real localx "Abscissa of local spline";
      Real sl "Liquid entropy";
      Real sv "Vapor entropy";
    algorithm
      i := 0;
      error := 0;
      found := false;
      pred := p/R134aData.data.FPCRIT;
      (int,error) := Common.FindInterval(pred, p_breaks);
      localx := pred - p_breaks[int];
      // set decent initial guesses for d and T
      supercritical := p > R134aData.data.FPCRIT;
      if supercritical then
        d := R134aData.data.FDCRIT + 500.0;
        T := R134aData.data.FTCRIT + 10.0;
      else
        sl := R134aData.data.SCRIT*Common.CubicSplineEval(localx, sl_coef[int,
          1:4]);
        sv := R134aData.data.SCRIT*Common.CubicSplineEval(localx, sv_coef[int,
          1:4]);
        liquid := s < sl;
        if liquid then
          d := R134aData.data.FDCRIT*Common.CubicSplineEval(localx, dl_coef[int,
            1:4])*1.1;
          //1.05
          T := Common.CubicSplineEval(localx, T_coef[int, 1:4])*0.9;
          //0.95
        else
          d := R134aData.data.FDCRIT*Common.CubicSplineEval(localx, dv_coef[int,
            1:4])*0.8;
          //0.9
          T := Common.CubicSplineEval(localx, T_coef[int, 1:4])*1.1 + 0.5*(s -
            sv);
        end if;
      end if;

      while ((i < 100) and not found) loop
        f := f_R134a(d=d, T=T);
        nDerivs := Modelica.Media.Common.Helmholtz_ps(f);
        ds := nDerivs.s - s;
        dp := nDerivs.p - p;
        if ((abs(ds/s) <= dels) and (abs(dp/p) <= delp)) then
          found := true;
        end if;
        det := nDerivs.st*nDerivs.pd - nDerivs.pt*nDerivs.sd;
        delt := (nDerivs.pd*ds - nDerivs.sd*dp)/det;
        deld := (nDerivs.st*dp - nDerivs.pt*ds)/det;
        T := T - delt;
        d := d - deld;
        i := i + 1;
      end while;
      if not found then
        error := 1;
      end if;

      annotation (Documentation(info="<html>
<p>This function calculates the density and temperature of R134a from absolute pressure and specific entropy in one-phase region. The function calls the fundamental helmholtz equation of Tillner-Roth (1994) which is requiring density and temperature for input. Thus, a newton iteration is performed to determine density and temperature. The newton iteration stops if the inputs for pressure difference delp and specific entropy difference dels are larger than the actual differences derived from the newton iteration.
</p>
<h4>Restrictions</h4>
The function shall only be used for one-phase inputs since the fundamental equation is not valid for two-phase states. The iteration could fail for liquid states with high pressures.
</html>"));
    end dtofpsOnePhase;

    function f_R134a
      "Calculation of helmholtz derivatives by density and temperature"
      extends Modelica.Icons.Function;

      input Density d "Density";
      input Temperature T "Temperature";
      output Modelica.Media.Common.HelmholtzDerivs f "Helmholtz derivatives";
    protected
      Real delta "Reduced density";
      Real tau "Reduced temperature";
      Modelica.Media.Common.HelmholtzDerivs fid "Helmholtz derivstives";

    algorithm
      delta := d/R134aData.data.DCRIT;
      tau := R134aData.data.TCRIT/T;
      fid := fid_R134a(delta=delta, tau=tau);
      f := fres_R134a(delta=delta, tau=tau);
      f.f := f.f + fid.f;
      f.fdelta := f.fdelta + fid.fdelta;
      f.fdeltadelta := f.fdeltadelta + fid.fdeltadelta;
      f.ftau := f.ftau + fid.ftau;
      f.ftautau := f.ftautau + fid.ftautau;
      f.d := d;
      f.T := T;
      f.R_s := R134aData.R_s;

      annotation (Documentation(info="<html>
This function adds the ideal gas contribution of the fundamental equation to the residual contribution and computes the helmholtz derivatives w.r.t. temperature and density.
</html>"));
    end f_R134a;

    function fid_R134a "Helmholtz coefficients of ideal part"
      extends Modelica.Icons.Function;

      input Real delta "Reduced density (delta=d/dcrit)";
      input Real tau "Reduced temperature (tau=Tcrit/T)";
      output Modelica.Media.Common.HelmholtzDerivs fid
        "Helmholtz derivatives of ideal part";
    protected
      Modelica.Media.R134a.R134aData.Ideal id "Ideal coefficients";
      Real atau=abs(tau) "|tau|";
      Real adelta=abs(delta) "|delta|";
    algorithm
      fid.delta := delta;
      fid.tau := tau;
      fid.f := Modelica.Math.log(adelta) + id.a[1] + id.a[2]*atau + id.a[3]*
        Modelica.Math.log(atau) + id.a[4]*atau^(-0.5) + id.a[5]*atau^(-0.75);
      fid.fdelta := 1.0/adelta;
      fid.fdeltadelta := -1.0/(adelta*adelta);
      fid.ftau := id.a[2] + id.a[3]/atau - 0.5*id.a[4]*atau^(-1.5) - 0.75*id.a[
        5]*atau^(-1.75);
      fid.ftautau := -id.a[3]/(atau*atau) + 0.75*id.a[4]*atau^(-2.5) + 1.3125*
        id.a[5]*atau^(-2.75);
      fid.fdeltatau := 0.0;
      fid.d := fid.delta*R134aData.data.DCRIT;
      fid.T := R134aData.data.TCRIT/fid.tau;
      fid.R_s := R134aData.R_s;

      annotation (Documentation(info="<html>
This function computes the ideal gas helmholtz derivatives of the fundamental equation of Tillner-Roth and Baehr for R134a (1994) w.r.t. to reduced temperature (tau=T_crit/T) and reduced density (delta=rho/rho_crit).
</html>"));
    end fid_R134a;

    function fres_R134a "Calculation of helmholtz derivatives"
      extends Modelica.Icons.Function;

      input Real delta "Reduced density (delta=d/dcrit)";
      input Real tau "Reduced temperature (tau=Tcrit/T)";
      output Modelica.Media.Common.HelmholtzDerivs f "Helmholtz derivatives";
    protected
      Modelica.Media.R134a.R134aData.Residual res "Residual coefficient";
      Real k "Helping var";
      Real dc "Helping var";
      Real cdc "Helping var";
    algorithm
      f.tau := abs(tau);
      f.delta := abs(delta);
      f.f := 0.0;
      f.ftau := 0.0;
      f.fdelta := 0.0;
      f.ftautau := 0.0;
      f.fdeltadelta := 0.0;
      f.fdeltatau := 0.0;
      for i in 1:res.ns1 loop
        k := res.n[i]*f.delta^res.d[i]*f.tau^res.t[i];
        f.f := f.f + k;
        f.fdelta := f.fdelta + k*res.d[i];
        f.fdeltadelta := f.fdeltadelta + k*res.d[i]*(res.d[i] - 1.0);
        f.ftau := f.ftau + k*res.t[i];
        f.ftautau := f.ftautau + k*res.t[i]*(res.t[i] - 1.0);
        f.fdeltatau := f.fdeltatau + k*res.t[i]*res.d[i];
      end for;
      for i in res.ns1 + 1:21 loop
        dc := f.delta^res.c[i];
        cdc := res.c[i]*dc;
        k := Modelica.Math.exp(-dc)*res.n[i]*delta^res.d[i]*f.tau^res.t[i];
        f.f := f.f + k;
        f.fdelta := f.fdelta + k*(res.d[i] - cdc);
        f.fdeltadelta := f.fdeltadelta + k*((res.d[i] - cdc)*(res.d[i] - 1.0 -
          cdc) - res.c[i]*cdc);
        f.ftau := f.ftau + k*res.t[i];
        f.ftautau := f.ftautau + k*res.t[i]*(res.t[i] - 1.0);
        f.fdeltatau := f.fdeltatau + k*res.t[i]*(res.d[i] - cdc);
      end for;
      f.fdelta := f.fdelta/delta;
      f.fdeltadelta := f.fdeltadelta/(delta*delta);
      f.ftau := f.ftau/tau;
      f.ftautau := f.ftautau/(tau*tau);
      f.fdeltatau := f.fdeltatau/(delta*tau);
      f.d := f.delta*R134aData.data.DCRIT;
      f.T := R134aData.data.TCRIT/f.tau;
      f.R_s := R134aData.R_s;

      annotation (Documentation(info="<html>
This function computes the residual helmholtz derivatives of the fundamental equation of Tillner-Roth and Baehr for R134a (1994) w.r.t. to reduced temperature (tau=T_crit/T) and reduced density (delta=rho/rho_crit). The function can be used for special properties depending just on the residual derivative parts.
</html>"));
    end fres_R134a;

    function getPhase_ph "Number of phases by pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";

      output Integer phase "Number of phases";

    protected
      SaturationProperties sat(psat=p, Tsat=0)
        "Saturation temperature and pressure";
      SI.SpecificEnthalpy hl=bubbleEnthalpy(sat)
        "Liquid enthalpy";
      SI.SpecificEnthalpy hv=dewEnthalpy(sat) "Vapor enthalpy";

    algorithm
      phase := if ((h < hl) or (h > hv) or (p > R134aData.data.FPCRIT)) then 1
         else 2;

      annotation (Documentation(info="<html>
This function computes the number of phases for R134a depending on the inputs for absolute pressure and specific enthalpy. It makes use of cubic spline functions for liquid and vapor specific enthalpy.
</html>"));
    end getPhase_ph;

    function getPhase_ps "Number of phases by pressure and entropy"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      output Integer phase "Number of phases";

    protected
      SaturationProperties sat(psat=p, Tsat=0)
        "Saturation temperature and pressure";
      SI.SpecificEntropy sl=bubbleEntropy(sat) "Liquid entropy";
      SI.SpecificEntropy sv=dewEntropy(sat) "Vapor entropy";

    algorithm
      phase := if ((s < sl) or (s > sv) or (p > R134aData.data.FPCRIT)) then 1
         else 2;

      annotation (Documentation(info="<html>
This function computes the number of phases for R134a depending on the inputs for absolute pressure and specific entropy. It makes use of cubic spline functions for liquid and vapor specific entropy.
</html>"));
    end getPhase_ps;

    function hofpsTwoPhase
      "Isentropic specific enthalpy in two phase region h(p,s)"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      output SpecificEnthalpy h "Specific enthalpy";

    protected
      SaturationProperties sat "Saturation temperature and pressure";
      SI.MassFraction x "Vapor quality";
      SI.SpecificEntropy sl "Liquid entropy";
      SI.SpecificEntropy sv "Vapor entropy";
      SI.SpecificEnthalpy hl "Liquid enthalpy";
      SI.SpecificEnthalpy hv "Vapor enthalpy";
    algorithm
      sat.psat := p;
      // dummy
      sat.Tsat := 0;
      hl := bubbleEnthalpy(sat=sat);
      hv := dewEnthalpy(sat=sat);
      sl := bubbleEntropy(sat=sat);
      sv := dewEntropy(sat=sat);
      x := (s - sl)/(sv - sl);
      h := hl + x*(hv - hl);

      annotation (Documentation(info="<html>
This function computes the specific enthalpy in two-phase for R134a depending on the inputs for absolute pressure and specific entropy. It makes use of cubic spline functions for liquid and vapor specific enthalpy as well as specific entropy.
</html>"));
    end hofpsTwoPhase;

    function R134a_liqofdT "Properties on liquid boundary phase"

      extends Modelica.Icons.Function;

      input Temperature T "Temperature";

      output Common.PhaseBoundaryProperties liq
        "Properties on liquid boundary phase";
    protected
      SI.Temperature T_liq "Liquid temperature";
      SI.Density d_liq "Liquid density";
      Modelica.Media.Common.HelmholtzDerivs f "Helmholtz derivatives";
    algorithm
      if T < R134aData.data.TCRIT then
        d_liq := bubbleDensity(setSat_T(T));
        T_liq := T;
      else
        d_liq := R134aData.data.DCRIT;
        T_liq := R134aData.data.TCRIT;
      end if;
      f := f_R134a(d_liq, T_liq);
      liq := Common.helmholtzToBoundaryProps(f);

    end R134a_liqofdT;

    function R134a_vapofdT "Properties on vapor boundary phase"

      extends Modelica.Icons.Function;

      input Temperature T "Temperature";

      output Common.PhaseBoundaryProperties vap
        "Properties on vapor boundary phase";
    protected
      SI.Temperature T_vap "Vapor temperature";
      SI.Density d_vap "Vapor density";
      Modelica.Media.Common.HelmholtzDerivs f "Helmholtz derivatives";
    algorithm
      if T < R134aData.data.TCRIT then
        d_vap := dewDensity(setSat_T(T));
        T_vap := T;
      else
        d_vap := R134aData.data.DCRIT;
        T_vap := R134aData.data.TCRIT;
      end if;
      f := f_R134a(d_vap, T_vap);
      vap := Common.helmholtzToBoundaryProps(f);

    end R134a_vapofdT;

    function rho_ph_der "Time derivative function of density_ph"
      extends Modelica.Icons.Function;

      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input Common.InverseDerivatives_rhoT derivs "Record for derivatives";
      input Real p_der "Derivative of pressure";
      input Real h_der "Derivative of specific enthalpy";
      output Real d_der "Derivative of density";
    algorithm
      if (derivs.phase == 2) then
        d_der := (derivs.rho*(derivs.rho*derivs.cv/derivs.dpT + 1.0)/(derivs.dpT
          *derivs.T))*p_der + (-derivs.rho*derivs.rho/(derivs.dpT*derivs.T))*
          h_der;
      else
        d_der := ((derivs.rho*(derivs.cv*derivs.rho + derivs.pt))/(derivs.rho*
          derivs.rho*derivs.pd*derivs.cv + derivs.T*derivs.pt*derivs.pt))*p_der
           + (-derivs.rho*derivs.rho*derivs.pt/(derivs.rho*derivs.rho*derivs.pd
          *derivs.cv + derivs.T*derivs.pt*derivs.pt))*h_der;
      end if;

      annotation (Documentation(info="<html>
This function calculates the derivative of density w.r.t. time. It is used as derivative function for <a href=\"modelica://Modelica.Media.R134a.R134a_ph.rho_props_ph\"> rho_props_ph</a>.
</html>"));
    end rho_ph_der;

    function rho_props_ph
      "Density as function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;

      input SI.Pressure p "Pressure";
      input SI.SpecificEnthalpy h "Specific enthalpy";
      input Common.InverseDerivatives_rhoT derivs
        "Record for the calculation of rho_ph_der";
      output SI.Density d "Density";
    algorithm
      d := derivs.rho;

      annotation (
        derivative(noDerivative=derivs) = rho_ph_der,
        Inline=false,
        LateInline=true,
        Documentation(info="<html>
This function integrates the derivative of density w.r.t. time in order to allow a numerical inversion for the complex fundamental equation of state.
</html>"));
    end rho_props_ph;

    function T_ph_der "Time derivative function of T_ph"
      extends Modelica.Icons.Function;

      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input Common.InverseDerivatives_rhoT derivs "Auxiliary record";
      input Real p_der "Derivative of pressure";
      input Real h_der "Derivative of specific enthalpy";
      output Real T_der "Derivative of temperature";
    algorithm
      if (derivs.phase == 2) then
        T_der := 1/derivs.dpT*p_der;
      else
        T_der := ((-derivs.rho*derivs.pd + derivs.T*derivs.pt)/(derivs.rho*
          derivs.rho*derivs.pd*derivs.cv + derivs.T*derivs.pt*derivs.pt))*p_der
           + ((derivs.rho*derivs.rho*derivs.pd)/(derivs.rho*derivs.rho*derivs.pd
          *derivs.cv + derivs.T*derivs.pt*derivs.pt))*h_der;
      end if;

      annotation (Documentation(info="<html>
This function calculates the derivative of temperature w.r.t. time. It is used as derivative function for <a href=\"modelica://Modelica.Media.R134a.R134a_ph.T_props_ph\"> T_props_ph</a>.
</html>"));
    end T_ph_der;

    function T_props_ph
      "Temperature as function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;

      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input Common.InverseDerivatives_rhoT derivs
        "Record for the calculation of T_ph_der";
      output Temperature T "Temperature";
    algorithm
      T := derivs.T;

      annotation (
        derivative(noDerivative=derivs) = T_ph_der,
        Inline=false,
        LateInline=true,
        Documentation(info="<html>
This function integrates the derivative of temperature w.r.t. time in order to allow a numerical inversion for the complex fundamental equation of state.
</html>"));
    end T_props_ph;

    redeclare function extends setSmoothState
      "Smooth transition function between state_a and state_b"
      import Modelica.Media.Common.smoothStep;
    algorithm
      state := ThermodynamicState(
        p=smoothStep(
          x,
          state_a.p,
          state_b.p,
          x_small),
        h=smoothStep(
          x,
          state_a.h,
          state_b.h,
          x_small),
        T=temperature_ph(smoothStep(
          x,
          state_a.p,
          state_b.p,
          x_small), smoothStep(
          x,
          state_a.h,
          state_b.h,
          x_small)),
        d=density_ph(smoothStep(
          x,
          state_a.p,
          state_b.p,
          x_small), smoothStep(
          x,
          state_a.h,
          state_b.h,
          x_small)),
        phase=0);
      annotation (Inline=true);
    end setSmoothState;

    function dofpT "Compute d for given p and T"
      extends Modelica.Icons.Function;
      input SI.Pressure p "Pressure";
      input SI.Temperature T "Temperature";
      input SI.Pressure delp "Iteration converged if (p-pre(p) < delp)";
      output SI.Density d "Density";

    protected
      constant Real p_breaks[:]=R134aData.pbreaks
        "Grid points of reduced pressure";
      constant Real dl_coef[:, 4]=R134aData.dlcoef
        "Coefficients of cubic spline for rho_liq(p)";
      constant Real dv_coef[:, 4]=R134aData.dvcoef
        "Coefficients of cubic spline for rho_vap(p)";

      Boolean liquid "Is liquid";
      Boolean supercritical "Is supercritcal";
      Integer int "Interval number";
      Real pred "Reduced pressure";
      Real localx "Abscissa of local spline";
      Integer i "Newton iteration number";
      Real dp "Pressure difference";
      SI.Density deld "Density step";
      Modelica.Media.Common.HelmholtzDerivs f
        "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
      Modelica.Media.Common.NewtonDerivatives_pT nDerivs
        "Derivatives needed in Newton iteration";
      Boolean found "Flag for iteration success";
      Integer error "1 if did not converged";

    algorithm
      Modelica.Media.R134a.R134a_ph.phaseBoundaryAssert(p, T);
      i := 0;
      error := 0;
      found := false;
      pred := p/R134aData.data.FPCRIT;
      (int,error) := Common.FindInterval(pred, p_breaks);
      localx := pred - p_breaks[int];
      // set decent initial guesses for d and T
      supercritical := p > R134aData.data.FPCRIT;
      if supercritical then
        // iteration seems to work better if coming from high densities
        d := R134aData.data.FDCRIT*3.0;
      else
        liquid := T <= Modelica.Media.R134a.R134a_ph.saturationTemperature(p);
        if liquid then
          d := R134aData.data.FDCRIT*Common.CubicSplineEval(localx, dl_coef[int,
            1:4])*1.02;
        else
          d := R134aData.data.FDCRIT*Common.CubicSplineEval(localx, dv_coef[int,
            1:4])*0.95;
        end if;
      end if;

      while ((i < 100) and not found) loop
        f := Modelica.Media.R134a.R134a_ph.f_R134a(d, T);
        nDerivs := Modelica.Media.Common.Helmholtz_pT(f);
        dp := nDerivs.p - p;
        if (abs(dp) <= delp) then
          found := true;
        end if;
        deld := dp/nDerivs.pd;
        d := d - deld;
        i := i + 1;
      end while;

      annotation (Documentation(info="<html>
<p>This function calculates the density of R134a from absolute pressure and temperature. The function can only be executed in one-phase region. The safety margin to the phase boundary is 1[K] and 1000[Pa].
</p>
<h4>Restrictions</h4>
The function cannot be inverted in a numerical way. Please use functions <a href=\"modelica://Modelica.Media.R134a.R134a_ph.rho_props_ph\">rho_props_ph</a> and <a href=\"modelica://Modelica.Media.R134a.R134a_ph.T_props_ph\">T_props_ph</a> for this purpose.
</html>"));
    end dofpT;

    function hofpT "Compute h for given p and T"
      extends Modelica.Icons.Function;
      input SI.Pressure p "Pressure";
      input SI.Temperature T "Temperature";
      input SI.Pressure delp
        "Iteration converged if (p-pre(p) < delp)";
      output SI.SpecificEnthalpy h "Specific Enthalpy";

    protected
      SI.Density d "Density";
      Modelica.Media.Common.HelmholtzDerivs f "Helmholtz derivatives";

    algorithm
      Modelica.Media.R134a.R134a_ph.phaseBoundaryAssert(p, T);
      d := dofpT(p, T, delp);
      f := f_R134a(d, T);
      h := R134aData.data.R_s*T*(f.tau*f.ftau + f.delta*f.fdelta);

      annotation (Documentation(info="<html>
<p>This function calculates the specific enthalpy of R134a from absolute pressure and temperature. The function can only be executed in one-phase region. The safety margin to the phase boundary is 1[K] and 1000[Pa].
</p>
</html>"));
    end hofpT;

    function phaseBoundaryAssert
      "Assert function for checking threshold to phase boundary"
      extends Modelica.Icons.Function;
      input SI.Pressure p "Refrigerant pressure";
      input SI.Temperature T "Refrigerant temperature";

    protected
      SI.Temperature T_lim_gas "Upper temperature limit";
      SI.Temperature T_lim_liq "Lower temperature limit";
      SI.Temperature T_sat "Saturation temperature";

    algorithm
      T_sat := Modelica.Media.R134a.R134a_ph.saturationTemperature(p);
      T_lim_gas := T_sat + 1;
      T_lim_liq := T_sat - 1;

      assert(p>R134aData.data.PCRIT+1000 or not
                                          (T<T_lim_gas and T>T_lim_liq), "Fluid state is too close to the two-phase region (p="+String(p)+"[Pa], T="+String(T)+"[K]. Pressure and temperature can not be used to determine properties in two-phase region.");

      annotation (Documentation(info="<html>
This function is used as a guard for property functions using pTX as an input. Property functions for two-phase media using pressure and temperature as inputs shall not be used close to the phase boundary in order to avoid errors and high deviations for just small deviations in the input arguments. The refrigerant state can not be determined in the two-phase region using pressure and temperature.
</html>"));
    end phaseBoundaryAssert;
    annotation (Documentation(info="<html>
<p>
Calculation of fluid properties for Tetrafluoroethane (R134a) in the fluid region of 0.0039 bar (Triple pressure) to 700 bar and 169.85 Kelvin (Triple temperature) to 455 Kelvin.
</p>
<h4>Restriction</h4>
<p>
The functions provided by this package shall be used inside of the restricted limits according to the referenced literature.
</p>
<ul>
 <li>
      <strong> 0.0039 bar &le; p &le; 700 bar </strong>
 </li>
 <li>
      <strong> 169.85 Kelvin &le; T &le; 455 Kelvin  </strong>
 </li>
 <li>
      <strong> explicit for pressure and specific enthalpy </strong>
 </li>
</ul>

<p><strong>References</strong></p>
<dl><dt>Baehr, H.D. and Tillner-Roth, R.: </dt>
<dd><strong>Thermodynamic Properties of Environmentally Acceptable Refrigerants -
Equations of State and Tables for Ammonia, R22, R134a, R152a, and R123</strong>. Springer-Verlag, Berlin (Germany), 1994.</dd>
</dl>
<dl><dt>Klein, McLinden and Laesecke: </dt>
<dd><strong>An improved extended corresponding states method for estimation of viscosity of pure refrigerants and mixtures</strong>.
Int. J. Refrig., Vol. 20, No.3, pp. 208-217, 1997.</dd>
</dl>
<dl><dt>McLinden, Klein. and Perkins: </dt>
<dd><strong>An extended corresponding states model for the thermal conductivity
of refrigerants and refrigerant mixtures</strong>.
Int. J. Refrig., 23 (2000) 43-63.</dd>
</dl>
<dl><dt>Okada and Higashi: </dt>
<dd><strong>Surface tension correlation of HFC-134a and HCFC-123</strong>.
Proceedings of the Joint Meeting of IIR Commissions B1, B2, E1, and E2, Padua, Italy, pp. 541-548, 1994.</dd>
</dl>
</html>"));
  end R134a_ph;

  package R134aData "R134a data required by package R134a_ph"

    extends Modelica.Icons.Package;
    constant SI.SpecificHeatCapacity R_s=data.R_s;
    constant Integer Npoints=478;
    constant Integer Ninterval=Npoints - 1;
    constant Real[Npoints] pbreaks={9.597762848258994e-005,
        9.869357747732370e-005,1.010264375639950e-004,1.065169584583328e-004,
        1.123059413359126e-004,1.184094248412308e-004,1.248446933924201e-004,
        1.316297064467259e-004,1.387835295300911e-004,1.463261079761978e-004,
        1.542786111807819e-004,1.626631846135783e-004,1.715035062398977e-004,
        1.808243694992149e-004,1.906517107583061e-004,2.010132485287069e-004,
        2.119377912202213e-004,2.234561174702443e-004,2.356004528862385e-004,
        2.484047512716141e-004,2.616284653191377e-004,2.747881183685521e-004,
        2.885158790807569e-004,3.028318826616158e-004,3.177568016040576e-004,
        3.333118542894548e-004,3.495188133266056e-004,3.664000141427236e-004,
        3.839783631625294e-004,4.022773464529003e-004,4.213210377579724e-004,
        4.411341070924892e-004,4.617418287585031e-004,4.831700895846934e-004,
        5.054453973240350e-004,5.285948883287491e-004,5.526463359992557e-004,
        5.776281585116855e-004,6.035694268866237e-004,6.304998727332601e-004,
        6.584498962084673e-004,6.874505733153568e-004,7.175336642444060e-004,
        7.487316202293097e-004,7.810775914127821e-004,8.146054342502127e-004,
        8.493497185583605e-004,8.853457349505343e-004,9.226295020377572e-004,
        9.612377731634476e-004,1.001208043569667e-003,1.042578557225471e-003,
        1.085388313487843e-003,1.129677073668393e-003,1.175485367705820e-003,
        1.222854500460934e-003,1.271826558129384e-003,1.322444414376414e-003,
        1.374751736326610e-003,1.428792990668195e-003,1.484613449495073e-003,
        1.542259195759381e-003,1.601777129328165e-003,1.663214972080042e-003,
        1.726621273310258e-003,1.792045415319891e-003,1.859537618008464e-003,
        1.929148944128722e-003,2.000931304128618e-003,2.074937460870742e-003,
        2.151221034049469e-003,2.229836504887513e-003,2.310839220352569e-003,
        2.394285397224690e-003,2.480232126358037e-003,2.568737376543922e-003,
        2.659859998183566e-003,2.753659727089886e-003,2.850197187960054e-003,
        2.949533897578886e-003,3.051732268501956e-003,3.156855611648015e-003,
        3.264968139624009e-003,3.376134969543659e-003,3.490422125512034e-003,
        3.607896541474759e-003,3.728626063414313e-003,3.852679451797347e-003,
        3.980126383732962e-003,4.111037454976533e-003,4.245484181734639e-003,
        4.383539002791262e-003,4.525275280559336e-003,4.670767303162268e-003,
        4.820090285488170e-003,4.973320370546478e-003,5.130534630480654e-003,
        5.291811067763014e-003,5.457228615833621e-003,5.626867140010384e-003,
        5.800807438004561e-003,5.979131240454509e-003,6.161921211248477e-003,
        6.349260947941199e-003,6.541234981608406e-003,6.737928777105548e-003,
        6.939428732811780e-003,7.145822180530093e-003,7.357197385013741e-003,
        7.573643543593235e-003,7.795250785685322e-003,8.022110172037484e-003,
        8.254313693933356e-003,8.491954272338212e-003,8.735125756982369e-003,
        8.983922925176295e-003,9.238441480673905e-003,9.498778052406051e-003,
        9.765030192907764e-003,1.003729637709093e-002,1.031567600057533e-002,
        1.060026937790312e-002,1.089117774088576e-002,1.118850323681089e-002,
        1.149234892629966e-002,1.180281878149178e-002,1.212001768378737e-002,
        1.244405142182634e-002,1.277502668901607e-002,1.311305108132637e-002,
        1.345823309485172e-002,1.381068212326552e-002,1.417050845529529e-002,
        1.453782327208102e-002,1.491273864445383e-002,1.529536753016332e-002,
        1.568582377114743e-002,1.608422209040166e-002,1.649067808931178e-002,
        1.690530824446280e-002,1.732822990453687e-002,1.775956128744187e-002,
        1.819942147677864e-002,1.864793041887473e-002,1.910520891956503e-002,
        1.957137864057372e-002,2.004656209644468e-002,2.053088265103482e-002,
        2.102446451411387e-002,2.152743273774831e-002,2.203991321298626e-002,
        2.256203266622321e-002,2.309391865555178e-002,2.363569956736602e-002,
        2.418750461246241e-002,2.474946382258750e-002,2.532170804665175e-002,
        2.590436894709933e-002,2.649757899613318e-002,2.710147147198215e-002,
        2.771618045516845e-002,2.834184082475825e-002,2.897858825451354e-002,
        2.962655920917527e-002,3.028589094062469e-002,3.095672148415131e-002,
        3.163918965453092e-002,3.233343504239619e-002,3.303959801019879e-002,
        3.375781968861326e-002,3.448824197265431e-002,3.523100751788461e-002,
        3.598625973665024e-002,3.675414279428406e-002,3.753480160540696e-002,
        3.832838183003045e-002,3.913502986997648e-002,3.995489286516166e-002,
        4.078811868980567e-002,4.163485594877166e-002,4.249525397402870e-002,
        4.336946282080187e-002,4.425763326428060e-002,4.515991679581355e-002,
        4.607646561937220e-002,4.700743264819789e-002,4.795297150115203e-002,
        4.891323649938621e-002,4.988838266300229e-002,5.087856570747507e-002,
        5.188394204050219e-002,5.290466875872184e-002,5.394090364435762e-002,
        5.499280516221097e-002,5.606053245635714e-002,5.714424534717350e-002,
        5.824410432822266e-002,5.936027056331945e-002,6.049290588356860e-002,
        6.164217278454836e-002,6.280823442343543e-002,6.399125461636106e-002,
        6.519139783552948e-002,6.640882920680599e-002,6.764371450704471e-002,
        6.889622016163087e-002,7.016651324207315e-002,7.145476146359577e-002,
        7.276113318295722e-002,7.408579739616779e-002,7.542892373645665e-002,
        7.679068247215846e-002,7.817124450477091e-002,7.957078136711258e-002,
        8.098946522143942e-002,8.242746885787376e-002,8.388496569268521e-002,
        8.536212976679605e-002,8.685913574431177e-002,8.837615891128831e-002,
        8.991337517436447e-002,9.147096105967481e-002,9.304909371182504e-002,
        9.464795089290083e-002,9.626771098168203e-002,9.790855297290042e-002,
        9.957065647660095e-002,1.012542017176483e-001,1.029593695353304e-001,
        1.046863413830815e-001,1.064352993283296e-001,1.082064260525101e-001,
        1.099999048510082e-001,1.118159196335355e-001,1.136546549243387e-001,
        1.155162958627491e-001,1.174010282037917e-001,1.193090383188843e-001,
        1.212405131966888e-001,1.231956404442420e-001,1.251746082880320e-001,
        1.271776055753336e-001,1.292048217756560e-001,1.312564469824424e-001,
        1.333326719147161e-001,1.354336879191573e-001,1.375596869720684e-001,
        1.397108616817379e-001,1.418874052908662e-001,1.440895116791160e-001,
        1.463173753659727e-001,1.485711915136508e-001,1.508511559303043e-001,
        1.531574650734013e-001,1.554903160532023e-001,1.578499066364259e-001,
        1.602364352504390e-001,1.626501009871427e-001,1.650911036075191e-001,
        1.675596435460891e-001,1.700559219157807e-001,1.725801405130011e-001,
        1.751325018227866e-001,1.777132090243812e-001,1.803224659969848e-001,
        1.829604773257499e-001,1.856274483079854e-001,1.883235849597385e-001,
        1.910490940225762e-001,1.938041829705809e-001,1.965890600178195e-001,
        1.994039341258457e-001,2.022490150118090e-001,2.051245131564867e-001,
        2.080306398131010e-001,2.109676070159534e-001,2.139356275898521e-001,
        2.169349151595292e-001,2.199656841596673e-001,2.230281498451127e-001,
        2.261225283015071e-001,2.292490364564299e-001,2.324078920906696e-001,
        2.355993138502352e-001,2.388235212584440e-001,2.420807347286962e-001,
        2.453711755776573e-001,2.486950660387031e-001,2.520526292761376e-001,
        2.554440893996220e-001,2.588696714792741e-001,2.623296015612792e-001,
        2.658241066839430e-001,2.693534148944132e-001,2.729177552658184e-001,
        2.765173579152221e-001,2.801524540219758e-001,2.838232758468616e-001,
        2.875300567517182e-001,2.912730312199488e-001,2.950524348775986e-001,
        2.988685045151655e-001,3.027214781102109e-001,3.066115948507304e-001,
        3.105390951593055e-001,3.145042207181398e-001,3.185072144949388e-001,
        3.225483207696795e-001,3.266277851623652e-001,3.307458546616600e-001,
        3.349027776546629e-001,3.390988039576249e-001,3.433341848477569e-001,
        3.476091730962973e-001,3.519240230025824e-001,3.562789904294610e-001,
        3.606743328399952e-001,3.651103093353738e-001,3.695871806943437e-001,
        3.741052094140343e-001,3.786646597522729e-001,3.832657977714583e-001,
        3.879088913841363e-001,3.925942104002511e-001,3.973220265761317e-001,
        4.020926136654290e-001,4.069062474719831e-001,4.117632059046955e-001,
        4.166637690345744e-001,4.216082191539507e-001,4.265968408381747e-001,
        4.316299210096456e-001,4.367077490044181e-001,4.418306166415828e-001,
        4.469988182954611e-001,4.522126509707460e-001,4.574724143807979e-001,
        4.627784110292650e-001,4.681309462951913e-001,4.735303285216456e-001,
        4.789768691084685e-001,4.844708826088187e-001,4.900126868302581e-001,
        4.956026029402373e-001,5.012409555764841e-001,5.069280729624649e-001,
        5.126642870282773e-001,5.184499335373062e-001,5.242853522190180e-001,
        5.302680522792256e-001,5.362148870570488e-001,5.421125034763555e-001,
        5.479604123151721e-001,5.537581634208009e-001,5.595053445140967e-001,
        5.652015800117042e-001,5.708465298673534e-001,5.764398884324107e-001,
        5.819813833363990e-001,5.874707743877503e-001,5.929078524952066e-001,
        5.982924386100538e-001,6.036243826896056e-001,6.089035626818212e-001,
        6.141298835313674e-001,6.193032762071714e-001,6.244236967514051e-001,
        6.294911253499476e-001,6.345055654242815e-001,6.394670427446655e-001,
        6.443756045645810e-001,6.492313187762216e-001,6.540342730869820e-001,
        6.587845742164332e-001,6.634823471141452e-001,6.681277341974906e-001,
        6.727208946097391e-001,6.772620034977512e-001,6.817512513092869e-001,
        6.861888431095735e-001,6.905749979167365e-001,6.949099480559251e-001,
        6.991939385318118e-001,7.034272264190118e-001,7.076100802703395e-001,
        7.117427795423493e-001,7.158256140379710e-001,7.198588833658458e-001,
        7.238428964161435e-001,7.277779708523336e-001,7.316644326187892e-001,
        7.355026154637049e-001,7.392928604808265e-001,7.430355156427725e-001,
        7.467309354101930e-001,7.503794802847638e-001,7.539815165033564e-001,
        7.575374158563575e-001,7.610475525042479e-001,7.645123095847116e-001,
        7.679320711405823e-001,7.713072258757592e-001,7.746381659738916e-001,
        7.779252867810481e-001,7.811689864996086e-001,7.843696658934009e-001,
        7.875277280034720e-001,7.906435778747776e-001,7.937176222932615e-001,
        7.967502695335140e-001,8.000199630662463e-001,8.033009258512434e-001,
        8.065932139849678e-001,8.098968847000179e-001,8.132119945147386e-001,
        8.165386053633329e-001,8.198767769333629e-001,8.232265712101035e-001,
        8.265880515436206e-001,8.299612827168834e-001,8.333463310190913e-001,
        8.367432643245871e-001,8.401521521779828e-001,8.435730658861569e-001,
        8.470060786178580e-001,8.504512655117438e-001,8.539087037939039e-001,
        8.573784729060409e-001,8.608606546457506e-001,8.643553333207711e-001,
        8.678625959196853e-001,8.713825323024099e-001,8.749152354154032e-001,
        8.784608015388341e-001,8.820193305769569e-001,8.855909230615221e-001,
        8.891756908959754e-001,8.927737444522241e-001,8.963852006600686e-001,
        9.000101817311734e-001,9.036488156539342e-001,9.073012367571003e-001,
        9.109675863549037e-001,9.146480134897557e-001,9.183426757925104e-001,
        9.220517404865118e-001,9.257753855697142e-001,9.295138012239329e-001,
        9.332671915249889e-001,9.370357765779688e-001,9.408197916132383e-001,
        9.446194993887446e-001,9.484351827283455e-001,9.522671554710838e-001,
        9.561157672135285e-001,9.599814113076552e-001,9.638645356406839e-001,
        9.677656576771091e-001,9.716853843570205e-001,9.756244470156604e-001,
        9.795837477900006e-001,9.825671883209557e-001,9.855632858038894e-001,
        9.886965153922347e-001,9.917147058660856e-001,9.939889544462242e-001,
        9.955107773467575e-001,9.966554757188424e-001,9.976501440012482e-001,
        9.985707411825207e-001,9.989551169812724e-001,9.991090113187927e-001,
        9.993400213037331e-001,9.995459937617709e-001,9.997521475624808e-001,
        9.998552980391523e-001,9.999068928446231e-001,1.0};
    constant Real[Npoints] Tbreaks={0.453892958213191,0.454558816062682,
        0.455118075727735,0.456391027473952,0.457672503868159,0.458962558356426,
        0.460261324553926,0.461568882629760,0.462885339476068,0.464210775261953,
        0.465545296879551,0.466888984497968,0.468241971732374,0.469604365474908,
        0.470976245894674,0.472357746606843,0.473748947780518,0.475149983030873,
        0.476560959250045,0.477981983330171,0.479384515070455,0.480720666793156,
        0.482056818515856,0.483392970238556,0.484729121961257,0.486065273683957,
        0.487401425406658,0.488737577129358,0.490073728852059,0.491409880574759,
        0.492746032297459,0.494082184020160,0.495418335742860,0.496754487465561,
        0.498090639188261,0.499426790910961,0.500762942633662,0.502099094356362,
        0.503435246079063,0.504771397801763,0.506107549524464,0.507443701247164,
        0.508779852969864,0.510116004692565,0.511452156415265,0.512788308137966,
        0.514124459860666,0.515460611583366,0.516796763306067,0.518132915028767,
        0.519469066751468,0.520805218474168,0.522141370196869,0.523477521919569,
        0.524813673642269,0.526149825364970,0.527485977087670,0.528822128810371,
        0.530158280533071,0.531494432255771,0.532830583978472,0.534166735701172,
        0.535502887423873,0.536839039146573,0.538175190869274,0.539511342591974,
        0.540847494314674,0.542183646037375,0.543519797760075,0.544855949482776,
        0.546192101205476,0.547528252928176,0.548864404650877,0.550200556373577,
        0.551536708096278,0.552872859818978,0.554209011541679,0.555545163264379,
        0.556881314987079,0.558217466709780,0.559553618432480,0.560889770155181,
        0.562225921877881,0.563562073600581,0.564898225323282,0.566234377045982,
        0.567570528768683,0.568906680491383,0.570242832214084,0.571578983936784,
        0.572915135659484,0.574251287382185,0.575587439104885,0.576923590827586,
        0.578259742550286,0.579595894272986,0.580932045995687,0.582268197718387,
        0.583604349441088,0.584940501163788,0.586276652886489,0.587612804609189,
        0.588948956331889,0.590285108054590,0.591621259777290,0.592957411499991,
        0.594293563222691,0.595629714945391,0.596965866668092,0.598302018390792,
        0.599638170113493,0.600974321836193,0.602310473558894,0.603646625281594,
        0.604982777004294,0.606318928726995,0.607655080449695,0.608991232172396,
        0.610327383895096,0.611663535617796,0.612999687340497,0.614335839063197,
        0.615671990785898,0.617008142508598,0.618344294231299,0.619680445953999,
        0.621016597676699,0.622352749399400,0.623688901122100,0.625025052844801,
        0.626361204567501,0.627697356290201,0.629033508012902,0.630369659735602,
        0.631705811458303,0.633041963181003,0.634378114903704,0.635714266626404,
        0.637050418349104,0.638386570071805,0.639722721794505,0.641058873517206,
        0.642395025239906,0.643731176962606,0.645067328685307,0.646403480408007,
        0.647739632130708,0.649075783853408,0.650411935576109,0.651748087298809,
        0.653084239021509,0.654420390744210,0.655756542466910,0.657092694189611,
        0.658428845912311,0.659764997635011,0.661101149357712,0.662437301080412,
        0.663773452803113,0.665109604525813,0.666445756248514,0.667781907971214,
        0.669118059693914,0.670454211416615,0.671790363139315,0.673126514862016,
        0.674462666584716,0.675798818307416,0.677134970030117,0.678471121752817,
        0.679807273475518,0.681143425198218,0.682479576920918,0.683815728643619,
        0.685151880366319,0.686488032089020,0.687824183811720,0.689160335534421,
        0.690496487257121,0.691832638979821,0.693168790702522,0.694504942425222,
        0.695841094147923,0.697177245870623,0.698513397593323,0.699849549316024,
        0.701185701038724,0.702521852761425,0.703858004484125,0.705194156206826,
        0.706530307929526,0.707866459652226,0.709202611374927,0.710538763097627,
        0.711874914820328,0.713211066543028,0.714547218265728,0.715883369988429,
        0.717219521711129,0.718555673433830,0.719891825156530,0.721227976879231,
        0.722564128601931,0.723900280324631,0.725236432047332,0.726572583770032,
        0.727908735492733,0.729244887215433,0.730581038938133,0.731917190660834,
        0.733253342383534,0.734589494106235,0.735925645828935,0.737261797551636,
        0.738597949274336,0.739934100997036,0.741270252719737,0.742606404442437,
        0.743942556165138,0.745278707887838,0.746614859610538,0.747951011333239,
        0.749287163055939,0.750623314778640,0.751959466501340,0.753295618224041,
        0.754631769946741,0.755967921669441,0.757304073392142,0.758640225114842,
        0.759976376837543,0.761312528560243,0.762648680282943,0.763984832005644,
        0.765320983728344,0.766657135451045,0.767993287173745,0.769329438896446,
        0.770665590619146,0.772001742341846,0.773337894064547,0.774674045787247,
        0.776010197509948,0.777346349232648,0.778682500955348,0.780018652678049,
        0.781354804400749,0.782690956123450,0.784027107846150,0.785363259568851,
        0.786699411291551,0.788035563014251,0.789371714736952,0.790707866459652,
        0.792044018182353,0.793380169905053,0.794716321627753,0.796052473350454,
        0.797388625073154,0.798724776795855,0.800060928518555,0.801397080241256,
        0.802733231963956,0.804069383686656,0.805405535409357,0.806741687132057,
        0.808077838854758,0.809413990577458,0.810750142300158,0.812086294022859,
        0.813422445745559,0.814758597468260,0.816094749190960,0.817430900913661,
        0.818767052636361,0.820103204359061,0.821439356081762,0.822775507804462,
        0.824111659527163,0.825447811249863,0.826783962972563,0.828120114695264,
        0.829456266417964,0.830792418140665,0.832128569863365,0.833464721586066,
        0.834800873308766,0.836137025031466,0.837473176754167,0.838809328476867,
        0.840145480199568,0.841481631922268,0.842817783644968,0.844153935367669,
        0.845490087090369,0.846826238813070,0.848162390535770,0.849498542258470,
        0.850834693981171,0.852170845703871,0.853506997426572,0.854843149149272,
        0.856179300871973,0.857515452594673,0.858851604317373,0.860187756040074,
        0.861523907762774,0.862860059485475,0.864196211208175,0.865532362930875,
        0.866868514653576,0.868204666376276,0.869540818098977,0.870876969821677,
        0.872213121544378,0.873549273267078,0.874885424989778,0.876221576712479,
        0.877557728435179,0.878893880157880,0.880230031880580,0.881566183603280,
        0.882902335325981,0.884238487048681,0.885574638771382,0.886910790494082,
        0.888246942216783,0.889583093939483,0.890919245662183,0.892255397384884,
        0.893591549107584,0.894927700830285,0.896263852552985,0.897600004275685,
        0.898936155998386,0.900272307721086,0.901608459443787,0.902944611166487,
        0.904280762889188,0.905616914611888,0.906953066334588,0.908289218057289,
        0.909625369779989,0.910961521502690,0.912297673225390,0.913633824948090,
        0.914969976670791,0.916306128393491,0.917642280116192,0.919000395123209,
        0.920338788669353,0.921654913780206,0.922949140962045,0.924221834556595,
        0.925473352843603,0.926704048141686,0.927914266907520,0.929104349833374,
        0.930274631943016,0.931425442686031,0.932557106030558,0.933669940554492,
        0.934764259535182,0.935840371037602,0.936898578001085,0.937939178324610,
        0.938962464950653,0.939968725947663,0.940958244591156,0.941931299443453,
        0.942888164432106,0.943829108927011,0.944754397816244,0.945664291580614,
        0.946559046367014,0.947438914060509,0.948304142355261,0.949154974824251,
        0.949991650987844,0.950814406381226,0.951623472620704,0.952419077468909,
        0.953201444898923,0.953970795157311,0.954727344826145,0.955471306883966,
        0.956202890765733,0.956922302421791,0.957629744375846,0.958325415781975,
        0.959009512480699,0.959682227054106,0.960343748880064,0.960994264185543,
        0.961633956099033,0.962263004702097,0.962881587080076,0.963489877371918,
        0.964088046819229,0.964676263814465,0.965254693948328,0.965823500056402,
        0.966382842264975,0.966932878036132,0.967473762212069,0.968005647058694,
        0.968528682308485,0.969043015202643,0.969548790532545,0.970046150680502,
        0.970580611369582,0.971115072058662,0.971649532747743,0.972183993436823,
        0.972718454125903,0.973252914814983,0.973787375504063,0.974321836193144,
        0.974856296882223,0.975390757571304,0.975925218260384,0.976459678949464,
        0.976994139638544,0.977528600327624,0.978063061016705,0.978597521705785,
        0.979131982394865,0.979666443083945,0.980200903773025,0.980735364462105,
        0.981269825151186,0.981804285840266,0.982338746529346,0.982873207218426,
        0.983407667907506,0.983942128596586,0.984476589285667,0.985011049974747,
        0.985545510663827,0.986079971352907,0.986614432041987,0.987148892731067,
        0.987683353420148,0.988217814109228,0.988752274798308,0.989286735487388,
        0.989821196176468,0.990355656865548,0.990890117554629,0.991424578243709,
        0.991959038932789,0.992493499621869,0.993027960310949,0.993562421000029,
        0.994096881689110,0.994631342378190,0.995165803067270,0.995700263756350,
        0.996234724445430,0.996769185134510,0.997303645823591,0.997704491340401,
        0.998105336857211,0.998522611695603,0.998922580696883,0.999222557447843,
        0.999422541948483,0.999572530323963,0.999702520249380,0.999822510949763,
        0.999872507074923,0.999892505524987,0.999922503200083,0.999949226234537,
        0.999975949268991,0.999989310786218,0.999995991544832,1.0};
    constant Real[Ninterval, 4] Tcoef={{2.428119691060830e+012,-4.216479757645069e+008,
        9.287051822649143e+004,1.698508300000001e+002},{2.166914762300397e+012,
        -3.992111678478829e+008,9.062913441482277e+004,1.700999999999999e+002},
        {1.899159185577863e+012,-3.795555733430910e+008,8.878532320450363e+004,
        1.703092800000000e+002},{1.629916579808073e+012,-3.435128543022376e+008,
        8.477062663992558e+004,1.707856300000000e+002},{1.398839241865448e+012,
        -3.108983786183325e+008,8.093962908382615e+004,1.712651700000000e+002},
        {1.200574221723735e+012,-2.813879938533571e+008,7.728396604745965e+004,
        1.717479200000000e+002},{1.030417923000963e+012,-2.546836477814989e+008,
        7.379541586188905e+004,1.722339300000000e+002},{8.844001037952972e+011,
        -2.305189284572275e+008,7.046631066361128e+004,1.727232300000000e+002},
        {7.590860483164475e+011,-2.086514602087597e+008,6.728926490972207e+004,
        1.732158600000001e+002},{6.515463964671414e+011,-1.888629690497167e+008,
        6.425730760561715e+004,1.737118499999999e+002},{5.592552216502428e+011,
        -1.709551666980799e+008,6.136372775951276e+004,1.742112400000000e+002},
        {4.800416585372977e+011,-1.547489317359679e+008,5.860218639168952e+004,
        1.747140600000000e+002},{4.120619529393444e+011,-1.400824449235276e+008,
        5.596654048742052e+004,1.752203600000000e+002},{3.537140308461040e+011,
        -1.268087414876019e+008,5.345098341920615e+004,1.757301800000000e+002},
        {3.036357271971793e+011,-1.147956769847417e+008,5.105003430189027e+004,
        1.762435499999999e+002},{2.606525213033651e+011,-1.039230394931327e+008,
        4.875837260556154e+004,1.767605200000000e+002},{2.237609674834909e+011,
        -9.408262939444540e+007,4.657101751284228e+004,1.772811199999999e+002},
        {1.922419405902699e+011,-8.518143962347658e+007,4.448317923172022e+004,
        1.778053999999999e+002},{1.656321149901774e+011,-7.714416678199874e+007,
        4.249042535564808e+004,1.783334000000000e+002},{1.431407593855788e+011,
        -6.989094076846488e+007,4.058849075808411e+004,1.788651600000000e+002},
        {1.241037279204862e+011,-6.345000608556164e+007,3.880841089253586e+004,
        1.793900000000000e+002},{1.078897726938036e+011,-5.787323844457100e+007,
        3.719668427889198e+004,1.798900000000000e+002},{9.388245239329929e+010,
        -5.281986768088788e+007,3.566287663310264e+004,1.803899999999999e+002},
        {8.177026870962473e+010,-4.823785073207039e+007,3.420275088737812e+004,
        1.808900000000001e+002},{7.128653091837167e+010,-4.408054713844873e+007,
        3.281232303846304e+004,1.813900000000000e+002},{6.220419978100047e+010,
        -4.030623531248382e+007,3.148784749056206e+004,1.818900000000000e+002},
        {5.432814901566791e+010,-3.687745020027063e+007,3.022579953184881e+004,
        1.823900000000000e+002},{4.749233588110072e+010,-3.376066397124648e+007,
        2.902286362710196e+004,1.828899999999999e+002},{4.155352730607562e+010,
        -3.092570824858189e+007,2.787591713537610e+004,1.833900000000000e+002},
        {3.638967234175739e+010,-2.834555680690369e+007,2.678202091246125e+004,
        1.838900000000000e+002},{3.189545805614265e+010,-2.599587187121439e+007,
        2.573840508245055e+004,1.843899999999999e+002},{2.798050203785508e+010,
        -2.385478375872732e+007,2.474246009078133e+004,1.848900000000000e+002},
        {2.456737261968692e+010,-2.190263720157386e+007,2.379172636307514e+004,
        1.853900000000000e+002},{2.158887725624487e+010,-2.012168454337252e+007,
        2.288388355112532e+004,1.858900000000000e+002},{1.898760836682233e+010,
        -1.849598750549042e+007,2.201674428367421e+004,1.863900000000000e+002},
        {1.671373899396782e+010,-1.701114199658637e+007,2.118824358594005e+004,
        1.868900000000001e+002},{1.472442515376055e+010,-1.565417444528254e+007,
        2.039643299085866e+004,1.873900000000000e+002},{1.298254187769645e+010,
        -1.441336250162147e+007,1.963947244326254e+004,1.878900000000000e+002},
        {1.145612023308615e+010,-1.327813374098965e+007,1.891562443180674e+004,
        1.883899999999999e+002},{1.011726329520874e+010,-1.223890854106894e+007,
        1.822324676787706e+004,1.888899999999999e+002},{8.942115914174372e+009,
        -1.128706309621500e+007,1.756078856084207e+004,1.893899999999999e+002},
        {7.909709317744029e+009,-1.041475590863545e+007,1.692678236252691e+004,
        1.898900000000000e+002},{7.002011600872572e+009,-9.614913403719645e+006,
        1.631984148717728e+004,1.903899999999999e+002},{6.203335937528857e+009,
        -8.881122302459281e+006,1.573865385204634e+004,1.908899999999999e+002},
        {5.500000426851387e+009,-8.207563992121900e+006,1.518197779409089e+004,
        1.913900000000000e+002},{4.880147872846049e+009,-7.588969652936688e+006,
        1.464863839566741e+004,1.918900000000000e+002},{4.333458916781487e+009,
        -7.020558044503353e+006,1.413752314725710e+004,1.923900000000000e+002},
        {3.850903162697156e+009,-6.497982633829402e+006,1.364757825073601e+004,
        1.928900000000000e+002},{3.424640794532519e+009,-6.017301775739881e+006,
        1.317780570385806e+004,1.933900000000000e+002},{3.047820397687019e+009,
        -5.574930915074369e+006,1.272725963793938e+004,1.938900000000000e+002},
        {2.714455522862305e+009,-5.167610077477907e+006,1.229504347489282e+004,
        1.943900000000000e+002},{2.419310099883856e+009,-4.792372987537484e+006,
        1.188030713941842e+004,1.948900000000000e+002},{2.157814657986750e+009,
        -4.446521482506972e+006,1.148224448765968e+004,1.953900000000000e+002},
        {1.925958574178695e+009,-4.127595989843101e+006,1.110009063273798e+004,
        1.958900000000000e+002},{1.720235556842085e+009,-3.833356838509688e+006,
        1.073311982718851e+004,1.963900000000000e+002},{1.537568498602969e+009,
        -3.561761260770541e+006,1.038064313240985e+004,1.968900000000000e+002},
        {1.375254807055739e+009,-3.310945444478069e+006,1.004200642469327e+004,
        1.973900000000000e+002},{1.230926157318009e+009,-3.079209502474114e+006,
        9.716588529824085e+003,1.978900000000000e+002},{1.102501569080066e+009,
        -2.865000978909834e+006,9.403799307559229e+003,1.983899999999999e+002},
        {9.881431890151527e+008,-2.666899927117780e+006,9.103077924469371e+003,
        1.988900000000000e+002},{8.862460643504052e+008,-2.483611530634848e+006,
        8.813891493500507e+003,1.993900000000000e+002},{7.953869975993569e+008,
        -2.313948910499454e+006,8.535733187669037e+003,1.998900000000000e+002},
        {7.143138769691485e+008,-2.156827077065875e+006,8.268121128719055e+003,
        2.003900000000000e+002},{6.419280859884250e+008,-2.011254157318892e+006,
        8.010596993801432e+003,2.008900000000001e+002},{5.772519450401038e+008,
        -1.876319403262300e+006,7.762724544343183e+003,2.013900000000000e+002},
        {5.194272793309037e+008,-1.751190083800481e+006,7.524088760577367e+003,
        2.018899999999999e+002},{4.676942564542144e+008,-1.635102283023300e+006,
        7.294294502273217e+003,2.023900000000000e+002},{4.213813991521418e+008,
        -1.527355501832372e+006,7.072965529370125e+003,2.028900000000000e+002},
        {3.798929639616593e+008,-1.427306562607491e+006,6.859743479795654e+003,
        2.033900000000000e+002},{3.427034243188576e+008,-1.334365732814233e+006,
        6.654287012551113e+003,2.038900000000000e+002},{3.093461000479141e+008,
        -1.247990970222474e+006,6.456270819862391e+003,2.043900000000000e+002},
        {2.794066491203365e+008,-1.167684115936397e+006,6.265384847491296e+003,
        2.048900000000000e+002},{2.525185307660005e+008,-1.092987656856107e+006,
        6.081333540245373e+003,2.053899999999999e+002},{2.283558222313167e+008,
        -1.023480600819874e+006,5.903835032062275e+003,2.058900000000000e+002},
        {2.066285778103371e+008,-9.587754989355512e+005,5.732620476110842e+003,
        2.063899999999999e+002},{1.870796358504928e+008,-8.985159698708151e+005,
        5.567433409816551e+003,2.068900000000000e+002},{1.694800630152804e+008,
        -8.423737208584454e+005,5.408029086050894e+003,2.073900000000000e+002},
        {1.536254323472121e+008,-7.900460905552147e+005,5.254173889079566e+003,
        2.078900000000000e+002},{1.393350041292428e+008,-7.412546763455822e+005,
        5.105644838061499e+003,2.083900000000000e+002},{1.264461946876812e+008,
        -6.957420884142442e+005,4.962228931931791e+003,2.088900000000000e+002},
        {1.148149957717430e+008,-6.532714037371146e+005,4.823722794654673e+003,
        2.093900000000000e+002},{1.043126918759436e+008,-6.136238260582621e+005,
        4.689932103330038e+003,2.098900000000000e+002},{9.482399240733823e+007,
        -5.765972058455468e+005,4.560671161847407e+003,2.103900000000000e+002},
        {8.624641502669747e+007,-5.420050981894244e+005,4.435762520264600e+003,
        2.108900000000000e+002},{7.848790676326571e+007,-5.096749922949291e+005,
        4.315036509192491e+003,2.113899999999999e+002},{7.146637230514374e+007,
        -4.794475711409992e+005,4.198330916505517e+003,2.118899999999999e+002},
        {6.510826527489491e+007,-4.511754575867408e+005,4.085490594353537e+003,
        2.123900000000000e+002},{5.934772889807401e+007,-4.247223114761246e+005,
        3.976367129792119e+003,2.128900000000000e+002},{5.412562005348311e+007,
        -3.999618944172335e+005,3.870818517414752e+003,2.133899999999999e+002},
        {4.938925600232123e+007,-3.767775105272770e+005,3.768708878722507e+003,
        2.138899999999999e+002},{4.509087667312729e+007,-3.550607788424417e+005,
        3.669908110384081e+003,2.143900000000000e+002},{4.118807316164903e+007,
        -3.347115756562438e+005,3.574291699195102e+003,2.148900000000000e+002},
        {3.764247330924181e+007,-3.156368905942572e+005,3.481740374155148e+003,
        2.153899999999999e+002},{3.441971899342819e+007,-2.977505663723726e+005,
        3.392139916478927e+003,2.158900000000000e+002},{3.148883664649886e+007,
        -2.809726258964635e+005,3.305380896883451e+003,2.163899999999999e+002},
        {2.882206369704212e+007,-2.652289174340525e+005,3.221358471964407e+003,
        2.168900000000000e+002},{2.639430226411493e+007,-2.504505234176753e+005,
        3.139972148385238e+003,2.173900000000001e+002},{2.418303052952018e+007,
        -2.365735031462724e+005,3.061125608726445e+003,2.178900000000000e+002},
        {2.216790736643471e+007,-2.235384141346653e+005,2.984726499486276e+003,
        2.183900000000000e+002},{2.033061705830633e+007,-2.112900306234645e+005,
        2.910686262830227e+003,2.188900000000000e+002},{1.865461368328635e+007,
        -1.997769906568943e+005,2.838919956827780e+003,2.193900000000000e+002},
        {1.712501178845796e+007,-1.889515587375750e+005,2.769346100218770e+003,
        2.198900000000000e+002},{1.572830246673164e+007,-1.787692672877184e+005,
        2.701886501082210e+003,2.203900000000002e+002},{1.445234208083232e+007,
        -1.691887831467449e+005,2.636466131342296e+003,2.208899999999999e+002},
        {1.328611259790656e+007,-1.601715845366386e+005,2.573012964462273e+003,
        2.213899999999999e+002},{1.221967792218837e+007,-1.516818185846242e+005,
        2.511457857150583e+003,2.218899999999999e+002},{1.124402410901016e+007,
        -1.436860587692310e+005,2.451734410827016e+003,2.223900000000001e+002},
        {1.035100231090916e+007,-1.361531635944861e+005,2.393778859436568e+003,
        2.228900000000000e+002},{9.533236131047620e+006,-1.290541003018532e+005,
        2.337529949475997e+003,2.233899999999999e+002},{8.784032342642559e+006,
        -1.223617814028497e+005,2.282928828509020e+003,2.238899999999999e+002},
        {8.097324140450608e+006,-1.160509373912711e+005,2.229918944431192e+003,
        2.243900000000000e+002},{7.467609003399250e+006,-1.100979854201498e+005,
        2.178445944730142e+003,2.248900000000000e+002},{6.889898183747469e+006,
        -1.044809122220948e+005,2.128457581571682e+003,2.253900000000001e+002},
        {6.359654158917572e+006,-9.917915038790123e+004,2.079903618776534e+003,
        2.258900000000000e+002},{5.872759686767209e+006,-9.417349114733808e+004,
        2.032735749928480e+003,2.263900000000000e+002},{5.425475631504861e+006,
        -8.944598462814202e+004,1.986907513929262e+003,2.268900000000000e+002},
        {5.014390733055720e+006,-8.497983886637562e+004,1.942374214543448e+003,
        2.273900000000000e+002},{4.636415792979381e+006,-8.075936791787535e+004,
        1.899092852995913e+003,2.278900000000000e+002},{4.288733044060946e+006,
        -7.676988872480289e+004,1.857022047834165e+003,2.283900000000000e+002},
        {3.968773876673203e+006,-7.299765929671984e+004,1.816121971306828e+003,
        2.288899999999999e+002},{3.674202520100520e+006,-6.942982257803570e+004,
        1.776354286367471e+003,2.293900000000000e+002},{3.402892107203013e+006,
        -6.605434102471954e+004,1.737682082113611e+003,2.298900000000000e+002},
        {3.152896273279971e+006,-6.285993128052545e+004,1.700069813095759e+003,
        2.303899999999999e+002},{2.922447601033651e+006,-5.983603289980221e+004,
        1.663483248995434e+003,2.308899999999999e+002},{2.709926760057117e+006,
        -5.697273957445595e+004,1.627889413642931e+003,2.313900000000000e+002},
        {2.513861217833642e+006,-5.426077246627386e+004,1.593256539802403e+003,
        2.318900000000001e+002},{2.332900319601032e+006,-5.169142195505573e+004,
        1.559554014347537e+003,2.323900000000000e+002},{2.165813772476697e+006,
        -4.925652436360114e+004,1.526752336938422e+003,2.328900000000000e+002},
        {2.011475838578284e+006,-4.694841733751677e+004,1.494823071235126e+003,
        2.333899999999999e+002},{1.868856269356124e+006,-4.475990809519066e+004,
        1.463738803224226e+003,2.338900000000000e+002},{1.737013293432888e+006,
        -4.268424495431413e+004,1.433473101024697e+003,2.343900000000000e+002},
        {1.615084644443825e+006,-4.071508653570022e+004,1.404000474764923e+003,
        2.348899999999998e+002},{1.502280625890901e+006,-3.884647544872509e+004,
        1.375296339470493e+003,2.353900000000001e+002},{1.397877494187559e+006,
        -3.707281331859772e+004,1.347336979285312e+003,2.358900000000000e+002},
        {1.301213605644812e+006,-3.538884022447428e+004,1.320099513857462e+003,
        2.363899999999998e+002},{1.211679248380561e+006,-3.378960565339209e+004,
        1.293561863094709e+003,2.368900000000000e+002},{1.128718624184195e+006,
        -3.227045988925767e+004,1.267702720329528e+003,2.373900000000000e+002},
        {1.051819631323617e+006,-3.082702432545408e+004,1.242501517244634e+003,
        2.378900000000000e+002},{9.805119943329289e+005,-2.945517899158243e+004,
        1.217938398261965e+003,2.383900000000000e+002},{9.143661234246076e+005,
        -2.815104963832588e+004,1.193994193542140e+003,2.388899999999999e+002},
        {8.529843036096668e+005,-2.691098269234095e+004,1.170650388729732e+003,
        2.393900000000000e+002},{7.960030849987015e+005,-2.573154186886301e+004,
        1.147889104993057e+003,2.398900000000000e+002},{7.430884210129550e+005,
        -2.460948952764748e+004,1.125693071288439e+003,2.403900000000000e+002},
        {6.939312882245765e+005,-2.354177155605786e+004,1.104045600935325e+003,
        2.408900000000000e+002},{6.482492262091814e+005,-2.252551343062689e+004,
        1.082930572906883e+003,2.413899999999999e+002},{6.057812463458836e+005,
        -2.155800267024627e+004,1.062332406718743e+003,2.418899999999999e+002},
        {5.662875366021142e+005,-2.063668238211267e+004,1.042236044331130e+003,
        2.423899999999999e+002},{5.295464858440637e+005,-1.975913928732001e+004,
        1.022626929351548e+003,2.428900000000000e+002},{4.953547285884677e+005,
        -1.892309832108412e+004,1.003490989941396e+003,2.433899999999999e+002},
        {4.635243665572284e+005,-1.812641112749775e+004,9.848146189060615e+002,
        2.438900000000000e+002},{4.338818671474538e+005,-1.736704928321503e+004,
        9.665846574512200e+002,2.443900000000000e+002},{4.062679337763968e+005,
        -1.664309916254490e+004,9.487883794001973e+002,2.448899999999999e+002},
        {3.805346095862030e+005,-1.595275107074704e+004,9.314134731830150e+002,
        2.453899999999999e+002},{3.565460578222151e+005,-1.529429731212101e+004,
        9.144480292797495e+002,2.458899999999999e+002},{3.341763897850724e+005,
        -1.466612297632049e+004,8.978805234049410e+002,2.463900000000000e+002},
        {3.133095571597457e+005,-1.406670233964544e+004,8.816998038639424e+002,
        2.468900000000000e+002},{2.938381657336060e+005,-1.349459252458615e+004,
        8.658950773076953e+002,2.473899999999999e+002},{2.756629705093029e+005,
        -1.294842921334388e+004,8.504558962743154e+002,2.478900000000001e+002},
        {2.586922013389850e+005,-1.242692195684236e+004,8.353721466343773e+002,
        2.483899999999999e+002},{2.428410028923686e+005,-1.192884991972681e+004,
        8.206340356628965e+002,2.488900000000001e+002},{2.280307218527483e+005,
        -1.145305746217065e+004,8.062320804248278e+002,2.493899999999998e+002},
        {2.141886791630994e+005,-1.099845109336764e+004,7.921570972279910e+002,
        2.498900000000000e+002},{2.012474588055167e+005,-1.056399519338368e+004,
        7.784001905236512e+002,2.503900000000000e+002},{1.891447383294132e+005,
        -1.014870937969869e+004,7.649527432295186e+002,2.508900000000000e+002},
        {1.778225648933724e+005,-9.751664453811391e+003,7.518064063753014e+002,
        2.513900000000000e+002},{1.672274901217288e+005,-9.371980845757489e+003,
        7.389530906287266e+002,2.518900000000000e+002},{1.573096370463601e+005,
        -9.008824060035608e+003,7.263849560163876e+002,2.523900000000000e+002},
        {1.480229998054410e+005,-8.661403967241104e+003,7.140944046859372e+002,
        2.528899999999999e+002},{1.393247573204245e+005,-8.328970961973500e+003,
        7.020740713322290e+002,2.533900000000000e+002},{1.311751868668219e+005,
        -8.010814302914930e+003,6.903168158285998e+002,2.538900000000000e+002},
        {1.235374217684196e+005,-7.706259887656581e+003,6.788157153740614e+002,
        2.543900000000000e+002},{1.163771876379430e+005,-7.414668078450832e+003,
        6.675640569646922e+002,2.548900000000000e+002},{1.096627095692096e+005,
        -7.135432106638779e+003,6.565553304580889e+002,2.553900000000000e+002},
        {1.033643398452726e+005,-6.867975679189847e+003,6.457832212746632e+002,
        2.558899999999999e+002},{9.745461870325112e+004,-6.611752090606020e+003,
        6.352416044310508e+002,2.563899999999998e+002},{9.190798963753549e+004,
        -6.366242084979492e+003,6.249245375741506e+002,2.568900000000000e+002},
        {8.670064055849906e+004,-6.130952362236059e+003,6.148262549854942e+002,
        2.573900000000000e+002},{8.181042020600053e+004,-5.905414374178652e+003,
        6.049411618718673e+002,2.578900000000000e+002},{7.721677640854748e+004,
        -5.689183128996180e+003,5.952638286607794e+002,2.583899999999999e+002},
        {7.290044135202718e+004,-5.481835253654937e+003,5.857889850231684e+002,
        2.588900000000000e+002},{6.884362660689066e+004,-5.282968916694660e+003,
        5.765115155427385e+002,2.593900000000000e+002},{6.502964570767200e+004,
        -5.092201572104827e+003,5.674264535024774e+002,2.598899999999999e+002},
        {6.144296599615412e+004,-4.909169573093382e+003,5.585289768075917e+002,
        2.603900000000000e+002},{5.806916350594535e+004,-4.733527235738733e+003,
        5.498144031252836e+002,2.608900000000001e+002},{5.489471665728002e+004,
        -4.564945391819472e+003,5.412781848879703e+002,2.613899999999999e+002},
        {5.190705215061930e+004,-4.403111022700504e+003,5.329159054741148e+002,
        2.618899999999999e+002},{4.909445721484846e+004,-4.247726255069810e+003,
        5.247232746761317e+002,2.623900000000000e+002},{4.644593911428791e+004,
        -4.098507286040056e+003,5.166961244486026e+002,2.628900000000000e+002},
        {4.395128803961570e+004,-3.955184162531220e+003,5.088304055117806e+002,
        2.633899999999999e+002},{4.160096100295921e+004,-3.817499734155457e+003,
        5.011221830784011e+002,2.638900000000001e+002},{3.938601346943615e+004,
        -3.685208951092035e+003,4.935676332701902e+002,2.643900000000000e+002},
        {3.729813534244107e+004,-3.558078575814604e+003,4.861630399003062e+002,
        2.648900000000000e+002},{3.532951540796938e+004,-3.435886151050459e+003,
        4.789047905747109e+002,2.653900000000000e+002},{3.347288342828854e+004,
        -3.318419829035272e+003,4.717893738824646e+002,2.658900000000001e+002},
        {3.172142027917930e+004,-3.205477566352382e+003,4.648133758676585e+002,
        2.663899999999999e+002},{3.006875992796082e+004,-3.096866799830403e+003,
        4.579734772020614e+002,2.668899999999999e+002},{2.850893674371467e+004,
        -2.992403858160356e+003,4.512664500780765e+002,2.673900000000000e+002},
        {2.703637806135581e+004,-2.891913613497721e+003,4.446891554758121e+002,
        2.678900000000000e+002},{2.564585331227819e+004,-2.795228937660512e+003,
        4.382385402712435e+002,2.683899999999999e+002},{2.433248558704846e+004,
        -2.702190470535179e+003,4.319116347685376e+002,2.688900000000000e+002},
        {2.309167689222681e+004,-2.612645984757337e+003,4.257055498446611e+002,
        2.693900000000000e+002},{2.191914997435190e+004,-2.526450353074852e+003,
        4.196174748723824e+002,2.698899999999999e+002},{2.081087709618847e+004,
        -2.443464913240735e+003,4.136446749057724e+002,2.703900000000000e+002},
        {1.976308961002175e+004,-2.363557314740986e+003,4.077844886436558e+002,
        2.708900000000000e+002},{1.877225549790460e+004,-2.286601167769257e+003,
        4.020343260965227e+002,2.713900000000000e+002},{1.783505491279766e+004,
        -2.212475713419265e+003,3.963916663955540e+002,2.718900000000000e+002},
        {1.694838403963000e+004,-2.141065646731519e+003,3.908540558216300e+002,
        2.723900000000000e+002},{1.610932000557480e+004,-2.072260732910480e+003,
        3.854191056171448e+002,2.728899999999999e+002},{1.531512874676714e+004,
        -2.005955680031755e+003,3.800844902084921e+002,2.733900000000001e+002},
        {1.456323697582539e+004,-1.942049804693102e+003,3.748479451687998e+002,
        2.738900000000000e+002},{1.385123026469367e+004,-1.880446871012044e+003,
        3.697072655023023e+002,2.743899999999999e+002},{1.317684399562190e+004,
        -1.821054876924206e+003,3.646603038516667e+002,2.748899999999999e+002},
        {1.253794303834637e+004,-1.763785795953628e+003,3.597049687290192e+002,
        2.753899999999999e+002},{1.193253057409521e+004,-1.708555492422938e+003,
        3.548392230103814e+002,2.758900000000000e+002},{1.135872219923051e+004,
        -1.655283426022064e+003,3.500610821583481e+002,2.763900000000000e+002},
        {1.081475019376878e+004,-1.603892563634609e+003,3.453686128301867e+002,
        2.768900000000001e+002},{1.029894855746364e+004,-1.554309165597434e+003,
        3.407599312946576e+002,2.773900000000000e+002},{9.809756431292144e+003,
        -1.506462692323420e+003,3.362332020717720e+002,2.778900000000001e+002},
        {9.345698521645902e+003,-1.460285569720035e+003,3.317866364015975e+002,
        2.783899999999999e+002},{8.905390176188423e+003,-1.415713129876954e+003,
        3.274184910384032e+002,2.788900000000000e+002},{8.487528222283663e+003,
        -1.372683444667674e+003,3.231270668582708e+002,2.793900000000001e+002},
        {8.090883603193332e+003,-1.331137188443026e+003,3.189107075891501e+002,
        2.798899999999998e+002},{7.714300903571747e+003,-1.291017548047196e+003,
        3.147677986317169e+002,2.803899999999999e+002},{7.356691193390297e+003,
        -1.252270086933305e+003,3.106967658260311e+002,2.808900000000000e+002},
        {7.017027940720315e+003,-1.214842639685586e+003,3.066960743158503e+002,
        2.813900000000000e+002},{6.694344504639365e+003,-1.178685218691503e+003,
        3.027642274486991e+002,2.818900000000000e+002},{6.387729498401815e+003,
        -1.143749907833270e+003,2.988997656793167e+002,2.823900000000000e+002},
        {6.096323639887130e+003,-1.109990771522367e+003,2.951012655307434e+002,
        2.828900000000000e+002},{5.819316375605656e+003,-1.077363765273413e+003,
        2.913673385813619e+002,2.833899999999999e+002},{5.555945230723103e+003,
        -1.045826664792471e+003,2.876966304991468e+002,2.838900000000000e+002},
        {5.305486577084192e+003,-1.015338940849282e+003,2.840878200262260e+002,
        2.843899999999999e+002},{5.067262644382695e+003,-9.858617563664993e+002,
        2.805396181886476e+002,2.848899999999999e+002},{4.840629717527347e+003,
        -9.573578165466240e+002,2.770507672483719e+002,2.853900000000001e+002},
        {4.624982316899136e+003,-9.297913562094941e+002,2.736200399658823e+002,
        2.858899999999998e+002},{4.419748465054315e+003,-9.031280472312861e+002,
        2.702462386898002e+002,2.863899999999999e+002},{4.224387583152579e+003,
        -8.773349366812882e+002,2.669281945592340e+002,2.868900000000001e+002},
        {4.038388297731713e+003,-8.523803870286566e+002,2.636647667234346e+002,
        2.873900000000000e+002},{3.861269499591353e+003,-8.282340390911418e+002,
        2.604548416035581e+002,2.878899999999999e+002},{3.692574672364702e+003,
        -8.048667226026902e+002,2.572973320823326e+002,2.883900000000000e+002},
        {3.531873216036285e+003,-7.822504319031273e+002,2.541911768555779e+002,
        2.888899999999999e+002},{3.378757294095987e+003,-7.603582607212622e+002,
        2.511353396959848e+002,2.893899999999999e+002},{3.232842821404854e+003,
        -7.391643734589071e+002,2.481288088106870e+002,2.898899999999998e+002},
        {3.093764229251524e+003,-7.186439267744648e+002,2.451705961230077e+002,
        2.903899999999998e+002},{2.961178144974160e+003,-6.987730702280496e+002,
        2.422597367302420e+002,2.908899999999999e+002},{2.834757569070961e+003,
        -6.795288612382922e+002,2.393952881854896e+002,2.913899999999999e+002},
        {2.714194398673150e+003,-6.608892613772416e+002,2.365763299875632e+002,
        2.918900000000000e+002},{2.599196768073861e+003,-6.428330798822078e+002,
        2.338019629427569e+002,2.923899999999999e+002},{2.489487678826580e+003,
        -6.253399364968090e+002,2.310713086112715e+002,2.928900000000000e+002},
        {2.384805817113105e+003,-6.083902428896103e+002,2.283835087915235e+002,
        2.933899999999999e+002},{2.284902791850232e+003,-5.919651508239373e+002,
        2.257377249419197e+002,2.938899999999999e+002},{2.189543827088161e+003,
        -5.760465367399366e+002,2.231331377069458e+002,2.943900000000001e+002},
        {2.098506646267296e+003,-5.606169661265348e+002,2.205689463939640e+002,
        2.948899999999999e+002},{2.011580322023283e+003,-5.456596605580177e+002,
        2.180443684809316e+002,2.953900000000000e+002},{1.928564097136700e+003,
        -5.311584690552852e+002,2.155586391540247e+002,2.958899999999999e+002},
        {1.849269849310739e+003,-5.170978692137003e+002,2.131110108940667e+002,
        2.963899999999999e+002},{1.773516707295410e+003,-5.034628931867380e+002,
        2.107007529155836e+002,2.968900000000000e+002},{1.701135034894489e+003,
        -4.902391539141415e+002,2.083271508720442e+002,2.973899999999999e+002},
        {1.631962729032615e+003,-4.774127857226459e+002,2.059895063267681e+002,
        2.978900000000001e+002},{1.565846506555941e+003,-4.649704442461410e+002,
        2.036871364135052e+002,2.983900000000002e+002},{1.502641202683996e+003,
        -4.528992802485624e+002,2.014193734124408e+002,2.988900000000002e+002},
        {1.442208277348613e+003,-4.411869095737466e+002,1.991855643479903e+002,
        2.993899999999999e+002},{1.384416824560510e+003,-4.298214105524195e+002,
        1.969850706592951e+002,2.998899999999999e+002},{1.329142377546727e+003,
        -4.187912951655748e+002,1.948172677994267e+002,3.003899999999999e+002},
        {1.276266832977576e+003,-4.080854951975836e+002,1.926815448953401e+002,
        3.008900000000000e+002},{1.225677744534944e+003,-3.976933420081253e+002,
        1.905773043972621e+002,3.013899999999999e+002},{1.177268608034691e+003,
        -3.876045575132537e+002,1.885039617618329e+002,3.018900000000000e+002},
        {1.130938214911173e+003,-3.778092338214274e+002,1.864609451086512e+002,
        3.023900000000000e+002},{1.086590010013511e+003,-3.682978157856858e+002,
        1.844476949037983e+002,3.028899999999999e+002},{1.044132879850411e+003,
        -3.590610987951029e+002,1.824636636814579e+002,3.033900000000000e+002},
        {1.003479421950269e+003,-3.500901978022080e+002,1.805083156956392e+002,
        3.038900000000000e+002},{9.645474592133718e+002,-3.413765556572088e+002,
        1.785811266916289e+002,3.043899999999999e+002},{9.272577564186632e+002,
        -3.329119057516371e+002,1.766815835499424e+002,3.048899999999999e+002},
        {8.915361551869480e+002,-3.246882895151356e+002,1.748091840997496e+002,
        3.053899999999999e+002},{8.573109718488198e+002,-3.166980141610849e+002,
        1.729634367537797e+002,3.058900000000000e+002},{8.245149278413157e+002,
        -3.089336702127797e+002,1.711438603429205e+002,3.063900000000000e+002},
        {7.930833414616905e+002,-3.013880987490236e+002,1.693499837846950e+002,
        3.068899999999999e+002},{7.629551004957449e+002,-2.940543974650270e+002,
        1.675813458946156e+002,3.073899999999999e+002},{7.340718127746320e+002,
        -2.869259009969820e+002,1.658374951082294e+002,3.078900000000000e+002},
        {7.063778149375254e+002,-2.799961751758680e+002,1.641179892660677e+002,
        3.083899999999998e+002},{6.798204571715311e+002,-2.732590129072642e+002,
        1.624223953944419e+002,3.088899999999998e+002},{6.543490746840538e+002,
        -2.667084141948034e+002,1.607502894508461e+002,3.093900000000000e+002},
        {6.299159798870081e+002,-2.603385935161680e+002,1.591012561598878e+002,
        3.098899999999998e+002},{6.064752538059523e+002,-2.541439563436756e+002,
        1.574748887477705e+002,3.103899999999999e+002},{5.839833827181259e+002,
        -2.481191036566246e+002,1.558707887864211e+002,3.108899999999999e+002},
        {5.623990077331871e+002,-2.422588210581205e+002,1.542885659710487e+002,
        3.113900000000002e+002},{5.416823557921136e+002,-2.365580664806819e+002,
        1.527278379169916e+002,3.118899999999998e+002},{5.217959156466890e+002,
        -2.310119745447131e+002,1.511882300065326e+002,3.123900000000000e+002},
        {5.027036118421444e+002,-2.256158391224129e+002,1.496693751642845e+002,
        3.128900000000001e+002},{4.843711839704919e+002,-2.203651149878204e+002,
        1.481709137107541e+002,3.133899999999999e+002},{4.667659843054528e+002,
        -2.152554094514039e+002,1.466924931733644e+002,3.138900000000000e+002},
        {4.498567607109622e+002,-2.102824750478224e+002,1.452337681136751e+002,
        3.143899999999999e+002},{4.336138489909362e+002,-2.054422081085836e+002,
        1.437943999757566e+002,3.148900000000000e+002},{4.180087357727423e+002,
        -2.007306382064600e+002,1.423740569063953e+002,3.153900000000000e+002},
        {4.030144488980337e+002,-1.961439302658990e+002,1.409724136234017e+002,
        3.158899999999998e+002},{3.886050416261347e+002,-1.916783723946983e+002,
        1.395891512326833e+002,3.163899999999999e+002},{3.747559197643732e+002,
        -1.873303777536728e+002,1.382239571063902e+002,3.168899999999999e+002},
        {3.614434175252985e+002,-1.830964742279822e+002,1.368765247137150e+002,
        3.173900000000002e+002},{3.486450944768750e+002,-1.789733061102790e+002,
        1.355465535030190e+002,3.178900000000001e+002},{3.363394583248588e+002,
        -1.749576258474919e+002,1.342337487433366e+002,3.183899999999999e+002},
        {3.245059552231471e+002,-1.710462911782989e+002,1.329378213973440e+002,
        3.188900000000000e+002},{3.131249934400873e+002,-1.672362625597232e+002,
        1.316584879935901e+002,3.193900000000001e+002},{3.021778376318846e+002,
        -1.635245982990388e+002,1.303954704917012e+002,3.198900000000000e+002},
        {2.916465737356219e+002,-1.599084513847945e+002,1.291484961596401e+002,
        3.203900000000000e+002},{2.815140960863762e+002,-1.563850665721780e+002,
        1.279172974528968e+002,3.208899999999999e+002},{2.717640535010451e+002,
        -1.529517768326230e+002,1.267016118931412e+002,3.213899999999999e+002},
        {2.623807958853618e+002,-1.496060000695831e+002,1.255011819518896e+002,
        3.218899999999999e+002},{2.533493995716780e+002,-1.463452370568750e+002,
        1.243157549397372e+002,3.223900000000000e+002},{2.446555324337382e+002,
        -1.431670669227680e+002,1.231450828893681e+002,3.228899999999998e+002},
        {2.362855481501693e+002,-1.400691465868011e+002,1.219889224559401e+002,
        3.233900000000001e+002},{2.282263709932994e+002,-1.370492063764239e+002,
        1.208470348027104e+002,3.238900000000001e+002},{2.204654530507506e+002,
        -1.341050475503324e+002,1.197191855005348e+002,3.243900000000000e+002},
        {2.129908699326103e+002,-1.312345418623600e+002,1.186051444334383e+002,
        3.248899999999999e+002},{2.057911337612362e+002,-1.284356261218127e+002,
        1.175046856861692e+002,3.253900000000000e+002},{1.988552794177001e+002,
        -1.257063023229668e+002,1.164175874610275e+002,3.258900000000000e+002},
        {1.921728401770502e+002,-1.230446350569414e+002,1.153436319785049e+002,
        3.263899999999999e+002},{1.857337349822465e+002,-1.204487478255335e+002,
        1.142826053796536e+002,3.268899999999998e+002},{1.795283572515752e+002,
        -1.179168232471038e+002,1.132342976468749e+002,3.273899999999998e+002},
        {1.735474970466655e+002,-1.154470997486489e+002,1.121985025073361e+002,
        3.278900000000000e+002},{1.677823331351591e+002,-1.130378699689073e+002,
        1.111750173492029e+002,3.283900000000000e+002},{1.622244016835726e+002,
        -1.106874787369236e+002,1.101636431365233e+002,3.288900000000000e+002},
        {1.568656145421817e+002,-1.083943220437680e+002,1.091641843297179e+002,
        3.293899999999999e+002},{1.516982207140161e+002,-1.061568447400119e+002,
        1.081764488004225e+002,3.298899999999999e+002},{1.467147735728482e+002,
        -1.039735387115258e+002,1.072002477527532e+002,3.303900000000000e+002},
        {1.419081528245269e+002,-1.018429421114725e+002,1.062353956494466e+002,
        3.308900000000001e+002},{1.372715346463949e+002,-9.976363736558096e+001,
        1.052817101318265e+002,3.313899999999999e+002},{1.327983662960232e+002,
        -9.773424955603815e+001,1.043390119451407e+002,3.318900000000000e+002},
        {1.284823811146052e+002,-9.575344556746910e+001,1.034071248680371e+002,
        3.323899999999998e+002},{1.243175382743625e+002,-9.381993180831613e+001,
        1.024858756363024e+002,3.328900000000000e+002},{1.202980857716605e+002,
        -9.193245448523439e+001,1.015750938798825e+002,3.333900000000000e+002},
        {1.164184832888737e+002,-9.008979675148045e+001,1.006746120438895e+002,
        3.338900000000000e+002},{1.126734095942744e+002,-8.829077808760059e+001,
        9.978426532565882e+001,3.343900000000001e+002},{1.090577734365635e+002,
        -8.653425359100095e+001,9.890389160942104e+001,3.348899999999999e+002},
        {1.055666864095504e+002,-8.481911235197464e+001,9.803333139647950e+001,
        3.353900000000000e+002},{1.021954515577647e+002,-8.314427636901104e+001,
        9.717242774102454e+001,3.358900000000000e+002},{9.893956151385201e+001,
        -8.150869971730866e+001,9.632102618748574e+001,3.363900000000000e+002},
        {9.579468908688170e+001,-7.991136750831623e+001,9.547897470672068e+001,
        3.368899999999999e+002},{9.275669381231643e+001,-7.835129514294606e+001,
        9.464612363393020e+001,3.373900000000000e+002},{8.982156217702787e+001,
        -7.682752633542408e+001,9.382232560288357e+001,3.378899999999999e+002},
        {8.698548803471240e+001,-7.533913420559925e+001,9.300743549507918e+001,
        3.383900000000002e+002},{8.424476965419449e+001,-7.388521810035263e+001,
        9.220131036581432e+001,3.388900000000000e+002},{8.159588334052123e+001,
        -7.246490478296335e+001,9.140380939689695e+001,3.393900000000000e+002},
        {7.903542293508620e+001,-7.107734622418560e+001,9.061479382770111e+001,
        3.398900000000000e+002},{7.656012346841582e+001,-6.972171965580679e+001,
        8.983412690204482e+001,3.403900000000001e+002},{7.416684232872031e+001,
        -6.839722645285069e+001,8.906167380618470e+001,3.408900000000000e+002},
        {7.185255755015002e+001,-6.710309157552798e+001,8.829730161148777e+001,
        3.413899999999999e+002},{6.961436087200231e+001,-6.583856282410744e+001,
        8.754087921483382e+001,3.418899999999998e+002},{6.744071144058677e+001,
        -6.460275810641772e+001,8.679227669290511e+001,3.423900000000000e+002},
        {6.533736714406254e+001,-6.339506228364169e+001,8.605136666621638e+001,
        3.428900000000000e+002},{6.331010443040145e+001,-6.221493679466649e+001,
        8.531802314304329e+001,3.433900000000000e+002},{6.136356979419681e+001,
        -6.104400934164141e+001,8.458025754148792e+001,3.438982188586610e+002},
        {5.950910769914493e+001,-5.991653377419485e+001,8.386060214553304e+001,
        3.443990577691702e+002},{5.774213795912628e+001,-5.883273750086214e+001,
        8.315996185918330e+001,3.448915636307768e+002},{5.605740872805171e+001,
        -5.779050749965268e+001,8.247767612460307e+001,3.453758750902661e+002},
        {5.445002414326789e+001,-5.678785488691579e+001,8.181311338100387e+001,
        3.458521284875891e+002},{5.291543947575813e+001,-5.582290706691298e+001,
        8.116566953938508e+001,3.463204578942522e+002},{5.144941514216728e+001,
        -5.489389939019187e+001,8.053476654316889e+001,3.467809951510519e+002},
        {5.004800476275456e+001,-5.399916819680369e+001,7.991985102044619e+001,
        3.472338699051960e+002},{4.870752053753856e+001,-5.313714386862832e+001,
        7.932039301451977e+001,3.476792096467971e+002},{4.742453515559163e+001,
        -5.230634512701585e+001,7.873588479339902e+001,3.481171397447639e+002},
        {4.619582778847320e+001,-5.150537243699205e+001,7.816583972221676e+001,
        3.485477834820968e+002},{4.501839582534991e+001,-5.073290350231906e+001,
        7.760979121186911e+001,3.489712620905890e+002},{4.388943451850130e+001,
        -4.998768810694993e+001,7.706729172077169e+001,3.493876947849560e+002},
        {4.280631164785162e+001,-4.926854332619763e+001,7.653791181582945e+001,
        3.497971987964010e+002},{4.176655526408100e+001,-4.857434938684333e+001,
        7.602123928892645e+001,3.501998894056100e+002},{4.076786327604572e+001,
        -4.790404616352511e+001,7.551687832371779e+001,3.505958799752079e+002},
        {3.980805733673829e+001,-4.725662870019470e+001,7.502444870357830e+001,
        3.509852819816741e+002},{3.888510061148567e+001,-4.663114456970701e+001,
        7.454358507290264e+001,3.513682050467190e+002},{3.799708329453679e+001,
        -4.602669045951641e+001,7.407393623185125e+001,3.517447569681489e+002},
        {3.714219720456370e+001,-4.544240891400779e+001,7.361516447128999e+001,
        3.521150437502121e+002},{3.631874498673679e+001,-4.487748602903891e+001,
        7.316694494766297e+001,3.524791696334351e+002},{3.552513982192850e+001,
        -4.433114893405369e+001,7.272896508813832e+001,3.528372371239739e+002},
        {3.475986373173623e+001,-4.380266269275900e+001,7.230092402560834e+001,
        3.531893470224679e+002},{3.402150381919826e+001,-4.329132906864620e+001,
        7.188253207215109e+001,3.535355984524188e+002},{3.330871802177212e+001,
        -4.279648372667590e+001,7.147351021030326e+001,3.538760888880901e+002},
        {3.262024083566979e+001,-4.231749458406720e+001,7.107358961785731e+001,
        3.542109141819540e+002},{3.195487579527898e+001,-4.185375988374079e+001,
        7.068251121409816e+001,3.545401685916690e+002},{3.131148674881513e+001,
        -4.140470653297403e+001,7.030002523183052e+001,3.548639448066199e+002},
        {3.068901235671067e+001,-4.096978874137064e+001,6.992589080997549e+001,
        3.551823339740079e+002},{3.008642901657157e+001,-4.054848592928184e+001,
        6.955987560500161e+001,3.554954257245101e+002},{2.950278142274513e+001,
        -4.014030203900851e+001,6.920175542777736e+001,3.558033081975119e+002},
        {2.893714926772632e+001,-3.974476359913557e+001,6.885131389159386e+001,
        3.561060680659211e+002},{2.838867997995928e+001,-3.936141920744957e+001,
        6.850834208489954e+001,3.564037905605628e+002},{2.785653948598558e+001,
        -3.898983744199484e+001,6.817263825199957e+001,3.566965594941810e+002},
        {2.733994891367559e+001,-3.862960663002127e+001,6.784400749871969e+001,
        3.569844572850220e+002},{2.683817826345350e+001,-3.828033360882353e+001,
        6.752226150569864e+001,3.572675649800471e+002},{2.635049716009461e+001,
        -3.794164206628756e+001,6.720721825603974e+001,3.575459622777420e+002},
        {2.587625347730658e+001,-3.761317301384136e+001,6.689870178268673e+001,
        3.578197275505541e+002},{2.541479976649183e+001,-3.729458259106318e+001,
        6.659654191726963e+001,3.580889378669559e+002},{2.496551525675362e+001,
        -3.698554184967730e+001,6.630057406013974e+001,3.583536690131409e+002},
        {2.452710525070210e+001,-3.668572794713256e+001,6.601063893678912e+001,
        3.586139955143569e+002},{2.410360417001564e+001,-3.639490086428960e+001,
        6.572658259420633e+001,3.588699906558899e+002},{2.368210844621412e+001,
        -3.611258607414033e+001,6.544825524888769e+001,3.591217265036901e+002},
        {2.327622138968802e+001,-3.583876497287966e+001,6.517551349931662e+001,
        3.593692739246600e+002},{2.285763234098723e+001,-3.557279939313234e+001,
        6.490821598447343e+001,3.596127026066080e+002},{2.239716065038261e+001,
        -3.531437500835054e+001,6.464622739113473e+001,3.598520810778630e+002},
        {2.261286818614434e+001,-3.507154486626255e+001,6.438943523372159e+001,
        3.600874767265670e+002},{2.115907150454445e+001,-3.481174562600655e+001,
        6.413762093896931e+001,3.603189558196478e+002},{2.159545498645849e+001,
        -3.459060253341110e+001,6.389086012794930e+001,3.605465835214680e+002},
        {2.102568471888965e+001,-3.435729682605923e+001,6.364880929050617e+001,
        3.607704239121769e+002},{2.067684918221991e+001,-3.413518689782911e+001,
        6.341147902075354e+001,3.609905400057469e+002},{2.033460501975768e+001,
        -3.391960694365179e+001,6.317872830742419e+001,3.612069937677100e+002},
        {1.999858565664685e+001,-3.371036657708588e+001,6.295044799142224e+001,
        3.614198461326062e+002},{1.966841892720444e+001,-3.350728276179628e+001,
        6.272653214279693e+001,3.616291570211340e+002},{1.934374242040421e+001,
        -3.331017987964569e+001,6.250687794476657e+001,3.618349853570229e+002},
        {1.902410836898150e+001,-3.311888848756182e+001,6.229138557796490e+001,
        3.620373890836158e+002},{1.870908669701693e+001,-3.293324699210280e+001,
        6.207995811721918e+001,3.622364251801869e+002},{1.839809418279004e+001,
        -3.275309960418061e+001,6.187250141735893e+001,3.624321496779760e+002},
        {1.808335136498075e+001,-3.257823292493270e+001,6.166892388130226e+001,
        3.626246176759661e+002},{1.776248672564552e+001,-3.240847057790838e+001,
        6.146913652788158e+001,3.628138833563929e+002},{1.743245820179932e+001,
        -3.224362752288467e+001,6.127305262354953e+001,3.629999999999999e+002},
        {1.708940169785534e+001,-3.206925059654591e+001,6.106275077012659e+001,
        3.631999999999998e+002},{1.727072380355401e+001,-3.190283448428098e+001,
        6.085287055989324e+001,3.634000000000002e+002},{1.576467522519720e+001,
        -3.171731020772320e+001,6.064333258200428e+001,3.636000000000000e+002},
        {1.639061885722927e+001,-3.156729873543955e+001,6.043429544463123e+001,
        3.638000000000000e+002},{1.577581090427984e+001,-3.139814584618751e+001,
        6.022552408630595e+001,3.640000000000001e+002},{1.543114797734251e+001,
        -3.123725025299474e+001,6.001714130776343e+001,3.642000000000000e+002},
        {1.508206908869408e+001,-3.107920267388456e+001,5.980909872430626e+001,
        3.644000000000001e+002},{1.472796538577313e+001,-3.092406207912170e+001,
        5.960138055055287e+001,3.646000000000000e+002},{1.436821268934422e+001,
        -3.077189392866886e+001,5.939397035423640e+001,3.647999999999999e+002},
        {1.400211036945577e+001,-3.062276983306427e+001,5.918685099995032e+001,
        3.649999999999999e+002},{1.362888293958223e+001,-3.047676843426775e+001,
        5.898000459303437e+001,3.652000000000000e+002},{1.324767438217522e+001,
        -3.033397615333581e+001,5.877341241576365e+001,3.654000000000000e+002},
        {1.285753973119515e+001,-3.019448807281502e+001,5.856705485715880e+001,
        3.656000000000000e+002},{1.245741665183489e+001,-3.005840871434270e+001,
        5.836091133461882e+001,3.657999999999999e+002},{1.204608676545747e+001,
        -2.992585293758458e+001,5.815496020672768e+001,3.660000000000001e+002},
        {1.162216928497416e+001,-2.979694764877785e+001,5.794917867743944e+001,
        3.661999999999999e+002},{1.118402249211580e+001,-2.967183260501715e+001,
        5.774354268368643e+001,3.663999999999999e+002},{1.072966463770549e+001,
        -2.955066252866774e+001,5.753802677196912e+001,3.666000000000000e+002},
        {1.025660267328408e+001,-2.943360905079618e+001,5.733260395197137e+001,
        3.668000000000001e+002},{9.761584790130781e+000,-2.932086371792684e+001,
        5.712724552477193e+001,3.670000000000000e+002},{9.240175660907763e+000,
        -2.921264175923935e+001,5.692192087203171e+001,3.672000000000001e+002},
        {8.686057647179084e+000,-2.910918755650368e+001,5.671659719110131e+001,
        3.673999999999998e+002},{8.778234040826405e+000,-2.901811342102016e+001,
        5.651125648369048e+001,3.675999999999999e+002},{6.691629539833685e+000,
        -2.890243901808726e+001,5.630576331567251e+001,3.677999999999998e+002},
        {7.290370456106036e+000,-2.883742522272521e+001,5.610033249324230e+001,
        3.679999999999999e+002},{6.272233268873873e+000,-2.874834766050094e+001,
        5.589459420906075e+001,3.682000000000001e+002},{5.558422478759069e+000,
        -2.867317963045713e+001,5.568870519404406e+001,3.683999999999999e+002},
        {4.792961753723030e+000,-2.860487749510562e+001,5.548256579547770e+001,
        3.685999999999999e+002},{3.968238215541748e+000,-2.854396871234190e+001,
        5.527612109369429e+001,3.687999999999998e+002},{3.075217193011998e+000,
        -2.849105390721893e+001,5.506931114354074e+001,3.690000000000001e+002},
        {2.103060257219561e+000,-2.844681941762896e+001,5.486207027055930e+001,
        3.692000000000001e+002},{1.038687074059420e+000,-2.841205356272049e+001,
        5.465432623928827e+001,3.694000000000000e+002},{-1.339999048012931e-001,
        -2.838766434327866e+001,5.444599925272737e+001,3.696000000000000e+002},
        {-1.435063121990103e+000,-2.837470417780358e+001,5.423700075757526e+001,
        3.698000000000000e+002},{-2.890489367153537e+000,-2.837439436195233e+001,
        5.402723196589630e+001,3.700000000000001e+002},{-4.535509502325382e+000,
        -2.838815668289008e+001,5.381658203375368e+001,3.702000000000000e+002},
        {-6.421717110684526e+000,-2.841764003690377e+001,5.360492570392729e+001,
        3.704000000000001e+002},{-8.029122269107946e+000,-2.847153711327977e+001,
        5.339213717659963e+001,3.705999999999999e+002},{-1.150718130865884e+001,
        -2.852257064861725e+001,5.317796925804201e+001,3.708000000000000e+002},
        {-1.357244772388494e+001,-2.862919062243810e+001,5.296244024140553e+001,
        3.710000000000001e+002},{-1.717479675911297e+001,-2.874214450332900e+001,
        5.274508640521118e+001,3.711999999999999e+002},{-2.123801901866396e+001,
        -2.889134404513250e+001,5.252580043857113e+001,3.714000000000001e+002},
        {-2.619511142469762e+001,-2.907738790923127e+001,5.230424646131181e+001,
        3.716000000000000e+002},{-3.236073058364635e+001,-2.930723253179286e+001,
        5.208006194513168e+001,3.717999999999999e+002},{-4.022068942597398e+001,
        -2.958957539713408e+001,5.185280422638054e+001,3.720000000000000e+002},
        {-5.027803753687388e+001,-2.993866920656852e+001,5.162193160829787e+001,
        3.721999999999999e+002},{-6.436974496162212e+001,-3.035919422556437e+001,
        5.138671614373845e+001,3.724000000000002e+002},{-8.360686397848249e+001,
        -3.088595220083816e+001,5.114631483263473e+001,3.726000000000000e+002},
        {-1.100834389241486e+002,-3.155568586681570e+001,5.089950843562296e+001,
        3.728000000000001e+002},{-1.472841062914758e+002,-3.245099931262556e+001,
        5.064476196619719e+001,3.730000000000000e+002},{-2.021579877018242e+002,
        -3.370859211762419e+001,5.037989000027908e+001,3.732000000000001e+002},
        {-2.897791479469411e+002,-3.471839082840622e+001,5.017174758533965e+001,
        3.733500000000000e+002},{-4.370418417975305e+002,-3.595572803188362e+001,
        4.995306621058514e+001,3.735000000000001e+002},{-6.808564431390644e+002,
        -3.803753250618856e+001,4.971098502785520e+001,3.736561480000000e+002},
        {-1.079182893585270e+003,-4.178442673431590e+001,4.945933042367851e+001,
        3.738058199999999e+002},{-1.681835788759286e+003,-4.662329946397544e+001,
        4.925008325739737e+001,3.739180740000000e+002},{-2.582563222934587e+003,
        -5.134362044917342e+001,4.909428751215069e+001,3.739929099999999e+002},
        {-4.106828068576426e+003,-5.577687841590389e+001,4.896368572381315e+001,
        3.740490370000001e+002},{-5.107591845246606e+003,-6.580440293493800e+001,
        4.883933501194808e+001,3.740976804000001e+002},{-9.771765920564003e+003,
        -7.560712452291881e+001,4.870422526751046e+001,3.741425820000000e+002},
        {-8.755497642709564e+003,-8.742278426612906e+001,4.864183118847620e+001,
        3.741612909999998e+002},{-9.815118604201449e+003,-9.075723406919788e+001,
        4.861419440063168e+001,3.741687745999999e+002},{-1.598688798560589e+004,
        -9.374464327459545e+001,4.857016747633733e+001,3.741800000000001e+002},
        {-1.920875724714269e+004,-1.019624881152255e+002,4.852930969549549e+001,
        3.741899999999998e+002},{-1.636215913588905e+005,-7.659891465615223e+001,
        4.848251558276280e+001,3.741999999999999e+002},{-1.286897688417260e+006,
        1.186575607887113e+001,4.845730381784014e+001,3.742050000000000e+002},{
        8.838952576730371e+007,-4.445028478910222e+003,4.849792832024318e+001,
        3.742074999999999e+002}};
    constant Real[Ninterval, 4] ptcoef={{0.786553610980441,0.073986317581331,
        0.004029258982827,0.000095977628483},{0.804804842020852,
        0.075513868977931,0.004128852620146,0.000098693577477},{
        0.826483769874362,0.076781180144682,0.004214141994619,0.000101026437564},
        {0.852226781522051,0.079838214007716,0.004413722019840,
        0.000106516958458},{0.878734233127809,0.083011720420838,
        0.004622630654312,0.000112305941336},{0.905918938100631,
        0.086306406812799,0.004841289235230,0.000118409424841},{
        0.933873884997079,0.089726230581858,0.005070153132594,0.000124844693392},
        {0.962577238137988,0.093275895699320,0.005309687431187,
        0.000131629706447},{0.992070856558737,0.096959926219076,
        0.005560383405310,0.000138783529530},{1.022340779604642,
        0.100783239811202,0.005822748456693,0.000146326107976},{
        1.053408429650162,0.104750722856737,0.006097318061549,0.000154278611181},
        {1.085334401770672,0.108867191838833,0.006384645627683,
        0.000162663184614},{1.118066059070003,0.113138431880924,
        0.006685319756183,0.000171503506240},{1.151675830716446,
        0.117569521390065,0.006999950677252,0.000180824369499},{
        1.186152658253827,0.122166182229820,0.007329167943923,0.000190651710758},
        {1.221529325860328,0.126934198374854,0.007673642176701,
        0.000201013248529},{1.257786462283640,0.131879624460586,
        0.008034059624186,0.000211937791220},{1.294812956053328,
        0.137009131430195,0.008411150309429,0.000223456117470},{
        1.332050814897662,0.142331923230738,0.008805666323160,0.000235600452886},
        {1.369397755526468,0.147855890364265,0.009218393425041,
        0.000248404751272},{1.406816638143677,0.153467769902578,
        0.009641353399052,0.000261628465319},{1.444356079648527,
        0.158956456158090,0.010059134663008,0.000274788118369},{
        1.482496486580440,0.164593208638941,0.010491786565620,0.000288515879081},
        {1.521219525653765,0.170380509776158,0.010939707938024,
        0.000302831882662},{1.560542804418774,0.176320624445618,
        0.011403304275305,0.000317756801604},{1.600437543776211,
        0.182416074041046,0.011882987053658,0.000333311854289},{
        1.640936272107287,0.188669018847875,0.012379174551977,0.000349518813327},
        {1.681996400839473,0.195082050643184,0.012892290728097,
        0.000366400014143},{1.723656934024151,0.201657263429387,
        0.013422766529104,0.000383978363163},{1.765877582075693,
        0.208397225399801,0.013971038423670,0.000402277346453},{
        1.808673898875252,0.215304119402563,0.014537549727065,0.000421321037758},
        {1.852056948436205,0.222380208630733,0.015122749655067,
        0.000441134107092},{1.895976234842191,0.229628047386924,
        0.015727093310843,0.000461741828759},{1.940485837249081,
        0.237049568378319,0.016351042726376,0.000483170089585},{
        1.985535349395222,0.244647339911478,0.016995065014999,0.000505445397324},
        {2.031148612115400,0.252423430625727,0.017659634148470,
        0.000528594888329},{2.077302947391230,0.260380191193645,
        0.018345229588173,0.000552646335999},{2.124013371424510,
        0.268519730288320,0.019052337090330,0.000577628158512},{
        2.171233734600246,0.276844461955414,0.019781447908203,0.000603569426887},
        {2.219036879803186,0.285356138275785,0.020533059923821,
        0.000630499872733},{2.267319033113332,0.294057511278019,
        0.021307675460814,0.000658449896208},{2.316150758140982,
        0.302950218193697,0.022105804263753,0.000687450573315},{
        2.365499765564834,0.312036591386713,0.022927960463078,0.000717533664244},
        {2.415341254676885,0.321318803772746,0.023774664275808,
        0.000748731620229},{2.465702228666255,0.330798721201480,
        0.024646441777799,0.000781077591413},{2.516566337049237,
        0.340478491545039,0.025543824020845,0.000814605434250},{
        2.567900988365430,0.350360262236221,0.026467347650949,0.000849349718558},
        {2.619736333280843,0.360445798567964,0.027417555102175,
        0.000885345734951},{2.672048765758521,0.370737202172238,
        0.028394993495523,0.000922629502038},{2.724826587346702,
        0.381236432325441,0.029400215484282,0.000961237773163},{
        2.778063214522083,0.391945380908662,0.030433778913126,0.001001208043570},
        {2.831766036616288,0.402865857403683,0.031496246697041,
        0.001042578557225},{2.885908682390723,0.413999836240006,
        0.032588186505531,0.001085388313488},{2.940499375779766,
        0.425349047466033,0.033710171266653,0.001129677073668},{
        2.995518695471547,0.436915364909673,0.034862778477020,0.001175485367706},
        {3.050956509836956,0.448700547312638,0.036046590569830,
        0.001222854500461},{3.106820822095549,0.460706240111525,
        0.037262194688661,0.001271826558129},{3.163093309167843,
        0.472934226350843,0.038510182323064,0.001322444414376},{
        3.219746757773316,0.485386251264479,0.039791149597540,0.001374751736327},
        {3.276823378325092,0.498063672720634,0.041105697402525,
        0.001428792990668},{3.334256093194325,0.510968455863627,
        0.042454430092932,0.001484613449495},{3.392066452222572,
        0.524101941700382,0.043837957232333,0.001542259195759},{
        3.450267320729766,0.537465592429579,0.045256892052289,0.001601777129328},
        {3.508789067634338,0.551061252504325,0.046711851466142,
        0.001663214972080},{3.567677958706406,0.564890022697125,
        0.048203457357055,0.001726621273310},{3.626905151411771,
        0.578953490302442,0.049732334529406,0.001792045415320},{
        3.686462083749643,0.593253045708126,0.051299111947236,0.001859537618008},
        {3.746327635912001,0.607790095318200,0.052904422199431,
        0.001929148944129},{3.806521328539690,0.622565797973926,
        0.054548901665213,0.002000931304129},{3.867009632214078,
        0.637581603413359,0.056233189735702,0.002074937460871},{
        3.927782116924284,0.652838734378914,0.057957929579066,0.002151221034049},
        {3.988852365666806,0.668338275550249,0.059723767660887,
        0.002229836504888},{4.050192516216124,0.684081532186310,
        0.061531353270102,0.002310839220353},{4.111789278896813,
        0.700069639448781,0.063381339086498,0.002394285397225},{
        4.173651666210960,0.716303589828222,0.065274380831822,0.002480232126358},
        {4.235756676172436,0.732784540271985,0.067211136814012,
        0.002568737376544},{4.298085502042800,0.749513538707623,
        0.069192268324502,0.002659859998184},{4.360671661599279,
        0.766491347937005,0.071218439541212,0.002753659727090},{
        4.423438949366865,0.783719304937090,0.073290316468236,0.002850197187960},
        {4.486438551377852,0.801197930575199,0.075408568729196,
        0.002949533897579},{4.549635083346689,0.818928297908401,
        0.077573867304666,0.003051732268502},{4.613005208765145,
        0.836911289865486,0.079786885896258,0.003156855611648},{
        4.676574403683728,0.855147500168120,0.082048300614339,0.003264968139624},
        {4.740297050704474,0.873637909632577,0.084358789038483,
        0.003376134969544},{4.804190690507514,0.892383063052667,
        0.086719031350494,0.003490422125512},{4.868235121873531,
        0.911383726822147,0.089129709147211,0.003607896541475},{
        4.932419559693664,0.930640548615199,0.091591505998932,0.003728626063414},
        {4.996730104947655,0.950154145354210,0.094105107137860,
        0.003852679451797},{5.061189204396221,0.969924932558094,
        0.096671199500138,0.003980126383733},{5.125721774355183,
        0.989953806668835,0.099290470904280,0.004111037454977},{
        5.190399776670092,1.010240773734387,0.101963611687264,0.004245484181735},
        {5.255151436743157,1.030786704419071,0.104691312074425,
        0.004383539002791},{5.319997881680896,1.051591809289908,
        0.107474264565075,0.004525275280559},{5.384915083275455,
        1.072656564602096,0.110313162173150,0.004670767303162},{
        5.449915764807296,1.093981202980726,0.113208699187816,0.004820090285488},
        {5.514961084515890,1.115566214746911,0.116161570403907,
        0.004973320370546},{5.580069995165794,1.137411702858405,
        0.119172471924876,0.005130534630481},{5.645214917013816,
        1.159518032770311,0.122242100064668,0.005291811067763},{
        5.710397135075893,1.181885343682942,0.125371152069178,0.005457228615834},
        {5.775601905695197,1.204513844192818,0.128560325505952,
        0.005626867140010},{5.840835782784636,1.227403598430226,
        0.131810318497041,0.005800807438005},{5.906059494800497,
        1.250554880485784,0.135121829207348,0.005979131240455},{
        5.971301283679346,1.273967536407251,0.138495556564960,0.006161921211248},
        {6.036525184627135,1.297641782816887,0.141932199008561,
        0.006349260947941},{6.101742108554982,1.321577504276583,
        0.145432455530469,0.006541234981608},{6.166925944102037,
        1.345774777484733,0.148997024740760,0.006737928777106},{
        6.232083718610021,1.370233441641100,0.152626605432942,0.006939428732812},
        {6.297207184980851,1.394953425336797,0.156321895953925,
        0.007145822180530},{6.362277871137049,1.419934665093411,
        0.160083594379107,0.007357197385014},{6.427293032446297,
        1.445176960347283,0.163912398571472,0.007573643543593},{
        6.492248494825507,1.470680105264633,0.167809005838224,0.007795250785685},
        {6.557139915959902,1.496443877947695,0.171774112913575,
        0.008022110172037},{6.621948550316446,1.522468096828492,
        0.175808415864079,0.008254313693933},{6.686677764125916,
        1.548752416568682,0.179912610249625,0.008491954272338},{
        6.751318489523362,1.575296555162762,0.184087390680888,0.008735125756982},
        {6.815849328693517,1.602100243679581,0.188333450922353,
        0.008983922925176},{6.880294415977666,1.629162944906189,
        0.192651484067798,0.009238441480674},{6.944622895829550,
        1.656484438791168,0.197042181708333,0.009498778052406},{
        7.008826622849972,1.684064290571623,0.201506234762844,0.009765030192908},
        {7.072914856384893,1.711901963064116,0.206044333006924,
        0.010037296377091},{7.136877800207411,1.739997032582018,
        0.210657164762212,0.010315676000575},{7.200691051456989,
        1.768349094724015,0.215345417113497,0.010600269377903},{
        7.264377479650122,1.796957457787893,0.220109776102959,0.010891177740886},
        {7.327906141296870,1.825821737448506,0.224950925854684,
        0.011188503236811},{7.391293625276115,1.854941234807067,
        0.229869549469729,0.011492348926300},{7.454508371077754,
        1.884315510467502,0.234866328098409,0.011802818781492},{
        7.517569054229431,1.913943797155383,0.239941941727175,0.012120017683787},
        {7.580459415407503,1.943825542494100,0.245097068267364,
        0.012444051421826},{7.643171908708069,1.973960094001435,
        0.250332384098234,0.012775026689016},{7.705707996362623,
        2.004346732841488,0.255648563847159,0.013113051081326},{
        7.768059519623182,2.034984784600641,0.261046280194050,0.013458233094852},
        {7.830220904482947,2.065873531807347,0.266526203982097,
        0.013810682123266},{7.892188564751971,2.097012226673120,
        0.272089004114447,0.014170508455295},{7.953965487964128,
        2.128400080683881,0.277735347500195,0.014537823272081},{
        8.015523649434170,2.160036441620303,0.283465898846533,0.014912738644454},
        {8.076895462829125,2.191920302660508,0.289281321183433,
        0.015295367530163},{8.138044320167687,2.224051063573816,
        0.295182274777506,0.015685823771147},{8.198976439581513,
        2.256427805724049,0.301169418248213,0.016084222090402},{
        8.259707938402711,2.289049595720479,0.307243407828786,0.016490678089312},
        {8.320192607430975,2.321915814614592,0.313404897121920,
        0.016905308244463},{8.380470028810771,2.355025314333463,
        0.319654538135147,0.017328229904537},{8.440522518139051,
        2.388377335023929,0.325992979815505,0.017759561287442},{
        8.500322217978708,2.421971086721057,0.332420868948437,0.018199421476779},
        {8.559907453252212,2.455805402507063,0.338938850295470,
        0.018647930418875},{8.619247679352942,2.489879545144593,
        0.345547565459140,0.019105208919565},{8.678350338810887,
        2.524192502690502,0.352247654043904,0.019571378640574},{
        8.737200358793032,2.558743383285288,0.359039752909466,0.020046562096445},
        {8.795818738593697,2.593531090067868,0.365924496580261,
        0.020530882651035},{8.854183207405342,2.628554783799626,
        0.372902516607536,0.021024464514114},{8.912292637601727,
        2.663813451198047,0.379974442256104,0.021527432737748},{
        8.970164816146156,2.699305998657141,0.387140900144449,0.022039913212986},
        {9.027764581740044,2.735031616100854,0.394402513874834,
        0.022562032666223},{9.085123127706376,2.770989086540987,
        0.401759904933333,0.023093918655552},{9.142217145365851,
        2.807177536491606,0.409213691526334,0.023635699567366},{
        9.199057526581893,2.843595861945240,0.416764489523273,0.024187504612462},
        {9.255634156711325,2.880243086753219,0.424412911826686,
        0.024749463822588},{9.311949978406053,2.917118141884187,
        0.432159568722993,0.025321708046652},{9.368005011068972,
        2.954219981819242,0.440005067647167,0.025904368947099},{
        9.423798091407672,2.991547565855996,0.447950013236107,0.026497578996133},
        {9.479322284803363,3.029099871775003,0.455995007318796,
        0.027101471471982},{9.534586801784080,3.066875784845970,
        0.464140649013009,0.027716180455168},{9.589583111450359,
        3.104874298352855,0.472387534443667,0.028341840824758},{
        9.644318672936832,3.143094307303569,0.480736257056818,0.028978588254514},
        {9.698780209475908,3.181534819712769,0.489187407311572,
        0.029626559209175},{9.752988166020387,3.220194655215614,
        0.497741573065422,0.030285890940625},{9.806914003161001,
        3.259072911744028,0.506399338956173,0.030956721484151},{
        9.860588583346717,3.298168334723664,0.515161287270285,0.031639189654531},
        {9.913991884695866,3.337479997260490,0.524027996925208,
        0.032333435042396},{9.967130228266164,3.377006786609229,
        0.533000044348281,0.033039598010199},{10.020005553537565,
        3.416747632921908,0.542078003011462,0.033757819688613},{
        10.072615604413384,3.456701490940380,0.551262443523183,
        0.034488241972654},{10.124967253171006,3.496867269778813,
        0.560553933719096,0.035231007517885},{10.177046563723209,
        3.537243989500037,0.569953038482225,0.035986259736650},{
        10.228875748201631,3.577830469437759,0.579460320131242,
        0.036754142794284},{10.280445312958783,3.618625745018311,
        0.589076337835556,0.037534801605407},{10.331749969404274,
        3.659628796758036,0.598801648151134,0.038328381830030},{
        10.382798930610805,3.700838525857476,0.608636804932991,
        0.039135029869976},{10.433600732654398,3.742253873156421,
        0.618582359146748,0.039954892865162},{10.484133544637205,
        3.783873935436875,0.628638858864915,0.040788118689806},{
        10.534436373982112,3.825697478101712,0.638806849846641,
        0.041634855948772},{10.584473346798614,3.867723723077579,
        0.649086874493393,0.042495253974029},{10.634263232829829,
        3.909951529450528,0.659479473130387,0.043369462820802},{
        10.683818854528312,3.952379855381508,0.669985183113258,
        0.044257633264281},{10.733119485900088,3.995007844903166,
        0.680604538962431,0.045159916795814},{10.782187429189030,
        4.037834386520546,0.691338072953496,0.046076465619372},{
        10.831022040856825,4.080858550106148,0.702186314429305,
        0.047007432648198},{10.879606700772708,4.124079466970156,
        0.713149790186699,0.047952971501152},{10.927971273840956,
        4.167496015473688,0.724229024778087,0.048913236499386},{
        10.976106518013856,4.211107350457580,0.735424539778802,
        0.049888382663002},{11.024007342655198,4.254912573065150,
        0.746736854471000,0.050878565707475},{11.071698030565202,
        4.298910646304973,0.758166485812413,0.051883942040502},{
        11.119157876862268,4.343100810847359,0.769713947959052,
        0.052904668758722},{11.166410089929238,4.387482048337676,
        0.781379753083690,0.053940903644358},{11.213444532743557,
        4.432053567134218,0.793164410642923,0.054992805162211},{
        11.260274048538790,4.476814442825981,0.805068428005676,
        0.056060532456357},{11.306896593576145,4.521763862164671,
        0.817092310086160,0.057144245347173},{11.353322382593026,
        4.566900954540457,0.829236559658240,0.058244104328223},{
        11.399547252019955,4.612224948003909,0.841501677172442,
        0.059360270563319},{11.445587422729814,4.657734972153432,
        0.853888161066984,0.060492905883569},{11.491426255466461,
        4.703430353321102,0.866396507423689,0.061642172784548},{
        11.537096574565506,4.749310152874991,0.879027210611636,
        0.062808234423435},{11.582580184110803,4.795373768279950,
        0.891780762485170,0.063991254616361},{11.627892085691373,
        4.841620390979311,0.904657653309611,0.065191397835530},{
        11.673035757508945,4.888049318737771,0.917658371228776,
        0.066408829206806},{11.718011197256940,4.934659877239165,
        0.930783402516026,0.067643714507045},{11.762834239165681,
        4.981451328650070,0.944033231699365,0.068896220161631},{
        11.807497796646979,5.028423090503301,0.957408341337984,
        0.070166513242073},{11.852019325559198,5.075574453530177,
        0.970909212484283,0.071454761463596},{11.896393217304059,
        5.122904870887758,0.984536324306399,0.072761133182957},{
        11.940631343927475,5.170413703210555,0.998290154543469,
        0.074085797396168},{11.984740791999011,5.218100377914232,
        1.012171179272453,0.075428923736457},{12.028718632188408,
        5.265964390903449,1.026179873042613,0.076790682472158},{
        12.072586720369342,5.314005127040347,1.040316709128782,
        0.078171244504771},{12.116334688142151,5.362222187928859,
        1.054582159164051,0.079570781367113},{12.159978238056379,
        5.410615029139965,1.068976693754340,0.080989465221439},{
        12.203519113274206,5.459183225116353,1.083500782085046,
        0.082427468857874},{12.246973860534712,5.507926297975900,
        1.098154892266446,0.083884965692685},{12.290333050611526,
        5.556843940294234,1.112939491127611,0.085362129766796},{
        12.333616287920439,5.605935690440304,1.127855044729348,
        0.086859135744312},{12.376827944463761,5.655201226431555,
        1.142902017949415,0.088376158911288},{12.419970336161901,
        5.704640252028573,1.158080874821313,0.089913375174364},{
        12.463057868403830,5.754252431854722,1.173392078642345,
        0.091470961059675},{12.506093470453104,5.804037534286757,
        1.188836091849739,0.093049093711825},{12.549084484576550,
        5.853995321776277,1.204413376293114,0.094647950892901},{
        12.592041013933368,5.904125575040546,1.220124393236732,
        0.096267710981682},{12.634969844799203,5.954428128657826,
        1.235969603401023,0.097908552972900},{12.677879333523451,
        6.004902838096064,1.251949467106324,0.099570656476601},{
        12.720778138710589,6.055549591140720,1.268064444332499,
        0.101254201717648},{12.763677927417257,6.106368298174700,
        1.284314994816732,0.102959369535330},{12.806573690779381,
        6.157358983209033,1.300701578059685,0.104686341383082},{
        12.849495734467585,6.208521508652972,1.317224653725359,
        0.106435299328330},{12.892432395176041,6.259856026588764,
        1.333884681122604,0.108206426052510},{12.935407425706483,
        6.311362500376266,1.350682120030723,0.109999904851008},{
        12.978425056907367,6.363041066848615,1.367617430188535,
        0.111815919633535},{13.021491468318452,6.414891872038170,
        1.384691071730111,0.113654654924339},{13.064617370780807,
        6.466915068601184,1.401903505228866,0.115516295862749},{
        13.107822326512034,6.519110816528661,1.419255191755479,
        0.117401028203792},{13.151102428135824,6.571479448359150,
        1.436746592829065,0.119309038318884},{13.194475889857047,
        6.624021192307916,1.454378170915361,0.121240513196689},{
        13.237950456876277,6.676736391559659,1.472150389150132,
        0.123195640444242},{13.281543801507878,6.729625380540582,
        1.490063711663251,0.125174608288032},{13.325252146812181,
        6.782688650527698,1.508118603496211,0.127177605575334},{
        13.369105579817697,6.835926541870936,1.526315531104156,
        0.129204821775656},{13.413096345193450,6.889339667250363,
        1.544654961877694,0.131256446982442},{13.457252262710217,
        6.942928465635696,1.563137364930240,0.133332671914716},{
        13.501577668383591,6.996693581650487,1.581763210613397,
        0.135433687919157},{13.546081324560269,7.050635659475550,
        1.600532971040650,0.137559686972068},{13.590784720119347,
        7.104755327585545,1.619447120138809,0.139710861681738},{
        13.635691247339029,7.159053373072407,1.638506133564744,
        0.141887405290866},{13.680822070366473,7.213530525265771,
        1.657710489160656,0.144089511679116},{13.726188668268707,
        7.268187637271742,1.677060666796245,0.146317375365973},{
        13.771798297574913,7.323025625062165,1.696557148667505,
        0.148571191513651},{13.817664037870237,7.378045410406364,
        1.716200419477746,0.150851155930304},{13.863822536457358,
        7.433247873019335,1.735990966547698,0.153157465073401},{
        13.910252564596428,7.488634271483426,1.755929279538731,
        0.155490316053202},{13.957000220459447,7.544205509430398,
        1.776015851602120,0.157849906636426},{14.004059404788652,
        7.599962884516280,1.796251178364456,0.160236435250439},{
        14.051458652306392,7.655907531048133,1.816635759011231,
        0.162650100987143},{14.099212398107770,7.712040754313932,
        1.837170095861397,0.165091103607519},{14.147325830763135,
        7.768363954548588,1.857854694766285,0.167559643546089},{
        14.195829055713423,7.824878452918044,1.878690065435772,
        0.170055921915781},{14.244733952698137,7.881585764229075,
        1.899676721206714,0.172580140513001},{14.294057776086026,
        7.938487429382151,1.920815179546794,0.175132501822787},{
        14.343815086396987,7.995585069263414,1.942105962124181,
        0.177713209024381},{14.394032268232515,8.052880315699051,
        1.963549595058805,0.180322465996985},{14.444723227764078,
        8.110374956342044,1.985146608928002,0.182960477325750},{
        14.495902989738047,8.168070830084497,2.006897539164692,
        0.185627448307985},{14.547604591999210,8.225969763841938,
        2.028802926260754,0.188323584959739},{14.599830390476210,
        8.284073839908597,2.050863315657581,0.191049094022576},{
        14.652622712367227,8.342384989911224,2.073079258516169,
        0.193804182970581},{14.705976237638581,8.400905505967810,
        2.095451311216376,0.196589060017819},{14.759945876695406,
        8.459637417523181,2.117980036449677,0.199403934125846},{
        14.814518646197049,8.518583246343280,2.140666002382416,
        0.202249015011809},{14.869750175199750,8.577745187148663,
        2.163509784095016,0.205124513156487},{14.925639645519096,
        8.637125883725918,2.186511962629850,0.208030639813101},{
        14.982229688310740,8.696727802523457,2.209673126244849,
        0.210967607015953},{15.039533284178862,8.756553699721664,
        2.232993869911483,0.213935627589852},{15.097579737480817,
        8.816606318080309,2.256474796094395,0.216934915159529},{
        15.156404639376522,8.876888492665323,2.280116514767052,
        0.219965684159667},{15.216017087353354,8.937403307410889,
        2.303919643575055,0.223028149845113},{15.276468737781256,
        8.998153712061299,2.327884808606054,0.226122528301507},{
        15.337764957062324,9.059143049053603,2.352012643941528,
        0.229249036456430},{15.399953708033358,9.120374511511402,
        2.376303792775960,0.232407892090670},{15.463063557119732,
        9.181851562515480,2.400758907024612,0.235599313850235},{
        15.527112665343029,9.243577821571789,2.425378647972495,
        0.238823521258444},{15.592155238801022,9.305556836457487,
        2.450163686802990,0.242080734728696},{15.658205916070527,
        9.367792530614247,2.475114704329850,0.245371175577657},{
        15.725311601613303,9.430288756971484,2.500232392044810,
        0.248695066038703},{15.793507965239648,9.493049601511352,
        2.525517451946825,0.252052629276138},{15.862825932729402,
        9.556079312219197,2.550970597127956,0.255444089399622},{
        15.933312197602097,9.619382197849491,2.576592552254044,
        0.258869671479274},{16.004995953725416,9.682962824454661,
        2.602384053692833,0.262329601561279},{16.077934097300989,
        9.746825764001034,2.628345850269465,0.265824106683943},{
        16.152154592300423,9.810975932600028,2.654478703227895,
        0.269353414894413},{16.227712509060744,9.875418249703314,
        2.680783387196289,0.272917755265819},{16.304641683475939,
        9.940157940705490,2.707260690167921,0.276517357915222},{
        16.383003793998693,10.005200254894007,2.733911414380859,
        0.280152454021976},{16.462838398153838,10.070550777666666,
        2.760736376351767,0.283823275846862},{16.544196962610815,
        10.136215205238340,2.787736407777602,0.287530056751718},{
        16.627135322317265,10.202199422476509,2.814912355868767,
        0.291273031219949},{16.711706524449259,10.268509549183181,
        2.842265083851243,0.295052434877599},{16.797965223152705,
        10.335151911490948,2.869795471594543,0.298868504515166},{
        16.885973077432112,10.402133026596109,2.897504416190871,
        0.302721478110211},{16.975789197985613,10.469459668908286,
        2.925392832470037,0.306611594850730},{17.067475629391790,
        10.537138837988799,2.953461653692272,0.310539095159306},{
        17.161101261098594,10.605177754876001,2.981711832178946,
        0.314504220718140},{17.256727563447523,10.673583946230488,
        3.010144339891328,0.318507214494939},{17.354434081476601,
        10.742365112825921,3.038760169297755,0.322548320769679},{
        17.454286888967282,10.811529328281166,3.067560333823008,
        0.326627785162365},{17.556361872915055,10.881084891722661,
        3.096545868856221,0.330745854661660},{17.660747345879500,
        10.951040356809601,3.125717832414596,0.334902777654663},{
        17.767513251246932,11.021404704495929,3.155077305781520,
        0.339098803957625},{17.876753527147354,11.092187100141274,
        3.184625394700079,0.343334184847757},{17.988558020215013,
        11.163397102005085,3.214363229894611,0.347609173096297},{
        18.103011475980828,11.235044648907479,3.244291968095110,
        0.351924023002582},{18.220219931796926,11.307139934127857,
        3.274412793120600,0.356278990429461},{18.340280778986866,
        11.379693610445296,3.304726916567339,0.360674332839995},{
        18.463298080493942,11.452716694435287,3.335235579044130,
        0.365110309335374},{18.589380769544157,11.526220600337037,
        3.365940051173917,0.369587180694344},{18.718647779688055,
        11.600217138800916,3.396841634701593,0.374105209414034},{
        18.851216237562294,11.674718604461052,3.427941663564171,
        0.378664659752273},{18.987207173821421,11.749737745984419,
        3.459241505194474,0.383265797771458},{19.126757016277303,
        11.825287735512903,3.490742561796580,0.387908891384136},{
        19.270000698205109,11.901382297719167,3.522446271500800,
        0.392594210400251},{19.417078152378568,11.978035678304561,
        3.554354109854081,0.397322026576132},{19.568141318232165,
        12.055262635750358,3.586467591264484,0.402092613665429},{
        19.723341784072204,12.133078538964597,3.618788270391853,
        0.406906247471983},{19.882852937169588,12.211499277098069,
        3.651317743856020,0.411763205904696},{20.046837713802415,
        12.290541476213873,3.684057651628890,0.416663769034575},{
        20.215476229183036,12.370222346595941,3.717009679046383,
        0.421608219153951},{20.388962195235955,12.450559766172979,
        3.750175558448313,0.426596840838175},{20.567492357396723,
        12.531572377068581,3.783557070998268,0.431629921009646},{
        20.751272461251776,12.613279573840439,3.817156048763674,
        0.436707749004418},{20.940523114529331,12.695701516360126,
        3.850974376794579,0.441830616641583},{21.135476236295002,
        12.778859203541924,3.885013995236225,0.446998818295461},{
        21.336375814837982,12.862774515603268,3.919276901634197,
        0.452212650970746},{21.543467768371034,12.947470302848114,
        3.953765153318787,0.457472414380798},{21.757039843293096,
        13.032970233643164,3.988480870150037,0.462778411029265},{
        21.977357441327399,13.119299219389090,4.023426236698062,
        0.468130946295191},{22.204737719518644,13.206483027886401,
        4.058603505710217,0.473530328521646},{22.439488108542466,
        13.294548737309782,4.094015000456882,0.478976869108469},{
        22.681951162306543,13.383524517175067,4.129663118341967,
        0.484470882608819},{22.932481353049372,13.473439862652034,
        4.165550333923462,0.490012686830258},{23.191458098134174,
        13.564325589516613,4.201679202567487,0.495602602940237},{
        23.459284149429621,13.656213940965090,4.238052364104783,
        0.501240955576484},{23.736388399611037,13.749138669767067,
        4.274672546779892,0.506928072962465},{24.024430476092892,
        13.843130314827746,4.311542575726286,0.512664287028277},{
        24.322901123698131,13.938228205581177,4.348665367591055,
        0.518449933537306},{24.631006458958126,14.034476212891667,
        4.386043942312380,0.524285352219018},{24.947842383313581,
        14.133566333461264,4.424302227413089,0.530268052279225},{
        25.270996534558169,14.232467569803379,4.462269952561297,
        0.536214887057049},{25.600402310675729,14.330975064669545,
        4.499865784968846,0.542112503476356},{25.936148140993652,
        14.429098478934334,4.537090582375646,0.547960412315172},{
        26.278342961331273,14.526847123997111,4.573945317983731,
        0.553758163420801},{26.627081839098057,14.624230171354640,
        4.610431074409271,0.559505344514097},{26.982479035852489,
        14.721256475920658,4.646549038424966,0.565201580011704},{
        27.344634819583604,14.817934767851131,4.682300495420807,
        0.570846529867353},{27.713671593677677,14.914273470914237,
        4.717686824578717,0.576439888432411},{28.089691272397957,
        15.010280930582828,4.752709493736557,0.581981383336399},{
        28.472824854307039,15.105965165341871,4.787370055045711,
        0.587470774387750},{28.863193517870002,15.201334102546408,
        4.821670140178958,0.592907852495206},{29.260918302887685,
        15.296395505394935,4.855611456225897,0.598292438610054},{
        29.666132958462629,15.391156926950673,4.889195781620369,
        0.603624382689606},{30.078982460204806,15.485625755858862,
        4.922424962124026,0.608903562681821},{30.499592721193313,
        15.579809342711769,4.955300906990578,0.614129883531367},{
        30.928117472544855,15.673714785982705,4.987825585602939,
        0.619303276207172},{31.364710865969087,15.767349102050195,
        5.020001023779209,0.624423696751405},{31.809515123102404,
        15.860719254916436,5.051829300512150,0.629491125349948},{
        32.262705236081672,15.953831979977263,5.083312544958544,
        0.634505565424281},{32.724447907289544,16.046694000766831,
        5.114452933148136,0.639467042744666},{33.194897132039792,
        16.139312001629271,5.145252685204367,0.644375604564581},{
        33.674255019897664,16.231692414917958,5.175714062698377,
        0.649231318776222},{34.162693117856691,16.323841771582561,
        5.205839365624563,0.654034273086982},{34.660408283882070,
        16.415766446679168,5.235630930162420,0.658784574216433},{
        35.167590811037854,16.507472809522142,5.265091126045004,
        0.663482347114145},{35.684449944091867,16.598967127675568,
        5.294222354303641,0.668127734197491},{36.211206269977197,
        16.690255627599420,5.323027044937864,0.672720894609739},{
        36.748056707258620,16.781344600488524,5.351507654715894,
        0.677262003497751},{37.295248265383698,16.872240144915182,
        5.379666665308135,0.681751251309287},{37.852995971145809,
        16.962948488394094,5.407506580997999,0.686188843109573},{
        38.421564488506611,17.053475690433864,5.435029927062224,
        0.690574997916736},{39.001171266768537,17.143827988284571,
        5.462239247649191,0.694909948055925},{39.592097221535276,
        17.234011403696112,5.489137104365301,0.699193938531812},{
        40.194606324023972,17.324032074846357,5.515726074258302,
        0.703427226419012},{40.808938401803530,17.413896207928254,
        5.542008748346981,0.707610080270340},{41.435436776864577,
        17.503609730835098,5.567987730243535,0.711742779542350},{
        42.074330693130328,17.593178988541467,5.593665634167064,
        0.715825614037971},{42.725940101764373,17.682610023334441,
        5.619045084134955,0.719858883365846},{43.390590488356239,
        17.771908949085155,5.644128712167098,0.723842896416144},{
        44.070645121622796,17.861077799265878,5.668919158926054,
        0.727777970852333},{44.753184105407975,17.950153724907196,
        5.693419053900836,0.731664432618789},{45.474373691042267,
        18.039048771108984,5.717631098338662,0.735502615463705},{
        46.193899163412112,18.127899243718634,5.741557851475661,
        0.739292860480826},{46.996029946900421,18.216517946983732,
        5.765202097955019,0.743035515642772},{47.975217272766379,
        18.304869267108689,5.788566478022887,0.746730935410193},{
        46.875088973944962,18.397435734790200,5.811651899684304,
        0.750379480284763},{51.065991163454697,18.476818607729076,
        5.834469443821195,0.753981516503356},{49.333461744266728,
        18.573099243289850,5.857003438946910,0.757537415856357},{
        50.827892820844589,18.659006028627026,5.879277141033153,
        0.761047552504248},{51.658864029489543,18.747265541446783,
        5.901281540617321,0.764512309584712},{52.507342163173028,
        18.835468843734557,5.923021904004630,0.767932071140582},{
        53.373793178351164,18.923622470147773,5.944500865847515,
        0.771307225875759},{54.258789501497823,19.011732877688232,
        5.965721054625218,0.774638165973891},{55.162916478482941,
        19.099806756700104,5.986685091803454,0.777925286781048},{
        56.087116564192172,19.187850477830338,6.007395591520163,
        0.781168986499608},{57.032398932408853,19.275871118680147,
        6.027855159614455,0.784369665893400},{58.000369060093050,
        19.363875690575604,6.048066393969457,0.787527728003472},{
        59.016634487394832,19.451836730736815,6.068031895995421,
        0.790643577874778},{60.091857764934808,19.539739992232406,
        6.087754256968488,0.793717622293261},{61.240245331030316,
        19.627560573034796,6.107236083235058,0.796750269533514},{
        62.480561298708686,19.723763384189539,6.128269590423300,
        0.800019963066246},{61.700811904981713,19.825193831111250,
        6.149405839679586,0.803300925851243},{67.613280255293020,
        19.914643859675749,6.170653665148103,0.806593213984968},{
        65.160632861084636,20.026986310421218,6.191997393361786,
        0.809896884700018},{67.669033122940235,20.127441775170933,
        6.213461939269268,0.813211994514738},{69.158974688263967,
        20.233552143778557,6.235035431887980,0.816538605363333},{
        70.723256826348845,20.341932263338009,6.256723667414029,
        0.819876776933363},{72.367614994324157,20.452692130214967,
        6.278529139019087,0.823226571210103},{74.098101167452896,
        20.565950434907393,6.300454462542573,0.826588051543621},{
        75.921523426230067,20.681834359896129,6.322502386312879,
        0.829961282716883},{77.845391462064271,20.800480873586661,
        6.344675800844324,0.833346331019091},{79.877973252120924,
        20.922037773350514,6.366977749927341,0.836743264324587},{
        82.028526688840202,21.046664524133615,6.389411442986359,
        0.840152152177982},{84.307359657115470,21.174533750826306,
        6.411980268436992,0.843573065886157},{86.726134004965445,
        21.305832439883137,6.434687808816977,0.847006078617858},{
        89.298052645255225,21.440763800191853,6.457537857418896,
        0.850451265511744},{92.038364283034596,21.579548930296038,
        6.480534437230531,0.853908703793904},{94.965026588148092,
        21.722429035678608,6.503681822191650,0.857378472906041},{
        98.099651271544445,21.869668254286683,6.526984561549138,
        0.860860654645750},{101.469212866843510,22.021556781161863,
        6.550447508473278,0.864355333320771},{105.108611392323670,
        22.178415351638186,6.574075853974501,0.867862595919685},{
        109.065005486134880,22.340601002668283,6.597875168817166,
        0.871382532302410},{109.750042242080070,22.514375499939113,
        6.621849368866829,0.874915235415403},{122.164468808740280,
        22.670441678991452,6.646016608190354,0.878460801538834},{
        120.492493879440720,22.868998811452705,6.670353260952902,
        0.882019330576957},{127.651716860571530,23.050715346380404,
        6.694905768119855,0.885590923061522},{133.417901827374580,
        23.246144421955755,6.719657855196887,0.889175690895975},{
        139.724332490425070,23.449952674292600,6.744624090533837,
        0.892773744452224},{146.646067568266890,23.662885976357035,
        6.769813936652642,0.896385200660068},{154.272084490525660,
        23.885788232412818,6.795237725626818,0.900010181731173},{
        162.708903919517890,24.119617882190067,6.820906777869384,
        0.903648815653934},{172.084864641046120,24.365469173499047,
        6.846833542039902,0.907301236757100},{182.556942338038600,
        24.624596217120128,6.873031762800324,0.910967586354904},{
        194.319534415060760,24.898444814009999,6.899516681255775,
        0.914648013489756},{207.620595915041970,25.188686585937077,
        6.926305281144004,0.918342675792510},{222.788620730249990,
        25.497261589113076,6.953416591526287,0.922051740486512},{
        240.287692571162920,25.826419168838576,6.980872074207111,
        0.925775385569714},{256.799890482864780,26.185216782196846,
        7.008693832401432,0.929513801223933},{286.851617485832720,
        26.548780722767628,7.036921002156521,0.933267191524989},{
        308.757481229623580,26.973589993440147,7.065557892145567,
        0.937035776577968},{342.616615998311150,27.414357072890436,
        7.094674470820509,0.940819791613239},{381.652936748389780,
        27.901112273738025,7.124294167964932,0.944619499388744},{
        429.420511597585570,28.436458075451569,7.154472608250879,
        0.948435182728345},{488.956374804092890,29.029524488453990,
        7.185270948459126,0.952267155471084},{564.913569104604680,
        29.691719970341111,7.216763630423190,0.956115767213528},{
        662.593654854627520,30.440873759588669,7.249041648619902,
        0.959981411307655},{798.395259632387020,31.285522685311911,
        7.282225938437964,0.963864535640684},{984.858707574925800,
        32.266683177856073,7.316458408944520,0.967765657677109},{
        1240.731677732101800,33.435525835453468,7.351939105152393,
        0.971685384357021},{1599.976231716470900,34.896887003483748,
        7.388921872674265,0.975624447015660},{2129.911398579198200,
        36.824993793515745,7.427765289272872,0.979583747790001},{
        2973.337742375393600,38.358182172438710,7.458590833881339,
        0.982567188320956},{4392.068482735210600,40.182279884917335,
        7.491259295582522,0.985563285803890},{6744.182542887068800,
        43.093253924408778,7.527746112509292,0.988696515392235},{
        10586.401080300620000,48.112109166481709,7.566030993328872,
        0.991714705866086},{16414.657806854295000,54.433838984731196,
        7.598161821734584,0.993988954446224},{25171.400376638227000,
        60.516762902335024,7.622270849789598,0.995510777346757},{
        39924.646532205254000,66.237216173833630,7.642602684084054,
        0.996655475718842},{50014.862506044708000,78.880685852650700,
        7.662052700016630,0.997650144001249},{94512.909959942233000,
        91.545289401322989,7.683298623696445,0.998570741182521},{
        85789.631197521958000,106.331709600833660,7.693152458218265,
        0.998955116981272},{96484.149392753985000,110.551277570634270,
        7.697526525177595,0.999109011318793},{155745.736499270020000,
        114.483229466648910,7.704504194463604,0.999340021303733},{
        187336.117221347780000,124.858748457008220,7.710990375742048,
        0.999545993761771},{1561441.955568452100000,93.976965631416093,
        7.718432905786972,0.999752147562480},{12254471.880229050000000,-14.883471920491438,
        7.722448708901911,0.999855298039152},{-840729689.033797860000000,
        5473.418677569786300,7.715971952179429,0.999906892844623}};
    constant Real[Ninterval, 4] dltcoef={{-7.119202491756649e-001,-2.739402377062618e-001,
        -1.927672596844717e+000,3.108234546713844e+000},{-7.187746754592991e-001,
        -2.753459585506838e-001,-1.928038361308511e+000,3.106950869117843e+000},
        {-7.267169555982382e-001,-2.765215049130652e-001,-1.928347041349235e+000,
        3.105872508783626e+000},{-7.359380114100472e-001,-2.792612028934110e-001,
        -1.929054601531175e+000,3.103417366473884e+000},{-7.451596984095644e-001,
        -2.820546952208173e-001,-1.929773991238450e+000,3.100944868392513e+000},
        {-7.543868380432980e-001,-2.849025526846495e-001,-1.930505474697466e+000,
        3.098454883787075e+000},{-7.636195252102033e-001,-2.878055700919983e-001,
        -1.931249367470398e+000,3.095947126307967e+000},{-7.728608352753940e-001,
        -2.907644204639990e-001,-1.932005961304827e+000,3.093421411830454e+000},
        {-7.821138534967362e-001,-2.937798575560094e-001,-1.932775569789591e+000,
        3.090877503680519e+000},{-7.913807227613616e-001,-2.968525969010559e-001,
        -1.933558497589903e+000,3.088315215846500e+000},{-8.006644142147472e-001,
        -2.999834307075162e-001,-1.934355071871375e+000,3.085734309672668e+000},
        {-8.099668105946853e-001,-3.031731138060267e-001,-1.935165610880807e+000,
        3.083134597151535e+000},{-8.192918853252418e-001,-3.064225359625613e-001,
        -1.935990472438392e+000,3.080515785796513e+000},{-8.286413378736912e-001,
        -3.097325618705826e-001,-1.936830006147945e+000,3.077877633663473e+000},
        {-8.380195338699306e-001,-3.131039924173268e-001,-1.937684552795189e+000,
        3.075219949428117e+000},{-8.474270870580881e-001,-3.165378097414413e-001,
        -1.938554494310329e+000,3.072542437056092e+000},{-8.568696991541474e-001,
        -3.200348522413296e-001,-1.939440187491448e+000,3.069844902846438e+000},
        {-8.663006219851039e-001,-3.235963509846717e-001,-1.940342031243627e+000,
        3.067127048225000e+000},{-8.755969029666063e-001,-3.272238814054915e-001,
        -1.941260416087275e+000,3.064388625095321e+000},{-8.847451895324255e-001,
        -3.309187279025791e-001,-1.942195741563215e+000,3.061629384019479e+000},
        {-8.937320642447604e-001,-3.346053531802966e-001,-1.943129242827890e+000,
        3.058904739456490e+000},{-9.025917571346555e-001,-3.381523238866969e-001,
        -1.944028228246023e+000,3.056307824467905e+000},{-9.114372727199264e-001,
        -3.417348650176046e-001,-1.944936739647034e+000,3.053709701944858e+000},
        {-9.202705051593279e-001,-3.453529129795982e-001,-1.945854872015144e+000,
        3.051110359095721e+000},{-9.290943179147365e-001,-3.490064060917521e-001,
        -1.946782720180552e+000,3.048509783002059e+000},{-9.379113035378066e-001,
        -3.526952951802167e-001,-1.947720378827961e+000,3.045907960618840e+000},
        {-9.467220586520030e-001,-3.564195514784557e-001,-1.948667942508438e+000,
        3.043304878774594e+000},{-9.555308122884657e-001,-3.601791344616129e-001,
        -1.949625505711145e+000,3.040700524171566e+000},{-9.643382215985582e-001,
        -3.639740319079109e-001,-1.950593162835531e+000,3.038094883385813e+000},
        {-9.731477743382022e-001,-3.678042249680064e-001,-1.951571008256408e+000,
        3.035487942867281e+000},{-9.819604804460426e-001,-3.716697186165744e-001,
        -1.952559136308239e+000,3.032879688939842e+000},{-9.907792924725812e-001,
        -3.755705130003580e-001,-1.953557641352945e+000,3.030270107801308e+000},
        {-9.996061903488108e-001,-3.795066236033756e-001,-1.954566617769396e+000,
        3.027659185523410e+000},{-1.008442332217312e+000,-3.834780801466576e-001,
        -1.955586159975327e+000,3.025046908051736e+000},{-1.017291187118612e+000,
        -3.874849056387030e-001,-1.956616362486219e+000,3.022433261205659e+000},
        {-1.026154224708753e+000,-3.915271430094308e-001,-1.957657319899389e+000,
        3.019818230678225e+000},{-1.035032728246099e+000,-3.956048454200966e-001,
        -1.958709126923303e+000,3.017201802035997e+000},{-1.043929801274928e+000,
        -3.997180632397729e-001,-1.959771878421853e+000,3.014583960718895e+000},
        {-1.052846917422804e+000,-4.038668640643446e-001,-1.960845669410642e+000,
        3.011964692039990e+000},{-1.061785874617104e+000,-4.080513211658256e-001,
        -1.961930595091244e+000,3.009343981185274e+000},{-1.070749281155416e+000,
        -4.122715113299520e-001,-1.963026750875285e+000,3.006721813213400e+000},
        {-1.079738284824320e+000,-4.165275287976867e-001,-1.964134232385564e+000,
        3.004098173055395e+000},{-1.088755056537119e+000,-4.208194669364273e-001,
        -1.965253135509263e+000,3.001473045514344e+000},{-1.097802354172137e+000,
        -4.251474262252926e-001,-1.966383556395710e+000,2.998846415265045e+000},
        {-1.106880826500578e+000,-4.295115260316672e-001,-1.967525591470941e+000,
        2.996218266853638e+000},{-1.115992785290996e+000,-4.339118828275575e-001,
        -1.968679337486387e+000,2.993588584697207e+000},{-1.125140601947682e+000,
        -4.383486216067864e-001,-1.969844891518973e+000,2.990957353083350e+000},
        {-1.134325959887290e+000,-4.428218781489602e-001,-1.971022350993147e+000,
        2.988324556169727e+000},{-1.143550497239480e+000,-4.473317957093480e-001,
        -1.972211813704686e+000,2.985690177983577e+000},{-1.152816353482765e+000,
        -4.518785235407696e-001,-1.973413377839173e+000,2.983054202421210e+000},
        {-1.162124575492226e+000,-4.564622237902882e-001,-1.974627141987564e+000,
        2.980416613247473e+000},{-1.171478417504371e+000,-4.610830531229002e-001,
        -1.975853205189499e+000,2.977777394095186e+000},{-1.180878493083438e+000,
        -4.657411912857257e-001,-1.977091666913681e+000,2.975136528464554e+000},
        {-1.190327393133407e+000,-4.704368136453667e-001,-1.978342627116694e+000,
        2.972493999722552e+000},{-1.199826475242167e+000,-4.751701105286942e-001,
        -1.979606186233481e+000,2.969849791102279e+000},{-1.209378307645038e+000,
        -4.799412725128706e-001,-1.980882445220469e+000,2.967203885702293e+000},
        {-1.218983781081318e+000,-4.847505072639017e-001,-1.982171505551098e+000,
        2.964556266485916e+000},{-1.228645580953087e+000,-4.895980192041626e-001,
        -1.983473469263982e+000,2.961906916280511e+000},{-1.238364766758997e+000,
        -4.944840304122741e-001,-1.984788438951109e+000,2.959255817776730e+000},
        {-1.248143707380005e+000,-4.994087621624195e-001,-1.986116517808350e+000,
        2.956602953527749e+000},{-1.257984483464209e+000,-5.043724445474235e-001,
        -1.987457809637882e+000,2.953948305948456e+000},{-1.267888763237574e+000,
        -5.093753175730373e-001,-1.988812418869192e+000,2.951291857314631e+000},
        {-1.277858155074884e+000,-5.144176299820401e-001,-1.990180450575876e+000,
        2.948633589762087e+000},{-1.287894587132058e+000,-5.194996353591673e-001,
        -1.991562010506334e+000,2.945973485285792e+000},{-1.297999978447886e+000,
        -5.246215949107307e-001,-1.992957205097942e+000,2.943311525738964e+000},
        {-1.308176257926076e+000,-5.297837777066512e-001,-1.994366141495533e+000,
        2.940647692832132e+000},{-1.318425322007352e+000,-5.349864596992644e-001,
        -1.995788927575479e+000,2.937981968132178e+000},{-1.328749277117991e+000,
        -5.402299243599632e-001,-1.997225671960814e+000,2.935314333061348e+000},
        {-1.339149199599445e+000,-5.455144676665747e-001,-1.998676484040282e+000,
        2.932644768896240e+000},{-1.349628368224229e+000,-5.508403810419320e-001,
        -2.000141474006426e+000,2.929973256766762e+000},{-1.360187219274824e+000,
        -5.562079806971391e-001,-2.001620752838174e+000,2.927299777655058e+000},
        {-1.370828781127042e+000,-5.616175744949384e-001,-2.003114432369282e+000,
        2.924624312394423e+000},{-1.381554684130381e+000,-5.670694862446681e-001,
        -2.004622625272832e+000,2.921946841668168e+000},{-1.392367149953658e+000,
        -5.725640441787859e-001,-2.006145445098469e+000,2.919267346008476e+000},
        {-1.403267693522663e+000,-5.781015902025207e-001,-2.007683006276334e+000,
        2.916585805795218e+000},{-1.414258411895148e+000,-5.836824691160817e-001,
        -2.009235424161747e+000,2.913902201254752e+000},{-1.425341560697221e+000,
        -5.893070331970658e-001,-2.010802815044349e+000,2.911216512458685e+000},
        {-1.436518650340928e+000,-5.949756469199823e-001,-2.012385296164895e+000,
        2.908528719322610e+000},{-1.447792531093776e+000,-6.006886752803999e-001,
        -2.013982985751103e+000,2.905838801604813e+000},{-1.459164304671427e+000,
        -6.064465023213990e-001,-2.015596003013732e+000,2.903146738904952e+000},
        {-1.470637134656586e+000,-6.122495073552353e-001,-2.017224468204838e+000,
        2.900452510662714e+000},{-1.482211863834624e+000,-6.180980925227824e-001,
        -2.018868502597047e+000,2.897756096156425e+000},{-1.493891852120214e+000,
        -6.239926530648990e-001,-2.020528228550773e+000,2.895057474501652e+000},
        {-1.505678096610527e+000,-6.299336067257686e-001,-2.022203769494007e+000,
        2.892356624649756e+000},{-1.517574031346761e+000,-6.359213660358718e-001,
        -2.023895249984035e+000,2.889653525386434e+000},{-1.529580796468173e+000,
        -6.419563650573666e-001,-2.025602795693617e+000,2.886948155330209e+000},
        {-1.541701356804014e+000,-6.480390354850254e-001,-2.027326533467826e+000,
        2.884240492930909e+000},{-1.553937356952073e+000,-6.541698276740846e-001,
        -2.029066591313422e+000,2.881530516468101e+000},{-1.566290954997507e+000,
        -6.603491961874959e-001,-2.030823098450255e+000,2.878818204049505e+000},
        {-1.578765461793385e+000,-6.665775985380139e-001,-2.032596185332172e+000,
        2.876103533609368e+000},{-1.591361479469684e+000,-6.728555174296306e-001,
        -2.034385983640837e+000,2.873386482906806e+000},{-1.604083053178186e+000,
        -6.791834242424827e-001,-2.036192626363599e+000,2.870667029524126e+000},
        {-1.616931466226678e+000,-6.855618163240326e-001,-2.038016247762119e+000,
        2.867945150865093e+000},{-1.629909893369509e+000,-6.919911893411197e-001,
        -2.039856983439587e+000,2.865220824153184e+000},{-1.643020022349849e+000,
        -6.984720579442955e-001,-2.041714970334005e+000,2.862494026429801e+000},
        {-1.656264551293298e+000,-7.050049397229221e-001,-2.043590346770784e+000,
        2.859764734552450e+000},{-1.669646268624311e+000,-7.115903625664921e-001,
        -2.045483252474063e+000,2.857032925192886e+000},{-1.683167576151129e+000,
        -7.182288656970074e-001,-2.047393828594889e+000,2.854298574835218e+000},
        {-1.696831423652399e+000,-7.249209956676710e-001,-2.049322217741730e+000,
        2.851561659773992e+000},{-1.710639128268257e+000,-7.316673198056414e-001,
        -2.051268563987778e+000,2.848822156112223e+000},{-1.724594742236566e+000,
        -7.384683987028911e-001,-2.053233012939716e+000,2.846080039759406e+000},
        {-1.738700069789140e+000,-7.453248180187038e-001,-2.055215711717725e+000,
        2.843335286429471e+000},{-1.752958138408101e+000,-7.522371655871375e-001,
        -2.057216809020459e+000,2.840587871638726e+000},{-1.767371569680276e+000,
        -7.592060430135096e-001,-2.059236455133438e+000,2.837837770703736e+000},
        {-1.781943384385722e+000,-7.662320613766317e-001,-2.061274801963785e+000,
        2.835084958739185e+000},{-1.796676013498676e+000,-7.733158456018825e-001,
        -2.063332003066546e+000,2.832329410655683e+000},{-1.811572772917376e+000,
        -7.804580273271474e-001,-2.065408213682221e+000,2.829571101157551e+000},
        {-1.826636048726881e+000,-7.876592550863618e-001,-2.067503590753522e+000,
        2.826810004740544e+000},{-1.841869688783150e+000,-7.949201807533446e-001,
        -2.069618292975332e+000,2.824046095689560e+000},{-1.857275569898410e+000,
        -8.022414792244761e-001,-2.071752480798810e+000,2.821279348076279e+000},
        {-1.872858144207920e+000,-8.096238224870805e-001,-2.073906316498295e+000,
        2.818509735756786e+000},{-1.888619059956391e+000,-8.170679126024469e-001,
        -2.076079964156223e+000,2.815737232369135e+000},{-1.904561956423886e+000,
        -8.245744503054575e-001,-2.078273589745324e+000,2.812961811330880e+000},
        {-1.920690668385609e+000,-8.321441499275529e-001,-2.080487361132164e+000,
        2.810183445836552e+000},{-1.937007416473138e+000,-8.397777468295377e-001,
        -2.082721448109063e+000,2.807402108855102e+000},{-1.953516633870803e+000,
        -8.474759771845204e-001,-2.084976022451227e+000,2.804617773127296e+000},
        {-1.970220662325402e+000,-8.552396029642130e-001,-2.087251257918434e+000,
        2.801830411163055e+000},{-1.987123236442702e+000,-8.630693899925094e-001,
        -2.089547330324482e+000,2.799039995238766e+000},{-2.004228350601878e+000,
        -8.709661185707598e-001,-2.091864417548962e+000,2.796246497394527e+000},
        {-2.021538725971305e+000,-8.789305897778639e-001,-2.094202699573659e+000,
        2.793449889431357e+000},{-2.039058367884046e+000,-8.869636101217421e-001,
        -2.096562358541322e+000,2.790650142908356e+000},{-2.056791020141507e+000,
        -8.950660040405472e-001,-2.098943578769776e+000,2.787847229139806e+000},
        {-2.074740298046955e+000,-9.032386105028429e-001,-2.101346546799721e+000,
        2.785041119192230e+000},{-2.092910200608639e+000,-9.114822800669383e-001,
        -2.103771451439775e+000,2.782231783881398e+000},{-2.111304179015425e+000,
        -9.197978847153946e-001,-2.106218483783340e+000,2.779419193769277e+000},
        {-2.129926301106460e+000,-9.281863059214009e-001,-2.108687837277904e+000,
        2.776603319160936e+000},{-2.148780529001271e+000,-9.366484426859110e-001,
        -2.111179707746509e+000,2.773784130101387e+000},{-2.167870835137651e+000,
        -9.451852095934209e-001,-2.113694293436472e+000,2.770961596372379e+000},
        {-2.187201600827261e+000,-9.537975352704542e-001,-2.116231795062518e+000,
        2.768135687489128e+000},{-2.206776744200663e+000,-9.624863678682748e-001,
        -2.118792415842629e+000,2.765306372697000e+000},{-2.226600913877821e+000,
        -9.712526682985949e-001,-2.121376361551813e+000,2.762473620968124e+000},
        {-2.246678099895653e+000,-9.800974184540910e-001,-2.123983840556277e+000,
        2.759637400997960e+000},{-2.267012600006316e+000,-9.890216163020363e-001,
        -2.126615063865472e+000,2.756797681201793e+000},{-2.287609020074218e+000,
        -9.980262753763182e-001,-2.129270245181486e+000,2.753954429711178e+000},
        {-2.308472981636114e+000,-1.007112421979191e+000,-2.131949600945738e+000,
        2.751107614370312e+000},{-2.329607982655612e+000,-1.016281113082512e+000,
        -2.134653350367198e+000,2.748257202732345e+000},{-2.351019199384163e+000,
        -1.025533415332722e+000,-2.137381715498646e+000,2.745403162055640e+000},
        {-2.372711351753493e+000,-1.034870417426487e+000,-2.140134921268429e+000,
        2.742545459299940e+000},{-2.394689420941603e+000,-1.044293225304602e+000,
        -2.142913195543392e+000,2.739684061122500e+000},{-2.416958489696154e+000,
        -1.053802964837059e+000,-2.145716769171991e+000,2.736818933874121e+000},
        {-2.439523927931083e+000,-1.063400781249023e+000,-2.148545876038628e+000,
        2.733950043595136e+000},{-2.462390547826898e+000,-1.073087842531493e+000,
        -2.151400753117987e+000,2.731077356011314e+000},{-2.485563955690444e+000,
        -1.082865334488783e+000,-2.154281640529923e+000,2.728200836529693e+000},
        {-2.509049754370408e+000,-1.092734464087250e+000,-2.157188781596602e+000,
        2.725320450234344e+000},{-2.532853214807481e+000,-1.102696462282614e+000,
        -2.160122422893467e+000,2.722436161882056e+000},{-2.556980090750864e+000,
        -1.112752579055204e+000,-2.163082814316411e+000,2.719547935897943e+000},
        {-2.581436437132852e+000,-1.122904087457842e+000,-2.166070209130614e+000,
        2.716655736370978e+000},{-2.606227654816659e+000,-1.133152285306878e+000,
        -2.169084864037961e+000,2.713759527049444e+000},{-2.631360439576148e+000,
        -1.143498488007834e+000,-2.172127039239977e+000,2.710859271336302e+000},
        {-2.656840304856598e+000,-1.153944042779445e+000,-2.175196998484420e+000,
        2.707954932284481e+000},{-2.682673341601513e+000,-1.164490316871617e+000,
        -2.178295009149678e+000,2.705046472592083e+000},{-2.708866825204242e+000,
        -1.175138696975488e+000,-2.181421342304900e+000,2.702133854597497e+000},
        {-2.735426422726402e+000,-1.185890604592462e+000,-2.184576272760956e+000,
        2.699217040274428e+000},{-2.762359314107140e+000,-1.196747478763960e+000,
        -2.187760079160614e+000,2.696295991226843e+000},{-2.789671673506554e+000,
        -1.207710791213431e+000,-2.190973044027281e+000,2.693370668683814e+000},
        {-2.817371158194170e+000,-1.218782032275562e+000,-2.194215453856300e+000,
        2.690441033494273e+000},{-2.845464441688514e+000,-1.229962726999865e+000,
        -2.197487599162562e+000,2.687507046121677e+000},{-2.873958455587959e+000,
        -1.241254426116775e+000,-2.200789774573439e+000,2.684568666638566e+000},
        {-2.902860980914899e+000,-1.252658706018288e+000,-2.204122278897234e+000,
        2.681625854721035e+000},{-2.932179792788460e+000,-1.264177171262446e+000,
        -2.207485415203479e+000,2.678678569643088e+000},{-2.961921972458911e+000,
        -1.275811461710634e+000,-2.210879490886982e+000,2.675726770270900e+000},
        {-2.992095784809014e+000,-1.287563242185971e+000,-2.214304817763162e+000,
        2.672770415056979e+000},{-3.022708807675713e+000,-1.299434212241244e+000,
        -2.217761712139564e+000,2.669809462034204e+000},{-3.053769494827838e+000,
        -1.311426099021429e+000,-2.221250494908468e+000,2.666843868809768e+000},
        {-3.085286256712582e+000,-1.323540662532576e+000,-2.224771491625306e+000,
        2.663873592558999e+000},{-3.117267156964171e+000,-1.335779699224753e+000,
        -2.228325032589873e+000,2.660898590019072e+000},{-3.149721717942327e+000,
        -1.348145031420924e+000,-2.231911452951636e+000,2.657918817482606e+000},
        {-3.182657768442030e+000,-1.360638526376643e+000,-2.235531092775834e+000,
        2.654934230791132e+000},{-3.216085761856677e+000,-1.373262071886569e+000,
        -2.239184297168944e+000,2.651944785328451e+000},{-3.250013826855947e+000,
        -1.386017607184507e+000,-2.242871416329658e+000,2.648950436013852e+000},
        {-3.284451500134391e+000,-1.398907099420707e+000,-2.246592805684378e+000,
        2.645951137295225e+000},{-3.319409250572173e+000,-1.411932549809613e+000,
        -2.250348825973040e+000,2.642946843142023e+000},{-3.354896753611417e+000,
        -1.425096003296100e+000,-2.254139843338936e+000,2.639937507038096e+000},
        {-3.390924039417435e+000,-1.438399542162570e+000,-2.257966229444829e+000,
        2.636923081974400e+000},{-3.427501254566009e+000,-1.451845290352722e+000,
        -2.261828361566645e+000,2.633903520441551e+000},{-3.464639359689941e+000,
        -1.465435408601526e+000,-2.265726622713691e+000,2.630878774422248e+000},
        {-3.502349053636324e+000,-1.479172101786477e+000,-2.269661401730241e+000,
        2.627848795383550e+000},{-3.540641220590683e+000,-1.493057617817210e+000,
        -2.273633093408675e+000,2.624813534268998e+000},{-3.579527769324496e+000,
        -1.507094243675857e+000,-2.277642098611021e+000,2.621772941490594e+000},
        {-3.619019405104672e+000,-1.521284319088120e+000,-2.281688824370349e+000,
        2.618726966920613e+000},{-3.659128845786773e+000,-1.535630218848213e+000,
        -2.285773684035279e+000,2.615675559883270e+000},{-3.699868104366120e+000,
        -1.550134370620169e+000,-2.289897097369691e+000,2.612618669146215e+000},
        {-3.741248903588338e+000,-1.564799252976718e+000,-2.294059490683182e+000,
        2.609556242911866e+000},{-3.783284874324993e+000,-1.579627382536116e+000,
        -2.298261296982422e+000,2.606488228808574e+000},{-3.825988545927405e+000,
        -1.594621335053040e+000,-2.302502956067142e+000,2.603414573881602e+000},
        {-3.869373496014526e+000,-1.609783731499074e+000,-2.306784914694967e+000,
        2.600335224583944e+000},{-3.913453221956383e+000,-1.625117249152555e+000,
        -2.311107626695294e+000,2.597250126766952e+000},{-3.958241447222634e+000,
        -1.640624618733666e+000,-2.315471553123667e+000,2.594159225670774e+000},
        {-4.003752472151792e+000,-1.656308622508239e+000,-2.319877162411532e+000,
        2.591062465914611e+000},{-4.050001634221138e+000,-1.672172096388015e+000,
        -2.324324930505149e+000,2.587959791486772e+000},{-4.097002876636228e+000,
        -1.688217943259190e+000,-2.328815341006177e+000,2.584851145734526e+000},
        {-4.144772509543070e+000,-1.704449112223655e+000,-2.333348885357084e+000,
        2.581736471353761e+000},{-4.193325486276812e+000,-1.720868623261894e+000,
        -2.337926062964376e+000,2.578615710378421e+000},{-4.242678130201291e+000,
        -1.737479551563644e+000,-2.342547381387367e+000,2.575488804169740e+000},
        {-4.292847565917512e+000,-1.754285033725772e+000,-2.347213356495573e+000,
        2.572355693405246e+000},{-4.343849344050583e+000,-1.771288281606365e+000,
        -2.351924512625498e+000,2.569216318067544e+000},{-4.395701890165288e+000,
        -1.788492558606178e+000,-2.356681382789128e+000,2.566070617432879e+000},
        {-4.448422980721418e+000,-1.805901202887346e+000,-2.361484508818656e+000,
        2.562918530059439e+000},{-4.502030354716064e+000,-1.823517623449364e+000,
        -2.366334441565460e+000,2.559759993775440e+000},{-4.556542840854151e+000,
        -1.841345298947618e+000,-2.371231741081224e+000,2.556594945666951e+000},
        {-4.611979475168832e+000,-1.859387780568530e+000,-2.376176976819913e+000,
        2.553423322065466e+000},{-4.668359753577363e+000,-1.877648695147924e+000,
        -2.381170727826738e+000,2.550245058535221e+000},{-4.725704074969167e+000,
        -1.896131743036145e+000,-2.386213582948206e+000,2.547060089860238e+000},
        {-4.784032727943202e+000,-1.914840707513675e+000,-2.391306141027599e+000,
        2.543868350031094e+000},{-4.843367240144604e+000,-1.933779447928860e+000,
        -2.396449011131275e+000,2.540669772231420e+000},{-4.903729030960412e+000,
        -1.952951909731893e+000,-2.401642812755355e+000,2.537464288824098e+000},
        {-4.965140432874901e+000,-1.972362121662210e+000,-2.406888176055385e+000,
        2.534251831337176e+000},{-5.027623797901383e+000,-1.992014202447187e+000,
        -2.412185742069771e+000,2.531032330449472e+000},{-5.091203355130014e+000,
        -2.011912351777201e+000,-2.417536162974205e+000,2.527805715975873e+000},
        {-5.155903044122922e+000,-2.032060866670441e+000,-2.422940102297541e+000,
        2.524571916852306e+000},{-5.221747451923521e+000,-2.052464137830248e+000,
        -2.428398235181793e+000,2.521330861120394e+000},{-5.288761616135504e+000,
        -2.073126654030853e+000,-2.433911248632754e+000,2.518082475911771e+000},
        {-5.356971788598320e+000,-2.094052999648703e+000,-2.439479841788043e+000,
        2.514826687432050e+000},{-5.426404613215012e+000,-2.115247861646304e+000,
        -2.445104726181699e+000,2.511563420944447e+000},{-5.497087522474739e+000,
        -2.136716031186819e+000,-2.450786626016956e+000,2.508292600753025e+000},
        {-5.569049288882915e+000,-2.158462403870986e+000,-2.456526278452476e+000,
        2.505014150185588e+000},{-5.642317740633977e+000,-2.180491994108471e+000,
        -2.462324433881294e+000,2.501727991576171e+000},{-5.716923840072115e+000,
        -2.202809915912630e+000,-2.468181856254582e+000,2.498434046247153e+000},
        {-5.792897745374091e+000,-2.225421410091371e+000,-2.474099323354432e+000,
        2.495132234490956e+000},{-5.870270221041334e+000,-2.248331836268295e+000,
        -2.480077627130501e+000,2.491822475551335e+000},{-5.949074871981971e+000,
        -2.271546665967843e+000,-2.486117574029875e+000,2.488504687604241e+000},
        {-6.029343786707989e+000,-2.295071511647872e+000,-2.492219985295749e+000,
        2.485178787738241e+000},{-6.111112084568413e+000,-2.318912101810149e+000,
        -2.498385697352468e+000,2.481844691934497e+000},{-6.194414527198641e+000,
        -2.343074305694364e+000,-2.504615562124872e+000,2.478502315046275e+000},
        {-6.279286904596403e+000,-2.367564130914826e+000,-2.510910447403784e+000,
        2.475151570777977e+000},{-6.365767209259786e+000,-2.392387718285614e+000,
        -2.517271237235579e+000,2.471792371663692e+000},{-6.453892994198572e+000,
        -2.417551362201253e+000,-2.523698832280891e+000,2.468424629045237e+000},
        {-6.543704169328149e+000,-2.443061498363987e+000,-2.530194150230223e+000,
        2.465048253049680e+000},{-6.635241010728419e+000,-2.468924721455782e+000,
        -2.536758126185958e+000,2.461663152566336e+000},{-6.728545843224950e+000,
        -2.495147778765465e+000,-2.543391713097591e+000,2.458269235223206e+000},
        {-6.823660845563034e+000,-2.521737588158918e+000,-2.550095882171187e+000,
        2.454866407362863e+000},{-6.920630794798460e+000,-2.548701226486825e+000,
        -2.556871623333734e+000,2.451454574017748e+000},{-7.019501381475465e+000,
        -2.576045946160612e+000,-2.563719945667194e+000,2.448033638884867e+000},
        {-7.120319480255796e+000,-2.603779178381579e+000,-2.570641877882507e+000,
        2.444603504299888e+000},{-7.223133969609193e+000,-2.631908532839725e+000,
        -2.577638468809950e+000,2.441164071210579e+000},{-7.327994580174460e+000,
        -2.660441811671938e+000,-2.584710787882002e+000,2.437715239149616e+000},
        {-7.434952494647915e+000,-2.689387012530814e+000,-2.591859925646200e+000,
        2.434256906206702e+000},{-7.544061135790023e+000,-2.718752328646964e+000,
        -2.599086994305352e+000,2.430788968999999e+000},{-7.655375515661243e+000,
        -2.748546159812257e+000,-2.606393128252138e+000,2.427311322646844e+000},
        {-7.768951708993694e+000,-2.778777123466263e+000,-2.613779484621389e+000,
        2.423823860733729e+000},{-7.884848282627553e+000,-2.809454050978603e+000,
        -2.621247243887760e+000,2.420326475285515e+000},{-8.003125847080343e+000,
        -2.840586000686433e+000,-2.628797610445466e+000,2.416819056733866e+000},
        {-8.123845717615904e+000,-2.872182270696010e+000,-2.636431813223878e+000,
        2.413301493884877e+000},{-8.247072986653183e+000,-2.904252390209657e+000,
        -2.644151106340080e+000,2.409773673885860e+000},{-8.372873324207069e+000,
        -2.936806146623549e+000,-2.651956769727907e+000,2.406235482191265e+000},
        {-8.501315321522739e+000,-2.969853579297517e+000,-2.659850109837497e+000,
        2.402686802527732e+000},{-8.632470179999418e+000,-3.003404992656809e+000,
        -2.667832460322147e+000,2.399127516858195e+000},{-8.766410786955008e+000,
        -3.037470967875636e+000,-2.675905182763388e+000,2.395557505345058e+000},
        {-8.903213411118998e+000,-3.072062364995864e+000,-2.684069667421548e+000,
        2.391976646312385e+000},{-9.042955255058262e+000,-3.107190347094537e+000,
        -2.692327333987842e+000,2.388384816207067e+000},{-9.185717838632552e+000,
        -3.142866369671718e+000,-2.700679632411345e+000,2.384781889558960e+000},
        {-9.331585097693958e+000,-3.179102204446007e+000,-2.709128043701907e+000,
        2.381167738939921e+000},{-9.480643607373500e+000,-3.215909949936703e+000,
        -2.717674080783783e+000,2.377542234921738e+000},{-9.632982569905030e+000,
        -3.253302040635393e+000,-2.726319289385702e+000,2.373905246032896e+000},
        {-9.788696395803125e+000,-3.291291246777491e+000,-2.735065248964523e+000,
        2.370256638714140e+000},{-9.947880046656847e+000,-3.329890716053707e+000,
        -2.743913573608185e+000,2.366596277272798e+000},{-1.011063370599249e+001,
        -3.369113955782007e+000,-2.752865913065797e+000,2.362924023835830e+000},
        {-1.027706158128749e+001,-3.408974858849373e+000,-2.761923953732860e+000,
        2.359239738301529e+000},{-1.044726980264801e+001,-3.449487728026834e+000,
        -2.771089419696060e+000,2.355543278289857e+000},{-1.062137120153357e+001,
        -3.490667263098932e+000,-2.780364073859961e+000,2.351834499091345e+000},
        {-1.079948025851573e+001,-3.532528610310817e+000,-2.789749719020175e+000,
        2.348113253614504e+000},{-1.098171707046586e+001,-3.575087353790894e+000,
        -2.799248199077059e+000,2.344379392331725e+000},{-1.116820588443619e+001,
        -3.618359541657062e+000,-2.808861400235142e+000,2.340632763223555e+000},
        {-1.135907707782098e+001,-3.662361694756724e+000,-2.818591252274326e+000,
        2.336873211721342e+000},{-1.155446370525415e+001,-3.707110846632381e+000,
        -2.828439729829784e+000,2.333100580648148e+000},{-1.175450638810228e+001,
        -3.752624533595280e+000,-2.838408853794547e+000,2.329314710157896e+000},
        {-1.195935053540618e+001,-3.798920836053745e+000,-2.848500692695762e+000,
        2.325515437672646e+000},{-1.216914587843163e+001,-3.846018400646425e+000,
        -2.858717364169532e+000,2.321702597817966e+000},{-1.238405202330118e+001,
        -3.893936434232603e+000,-2.869061036519223e+000,2.317876022356294e+000},
        {-1.260423031369346e+001,-3.942694775750631e+000,-2.879533930237916e+000,
        2.314035540118215e+000},{-1.282985291483982e+001,-3.992313868676216e+000,
        -2.890138319734129e+000,2.310180976931594e+000},{-1.306109620929062e+001,
        -4.042814830660411e+000,-2.900876534982684e+000,2.306312155548434e+000},
        {-1.329814643430201e+001,-4.094219444695344e+000,-2.911750963375111e+000,
        2.302428895569415e+000},{-1.354119627426263e+001,-4.146550213873349e+000,
        -2.922764051537747e+000,2.298531013365968e+000},{-1.379044740846033e+001,
        -4.199830379609585e+000,-2.933918307290487e+000,2.294618321999826e+000},
        {-1.404610889345345e+001,-4.254083961469080e+000,-2.945216301668451e+000,
        2.290690631139917e+000},{-1.430840142757132e+001,-4.309335770863983e+000,
        -2.956660671054686e+000,2.286747746976495e+000},{-1.457755349316863e+001,
        -4.365611471997627e+000,-2.968254119347887e+000,2.282789472132388e+000},
        {-1.485380456670902e+001,-4.422937601107329e+000,-2.979999420291443e+000,
        2.278815605571237e+000},{-1.513740534264527e+001,-4.481341609033519e+000,
        -2.991899419865233e+000,2.274825942502599e+000},{-1.542861733910674e+001,
        -4.540851908926687e+000,-3.003957038785516e+000,2.270820274283760e+000},
        {-1.572771438306834e+001,-4.601497912391182e+000,-3.016175275142619e+000,
        2.266798388318140e+000},{-1.603498363566405e+001,-4.663310074910363e+000,
        -3.028557207138266e+000,2.262760067950089e+000},{-1.635072484269092e+001,
        -4.726319953306938e+000,-3.041105995942990e+000,2.258705092355959e+000},
        {-1.667525327132274e+001,-4.790560243365801e+000,-3.053824888716676e+000,
        2.254633236431245e+000},{-1.700889813746121e+001,-4.856064846889706e+000,
        -3.066717221736760e+000,2.250544270673617e+000},{-1.735200585595545e+001,
        -4.922868920071202e+000,-3.079786423691872e+000,2.246437961061666e+000},
        {-1.770493843523546e+001,-4.991008942657080e+000,-3.093036019134606e+000,
        2.242314068929141e+000},{-1.806807798479443e+001,-5.060522765468733e+000,
        -3.106469632112602e+000,2.238172350834463e+000},{-1.844182350134685e+001,
        -5.131449703543621e+000,-3.120090989928735e+000,2.234012558425291e+000},
        {-1.882659593895549e+001,-5.203830582698908e+000,-3.133903927164026e+000,
        2.229834438297898e+000},{-1.922283720003022e+001,-5.277707832656685e+000,
        -3.147912389827138e+000,2.225637731851087e+000},{-1.963101137194863e+001,
        -5.353125565238721e+000,-3.162120439758187e+000,2.221422175134389e+000},
        {-2.005160793417239e+001,-5.430129651245946e+000,-3.176532259252670e+000,
        2.217187498690242e+000},{-2.048514159347870e+001,-5.508767821782203e+000,
        -3.191152155899943e+000,2.212933427389840e+000},{-2.093215458382820e+001,
        -5.589089761522009e+000,-3.205984567694959e+000,2.208659680262342e+000},
        {-2.139321785013910e+001,-5.671147213614056e+000,-3.221034068411279e+000,
        2.204365970317081e+000},{-2.186893386429054e+001,-5.754994082273456e+000,
        -3.236305373268270e+000,2.200052004358388e+000},{-2.235993893520058e+001,
        -5.840686550619682e+000,-3.251803344885138e+000,2.195717482792680e+000},
        {-2.286690183868918e+001,-5.928283224318049e+000,-3.267532999536663e+000,
        2.191362099427353e+000},{-2.339053129045003e+001,-6.017845229047717e+000,
        -3.283499513835679e+000,2.186985541261074e+000},{-2.393157553110568e+001,
        -6.109436372639191e+000,-3.299708231679054e+000,2.182587488264950e+000},
        {-2.449082365362512e+001,-6.203123298466807e+000,-3.316164671630298e+000,
        2.178167613154133e+000},{-2.506911261829099e+001,-6.298975620761307e+000,
        -3.332874534743562e+000,2.173725581149273e+000},{-2.566732526965500e+001,
        -6.397066125615121e+000,-3.349843712746693e+000,2.169261049727270e+000},
        {-2.628639811323098e+001,-6.497470921823482e+000,-3.367078296797307e+000,
        2.164773668360732e+000},{-2.692732173142186e+001,-6.600269655973709e+000,
        -3.384584586646084e+000,2.160263078245440e+000},{-2.759114524502430e+001,
        -6.705545710843315e+000,-3.402369100397087e+000,2.155728912015202e+000},
        {-2.827898248761451e+001,-6.813386415478488e+000,-3.420438584828478e+000,
        2.151170793443279e+000},{-2.899201259869876e+001,-6.923883300413103e+000,
        -3.438800026289747e+000,2.146588337129650e+000},{-2.973148847503503e+001,
        -7.037132326714247e+000,-3.457460662309122e+000,2.141981148173250e+000},
        {-3.049873840109150e+001,-7.153234177647235e+000,-3.476427993824973e+000,
        2.137348821828268e+000},{-3.129517493940490e+001,-7.272294522510483e+000,
        -3.495709798247626e+000,2.132690943143583e+000},{-3.212229765000851e+001,
        -7.394424343175200e+000,-3.515314143246334e+000,2.128007086584252e+000},
        {-3.298170177292683e+001,-7.519740249452365e+000,-3.535249401439987e+000,
        2.123296815633989e+000},{-3.387508454061701e+001,-7.648364836976240e+000,
        -3.555524265971750e+000,2.118559682377430e+000},{-3.480425051048727e+001,
        -7.780427073933807e+000,-3.576147767071773e+000,2.113795227060935e+000},
        {-3.577112387256164e+001,-7.916062682686504e+000,-3.597129289704889e+000,
        2.109002977630553e+000},{-3.677775248212046e+001,-8.055414602783463e+000,
        -3.618478592274180e+000,2.104182449245703e+000},{-3.782632044661916e+001,
        -8.198633436873966e+000,-3.640205826613887e+000,2.099333143767018e+000},
        {-3.891915659162862e+001,-8.345877962293837e+000,-3.662321559229458e+000,
        2.094454549216663e+000},{-4.005874745570689e+001,-8.497315658007004e+000,
        -3.684836793965542e+000,2.089546139209324e+000},{-4.124774609923581e+001,
        -8.653123302578791e+000,-3.707762996136288e+000,2.084607372351954e+000},
        {-4.248898846355697e+001,-8.813487578187926e+000,-3.731112118317829e+000,
        2.079637691610172e+000},{-4.378550526414175e+001,-8.978605753438103e+000,
        -3.754896627843079e+000,2.074636523639093e+000},{-4.514053901757636e+001,
        -9.148686395755780e+000,-3.779129536196960e+000,2.069603278076170e+000},
        {-4.655756027868422e+001,-9.323950155855000e+000,-3.803824430401465e+000,
        2.064537346793447e+000},{-4.804028430092423e+001,-9.504630615340995e+000,
        -3.828995506585277e+000,2.059438103106440e+000},{-4.959269431334278e+001,
        -9.690975174726935e+000,-3.854657605931726e+000,2.054304900936606e+000},
        {-5.121906225977325e+001,-9.883246042911827e+000,-3.880826253119925e+000,
        2.049137073924143e+000},{-5.292396969033102e+001,-1.008172131188975e+001,
        -3.907517697516740e+000,2.043933934487611e+000},{-5.471233926943821e+001,
        -1.028669607165458e+001,-3.934748957389588e+000,2.038694772826543e+000},
        {-5.658946080723199e+001,-1.049848367280677e+001,-3.962537867252546e+000,
        2.033418855862916e+000},{-5.856102198737246e+001,-1.071741707506913e+001,
        -3.990903128739948e+000,2.028105426117049e+000},{-6.063314629294836e+001,
        -1.094385028946904e+001,-4.019864365275073e+000,2.022753700513037e+000},
        {-6.281242946118387e+001,-1.117815997880301e+001,-4.049442180792742e+000,
        2.017362869108480e+000},{-6.510598207265966e+001,-1.142074718300361e+001,
        -4.079658222944135e+000,2.011932093742810e+000},{-6.752147690312931e+001,
        -1.167203919014480e+001,-4.110535251172350e+000,2.006460506597967e+000},
        {-7.006720223331806e+001,-1.193249157665400e+001,-4.142097210058299e+000,
        2.000947208664683e+000},{-7.275211711338568e+001,-1.220259045397827e+001,
        -4.174369308405988e+000,1.995391268106987e+000},{-7.558591731733223e+001,
        -1.248285489197702e+001,-4.207378104671925e+000,1.989791718516892e+000},
        {-7.857910654055216e+001,-1.277383958744936e+001,-4.241151599238290e+000,
        1.984147557050459e+000},{-8.174307486950895e+001,-1.307613778749139e+001,
        -4.275719334227814e+000,1.978457742435633e+000},{-8.509018865469528e+001,
        -1.339038448212000e+001,-4.311112501590751e+000,1.972721192841308e+000},
        {-8.863388899758650e+001,-1.371725992427822e+001,-4.347364060230715e+000,
        1.966936783596048e+000},{-9.238880450061555e+001,-1.405749348404934e+001,
        -4.384508863125920e+000,1.961103344743806e+000},{-9.638803576032707e+001,
        -1.441179912568236e+001,-4.422583856657013e+000,1.955219658422624e+000},
        {-1.006355886419617e+002,-1.478104683078891e+001,-4.461628093181375e+000,
        1.949284456050977e+000},{-1.051313454597849e+002,-1.516621147525332e+001,
        -4.501682994351671e+000,1.943296415304725e+000},{-1.098726320850258e+002,
        -1.557562130758561e+001,-4.543476494807336e+000,1.937154374999355e+000},
        {-1.148328382566474e+002,-1.599730363449987e+001,-4.585776601560153e+000,
        1.931045251398180e+000},{-1.200188108246691e+002,-1.643068297329990e+001,
        -4.628499471591676e+000,1.924981823573037e+000},{-1.254402600577610e+002,
        -1.687609306545174e+001,-4.671650064463239e+000,1.918963711773316e+000},
        {-1.311072854774274e+002,-1.733387495899903e+001,-4.715233405571223e+000,
        1.912990539037578e+000},{-1.370304007377400e+002,-1.780437708974399e+001,
        -4.759254580973940e+000,1.907061931185782e+000},{-1.432205478371830e+002,
        -1.828795544632071e+001,-4.803718732234705e+000,1.901177516818668e+000},
        {-1.496891184999602e+002,-1.878497370717625e+001,-4.848631051484921e+000,
        1.895336927323218e+000},{-1.564479780964446e+002,-1.929580338699566e+001,
        -4.893996776657341e+000,1.889539796883510e+000},{-1.635094896114932e+002,
        -1.982082401614414e+001,-4.939821186869632e+000,1.883785762496075e+000},
        {-1.708865276896965e+002,-2.036042337835779e+001,-4.986109598005116e+000,
        1.878074463988980e+000},{-1.785925165319611e+002,-2.091499764565038e+001,
        -5.032867358670587e+000,1.872405544044007e+000},{-1.866414510420746e+002,
        -2.148495164496683e+001,-5.080099846220948e+000,1.866778648221036e+000},
        {-1.950479162106498e+002,-2.207069912489180e+001,-5.127812463129048e+000,
        1.861193424984080e+000},{-2.038271353278870e+002,-2.267266292380108e+001,
        -5.176010633724887e+000,1.855649525728495e+000},{-2.129949758145855e+002,
        -2.329127536217849e+001,-5.224699800985325e+000,1.850146604808510e+000},
        {-2.225680072626292e+002,-2.392697840643329e+001,-5.273885423907177e+000,
        1.844684319564753e+000},{-2.325635046039472e+002,-2.458022411269052e+001,
        -5.323572974870670e+000,1.839262330351306e+000},{-2.429995182741653e+002,
        -2.525147478994882e+001,-5.373767937627715e+000,1.833880300561732e+000},
        {-2.538948748098448e+002,-2.594120350769362e+001,-5.424475805224988e+000,
        1.828537896653741e+000},{-2.652692415314800e+002,-2.664989431255637e+001,
        -5.475702078602022e+000,1.823234788172320e+000},{-2.771431560702175e+002,
        -2.737804267118220e+001,-5.527452265174031e+000,1.817970647770634e+000},
        {-2.895380660742452e+002,-2.812615585599748e+001,-5.579731877863270e+000,
        1.812745151228864e+000},{-3.024763750171533e+002,-2.889475333428489e+001,
        -5.632546434409225e+000,1.807557977470461e+000},{-3.159814902028902e+002,
        -2.968436718887993e+001,-5.685901456916128e+000,1.802408808575871e+000},
        {-3.300778700110466e+002,-3.049554255611214e+001,-5.739802471693491e+000,
        1.797297329793238e+000},{-3.447910678389576e+002,-3.132883810210219e+001,
        -5.794255009340000e+000,1.792223229546456e+000},{-3.601477887192862e+002,
        -3.218482647037611e+001,-5.849264605126227e+000,1.787186199439965e+000},
        {-3.761759502852180e+002,-3.306409475164691e+001,-5.904836799592490e+000,
        1.782185934260666e+000},{-3.929047215975117e+002,-3.396724504852546e+001,
        -5.960977139338727e+000,1.777222131976677e+000},{-4.103646058482501e+002,
        -3.489489490975335e+001,-6.017691178152736e+000,1.772294493733011e+000},
        {-4.285874676385886e+002,-3.584767798721607e+001,-6.074984478170861e+000,
        1.767402723844187e+000},{-4.476066601835161e+002,-3.682624437371988e+001,
        -6.132862611514633e+000,1.762546529783868e+000},{-4.674570002533873e+002,
        -3.783126149387554e+001,-6.191331161679662e+000,1.757725622171409e+000},
        {-4.881749356184829e+002,-3.886341433245930e+001,-6.250395725677553e+000,
        1.752939714755772e+000},{-5.097985523417300e+002,-3.992340630042679e+001,
        -6.310061915750649e+000,1.748188524396310e+000},{-5.323676746229096e+002,
        -4.101195973874807e+001,-6.370335361660072e+000,1.743471771041181e+000},
        {-5.559239469182820e+002,-4.212981655933941e+001,-6.431221712923479e+000,
        1.738789177703054e+000},{-5.805109168157189e+002,-4.327773889908156e+001,
        -6.492726641214050e+000,1.734140470432367e+000},{-6.061741146091180e+002,
        -4.445650981673200e+001,-6.554855842839679e+000,1.729525378288342e+000},
        {-6.329602015454766e+002,-4.566693587314825e+001,-6.617615040532088e+000,
        1.724943633307832e+000},{-6.609250424371172e+002,-4.690982976130863e+001,
        -6.681009994698973e+000,1.720394970472067e+000},{-6.901042593869157e+002,
        -4.818608458142636e+001,-6.745046467541486e+000,1.715879127671711e+000},
        {-7.205706164247110e+002,-4.949651492478494e+001,-6.809730323163137e+000,
        1.711395845671781e+000},{-7.523401581588573e+002,-5.084211154381994e+001,
        -6.875067360429169e+000,1.706944868064385e+000},{-7.854200256589894e+002,
        -5.222382897866345e+001,-6.941063483168687e+000,1.702525941248357e+000},
        {-8.210353457106370e+002,-5.364030461686616e+001,-7.007725542909286e+000,
        1.698138814375824e+000},{-8.554766922517680e+002,-5.510143617018551e+001,
        -7.075055206156207e+000,1.693783239359508e+000},{-8.945408949715370e+002,
        -5.659285841589260e+001,-7.143067888804235e+000,1.689458970942078e+000},
        {-9.336319987298878e+002,-5.812951993780914e+001,-7.211759170575077e+000,
        1.685165765209987e+000},{-9.748070167487797e+002,-5.970600021779582e+001,
        -7.281141145128838e+000,1.680903383115732e+000},{-1.017797161099866e+003,
        -6.132462116161106e+001,-7.351218688149022e+000,1.676671586493826e+000},
        {-1.062683684456890e+003,-6.298650584026640e+001,-7.421998074872098e+000,
        1.672470140103473e+000},{-1.109551487921742e+003,-6.469280936461375e+001,
        -7.493485645708336e+000,1.668298811149195e+000},{-1.158489280848639e+003,
        -6.644471976211437e+001,-7.565687809091735e+000,1.664157369235286e+000},
        {-1.209589622929883e+003,-6.824345904605310e+001,-7.638611044176486e+000,
        1.660045586320429e+000},{-1.262949116295308e+003,-7.009028388353097e+001,
        -7.712261903592744e+000,1.655963236672332e+000},{-1.318668341934761e+003,
        -7.198648673326566e+001,-7.786647015696424e+000,1.651910096822905e+000},
        {-1.378234074012758e+003,-7.393131086849101e+001,-7.861773788109874e+000,
        1.647885945523818e+000},{-1.442265174772427e+003,-7.592462610887877e+001,
        -7.937649607034357e+000,1.643890563702867e+000},{-1.511481571183503e+003,
        -7.796562144522292e+001,-8.014283223597630e+000,1.639923734421354e+000},
        {-1.586722725865685e+003,-8.026846357280738e+001,-8.098960584225544e+000,
        1.635617913591073e+000},{-1.668825233579326e+003,-8.268094464949859e+001,
        -8.186167899408106e+000,1.631266166750611e+000},{-1.751894172577563e+003,
        -8.522351785771092e+001,-8.276024876610972e+000,1.626867109373032e+000},
        {-1.847472908821830e+003,-8.787922432899295e+001,-8.368677996958821e+000,
        1.622419288010019e+000},{-1.946491084587533e+003,-9.068266529460510e+001,
        -8.464253729359603e+000,1.617921174006821e+000},{-2.053978412575095e+003,
        -9.363129093939379e+001,-8.562915811238364e+000,1.613371162616998e+000},
        {-2.169922983260752e+003,-9.673869964576350e+001,-8.664826684394154e+000,
        1.608767561543369e+000},{-2.295197216249843e+003,-1.000170527865890e+002,
        -8.770163821231140e+000,1.604108587787459e+000},{-2.430785442417563e+003,
        -1.034797311140764e+002,-8.879118505262669e+000,1.599392359891713e+000},
        {-2.577801026632838e+003,-1.071414867500088e+002,-8.991897240203381e+000,
        1.594616890192578e+000},{-2.737506932622896e+003,-1.110186171022473e+002,
        -9.108723338184889e+000,1.589780076274507e+000},{-2.911339732177706e+003,
        -1.151291662320393e+002,-9.229838713457117e+000,1.584879691522251e+000},
        {-3.100938315519513e+003,-1.194931571822090e+002,-9.355505914598652e+000,
        1.579913374653328e+000},{-3.308178313364557e+003,-1.241328611774950e+002,
        -9.486010432931598e+000,1.574878618093619e+000},{-3.535213086559769e+003,
        -1.290731114786262e+002,-9.621663331956111e+000,1.569772755037022e+000},
        {-3.784523337361933e+003,-1.343416691601648e+002,-9.762804252286623e+000,
        1.564592945003904e+000},{-4.058976804769223e+003,-1.399696522448835e+002,
        -9.909804855879647e+000,1.559336157681449e+000},{-4.361900810987743e+003,
        -1.459920399445989e+002,-1.006307278746745e+001,1.553999154791511e+000},
        {-4.697170408589283e+003,-1.524482682241805e+002,-1.022305624605249e+001,
        1.548578469686142e+000},{-5.069316087288656e+003,-1.593829353173996e+002,
        -1.039024927974076e+001,1.543070384316234e+000},{-5.483655244797968e+003,
        -1.668466418498926e+002,-1.056519794058328e+001,1.537470903152320e+000},
        {-5.946453353590173e+003,-1.748969941438437e+002,-1.074850746706512e+001,
        1.531775723555805e+000},{-6.470411734157407e+003,-1.835913253448870e+002,
        -1.094085372023932e+001,1.525980202000237e+000},{-7.043187071142154e+003,
        -1.930474897871591e+002,-1.114297042220280e+001,1.520079315421806e+000},
        {-7.711933761545253e+003,-2.032681531837435e+002,-1.135574068537159e+001,
        1.514067616830629e+000},{-8.457541572806047e+003,-2.144378352863221e+002,
        -1.158005302355428e+001,1.507939179287543e+000},{-9.310061797401568e+003,
        -2.266315901380780e+002,-1.181700489705569e+001,1.501687551187454e+000},
        {-1.028612055393173e+004,-2.399941811640263e+002,-1.206779207559716e+001,
        1.495305668348962e+000},{-1.140941135333577e+004,-2.546856980795141e+002,
        -1.233378335486043e+001,1.488785783609071e+000},{-1.270936879154894e+004,
        -2.708950151984197e+002,-1.261654223773738e+001,1.482119368890722e+000},
        {-1.422287401592777e+004,-2.888462620691078e+002,-1.291786359692049e+001,
        1.475297002040697e+000},{-1.599657041959849e+004,-3.088070502047960e+002,
        -1.323981906420460e+001,1.468308231964111e+000},{-1.809004382910636e+004,
        -3.310990266311976e+002,-1.358481369182558e+001,1.461141416796625e+000},
        {-2.058025235609896e+004,-3.561115228088582e+002,-1.395565733388563e+001,
        1.453783528293291e+000},{-2.356778164825942e+004,-3.843193794845403e+002,
        -1.435565545638336e+001,1.446219913491735e+000},{-2.718581393635035e+004,
        -4.163064498517156e+002,-1.478872591139304e+001,1.438434001794348e+000},
        {-3.161318342772590e+004,-4.527969315541988e+002,-1.525955085475275e+001,
        1.430406941556335e+000},{-3.710725880796295e+004,-4.946758410121437e+002,
        -1.577378467014829e+001,1.422117144536678e+000},{-4.396402756633394e+004,
        -5.431789342797099e+002,-1.633827036775515e+001,1.413539708353296e+000},
        {-5.273878604465988e+004,-5.996007772929380e+002,-1.696157367093251e+001,
        1.404645675124891e+000},{-6.407490165878369e+004,-6.659850765960473e+002,
        -1.765417026519191e+001,1.395401054361457e+000},{-7.904776202793667e+004,
        -7.447144090654609e+002,-1.842951853955794e+001,1.385765574728270e+000},
        {-9.926766194745344e+004,-8.390379482241829e+002,-1.930485080869606e+001,
        1.375690927154873e+000},{-1.273095825071022e+005,-9.532400246900349e+002,
        -2.030280355373593e+001,1.365118418615304e+000},{-1.674562138620607e+005,
        -1.092995537492447e+003,-2.145377509289186e+001,1.353975640846269e+000},
        {-2.272198539857275e+005,-1.265667878999013e+003,-2.279974485733070e+001,
        1.342171664024869e+000},{-3.205446595310491e+005,-1.480352798561740e+003,
        -2.440067528762999e+001,1.329589871746868e+000},{-4.757004171335059e+005,
        -1.745534398035771e+003,-2.634638501786641e+001,1.316076873033058e+000},
        {-7.277874286905073e+005,-2.104072122532931e+003,-2.876388941251714e+001,
        1.301424533021810e+000},{-1.158269327743195e+006,-2.638285390348861e+003,
        -3.185184183947293e+001,1.285339230723633e+000},{-1.959002083113540e+006,
        -3.532523254029535e+003,-3.592185311796366e+001,1.267385221467623e+000},
        {-3.596005342715708e+006,-3.892843755514912e+003,-4.023498447113133e+001,
        1.252292339125201e+000},{-7.337307110377396e+006,-3.598464703219049e+003,
        -4.636507095266333e+001,1.235307228164419e+000},{-1.605717610482991e+007,
        -3.192373063618026e+003,-5.564203153249309e+001,1.214800598771303e+000},
        {-3.619723757401069e+007,-6.348690590601902e+003,-6.892252303788369e+001,
        1.191007390096094e+000},{-8.251938353183653e+007,-1.344847387729171e+004,
        -8.574522926416114e+001,1.168783843757871e+000},{-2.040599684077241e+008,
        -1.069786567964125e+004,-1.061289066146439e+002,1.150438269719548e+000},
        {-5.121867096552509e+008,1.456135255074863e+004,-1.331224976907382e+002,
        1.133590960463892e+000},{-1.208283139664454e+009,1.667633657013471e+004,
        -1.694988472006016e+002,1.115407413029604e+000},{-2.713573785229895e+009,
        -2.376510051574436e+005,-2.229542789125316e+002,1.093221801784601e+000},
        {-5.496859099556583e+009,-4.498406556454219e+005,-2.698490407608527e+002,
        1.081141798451352e+000},{-1.281003550443853e+010,-1.454397978181947e+005,
        -3.068797733762085e+002,1.075521362860637e+000},{-3.803997568288454e+010,
        7.244080350807136e+005,-3.862216588136204e+002,1.065839017041407e+000},
        {-1.282594878189864e+011,3.702125120753230e+006,-5.256416986606254e+002,
        1.055309382343471e+000},{-4.144936674091608e+011,2.980984288420191e+006,
        -6.792080235153045e+002,1.041458768913244e+000},{-8.964984509224136e+011,
        -5.905430282043110e+006,-8.516642522807352e+002,1.031926967645291e+000},
        {-7.355836465490852e+015,4.518177895310270e+010,-6.933068977626010e+004,
        1.025706312840203e+000}};
    constant Real[Ninterval, 4] dvtcoef={{3.665200884480820e-001,
        3.768263375039013e-002,2.190792329657455e-003,5.503960828374045e-005},{
        3.740100562223658e-001,3.839687254278058e-002,2.241470067816089e-003,
        5.651517998086539e-005},{3.828499115332361e-001,3.899054527468819e-002,
        2.284797395124333e-003,5.778081864475580e-005},{3.933222065720126e-001,
        4.041224383597725e-002,2.385959187504062e-003,6.075322570198209e-005},{
        4.040330124879073e-001,4.188279732592867e-002,2.491507351266832e-003,
        6.387796804156671e-005},{4.149858832885122e-001,4.340369917802586e-002,
        2.601623832550185e-003,6.716271877677985e-005},{4.261843979498587e-001,
        4.497658031312836e-002,2.716504756553497e-003,7.061574208320139e-005},{
        4.376320460159308e-001,4.660304907537514e-002,2.836349505162887e-003,
        7.424557939372635e-005},{4.493322760556361e-001,4.828479016768840e-002,
        2.961367887534022e-003,7.806127539077438e-005},{4.612885541291512e-001,
        5.002349607708437e-002,3.091775532306176e-003,8.207225038864295e-005},{
        4.735043599311913e-001,5.182093843609277e-002,3.227799262656286e-003,
        8.628847726670128e-005},{4.859830663248401e-001,5.367889630080813e-002,
        3.369672145850532e-003,9.072034242183301e-005},{4.987281155931236e-001,
        5.559927072115295e-002,3.517642230639391e-003,9.537893269130447e-005},{
        5.117427716648794e-001,5.758397405257353e-002,3.671964680832330e-003,
        1.002758063548368e-004},{5.250302993025363e-001,5.963492463599265e-002,
        3.832901617045873e-003,1.054230003569787e-004},{5.385939624651210e-001,
        6.175417109476790e-002,4.000731818279412e-003,1.108333568850559e-004},{
        5.524368943414315e-001,6.394372783418179e-002,4.175738556303638e-003,
        1.165201514339943e-004},{5.664900425757722e-001,6.620605134392597e-002,
        4.358222679301490e-003,1.224975427286338e-004},{5.805583121436652e-001,
        6.854424938506180e-002,4.548492850733371e-003,1.287802891593489e-004},{
        5.946086214220634e-001,7.096102605514981e-002,4.746869857737302e-003,
        1.353838849828342e-004},{6.086065747191686e-001,7.340678828072091e-002,
        4.949478977042500e-003,1.421827481986982e-004},{6.225914771181178e-001,
        7.579030259624107e-002,5.148953763370412e-003,1.489285080947021e-004},{
        6.367315613084956e-001,7.822925272680593e-002,5.354873479106979e-003,
        1.559450852216557e-004},{6.510248604875336e-001,8.072426859544872e-002,
        5.567387089688100e-003,1.632411903229065e-004},{6.654693630800921e-001,
        8.327597242098897e-002,5.786645233200854e-003,1.708257343021365e-004},{
        6.800630053891468e-001,8.588497856777670e-002,6.012800199529966e-003,
        1.787078304444174e-004},{6.948036854574047e-001,8.855189328122257e-002,
        6.246005909138952e-003,1.868967966091155e-004},{7.096892568246661e-001,
        9.127731455960417e-002,6.486417891145978e-003,1.954021573940052e-004},{
        7.247175349874265e-001,9.406183194968448e-002,6.734193261069997e-003,
        2.042336462698481e-004},{7.398863032918654e-001,9.690602637057491e-002,
        6.989490698063166e-003,2.134012076848844e-004},{7.551933077292230e-001,
        9.981047000578269e-002,7.252470421664215e-003,2.229149991386050e-004},{
        7.706362681974270e-001,1.027757261083910e-001,7.523294168294181e-003,
        2.327853932242564e-004},{7.862128763870087e-001,1.058023489048649e-001,
        7.802125167244362e-003,2.430229796396210e-004},{8.019208000233606e-001,
        1.088908834647968e-001,8.089128116419406e-003,2.536385671655344e-004},{
        8.177576857661010e-001,1.120418655935747e-001,8.384469157748138e-003,
        2.646431856117704e-004},{8.337211625135900e-001,1.152558217345552e-001,
        8.688315852326128e-003,2.760480877298891e-004},{8.498088435549523e-001,
        1.185332688891191e-001,9.000837155310458e-003,2.878647510927008e-004},{
        8.660183298445744e-001,1.218747145409911e-001,9.322203390615966e-003,
        3.001048799400485e-004},{8.823472121350809e-001,1.252806565984050e-001,
        9.652586225422304e-003,3.127804069906578e-004},{8.987930767579581e-001,
        1.287515833300165e-001,9.992158644551460e-003,3.259034952198205e-004},{
        9.153535027634360e-001,1.322879733585061e-001,1.034109492467412e-002,
        3.394865396027454e-004},{9.320260723490239e-001,1.358902955896432e-001,
        1.069957060853094e-002,3.535421688234263e-004},{9.488083651027407e-001,
        1.395590092481384e-001,1.106776247896205e-002,3.680832469489624e-004},{
        9.656979703504189e-001,1.432945638174619e-001,1.144584853306668e-002,
        3.831228750692304e-004},{9.826924805368605e-001,1.470973991054695e-001,
        1.183400795620025e-002,3.986743929019505e-004},{9.997894997984816e-001,
        1.509679452225744e-001,1.223242109616551e-002,4.147513803631108e-004},{
        1.016986646503764e+000,1.549066226184312e-001,1.264126943736927e-002,
        4.313676591028885e-004},{1.034281553150528e+000,1.589138421395006e-001,
        1.306073557508202e-002,4.485372940071116e-004},{1.051671869872525e+000,
        1.629900050717103e-001,1.349100318986285e-002,4.662745946644320e-004},{
        1.069155270937662e+000,1.671355031844444e-001,1.393225702213025e-002,
        4.845941167994041e-004},{1.086729447284750e+000,1.713507188579044e-001,
        1.438468284683222e-002,5.035106636716927e-004},{1.104392125557418e+000,
        1.756360250733073e-001,1.484846744851311e-002,5.230392874416344e-004},{
        1.122141050214495e+000,1.799917856279029e-001,1.532379859632389e-002,
        5.431952905025172e-004},{1.139974004762330e+000,1.844183551212992e-001,
        1.581086501965071e-002,5.639942267798111e-004},{1.157888800935349e+000,
        1.889160791550389e-001,1.630985638370746e-002,5.854519029978606e-004},{
        1.175883287892217e+000,1.934852944091692e-001,1.682096326567359e-002,
        6.075843799142949e-004},{1.193955352468680e+000,1.981263287911221e-001,
        1.734437713105463e-002,6.304079735227150e-004},{1.212102920438635e+000,
        2.028395015817585e-001,1.788029031044544e-002,6.539392562240593e-004},{
        1.230323959893689e+000,2.076251235778936e-001,1.842889597669781e-002,
        6.781950579671869e-004},{1.248616484149628e+000,2.124834972498307e-001,
        1.899038812248679e-002,7.031924673592142e-004},{1.266978553097518e+000,
        2.174149169184600e-001,1.956496153830370e-002,7.289488327461666e-004},{
        1.285408269937146e+000,2.224196689540113e-001,2.015281179091836e-002,
        7.554817632645458e-004},{1.303903795153633e+000,2.274980318933519e-001,
        2.075413520241562e-002,7.828091298644555e-004},{1.322463336930379e+000,
        2.326502767088909e-001,2.136912882953291e-002,8.109490663049821e-004},{
        1.341085156891751e+000,2.378766669763421e-001,2.199799044372205e-002,
        8.399199701224019e-004},{1.359767575223034e+000,2.431774590683698e-001,
        2.264091851168786e-002,8.697405035720730e-004},{1.378508965237237e+000,
        2.485529024112762e-001,2.329811217643337e-002,9.004295945446784e-004},{
        1.397307764139623e+000,2.540032396549401e-001,2.396977123901983e-002,
        9.320064374575882e-004},{1.416162464351274e+000,2.595287069634087e-001,
        2.465609614076989e-002,9.644904941221798e-004},{1.435071623389463e+000,
        2.651295341966611e-001,2.535728794626573e-002,9.979014945878779e-004},{
        1.454033862914496e+000,2.708059451751824e-001,2.607354832685021e-002,
        1.032259437963822e-003},{1.473047868841412e+000,2.765581579370460e-001,
        2.680507954482812e-002,1.067584593218963e-003},{1.492112386818882e+000,
        2.823863850138245e-001,2.755208443834308e-002,1.103897499961510e-003},{
        1.511226244667304e+000,2.882908335802246e-001,2.831476640706065e-002,
        1.141218969198648e-003},{1.530388322738662e+000,2.942717059001999e-001,
        2.909332939819350e-002,1.179570084077442e-003},{1.549597582529973e+000,
        3.003291994252179e-001,2.988797789375669e-002,1.218972200607816e-003},{
        1.568853054060884e+000,3.064635071695984e-001,3.069891689809663e-002,
        1.259446948368720e-003},{1.588153834283365e+000,3.126748179903948e-001,
        3.152635192639908e-002,1.301016231198290e-003},{1.607499102743188e+000,
        3.189633167940680e-001,3.237048899399019e-002,1.343702227869144e-003},{
        1.626888102366270e+000,3.253291849447598e-001,3.323153460615338e-002,
        1.387527392749791e-003},{1.646320164489830e+000,3.317726004172473e-001,
        3.410969574909326e-002,1.432514456453111e-003},{1.665794682688201e+000,
        3.382937382564183e-001,3.500517988125847e-002,1.478686426473104e-003},{
        1.685311138825627e+000,3.448927707221959e-001,3.591819492593865e-002,
        1.526066587810795e-003},{1.704869084047406e+000,3.515698677202811e-001,
        3.684894926422587e-002,1.574678503590567e-003},{1.724468158770434e+000,
        3.583251969986714e-001,3.779765172916720e-002,1.624546015667824e-003},{
        1.744108067700997e+000,3.651589246073122e-001,3.876451160038527e-002,
        1.675693245229228e-003},{1.763788610501295e+000,3.720712150319988e-001,
        3.974973859999501e-002,1.728144593386518e-003},{1.783509661384779e+000,
        3.790622316554051e-001,4.075354288886299e-002,1.781924741765163e-003},{
        1.803271169098520e+000,3.861321370576751e-001,4.177613506405691e-002,
        1.837058653088839e-003},{1.823073183620778e+000,3.932810932079064e-001,
        4.281772615719370e-002,1.893571571760980e-003},{1.842915816106496e+000,
        4.005092620304885e-001,4.387852763320605e-002,1.951489024444566e-003},{
        1.862799271892769e+000,4.078168055176666e-001,4.495875139067014e-002,
        2.010836820641158e-003},{1.882723840320363e+000,4.152038861479577e-001,
        4.605860976245487e-002,2.071641053270659e-003},{1.902689896843988e+000,
        4.226706672139174e-001,4.717831551747944e-002,2.133928099252665e-003},{
        1.922697890394811e+000,4.302173132196612e-001,4.831808186330070e-002,
        2.197724620090751e-003},{1.942748370153087e+000,4.378439900664124e-001,
        4.947812244984428e-002,2.263057562460898e-003},{1.962841961294967e+000,
        4.455508655515563e-001,5.065865137358835e-002,2.329954158805294e-003},{
        1.982979377414200e+000,4.533381096250566e-001,5.185988318307852e-002,
        2.398441927932571e-003},{2.003161423573253e+000,4.612058947322305e-001,
        5.308203288516229e-002,2.468548675625884e-003},{2.023388978688615e+000,
        4.691543962461522e-001,5.432531595209598e-002,2.540302495259932e-003},{
        2.043663032156556e+000,4.771837926209295e-001,5.558994832988842e-002,
        2.613731768428245e-003},{2.063984632955979e+000,4.852942660390235e-001,
        5.687614644693947e-002,2.688865165581934e-003},{2.084354942844196e+000,
        4.934860024349729e-001,5.818412722451828e-002,2.765731646681043e-003},{
        2.104775202157050e+000,5.017591920850383e-001,5.951410808727019e-002,
        2.844360461860065e-003},{2.125246731719251e+000,5.101140299143760e-001,
        6.086630697524879e-002,2.924781152108464e-003},{2.145770960466568e+000,
        5.185507157095545e-001,6.224094235686584e-002,3.007023549967835e-003},{
        2.166349393201155e+000,5.270694546814225e-001,6.363823324234659e-002,
        3.091117780246803e-003},{2.186983629134377e+000,5.356704576934424e-001,
        6.505839919869993e-002,3.177094260754839e-003},{2.207675360445951e+000,
        5.443539416465710e-001,6.650166036532459e-002,3.264983703056519e-003},{
        2.228426369973906e+000,5.531201298632031e-001,6.796823747062697e-002,
        3.354817113247326e-003},{2.249238522655806e+000,5.619692524824012e-001,
        6.945835184963980e-002,3.446625792752342e-003},{2.270113792409218e+000,
        5.709015466811348e-001,7.097222546277789e-002,3.540441339149131e-003},{
        2.291054235680260e+000,5.799172572176781e-001,7.251008091513399e-002,
        3.636295647016205e-003},{2.312061997510860e+000,5.890166367384575e-001,
        7.407214147719843e-002,3.734220908808123e-003},{2.333139328790219e+000,
        5.981999460648496e-001,7.565863110647320e-002,3.834249615758862e-003},{
        2.354288566264979e+000,6.074674546965987e-001,7.726977446981624e-002,
        3.936414558814613e-003},{2.375512137218167e+000,6.168194411357968e-001,
        7.890579696711332e-002,4.040748829597290e-003},{2.396812574191011e+000,
        6.262561931938135e-001,8.056692475586602e-002,4.147285821400253e-003},{
        2.418192505865444e+000,6.357780084481650e-001,8.225338477660042e-002,
        4.256059230217468e-003},{2.439654638189181e+000,6.453851947021946e-001,
        8.396540477941994e-002,4.367103055807411e-003},{2.461201802244242e+000,
        6.550780701048645e-001,8.570321335190975e-002,4.480451602793228e-003},{
        2.482836910050617e+000,6.648569638275532e-001,8.746703994730097e-002,
        4.596139481800508e-003},{2.504562958561007e+000,6.747222163788872e-001,
        8.925711491435891e-002,4.714201610633784e-003},{2.526383089076794e+000,
        6.846741796996655e-001,9.107366952835992e-002,4.834673215493565e-003},{
        2.548300479768189e+000,6.947132181729661e-001,9.291693602203711e-002,
        4.957589832234993e-003},{2.570318477197365e+000,7.048397082466733e-001,
        9.478714761948791e-002,5.082987307669528e-003},{2.592440465382741e+000,
        7.150540396336219e-001,9.668453856884922e-002,5.210901800911450e-003},{
        2.614669982458294e+000,7.253566149948452e-001,9.860934417835919e-002,
        5.341369784769924e-003},{2.637010642561412e+000,7.357478508657601e-001,
        1.005618008515189e-001,5.474428047188929e-003},{2.659466158279287e+000,
        7.462281778772136e-001,1.025421461246414e-001,5.610113692735653e-003},{
        2.682040381265263e+000,7.567980409850534e-001,1.045506187051913e-001,
        5.748464144139502e-003},{2.704737228505560e+000,7.674579003195780e-001,
        1.065874585105618e-001,5.889517143882839e-003},{2.727560756610687e+000,
        7.782082311537123e-001,1.086529067092295e-001,6.033310755844878e-003},{
        2.750515116663080e+000,7.890495246405542e-001,1.107472057618116e-001,
        6.179883367000695e-003},{2.773604564123278e+000,7.999822881587377e-001,
        1.128705994640319e-001,6.329273689176290e-003},{2.796833481101817e+000,
        8.110070456381986e-001,1.150233329907212e-001,6.481520760861736e-003},{
        2.820206359500705e+000,8.221243381278066e-001,1.172056529406883e-001,
        6.636663949083662e-003},{2.843727786952501e+000,8.333347242992452e-001,
        1.194178073829910e-001,6.794742951338803e-003},{2.867402504168878e+000,
        8.446387806027250e-001,1.216600459047351e-001,6.955797797590129e-003},{
        2.891235314964451e+000,8.560371022382086e-001,1.239326196590929e-001,
        7.119868852327294e-003},{2.915231207685412e+000,8.675303029206455e-001,
        1.262357814161839e-001,7.286996816692764e-003},{2.939395228384068e+000,
        8.791190161294715e-001,1.285697856130808e-001,7.457222730675805e-003},{
        2.963732594119631e+000,8.908038948858174e-001,1.309348884073418e-001,
        7.630587975375205e-003},{2.988248610630383e+000,9.025856127699617e-001,
        1.333313477298497e-001,7.807134275333398e-003},{3.012948756836480e+000,
        9.144648639316437e-001,1.357594233405432e-001,7.986903700942813e-003},{
        3.037838552477580e+000,9.264423643191631e-001,1.382193768838317e-001,
        8.169938670926896e-003},{3.062923779323181e+000,9.385188509558488e-001,
        1.407114719478523e-001,8.356281954897082e-003},{3.088210210949279e+000,
        9.506950840800934e-001,1.432359741212169e-001,8.545976675988148e-003},{
        3.113703846840580e+000,9.629718461669161e-001,1.457931510558516e-001,
        8.739066313572597e-003},{3.139410816633882e+000,9.753499432105148e-001,
        1.483832725273125e-001,8.935594706057733e-003},{3.165337344775792e+000,
        9.878302053998029e-001,1.510066104981779e-001,9.135606053765535e-003},{
        3.191489836188858e+000,1.000413487150973e+000,1.536634391835181e-001,
        9.339144921898232e-003},{3.217874837362654e+000,1.013100667985528e+000,
        1.563540351164809e-001,9.546256243591650e-003},{3.244499017871583e+000,
        1.025892653177059e+000,1.590786772160487e-001,9.756985323057694e-003},{
        3.271369233348681e+000,1.038790373981308e+000,1.618376468567759e-001,
        9.971377838818435e-003},{3.298492456712199e+000,1.051794788668075e+000,
        1.646312279389412e-001,1.018947984703397e-002},{3.325875855766680e+000,
        1.064906882678220e+000,1.674597069616482e-001,1.041133778492568e-002},{
        3.353526720988624e+000,1.078127669689009e+000,1.703233730962368e-001,
        1.063699847429761e-002},{3.381452539482126e+000,1.091458191811743e+000,
        1.732225182626495e-001,1.086650912515772e-002},{3.409660934355382e+000,
        1.104899520630803e+000,1.761574372062440e-001,1.109991733944163e-002},{
        3.438159712928544e+000,1.118452757551656e+000,1.791284275774465e-001,
        1.133727111484079e-002},{3.466956886644510e+000,1.132119034446490e+000,
        1.821357900125424e-001,1.157861884873769e-002},{3.496060578876284e+000,
        1.145899514855565e+000,1.851798282158324e-001,1.182400934225040e-002},{
        3.525479158448411e+000,1.159795393897511e+000,1.882608490453275e-001,
        1.207349180438865e-002},{3.555221150625067e+000,1.173807899612132e+000,
        1.913791625981357e-001,1.232711585632465e-002},{3.585295253530584e+000,
        1.187938293517513e+000,1.945350822993449e-001,1.258493153578014e-002},{
        3.615710419947444e+000,1.202187870979279e+000,1.977289249926884e-001,
        1.284698930153326e-002},{3.646475741855814e+000,1.216557962688612e+000,
        2.009610110319655e-001,1.311334003804746e-002},{3.677600534221765e+000,
        1.231049934891233e+000,2.042316643764733e-001,1.338403506022480e-002},{
        3.709094341468303e+000,1.245665190249085e+000,2.075412126872400e-001,
        1.365912611828753e-002},{3.740966909400527e+000,1.260405168872820e+000,
        2.108899874254873e-001,1.393866540278966e-002},{3.773228176367919e+000,
        1.275271349170827e+000,2.142783239537165e-001,1.422270554976199e-002},{
        3.805888377290767e+000,1.290265248201987e+000,2.177065616394706e-001,
        1.451129964599359e-002},{3.838957884662454e+000,1.305388423503501e+000,
        2.211750439596317e-001,1.480450123445293e-002},{3.872447399709886e+000,
        1.320642472860455e+000,2.246841186100514e-001,1.510236431985103e-002},{
        3.906367799894601e+000,1.336029036255819e+000,2.282341376142729e-001,
        1.540494337435146e-002},{3.940730251550222e+000,1.351549796109007e+000,
        2.318254574376806e-001,1.571229334342844e-002},{3.975546173467691e+000,
        1.367206478594881e+000,2.354584391022789e-001,1.602446965187828e-002},{
        4.010827215553952e+000,1.383000854730738e+000,2.391334483049296e-001,
        1.634152820998645e-002},{4.046585350875875e+000,1.398934740935574e+000,
        2.428508555387394e-001,1.666352541985450e-002},{4.082832758036515e+000,
        1.415010000798975e+000,2.466110362157002e-001,1.699051818189041e-002},{
        4.119582040102078e+000,1.431228545024562e+000,2.504143707946231e-001,
        1.732256390146564e-002},{4.156845889599819e+000,1.447592334476850e+000,
        2.542612449081177e-001,1.765972049574360e-002},{4.194637505310675e+000,
        1.464103378865951e+000,2.581520494986178e-001,1.800204640068241e-002},{
        4.232970236952464e+000,1.480763740213331e+000,2.620871809503179e-001,
        1.834960057821798e-002},{4.271857846363231e+000,1.497575532404973e+000,
        2.660670412307083e-001,1.870244252362888e-002},{4.311314452870784e+000,
        1.514540923036616e+000,2.700920380312623e-001,1.906063227308990e-002},{
        4.351354365658449e+000,1.531662135547257e+000,2.741625849122226e-001,
        1.942423041141704e-002},{4.391992415882795e+000,1.548941448644654e+000,
        2.782791014540191e-001,1.979329808000918e-002},{4.433243686970854e+000,
        1.566381199477114e+000,2.824420134068151e-001,2.016789698499184e-002},{
        4.475123641314885e+000,1.583983784131202e+000,2.866517528484842e-001,
        2.054808940556589e-002},{4.517648207096858e+000,1.601751658807016e+000,
        2.909087583444591e-001,2.093393820256836e-002},{4.560833550448293e+000,
        1.619687342607780e+000,2.952134751100056e-001,2.132550682724936e-002},{
        4.604696396499985e+000,1.637793417179381e+000,2.995663551808326e-001,
        2.172285933027002e-002},{4.649253796372554e+000,1.656072529916263e+000,
        3.039678575822974e-001,2.212606037092869e-002},{4.694523265092098e+000,
        1.674527394692921e+000,3.084184485074046e-001,2.253517522661828e-002},{
        4.740522712955659e+000,1.693160794008574e+000,3.129186014966691e-001,
        2.295026980252321e-002},{4.787270576136158e+000,1.711975580058748e+000,
        3.174687976240633e-001,2.337141064156014e-002},{4.834785712163620e+000,
        1.730974677253755e+000,3.220695256857244e-001,2.379866493456965e-002},{
        4.883087485591644e+000,1.750161083541156e+000,3.267212823955581e-001,
        2.423210053076392e-002},{4.932195710571193e+000,1.769537872699258e+000,
        3.314245725842074e-001,2.467178594843879e-002},{4.982130846586524e+000,
        1.789108195340259e+000,3.361799094048092e-001,2.511779038595532e-002},{
        5.032913690335282e+000,1.808875282735387e+000,3.409878145406674e-001,
        2.557018373299858e-002},{5.084565761601779e+000,1.828842446624347e+000,
        3.458488184239917e-001,2.602903658212011e-002},{5.137109093797749e+000,
        1.849013082945023e+000,3.507634604540620e-001,2.649442024057316e-002},{
        5.190566200241511e+000,1.869390674036088e+000,3.557322892248459e-001,
        2.696640674244556e-002},{5.244960447391115e+000,1.889978789056404e+000,
        3.607558627598103e-001,2.744506886110065e-002},{5.300315503010739e+000,
        1.910781089611307e+000,3.658347487465493e-001,2.793048012193356e-002},{
        5.356655984977632e+000,1.931801328375829e+000,3.709695247877092e-001,
        2.842271481544970e-002},{5.414006939214302e+000,1.953043355008492e+000,
        3.761607786475629e-001,2.892184801067763e-002},{5.472394280173591e+000,
        1.974511116073609e+000,3.814091085150813e-001,2.942795556892076e-002},{
        5.531844552982697e+000,1.996208659464594e+000,3.867151232667687e-001,
        2.994111415786121e-002},{5.592384986946350e+000,2.018140136745433e+000,
        3.920794427409197e-001,3.046140126602264e-002},{5.654043699138815e+000,
        2.040309805072126e+000,3.975026980190738e-001,3.098889521760342e-002},{
        5.716849502278652e+000,2.062722031519653e+000,4.029855317122437e-001,
        3.152367518768998e-002},{5.780832066643861e+000,2.085381295218880e+000,
        4.085285982589873e-001,3.206582121785987e-002},{5.846021876769548e+000,
        2.108292190975333e+000,4.141325642292472e-001,3.261541423218720e-002},{
        5.912450295234973e+000,2.131459432255390e+000,4.197981086381419e-001,
        3.317253605366047e-002},{5.980149653199785e+000,2.154887854369196e+000,
        4.255259232680015e-001,3.373726942102519e-002},{6.049153080922429e+000,
        2.178582419018171e+000,4.313167129985944e-001,3.430969800606264e-002},{
        6.119494843356140e+000,2.202548216154015e+000,4.371711961503690e-001,
        3.488990643131756e-002},{6.191210090835239e+000,2.226790469534412e+000,
        4.430901048323289e-001,3.547798028828864e-002},{6.264335024681378e+000,
        2.251314539600350e+000,4.490741853049658e-001,3.607400615609312e-002},{
        6.338906985205288e+000,2.276125927352816e+000,4.551241983514239e-001,
        3.667807162062186e-002},{6.414964364223934e+000,2.301230279236725e+000,
        4.612409196589499e-001,3.729026529419736e-002},{6.492546755911735e+000,
        2.326633390771490e+000,4.674251402137614e-001,3.791067683575024e-002},{
        6.571694919608382e+000,2.352341211514662e+000,4.736776667056718e-001,
        3.853939697152988e-002},{6.652450889812159e+000,2.378359849304511e+000,
        4.799993219463535e-001,3.917651751636464e-002},{6.734857960020156e+000,
        2.404695575420992e+000,4.863909452991119e-001,3.982213139548871e-002},{
        6.818960762407748e+000,2.431354829314535e+000,4.928533931226813e-001,
        4.047633266695239e-002},{6.904805348414572e+000,2.458344223655918e+000,
        4.993875392280697e-001,4.113921654463405e-002},{6.992439181126046e+000,
        2.485670550059953e+000,5.059942753490215e-001,4.181087942187155e-002},{
        7.081911236169231e+000,2.513340784316515e+000,5.126745116281625e-001,
        4.249141889573267e-002},{7.173272004697938e+000,2.541362092459206e+000,
        5.194291771172804e-001,4.318093379194453e-002},{7.266573617083629e+000,
        2.569741836357898e+000,5.262592202942233e-001,4.387952419050236e-002},{
        7.361869906936396e+000,2.598487580031925e+000,5.331656095952206e-001,
        4.458729145197930e-002},{7.459216347534869e+000,2.627607096681667e+000,
        5.401493339641285e-001,4.530433824455851e-002},{7.558670349451412e+000,
        2.657108374111654e+000,5.472114034211771e-001,4.603076857181219e-002},{
        7.660291079236791e+000,2.686999623211421e+000,5.543528496461990e-001,
        4.676668780125031e-002},{7.764139728783404e+000,2.717289283930944e+000,
        5.615747265851068e-001,4.751220269366371e-002},{7.870279478141036e+000,
        2.747986033541306e+000,5.688781110727400e-001,4.826742143328870e-002},{
        7.978775648099929e+000,2.779098793974625e+000,5.762641034782924e-001,
        4.903245365881855e-002},{8.089695695459456e+000,2.810636740433291e+000,
        5.837338283705550e-001,4.980741049529092e-002},{8.203109430764046e+000,
        2.842609309100674e+000,5.912884352069108e-001,5.059240458687938e-002},{
        8.319088992819991e+000,2.875026206633575e+000,5.989290990433451e-001,
        5.138755013061993e-002},{8.437709001965207e+000,2.907897418922941e+000,
        6.066570212701816e-001,5.219296291110302e-002},{8.559046630712071e+000,
        2.941233220726810e+000,6.144734303718776e-001,5.300876033616472e-002},{
        8.683181769475304e+000,2.975044185275829e+000,6.223795827131393e-001,
        5.383506147361033e-002},{8.810197102877758e+000,3.009341194858236e+000,
        6.303767633513405e-001,5.467198708900607e-002},{8.940178073287749e+000,
        3.044135452087358e+000,6.384662868774791e-001,5.551965968457501e-002},{
        9.073213421245114e+000,3.079438488879136e+000,6.466494982886871e-001,
        5.637820353923723e-002},{9.209394871242861e+000,3.115262180887050e+000,
        6.549277738848125e-001,5.724774474983270e-002},{9.348817398676971e+000,
        3.151618758416641e+000,6.633025222039423e-001,5.812841127356715e-002},{
        9.491579474545942e+000,3.188520818472828e+000,6.717751849883596e-001,
        5.902033297172826e-002},{9.637783262374123e+000,3.225981337955358e+000,
        6.803472381840313e-001,5.992364165471453e-002},{9.787534478331198e+000,
        3.264013689063900e+000,6.890201929749196e-001,6.083847112842355e-002},{
        9.940942732178327e+000,3.302631652132191e+000,6.977955968597331e-001,
        6.176495724204956e-002},{1.009812202265841e+001,3.341849429269576e+000,
        7.066750347651324e-001,6.270323793734337e-002},{1.025919010297298e+001,
        3.381681664493669e+000,7.156601301940823e-001,6.365345329938531e-002},{
        1.042426957493940e+001,3.422143454409642e+000,7.247525464307929e-001,
        6.461574560892680e-002},{1.059348749063613e+001,3.463250369255583e+000,
        7.339539877745911e-001,6.559025939636394e-002},{1.076697585846694e+001,
        3.505018468612565e+000,7.432662008315984e-001,6.657714149739567e-002},{
        1.094487160471041e+001,3.547464321529919e+000,7.526909758485252e-001,
        6.757654111043801e-002},{1.112731703673556e+001,3.590605024361887e+000,
        7.622301481021555e-001,6.858860985585549e-002},{1.131446020990981e+001,
        3.634458220845387e+000,7.718855993386348e-001,6.961350183708254e-002},{
        1.150645448169887e+001,3.679042126940943e+000,7.816592592654319e-001,
        7.065137370370449e-002},{1.170345995510019e+001,3.724375546279324e+000,
        7.915531071140711e-001,7.170238471657543e-002},{1.190564234904387e+001,
        3.770477901775988e+000,8.015691732425808e-001,7.276669681505513e-002},{
        1.211317480895882e+001,3.817369250831911e+000,8.117095408270398e-001,
        7.384447468644079e-002},{1.232623678221967e+001,3.865070319658420e+000,
        8.219763475927884e-001,7.493588583769051e-002},{1.254501551614812e+001,
        3.913602522481210e+000,8.323717876409130e-001,7.604110066951828e-002},{
        1.276970570264624e+001,3.962987994216706e+000,8.428981133273581e-001,
        7.716029255296762e-002},{1.300051006140023e+001,4.013249618094449e+000,
        8.535576372305411e-001,7.829363790855323e-002},{1.323763982202276e+001,
        4.064411055841034e+000,8.643527341958465e-001,7.944131628808258e-002},{
        1.348131510325956e+001,4.116496780178591e+000,8.752858434632413e-001,
        8.060351045926384e-002},{1.373176523992096e+001,4.169532109259019e+000,
        8.863594708830151e-001,8.178040649321636e-002},{1.398922935368295e+001,
        4.223543241273606e+000,8.975761912265102e-001,8.297219385500314e-002},{
        1.425395688597875e+001,4.278557291550713e+000,9.089386505921364e-001,
        8.417906549731447e-002},{1.452620788323131e+001,4.334602332815509e+000,
        9.204495689124428e-001,8.540121795743366e-002},{1.480625390155680e+001,
        4.391707434003711e+000,9.321117425728144e-001,8.663885145762519e-002},{
        1.509437843512102e+001,4.449902704716440e+000,9.439280471367345e-001,
        8.789217000909319e-002},{1.539087726927183e+001,4.509219341703720e+000,
        9.559014401917926e-001,8.916138151966196e-002},{1.569605974666963e+001,
        4.569689672974459e+000,9.680349643254816e-001,9.044669790534268e-002},{
        1.601024873436720e+001,4.631347212300324e+000,9.803317502206551e-001,
        9.174833520595821e-002},{1.633378209073554e+001,4.694226707614670e+000,
        9.927950199017923e-001,9.306651370500110e-002},{1.666701262562578e+001,
        4.758364201213424e+000,1.005428090113279e+000,9.440145805391902e-002},{
        1.701031014311637e+001,4.823797081430276e+000,1.018234375865878e+000,
        9.575339740102105e-002},{1.736406085678517e+001,4.890564153189856e+000,
        1.031217394122572e+000,9.712256552522060e-002},{1.772866946580232e+001,
        4.958705695446524e+000,1.044380767679338e+000,9.850920097482693e-002},{
        1.810455972114648e+001,5.028263532980517e+000,1.057728229205364e+000,
        9.991354721162990e-002},{1.849217554137902e+001,5.099281108341590e+000,
        1.071263625479878e+000,1.013358527605123e-001},{1.889198201807828e+001,
        5.171803558649142e+000,1.084990921826914e+000,1.027763713648547e-001},{
        1.930446710896825e+001,5.245877793634559e+000,1.098914206763288e+000,
        1.042353621480049e-001},{1.973014205980786e+001,5.321552585652118e+000,
        1.113037696859451e+000,1.057130897811017e-001},{2.016954403973725e+001,
        5.398878652454267e+000,1.127365741851098e+000,1.072098246575545e-001},{
        2.062323620612181e+001,5.477908760805788e+000,1.141902829977046e+000,
        1.087258430745073e-001},{2.109181035758059e+001,5.558697820064092e+000,
        1.156653593603386e+000,1.102614274216203e-001},{2.157588804150967e+001,
        5.641302992575035e+000,1.171622815106442e+000,1.118168663775389e-001},{
        2.207612293451024e+001,5.725783803384387e+000,1.186815433061205e+000,
        1.133924551144240e-001},{2.259320168853458e+001,5.812202265487298e+000,
        1.202236548730634e+000,1.149884955109506e-001},{2.312784738048727e+001,
        5.900622998303927e+000,1.217891432902972e+000,1.166052963742056e-001},{
        2.368082059232428e+001,5.991113369373331e+000,1.233785533055696e+000,
        1.182431736709384e-001},{2.425292225768141e+001,6.083743633219402e+000,
        1.249924480910505e+000,1.199024507686403e-001},{2.484499632728939e+001,
        6.178587082451594e+000,1.266314100373835e+000,1.215834586869736e-001},{
        2.545793213201633e+001,6.275720210738291e+000,1.282960415894291e+000,
        1.232865363600859e-001},{2.609266741838787e+001,6.375222882468171e+000,
        1.299869661270916e+000,1.250120309103875e-001},{2.675019182339740e+001,
        6.477178512979792e+000,1.317048288932363e+000,1.267602979344092e-001},{
        2.743154975809655e+001,6.581674264927436e+000,1.334502979714424e+000,
        1.285317018013878e-001},{2.813784419975337e+001,6.688801252695598e+000,
        1.352240653180803e+000,1.303266159652730e-001},{2.887024103476939e+001,
        6.798654759803430e+000,1.370268478512396e+000,1.321454232908995e-001},{
        2.962997256101324e+001,6.911334476958677e+000,1.388593885998045e+000,
        1.339885163951065e-001},{3.041834222256269e+001,7.026944749204763e+000,
        1.407224579184756e+000,1.358562980036433e-001},{3.123673065041534e+001,
        7.145594837012060e+000,1.426168547717874e+000,1.377491813247640e-001},{
        3.208659867260553e+001,7.267399213620009e+000,1.445434080900596e+000,
        1.396675904404572e-001},{3.296949558164943e+001,7.392477853249294e+000,
        1.465029782083446e+000,1.416119607163322e-001},{3.388706321309404e+001,
        7.520956569516788e+000,1.484964583852694e+000,1.435827392312659e-001},{
        3.484104425992344e+001,7.652967352967133e+000,1.505247764160289e+000,
        1.455803852279572e-001},{3.583328871585933e+001,7.788648749509054e+000,
        1.525888963393957e+000,1.476053705856567e-001},{3.686576173093582e+001,
        7.928146259087701e+000,1.546898202497619e+000,1.496581803163948e-001},{
        3.794055292138633e+001,8.071612759939052e+000,1.568285902204809e+000,
        1.517393130861525e-001},{3.905988423567278e+001,8.219208975969522e+000,
        1.590062903450447e+000,1.538492817625102e-001},{4.022612278917213e+001,
        8.371103955820873e+000,1.612240489091282e+000,1.559886139904228e-001},{
        4.144178802231272e+001,8.527475626063863e+000,1.634830406955019e+000,
        1.581578527979038e-001},{4.270956760743552e+001,8.688511337873317e+000,
        1.657844894438090e+000,1.603575572335084e-001},{4.403232828703730e+001,
        8.854408498051546e+000,1.681296704630431e+000,1.625883030377006e-001},{
        4.541313048616726e+001,9.025375228265101e+000,1.705199134198361e+000,
        1.648506833502761e-001},{4.685524481402835e+001,9.201631075280597e+000,
        1.729566053114142e+000,1.671453094562547e-001},{4.836216874299397e+001,
        9.383407786556877e+000,1.754411936372791e+000,1.694728115728024e-001},{
        4.993764414063455e+001,9.570950149359556e+000,1.779751897873626e+000,
        1.718338396799571e-001},{5.158568206789742e+001,9.764516870993175e+000,
        1.805601726664191e+000,1.742290643981639e-001},{5.331057910775004e+001,
        9.964381592476455e+000,1.831977925638632e+000,1.766591779158699e-001},{
        5.511694763067611e+001,1.017083391162707e+001,1.858897753082626e+000,
        1.791248949706736e-001},{5.700974172252563e+001,1.038418054494647e+001,
        1.886379267098844e+000,1.816269538878832e-001},{5.899428511832413e+001,
        1.060474658549166e+001,1.914441373282820e+000,1.841661176805712e-001},{
        6.107630828637804e+001,1.083287683601744e+001,1.943103875942831e+000,
        1.867431752156427e-001},{6.326198278685594e+001,1.106893730143000e+001,
        1.972387533071627e+000,1.893589424508101e-001},{6.555796198384681e+001,
        1.131331679368660e+001,2.002314115513010e+000,1.920142637477639e-001},{
        6.797142895789277e+001,1.156642867112690e+001,2.032906470660536e+000,
        1.947100132673632e-001},{7.051014259118738e+001,1.182871277708803e+001,
        2.064188591054464e+000,1.974470964531552e-001},{7.318249755499194e+001,
        1.210063750757317e+001,2.096185688455698e+000,2.002264516101225e-001},{
        7.599758305520270e+001,1.238270212416496e+001,2.128924273762562e+000,
        2.030490515862381e-001},{7.896525487015090e+001,1.267543924938139e+001,
        2.162432243469748e+000,2.059159055650721e-001},{8.209620970424231e+001,
        1.297941764134553e+001,2.196738973190282e+000,2.088280609785455e-001},{
        8.540207522795785e+001,1.329524520372681e+001,2.231875419045990e+000,
        2.117866055497768e-001},{8.889550374943779e+001,1.362357234194895e+001,
        2.267874227597210e+000,2.147926694769878e-001},{9.259028368620527e+001,
        1.396509562361649e+001,2.304769855305945e+000,2.178474277705093e-001},{
        9.651829128424471e+001,1.432049438243640e+001,2.342598758507877e+000,
        2.209521027562080e-001},{1.006827813095549e+002,1.469059898846239e+001,
        2.381399399667429e+000,2.241079667600002e-001},{1.050830383090181e+002,
        1.507634001775476e+001,2.421212499782385e+000,2.273163449897145e-001},{
        1.097159532822494e+002,1.548598574903566e+001,2.462761236361068e+000,
        2.306327012079619e-001},{1.145551746011481e+002,1.590751402734798e+001,
        2.504820150180328e+000,2.339568479963077e-001},{1.196071879274800e+002,
        1.634031428204418e+001,2.547304783567245e+000,2.372813206159512e-001},{
        1.248813064046870e+002,1.678468557395838e+001,2.590218919465339e+000,
        2.406057414176631e-001},{1.303872537968743e+002,1.724093475889964e+001,
        2.633566376628655e+000,2.439297408582211e-001},{1.361351893482151e+002,
        1.770937668244954e+001,2.677351009715642e+000,2.472529573723386e-001},{
        1.421357200157020e+002,1.819033445609385e+001,2.721576709359743e+000,
        2.505750372458958e-001},{1.483999250325510e+002,1.868413966908177e+001,
        2.766247402420666e+000,2.538956344906715e-001},{1.549393793818828e+002,
        1.919113263274907e+001,2.811367052239077e+000,2.572144107206163e-001},{
        1.617661691499202e+002,1.971166267036393e+001,2.856939658935786e+000,
        2.605310350297162e-001},{1.688929248323650e+002,2.024608833018471e+001,
        2.902969259872029e+000,2.638451838715473e-001},{1.763328352717475e+002,
        2.079477771318220e+001,2.949459930036376e+000,2.671565409405210e-001},{
        1.840996840769975e+002,2.135810869815029e+001,2.996415782636564e+000,
        2.704647970548957e-001},{1.922078676314314e+002,2.193646927847552e+001,
        3.043840969616666e+000,2.737696500416193e-001},{2.006724283454303e+002,
        2.253025783125822e+001,3.091739682337686e+000,2.770708046228763e-001},{
        2.095090814552011e+002,2.313988343722962e+001,3.140116152252167e+000,
        2.803679723045419e-001},{2.187342515473353e+002,2.376576617580840e+001,
        3.188974651669187e+000,2.836608712664611e-001},{2.283650918868312e+002,
        2.440833750459543e+001,3.238319494505725e+000,2.869492262544885e-001},{
        2.384195342056883e+002,2.506804051982763e+001,3.288155037218739e+000,
        2.902327684744187e-001},{2.489163138911711e+002,2.574533035608010e+001,
        3.338485679629001e+000,2.935112354877263e-001},{2.598750056133280e+002,
        2.644067453977188e+001,3.389315865882125e+000,2.967843711090281e-001},{
        2.713160677769612e+002,2.715455332610006e+001,3.440650085468187e+000,
        3.000519253054244e-001},{2.832608847937721e+002,2.788746007968089e+001,
        3.492492874226473e+000,3.033136540975304e-001},{2.957317919551732e+002,
        2.863990172314495e+001,3.544848815373224e+000,3.065693194622797e-001},{
        3.087521441999503e+002,2.941239903121475e+001,3.597722540707405e+000,
        3.098186892373309e-001},{3.223463482749902e+002,3.020548711562214e+001,
        3.651118731652995e+000,3.130615370273069e-001},{3.365398966901275e+002,
        3.101971587811786e+001,3.705042120439269e+000,3.162976421114645e-001},{
        3.513594557285981e+002,3.185565030489221e+001,3.759497491412099e+000,
        3.195267893531296e-001},{3.668328823476213e+002,3.271387106452257e+001,
        3.814489682103804e+000,3.227487691105892e-001},{3.829892914752884e+002,
        3.359497489941416e+001,3.870023584585280e+000,3.259633771495039e-001},{
        3.998591128097355e+002,3.449957509744066e+001,3.926104146732770e+000,
        3.291704145568308e-001},{4.174741627149792e+002,3.542830194413114e+001,
        3.982736373535119e+000,3.323696876561623e-001},{4.358676805476378e+002,
        3.638180331176448e+001,4.039925328339042e+000,3.355610079244262e-001},{
        4.550744161800611e+002,3.736074507936995e+001,4.097676134274746e+000,
        3.387441919099929e-001},{4.751306901524957e+002,3.836581169669577e+001,
        4.155993975546389e+000,3.419190611519825e-001},{4.960744587857732e+002,
        3.939770673337638e+001,4.214884098795508e+000,3.450854421009716e-001},{
        5.179454167679796e+002,4.045715335623541e+001,4.274351814507482e+000,
        3.482431660408029e-001},{5.407850064016650e+002,4.154489509408396e+001,
        4.334402498261381e+000,3.513920690115978e-001},{5.646366068557300e+002,
        4.266169608345259e+001,4.395041592346873e+000,3.545319917339359e-001},{
        5.895455040095308e+002,4.380834204753403e+001,4.456274606836136e+000,
        3.576627795341116e-001},{6.155612607453704e+002,4.498563613130256e+001,
        4.518107123265989e+000,3.607842822704025e-001},{6.427223576125481e+002,
        4.619443542018386e+001,4.580544778714099e+000,3.638963542604584e-001},{
        6.711025648658506e+002,4.743553149708603e+001,4.643593333070903e+000,
        3.669988542095214e-001},{7.007318473518636e+002,4.870987626352949e+001,
        4.707258525584453e+000,3.700916451436019e-001},{7.316684143282685e+002,
        5.001834629107649e+001,4.771546260300777e+000,3.731745943241331e-001},{
        7.639419550281848e+002,5.136190630000230e+001,4.836462461289155e+000,
        3.762475732019301e-001},{7.981063801427506e+002,5.274052724808852e+001,
        4.902013540645013e+000,3.793104573307563e-001},{8.326445111213358e+002,
        5.415893280165836e+001,4.968203781164648e+000,3.823631262876042e-001},{
        8.700148252485711e+002,5.561171210577200e+001,5.035043285535354e+000,
        3.854054635554983e-001},{9.083445124296225e+002,5.710569757459630e+001,
        5.102533934520626e+000,3.884373570657309e-001},{9.485314487146718e+002,
        5.863925936997953e+001,5.170684545601461e+000,3.914586976410323e-001},{
        9.905087195242919e+002,6.021400337316415e+001,5.239500994607786e+000,
        3.944693805727305e-001},{1.034356723979786e+003,6.183105555221405e+001,
        5.308989797804546e+000,3.974693046888213e-001},{1.080159595815648e+003,
        6.349157319187947e+001,5.379157557964565e+000,4.004583724710528e-001},{
        1.128005029381322e+003,6.519674650368150e+001,5.450010965169889e+000,
        4.034364899924996e-001},{1.177984892396054e+003,6.694779842280083e+001,
        5.521556798559543e+000,4.064035668556144e-001},{1.230194856555584e+003,
        6.874598675922586e+001,5.593801926683446e+000,4.093595161310650e-001},{
        1.284735013104745e+003,7.059260392256267e+001,5.666753309253390e+000,
        4.123042542968513e-001},{1.343063556661926e+003,7.248693578584985e+001,
        5.740418684403948e+000,4.152377011781763e-001},{1.405790811881685e+003,
        7.442887970010709e+001,5.814805784873986e+000,4.181597798876019e-001},{
        1.473628412214821e+003,7.641766308616965e+001,5.889923696754936e+000,
        4.210704167656976e-001},{1.547407873141551e+003,7.866215579136075e+001,
        5.972913138476412e+000,4.242404029888886e-001},{1.626876447829412e+003,
        8.101582333818058e+001,6.058368241520675e+000,4.274553962053971e-001},{
        1.710703024156860e+003,8.348992183014360e+001,6.146409820007483e+000,
        4.307167462684176e-001},{1.802548130038754e+003,8.608556958507408e+001,
        6.237172430960432e+000,4.340258706136082e-001},{1.900281151393451e+003,
        8.881903955788455e+001,6.330791655209080e+000,4.373842594703591e-001},{
        2.005807564700644e+003,9.169671712011228e+001,6.427420948078083e+000,
        4.407934798537481e-001},{2.119670462816548e+003,9.473022727133676e+001,
        6.527221444915404e+000,4.442551829095661e-001},{2.242730739132749e+003,
        9.793155623939180e+001,6.630367354240099e+000,4.477711093076878e-001},{
        2.375959842441208e+003,1.013138933328462e+002,6.737046497801452e+000,
        4.513430963808632e-001},{2.520456586920368e+003,1.048917812479968e+002,
        6.847461700925177e+000,4.549730857610047e-001},{2.677467781456748e+003,
        1.086812872066808e+002,6.961832360108455e+000,4.586631318040276e-001},{
        2.848411757693430e+003,1.127002025269144e+002,7.080396212881112e+000,
        4.624154109045756e-001},{3.034907040997281e+003,1.169682716660580e+002,
        7.203411344095176e+000,4.662322318172513e-001},{3.238806348401873e+003,
        1.215074586972124e+002,7.331158464655384e+000,4.701160471199219e-001},{
        3.462237522477920e+003,1.263422571775514e+002,7.463943508185539e+000,
        4.740694659762597e-001},{3.707652735358812e+003,1.315000523822533e+002,
        7.602100598730761e+000,4.780952683808143e-001},{3.977888247502366e+003,
        1.370115455154723e+002,7.745995453845659e+000,4.821964211012325e-001},{
        4.276236889578777e+003,1.429112533343024e+002,7.896029299613393e+000,
        4.863760955695669e-001},{4.606537129126736e+003,1.492380973967760e+002,
        8.052643391311207e+000,4.906376880197965e-001},{4.973281708728467e+003,
        1.560361047391914e+002,8.216324251440401e+000,4.949848422233832e-001},{
        5.381752513871990e+003,1.633552406824528e+002,8.387609764809310e+000,
        4.994214752410864e-001},{5.838187327949046e+003,1.712524067572989e+002,
        8.567096297611432e+000,5.039518066908266e-001},{6.350807137284905e+003,
        1.797913262134226e+002,8.755447517735441e+000,5.085803921309421e-001},{
        6.925260369284571e+003,1.890530284782858e+002,8.953400783448563e+000,
        5.133121612816783e-001},{7.577609824964002e+003,1.991109013463354e+002,
        9.161790857189885e+000,5.181524619605371e-001},{8.315968280243349e+003,
        2.100768343459340e+002,9.381540170293199e+000,5.231071115480921e-001},{
        9.158060724816223e+003,2.220603128331959e+002,9.613703198825842e+000,
        5.281824536278080e-001},{1.012263317307919e+004,2.351976050029865e+002,
        9.859467222735550e+000,5.333854293394884e-001},{1.123327851126173e+004,
        2.496472646859635e+002,1.012018401525426e+001,5.387236561640729e-001},{
        1.251933369982379e+004,2.655964641799241e+002,1.039739833055877e+001,
        5.442055229446516e-001},{1.401759699687882e+004,2.832674508259391e+002,
        1.069288439806393e+001,5.498403020789378e-001},{1.577465893041188e+004,
        3.029257728808081e+002,1.100869114048111e+001,5.556382833229867e-001},{
        1.785011289937452e+004,3.248908324502644e+002,1.134719868472852e+001,
        5.616109344677590e-001},{2.032103368180682e+004,3.495495532976501e+002,
        1.171118962875876e+001,5.677710957231201e-001},{2.328832453018373e+004,
        3.773742333550699e+002,1.210393982355082e+001,5.741332167790789e-001},{
        2.688585484152241e+004,4.089460996964476e+002,1.252933527138577e+001,
        5.807136484549550e-001},{3.129385590668408e+004,4.449866873513151e+002,
        1.299202446564990e+001,5.875310049495469e-001},{3.675989831311496e+004,
        4.863985403526961e+002,1.349762008289207e+001,5.946066185193436e-001},{
        4.362525762024865e+004,5.343309081037533e+002,1.405296523588706e+001,
        6.019651167819491e-001},{5.238361908669422e+004,5.902358641369289e+002,
        1.466651102006858e+001,6.096351651125723e-001},{6.374468368510970e+004,
        6.560106923559654e+002,1.534880715327808e+001,6.176504358167559e-001},{
        7.877675453751416e+004,7.341156222195222e+002,1.611324444329973e+001,
        6.260508899137485e-001},{9.912569226684302e+004,8.277977359185787e+002,
        1.697708892301073e+001,6.348845111387733e-001},{1.274244982488466e+005,
        9.413602952665652e+002,1.796305186238983e+001,6.442096900359834e-001},{
        1.680683685966994e+005,1.080502797828005e+003,1.910170745210420e+001,
        6.540985866240503e-001},{2.287813361407409e+005,1.252634522697668e+003,
        2.043539039017945e+001,6.646420006807282e-001},{3.240258081936964e+005,
        1.466745135891141e+003,2.202482398980625e+001,6.759566538738161e-001},{
        4.831368343637143e+005,1.731166540009913e+003,2.396123098126818e+001,
        6.881964979202373e-001},{7.431179345815331e+005,2.088970442340921e+003,
        2.637425972841378e+001,7.015710980094142e-001},{1.189850152483235e+006,
        2.623880187705014e+003,2.946733032297955e+001,7.163772638856115e-001},{
        2.026594777734833e+006,3.525448589659171e+003,3.356057915998095e+001,
        7.330575520262048e-001},{3.751171121950996e+006,3.860303175516215e+003,
        3.792933932492554e+001,7.472071449747023e-001},{7.724209728178185e+006,
        3.466433188520202e+003,4.418715889618908e+001,7.632728136051334e-001},{
        1.704546786687731e+007,2.883198938498763e+003,5.372439594779554e+001,
        7.828757764751581e-001},{3.866227285949533e+007,6.044071408154451e+003,
        6.745335104083873e+001,8.059157661363587e-001},{8.834871476634434e+007,
        1.351199514790031e+004,8.499422051220881e+001,8.277377240352702e-001},{
        2.176025209942091e+008,1.094228648933841e+004,1.064266208208614e+002,
        8.459822722289890e-001},{5.417031709599584e+008,-1.429287025490565e+004,
        1.349265846505103e+002,8.629254292602316e-001},{1.260427879479906e+009,
        -1.145901868204451e+004,1.733305321359170e+002,8.814128590616269e-001},
        {2.813184466308078e+009,2.559435030649040e+005,2.304564317758250e+002,
        9.042234397623542e-001},{5.626351338748589e+009,4.809820508206572e+005,
        2.799571429006732e+002,9.167366942666617e-001},{1.296968662926528e+010,
        1.817347953863243e+005,3.184401164168030e+002,9.225727665578075e-001},{
        3.830247925197880e+010,-6.819911380346881e+005,4.005374222642562e+002,
        9.326388658049110e-001},{1.287778778901221e+011,-3.655758707469311e+006,
        5.430609568313491e+002,9.435863614001090e-001},{4.268494326672124e+011,
        -3.288472239150366e+006,7.033859556657586e+002,9.579454741567478e-001},
        {1.034173853201191e+012,4.083865055613008e+006,8.820734693646336e+002,
        9.677749072712484e-001},{7.360535318331335e+015,-4.520887554536115e+010,
        6.939753852333379e+004,9.741584695812871e-001}};
    constant Real[Ninterval, 4] dlcoef={{-1.238492681682227e+010,
        2.155273044551285e+006,-4.784064764172629e+002,3.108234546713846e+000},
        {-1.105429598046165e+010,2.040848348264662e+006,-4.669490356904236e+002,
        3.106950869117842e+000},{-9.690084649689146e+009,1.940606112928544e+006,
        -4.575230025626220e+002,3.105872508783625e+000},{-8.318064398350635e+009,
        1.756735969737722e+006,-4.369950152503960e+002,3.103417366473883e+000},
        {-7.140296347581058e+009,1.590320343200648e+006,-4.174017246617847e+002,
        3.100944868392514e+000},{-6.129570508708958e+009,1.439711927840652e+006,
        -3.987007300239189e+002,3.098454883787075e+000},{-5.261965140039352e+009,
        1.303395508058584e+006,-3.808503361523602e+002,3.095947126307966e+000},
        {-4.517289395063499e+009,1.180016669264855e+006,-3.638116590837542e+002,
        3.093421411830455e+000},{-3.878070615519906e+009,1.068342896840991e+006,
        -3.475472372378163e+002,3.090877503680521e+000},{-3.329405690851281e+009,
        9.672641008273838e+005,-3.320217101263023e+002,3.088315215846500e+000},
        {-2.858440705800047e+009,8.757716096217774e+005,-3.172010279329125e+002,
        3.085734309672665e+000},{-2.454126160678405e+009,7.929540898201873e+005,
        -3.030530265360140e+002,3.083134597151535e+000},{-2.107077441640843e+009,
        7.179881425904200e+005,-2.895465270173005e+002,3.080515785796512e+000},
        {-1.809136833923553e+009,6.501257495370673e+005,-2.766520552391303e+002,
        3.077877633663473e+000},{-1.553367992062939e+009,5.886942597143862e+005,
        -2.643417895971250e+002,3.075219949428117e+000},{-1.333788491394850e+009,
        5.330816167622649e+005,-2.525887134919396e+002,3.072542437056091e+000},
        {-1.145286689441753e+009,4.827368491822371e+005,-2.413675362576479e+002,
        3.069844902846438e+000},{-9.842004535366566e+008,4.371863251742306e+005,
        -2.306539304447653e+002,3.067127048225000e+000},{-8.481738668343931e+008,
        3.960467172138331e+005,-2.204253861258150e+002,3.064388625095322e+000},
        {-7.331751535883956e+008,3.589111400199431e+005,-2.106602384512079e+002,
        3.061629384019479e+000},{-6.358170209106354e+008,3.259263366450451e+005,
        -2.015181373167670e+002,3.058904739456489e+000},{-5.528785395381644e+008,
        2.973604756002514e+005,-1.932383784377713e+002,3.056307824467903e+000},
        {-4.812120579273270e+008,2.714695510765162e+005,-1.853567632253349e+002,
        3.053709701944857e+000},{-4.192283489842466e+008,2.479880869216736e+005,
        -1.778517183038584e+002,3.051110359095722e+000},{-3.655664548207343e+008,
        2.266781162415372e+005,-1.707029553047223e+002,3.048509783002060e+000},
        {-3.190676294329081e+008,2.073267347249426e+005,-1.638913968450548e+002,
        3.045907960618840e+000},{-2.787357163663924e+008,1.897427160373918e+005,
        -1.573990874235835e+002,3.043304878774594e+000},{-2.437229798017070e+008,
        1.737549055396368e+005,-1.512091344388983e+002,3.040700524171564e+000},
        {-2.132978996593800e+008,1.592092608304189e+005,-1.453056252302879e+002,
        3.038094883385813e+000},{-1.868371040328432e+008,1.459677646993695e+005,
        -1.396735798552919e+002,3.035487942867281e+000},{-1.638025501528403e+008,
        1.339061001971329e+005,-1.342988785546285e+002,3.032879688939840e+000},
        {-1.437323978319605e+008,1.229125376644445e+005,-1.291682166376668e+002,
        3.030270107801310e+000},{-1.262309428194057e+008,1.128866441350699e+005,
        -1.242690519881137e+002,3.027659185523409e+000},{-1.109546795986899e+008,
        1.037377107884577e+005,-1.195895502947782e+002,3.025046908051736e+000},
        {-9.761012432391328e+007,9.538426669141714e+004,-1.151185537187768e+002,
        3.022433261205660e+000},{-8.594246238515522e+007,8.775266482730758e+004,
        -1.108455268357315e+002,3.019818230678227e+000},{-7.573256602113859e+007,
        8.077656161927809e+004,-1.067605270066560e+002,3.017201802035995e+000},
        {-6.679050808234609e+007,7.439599879519979e+004,-1.028541631348516e+002,
        3.014583960718893e+000},{-5.895272357387779e+007,6.855689098463632e+004,
        -9.911756599444276e+001,3.011964692039987e+000},{-5.207642434522393e+007,
        6.321021881030477e+004,-9.554235139999366e+001,3.009343981185272e+000},
        {-4.603952482299992e+007,5.831185001665622e+004,-9.212060006254087e+001,
        3.006721813213399e+000},{-4.073465329002590e+007,5.382164282445671e+004,
        -8.884481728610524e+001,3.004098173055394e+000},{-3.606947830186065e+007,
        4.970338252471794e+004,-8.570791975358135e+001,3.001473045514342e+000},
        {-3.196365751713583e+007,4.592422769921850e+004,-8.270320400275625e+001,
        2.998846415265044e+000},{-2.834709613390578e+007,4.245437522415161e+004,
        -7.982432520669138e+001,2.996218266853638e+000},{-2.515904141651271e+007,
        3.926683364274947e+004,-7.706527859170076e+001,2.993588584697207e+000},
        {-2.234661006197257e+007,3.633710429345421e+004,-7.442037731654195e+001,
        2.990957353083351e+000},{-1.986350933749488e+007,3.364291054328384e+004,
        -7.188423367010003e+001,2.988324556169726e+000},{-1.766954634469551e+007,
        3.116404764577806e+004,-6.945174434254167e+001,2.985690177983576e+000},
        {-1.572958710525628e+007,2.888213723781383e+004,-6.711807172295707e+001,
        2.983054202421209e+000},{-1.401292644023167e+007,2.678046159635360e+004,
        -6.487862947013215e+001,2.980416613247471e+000},{-1.249270190404953e+007,
        2.484380595914790e+004,-6.272906834224337e+001,2.977777394095186e+000},
        {-1.114546757050897e+007,2.305832820575798e+004,-6.066526313144936e+001,
        2.975136528464554e+000},{-9.950639193150809e+006,2.141140730200463e+004,
        -5.868329902325385e+001,2.972493999722552e+000},{-8.890218298855454e+006,
        1.989154845489648e+004,-5.677946086303228e+001,2.969849791102278e+000},
        {-7.948405774843407e+006,1.848826513773720e+004,-5.495022127059669e+001,
        2.967203885702293e+000},{-7.111322017747801e+006,1.719198739978693e+004,
        -5.319223050409758e+001,2.964556266485915e+000},{-6.366802347563332e+006,
        1.599398533656803e+004,-5.150230698139536e+001,2.961906916280511e+000},
        {-5.704155755187705e+006,1.488628445368870e+004,-4.987742750713409e+001,
        2.959255817776730e+000},{-5.113936916982337e+006,1.386158907991517e+004,
        -4.831471847609879e+001,2.956602953527748e+000},{-4.587897845661234e+006,
        1.291324557621612e+004,-4.681144900015597e+001,2.953948305948456e+000},
        {-4.118721316950063e+006,1.203515316230080e+004,-4.536502121962786e+001,
        2.951291857314630e+000},{-3.699968686669407e+006,1.122173374498905e+004,
        -4.397296471188466e+001,2.948633589762085e+000},{-3.325990419032289e+006,
        1.046788709710375e+004,-4.263292938338680e+001,2.945973485285792e+000},
        {-2.991756337877007e+006,9.768928695956120e+003,-4.134267792650781e+001,
        2.943311525738965e+000},{-2.692851052844252e+006,9.120574676046892e+003,
        -4.010008148277442e+001,2.940647692832129e+000},{-2.425364090781395e+006,
        8.518894238993196e+003,-3.890311277023815e+001,2.937981968132176e+000},
        {-2.185839011929014e+006,7.960282125333197e+003,-3.774984110719230e+001,
        2.935314333061347e+000},{-1.971208238001473e+006,7.441427276955104e+003,
        -3.663842719615118e+001,2.932644768896239e+000},{-1.778765554998854e+006,
        6.959293235989100e+003,-3.556711877550735e+001,2.929973256766761e+000},
        {-1.606107055594805e+006,6.511088393081703e+003,-3.453424555743582e+001,
        2.927299777655057e+000},{-1.451097834519724e+006,6.094246543433254e+003,
        -3.353821526499588e+001,2.924624312394422e+000},{-1.311849093123074e+006,
        5.706410424466297e+003,-3.257750979381026e+001,2.921946841668166e+000},
        {-1.186680867573490e+006,5.345410405839227e+003,-3.165068106360730e+001,
        2.919267346008474e+000},{-1.074098219451101e+006,5.009249251722629e+003,
        -3.075634760904577e+001,2.916585805795216e+000},{-9.727750675061081e+005,
        4.696089510241781e+003,-2.989319134752533e+001,2.913902201254751e+000},
        {-8.815305960940811e+005,4.404238143974260e+003,-2.905995415563471e+001,
        2.911216512458684e+000},{-7.993100073168422e+005,4.132133894522016e+003,
        -2.825543489024561e+001,2.908528719322610e+000},{-7.251808108065209e+005,
        3.878340434733169e+003,-2.747848687199868e+001,2.905838801604811e+000},
        {-6.583036582047840e+005,3.641529386009533e+003,-2.672801450587870e+001,
        2.903146738904952e+000},{-5.979351488970650e+005,3.420477830640781e+003,
        -2.600297151102254e+001,2.900452510662714e+000},{-5.434106276898081e+005,
        3.214056119358886e+003,-2.530235797279994e+001,2.897756096156425e+000},
        {-4.941345433408149e+005,3.021220273636314e+003,-2.462521817165470e+001,
        2.895057474501652e+000},{-4.495775001488223e+005,2.841007253447881e+003,
        -2.397063865119245e+001,2.892356624649757e+000},{-4.092637696142438e+005,
        2.672525730358106e+003,-2.333774582158626e+001,2.889653525386433e+000},
        {-3.727690426212300e+005,2.514952386918597e+003,-2.272570432440947e+001,
        2.886948155330209e+000},{-3.397130883384123e+005,2.367525415691009e+003,
        -2.213371501440320e+001,2.884240492930909e+000},{-3.097553540585333e+005,
        2.229539894807050e+003,-2.156101328018909e+001,2.881530516468100e+000},
        {-2.825898974603600e+005,2.100342961405521e+003,-2.100686736953992e+001,
        2.878818204049503e+000},{-2.579442208981614e+005,1.979331007278646e+003,
        -2.047057696315193e+001,2.876103533609366e+000},{-2.355710977468511e+005,
        1.865943220530542e+003,-1.995147135640385e+001,2.873386482906805e+000},
        {-2.152510718952486e+005,1.759661471895166e+003,-1.944890854277082e+001,
        2.870667029524125e+000},{-1.967854522379427e+005,1.660004272608494e+003,
        -1.896227340604679e+001,2.867945150865090e+000},{-1.799963227248120e+005,
        1.566525526716963e+003,-1.849097676756957e+001,2.865220824153183e+000},
        {-1.647232316787083e+005,1.478811021808096e+003,-1.803445403318663e+001,
        2.862494026429800e+000},{-1.508223569587723e+005,1.396476642378965e+003,
        -1.759216415836827e+001,2.859764734552452e+000},{-1.381636164814771e+005,
        1.319165275775219e+003,-1.716358843294191e+001,2.857032925192887e+000},
        {-1.266302756204947e+005,1.246545535418823e+003,-1.674822959952733e+001,
        2.854298574835218e+000},{-1.161168631137604e+005,1.178309260666872e+003,
        -1.634561076107631e+001,2.851561659773991e+000},{-1.065283929681333e+005,
        1.114170085655529e+003,-1.595527452413494e+001,2.848822156112222e+000},
        {-9.777902898360457e+004,1.053861608696577e+003,-1.557678207604774e+001,
        2.846080039759405e+000},{-8.979154479537536e+004,9.971361867131301e+002,
        -1.520971239323694e+001,2.843335286429471e+000},{-8.249581780149181e+004,
        9.437630558793404e+002,-1.485366135803301e+001,2.840587871638727e+000},
        {-7.582881406187733e+004,8.935276800414810e+002,-1.450824112401567e+001,
        2.837837770703734e+000},{-6.973331684484918e+004,8.462300547482139e+002,
        -1.417307927722939e+001,2.835084958739184e+000},{-6.415772301025310e+004,
        8.016839926065475e+002,-1.384781823535527e+001,2.832329410655682e+000},
        {-5.905519971849246e+004,7.597158559545809e+002,-1.353211453405775e+001,
        2.829571101157552e+000},{-5.438340177539967e+004,7.201638399218540e+002,
        -1.322563825532957e+001,2.826810004740545e+000},{-5.010398989213503e+004,
        6.828770586818224e+002,-1.292807241099001e+001,2.824046095689559e+000},
        {-4.618216375504041e+004,6.477146970338505e+002,-1.263911237047971e+001,
        2.821279348076278e+000},{-4.258637278865216e+004,6.145453580284924e+002,
        -1.235846534594279e+001,2.818509735756785e+000},{-3.928799334523628e+004,
        5.832463833869973e+002,-1.208584987510642e+001,2.815737232369135e+000},
        {-3.626107008446607e+004,5.537032511254856e+002,-1.182099533490190e+001,
        2.812961811330881e+000},{-3.348198605783714e+004,5.258089299140838e+002,
        -1.156364146280048e+001,2.810183445836552e+000},{-3.092930799948825e+004,
        4.994634350699143e+002,-1.131353793886240e+001,2.807402108855102e+000},
        {-2.858356718774496e+004,4.745733110816813e+002,-1.107044395139554e+001,
        2.804617773127295e+000},{-2.642699292972316e+004,4.510511035622531e+002,
        -1.083412778305086e+001,2.801830411163054e+000},{-2.444349338561342e+004,
        4.288151035012024e+002,-1.060436646834351e+001,2.799039995238765e+000},
        {-2.261838452021139e+004,4.077888022404431e+002,-1.038094537815669e+001,
        2.796246497394526e+000},{-2.093827593537573e+004,3.879005747406519e+002,
        -1.016365789510950e+001,2.793449889431356e+000},{-1.939098963577922e+004,
        3.690833932437830e+002,-9.952305091079492e+000,2.790650142908357e+000},
        {-1.796543440841462e+004,3.512744857770907e+002,-9.746695394200888e+000,
        2.787847229139806e+000},{-1.665145478671165e+004,3.344149940989051e+002,
        -9.546644276491429e+000,2.785041119192228e+000},{-1.543982996581212e+004,
        3.184498209919203e+002,-9.351973998366489e+000,2.782231783881397e+000},
        {-1.432210669598613e+004,3.033272642915332e+002,-9.162513291636291e+000,
        2.779419193769276e+000},{-1.329059840415068e+004,2.889988870529622e+002,
        -8.978097130361970e+000,2.776603319160937e+000},{-1.233825052722389e+004,
        2.754192080986946e+002,-8.798566446195549e+000,2.773784130101386e+000},
        {-1.145863709207734e+004,2.625455884031810e+002,-8.623767918906500e+000,
        2.770961596372379e+000},{-1.064587614821500e+004,2.503379954642477e+002,
        -8.453553723390042e+000,2.768135687489127e+000},{-9.894583021419403e+003,
        2.387588397329175e+002,-8.287781316214854e+000,2.765306372696999e+000},
        {-9.199834391098546e+003,2.277728276390388e+002,-8.126313229068519e+000,
        2.762473620968123e+000},{-8.557121363365739e+003,2.173468013975267e+002,
        -7.969016862161412e+000,2.759637400997958e+000},{-7.962313251536238e+003,
        2.074496022604224e+002,-7.815764293296074e+000,2.756797681201794e+000},
        {-7.411623241071581e+003,1.980519411509770e+002,-7.666432093866367e+000,
        2.753954429711179e+000},{-6.901589290252236e+003,1.891262933062386e+002,
        -7.520901156344275e+000,2.751107614370310e+000},{-6.429018668504029e+003,
        1.806467434145949e+002,-7.379056511362362e+000,2.748257202732345e+000},
        {-5.991001909044038e+003,1.725889472108416e+002,-7.240787192269098e+000,
        2.745403162055639e+000},{-5.584856439473709e+003,1.649299712560422e+002,
        -7.105986051583309e+000,2.742545459299940e+000},{-5.208118092244479e+003,
        1.576482310857538e+002,-6.974549631033893e+000,2.739684061122499e+000},
        {-4.858536339451712e+003,1.507234256770707e+002,-6.846378022696069e+000,
        2.736818933874121e+000},{-4.534025576845524e+003,1.441364021997527e+002,
        -6.721374710980710e+000,2.733950043595136e+000},{-4.232680321240590e+003,
        1.378691440330893e+002,-6.599446472802768e+000,2.731077356011313e+000},
        {-3.952748909345426e+003,1.319046712312123e+002,-6.480503232709889e+000,
        2.728200836529692e+000},{-3.692609478366457e+003,1.262269600752981e+002,
        -6.364457941874171e+000,2.725320450234344e+000},{-3.450780099779326e+003,
        1.208209269116236e+002,-6.251226483812403e+000,2.722436161882055e+000},
        {-3.225890664374303e+003,1.156723332618167e+002,-6.140727542679162e+000,
        2.719547935897942e+000},{-3.016682125991474e+003,1.107677541103619e+002,
        -6.032882511285902e+000,2.716655736370977e+000},{-2.821990248596265e+003,
        1.060945140428862e+002,-5.927615383023561e+000,2.713759527049444e+000},
        {-2.640746879338374e+003,1.016406614326807e+002,-5.824852664925329e+000,
        2.710859271336301e+000},{-2.471964523626565e+003,9.739490626074014e+001,
        -5.724523273535363e+000,2.707954932284481e+000},{-2.314730837568900e+003,
        9.334658567014867e+001,-5.626558451896237e+000,2.705046472592083e+000},
        {-2.168208526525156e+003,8.948563835359066e+001,-5.530891688550211e+000,
        2.702133854597495e+000},{-2.031619097394213e+003,8.580254532064717e+001,
        -5.437458623108411e+000,2.699217040274426e+000},{-1.904248100892504e+003,
        8.228832275596824e+001,-5.346196983339631e+000,2.696295991226843e+000},
        {-1.785432953219038e+003,7.893447181267172e+001,-5.257046496811301e+000,
        2.693370668683814e+000},{-1.674562836953798e+003,7.573296108764812e+001,
        -5.169948826535308e+000,2.690441033494273e+000},{-1.571072232234745e+003,
        7.267619282823553e+001,-5.084847496875256e+000,2.687507046121676e+000},
        {-1.474438413222446e+003,6.975698100090553e+001,-5.001687829570725e+000,
        2.684568666638568e+000},{-1.384177903371559e+003,6.696852671757033e+001,
        -4.920416878738944e+000,2.681625854721034e+000},{-1.299843535198407e+003,
        6.430439600004813e+001,-4.840983369252954e+000,2.678678569643088e+000},
        {-1.221020634106669e+003,6.175849648989043e+001,-4.763337636576003e+000,
        2.675726770270898e+000},{-1.147326026570235e+003,5.932506215554464e+001,
        -4.687431572745481e+000,2.672770415056979e+000},{-1.078404076039887e+003,
        5.699863018706918e+001,-4.613218568350649e+000,2.669809462034204e+000},
        {-1.013926021509312e+003,5.477402792669884e+001,-4.540653463065229e+000,
        2.666843868809767e+000},{-9.535859458173311e+002,5.264635101631857e+001,
        -4.469692491629795e+000,2.663873592558998e+000},{-8.971017903285012e+002,
        5.061095614294467e+001,-4.400293240651299e+000,2.660898590019072e+000},
        {-8.442100723223150e+002,4.866343605671213e+001,-4.332414594549864e+000,
        2.657918817482606e+000},{-7.946678515348818e+002,4.679961714885733e+001,
        -4.266016699189970e+000,2.654934230791131e+000},{-7.482488676648289e+002,
        4.501553841960071e+001,-4.201060911438582e+000,2.651944785328449e+000},
        {-7.047431728617579e+002,4.330744315658079e+001,-4.137509761479857e+000,
        2.648950436013851e+000},{-6.639558744821053e+002,4.167176730429927e+001,
        -4.075326912123187e+000,2.645951137295226e+000},{-6.257057100641964e+002,
        4.010512796775672e+001,-4.014477119746307e+000,2.642946843142023e+000},
        {-5.898246346182218e+002,3.860431527293839e+001,-3.954926198543035e+000,
        2.639937507038096e+000},{-5.561557244035386e+002,3.716627939672841e+001,
        -3.896640982412575e+000,2.636923081974399e+000},{-5.245536700749274e+002,
        3.578812653072018e+001,-3.839589294597946e+000,2.633903520441549e+000},
        {-4.948831814045453e+002,3.446710725683307e+001,-3.783739911111038e+000,
        2.630878774422248e+000},{-4.670181331795835e+002,3.320060869244811e+001,
        -3.729062529754870e+000,2.627848795383549e+000},{-4.408411680577592e+002,
        3.198614837687174e+001,-3.675527740772351e+000,2.624813534268998e+000},
        {-4.162434320780575e+002,3.082136815496841e+001,-3.623106997289613e+000,
        2.621772941490593e+000},{-3.931227261553422e+002,2.970402334199991e+001,
        -3.571772583810418e+000,2.618726966920612e+000},{-3.713848005366851e+002,
        2.863198333302012e+001,-3.521497594697411e+000,2.615675559883269e+000},
        {-3.509411299166285e+002,2.760321878319193e+001,-3.472255900926836e+000,
        2.612618669146214e+000},{-3.317092974307500e+002,2.661580012155591e+001,
        -3.424022129678430e+000,2.609556242911867e+000},{-3.136127904025766e+002,
        2.566789269818100e+001,-3.376771639026537e+000,2.606488228808575e+000},
        {-2.965798073836402e+002,2.475774875702146e+001,-3.330480491611001e+000,
        2.603414573881601e+000},{-2.805435913300593e+002,2.388370594280104e+001,
        -3.285125435370047e+000,2.600335224583943e+000},{-2.654419571434289e+002,
        2.304418190389038e+001,-3.240683879734343e+000,2.597250126766951e+000},
        {-2.512164673588557e+002,2.223766834090091e+001,-3.197133873379682e+000,
        2.594159225670773e+000},{-2.378128746065777e+002,2.146273034130477e+001,
        -3.154454087136033e+000,2.591062465914610e+000},{-2.251804620611885e+002,
        2.071800061360175e+001,-3.112623791404769e+000,2.587959791486772e+000},
        {-2.132716404393391e+002,2.000217565128110e+001,-3.071622837510624e+000,
        2.584851145734526e+000},{-2.020422322936485e+002,1.931401462635231e+001,
        -3.031431641412206e+000,2.581736471353761e+000},{-1.914506566618751e+002,
        1.865233349451230e+001,-2.992031162913385e+000,2.578615710378421e+000},
        {-1.814582337456608e+002,1.801600450360726e+001,-2.953402891597071e+000,
        2.575488804169740e+000},{-1.720286483594544e+002,1.740395163665135e+001,
        -2.915528828069439e+000,2.572355693405244e+000},{-1.631280051948557e+002,
        1.681514914240465e+001,-2.878391469604711e+000,2.569216318067544e+000},
        {-1.547245214939870e+002,1.624861828468630e+001,-2.841973793789774e+000,
        2.566070617432879e+000},{-1.467885075935258e+002,1.570342560672776e+001,
        -2.806259244455594e+000,2.562918530059438e+000},{-1.392920759633892e+002,
        1.517867995891996e+001,-2.771231716523010e+000,2.559759993775438e+000},
        {-1.322092377618008e+002,1.467353144997319e+001,-2.736875543385945e+000,
        2.556594945666950e+000},{-1.255154520422071e+002,1.418716782019382e+001,
        -2.703175481732913e+000,2.553423322065465e+000},{-1.191879144732180e+002,
        1.371881463196889e+001,-2.670116701239096e+000,2.550245058535220e+000},
        {-1.132051254329855e+002,1.326773160149195e+001,-2.637684769449511e+000,
        2.547060089860237e+000},{-1.075469689833722e+002,1.283321196746067e+001,
        -2.605865641505036e+000,2.543868350031094e+000},{-1.021945855468274e+002,
        1.241458057792133e+001,-2.574645647887416e+000,2.540669772231418e+000},
        {-9.713024121213921e+001,1.201119215362063e+001,-2.544011483057522e+000,
        2.537464288824097e+000},{-9.233735633732306e+001,1.162243039375014e+001,
        -2.513950195251489e+000,2.534251831337175e+000},{-8.780030483853737e+001,
        1.124770586654619e+001,-2.484449174984496e+000,2.531032330449471e+000},
        {-8.350447678244254e+001,1.088645546210887e+001,-2.455496146003123e+000,
        2.527805715975874e+000},{-7.943610746442556e+001,1.053814048023886e+001,
        -2.427079154442550e+000,2.524571916852306e+000},{-7.558228169765363e+001,
        1.020224588737254e+001,-2.399186560121682e+000,2.521330861120392e+000},
        {-7.193088597970828e+001,9.878279171064129e+000,-2.371807027150768e+000,
        2.518082475911769e+000},{-6.847048516239306e+001,9.565768889163360e+000,
        -2.344929514629048e+000,2.514826687432048e+000},{-6.519039610308946e+001,
        9.264264386688476e+000,-2.318543269061701e+000,2.511563420944446e+000},
        {-6.208052306641781e+001,8.973334052099887e+000,-2.292637814810399e+000,
        2.508292600753025e+000},{-5.913139743958612e+001,8.692564973814662e+000,
        -2.267202947101239e+000,2.505014150185589e+000},{-5.633408892514787e+001,
        8.421561745547976e+000,-2.242228723666145e+000,2.501727991576170e+000},
        {-5.368023596268498e+001,8.159946044547962e+000,-2.217705457774197e+000,
        2.498434046247153e+000},{-5.116192490033033e+001,7.907355281104470e+000,
        -2.193623710100769e+000,2.495132234490955e+000},{-4.877172908422913e+001,
        7.663442373803837e+000,-2.169974282641104e+000,2.491822475551334e+000},
        {-4.650265985770452e+001,7.427874856171875e+000,-2.146748211408460e+000,
        2.488504687604243e+000},{-4.434811779628213e+001,7.200334084917268e+000,
        -2.123936759740916e+000,2.485178787738240e+000},{-4.230190317998800e+001,
        6.980514860596383e+000,-2.101531412363795e+000,2.481844691934497e+000},
        {-4.035816750319500e+001,6.768124621635819e+000,-2.079523868792742e+000,
        2.478502315046275e+000},{-3.851139744312152e+001,6.562882936055023e+000,
        -2.057906037559458e+000,2.475151570777977e+000},{-3.675639931468597e+001,
        6.364520986088379e+000,-2.036670030451280e+000,2.471792371663693e+000},
        {-3.508827447219454e+001,6.172781005619186e+000,-2.015808156820983e+000,
        2.468424629045237e+000},{-3.350240391913771e+001,5.987415808641527e+000,
        -1.995312918218178e+000,2.465048253049681e+000},{-3.199442787158013e+001,
        5.808188295000401e+000,-1.975177003091340e+000,2.461663152566335e+000},
        {-3.056024706213614e+001,5.634871106705811e+000,-1.955393281837274e+000,
        2.458269235223206e+000},{-2.919596443353868e+001,5.467245898489124e+000,
        -1.935954801423811e+000,2.454866407362862e+000},{-2.789793559611147e+001,
        5.305103425707614e+000,-1.916854781506048e+000,2.451454574017747e+000},
        {-2.666269215914849e+001,5.148242631442525e+000,-1.898086608731207e+000,
        2.448033638884868e+000},{-2.548697421306633e+001,4.996470669372890e+000,
        -1.879643833139071e+000,2.444603504299887e+000},{-2.436770123450288e+001,
        4.849602373431799e+000,-1.861520163342853e+000,2.441164071210578e+000},
        {-2.330195977537568e+001,4.707459922705984e+000,-1.843709462409692e+000,
        2.437715239149616e+000},{-2.228699227843552e+001,4.569872530071029e+000,
        -1.826205743845993e+000,2.434256906206701e+000},{-2.132020684497282e+001,
        4.436676277522927e+000,-1.809003167843803e+000,2.430788968999998e+000},
        {-2.039914018532746e+001,4.307713579632853e+000,-1.792096036957894e+000,
        2.427311322646843e+000},{-1.952146936347992e+001,4.182833098600734e+000,
        -1.775478792886058e+000,2.423823860733728e+000},{-1.868499316966931e+001,
        4.061889380846185e+000,-1.759146012624790e+000,2.420326475285513e+000},
        {-1.788763992768876e+001,3.944742723944577e+000,-1.743092405205007e+000,
        2.416819056733864e+000},{-1.712743344254924e+001,3.831258705580187e+000,
        -1.727312807882854e+000,2.413301493884874e+000},{-1.640252210380573e+001,
        3.721308274346385e+000,-1.711802183566103e+000,2.409773673885858e+000},
        {-1.571113655820867e+001,3.614767188724737e+000,-1.696555616858599e+000,
        2.406235482191265e+000},{-1.505161347050935e+001,3.511516100089723e+000,
        -1.681568311719631e+000,2.402686802527732e+000},{-1.442237501501945e+001,
        3.411440183535207e+000,-1.666835588003566e+000,2.399127516858194e+000},
        {-1.382192281792874e+001,3.314428957926218e+000,-1.652352878705905e+000,
        2.395557505345059e+000},{-1.324884440234419e+001,3.220376204778547e+000,
        -1.638115727371166e+000,2.391976646312384e+000},{-1.270179534791704e+001,
        3.129179660595857e+000,-1.624119785066449e+000,2.388384816207066e+000},
        {-1.217950533160762e+001,3.040740960771689e+000,-1.610360808057413e+000,
        2.384781889558960e+000},{-1.168077185108037e+001,2.954965440505362e+000,
        -1.596834655106244e+000,2.381167738939920e+000},{-1.120445287471011e+001,
        2.871761949263363e+000,-1.583537284982829e+000,2.377542234921738e+000},
        {-1.074945938906329e+001,2.791042690386217e+000,-1.570464754127387e+000,
        2.373905246032895e+000},{-1.031477532863617e+001,2.712723290948242e+000,
        -1.557613214714723e+000,2.370256638714139e+000},{-9.899418059077929e+000,
        2.636722293125727e+000,-1.544978911524978e+000,2.366596277272797e+000},
        {-9.502469882015735e+000,2.562961407683305e+000,-1.532558180831734e+000,
        2.362924023835828e+000},{-9.123051186031617e+000,2.491365115660259e+000,
        -1.520347447494355e+000,2.359239738301530e+000},{-8.760330847138221e+000,
        2.421860710047537e+000,-1.508343223428605e+000,2.355543278289859e+000},
        {-8.413522164671106e+000,2.354378147536363e+000,-1.496542105459269e+000,
        2.351834499091346e+000},{-8.081872986226925e+000,2.288849868571785e+000,
        -1.484940773296089e+000,2.348113253614503e+000},{-7.764673182380162e+000,
        2.225210809410545e+000,-1.473535988024564e+000,2.344379392331724e+000},
        {-7.461247253240972e+000,2.163398232030816e+000,-1.462324590067311e+000,
        2.340632763223554e+000},{-7.170954402974354e+000,2.103351655486919e+000,
        -1.451303497568699e+000,2.336873211721342e+000},{-6.893183429082948e+000,
        2.045012734099102e+000,-1.440469704675801e+000,2.333100580648147e+000},
        {-6.627356535854197e+000,1.988325235265094e+000,-1.429820280102758e+000,
        2.329314710157896e+000},{-6.372924033280025e+000,1.933234904863000e+000,
        -1.419352365401565e+000,2.325515437672646e+000},{-6.129360718270444e+000,
        1.879689376009046e+000,-1.409063173503607e+000,2.321702597817965e+000},
        {-5.896172583475862e+000,1.827638183228592e+000,-1.398949987494580e+000,
        2.317876022356293e+000},{-5.672883417268298e+000,1.777032546809523e+000,
        -1.389010158827584e+000,2.314035540118214e+000},{-5.459048060392687e+000,
        1.727825480131581e+000,-1.379241106510718e+000,2.310180976931593e+000},
        {-5.254234210794342e+000,1.679971515124929e+000,-1.369640315213699e+000,
        2.306312155548433e+000},{-5.058040409876274e+000,1.633426877234746e+000,
        -1.360205334751793e+000,2.302428895569415e+000},{-4.870075449851535e+000,
        1.588149172977625e+000,-1.350933778115679e+000,2.298531013365968e+000},
        {-4.689974661286671e+000,1.544097561802145e+000,-1.341823321100738e+000,
        2.294618321999826e+000},{-4.517385486985614e+000,1.501232515510214e+000,
        -1.332871700581220e+000,2.290690631139916e+000},{-4.351976351638122e+000,
        1.459515900408742e+000,-1.324076713954947e+000,2.286747746976495e+000},
        {-4.193429409227905e+000,1.418910831861334e+000,-1.315436217803243e+000,
        2.282789472132387e+000},{-4.041441822526155e+000,1.379381663626085e+000,
        -1.306948127133261e+000,2.278815605571236e+000},{-3.895727955783459e+000,
        1.340893969545224e+000,-1.298610414512591e+000,2.274825942502597e+000},
        {-3.756011643772165e+000,1.303414407478659e+000,-1.290421108956039e+000,
        2.270820274283760e+000},{-3.622034405547364e+000,1.266910796845365e+000,
        -1.282378295516774e+000,2.266798388318138e+000},{-3.493546180189254e+000,
        1.231351952460242e+000,-1.274480114091720e+000,2.262760067950088e+000},
        {-3.370310607726903e+000,1.196707735821732e+000,-1.266724759068044e+000,
        2.258705092355959e+000},{-3.252103437476587e+000,1.162948988902917e+000,
        -1.259110478484196e+000,2.254633236431245e+000},{-3.138708072538556e+000,
        1.130047448209561e+000,-1.251635573300534e+000,2.250544270673615e+000},
        {-3.029921490748561e+000,1.097975801268001e+000,-1.244298397138752e+000,
        2.246437961061666e+000},{-2.925547647484275e+000,1.066707556584218e+000,
        -1.237097355384933e+000,2.242314068929141e+000},{-2.825400740172198e+000,
        1.036217072961828e+000,-1.230030904983982e+000,2.238172350834462e+000},
        {-2.729304069234395e+000,1.006479509244643e+000,-1.223097553890867e+000,
        2.234012558425291e+000},{-2.637088175181507e+000,9.774707739265413e-001,
        -1.216295860641661e+000,2.229834438297897e+000},{-2.548592797119484e+000,
        9.491675292708579e-001,-1.209624434141700e+000,2.225637731851086e+000},
        {-2.463663423753487e+000,9.215471164859220e-001,-1.203081933219051e+000,
        2.221422175134388e+000},{-2.382154682227609e+000,8.945875849149885e-001,
        -1.196667066602152e+000,2.217187498690240e+000},{-2.303926482472558e+000,
        8.682676066340345e-001,-1.190378592501879e+000,2.212933427389838e+000},
        {-2.228846495422617e+000,8.425664957592878e-001,-1.184215318682858e+000,
        2.208659680262342e+000},{-2.156787119809440e+000,8.174641394548649e-001,
        -1.178176102225793e+000,2.204365970317081e+000},{-2.087628043470757e+000,
        7.929410200343601e-001,-1.172259849701592e+000,2.200052004358389e+000},
        {-2.021254023899635e+000,7.689781539219797e-001,-1.166465517041273e+000,
        2.195717482792678e+000},{-1.957555062242275e+000,7.455570794959029e-001,
        -1.160792109727399e+000,2.191362099427352e+000},{-1.896426533402995e+000,
        7.226598392117595e-001,-1.155238682973756e+000,2.186985541261074e+000},
        {-1.837768826064559e+000,7.002689535529851e-001,-1.149804341937003e+000,
        2.182587488264949e+000},{-1.781486665007183e+000,6.783673926406706e-001,
        -1.144488242010365e+000,2.178167613154132e+000},{-1.727489645225360e+000,
        6.569385677311423e-001,-1.139289589251027e+000,2.173725581149271e+000},
        {-1.675691487477748e+000,6.359662992671422e-001,-1.134207640777898e+000,
        2.169261049727270e+000},{-1.626009927752474e+000,6.154347993672957e-001,
        -1.129241705325752e+000,2.164773668360731e+000},{-1.578367042581602e+000,
        5.953286591428831e-001,-1.124391143878772e+000,2.160263078245440e+000},
        {-1.532688000054525e+000,5.756328107329074e-001,-1.119655370298758e+000,
        2.155728912015201e+000},{-1.488902369669526e+000,5.563325343394894e-001,
        -1.115033852224612e+000,2.151170793443280e+000},{-1.446942756513707e+000,
        5.374134146917063e-001,-1.110526111833913e+000,2.146588337129652e+000},
        {-1.406744919308124e+000,5.188613303492935e-001,-1.106131726888593e+000,
        2.141981148173249e+000},{-1.368248520348087e+000,5.006624488336312e-001,
        -1.101850331860153e+000,2.137348821828268e+000},{-1.331395630230789e+000,
        4.828031818949505e-001,-1.097681619010324e+000,2.132690943143583e+000},
        {-1.296131540592206e+000,4.652701873924490e-001,-1.093625339819990e+000,
        2.128007086584252e+000},{-1.262404709408866e+000,4.480503487048833e-001,
        -1.089681306389480e+000,2.123296815633988e+000},{-1.230165851283160e+000,
        4.311307419976398e-001,-1.085849392958450e+000,2.118559682377429e+000},
        {-1.199368710297917e+000,4.144986359366915e-001,-1.082129537707425e+000,
        2.113795227060934e+000},{-1.169969608591567e+000,3.981414637443046e-001,
        -1.078521744549609e+000,2.109002977630553e+000},{-1.141927349834720e+000,
        3.820468046501531e-001,-1.075026085156083e+000,2.104182449245702e+000},
        {-1.115203082457214e+000,3.662023649698341e-001,-1.071642701147781e+000,
        2.099333143767018e+000},{-1.089760490754199e+000,3.505959636314658e-001,
        -1.068371806469075e+000,2.094454549216662e+000},{-1.065565676036384e+000,
        3.352155103263428e-001,-1.065213689919650e+000,2.089546139209323e+000},
        {-1.042586729117127e+000,3.200489791680136e-001,-1.062168717889230e+000,
        2.084607372351953e+000},{-1.020794201818640e+000,3.050843996188034e-001,
        -1.059237337384420e+000,2.079637691610172e+000},{-1.000160851423267e+000,
        2.903098297929833e-001,-1.056420079188220e+000,2.074636523639092e+000},
        {-9.806614973337507e-001,2.757133333948358e-001,-1.053717561313666e+000,
        2.069603278076170e+000},{-9.622732693844609e-001,2.612829629773606e-001,
        -1.051130492745526e+000,2.064537346793446e+000},{-9.449750965802405e-001,
        2.470067276370440e-001,-1.048659677405065e+000,2.059438103106439e+000},
        {-9.287484495069965e-001,2.328725849863756e-001,-1.046306018534049e+000,
        2.054304900936606e+000},{-9.135767353123816e-001,2.188684014719849e-001,
        -1.044070523246075e+000,2.049137073924143e+000},{-8.994453596884484e-001,
        2.049819299554718e-001,-1.041954307568271e+000,2.043933934487611e+000},
        {-8.863420305972949e-001,1.912007886144718e-001,-1.039958601844730e+000,
        2.038694772826542e+000},{-8.742566684377657e-001,1.775124284430896e-001,
        -1.038084756497729e+000,2.033418855862917e+000},{-8.631812697459577e-001,
        1.639040998219162e-001,-1.036334248261912e+000,2.028105426117050e+000},
        {-8.531101234321912e-001,1.503628248396395e-001,-1.034708686935291e+000,
        2.022753700513037e+000},{-8.440398362033877e-001,1.368753624716768e-001,
        -1.033209822617653e+000,2.017362869108479e+000},{-8.359695776931154e-001,
        1.234281750538496e-001,-1.031839553532223e+000,2.011932093742809e+000},
        {-8.289005178126103e-001,1.100073763809098e-001,-1.030599934401732e+000,
        2.006460506597966e+000},{-8.228370327534438e-001,9.659871547150999e-002,
        -1.029493185682019e+000,2.000947208664684e+000},{-8.177855931109604e-001,
        8.318750209275284e-002,-1.028521703215806e+000,1.995391268106987e+000},
        {-8.137559409386451e-001,6.975858534653368e-002,-1.027688069030039e+000,
        1.989791718516891e+000},{-8.107605455362672e-001,5.629628320384371e-002,
        -1.026995062703656e+000,1.984147557050458e+000},{-8.088151684966699e-001,
        4.278433685925803e-002,-1.026445673888504e+000,1.978457742435633e+000},
        {-8.079389176695084e-001,2.920584547725917e-002,-1.026043115762180e+000,
        1.972721192841307e+000},{-8.081545055075236e-001,1.554320066626404e-002,
        -1.025790839663862e+000,1.966936783596047e+000},{-8.094885690941598e-001,
        1.778015394473135e-003,-1.025692550981584e+000,1.961103344743805e+000},
        {-8.119862698864362e-001,-1.210870698156008e-002,-1.025752227366026e+000,
        1.955219658422625e+000},{-8.156795691276541e-001,-2.613710375287741e-002,
        -1.025974136034128e+000,1.949284456050977e+000},{-8.205859499113112e-001,
        -4.032871488155882e-002,-1.026362854927959e+000,1.943296415304725e+000},
        {-8.267080955867543e-001,-5.494775286888999e-002,-1.026933948323617e+000,
        1.937154374999355e+000},{-8.340034681281544e-001,-6.956792894448306e-002,
        -1.027675693302118e+000,1.931045251398180e+000},{-8.424606360805104e-001,
        -8.417588056073176e-002,-1.028583863802415e+000,1.924981823573036e+000},
        {-8.520744170015872e-001,-9.878905079285071e-002,-1.029655444551397e+000,
        1.918963711773316e+000},{-8.628424957952819e-001,-1.134242872327940e-001,
        -1.030887586075559e+000,1.912990539037579e+000},{-8.747657918779217e-001,
        -1.280978812135765e-001,-1.032277595480934e+000,1.907061931185783e+000},
        {-8.878479382283583e-001,-1.428256278541051e-001,-1.033822927640486e+000,
        1.901177516818667e+000},{-9.020955906247847e-001,-1.576228613739366e-001,
        -1.035521177062222e+000,1.895336927323218e+000},{-9.175179556117891e-001,
        -1.725045083448280e-001,-1.037370070125957e+000,1.889539796883510e+000},
        {-9.341272433353944e-001,-1.874851158489946e-001,-1.039367457933408e+000,
        1.883785762496073e+000},{-9.519380335091618e-001,-2.025789039960535e-001,
        -1.041511309452197e+000,1.878074463988979e+000},{-9.709677271759698e-001,
        -2.177997890193544e-001,-1.043799705248612e+000,1.872405544044008e+000},
        {-9.912364175083539e-001,-2.331614219124641e-001,-1.046230831486630e+000,
        1.866778648221036e+000},{-1.012766648729506e+000,-2.486772255078792e-001,
        -1.048802974335914e+000,1.861193424984079e+000},{-1.035583653239251e+000,
        -2.643604184910795e-001,-1.051514514791885e+000,1.855649525728494e+000},
        {-1.059715403422719e+000,-2.802240450910093e-001,-1.054363923766542e+000,
        1.850146604808510e+000},{-1.085192428404830e+000,-2.962810076523094e-001,
        -1.057349757490633e+000,1.844684319564752e+000},{-1.112047840284971e+000,
        -3.125440918568987e-001,-1.060470653253161e+000,1.839262330351305e+000},
        {-1.140317779786924e+000,-3.290259844501270e-001,-1.063725325428120e+000,
        1.833880300561731e+000},{-1.170040772767701e+000,-3.457393129150245e-001,
        -1.067112561661264e+000,1.828537896653743e+000},{-1.201258334460249e+000,
        -3.626966549827271e-001,-1.070631219467131e+000,1.823234788172321e+000},
        {-1.234015008677897e+000,-3.799105645052093e-001,-1.074280222931547e+000,
        1.817970647770632e+000},{-1.268357889035586e+000,-3.973936035490504e-001,
        -1.078058559640830e+000,1.812745151228863e+000},{-1.304337381224103e+000,
        -4.151583481991378e-001,-1.081965277933464e+000,1.807557977470460e+000},
        {-1.342006818795918e+000,-4.332174201542663e-001,-1.085999484193767e+000,
        1.802408808575871e+000},{-1.381422811192989e+000,-4.515835009140273e-001,
        -1.090160340433320e+000,1.797297329793238e+000},{-1.422645114412084e+000,
        -4.702693556220330e-001,-1.094447061989566e+000,1.792223229546457e+000},
        {-1.465736793308509e+000,-4.892878500123289e-001,-1.098858915416110e+000,
        1.787186199439965e+000},{-1.510764665910317e+000,-5.086519632583179e-001,
        -1.103395216529062e+000,1.782185934260665e+000},{-1.557798713989053e+000,
        -5.283748197187160e-001,-1.108055328517688e+000,1.777222131976678e+000},
        {-1.606913024249304e+000,-5.484696901100445e-001,-1.112838660328233e+000,
        1.772294493733011e+000},{-1.658185052376375e+000,-5.689500256907437e-001,
        -1.117744665009237e+000,1.767402723844188e+000},{-1.711696835419274e+000,
        -5.898294555775258e-001,-1.122772838338994e+000,1.762546529783867e+000},
        {-1.767533848479072e+000,-6.111218280850936e-001,-1.127922717367707e+000,
        1.757725622171410e+000},{-1.825786241452084e+000,-6.328412048781662e-001,
        -1.133193879281465e+000,1.752939714755770e+000},{-1.886548675522292e+000,
        -6.550018871713900e-001,-1.138585940177355e+000,1.748188524396311e+000},
        {-1.949919791236933e+000,-6.776184419015450e-001,-1.144098553976703e+000,
        1.743471771041181e+000},{-2.016003811123379e+000,-7.007056923572437e-001,
        -1.149731411542488e+000,1.738789177703054e+000},{-2.084909407036162e+000,
        -7.242787611639050e-001,-1.155484239633304e+000,1.734140470432365e+000},
        {-2.156750372091127e+000,-7.483530737647965e-001,-1.161356800148957e+000,
        1.729525378288342e+000},{-2.231627926685809e+000,-7.729445823064577e-001,
        -1.167348888802051e+000,1.724943633307832e+000},{-2.309782982776231e+000,
        -7.980678185970754e-001,-1.173460339702013e+000,1.720394970472067e+000},
        {-2.391033663426555e+000,-8.237439135656604e-001,-1.179691000681487e+000,
        1.715879127671712e+000},{-2.475869227142783e+000,-8.499832002901067e-001,
        -1.186040793336751e+000,1.711395845671781e+000},{-2.563702595314027e+000,
        -8.768125482108226e-001,-1.192509607048069e+000,1.706944868064386e+000},
        {-2.653854883122921e+000,-9.042518387765622e-001,-1.199097403535986e+000,
        1.702525941248357e+000},{-2.766079959594875e+000,-9.320924259943205e-001,
        -1.205804687265605e+000,1.698138814375825e+000},{-2.836837888537308e+000,
        -9.612314004857536e-001,-1.212628993373840e+000,1.693783239359507e+000},
        {-2.962833314784326e+000,-9.901728646594288e-001,-1.219575772839467e+000,
        1.689458970942077e+000},{-3.065797818595779e+000,-1.020307105997146e+000,
        -1.226639028725659e+000,1.685165765209986e+000},{-3.179146555811669e+000,
        -1.051016019187351e+000,-1.233822305642099e+000,1.680903383115731e+000},
        {-3.297284348618891e+000,-1.082440812070858e+000,-1.241124966094870e+000,
        1.676671586493826e+000},{-3.420414306708996e+000,-1.114602326672745e+000,
        -1.248547175601712e+000,1.672470140103473e+000},{-3.548747934055633e+000,
        -1.147521940179529e+000,-1.256089127934521e+000,1.668298811149195e+000},
        {-3.682505857052307e+000,-1.181221572474609e+000,-1.263751044854284e+000,
        1.664157369235286e+000},{-3.821915807343334e+000,-1.215723723768695e+000,
        -1.271533175757266e+000,1.660045586320429e+000},{-3.967214733237526e+000,
        -1.251051449579780e+000,-1.279435797479266e+000,1.655963236672333e+000},
        {-4.118645118574411e+000,-1.287228408806640e+000,-1.287459213783149e+000,
        1.651910096822906e+000},{-4.280211341706425e+000,-1.324244351504146e+000,
        -1.295603825538186e+000,1.647885945523818e+000},{-4.453514772407470e+000,
        -1.362099245447999e+000,-1.303870050532300e+000,1.643890563702867e+000},
        {-4.640395688977453e+000,-1.400781827377156e+000,-1.312258462550433e+000,
        1.639923734421353e+000},{-4.842972282220500e+000,-1.444303609727521e+000,
        -1.321571915960135e+000,1.635617913591072e+000},{-5.077818607817462e+000,
        -1.489650226742146e+000,-1.331210828298044e+000,1.631266166750613e+000},
        {-5.269519269425579e+000,-1.537901012173168e+000,-1.341188853488693e+000,
        1.626867109373032e+000},{-5.551431069675780e+000,-1.587320333609772e+000,
        -1.351529036102523e+000,1.622419288010019e+000},{-5.808923042237106e+000,
        -1.639958440934728e+000,-1.362242057327564e+000,1.617921174006821e+000},
        {-6.095719050661056e+000,-1.695055063945981e+000,-1.373352317843512e+000,
        1.613371162616998e+000},{-6.404369551367121e+000,-1.752995378033357e+000,
        -1.384879806897964e+000,1.608767561543370e+000},{-6.737074974434417e+000,
        -1.813996281601904e+000,-1.396847279282773e+000,1.604108587787460e+000},
        {-7.096314427293298e+000,-1.878296278283565e+000,-1.409279272349471e+000,
        1.599392359891712e+000},{-7.484885584665084e+000,-1.946158190784704e+000,
        -1.422202288280279e+000,1.594616890192578e+000},{-7.905955622871398e+000,
        -2.017872214308587e+000,-1.435644999776433e+000,1.589780076274508e+000},
        {-8.363119801992593e+000,-2.093759464249109e+000,-1.449638482309929e+000,
        1.584879691522251e+000},{-8.860470601969707e+000,-2.174176076790771e+000,
        -1.464216477264085e+000,1.579913374653328e+000},{-9.402681541299199e+000,
        -2.259517940676243e+000,-1.479415690927240e+000,1.574878618093620e+000},
        {-9.995105596234213e+000,-2.350226224176583e+000,-1.495276135046780e+000,
        1.569772755037022e+000},{-1.064389482985112e+001,-2.446793798326975e+000,
        -1.511841516075586e+000,1.564592945003904e+000},{-1.135614240262710e+001,
        -2.549772781901460e+000,-1.529159681274163e+000,1.559336157681449e+000},
        {-1.214005414414541e+001,-2.659783392395340e+000,-1.547283131791800e+000,
        1.553999154791512e+000},{-1.300515543255768e+001,-2.777524377540540e+000,
        -1.566269614684388e+000,1.548578469686142e+000},{-1.396253928239969e+001,
        -2.903785372223432e+000,-1.586182808281310e+000,1.543070384316234e+000},
        {-1.502516407943721e+001,-3.039461566365826e+000,-1.607093118455835e+000,
        1.537470903152320e+000},{-1.620820834955008e+001,-3.185571181481919e+000,
        -1.629078606872898e+000,1.531775723555805e+000},{-1.756861317903349e+001,
        -3.342859695130933e+000,-1.652227062158571e+000,1.525980202000237e+000},
        {-1.896992968076159e+001,-3.514753551909730e+000,-1.676629844756208e+000,
        1.520079315421806e+000},{-2.070940498674979e+001,-3.698607679814522e+000,
        -1.702409666201476e+000,1.514067616830629e+000},{-2.258006445102759e+001,
        -3.900361852777759e+000,-1.729670196587357e+000,1.507939179287543e+000},
        {-2.472640864504724e+001,-4.119997968335903e+000,-1.758560156062154e+000,
        1.501687551187454e+000},{-2.717555760930571e+001,-4.360330688942441e+000,
        -1.789232432463443e+000,1.495305668348961e+000},{-2.998453612050399e+001,
        -4.624174865325230e+000,-1.821864001930955e+000,1.488785783609070e+000},
        {-3.322400657923019e+001,-4.914848588452856e+000,-1.856657070400842e+000,
        1.482119368890723e+000},{-3.698227739969207e+001,-5.236285870597177e+000,
        -1.893843826546765e+000,1.475297002040697e+000},{-4.137073781469906e+001,
        -5.593179752915376e+000,-1.933692326201029e+000,1.468308231964111e+000},
        {-4.653129624345377e+001,-5.991165877519198e+000,-1.976513837575755e+000,
        1.461141416796625e+000},{-5.264671942271787e+001,-6.437059666295744e+000,
        -2.022672094596102e+000,1.453783528293291e+000},{-5.995516440181747e+001,
        -6.939166169402911e+000,-2.072595066915272e+000,1.446219913491736e+000},
        {-6.877091752349767e+001,-7.507688498893050e+000,-2.126790093032183e+000,
        1.438434001794347e+000},{-7.951434352644553e+001,-8.155272910741649e+000,
        -2.185863560319914e+000,1.430406941556337e+000},{-9.282260741855799e+001,
        -8.896990368881466e+000,-2.250548709297550e+000,1.422117144536678e+000},
        {-1.092705800731509e+002,-9.755978248450887e+000,-2.321727653966861e+000,
        1.413539708353296e+000},{-1.303440861742615e+002,-1.075180658002727e+001,
        -2.400520525131451e+000,1.404645675124892e+000},{-1.573817172536041e+002,
        -1.192284129304266e+001,-2.488271989475859e+000,1.395401054361456e+000},
        {-1.929469781047582e+002,-1.330915824062231e+001,-2.586733173534589e+000,
        1.385765574728271e+000},{-2.407515409275657e+002,-1.496747918474029e+001,
        -2.698134813608466e+000,1.375690927154873e+000},{-3.067296511299643e+002,
        -1.697224306116501e+001,-2.825409191622562e+000,1.365118418615304e+000},
        {-4.007152627101729e+002,-1.942210540851691e+001,-2.972493248817588e+000,
        1.353975640846269e+000},{-5.399185840310040e+002,-2.244503642183699e+001,
        -3.144822779164391e+000,1.342171664024869e+000},{-7.560716744000814e+002,
        -2.620100919290446e+001,-3.350155100053136e+000,1.329589871746869e+000},
        {-1.113449606842879e+003,-3.084021110135518e+001,-3.600109952519693e+000,
        1.316076873033058e+000},{-1.690504862425243e+003,-3.710261655467448e+001,
        -3.911155756406296e+000,1.301424533021810e+000},{-2.670061268217115e+003,
        -4.640046513281821e+001,-4.309071967361942e+000,1.285339230723633e+000},
        {-4.481748438342077e+003,-6.187707883736660e+001,-4.834386672670042e+000,
        1.267385221467624e+000},{-8.164522417664276e+003,-6.838329256029518e+001,
        -5.390905548063032e+000,1.252292339125201e+000},{-1.652878983123607e+004,
        -6.410911523659486e+001,-6.181751840615706e+000,1.235307228164419e+000},
        {-3.589814816980765e+004,-5.850303396906464e+001,-7.379682885213981e+000,
        1.214800598771303e+000},{-8.037263246538142e+004,-1.135710262603827e+002,
        -9.097826769016773e+000,1.191007390096093e+000},{-1.821922090737477e+005,
        -2.354776316590442e+002,-1.127469694751144e+001,1.168783843757871e+000},
        {-4.484262360427870e+005,-1.929406030066214e+002,-1.390923719646678e+001,
        1.150438269719548e+000},{-1.121046496283366e+006,2.244014433727998e+002,
        -1.739509749280907e+001,1.133590960463892e+000},{-2.637332052450561e+006,
        2.537931543190984e+002,-2.209765636576909e+001,1.115407413029603e+000},
        {-5.907648512403362e+006,-4.012624018357776e+003,-2.901240599782692e+001,
        1.093221801784601e+000},{-1.195665812647725e+007,-7.565697091202631e+003,
        -3.507390000142389e+001,1.081141798451352e+000},{-2.784190228559279e+007,
        -2.474660221277177e+003,-3.985563387169906e+001,1.075521362860637e+000},
        {-8.260002532389586e+007,1.207599307914400e+004,-5.010461096457156e+001,
        1.065839017041407e+000},{-2.783054150157432e+008,6.191392637195736e+004,
        -6.812180721814856e+001,1.055309382343470e+000},{-8.984303648430897e+008,
        4.972036367617193e+004,-8.797612069577760e+001,1.041458768913245e+000},
        {-1.938721107426129e+009,-9.947883920780817e+004,-1.102739497257638e+002,
        1.031926967645291e+000},{-1.596711708673011e+013,7.576033677883548e+008,
        -8.980126598064539e+003,1.025706312840203e+000}};
    constant Real[Ninterval, 4] dvcoef={{4.918869918230695e+005,-1.567555888877598e+002,
        5.437208630256651e-001,5.503960828374048e-005},{4.550378123449924e+005,
        -1.523735197978206e+002,5.428795951631563e-001,5.651517998086538e-005},
        {4.154435854155241e+005,-1.485249049854512e+002,5.421736401433307e-001,
        5.778081864475579e-005},{3.741482472743288e+005,-1.409517385019123e+002,
        5.405774106280010e-001,6.075322570198208e-005},{3.367178855870678e+005,
        -1.337561394903371e+002,5.389802274088923e-001,6.387796804156671e-005},
        {3.032331897449884e+005,-1.269325231900327e+002,5.373822526407004e-001,
        6.716271877677984e-005},{2.729783236073526e+005,-1.204513648774790e+002,
        5.357833746302725e-001,7.061574208320135e-005},{2.457737771951380e+005,
        -1.143004549600878e+002,5.341836871213043e-001,7.424557939372635e-005},
        {2.212418903451594e+005,-1.084606313277702e+002,5.325831835730194e-001,
        7.806127539077440e-005},{1.991932319373264e+005,-1.029188757389579e+002,
        5.309819330350911e-001,8.207225038864295e-005},{1.793568834640014e+005,
        -9.765862295132199e+001,5.293799351427024e-001,8.628847726670124e-005},
        {1.614383537622045e+005,-9.266330277412550e+001,5.277772334623126e-001,
        9.072034242183298e-005},{1.453621714686960e+005,-8.792412794039890e+001,
        5.261738672668539e-001,9.537893269130447e-005},{1.308585174350236e+005,
        -8.342408029607272e+001,5.245698186895845e-001,1.002758063548368e-004},
        {1.178099872852326e+005,-7.915315147317665e+001,5.229651805648193e-001,
        1.054230003569786e-004},{1.060542653282609e+005,-7.509881556093026e+001,
        5.213599463406871e-001,1.108333568850558e-004},{9.549308124088842e+004,
        -7.125147962403636e+001,5.197541987519517e-001,1.165201514339942e-004},
        {8.600354913972432e+004,-6.759972330879310e+001,5.181479357221414e-001,
        1.224975427286338e-004},{7.761649543341427e+004,-6.414066678887514e+001,
        5.165412858073596e-001,1.287802891593490e-004},{7.020537948517055e+004,
        -6.086565981704204e+001,5.149343233861899e-001,1.353838849828343e-004},
        {6.362526510536840e+004,-5.781701794798269e+001,5.133590847200070e-001,
        1.421827481986982e-004},{5.777602598727927e+004,-5.506082706782908e+001,
        5.118681842941606e-001,1.489285080947021e-004},{5.249423222977891e+004,
        -5.245136198830269e+001,5.103869134700294e-001,1.559450852216556e-004},
        {4.772771403525848e+004,-4.998041590145706e+001,5.089152331130584e-001,
        1.632411903229066e-004},{4.341758916708818e+004,-4.763947665576765e+001,
        5.074530908455733e-001,1.708257343021365e-004},{3.952482258441854e+004,
        -4.542149360328381e+001,5.060004500938848e-001,1.787078304444174e-004},
        {3.599853857184100e+004,-4.331871999300164e+001,5.045572556408491e-001,
        1.868967966091156e-004},{3.281073717790914e+004,-4.132521822148750e+001,
        5.031234772300364e-001,1.954021573940050e-004},{2.991928864379426e+004,
        -3.943405746218934e+001,5.016990585808311e-001,2.042336462698480e-004},
        {2.730136743929938e+004,-3.764000095251405e+001,5.002839707362081e-001,
        2.134012076848843e-004},{2.492659063635537e+004,-3.593720253748594e+001,
        4.988781632750814e-001,2.229149991386049e-004},{2.276955125736159e+004,
        -3.432046079500933e+001,4.974815975109458e-001,2.327853932242566e-004},
        {2.081432755389784e+004,-3.278542777406340e+001,4.960942426492074e-001,
        2.430229796396210e-004},{1.903499917129547e+004,-3.132692253363413e+001,
        4.947160448050079e-001,2.536385671655345e-004},{1.741916761544805e+004,
        -2.994121669633407e+001,4.933469804327021e-001,2.646431856117704e-004},
        {1.594856799673893e+004,-2.862400374594620e+001,4.919870030103821e-001,
        2.760480877298892e-004},{1.461071366209510e+004,-2.737169558264001e+001,
        4.906360810069271e-001,2.878647510927006e-004},{1.339168327690314e+004,
        -2.618061339571608e+001,4.892941746173027e-001,3.001048799400484e-004},
        {1.228253049325166e+004,-2.504768084200302e+001,4.879612544780885e-001,
        3.127804069906575e-004},{1.126892157829276e+004,-2.396930264453291e+001,
        4.866372742930647e-001,3.259034952198203e-004},{1.034662065878251e+004,
        -2.294316241182801e+001,4.853222187890683e-001,3.394865396027453e-004},
        {9.503700936201338e+003,-2.196597276324068e+001,4.840160361000067e-001,
        3.535421688234263e-004},{8.734018189448401e+003,-2.103534947204093e+001,
        4.827187038678896e-001,3.680832469489622e-004},{8.031366011875803e+003,
        -2.014888458104759e+001,4.814301896622395e-001,3.831228750692300e-004},
        {7.388578355618841e+003,-1.930410181604127e+001,4.801504565658148e-001,
        3.986743929019504e-004},{6.800574870580942e+003,-1.849890723067505e+001,
        4.788794784376936e-001,4.147513803631108e-004},{6.262968091501257e+003,
        -1.773131649952538e+001,4.776172260185485e-001,4.313676591028885e-004},
        {5.770389109765950e+003,-1.699924277022264e+001,4.763636637585473e-001,
        4.485372940071114e-004},{5.319190052222050e+003,-1.630094266002941e+001,
        4.751187671980786e-001,4.662745946644320e-004},{4.905748845902255e+003,
        -1.563469347603085e+001,4.738825069166632e-001,4.845941167994040e-004},
        {4.526685334231427e+003,-1.499884943133974e+001,4.726548535498104e-001,
        5.035106636716925e-004},{4.178772802276819e+003,-1.439183882285007e+001,
        4.714357786189442e-001,5.230392874416343e-004},{3.859530682062243e+003,
        -1.381226047506382e+001,4.702252575271995e-001,5.431952905025171e-004},
        {3.566271424600439e+003,-1.325870013942056e+001,4.690232613675992e-001,
        5.639942267798111e-004},{3.296870650297050e+003,-1.272989003696022e+001,
        4.678297654512661e-001,5.854519029978606e-004},{3.049276098691007e+003,
        -1.222459719155169e+001,4.666447430986029e-001,6.075843799142949e-004},
        {2.821484408536768e+003,-1.174163338947488e+001,4.654681678733132e-001,
        6.304079735227145e-004},{2.611896527283416e+003,-1.127992855916830e+001,
        4.643000166997424e-001,6.539392562240592e-004},{2.419079453141731e+003,
        -1.083846133076433e+001,4.631402651077743e-001,6.781950579671866e-004},
        {2.241307272262556e+003,-1.041617660727023e+001,4.619888855086836e-001,
        7.031924673592141e-004},{2.077658736699405e+003,-1.001223689974768e+001,
        4.608458599404298e-001,7.289488327461664e-004},{1.926777017074004e+003,
        -9.625702150971902e+000,4.597111603812837e-001,7.554817632645456e-004},
        {1.787519449312663e+003,-9.255727615109393e+000,4.585847646064639e-001,
        7.828091298644552e-004},{1.659179395402279e+003,-8.901591924409631e+000,
        4.574666539228491e-001,8.109490663049823e-004},{1.540633616703145e+003,
        -8.562472211245941e+000,4.563568005087656e-001,8.399199701224020e-004},
        {1.431161858142325e+003,-8.237690859137757e+000,4.552551859319501e-001,
        8.697405035720722e-004},{1.330023377555299e+003,-7.926573334195409e+000,
        4.541617883382710e-001,9.004295945446778e-004},{1.236573482343776e+003,
        -7.628487285308340e+000,4.530765866476337e-001,9.320064374575882e-004},
        {1.150117985277077e+003,-7.342803184259996e+000,4.519995585201517e-001,
        9.644904941221798e-004},{1.070158684587523e+003,-7.068970548333955e+000,
        4.509306856964692e-001,9.979014945878772e-004},{9.961748371914198e+002,
        -6.806438520833332e+000,4.498699469983624e-001,1.032259437963822e-003},
        {9.276477356080152e+002,-6.554674171966223e+000,4.488173216777321e-001,
        1.067584593218963e-003},{8.641833883415839e+002,-6.313201947850644e+000,
        4.477727918978972e-001,1.103897499961509e-003},{8.053877216782303e+002,
        -6.081553232617854e+000,4.467363378201690e-001,1.141218969198647e-003},
        {7.508679837063625e+002,-5.859273363957273e+000,4.457079396593727e-001,
        1.179570084077442e-003},{7.003121955106866e+002,-5.645950416545300e+000,
        4.446875799042271e-001,1.218972200607816e-003},{6.534229224786275e+002,
        -5.441184593317924e+000,4.436752399301383e-001,1.259446948368720e-003},
        {6.098701132482534e+002,-5.244576566367364e+000,4.426709003094503e-001,
        1.301016231198290e-003},{5.694693580848956e+002,-5.055795182260655e+000,
        4.416745463024567e-001,1.343702227869144e-003},{5.319187630216652e+002,
        -4.874464882088055e+000,4.406861567650555e-001,1.387527392749791e-003},
        {4.970284952496925e+002,-4.700273550639881e+000,4.397057168100576e-001,
        1.432514456453111e-003},{4.646073398256017e+002,-4.532911236187518e+000,
        4.387332091303748e-001,1.478686426473104e-003},{4.344436320778534e+002,
        -4.372067882144371e+000,4.377686155875123e-001,1.526066587810795e-003},
        {4.063942942181745e+002,-4.217474280320218e+000,4.368119214276980e-001,
        1.574678503590567e-003},{3.802841770186233e+002,-4.068850532622352e+000,
        4.358631089330863e-001,1.624546015667824e-003},{3.559769108797973e+002,
        -3.925944939917800e+000,4.349221629490394e-001,1.675693245229227e-003},
        {3.333402909463835e+002,-3.788512906615899e+000,4.339890675369079e-001,
        1.728144593386517e-003},{3.122536180170024e+002,-3.656321586479176e+000,
        4.330638070558099e-001,1.781924741765163e-003},{2.925902763184365e+002,
        -3.529142319538135e+000,4.321463655932412e-001,1.837058653088838e-003},
        {2.742740781970119e+002,-3.406778654781579e+000,4.312367299211879e-001,
        1.893571571760979e-003},{2.571759037143193e+002,-3.289008496189263e+000,
        4.303348822713388e-001,1.951489024444565e-003},{2.412316234199518e+002,
        -3.175655844670625e+000,4.294408108599679e-001,2.010836820641156e-003},
        {2.263479765419118e+002,-3.066528653226592e+000,4.285544996055142e-001,
        2.071641053270657e-003},{2.124540881441975e+002,-2.961454863028191e+000,
        4.276759349468488e-001,2.133928099252665e-003},{1.994738967239204e+002,
        -2.860263446005821e+000,4.268051024338398e-001,2.197724620090749e-003},
        {1.873507685079785e+002,-2.762800207342723e+000,4.259419892085835e-001,
        2.263057562460898e-003},{1.760176881347635e+002,-2.668907362024899e+000,
        4.250865807774918e-001,2.329954158805295e-003},{1.654238211245136e+002,
        -2.578442894138812e+000,4.242388645871290e-001,2.398441927932571e-003},
        {1.555155973132484e+002,-2.491265813149157e+000,4.233988271501935e-001,
        2.468548675625884e-003},{1.462467369395943e+002,-2.407244188793173e+000,
        4.225664558320871e-001,2.540302495259932e-003},{1.375706942965182e+002,
        -2.326249402371831e+000,4.217417377784478e-001,2.613731768428245e-003},
        {1.294517522416703e+002,-2.248163891647594e+000,4.209246611933187e-001,
        2.688865165581934e-003},{1.218462678465571e+002,-2.172866771201884e+000,
        4.201152129124728e-001,2.765731646681044e-003},{1.147234040530867e+002,
        -2.100250995085103e+000,4.193133818831384e-001,2.844360461860063e-003},
        {1.080479787286075e+002,-2.030208123787794e+000,4.185191557975788e-001,
        2.924781152108462e-003},{1.017920655477493e+002,-1.962638710731280e+000,
        4.177325235641014e-001,3.007023549967833e-003},{9.592579946784062e+001,
        -1.897443919649623e+000,4.169534734756494e-001,3.091117780246804e-003},
        {9.042335241081501e+001,-1.834531404942512e+000,4.161819947150213e-001,
        3.177094260754840e-003},{8.526160053959171e+001,-1.773813276822706e+000,
        4.154180766062474e-001,3.264983703056518e-003},{8.041750410261692e+001,
        -1.715203736662323e+000,4.146617082903334e-001,3.354817113247324e-003},
        {7.586988596025167e+001,-1.658621120070368e+000,4.139128794048740e-001,
        3.446625792752341e-003},{7.159914621790271e+001,-1.603987470082015e+000,
        4.131715799027952e-001,3.540441339149129e-003},{6.758805543380534e+001,
        -1.551228969555801e+000,4.124378000649125e-001,3.636295647016206e-003},
        {6.381901401260075e+001,-1.500273202161896e+000,4.117115299747857e-001,
        3.734220908808124e-003},{6.027654566266498e+001,-1.451051972887889e+000,
        4.109927603593492e-001,3.834249615758861e-003},{5.694686162949886e+001,
        -1.403500300021269e+000,4.102814821535462e-001,3.936414558814610e-003},
        {5.381464616126993e+001,-1.357553381609505e+000,4.095776860201926e-001,
        4.040748829597288e-003},{5.086862121268142e+001,-1.313152746254192e+000,
        4.088813639116348e-001,4.147285821400251e-003},{4.809696746170313e+001,
        -1.270240281248384e+000,4.081925071806428e-001,4.256059230217466e-003},
        {4.548795219446311e+001,-1.228759645993116e+000,4.075111074687371e-001,
        4.367103055807410e-003},{4.303153877084944e+001,-1.188658139770851e+000,
        4.068371571482173e-001,4.480451602793230e-003},{4.071884002550738e+001,
        -1.149885475769847e+000,4.061706487359031e-001,4.596139481800510e-003},
        {3.853982359631466e+001,-1.112391283466330e+000,4.055115744704507e-001,
        4.714201610633783e-003},{3.648706442220689e+001,-1.076129903100120e+000,
        4.048599277728404e-001,4.834673215493562e-003},{3.455203104072965e+001,
        -1.041055261831986e+000,4.042157015223190e-001,4.957589832234991e-003},
        {3.272824992696282e+001,-1.007125200219632e+000,4.035788895850664e-001,
        5.082987307669529e-003},{3.100819917421405e+001,-9.742971021566538e-001,
        4.029494853695961e-001,5.210901800911449e-003},{2.938585708234636e+001,
        -9.425316926626286e-001,4.023274832668355e-001,5.341369784769924e-003},
        {2.785532702736859e+001,-9.117906925683219e-001,4.017128776362615e-001,
        5.474428047188925e-003},{2.641089462970517e+001,-8.820370796524276e-001,
        4.011056631033509e-001,5.610113692735653e-003},{2.504744509854464e+001,
        -8.532356843531500e-001,4.005058347752553e-001,5.748464144139499e-003},
        {2.376012690680433e+001,-8.253525682988094e-001,3.999133879843608e-001,
        5.889517143882834e-003},{2.254436515950055e+001,-7.983550679575092e-001,
        3.993283183805698e-001,6.033310755844880e-003},{2.139577493846826e+001,
        -7.722116978256376e-001,3.987506219417533e-001,6.179883367000695e-003},
        {2.031075898178054e+001,-7.468929148919709e-001,3.981802951854477e-001,
        6.329273689176286e-003},{1.928498435038579e+001,-7.223687585378505e-001,
        3.976173344075094e-001,6.481520760861736e-003},{1.831546512863807e+001,
        -6.986123544713665e-001,3.970617370876304e-001,6.636663949083660e-003},
        {1.739874302112455e+001,-6.755964878582553e-001,3.965135003282964e-001,
        6.794742951338802e-003},{1.653149368600032e+001,-6.532950634486524e-001,
        3.959726218194969e-001,6.955797797590126e-003},{1.571136413855040e+001,
        -6.316842473860278e-001,3.954391000465521e-001,7.119868852327289e-003},
        {1.493511547753208e+001,-6.107391370754174e-001,3.949129329852181e-001,
        7.286996816692762e-003},{1.420039845144105e+001,-5.904373123215700e-001,
        3.943941198649326e-001,7.457222730675804e-003},{1.350506994592831e+001,
        -5.707570615830940e-001,3.938826600000119e-001,7.630587975375203e-003},
        {1.284647108422737e+001,-5.516762826357500e-001,3.933785526503101e-001,
        7.807134275333396e-003},{1.222277796478104e+001,-5.331751751866478e-001,
        3.928817982791715e-001,7.986903700942806e-003},{1.163191695951530e+001,
        -5.152338073353088e-001,3.923923971864010e-001,8.169938670926894e-003},
        {1.107213284474227e+001,-4.978333946436397e-001,3.919103503368385e-001,
        8.356281954897082e-003},{1.054149664309521e+001,-4.809552921213819e-001,
        3.914356588874424e-001,8.545976675988149e-003},{1.003852662470317e+001,
        -4.645822992591858e-001,3.909683248378932e-001,8.739066313572592e-003},
        {9.561664872804187e+000,-4.486973760480717e-001,3.905083502824061e-001,
        8.935594706057733e-003},{9.109335246091527e+000,-4.332839483801887e-001,
        3.900557377878584e-001,9.135606053765538e-003},{8.680382947929710e+000,
        -4.183267593479249e-001,3.896104907230568e-001,9.339144921898225e-003},
        {8.273324247996497e+000,-4.038101468153956e-001,3.891726123742362e-001,
        9.546256243591643e-003},{7.887079182136844e+000,-3.897198414232183e-001,
        3.887421070574992e-001,9.756985323057689e-003},{7.520443323253075e+000,
        -3.760415771209294e-001,3.883189792052398e-001,9.971377838818433e-003},
        {7.172391400254022e+000,-3.627618922961474e-001,3.879032339530123e-001,
        1.018947984703397e-002},{6.841893907962348e+000,-3.498676232857845e-001,
        3.874948768109323e-001,1.041133778492567e-002},{6.527997017874895e+000,
        -3.373461375524688e-001,3.870939138736296e-001,1.063699847429761e-002},
        {6.229808364298923e+000,-3.251852702502093e-001,3.867003517682037e-001,
        1.086650912515772e-002},{5.946507856507541e+000,-3.133733224079474e-001,
        3.863141976591653e-001,1.109991733944163e-002},{5.677262450077949e+000,
        -3.018988533524630e-001,3.859354591756860e-001,1.133727111484078e-002},
        {5.421352794634765e+000,-2.907510173390247e-001,3.855641446431972e-001,
        1.157861884873768e-002},{5.178044952198035e+000,-2.799191865535771e-001,
        3.852002628309458e-001,1.182400934225040e-002},{4.946713848640733e+000,
        -2.693932865271758e-001,3.848438232049179e-001,1.207349180438865e-002},
        {4.726667248951112e+000,-2.591633075488187e-001,3.844948356365955e-001,
        1.232711585632465e-002},{4.517394406394665e+000,-2.492199984536905e-001,
        3.841533108804939e-001,1.258493153578013e-002},{4.318248173877903e+000,
        -2.395539223666578e-001,3.838192599352582e-001,1.284698930153326e-002},
        {4.128755543462441e+000,-2.301564276641476e-001,3.834926948075274e-001,
        1.311334003804745e-002},{3.948400040450002e+000,-2.210188987207532e-001,
        3.831736278767949e-001,1.338403506022480e-002},{3.776706557031288e+000,
        -2.121330737099716e-001,3.828620722535667e-001,1.365912611828752e-002},
        {3.613235615589715e+000,-2.034909988612184e-001,3.825580417231296e-001,
        1.393866540278966e-002},{3.457552934484986e+000,-1.950849326143231e-001,
        3.822615507012779e-001,1.422270554976199e-002},{3.309289747397522e+000,
        -1.869075184953642e-001,3.819726143711710e-001,1.451129964599359e-002},
        {3.168027635565692e+000,-1.789514180717389e-001,3.816912484468373e-001,
        1.480450123445292e-002},{3.033432541611965e+000,-1.712097771328688e-001,
        3.814174695766434e-001,1.510236431985102e-002},{2.905177939665958e+000,
        -1.636758970404103e-001,3.811512950075380e-001,1.540494337435146e-002},
        {2.782931144489786e+000,-1.563432183214555e-001,3.808927426753809e-001,
        1.571229334342843e-002},{2.666380912718784e+000,-1.492054387832750e-001,
        3.806418313441766e-001,1.602446965187827e-002},{2.555276695079573e+000,
        -1.422566004739850e-001,3.803985806210800e-001,1.634152820998644e-002},
        {2.449295076606051e+000,-1.354906337033831e-001,3.801630106447514e-001,
        1.666352541985449e-002},{2.348233464609053e+000,-1.289020699204486e-001,
        3.799351427205061e-001,1.699051818189040e-002},{2.251825859416809e+000,
        -1.224852907459614e-001,3.797149986002554e-001,1.732256390146563e-002},
        {2.159830546635063e+000,-1.162349453169496e-001,3.795026010329486e-001,
        1.765972049574360e-002},{2.072058189589333e+000,-1.101459982440797e-001,
        3.792979737057716e-001,1.800204640068242e-002},{1.988279437621665e+000,
        -1.042133641825461e-001,3.791011409474683e-001,1.834960057821797e-002},
        {1.908304088873131e+000,-9.843225925896297e-002,3.789121281419708e-001,
        1.870244252362887e-002},{1.831966481347027e+000,-9.279808329654883e-002,
        3.787309615388108e-001,1.906063227308990e-002},{1.759063885369890e+000,
        -8.730619512825491e-002,3.785576681372098e-001,1.942423041141704e-002},
        {1.689442954866666e+000,-8.195229176988321e-002,3.783922761004630e-001,
        1.979329808000917e-002},{1.622952654628118e+000,-7.673215449994221e-002,
        3.782348144266670e-001,2.016789698499184e-002},{1.559425467803564e+000,
        -7.164160304756834e-002,3.780853130129168e-001,2.054808940556589e-002},
        {1.498739703281514e+000,-6.667675646191087e-002,3.779438029211383e-001,
        2.093393820256837e-002},{1.440744669602029e+000,-6.183368436111730e-002,
        3.778103160133016e-001,2.132550682724936e-002},{1.385323321761285e+000,
        -5.710870924118614e-002,3.776848853473129e-001,2.172285933027002e-002},
        {1.332347619367673e+000,-5.249817996692605e-002,3.775675449108211e-001,
        2.212606037092868e-002},{1.281706587252000e+000,-4.799861330288496e-002,
        3.774583298354774e-001,2.253517522661828e-002},{1.233286775513597e+000,
        -4.360659269821209e-002,3.773572762902370e-001,2.295026980252321e-002},
        {1.186989610982328e+000,-3.931885012278981e-002,3.772644216056396e-001,
        2.337141064156014e-002},{1.142709310723802e+000,-3.513215772395206e-002,
        3.771798041763876e-001,2.379866493456963e-002},{1.100364054184835e+000,
        -3.104347409546139e-002,3.771034636540305e-001,2.423210053076392e-002},
        {1.059849057888973e+000,-2.704971323541650e-002,3.770354407144567e-001,
        2.467178594843880e-002},{1.021092249072365e+000,-2.314803353433318e-002,
        3.769757774433468e-001,2.511779038595530e-002},{9.840075377705944e-001,
        -1.933557117879185e-002,3.769245169864941e-001,2.557018373299856e-002},
        {9.485193352610145e-001,-1.560958934131050e-002,3.768817038258078e-001,
        2.602903658212011e-002},{9.145571430630910e-001,-1.196743397082525e-002,
        3.768473837166201e-001,2.649442024057316e-002},{8.820469590864203e-001,
        -8.406493879188376e-003,3.768216036884748e-001,2.696640674244555e-002},
        {8.509285119314395e-001,-4.924290603556751e-003,3.768044121832929e-001,
        2.744506886110065e-002},{8.211340609415847e-001,-1.518356287428216e-003,
        3.767958589199679e-001,2.793048012193355e-002},{7.926086375394551e-001,
        1.813649114228547e-003,3.767959950973827e-001,2.842271481544971e-002},{
        7.652929944655803e-001,5.074044032923294e-003,3.768048732667741e-001,
        2.892184801067763e-002},{7.391329197825297e-001,8.265062590104030e-003,
        3.768225474785089e-001,2.942795556892074e-002},{7.140800335116605e-001,
        1.138886128687014e-002,3.768490732805331e-001,2.994111415786120e-002},{
        6.900802188495476e-001,1.444758203811515e-002,3.768845076851303e-001,
        3.046140126602262e-002},{6.670923614724178e-001,1.744324178592566e-002,
        3.769289093561197e-001,3.098889521760341e-002},{6.450691071878270e-001,
        2.037785914287436e-002,3.769823384460632e-001,3.152367518768998e-002},{
        6.239696575093529e-001,2.325336642648719e-002,3.770448567964210e-001,
        3.206582121785987e-002},{6.037510611099373e-001,2.607166756790367e-002,
        3.771165278758674e-001,3.261541423218719e-002},{5.843794053727025e-001,
        2.883457191774331e-002,3.771974169112035e-001,3.317253605366046e-002},{
        5.658147755261427e-001,3.154389410629092e-002,3.772875907776753e-001,
        3.373726942102517e-002},{5.480231161544660e-001,3.420136776566449e-002,
        3.773871182015341e-001,3.430969800606262e-002},{5.309724570385872e-001,
        3.680868184153350e-002,3.774960697125371e-001,3.488990643131756e-002},{
        5.146295233740406e-001,3.936750010466255e-002,3.776145176754647e-001,
        3.547798028828863e-002},{4.989652245345753e-001,4.187942343633730e-002,
        3.777425363985507e-001,3.607400615609310e-002},{4.839508951570389e-001,
        4.434602120425499e-002,3.778802021164517e-001,3.667807162062187e-002},{
        4.695586251393293e-001,4.676882656463798e-002,3.780275930601468e-001,
        3.729026529419736e-002},{4.557625505429792e-001,4.914932842369436e-002,
        3.781847895177411e-001,3.791067683575024e-002},{4.425376937773825e-001,
        5.148898190841291e-002,3.783518738637359e-001,3.853939697152988e-002},{
        4.298602277084476e-001,5.378920663485787e-002,3.785289306177614e-001,
        3.917651751636464e-002},{4.177069453640965e-001,5.605139045206042e-002,
        3.787160464931026e-001,3.982213139548867e-002},{4.060584771999545e-001,
        5.827687113517555e-002,3.789133104735820e-001,4.047633266695239e-002},{
        3.948906268608474e-001,6.046699738585702e-002,3.791208137811170e-001,
        4.113921654463403e-002},{3.841870232133331e-001,6.262303268347103e-002,
        3.793386501060483e-001,4.181087942187154e-002},{3.739265762012089e-001,
        6.474625902500740e-002,3.795669154584302e-001,4.249141889573269e-002},{
        3.640921561536769e-001,6.683790154597202e-002,3.798057084001543e-001,
        4.318093379194452e-002},{3.546670821834087e-001,6.889916478367825e-002,
        3.800551300119356e-001,4.387952419050235e-002},{3.456348352625734e-001,
        7.093123341959720e-002,3.803152839747856e-001,4.458729145197930e-002},{
        3.369785561122604e-001,7.293527279624670e-002,3.805862766488284e-001,
        4.530433824455851e-002},{3.286851767658728e-001,7.491239979095070e-002,
        3.808682171819050e-001,4.603076857181217e-002},{3.207394347235971e-001,
        7.686373551656341e-002,3.811612174764944e-001,4.676668780125029e-002},{
        3.131280975545644e-001,7.879036541765304e-002,3.814653923662434e-001,
        4.751220269366369e-002},{3.058374247107702e-001,8.069336289010372e-002,
        3.817808596349681e-001,4.826742143328867e-002},{2.988566601058779e-001,
        8.257376243678892e-002,3.821077401446526e-001,4.903245365881852e-002},{
        2.921719464565475e-001,8.443261163535294e-002,3.824461578200114e-001,
        4.980741049529087e-002},{2.857739928784489e-001,8.627090300499446e-002,
        3.827962398805592e-001,5.059240458687936e-002},{2.796503942775182e-001,
        8.808964658709946e-002,3.831581167626421e-001,5.138755013061990e-002},{
        2.737916253179937e-001,8.988981115731574e-002,3.835319223574790e-001,
        5.219296291110304e-002},{2.681881525413893e-001,9.167235767109909e-002,
        3.839177940069860e-001,5.300876033616471e-002},{2.628297823694911e-001,
        9.343824154080706e-002,3.843158726191478e-001,5.383506147361034e-002},{
        2.577083882939691e-001,9.518838846980050e-002,3.847263028172936e-001,
        5.467198708900604e-002},{2.528146968098489e-001,9.692372676861677e-002,
        3.851492329671904e-001,5.551965968457499e-002},{2.481407625412646e-001,
        9.864516159899474e-002,3.855848153536583e-001,5.637820353923723e-002},{
        2.436792821405074e-001,1.003535861532541e-001,3.860332062506214e-001,
        5.724774474983266e-002},{2.394228253416791e-001,1.020498895213405e-001,
        3.864945660289071e-001,5.812841127356713e-002},{2.353627081090076e-001,
        1.037349621793819e-001,3.869690592847504e-001,5.902033297172822e-002},{
        2.314947402031453e-001,1.054096452054131e-001,3.874568550524591e-001,
        5.992364165471450e-002},{2.278102791323715e-001,1.070748228351733e-001,
        3.879581267137887e-001,6.083847112842353e-002},{2.243046124050026e-001,
        1.087313304366365e-001,3.884730523862753e-001,6.176495724204952e-002},{
        2.209710682148270e-001,1.103800228757795e-001,3.890018148594768e-001,
        6.270323793734339e-002},{2.178041486530274e-001,1.120217365977945e-001,
        3.895446018605192e-001,6.365345329938535e-002},{2.147992288835744e-001,
        1.136572986272354e-001,3.901016061552393e-001,6.461574560892683e-002},{
        2.119504441278575e-001,1.152875476716101e-001,3.906730256654490e-001,
        6.559025939636390e-002},{2.092533159443932e-001,1.169133040170711e-001,
        3.912590637138232e-001,6.657714149739562e-002},{2.067032739670428e-001,
        1.185353897562482e-001,3.918599291191595e-001,6.757654111043797e-002},{
        2.042961465696757e-001,1.201546233006569e-001,3.924758363922071e-001,
        6.858860985585547e-002},{2.020274264697294e-001,1.217718271650500e-001,
        3.931070059001712e-001,6.961350183708251e-002},{1.998934200278083e-001,
        1.233878153258157e-001,3.937536640855738e-001,7.065137370370449e-002},{
        1.978906676118772e-001,1.250034030877950e-001,3.944160436227127e-001,
        7.170238471657542e-002},{1.960149967375316e-001,1.266194158856914e-001,
        3.950943836109010e-001,7.276669681505510e-002},{1.942639589257347e-001,
        1.282366627914691e-001,3.957889298488906e-001,7.384447468644079e-002},{
        1.926334395158679e-001,1.298559775451477e-001,3.964999349368981e-001,
        7.493588583769048e-002},{1.911216527090522e-001,1.314781710093624e-001,
        3.972276586428074e-001,7.604110066951825e-002},{1.897244443573727e-001,
        1.331040891931062e-001,3.979723679677965e-001,7.716029255296758e-002},{
        1.884406453288555e-001,1.347345473673733e-001,3.987343375897471e-001,
        7.829363790855320e-002},{1.872665265601232e-001,1.363704021692120e-001,
        3.995138498928030e-001,7.944131628808254e-002},{1.862007615810149e-001,
        1.380124863528179e-001,4.003111954501998e-001,8.060351045926381e-002},{
        1.852405381185921e-001,1.396616628531729e-001,4.011266731139843e-001,
        8.178040649321632e-002},{1.843843241480039e-001,1.413187870896886e-001,
        4.019605904389793e-001,8.297219385500310e-002},{1.836301668974131e-001,
        1.429847328561038e-001,4.028132638873196e-001,8.417906549731445e-002},{
        1.829760794685091e-001,1.446603849414294e-001,4.036850191842593e-001,
        8.540121795743359e-002},{1.824211264871903e-001,1.463466283642914e-001,
        4.045761916625467e-001,8.663885145762512e-002},{1.819631618475816e-001,
        1.480443786791565e-001,4.054871265152293e-001,8.789217000909319e-002},{
        1.816016538481242e-001,1.497545442283934e-001,4.064181792768163e-001,
        8.916138151966188e-002},{1.813349324261531e-001,1.514780668535952e-001,
        4.073697160521965e-001,9.044669790534266e-002},{1.811620760240895e-001,
        1.532158932804673e-001,4.083421140201370e-001,9.174833520595821e-002},{
        1.810826213005452e-001,1.549689846495924e-001,4.093357617802799e-001,
        9.306651370500112e-002},{1.810952242372437e-001,1.567383340769575e-001,
        4.103510597385373e-001,9.440145805391896e-002},{1.811998433905139e-001,
        1.585249366978412e-001,4.113884206505568e-001,9.575339740102104e-002},{
        1.813956689375554e-001,1.603298228620418e-001,4.124482699601924e-001,
        9.712256552522057e-002},{1.816823933789322e-001,1.621540381227494e-001,
        4.135310463731760e-001,9.850920097482685e-002},{1.820599684503609e-001,
        1.639986506841799e-001,4.146372023209510e-001,9.991354721162989e-002},{
        1.825281279631850e-001,1.658647591954069e-001,4.157672044730891e-001,
        1.013358527605122e-001},{1.830871732976372e-001,1.677534826607340e-001,
        4.169215343307577e-001,1.027763713648546e-001},{1.837369499625757e-001,
        1.696659773067486e-001,4.181006887506906e-001,1.042353621480049e-001},{
        1.844781042590138e-001,1.716034189674459e-001,4.193051806207994e-001,
        1.057130897811016e-001},{1.853108783667900e-001,1.735670247032512e-001,
        4.205355394147057e-001,1.072098246575544e-001},{1.862361146072027e-001,
        1.755580382624963e-001,4.217923119273905e-001,1.087258430745072e-001},{
        1.872542658540640e-001,1.775777478187758e-001,4.230760629130649e-001,
        1.102614274216203e-001},{1.883664161066458e-001,1.796274712137456e-001,
        4.243873758852488e-001,1.118168663775390e-001},{1.895736042833884e-001,
        1.817085709127874e-001,4.257268538261469e-001,1.133924551144239e-001},{
        1.908769430286885e-001,1.838224530798516e-001,4.270951200211710e-001,
        1.149884955109506e-001},{1.922778327149997e-001,1.859705667570249e-001,
        4.284928189189925e-001,1.166052963742057e-001},{1.937778134238934e-001,
        1.881544096840238e-001,4.299206170087649e-001,1.182431736709383e-001},{
        1.953785161419524e-001,1.903755314738871e-001,4.313792037637430e-001,
        1.199024507686402e-001},{1.970818360106390e-001,1.926355337251292e-001,
        4.328692926418148e-001,1.215834586869736e-001},{1.988898297699773e-001,
        1.949360754056711e-001,4.343916221158705e-001,1.232865363600858e-001},{
        2.008046698894440e-001,1.972788765871647e-001,4.359469567739310e-001,
        1.250120309103874e-001},{2.028288942436377e-001,1.996657181573041e-001,
        4.375360884891066e-001,1.267602979344092e-001},{2.049649981449501e-001,
        2.020984525641909e-001,4.391598376128025e-001,1.285317018013877e-001},{
        2.072159412632179e-001,2.045789987236268e-001,4.408190543010555e-001,
        1.303266159652730e-001},{2.095848139500683e-001,2.071093533752463e-001,
        4.425146198364234e-001,1.321454232908996e-001},{2.120747994517689e-001,
        2.096915950472666e-001,4.442474480766267e-001,1.339885163951064e-001},{
        2.146896366486244e-001,2.123278812982627e-001,4.460184869960368e-001,
        1.358562980036432e-001},{2.174330624393193e-001,2.150204647564746e-001,
        4.478287202391585e-001,1.377491813247640e-001},{2.203091662968168e-001,
        2.177716908634281e-001,4.496791688610775e-001,1.396675904404572e-001},{
        2.233224795982417e-001,2.205840035106147e-001,4.515708931119363e-001,
        1.416119607163322e-001},{2.264775934106465e-001,2.234599582551517e-001,
        4.535049943124936e-001,1.435827392312657e-001},{2.297796161462891e-001,
        2.264022198467781e-001,4.554826169139364e-001,1.455803852279571e-001},{
        2.332339727580958e-001,2.294135744742551e-001,4.575049506012141e-001,
        1.476053705856567e-001},{2.368464516137537e-001,2.324969364640791e-001,
        4.595732325689487e-001,1.496581803163948e-001},{2.406231945523244e-001,
        2.356553566145465e-001,4.616887499294117e-001,1.517393130861526e-001},{
        2.445708289741049e-001,2.388920286712658e-001,4.638528422778431e-001,
        1.538492817625101e-001},{2.486964917723498e-001,2.422102993641000e-001,
        4.660669044016151e-001,1.559886139904228e-001},{2.530076500232799e-001,
        2.456136819772180e-001,4.683323891611289e-001,1.581578527979037e-001},{
        2.575124198255152e-001,2.491058607958477e-001,4.706508105994867e-001,
        1.603575572335084e-001},{2.622194715578140e-001,2.526907061233002e-001,
        4.730237471960758e-001,1.625883030377006e-001},{2.671380191367600e-001,
        2.563722872425211e-001,4.754528453647684e-001,1.648506833502761e-001},{
        2.722780089338211e-001,2.601548827603011e-001,4.779398231980150e-001,
        1.671453094562546e-001},{2.776499422163085e-001,2.640429994212740e-001,
        4.804864744277954e-001,1.694728115728024e-001},{2.832652297087600e-001,
        2.680413810642935e-001,4.830946727123900e-001,1.718338396799571e-001},{
        2.891360595449805e-001,2.721550304002138e-001,4.857663761527585e-001,
        1.742290643981639e-001},{2.952753902018427e-001,2.763892276998674e-001,
        4.885036321697845e-001,1.766591779158700e-001},{3.016972268760389e-001,
        2.807495456513702e-001,4.913085827436155e-001,1.791248949706735e-001},{
        3.084166142336471e-001,2.852418733111838e-001,4.941834699821898e-001,
        1.816269538878832e-001},{3.154496431133436e-001,2.898724405299774e-001,
        4.971306421192923e-001,1.841661176805713e-001},{3.228136488040175e-001,
        2.946478403193760e-001,5.001525599745869e-001,1.867431752156427e-001},{
        3.305272701993334e-001,2.995750572746494e-001,5.032518038700848e-001,
        1.893589424508100e-001},{3.386106566497629e-001,3.046614955486481e-001,
        5.064310810895980e-001,1.920142637477638e-001},{3.470853252620201e-001,
        3.099150166755338e-001,5.096932338829231e-001,1.947100132673631e-001},{
        3.559747578322673e-001,3.153439644648628e-001,5.130412481742362e-001,
        1.974470964531553e-001},{3.653040508329576e-001,3.209572158003464e-001,
        5.164782628307193e-001,2.002264516101224e-001},{3.751005268804078e-001,
        3.267642117238987e-001,5.200075798247715e-001,2.030490515862380e-001},{
        3.853936367929098e-001,3.327750113808939e-001,5.236326750964294e-001,
        2.059159055650719e-001},{3.962153242954108e-001,3.390003384908145e-001,
        5.273572104049557e-001,2.088280609785455e-001},{4.076002326752048e-001,
        3.454516381993498e-001,5.311850461311969e-001,2.117866055497767e-001},{
        4.195859580454628e-001,3.521411385938809e-001,5.351202551856762e-001,
        2.147926694769877e-001},{4.322133830106544e-001,3.590819173408294e-001,
        5.391671381277255e-001,2.178474277705093e-001},{4.455847504181922e-001,
        3.662869712655928e-001,5.433302434909894e-001,2.209521027562080e-001},{
        4.597024094143034e-001,3.737717322143078e-001,5.476143770879206e-001,
        2.241079667600003e-001},{4.745555429725229e-001,3.815533474816013e-001,
        5.520246277787561e-001,2.273163449897146e-001},{4.901257557583882e-001,
        3.897937038015808e-001,5.566421198401972e-001,2.306327012079619e-001},{
        5.063188762578222e-001,3.982520969512932e-001,5.613313187177943e-001,
        2.339568479963076e-001},{5.231506865568163e-001,4.069158720726419e-001,
        5.660827733888582e-001,2.372813206159511e-001},{5.406462578991202e-001,
        4.157904644940312e-001,5.708968304793926e-001,2.406057414176632e-001},{
        5.588316450226307e-001,4.248814441409453e-001,5.757738454519713e-001,
        2.439297408582211e-001},{5.777342003001672e-001,4.341945133486757e-001,
        5.807141825807703e-001,2.472529573723387e-001},{5.973823532328585e-001,
        4.437355186814879e-001,5.857182148492396e-001,2.505750372458956e-001},{
        6.178058903813788e-001,4.535104497074449e-001,5.907863239449198e-001,
        2.538956344906717e-001},{6.390358272679809e-001,4.635254487171909e-001,
        5.959189001915087e-001,2.572144107206164e-001},{6.611046329585031e-001,
        4.737868116278242e-001,6.011163425492457e-001,2.605310350297160e-001},{
        6.840461012924548e-001,4.843009977730023e-001,6.063790585717825e-001,
        2.638451838715473e-001},{7.078955339544499e-001,4.950746315277593e-001,
        6.117074644259439e-001,2.671565409405211e-001},{7.326898428585754e-001,
        5.061145075622476e-001,6.171019848856783e-001,2.704647970548958e-001},{
        7.584674735300413e-001,5.174275997007870e-001,6.225630533267513e-001,
        2.737696500416191e-001},{7.852685225837038e-001,5.290210645205079e-001,
        6.280911117643314e-001,2.770708046228762e-001},{8.131349523353069e-001,
        5.409022444662868e-001,6.336866108855748e-001,2.803679723045419e-001},{
        8.421104635778781e-001,5.530786787453849e-001,6.393500100554367e-001,
        2.836608712664611e-001},{8.722406215697443e-001,5.655581071809576e-001,
        6.450817773793988e-001,2.869492262544884e-001},{9.035731218920524e-001,
        5.783484730140734e-001,6.508823897607542e-001,2.902327684744185e-001},{
        9.361575777347176e-001,5.914579359394194e-001,6.567523329200065e-001,
        2.935112354877266e-001},{9.700458060496284e-001,6.048948732292336e-001,
        6.626921014911419e-001,2.967843711090281e-001},{1.005291989370011e+000,
        6.186678860505348e-001,6.687021990776449e-001,3.000519253054242e-001},{
        1.041952490869116e+000,6.327858120001110e-001,6.747831383002202e-001,
        3.033136540975303e-001},{1.080086214331775e+000,6.472577257095189e-001,
        6.809354409115697e-001,3.065693194622796e-001},{1.119754627068662e+000,
        6.620929484858137e-001,6.871596378556201e-001,3.098186892373309e-001},{
        1.161021912738447e+000,6.773010550003773e-001,6.934562693572517e-001,
        3.130615370273069e-001},{1.203954887498334e+000,6.928918842065448e-001,
        6.998258850011435e-001,3.162976421114647e-001},{1.248623406898427e+000,
        7.088755407142894e-001,7.062690438568339e-001,3.195267893531296e-001},{
        1.295100419859135e+000,7.252624056040015e-001,7.127863145497119e-001,
        3.227487691105891e-001},{1.343461839212578e+000,7.420631486316124e-001,
        7.193782753529641e-001,3.259633771495041e-001},{1.393787066100554e+000,
        7.592887285293669e-001,7.260455143290677e-001,3.291704145568307e-001},{
        1.446158832199879e+000,7.769504079175785e-001,7.327886293986805e-001,
        3.323696876561625e-001},{1.500663624657993e+000,7.950597567053790e-001,
        7.396082284751718e-001,3.355610079244260e-001},{1.557391483641027e+000,
        8.136286676665213e-001,7.465049295460156e-001,3.387441919099931e-001},{
        1.616436486202836e+000,8.326693587008284e-001,7.534793608199935e-001,
        3.419190611519823e-001},{1.677896904646256e+000,8.521943838823333e-001,
        7.605321608220843e-001,3.450854421009717e-001},{1.741874983769677e+000,
        8.722166491849841e-001,7.676639784917609e-001,3.482431660408027e-001},{
        1.808477704796359e+000,8.927494114574271e-001,7.748754733450998e-001,
        3.513920690115978e-001},{1.877816685279789e+000,9.138062955612120e-001,
        7.821673155490562e-001,3.545319917339357e-001},{1.950008110826083e+000,
        9.354013076198702e-001,7.895401860415601e-001,3.576627795341115e-001},{
        2.025176264842242e+000,9.575488033850547e-001,7.969947767714907e-001,
        3.607842822704026e-001},{2.103446939662919e+000,9.802636143987048e-001,
        8.045317904513486e-001,3.638963542604584e-001},{2.184913845243859e+000,
        1.003561394684095e+000,8.121519401501026e-001,3.669988542095216e-001},{
        2.269763220050740e+000,1.027456793165435e+000,8.198559544878306e-001,
        3.700916451436019e-001},{2.357786913578639e+000,1.051969888877999e+000,
        8.276445572115562e-001,3.731745943241333e-001},{2.448578982729761e+000,
        1.077119371791434e+000,8.355184943898608e-001,3.762475732019303e-001},{
        2.554495397712962e+000,1.102780965056649e+000,8.434788475409446e-001,
        3.793104573307565e-001},{2.636142944230747e+000,1.129517864911584e+000,
        8.515248441466035e-001,3.823631262876039e-001},{2.753576242195605e+000,
        1.156408150188240e+000,8.596606204334905e-001,3.854054635554983e-001},{
        2.858337969405045e+000,1.184320228835573e+000,8.678832015184743e-001,
        3.884373570657307e-001},{2.971207245092491e+000,1.212877645710290e+000,
        8.761955271692427e-001,3.914586976410320e-001},{3.088790819517250e+000,
        1.242174717307695e+000,8.845979360059516e-001,3.944693805727305e-001},{
        3.211290782525183e+000,1.272231405920666e+000,8.930912596503021e-001,
        3.974693046888215e-001},{3.338918141302322e+000,1.303068219692468e+000,
        9.016763420849130e-001,4.004583724710529e-001},{3.471892018272730e+000,
        1.334706240150083e+000,9.103540397044045e-001,4.034364899924997e-001},{
        3.610440645775533e+000,1.367167120982722e+000,9.191252214485987e-001,
        4.064035668556145e-001},{3.754800508814665e+000,1.400473111418473e+000,
        9.279907688104051e-001,4.093595161310653e-001},{3.905216477735271e+000,
        1.434647058532653e+000,9.369515758788880e-001,4.123042542968515e-001},{
        4.065670804884121e+000,1.469678174488928e+000,9.460086192933500e-001,
        4.152377011781764e-001},{4.237761502904625e+000,1.505565867821763e+000,
        9.551628791098028e-001,4.181597798876018e-001},{4.423332904730818e+000,
        1.542298398896243e+000,9.644154775777063e-001,4.210704167656975e-001},{
        4.624516092786303e+000,1.583704725720241e+000,9.746473707878920e-001,
        4.242404029888883e-001},{4.850196574686571e+000,1.626991736963335e+000,
        9.851937689726753e-001,4.274553962053975e-001},{5.056790030629979e+000,
        1.672846557345158e+000,9.960690537668240e-001,4.307167462684177e-001},{
        5.322780585611914e+000,1.720316041896115e+000,1.007293551783249e+000,
        4.340258706136082e-001},{5.581856116174721e+000,1.770664322860376e+000,
        1.018880860299036e+000,4.373842594703593e-001},{5.866088407465559e+000,
        1.823520560177389e+000,1.030853140388873e+000,4.407934798537482e-001},{
        6.171923002120571e+000,1.879189565923113e+000,1.043230569280668e+000,
        4.442551829095663e-001},{6.501535536191801e+000,1.937885751613769e+000,
        1.056035595849955e+000,4.477711093076880e-001},{6.857377194386117e+000,
        1.999844889612192e+000,1.069292431020710e+000,4.513430963808631e-001},{
        7.242214043652889e+000,2.065326797427353e+000,1.083027227973919e+000,
        4.549730857610047e-001},{7.659178646510535e+000,2.134618343011173e+000,
        1.097268285542566e+000,4.586631318040277e-001},{8.111827066134506e+000,
        2.208036973520845e+000,1.112046277772487e+000,4.624154109045757e-001},{
        8.604208529071581e+000,2.285934758959754e+000,1.127394514184514e+000,
        4.662322318172514e-001},{9.140948252644797e+000,2.368703086413673e+000,
        1.143349235435159e+000,4.701160471199221e-001},{9.727346257355944e+000,
        2.456778125271054e+000,1.159949950207535e+000,4.740694659762598e-001},{
        1.036949636473117e+001,2.550647201445953e+000,1.177239820295516e+000,
        4.780952683808142e-001},{1.107442943815378e+001,2.650856267473131e+000,
        1.195266102140809e+000,4.821964211012327e-001},{1.185028605617332e+001,
        2.758018689992081e+000,1.214080654794935e+000,4.863760955695670e-001},{
        1.270652798974013e+001,2.872825592971998e+000,1.233740526395416e+000,
        4.906376880197966e-001},{1.365419174621447e+001,2.996058162729545e+000,
        1.254308633466170e+000,4.949848422233832e-001},{1.470620059822895e+001,
        3.128602227412618e+000,1.275854551067133e+000,4.994214752410865e-001},{
        1.587774199700023e+001,3.271465705618580e+000,1.298455434935754e+000,
        5.039518066908264e-001},{1.720674254013149e+001,3.425586345730544e+000,
        1.322197606263238e+000,5.085803921309422e-001},{1.863402248089567e+001,
        3.593353579496717e+000,1.347174025974930e+000,5.133121612816782e-001},{
        2.032390211918452e+001,3.774153760759719e+000,1.373499219827730e+000,
        5.181524619605369e-001},{2.218601347832784e+001,3.971869398731903e+000,
        1.401284417001323e+000,5.231071115480921e-001},{2.431252464422925e+001,
        4.187482117105547e+000,1.430671346578243e+000,5.281824536278078e-001},{
        2.673985851010544e+001,4.423583955149483e+000,1.461812601611662e+000,
        5.333854293394883e-001},{2.952491937183151e+001,4.682968036424375e+000,
        1.494883366150635e+000,5.387236561640727e-001},{3.273828578159125e+001,
        4.968928762622564e+000,1.530083871593750e+000,5.442055229446516e-001},{
        3.646825750913934e+001,5.285374439016692e+000,1.567644134852697e+000,
        5.498403020789376e-001},{4.082633712570511e+001,5.636970657586560e+000,
        1.607829829067538e+000,5.556382833229866e-001},{4.595475926455129e+001,
        6.029324175734520e+000,1.650949619985925e+000,5.616109344677590e-001},{
        5.203696918320384e+001,6.469220871161562e+000,1.697364417633431e+000,
        5.677710957231201e-001},{5.931241581636025e+001,6.964936570782171e+000,
        1.747499159582017e+000,5.741332167790794e-001},{6.809776191782187e+001,
        7.526647036007701e+000,1.801857981792066e+000,5.807136484549547e-001},{
        7.881778054554678e+001,8.166974540194117e+000,1.861043982241702e+000,
        5.875310049495474e-001},{9.207856359262058e+001,8.901415236315513e+000,
        1.925786076833259e+000,5.946066185193436e-001},{1.085962925592044e+002,
        9.751235331139156e+000,1.996968777326911e+000,6.019651167819492e-001},{
        1.296612727594772e+002,1.073953725331416e+001,2.075696926484503e+000,
        6.096351651125727e-001},{1.568149508938095e+002,1.190149594899319e+001,
        2.163329563019325e+000,6.176504358167556e-001},{1.925895489261716e+002,
        1.327895255374134e+001,2.261610095071371e+000,6.260508899137490e-001},{
        2.407894220277205e+002,1.492863095592906e+001,2.372777247256969e+000,
        6.348845111387734e-001},{3.074933991972216e+002,1.692543720677949e+001,
        2.499777113694852e+000,6.442096900359834e-001},{4.028115941258301e+002,
        1.936864049070909e+001,2.646574749423806e+000,6.540985866240505e-001},{
        5.444627680553028e+002,2.238732251366779e+001,2.818658896530704e+000,
        6.646420006807281e-001},{7.654263901392872e+002,2.613984326739216e+001,
        3.023895327133340e+000,6.759566538738164e-001},{1.132473145221229e+003,
        3.077464245663644e+001,3.274097890822487e+000,6.881964979202373e-001},{
        1.728456306009293e+003,3.703669144378617e+001,3.586095407785845e+000,
        7.015710980094141e-001},{2.746345210190641e+003,4.636511685430635e+001,
        3.986312539776484e+000,7.163772638856115e-001},{4.641775374977525e+003,
        6.199723710600262e+001,4.516428772903993e+000,7.330575520262050e-001},{
        8.525657962231340e+003,6.810054194649604e+001,5.081630948855855e+000,
        7.472071449747022e-001},{1.741572862879567e+004,6.219045752188775e+001,
        5.890642485434674e+000,7.632728136051337e-001},{3.813458054210775e+004,
        5.370618375512508e+001,7.124228169883730e+000,7.828757764751582e-001},{
        8.589158440190039e+004,1.090981683303350e+002,8.902873285623791e+000,
        8.059157661363586e-001},{1.951303750681718e+005,2.375849575768755e+002,
        1.117514113283684e+001,8.277377240352704e-001},{4.782548713012288e+005,
        1.986473214368117e+002,1.394735114459777e+001,8.459822722289891e-001},{
        1.185655347397813e+006,-2.174684780917248e+002,1.762979102357640e+001,
        8.629254292602320e-001},{2.750846962420604e+006,-1.629109294341851e+002,
        2.259666061556802e+001,8.814128590616266e-001},{6.123913630880820e+006,
        4.322208699496733e+003,2.998861227777463e+001,9.042234397623542e-001},{
        1.223685185147719e+007,8.090218357744150e+003,3.638774289535504e+001,
        9.167366942666613e-001},{2.818621443600825e+007,3.085711548192580e+003,
        4.135729893033309e+001,9.225727665578074e-001},{8.316585285067827e+007,
        -1.136324148807467e+004,5.196252092604191e+001,9.326388658049112e-001},
        {2.794244200228550e+008,-6.113667992222013e+004,7.038061963269288e+001,
        9.435863614001085e-001},{9.252325428804928e+008,-5.487463721818197e+004,
        9.110802490104044e+001,9.579454741567480e-001},{2.237265034221097e+009,
        6.896819415082679e+004,1.142108494843807e+002,9.677749072712486e-001},{
        1.597732512872630e+013,-7.580581567199930e+008,8.988788796440838e+003,
        9.741584695812871e-001}};
    constant Real[Ninterval, 4] hlcoef={{7.395064117384627e+009,-1.280865388176200e+006,
        2.821575750527614e+002,1.833836171003976e-001},{6.597504135407492e+009,
        -1.212511325876777e+006,2.753491351615672e+002,1.841406426859871e-001},
        {5.780271674084454e+009,-1.152633155136978e+006,2.697490006419553e+002,
        1.847764786820451e-001},{4.958860729534658e+009,-1.042899311995140e+006,
        2.575580906113897e+002,1.862237508639398e-001},{4.254225882522524e+009,
        -9.436430636231016e+005,2.459280611632260e+002,1.876807622923263e-001},
        {3.649929287231926e+009,-8.538684890799312e+005,2.348330720290646e+002,
        1.891475943673219e-001},{3.131540328303725e+009,-7.726606490030770e+005,
        2.242477593033248e+002,1.906244199793511e-001},{2.686884429215740e+009,
        -6.992021917100513e+005,2.141484795719950e+002,1.921113515976508e-001},
        {2.305436681190764e+009,-6.327500405900241e+005,2.045124826635191e+002,
        1.936085324364108e-001},{1.978225892136117e+009,-5.726354169435729e+005,
        1.953183098525792e+002,1.951160756856359e-001},{1.697521363709874e+009,
        -5.182511799267425e+005,1.865453222831365e+002,1.966341253040380e-001},
        {1.456683048691095e+009,-4.690492050108880e+005,1.781740380829120e+002,
        1.981627952385604e-001},{1.250074360886440e+009,-4.245346083004282e+005,
        1.701855963205966e+002,1.997022606387281e-001},{1.072800606962726e+009,
        -3.842582037066196e+005,1.625621803354005e+002,2.012526666726048e-001},
        {9.207021541607516e+008,-3.478163169361438e+005,1.552869834519622e+002,
        2.028141285158312e-001},{7.901943344753319e+008,-3.148419383589053e+005,
        1.483437057813515e+002,2.043868226073761e-001},{6.782161334430934e+008,
        -2.850048993978956e+005,1.417170959818027e+002,2.059708649963459e-001},
        {5.825727219202920e+008,-2.580214571990632e+005,1.353924992211892e+002,
        2.075664330398644e-001},{5.018477901925672e+008,-2.336618459414496e+005,
        1.293563597550240e+002,2.091736741482984e-001},{4.336339749859386e+008,
        -2.116826692784306e+005,1.235956428311352e+002,2.107927362153820e-001},
        {3.759101976651321e+008,-1.921682462515702e+005,1.182042406216403e+002,
        2.123911161514204e-001},{3.267571477181848e+008,-1.752745050595466e+005,
        1.133228792803702e+002,2.139142206063779e-001},{2.843020873596044e+008,
        -1.599683613280694e+005,1.086775876446765e+002,2.154377045739531e-001},
        {2.475979262638457e+008,-1.460916038079511e+005,1.042554766441906e+002,
        2.169615822712266e-001},{2.158340827399827e+008,-1.335024950386115e+005,
        1.000444324122937e+002,2.184858675939239e-001},{1.883207309006085e+008,
        -1.220742895035692e+005,9.603307088337355e+001,2.200105741258566e-001},
        {1.644651841228906e+008,-1.116932087097448e+005,9.221068373842154e+001,
        2.215357151481048e-001},{1.437632632379007e+008,-1.022574640228438e+005,
        8.856720217299345e+001,2.230613036479431e-001},{1.257801607275091e+008,
        -9.367549193296053e+004,8.509314677627712e+001,2.245873523275273e-001},
        {1.101454874055535e+008,-8.586529010338520e+004,8.177959848067110e+001,
        2.261138736123414e-001},{9.653972368356156e+007,-7.875303244948787e+004,
        7.861815481978856e+001,2.276408796594130e-001},{8.468871988652200e+007,
        -7.227239695689626e+004,7.560090235615557e+001,2.291683823653079e-001},
        {7.435767250336401e+007,-6.636379223835093e+004,7.272038489459962e+001,
        2.306963933739068e-001},{6.534286001294021e+007,-6.097342167031716e+004,
        6.996957046343296e+001,2.322249240839693e-001},{5.747027807155222e+007,
        -5.605298520200417e+004,6.734183209615867e+001,2.337539856564991e-001},
        {5.058892155208572e+007,-5.155884014645571e+004,6.483091539577785e+001,
        2.352835890219054e-001},{4.456897749091873e+007,-4.745168641553626e+004,
        6.243092046710518e+001,2.368137448869720e-001},{3.929797808634566e+007,
        -4.369602037553607e+004,6.013627711697743e+001,2.383444637416446e-001},
        {3.467909626236541e+007,-4.025982723829874e+004,5.794172688510435e+001,
        2.398757558656324e-001},{3.062784360211651e+007,-3.711410238256247e+004,
        5.584230094500428e+001,2.414076313348311e-001},{2.707199455967587e+007,
        -3.423274054960324e+004,5.383330780575171e+001,2.429401000275848e-001},
        {2.394806063151847e+007,-3.159200650084850e+004,5.191030928225440e+001,
        2.444731716307669e-001},{2.120145854494023e+007,-2.917049319028297e+004,
        5.006911233397096e+001,2.460068556457158e-001},{1.878470848130406e+007,
        -2.694879400670043e+004,4.830575024370947e+001,2.475411613940012e-001},
        {1.665640139112113e+007,-2.490930349109187e+004,4.661646985518280e+001,
        2.490760980230453e-001},{1.478065625824185e+007,-2.303608166989841e+004,
        4.499772037807755e+001,2.506116745115950e-001},{1.312624886938225e+007,
        -2.131466500927661e+004,4.344614015879794e+001,2.521478996750478e-001},
        {1.166585545469223e+007,-1.973190580002538e+004,4.195854541513062e+001,
        2.536847821706443e-001},{1.037575804683703e+007,-1.827588228385652e+004,
        4.053192137337701e+001,2.552223305025196e-001},{9.235229821301350e+006,
        -1.693575336267236e+004,3.916341110770780e+001,2.567605530266264e-001},
        {8.226161529454760e+006,-1.570166014825697e+004,3.785030689607822e+001,
        2.582994579555294e-001},{7.332714409838634e+006,-1.456463239248035e+004,
        3.659004174391924e+001,2.598390533630776e-001},{6.541067280596239e+006,
        -1.351651109839700e+004,3.538018157148768e+001,2.613793471889549e-001},
        {5.839089097217685e+006,-1.254985887421323e+004,3.421841707983741e+001,
        2.629203472431124e-001},{5.216174993443639e+006,-1.165790355620624e+004,
        3.310255732922824e+001,2.644620612100892e-001},{4.663018167146263e+006,
        -1.083446843025749e+004,3.203052265688924e+001,2.660044966532249e-001},
        {4.171444464302824e+006,-1.007391792850541e+004,3.100033862903940e+001,
        2.675476610187589e-001},{3.734291063599596e+006,-9.371112234283090e+003,
        3.001013038565671e+001,2.690915616398324e-001},{3.345264196959495e+006,
        -8.721357281608769e+003,2.905811682622430e+001,2.706362057403845e-001},
        {2.998804824052956e+006,-8.120359510245587e+003,2.814260537246550e+001,
        2.721816004389522e-001},{2.690059117043254e+006,-7.564203866773062e+003,
        2.726198786072066e+001,2.737277527523759e-001},{2.414722165518809e+006,
        -7.049301389752438e+003,2.641473480407623e+001,2.752746695994082e-001},
        {2.169006576676412e+006,-6.572371181362734e+003,2.559939204631222e+001,
        2.768223578042399e-001},{1.949589547380671e+006,-6.130413910998713e+003,
        2.481457654061498e+001,2.783708240999319e-001},{1.753513335070667e+006,
        -5.720675273235230e+003,2.405897188170692e+001,2.799200751317631e-001},
        {1.578181984153911e+006,-5.340636910887383e+003,2.333132571024671e+001,
        2.814701174605012e-001},{1.421296797534924e+006,-4.987988415116040e+003,
        2.263044564557126e+001,2.830209575655875e-001},{1.280826297625475e+006,
        -4.660611060652745e+003,2.195519632940761e+001,2.845726018482448e-001},
        {1.154967887885402e+006,-4.356559333855659e+003,2.130449633293048e+001,
        2.861250566345134e-001},{1.042131487251255e+006,-4.074049315833184e+003,
        2.067731557349638e+001,2.876783281782094e-001},{9.409048828988477e+005,
        -3.811441190960783e+003,2.007267232055989e+001,2.892324226638147e-001},
        {8.500340926125752e+005,-3.567227768237408e+003,1.948963084447095e+001,
        2.907873462092958e-001},{7.684098011669957e+005,-3.340024748034876e+003,
        1.892729914062116e+001,2.923431048688557e-001},{6.950454961539843e+005,
        -3.128558197222760e+003,1.838482647741899e+001,2.938997046356221e-001},
        {6.290634426463042e+005,-2.931655562235562e+003,1.786140137631819e+001,
        2.954571514442698e-001},{5.696851277746989e+005,-2.748238224841836e+003,
        1.735624969777203e+001,2.970154511735833e-001},{5.162174096472578e+005,
        -2.577312465118152e+003,1.686863261843808e+001,2.985746096489578e-001},
        {4.680412177608077e+005,-2.417962027029424e+003,1.639784486931878e+001,
        3.001346326448444e-001},{4.246092785921820e+005,-2.269344049512283e+003,
        1.594321324426641e+001,3.016955258871379e-001},{3.854290946306968e+005,
        -2.130679129811940e+003,1.550409461031256e+001,3.032572950555081e-001},
        {3.500644784375472e+005,-2.001249801636266e+003,1.507987485327908e+001,
        3.048199457856796e-001},{3.181254941087923e+005,-1.880393392444164e+003,
        1.466996714224077e+001,3.063834836716620e-001},{2.892627964124076e+005,
        -1.767497553444107e+003,1.427381064630017e+001,3.079479142679245e-001},
        {2.631658597077979e+005,-1.661997457406561e+003,1.389086939175560e+001,
        3.095132430915293e-001},{2.395556802770178e+005,-1.563370394708744e+003,
        1.352063085122437e+001,3.110794756242089e-001},{2.181834226552594e+005,
        -1.471133577957063e+003,1.316260497547039e+001,3.126466173144076e-001},
        {1.988261272748282e+005,-1.384840332961980e+003,1.281632300534341e+001,
        3.142146735792670e-001},{1.812841164270276e+005,-1.304077374256214e+003,
        1.248133648021494e+001,3.157836498065826e-001},{1.653780267940605e+005,
        -1.228461972770334e+003,1.215721625109387e+001,3.173535513567038e-001},
        {1.509481016353733e+005,-1.157640295687853e+003,1.184355163838609e+001,
        3.189243835644045e-001},{1.378494330329677e+005,-1.091283635929976e+003,
        1.153994936397996e+001,3.204961517407096e-001},{1.259533798538558e+005,
        -1.029088314073179e+003,1.124603300581368e+001,3.220688611746812e-001},
        {1.151434947602917e+005,-9.707721560066344e+002,1.096144193815056e+001,
        3.236425171351746e-001},{1.053155086752598e+005,-9.160737446488935e+002,
        1.068583076706654e+001,3.252171248725524e-001},{9.637539799014138e+004,
        -8.647503663978431e+002,1.041886853531754e+001,3.267926896203659e-001},
        {8.823888454783670e+004,-8.165769553308005e+002,1.016023811189488e+001,
        3.283692165970028e-001},{8.082975256302909e+004,-7.713442852693606e+002,
        9.909635478268301e+000,3.299467110073037e-001},{7.407960702001616e+004,
        -7.288582119329744e+002,9.666769207898108e+000,3.315251780441446e-001},
        {6.792665838390439e+004,-6.889382110921721e+002,9.431359824692734e+000,
        3.331046228899912e-001},{6.231526198828789e+004,-6.514165353801458e+002,
        9.203139298263135e+000,3.346850507184217e-001},{5.719513812339059e+004,
        -6.161371424524319e+002,8.981850501633565e+000,3.362664666956208e-001},
        {5.252104982234649e+004,-5.829549835215390e+002,8.767246744918761e+000,
        3.378488759818509e-001},{4.825192751323921e+004,-5.517349069002831e+002,
        8.559091257223685e+000,3.394322837328866e-001},{4.435085262412058e+004,
        -5.223512693230589e+002,8.357156812102812e+000,3.410166951014356e-001},
        {4.078431692402485e+004,-4.946869454272916e+002,8.161225235617962e+000,
        3.426021152385257e-001},{3.752210023182508e+004,-4.686329059593669e+002,
        7.971087052548851e+000,3.441885492948688e-001},{3.453677849407373e+004,
        -4.440874766662903e+002,7.786541067524770e+000,3.457760024222062e-001},
        {3.180355626502269e+004,-4.209559160395517e+002,7.607394028698087e+000,
        3.473644797746268e-001},{2.929998425341201e+004,-3.991498796401928e+002,
        7.433460265705899e+000,3.489539865098665e-001},{2.700568725535247e+004,
        -3.785869240593804e+002,7.264561353833670e+000,3.505445277905829e-001},
        {2.490219323552633e+004,-3.591901229932722e+002,7.100525811207305e+000,
        3.521361087856166e-001},{2.297274465666998e+004,-3.408876693791219e+002,
        6.941188795306921e+000,3.537287346712248e-001},{2.120214641232764e+004,
        -3.236125217409932e+002,6.786391817255598e+000,3.553224106323019e-001},
        {1.957657344633676e+004,-3.073020267951967e+002,6.635982461076544e+000,
        3.569171418635831e-001},{1.808347931117164e+004,-2.918976581600808e+002,
        6.489814137991496e+000,3.585129335708239e-001},{1.671146762926517e+004,
        -2.773447131490234e+002,6.347745831608338e+000,3.601097909719717e-001},
        {1.545013740159694e+004,-2.635920046989097e+002,6.209641855271004e+000,
        3.617077192983143e-001},{1.429006951012745e+004,-2.505917089097457e+002,
        6.075371650375700e+000,3.633067237956181e-001},{1.322266968511326e+004,
        -2.382990480062072e+002,5.944809543387017e+000,3.649068097252486e-001},
        {1.224010132039165e+004,-2.266721040737960e+002,5.817834554960569e+000,
        3.665079823652802e-001},{1.133523722405783e+004,-2.156716504900735e+002,
        5.694330210582269e+000,3.681102470115885e-001},{1.050158642348279e+004,
        -2.052609525375157e+002,5.574184345532527e+000,3.697136089789342e-001},
        {9.733206313299734e+003,-1.954055676141257e+002,5.457288921742155e+000,
        3.713180736020321e-001},{9.024700730222718e+003,-1.860732540723482e+002,
        5.343539877398015e+000,3.729236462366104e-001},{8.371123402082400e+003,
        -1.772337586979163e+002,5.232836941729546e+000,3.745303322604583e-001},
        {7.767976360117369e+003,-1.688587391346637e+002,5.125083500057396e+000,
        3.761381370744614e-001},{7.211132037590188e+003,-1.609215840176348e+002,
        5.020186427402752e+000,3.777470661036311e-001},{6.696830442802067e+003,
        -1.533973451085674e+002,4.918055965107774e+000,3.793571247981251e-001},
        {6.221630107308341e+003,-1.462626001578099e+002,4.818605572961186e+000,
        3.809683186342531e-001},{5.782380642858814e+003,-1.394953568738606e+002,
        4.721751803873504e+000,3.825806531154816e-001},{5.376201651577415e+003,
        -1.330749668179309e+002,4.627414182825382e+000,3.841941337734274e-001},
        {5.000455207451565e+003,-1.269820315075479e+002,4.535515085732524e+000,
        3.858087661688454e-001},{4.652724834587218e+003,-1.211983226404149e+002,
        4.445979627643788e+000,3.874245558926092e-001},{4.330795240187265e+003,
        -1.157067060614417e+002,4.358735554805467e+000,3.890415085666860e-001},
        {4.032641019365463e+003,-1.104910799208306e+002,4.273713143506992e+000,
        3.906596298451056e-001},{3.756394747613435e+003,-1.055362848885977e+002,
        4.190845093212067e+000,3.922789254149277e-001},{3.500354297338667e+003,
        -1.008280802229431e+002,4.110066446614686e+000,3.938994009971991e-001},
        {3.262950609227280e+003,-9.635305138220821e+001,4.031314482734651e+000,
        3.955210623479115e-001},{3.042742369663052e+003,-9.209857304695458e+001,
        3.954528640335044e+000,3.971439152589546e-001},{2.838413065597216e+003,
        -8.805277060758006e+001,3.879650436609394e+000,3.987679655590649e-001},
        {2.648742989264185e+003,-8.420444188141711e+001,3.806623374949973e+000,
        4.003932191147761e-001},{2.472617600983757e+003,-8.054304904610477e+001,
        3.735392885948790e+000,4.020196818313603e-001},{2.309012318091831e+003,
        -7.705866086409024e+001,3.665906242883802e+000,4.036473596537750e-001},
        {2.156978720419112e+003,-7.374190599668950e+001,3.598112490902449e+000,
        4.052762585676071e-001},{2.015650036432498e+003,-7.058396265218144e+001,
        3.531962391385521e+000,4.069063846000124e-001},{1.884225012048499e+003,
        -6.757650377249485e+001,3.467408345228365e+000,4.085377438206608e-001},
        {1.761967295914424e+003,-6.471167807273380e+001,3.404404338708559e+000,
        4.101703423426775e-001},{1.648196125371299e+003,-6.198207308290163e+001,
        3.342905880402665e+000,4.118041863235865e-001},{1.542286784888126e+003,
        -5.938069940472492e+001,3.282869949941535e+000,4.134392819662572e-001},
        {1.443661841752103e+003,-5.690095495331793e+001,3.224254937399627e+000,
        4.150756355198507e-001},{1.351787821483400e+003,-5.453660450267201e+001,
        3.167020594458915e+000,4.167132532807668e-001},{1.266175045567968e+003,
        -5.228176450788781e+001,3.111127986917860e+000,4.183521415935981e-001},
        {1.186368387856992e+003,-5.013086904303047e+001,3.056539439710153e+000,
        4.199923068520857e-001},{1.111950039713011e+003,-4.807866488602586e+001,
        3.003218499628963e+000,4.216337555000751e-001},{1.042532610364972e+003,
        -4.612018271016708e+001,2.951129883955490e+000,4.232764940324793e-001},
        {9.777589417052835e+002,-4.425072650328128e+001,2.900239442556008e+000,
        4.249205289962486e-001},{9.172983979562611e+002,-4.246585399078810e+001,
        2.850514114630586e+000,4.265658669913391e-001},{8.608453554430503e+002,
        -4.076136366761418e+001,2.801921891149074e+000,4.282125146716945e-001},
        {8.081171471965247e+002,-3.913328048140521e+001,2.754431776852438e+000,
        4.298604787462255e-001},{7.588523354947266e+002,-3.757784280141392e+001,
        2.708013754148967e+000,4.315097659798046e-001},{7.128085053227204e+002,
        -3.609148886941360e+001,2.662638747952767e+000,4.331603831942572e-001},
        {6.697616301899591e+002,-3.467084767166227e+001,2.618278593896983e+000,
        4.348123372693731e-001},{6.295038171706216e+002,-3.331272564117698e+001,
        2.574906004565767e+000,4.364656351439127e-001},{5.918428655279847e+002,
        -3.201409883532291e+001,2.532494540378606e+000,4.381202838166297e-001},
        {5.565999606334636e+002,-3.077210029665694e+001,2.491018578065730e+000,
        4.397762903473017e-001},{5.236101967728564e+002,-2.958401561514848e+001,
        2.450453285249495e+000,4.414336618577676e-001},{4.927195823157568e+002,
        -2.844726859478019e+001,2.410774588999436e+000,4.430924055329756e-001},
        {4.637860960803320e+002,-2.735941953218890e+001,2.371959154294425e+000,
        4.447525286220433e-001},{4.366774822365882e+002,-2.631815311065120e+001,
        2.333984354679967e+000,4.464140384393267e-001},{4.112710296977796e+002,
        -2.532127349245170e+001,2.296828250141353e+000,4.480769423654994e-001},
        {3.874528219662709e+002,-2.436669747558107e+001,2.260469563259040e+000,
        4.497412478486488e-001},{3.651169185882785e+002,-2.345244781267422e+001,
        2.224887656378541e+000,4.514069624053770e-001},{3.441650927913553e+002,
        -2.257664839246537e+001,2.190062510638771e+000,4.530740936219221e-001},
        {3.245056450427372e+002,-2.173751677003992e+001,2.155974703738442e+000,
        4.547426491552871e-001},{3.060536399057885e+002,-2.093336163040314e+001,
        2.122605392018528e+000,4.564126367343871e-001},{2.887300097307417e+002,
        -2.016257613322068e+001,2.089936289195907e+000,4.580840641612062e-001},
        {2.724610482918949e+002,-1.942363328612018e+001,2.057949648179311e+000,
        4.597569393119745e-001},{2.571781773457540e+002,-1.871508235114862e+001,
        2.026628243849622e+000,4.614312701383573e-001},{2.428177694319144e+002,
        -1.803554520313706e+001,1.995955355734756e+000,4.631070646686624e-001},
        {2.293201220245030e+002,-1.738371018461584e+001,1.965914749708475e+000,
        4.647843310090629e-001},{2.166301416228736e+002,-1.675833219262003e+001,
        1.936490665160709e+000,4.664630773448359e-001},{2.046961071710434e+002,
        -1.615822543778556e+001,1.907667795779915e+000,4.681433119416241e-001},
        {1.934698629445243e+002,-1.558226242939191e+001,1.879431277425193e+000,
        4.698250431467114e-001},{1.829066943899449e+002,-1.502937113484294e+001,
        1.851766673341252e+000,4.715082793903179e-001},{1.729646537632953e+002,
        -1.449853037846985e+001,1.824659958829607e+000,4.731930291869178e-001},
        {1.636047362947269e+002,-1.398876887679239e+001,1.798097509845817e+000,
        4.748793011365756e-001},{1.547905996606153e+002,-1.349916208755315e+001,
        1.772066089112747e+000,4.765671039263029e-001},{1.464881127185945e+002,
        -1.302882884420155e+001,1.746552833172282e+000,4.782564463314370e-001},
        {1.386655781437395e+002,-1.257693080761831e+001,1.721545242210061e+000,
        4.799473372170469e-001},{1.312933609201193e+002,-1.214266917026167e+001,
        1.697031166940830e+000,4.816397855393539e-001},{1.243436673524583e+002,
        -1.172528246603632e+001,1.672998797715616e+000,4.833338003471823e-001},
        {1.177906812224748e+002,-1.132404579365274e+001,1.649436654853634e+000,
        4.850293907834343e-001},{1.116101176422379e+002,-1.093826750962181e+001,
        1.626333576621976e+000,4.867265660865868e-001},{1.057793766234323e+002,
        -1.056728882118992e+001,1.603678710849861e+000,4.884253355922194e-001},
        {1.002772484594161e+002,-1.021048121888435e+001,1.581461504068653e+000,
        4.901257087345642e-001},{9.508393109691426e+001,-9.867245539491131e+000,
        1.559671692999208e+000,4.918276950480881e-001},{9.018086100582940e+001,
        -9.537010120052251e+000,1.538299295044362e+000,4.935313041690984e-001},
        {8.555069486770042e+001,-9.219229747811003e+000,1.517334600000931e+000,
        4.952365458373848e-001},{8.117714599214482e+001,-8.913383954440521e+000,
        1.496768161220113e+000,4.969434298978837e-001},{7.704503147414225e+001,
        -8.618976357910185e+000,1.476590788161609e+000,4.986519663023814e-001},
        {7.314002294338168e+001,-8.335532613364549e+000,1.456793537585971e+000,
        5.003621651112420e-001},{6.944879810386360e+001,-8.062600431450619e+000,
        1.437367707389535e+000,5.020740364951754e-001},{6.595880156239269e+001,
        -7.799747511242599e+000,1.418304827863057e+000,5.037875907370351e-001},
        {6.265828559603662e+001,-7.546561136231898e+000,1.399596655606285e+000,
        5.055028382336494e-001},{5.953623627670859e+001,-7.302647062139070e+000,
        1.381235166362647e+000,5.072197894976949e-001},{5.658229760929855e+001,
        -7.067628502368594e+000,1.363212548354849e+000,5.089384551595994e-001},
        {5.378678727776725e+001,-6.841145600895276e+000,1.345521196299155e+000,
        5.106588459694897e-001},{5.114058172786601e+001,-6.622854212012143e+000,
        1.328153704681671e+000,5.123809727991734e-001},{4.863514814255605e+001,
        -6.412425552714074e+000,1.311102862409988e+000,5.141048466441640e-001},
        {4.626245004092587e+001,-6.209545123139677e+000,1.294361646523955e+000,
        5.158304786257448e-001},{4.401494669041566e+001,-6.013912245135423e+000,
        1.277923217027002e+000,5.175578799930805e-001},{4.188556400289667e+001,
        -5.825239391259091e+000,1.261780911389945e+000,5.192870621253667e-001},
        {3.986762775448643e+001,-5.643251367096637e+000,1.245928239132817e+000,
        5.210180365340277e-001},{3.795489834408001e+001,-5.467685094511304e+000,
        1.230358877298484e+000,5.227508148649598e-001},{3.614148268541150e+001,
        -5.298288645847125e+000,1.215066664937051e+000,5.244854089008243e-001},
        {3.442185278609600e+001,-5.134821009449518e+000,1.200045598933553e+000,
        5.262218305633868e-001},{3.279079584820779e+001,-4.977051405468687e+000,
        1.185289829131247e+000,5.279600919159078e-001},{3.124342934154262e+001,
        -4.824759024073568e+000,1.170793654218353e+000,5.297002051655871e-001},
        {2.977513427897120e+001,-4.677732260255681e+000,1.156551516988663e+000,
        5.314421826660609e-001},{2.838157596586128e+001,-4.535768567068232e+000,
        1.142558000732308e+000,5.331860369199514e-001},{2.705867366805578e+001,
        -4.398673923357351e+000,1.128807824937147e+000,5.349317805814788e-001},
        {2.580257661383335e+001,-4.266262403536937e+000,1.115295841412068e+000,
        5.366794264591228e-001},{2.460966531506359e+001,-4.138355917689477e+000,
        1.102017030714079e+000,5.384289875183563e-001},{2.347652634935337e+001,
        -4.014783768732895e+000,1.088966498339614e+000,5.401804768844284e-001},
        {2.239994189186168e+001,-3.895382342766132e+000,1.076139471288119e+000,
        5.419339078452174e-001},{2.137688056201431e+001,-3.779994809266803e+000,
        1.063531294680509e+000,5.436892938541545e-001},{2.040448375466456e+001,
        -3.668470797273908e+000,1.051137428418400e+000,5.454466485332009e-001},
        {1.948005543173328e+001,-3.560666110129647e+000,1.038953444001990e+000,
        5.472059856759085e-001},{1.860105179024829e+001,-3.456442449726411e+000,
        1.026975021437601e+000,5.489673192505425e-001},{1.776507969598140e+001,
        -3.355667198759821e+000,1.015197946286714e+000,5.507306634032858e-001},
        {1.696986640316189e+001,-3.258213021837012e+000,1.003618106544807e+000,
        5.524960324615093e-001},{1.621328376128235e+001,-3.163957875125649e+000,
        9.922314902636222e-001,5.542634409371333e-001},{1.549330911573373e+001,
        -3.072784521087606e+000,9.810341822990482e-001,5.560329035300551e-001},
        {1.480803983183346e+001,-2.984580503003917e+000,9.700223620937467e-001,
        5.578044351316714e-001},{1.415567829505791e+001,-2.899237854035364e+000,
        9.591923008786090e-001,5.595780508284809e-001},{1.353452476308944e+001,
        -2.816652899819644e+000,9.485403592247703e-001,5.613537659057762e-001},
        {1.294297073501526e+001,-2.736726076361296e+000,9.380629846710600e-001,
        5.631315958514251e-001},{1.237950327534221e+001,-2.659361822105834e+000,
        9.277567094758138e-001,5.649115563597501e-001},{1.184268567697761e+001,
        -2.584468285143181e+000,9.176181481050070e-001,5.666936633355001e-001},
        {1.133116273830062e+001,-2.511957258765677e+000,9.076439952813108e-001,
        5.684779328979236e-001},{1.084365039059536e+001,-2.441743973937185e+000,
        8.978310237189942e-001,5.702643813849461e-001},{1.037893959350994e+001,
        -2.373747016076154e+000,8.881760821711557e-001,5.720530253574520e-001},
        {9.935878258780905e+000,-2.307888066176576e+000,8.786760932029253e-001,
        5.738438816036776e-001},{9.513385220488097e+000,-2.244091925599429e+000,
        8.693280515875038e-001,5.756369671437167e-001},{9.110429465384806e+000,
        -2.182286226388107e+000,8.601290220482226e-001,5.774322992341427e-001},
        {8.726039979294475e+000,-2.122401439791754e+000,8.510761377549098e-001,
        5.792298953727533e-001},{8.359296620034248e+000,-2.064370690628830e+000,
        8.421665983411981e-001,5.810297733034353e-001},{8.009325561958333e+000,
        -2.008129640143733e+000,8.333976682171725e-001,5.828319510211679e-001},
        {7.675302688422919e+000,-1.953616435842042e+000,8.247666750114966e-001,
        5.846364467771462e-001},{7.356443958617260e+000,-1.900771540092228e+000,
        8.162710077803924e-001,5.864432790840537e-001},{7.052008531129983e+000,
        -1.849537692088942e+000,8.079081155885138e-001,5.882524667214695e-001},
        {6.761294720818636e+000,-1.799859789804134e+000,7.996755058885832e-001,
        5.900640287414285e-001},{6.483636498372520e+000,-1.751684788990636e+000,
        7.915707430302340e-001,5.918779844741284e-001},{6.218399337511639e+000,
        -1.704961609984714e+000,7.835914468426860e-001,5.936943535337977e-001},
        {5.964989501232742e+000,-1.659641156314279e+000,7.757352914082837e-001,
        5.955131558247273e-001},{5.722834924601525e+000,-1.615676059262124e+000,
        7.680000032840613e-001,5.973344115474654e-001},{5.491399638620130e+000,
        -1.573020782408741e+000,7.603833606797970e-001,5.991581412051937e-001},
        {5.270171046295689e+000,-1.531631422179552e+000,7.528831917957080e-001,
        6.009843656102799e-001},{5.058664298813443e+000,-1.491465712692528e+000,
        7.454973738143860e-001,6.028131058910203e-001},{4.856420435950218e+000,
        -1.452482946378775e+000,7.382238316110306e-001,6.046443834985716e-001},
        {4.663000885144658e+000,-1.414643871536506e+000,7.310605365115268e-001,
        6.064782202140927e-001},{4.477991405897813e+000,-1.377910693546225e+000,
        7.240055053241036e-001,6.083146381560854e-001},{4.300998038136363e+000,
        -1.342246980204123e+000,7.170567991024387e-001,6.101536597879579e-001},
        {4.131646836878849e+000,-1.307617618348851e+000,7.102125221204546e-001,
        6.119953079258070e-001},{3.969581617344602e+000,-1.273988750409006e+000,
        7.034708208117358e-001,6.138396057464396e-001},{3.814464999241590e+000,
        -1.241327747944722e+000,6.968298828181920e-001,6.156865767956317e-001},
        {3.665976419552412e+000,-1.209603147585341e+000,6.902879359474882e-001,
        6.175362449966364e-001},{3.523809639869346e+000,-1.178784591650163e+000,
        6.838432472111192e-001,6.193886346589591e-001},{3.387676101076204e+000,
        -1.148842831128321e+000,6.774941220149650e-001,6.212437704873943e-001},
        {3.257298408715396e+000,-1.119749615703440e+000,6.712389030704746e-001,
        6.231016775913520e-001},{3.132416234122967e+000,-1.091477733912388e+000,
        6.650759697593417e-001,6.249623814944699e-001},{3.012777923461127e+000,
        -1.064000880818915e+000,6.590037370124431e-001,6.268259081445352e-001},
        {2.898148500487827e+000,-1.037293729191567e+000,6.530206548146291e-001,
        6.286922839237189e-001},{2.788300228906221e+000,-1.011331780554530e+000,
        6.471252070509176e-001,6.305615356591386e-001},{2.683019744175228e+000,
        -9.860914343814429e-001,6.413159110771507e-001,6.324336906337702e-001},
        {2.582101558543176e+000,-9.615498742641666e-001,6.355913166870878e-001,
        6.343087765977056e-001},{2.485351726258790e+000,-9.376850950754241e-001,
        6.299500055923686e-001,6.361868217797954e-001},{2.392584780774969e+000,
        -9.144758355198807e-001,6.243905905769184e-001,6.380678548996677e-001},
        {2.303623809125252e+000,-8.919015614137316e-001,6.189117148779868e-001,
        6.399519051801563e-001},{2.218301716484065e+000,-8.699424569246335e-001,
        6.135120515563689e-001,6.418390023601502e-001},{2.136457313721100e+000,
        -8.485793527805717e-001,6.081903027200146e-001,6.437291767078821e-001},
        {2.057939227794259e+000,-8.277937602603399e-001,6.029451990970640e-001,
        6.456224590346728e-001},{1.982601361773348e+000,-8.075677868124656e-001,
        5.977754992194658e-001,6.475188807091614e-001},{1.910305422321021e+000,
        -7.878841579305617e-001,5.926799890174284e-001,6.494184736720295e-001},
        {1.840919973864347e+000,-7.687261800830212e-001,5.876574811656280e-001,
        6.513212704512502e-001},{1.774318431447832e+000,-7.500776989994216e-001,
        5.827068144958507e-001,6.532273041778850e-001},{1.710381605636034e+000,
        -7.319231195156424e-001,5.778268536008011e-001,6.551366086024576e-001},
        {1.648994688751223e+000,-7.142473440233981e-001,5.730164881656592e-001,
        6.570492181119113e-001},{1.590048725123274e+000,-6.970357821918966e-001,
        5.682746325952985e-001,6.589651677472103e-001},{1.533439874027392e+000,
        -6.802743224911976e-001,5.636002254787615e-001,6.608844932215886e-001},
        {1.479068697158344e+000,-6.639493087403419e-001,5.589922291190146e-001,
        6.628072309394806e-001},{1.426840869536403e+000,-6.480475369725340e-001,
        5.544496291369960e-001,6.647334180161881e-001},{1.376665618585289e+000,
        -6.325562192444207e-001,5.499714339749598e-001,6.666630922982865e-001},
        {1.328457187000894e+000,-6.174629937261502e-001,5.455566745780982e-001,
        6.685962923848331e-001},{1.282133030214725e+000,-6.027558831242498e-001,
        5.412044038917494e-001,6.705330576494062e-001},{1.237614927340746e+000,
        -5.884233016021722e-001,5.369136965737760e-001,6.724734282630155e-001},
        {1.194827579250900e+000,-5.744540212110448e-001,5.326836485547319e-001,
        6.744174452179302e-001},{1.153699645170108e+000,-5.608371784476705e-001,
        5.285133767701128e-001,6.763651503524762e-001},{1.114162811162155e+000,
        -5.475622466470426e-001,5.244020187578001e-001,6.783165863768431e-001},
        {1.076151709993373e+000,-5.346190261721666e-001,5.203487323673905e-001,
        6.802717968999631e-001},{1.039604087616986e+000,-5.219976374666073e-001,
        5.163526954775388e-001,6.822308264575041e-001},{1.004460456200703e+000,
        -5.096885048943938e-001,5.124131056874093e-001,6.841937205410585e-001},
        {9.706638785677234e-001,-4.976823447415940e-001,5.085291800511675e-001,
        6.861605256285703e-001},{9.381600986563852e-001,-4.859701585652561e-001,
        5.047001548417265e-001,6.881312892160738e-001},{9.068972242668986e-001,
        -4.745432188080312e-001,5.009252852952014e-001,6.901060598508284e-001},
        {8.768256265898535e-001,-4.633930593762060e-001,4.972038453990545e-001,
        6.920848871659001e-001},{8.478980422480926e-001,-4.525114688501092e-001,
        4.935351276972386e-001,6.940678219163016e-001},{8.200690560722610e-001,
        -4.418904741373326e-001,4.899184430790607e-001,6.960549160167504e-001},
        {7.932955365213841e-001,-4.315223407060223e-001,4.863531206494093e-001,
        6.980462225811568e-001},{7.675361442985631e-001,-4.213995555141402e-001,
        4.828385075364002e-001,7.000417959639271e-001},{7.427512593575009e-001,
        -4.115148200888941e-001,4.793739687774626e-001,7.020416918031972e-001},
        {7.189033117426465e-001,-4.018610486495977e-001,4.759588872229961e-001,
        7.040459670661056e-001},{6.959561135742333e-001,-3.924313488754276e-001,
        4.725926633925903e-001,7.060546800962171e-001},{6.738752033854085e-001,
        -3.832190229838893e-001,4.692747154481086e-001,7.080678906632436e-001},
        {6.526277468276821e-001,-3.742175581148609e-001,4.660044791174469e-001,
        7.100856600151843e-001},{6.321821747106798e-001,-3.654206137379463e-001,
        4.627814076433050e-001,7.121080509330365e-001},{6.125084635885677e-001,
        -3.568220214675603e-001,4.596049718063618e-001,7.141351277882394e-001},
        {5.935779282079696e-001,-3.484157741858985e-001,4.564746599098449e-001,
        7.161669566030067e-001},{5.753631542423251e-001,-3.401960190266252e-001,
        4.533899778172436e-001,7.182036051137486e-001},{5.578379080634269e-001,
        -3.321570502209607e-001,4.503504490128227e-001,7.202451428377567e-001},
        {5.409772378490252e-001,-3.242933053050536e-001,4.473556146977857e-001,
        7.222916411433742e-001},{5.247573236514336e-001,-3.165993558732946e-001,
        4.444050338858265e-001,7.243431733238683e-001},{5.091553583120583e-001,
        -3.090699001449694e-001,4.414982835460874e-001,7.263998146752452e-001},
        {4.941496650179276e-001,-3.016997600084108e-001,4.386349587914129e-001,
        7.284616425782706e-001},{4.797195893441171e-001,-2.944838727153321e-001,
        4.358146730674687e-001,7.305287365849668e-001},{4.658454159189164e-001,
        -2.874172838318425e-001,4.330370583894325e-001,7.326011785098984e-001},
        {4.525084286368681e-001,-2.804951429879555e-001,4.303017656275229e-001,
        7.346790525265499e-001},{4.396907169839087e-001,-2.737126945641282e-001,
        4.276084648056008e-001,7.367624452691657e-001},{4.273754112892716e-001,
        -2.670652769945731e-001,4.249568454808719e-001,7.388514459404123e-001},
        {4.155464136560620e-001,-2.605483107212597e-001,4.223466171076617e-001,
        7.409461464252765e-001},{4.041884380013781e-001,-2.541572941142669e-001,
        4.197775095020359e-001,7.430466414116397e-001},{3.932870578905699e-001,
        -2.478877986781748e-001,4.172492733426532e-001,7.451530285179989e-001},
        {3.828286467935785e-001,-2.417354613025955e-001,4.147616807084972e-001,
        7.472654084288583e-001},{3.728003160347851e-001,-2.356959769333881e-001,
        4.123145256850712e-001,7.493838850383399e-001},{3.631899496533657e-001,
        -2.297650933614912e-001,4.099076250447146e-001,7.515085656026301e-001},
        {3.539861802648743e-001,-2.239386040074048e-001,4.075408189796285e-001,
        7.536395609019181e-001},{3.451784395377778e-001,-2.182123418981641e-001,
        4.052139719155342e-001,7.557769854125394e-001},{3.367567308090195e-001,
        -2.125821679594597e-001,4.029269733841373e-001,7.579209574901114e-001},
        {3.287119984291083e-001,-2.070439719882496e-001,4.006797390434232e-001,
        7.600715995645146e-001},{3.210357123305466e-001,-2.015936547953648e-001,
        3.984722116891958e-001,7.622290383476353e-001},{3.137202183461909e-001,
        -1.962271288064989e-001,3.963043624830746e-001,7.643934050549112e-001},
        {3.067585099743523e-001,-1.909403032422600e-001,3.941761921936149e-001,
        7.665648356417625e-001},{3.001443621673701e-001,-1.857290784658068e-001,
        3.920877326274295e-001,7.687434710561505e-001},{2.938722968103650e-001,
        -1.805893348436715e-001,3.900390481551737e-001,7.709294575085852e-001},
        {2.879376064535850e-001,-1.755169227244073e-001,3.880302373994634e-001,
        7.731229467610636e-001},{2.823363799596992e-001,-1.705076514427414e-001,
        3.860614350793771e-001,7.753240964365381e-001},{2.770447885477484e-001,
        -1.655569164888013e-001,3.841328126374664e-001,7.775330703507134e-001},
        {2.720819561369693e-001,-1.606606552857484e-001,3.822445839373179e-001,
        7.797500388681229e-001},{2.674653113933975e-001,-1.558148244688060e-001,
        3.803970049600344e-001,7.819751792846662e-001},{2.632075572084795e-001,
        -1.509385793371179e-001,3.785610382540837e-001,7.842454607100902e-001},
        {2.593330708233911e-001,-1.461744656606448e-001,3.767934811627194e-001,
        7.864914180935034e-001},{2.558290465748489e-001,-1.415248268445518e-001,
        3.750961409463570e-001,7.887085704890959e-001},{2.526817192496980e-001,
        -1.369820489145218e-001,3.734669282636506e-001,7.908973098182515e-001},
        {2.498786057610260e-001,-1.325389045601303e-001,3.719038491266883e-001,
        7.930580228550742e-001},{2.474085267751381e-001,-1.281885279708624e-001,
        3.704049999203535e-001,7.951910912877180e-001},{2.452614346122534e-001,
        -1.239243863767887e-001,3.689685626896172e-001,7.972968917785244e-001},
        {2.434284168742104e-001,-1.197402577787785e-001,3.675928007377211e-001,
        7.993757960231415e-001},{2.419015528622072e-001,-1.156302067314484e-001,
        3.662760544672607e-001,8.014281708086085e-001},{2.406739735415517e-001,
        -1.115885662953330e-001,3.650167374937393e-001,8.034543780705155e-001},
        {2.397396425750860e-001,-1.076099145903805e-001,3.638133329505207e-001,
        8.054547749492954e-001},{2.390934524095718e-001,-1.036890607294186e-001,
        3.626643900605662e-001,8.074297138456664e-001},{2.387311440820192e-001,
        -9.982102656507678e-002,3.615685208685295e-001,8.093795424753392e-001},
        {2.386492238235064e-001,-9.600103014473647e-002,3.605243971745443e-001,
        8.113046039230223e-001},{2.388449516089252e-001,-9.222447197204525e-002,
        3.595307476540946e-001,8.132052366957213e-001},{2.393163909364370e-001,
        -8.848692277977732e-002,3.585863551396568e-001,8.150817747754554e-001},
        {2.400622369503420e-001,-8.478410739725760e-002,3.576900540368518e-001,
        8.169345476714047e-001},{2.410819093473880e-001,-8.111189587840884e-002,
        3.568407279242882e-001,8.187638804714793e-001},{2.423755227229712e-001,
        -7.746629151231736e-002,3.560373072597538e-001,8.205700938934316e-001},
        {2.439437903097885e-001,-7.384341869908345e-002,3.552787672180464e-001,
        8.223535043354756e-001},{2.457880841300521e-001,-7.023951497682976e-002,
        3.545641256673672e-001,8.241144239264422e-001},{2.479104628840352e-001,
        -6.665092199321671e-002,3.538924412424807e-001,8.258531605755627e-001},
        {2.503135014091841e-001,-6.307407345043224e-002,3.532628115142414e-001,
        8.275700180218225e-001},{2.530004736674350e-001,-5.950549117251455e-002,
        3.526743712965212e-001,8.292652958829614e-001},{2.559752230366451e-001,
        -5.594177412647441e-002,3.521262910014856e-001,8.309392897040731e-001},
        {2.592422310622398e-001,-5.237959267551613e-002,3.516177751155357e-001,
        8.325922910059250e-001},{2.628065531267236e-001,-4.881568009199424e-002,
        3.511480607379117e-001,8.342245873328724e-001},{2.666738567720074e-001,
        -4.524682709852055e-002,3.507164162151467e-001,8.358364623005091e-001},
        {2.708504884539047e-001,-4.166987608244501e-002,3.503221398361055e-001,
        8.374281956429612e-001},{2.753433071879429e-001,-3.808171199029962e-002,
        3.499645585884929e-001,8.390000632598814e-001},{2.801599037196582e-001,
        -3.447926077765695e-002,3.496430270117127e-001,8.405523372631366e-001},
        {2.853083921105367e-001,-3.085947960555782e-002,3.493569260683962e-001,
        8.420852860231959e-001},{2.907976806313661e-001,-2.721935651026936e-002,
        3.491056621189848e-001,8.435991742151832e-001},{2.966371720783940e-001,
        -2.355589928273860e-002,3.488886658983132e-001,8.450942628646833e-001},
        {3.028370462889118e-001,-1.986613619310260e-002,3.487053916015641e-001,
        8.465708093931487e-001},{3.094081917821564e-001,-1.614710890028537e-002,
        3.485553159714244e-001,8.480290676631032e-001},{3.163620364755382e-001,
        -1.239586542273052e-002,3.484379374449686e-001,8.494692880229420e-001},
        {3.237109529050010e-001,-8.609462422221065e-003,3.483527753712113e-001,
        8.508917173514538e-001},{3.314679191860245e-001,-4.784954014192033e-003,
        3.482993692124245e-001,8.522965991020172e-001},{3.396466627040896e-001,
        -9.193907609769285e-004,3.482772778363755e-001,8.536841733464595e-001},
        {3.482573639782674e-001,2.990234168183047e-003,3.482860786936271e-001,
        8.550546768185773e-001},{3.573435870189764e-001,6.946512750374164e-003,
        3.483253684425491e-001,8.564083429573437e-001},{3.668456015562940e-001,
        1.095357014539229e-002,3.483947564910607e-001,8.577454019497183e-001},{
        3.768666032330697e-001,1.501283216327796e-002,3.484938791513281e-001,
        8.590660807729463e-001},{3.872502858387614e-001,1.912964792928498e-002,
        3.486223735021649e-001,8.603706032376969e-001},{3.978260416786913e-001,
        2.330753852682181e-002,3.487799024495905e-001,8.616591900276418e-001},{
        4.132101935168742e-001,2.749646402204903e-002,3.489662637387618e-001,
        8.629320587422359e-001},{4.184545943199193e-001,3.190595255298934e-002,
        3.491805658203261e-001,8.641894239321634e-001},{4.362824413649418e-001,
        3.618297429472679e-002,3.494237843557785e-001,8.654314971271906e-001},{
        4.482605603718436e-001,4.065324239822417e-002,3.496942108258070e-001,
        8.666584870394793e-001},{4.622330316257493e-001,4.516985999042349e-002,
        3.499923862104077e-001,8.678705992003968e-001},{4.768622286036364e-001,
        4.976455970008947e-002,3.503178747560284e-001,8.690680364449238e-001},{
        4.921745241725010e-001,5.444066904880778e-002,3.506704352553635e-001,
        8.702509987148481e-001},{5.081973839874943e-001,5.920156908963686e-002,
        3.510498387111092e-001,8.714196831463595e-001},{5.249595720422131e-001,
        6.405069424380409e-002,3.514558679881682e-001,8.725742841082431e-001},{
        5.424905347559086e-001,6.899154202103656e-002,3.518883174461503e-001,
        8.737149932396073e-001},{5.608210429624480e-001,7.402766394847896e-002,
        3.523469926362302e-001,8.748419994872339e-001},{5.799822127345404e-001,
        7.916267804090524e-002,3.528317099190555e-001,8.759554891424319e-001},{
        6.004830519290501e-001,8.439587774540482e-002,3.533423051135982e-001,
        8.770556458774835e-001},{6.225303530662254e-001,8.972780116427569e-002,
        3.538786230951095e-001,8.781426507816023e-001},{6.463610750175416e-001,
        9.515751995040138e-002,3.544405351945316e-001,8.792166823964106e-001},{
        6.722471844825647e-001,1.012426405366949e-001,3.550840958618995e-001,
        8.803766342353709e-001},{7.038651077223995e-001,1.075468486721946e-001,
        3.557708387936919e-001,8.815427655306450e-001},{7.251393379424058e-001,
        1.142877363408631e-001,3.565023423314873e-001,8.827152564770329e-001},{
        7.642524395207234e-001,1.210851585997144e-001,3.572820846551236e-001,
        8.838942963354349e-001},{7.967358094127701e-001,1.283613467605374e-001,
        3.581108233391086e-001,8.850800842450453e-001},{8.338699793357391e-001,
        1.359403244468062e-001,3.589921197256534e-001,8.862728294157951e-001},{
        8.739157757386329e-001,1.438882241405927e-001,3.599284806768164e-001,
        8.874727525584538e-001},{9.171674240348069e-001,1.522338614296611e-001,
        3.609228706786188e-001,8.886800863594736e-001},{9.639566900146391e-001,
        1.610089362976866e-001,3.619784903446237e-001,8.898950765022780e-001},{
        1.014658245902457e+000,1.702483983739543e-001,3.630988007319633e-001,
        8.911179826999973e-001},{1.069696500740114e+000,1.799908580537642e-001,
        3.642875508037436e-001,8.923490798353885e-001},{1.129553586989754e+000,
        1.902790629163924e-001,3.655488084631469e-001,8.935886592217480e-001},{
        1.194778730658964e+000,2.011604495101677e-001,3.668869957374470e-001,
        8.948370300007601e-001},{1.265999604715109e+000,2.126877807800234e-001,
        3.683069287846877e-001,8.960945206957666e-001},{1.343935603653501e+000,
        2.249198920053187e-001,3.698138634914989e-001,8.973614809419384e-001},{
        1.429414190654427e+000,2.379225551311867e-001,3.714135476414637e-001,
        8.986382834183703e-001},{1.523389963185659e+000,2.517694999845817e-001,
        3.731122807290428e-001,8.999253260114501e-001},{1.626967987465184e+000,
        2.665436073713666e-001,3.749169828303232e-001,9.012230342439003e-001},{
        1.741431587530111e+000,2.823383211013446e-001,3.768352741049624e-001,
        9.025318640101248e-001},{1.868275831068914e+000,2.992593167802703e-001,
        3.788755669150111e-001,9.038523046659105e-001},{2.009247253435497e+000,
        3.174264875499637e-001,3.810471728982508e-001,9.051848825296176e-001},{
        2.166391087168643e+000,3.369763061640536e-001,3.833604278633734e-001,
        9.065301648630008e-001},{2.349101814944340e+000,3.579901484020978e-001,
        3.858270141057033e-001,9.078887644133517e-001},{2.531929749610997e+000,
        3.810226519207810e-001,3.884588003903566e-001,9.092613446151097e-001},{
        2.767188003052499e+000,4.055286490868840e-001,3.912727602985009e-001,
        9.106486255694756e-001},{3.016217450507473e+000,4.324970058988013e-001,
        3.942818356613025e-001,9.120513915273417e-001},{3.303389261208595e+000,
        4.618306962042632e-001,3.975063679209401e-001,9.134704971443424e-001},{
        3.631549916126941e+000,4.939281587987267e-001,4.009666241813926e-001,
        9.149068790734376e-001},{4.008482779288279e+000,5.291694395449363e-001,
        4.046862435629703e-001,9.163615656490546e-001},{4.443846750534742e+000,
        5.680030693371376e-001,4.086922722032931e-001,9.178356901063999e-001},{
        4.949731196871531e+000,6.109615086616571e-001,4.130158106084739e-001,
        9.193305059167702e-001},{5.541409643335976e+000,6.586807872014066e-001,
        4.176928163006187e-001,9.208474050863027e-001},{6.238372675901206e+000,
        7.119257358914435e-001,4.227651072505875e-001,9.223879401412338e-001},{
        7.065766386999059e+000,7.716226265930281e-001,4.282816280479594e-001,
        9.239538507389419e-001},{8.056416694649682e+000,8.389018864217007e-001,
        4.343000631122791e-001,9.255470961380512e-001},{9.253723462876144e+000,
        9.151544772853499e-001,4.408889145566523e-001,9.271698951653059e-001},{
        1.071584561649215e+001,1.002107267105648e+000,4.481302092757962e-001,
        9.288247758812972e-001},{1.253214033900518e+001,1.101808734948876e+000,
        4.561233615389971e-001,9.305146379456196e-001},{1.477897062418504e+001,
        1.217485995326902e+000,4.649880047213420e-001,9.322428318295400e-001},{
        1.766908561621815e+001,1.351719349121241e+000,4.748770243380275e-001,
        9.340132606989513e-001},{2.138486266524388e+001,1.509883643514754e+000,
        4.859733964211321e-001,9.358305148113010e-001},{2.628754637519723e+001,
        1.697451202895145e+000,4.985169448163012e-001,9.377000442304936e-001},{
        3.289856626810693e+001,1.922256316265470e+000,5.128135873286412e-001,
        9.396284013530487e-001},{4.205492727375339e+001,2.194581754116503e+000,
        5.292667488868058e-001,9.416235666436306e-001},{5.514876558372439e+001,
        2.528063775283584e+000,5.484198767596652e-001,9.436954119389488e-001},{
        7.462633427723064e+001,2.940368260878233e+000,5.710261164676607e-001,
        9.458563710445010e-001},{1.050184348991562e+002,3.453462949853480e+000,
        5.981648072853771e-001,9.481224427923183e-001},{1.555495965673860e+002,
        4.087350044552481e+000,6.314608944041468e-001,9.505147490704314e-001},{
        2.376339218745235e+002,4.944818621598538e+000,6.732270162071558e-001,
        9.530620700536182e-001},{3.778931105604901e+002,6.223871768745157e+000,
        7.270999546100488e-001,9.558052023498382e-001},{6.392510022959895e+002,
        8.369904048358965e+000,7.988184626507228e-001,9.588050299738381e-001},{
        1.175214125741375e+003,9.200515050596998e+000,8.756729054310770e-001,
        9.612797327158309e-001},{2.404391521144330e+003,8.351201828031256e+000,
        9.861434004464017e-001,9.640175305607321e-001},{5.280178052685498e+003,
        7.052137331238425e+000,1.155225153751228e+000,9.672632864915536e-001},{
        1.195185547887987e+004,1.436266930835130e+001,1.399691464502437e+000,
        9.709593911907505e-001},{2.738163303986884e+004,3.128192142643308e+001,
        1.713086045447508e+000,9.743575124934957e-001},{6.813367902015221e+004,
        2.245954110359909e+001,2.098339086431259e+000,9.771334786926074e-001},{
        1.719549070722432e+005,-4.567581958920449e+001,2.615376615379705e+000,
        9.796670698052391e-001},{4.072927452321919e+005,-5.632241381576800e+001,
        3.317614691567385e+000,9.823925310148151e-001},{9.174334612404156e+005,
        5.978559879130236e+002,4.355002072346393e+000,9.857167565271496e-001},{
        1.863229120547296e+006,1.146180212440694e+003,5.277266586606779e+000,
        9.875311446084982e-001},{4.352587282561689e+006,3.435290432960140e+002,
        6.013725056438802e+000,9.883772225822374e-001},{1.294720023425507e+007,
        -1.952316825630777e+003,7.598845776825704e+000,9.898384444052550e-001},
        {4.368922580067658e+007,-9.798242269889981e+003,1.040268251220144e+001,
        9.914339076346728e-001},{1.412163489780696e+008,-7.929973860030538e+003,
        1.348982180175535e+001,9.935448201066974e-001},{3.054619794272863e+008,
        1.543075051399528e+004,1.697364990930417e+001,9.950069147908655e-001},{
        2.513842293016319e+012,-1.192762798969687e+008,1.413409677685541e+003,
        9.959656981502529e-001}};
    constant Real[Ninterval, 4] hvcoef={{3.418719024828741e+009,-6.021500887201227e+005,
        1.372239895761628e+002,8.595917694423992e-001},{3.054310565670096e+009,
        -5.705938691014666e+005,1.340221742560438e+002,8.599600896018758e-001},
        {2.680326377990845e+009,-5.429463074242631e+005,1.313866487967003e+002,
        8.602696780537780e-001},{2.303779913727746e+009,-4.921392562770898e+005,
        1.256410111646926e+002,8.609751352703259e-001},{1.980129780009944e+009,
        -4.460960668130493e+005,1.201498857905039e+002,8.616864231415984e-001},
        {1.702029460983321e+009,-4.043727836958034e+005,1.149020405579111e+002,
        8.624035880113733e-001},{1.463001841507740e+009,-3.665601613605881e+005,
        1.098863963717011e+002,8.631267209320035e-001},{1.257578888846852e+009,
        -3.322921639231642e+005,1.050926221990266e+002,8.638558834346060e-001},
        {1.081020151317802e+009,-3.012351730865443e+005,1.005107466086200e+002,
        8.645911520991180e-001},{9.292788756444820e+008,-2.730884033777993e+005,
        9.613135173247430e+001,8.653325887404106e-001},{7.988592072529383e+008,
        -2.475781452734592e+005,9.194535249523334e+001,8.660802702489665e-001},
        {6.867517994789405e+008,-2.244567953084133e+005,8.794416126688296e+001,
        8.668342586830016e-001},{5.903993090097249e+008,-2.035004093727184e+005,
        8.411943557310387e+001,8.675946462312558e-001},{5.075739967569540e+008,
        -1.845052128758624e+005,8.046328280923146e+001,8.683615102740704e-001},
        {4.363803981359935e+008,-1.672877964071615e+005,7.696824858217629e+001,
        8.691349132544352e-001},{3.751811369685484e+008,-1.516810195389626e+005,
        7.362707753938845e+001,8.699149478489386e-001},{3.225757764446142e+008,
        -1.375342639486588e+005,7.043297686856677e+001,8.707016766933142e-001},
        {2.775632019164234e+008,-1.247180148068888e+005,6.737939987231324e+001,
        8.714951927224426e-001},{2.395047937120040e+008,-1.131276569986563e+005,
        6.446029045026621e+001,8.722955738779207e-001},{2.072894646248908e+008,
        -1.026516293164950e+005,6.166981089182345e+001,8.731028981691641e-001},
        {1.799822430252400e+008,-9.333464537306117e+004,5.905402123864285e+001,
        8.739009311042776e-001},{1.566914275764715e+008,-8.525624087305536e+004,
        5.668205775153147e+001,8.746623083398238e-001},{1.365420998913238e+008,
        -7.792553082576592e+004,5.442145459347433e+001,8.754247647693702e-001},
        {1.190945653358361e+008,-7.126911585540987e+004,5.226630523340383e+001,
        8.761882924491433e-001},{1.039717710388903e+008,-6.522111942123056e+004,
        5.021104820325436e+001,8.769528833328070e-001},{9.085238634246235e+007,
        -5.972253866425365e+004,4.825044784911309e+001,8.777185292709222e-001},
        {7.945976285392952e+007,-5.472031010955200e+004,4.637957044109646e+001,
        8.784852220104472e-001},{6.955828718931271e+007,-5.016689134145316e+004,
        4.459376897054184e+001,8.792529531942909e-001},{6.094432939926156e+007,
        -4.601943690028419e+004,4.288866070740672e+001,8.800217143609221e-001},
        {5.344423567813414e+007,-4.223952028854783e+004,4.126011513927500e+001,
        8.807914969440196e-001},{4.690790693157751e+007,-3.879248539780872e+004,
        3.970423429382681e+001,8.815622922721852e-001},{4.120636628965157e+007,
        -3.564715093489797e+004,3.821734102078233e+001,8.823340915687035e-001},
        {3.622900976104898e+007,-3.277545861657008e+004,3.679596497500520e+001,
        8.831068859513512e-001},{3.187967036644944e+007,-3.015203386420734e+004,
        3.543682780067873e+001,8.838806664322682e-001},{2.807613578829654e+007,
        -2.775406516810798e+004,3.413683515396600e+001,8.846554239178743e-001},
        {2.474692036340034e+007,-2.556090563904067e+004,3.289306188961926e+001,
        8.854311492088450e-001},{2.183049697968674e+007,-2.355393699418945e+004,
        3.170274439968934e+001,8.862078330001338e-001},{1.927347019859899e+007,
        -2.171631328406215e+004,3.056326941876671e+001,8.869854658810615e-001},
        {1.702981751333125e+007,-2.003282321642497e+004,2.947216618883089e+001,
        8.877640383354423e-001},{1.505930006594837e+007,-1.848966312427858e+004,
        2.842709641996708e+001,8.885435407417774e-001},{1.332750187738691e+007,
        -1.707439527076683e+004,2.742584914811091e+001,8.893239633734973e-001},
        {1.180409908173095e+007,-1.577569115143173e+004,2.646632952888870e+001,
        8.901052963992563e-001},{1.046300091887967e+007,-1.458332162795913e+004,
        2.554655563707482e+001,8.908875298832820e-001},{9.281478450960947e+006,
        -1.348800001880907e+004,2.466464976005302e+001,8.916706537857801e-001},
        {8.239677365327914e+006,-1.248128939600677e+004,2.381883271013455e+001,
        8.924546579633877e-001},{7.320375014028021e+006,-1.155554134563862e+004,
        2.300741887638321e+001,8.932395321696804e-001},{6.508564560677815e+006,
        -1.070380653674440e+004,2.222881017899560e+001,8.940252660557324e-001},
        {5.791092789698311e+006,-9.919758901292089e+003,2.148149097099744e+001,
        8.948118491707285e-001},{5.156530698970656e+006,-9.197655328178946e+003,
        2.076402412172987e+001,8.955992709626238e-001},{4.594876945645325e+006,
        -8.532266312855607e+003,2.007504587669628e+001,8.963875207788541e-001},
        {4.097381930359949e+006,-7.918830001821591e+003,1.941326196319786e+001,
        8.971765878670993e-001},{3.656383109691083e+006,-7.353008221313214e+003,
        1.877744374229622e+001,8.979664613760915e-001},{3.265186685897589e+006,
        -6.830850362101170e+003,1.816642466513669e+001,8.987571303564701e-001},
        {2.917909279006009e+006,-6.348750551159110e+003,1.757909652930962e+001,
        8.995485837616878e-001},{2.609402060809861e+006,-5.903421540440110e+003,
        1.701440658291143e+001,9.003408104489590e-001},{2.335140768578981e+006,
        -5.491861404071661e+003,1.647135426048376e+001,9.011337991802549e-001},
        {2.091146761265873e+006,-5.111327878744832e+003,1.594898842221833e+001,
        9.019275386233419e-001},{1.873929941363969e+006,-4.759317050348291e+003,
        1.544640477086862e+001,9.027220173528617e-001},{1.680420118072653e+006,
        -4.433539445570736e+003,1.496274316343266e+001,9.035172238514534e-001},
        {1.507901694720669e+006,-4.131898344129412e+003,1.449718519666387e+001,
        9.043131465109192e-001},{1.354001888305344e+006,-3.852479913913011e+003,
        1.404895235600572e+001,9.051097736334237e-001},{1.216613076782086e+006,
        -3.593527497504629e+003,1.361730330460103e+001,9.059070934327353e-001},
        {1.093879091249427e+006,-3.353433477948261e+003,1.320153238778303e+001,
        9.067050940355028e-001},{9.841701033319680e+005,-3.130726664519008e+003,
        1.280096767078483e+001,9.075037634825668e-001},{8.860331097677258e+005,
        -2.924054367261154e+003,1.241496883316571e+001,9.083030897303053e-001},
        {7.981918624483937e+005,-2.732178555007192e+003,1.204292601630526e+001,
        9.091030606520103e-001},{7.195149237111326e+005,-2.553962145681973e+003,
        1.168425789742630e+001,9.099036640393030e-001},{6.490013601859985e+005,
        -2.388361283829961e+003,1.133841032591765e+001,9.107048876035626e-001},
        {5.857619638546082e+005,-2.234416399557152e+003,1.100485487724143e+001,
        9.115067189773976e-001},{5.290116852906891e+005,-2.091246746576212e+003,
        1.068308765988832e+001,9.123091457161393e-001},{4.780525034495146e+005,
        -1.958041849488108e+003,1.037262790050762e+001,9.131121552993566e-001},
        {4.322639370581367e+005,-1.834056004290414e+003,1.007301685198876e+001,
        9.139157351323971e-001},{3.910966072603547e+005,-1.718603636258115e+003,
        9.783816732166672e+000,9.147198725479478e-001},{3.540614298472962e+005,
        -1.611053173940656e+003,9.504609563667259e+000,9.155245548076196e-001},
        {3.207227948052809e+005,-1.510822716204718e+003,9.234996229867011e+000,
        9.163297691035424e-001},{2.906939935011917e+005,-1.417376462988183e+003,
        8.974595578775290e+000,9.171355025599859e-001},{2.636303793313987e+005,
        -1.330220294731111e+003,8.723043464518558e+000,9.179417422349862e-001},
        {2.392237992914084e+005,-1.248898152561119e+003,8.479991917683572e+000,
        9.187484751219944e-001},{2.172016592892052e+005,-1.172990137423081e+003,
        8.245108450295883e+000,9.195556881515287e-001},{1.973183307798826e+005,
        -1.102107553390677e+003,8.018075097948199e+000,9.203633681928409e-001},
        {1.793561202392878e+005,-1.035892282235062e+003,7.798587940806567e+000,
        9.211715020555885e-001},{1.631202275964593e+005,-9.740132377691543e+002,
        7.586356268239432e+000,9.219800764915146e-001},{1.484359488552449e+005,
        -9.161641833684364e+002,7.381101972870521e+000,9.227890781961310e-001},
        {1.351478825430181e+005,-8.620624032575208e+002,7.182559013917762e+000,
        9.235984938104057e-001},{1.231162519279247e+005,-8.114460113623057e+002,
        6.990472737830404e+000,9.244083099224488e-001},{1.122162968415116e+005,
        -7.640729129202056e+002,6.804599425001765e+000,9.252185130692011e-001},
        {1.023361278541669e+005,-7.197189192332255e+002,6.624705719443992e+000,
        9.260290897381156e-001},{9.337545308914331e+004,-6.781764164807573e+002,
        6.450568157340423e+000,9.268400263688406e-001},{8.524409931480192e+004,
        -6.392529690945879e+002,6.281972695119674e+000,9.276513093548937e-001},
        {7.786169679505364e+004,-6.027705240567450e+002,6.118714310110324e+000,
        9.284629250453276e-001},{7.115526319693035e+004,-5.685635173312871e+002,
        5.960596482051478e+000,9.292748597463896e-001},{6.505997236969629e+004,
        -5.364788721222958e+002,5.807430942404182e+000,9.300870997231673e-001},
        {5.951708365389362e+004,-5.063742243350591e+002,5.659037156140247e+000,
        9.308996312012252e-001},{5.447396049317387e+004,-4.781175751106457e+002,
        5.515242057235346e+000,9.317124403682275e-001},{4.988309687503692e+004,
        -4.515862663149072e+002,5.375879663496088e+000,9.325255133755377e-001},
        {4.570187946719245e+004,-4.266664669336558e+002,5.240790784971295e+000,
        9.333388363398144e-001},{4.189173749451424e+004,-4.032522688537788e+002,
        5.109822677685524e+000,9.341523953445763e-001},{3.841803267326960e+004,
        -3.812453207114073e+002,4.982828795533794e+000,9.349661764417548e-001},
        {3.524944619171859e+004,-3.605540968469249e+002,4.859668478530708e+000,
        9.357801656532230e-001},{3.235775262493093e+004,-3.410934828706502e+002,
        4.740206710402045e+000,9.365943489722998e-001},{2.971742749441942e+004,
        -3.227842408832863e+002,4.624313855555895e+000,9.374087123652322e-001},
        {2.730548973676348e+004,-3.055526590426766e+002,4.511865434271594e+000,
        9.382232417726517e-001},{2.510105818186500e+004,-2.893300011512208e+002,
        4.402741870199007e+000,9.390379231110015e-001},{2.308534946321419e+004,
        -2.740523193986549e+002,4.296828310919137e+000,9.398527422739368e-001},
        {2.124130171607308e+004,-2.596599553908384e+002,4.194014387044316e+000,
        9.406676851337009e-001},{1.955351648008638e+004,-2.460973335068810e+002,
        4.094194041865801e+000,9.414827375424566e-001},{1.800800960501098e+004,
        -2.333125885677086e+002,3.997265326620004e+000,9.422978853336017e-001},
        {1.659212825450676e+004,-2.212573565008916e+002,3.903130237563751e+000,
        9.431131143230387e-001},{1.529440870224837e+004,-2.098865061302326e+002,
        3.811694539213896e+000,9.439284103104196e-001},{1.410443891357347e+004,
        -1.991578904408298e+002,3.722867600418599e+000,9.447437590803492e-001},
        {1.301277276409646e+004,-1.890321548645134e+002,3.636562246885636e+000,
        9.455591464035549e-001},{1.201083501871745e+004,-1.794725379233024e+002,
        3.552694612840763e+000,9.463745580380161e-001},{1.109084452413765e+004,
        -1.704446937374686e+002,3.471184001267795e+000,9.471899797300593e-001},
        {1.024571699447709e+004,-1.619165024398652e+002,3.391952746393233e+000,
        9.480053972154118e-001},{9.469018895726013e+003,-1.538579391475356e+002,
        3.314926093557165e+000,9.488207962202151e-001},{8.754902558872502e+003,
        -1.462409215712277e+002,3.240032074179658e+000,9.496361624619982e-001},
        {8.098027596251695e+003,-1.390391545991529e+002,3.167201386524235e+000,
        9.504514816506080e-001},{7.493554482491891e+003,-1.322280542592093e+002,
        3.096367297109474e+000,9.512667394890960e-001},{6.937064709883011e+003,
        -1.257845873818821e+002,3.027465520734622e+000,9.520819216745656e-001},
        {6.424526737209824e+003,-1.196871778019022e+002,2.960434126813456e+000,
        9.528970138989733e-001},{5.952271592786267e+003,-1.139156214553171e+002,
        2.895213446237914e+000,9.537120018498824e-001},{5.516955702461954e+003,
        -1.084509856459832e+002,2.831745975134339e+000,9.545268712111753e-001},
        {5.115516193281917e+003,-1.032755079240082e+002,2.769976284441141e+000,
        9.553416076637196e-001},{4.745169939215222e+003,-9.837255018506627e+001,
        2.709850945954599e+000,9.561561968859864e-001},{4.403364440818750e+003,
        -9.372649095365175e+001,2.651318440509086e+000,9.569706245546216e-001},
        {4.087776994953164e+003,-8.932268622183530e+001,2.594329091528175e+000,
        9.577848763449695e-001},{3.796275090953450e+003,-8.514737826931575e+001,
        2.538834982469134e+000,9.585989379315498e-001},{3.526914794156184e+003,
        -8.118766109964749e+001,2.484789895870575e+000,9.594127949884909e-001},
        {3.277915891545599e+003,-7.743141105727378e+001,2.432149240012017e+000,
        9.602264331899009e-001},{3.047647797709957e+003,-7.386723790355531e+001,
        2.380869986715188e+000,9.610398382102077e-001},{2.834618789109123e+003,
        -7.048444111730269e+001,2.330910611325176e+000,9.618529957244332e-001},
        {2.637461957139128e+003,-6.727296213941031e+001,2.282231032479775e+000,
        9.626658914084311e-001},{2.454924432505965e+003,-6.422334375285149e+001,
        2.234792556533058e+000,9.634785109390691e-001},{2.285857047983956e+003,
        -6.132669141282386e+001,2.188557823874969e+000,9.642908399943569e-001},
        {2.129208461400737e+003,-5.857464160828975e+001,2.143490758529177e+000,
        9.651028642535350e-001},{1.984008976569308e+003,-5.595931630261283e+001,
        2.099556514899462e+000,9.659145693971051e-001},{1.849374081739265e+003,
        -5.347331044763390e+001,2.056721437955760e+000,9.667259411068088e-001},
        {1.724488078442418e+003,-5.110964503808447e+001,2.014953009798691e+000,
        9.675369650655664e-001},{1.608601317477169e+003,-4.886174815058493e+001,
        1.974219811466410e+000,9.683476269573521e-001},{1.501028549020432e+003,
        -4.672343509185431e+001,1.934491482280281e+000,9.691579124670265e-001},
        {1.401134787382134e+003,-4.468886871440314e+001,1.895738673701978e+000,
        9.699678072801187e-001},{1.308339375774190e+003,-4.275255490962074e+001,
        1.857933019816026e+000,9.707772970825509e-001},{1.222108228029781e+003,
        -4.090931316053910e+001,1.821047094970709e+000,9.715863675603226e-001},
        {1.141946857646252e+003,-3.915425280944660e+001,1.785054378319671e+000,
        9.723950043991366e-001},{1.067402981642193e+003,-3.748276735761835e+001,
        1.749929225855599e+000,9.732031932839743e-001},{9.980583833327522e+002,
        -3.589050668361879e+001,1.715646831952266e+000,9.740109198986281e-001},
        {9.335284820523360e+002,-3.437336708372298e+001,1.682183202119270e+000,
        9.748181699251741e-001},{8.734576475077868e+002,-3.292747251868510e+001,
        1.649515121362005e+000,9.756249290433984e-001},{8.175192743315979e+002,
        -3.154916618621505e+001,1.617620128283343e+000,9.764311829301763e-001},
        {7.654113989059594e+002,-3.023499246048811e+001,1.586476484703391e+000,
        9.772369172587978e-001},{7.168549261326022e+002,-2.898168620253393e+001,
        1.556063150963355e+000,9.780421176982415e-001},{6.715934871869085e+002,
        -2.778616486120676e+001,1.526359761996525e+000,9.788467699124019e-001},
        {6.293887964147959e+002,-2.664551120825474e+001,1.497346599661789e+000,
        9.796508595592697e-001},{5.900219253252941e+002,-2.555697044888610e+001,
        1.469004573803481e+000,9.804543722900537e-001},{5.532898465620945e+002,
        -2.451793564352644e+001,1.441315196411080e+000,9.812572937482607e-001},
        {5.190052723541189e+002,-2.352594208801040e+001,1.414260562393762e+000,
        9.820596095687246e-001},{4.869947579083630e+002,-2.257865727178197e+001,
        1.387823327724877e+000,9.828613053765841e-001},{4.570979184019152e+002,
        -2.167387417193229e+001,1.361986690424303e+000,9.836623667862149e-001},
        {4.291663436174557e+002,-2.080950381084881e+001,1.336734371291882e+000,
        9.844627794001081e-001},{4.030627155807368e+002,-1.998356855725961e+001,
        1.312050595629924e+000,9.852625288077083e-001},{3.786596714281382e+002,
        -1.919419513223841e+001,1.287920075411151e+000,9.860616005841896e-001},
        {3.558394376680569e+002,-1.843960978347813e+001,1.264327993086148e+000,
        9.868599802892032e-001},{3.344927057914483e+002,-1.771813153942693e+001,
        1.241259984529670e+000,9.876576534655511e-001},{3.145183552120479e+002,
        -1.702816801518539e+001,1.218702124146350e+000,9.884546056378373e-001},
        {2.958222994740287e+002,-1.636820898671438e+001,1.196640908911924e+000,
        9.892508223110540e-001},{2.783177026940484e+002,-1.573682393871353e+001,
        1.175063245364513e+000,9.900462889691248e-001},{2.619234894737551e+002,
        -1.513265481908928e+001,1.153956433685712e+000,9.908409910734041e-001},
        {2.465648216723021e+002,-1.455441492324349e+001,1.133308156602596e+000,
        9.916349140611203e-001},{2.321720020070755e+002,-1.400088277850550e+001,
        1.113106464537580e+000,9.924280433437820e-001},{2.186803377779052e+002,
        -1.347089951583520e+001,1.093339764259556e+000,9.932203643055251e-001},
        {2.060297477025833e+002,-1.296336530904619e+001,1.073996806711151e+000,
        9.940118623014244e-001},{1.941643451397283e+002,-1.247723593031160e+001,
        1.055066675366082e+000,9.948025226557459e-001},{1.830322811700511e+002,
        -1.201152018223532e+001,1.036538775470238e+000,9.955923306601620e-001},
        {1.725851592956317e+002,-1.156527611442914e+001,1.018402822732162e+000,
        9.963812715719111e-001},{1.627781181669557e+002,-1.113760956039830e+001,
        1.000648834052838e+000,9.971693306119173e-001},{1.535693860011035e+002,
        -1.072767076272634e+001,9.832671167175504e-001,9.979564929628543e-001},
        {1.449200191421523e+002,-1.033465196230555e+001,9.662482590600698e-001,
        9.987427437671671e-001},{1.367937717065337e+002,-9.957785484393540e+000,
        9.495831215921720e-001,9.995280681250476e-001},{1.291569872589011e+002,
        -9.596341801355912e+000,9.332628281122665e-001,1.000312451092355e+000},
        {1.219781077764371e+002,-9.249626474109293e+000,9.172787563965046e-001,
        1.001095877678499e+000},{1.152279668782842e+002,-8.916979963771544e+000,
        9.016225314369730e-001,1.001878332844262e+000},{1.088792020192482e+002,
        -8.597774082924014e+000,8.862860157568774e-001,1.002659801499583e+000},
        {1.029063235987208e+002,-8.291411320542892e+000,8.712613030194463e-001,
        1.003440268501293e+000},{9.728564785438825e+001,-7.997323365549272e+000,
        8.565407104574884e-001,1.004219718650792e+000},{9.199496304063413e+001,
        -7.714968773139151e+000,8.421167710251819e-001,1.004998136691686e+000},
        {8.701360359900153e+001,-7.443832377910562e+000,8.279822274408061e-001,
        1.005775507307376e+000},{8.232230443717428e+001,-7.183423666195218e+000,
        8.141300250683886e-001,1.006551815118586e+000},{7.790298199800353e+001,
        -6.933275074571325e+000,8.005533052628054e-001,1.007327044680851e+000},
        {7.373882736821794e+001,-6.692941599684643e+000,7.872454000252229e-001,
        1.008101180481954e+000},{6.981412051815975e+001,-6.461999122789390e+000,
        7.741998252916442e-001,1.008874206939307e+000},{6.611412526808580e+001,
        -6.240043296990975e+000,7.614102753125023e-001,1.009646108397281e+000},
        {6.262513663235084e+001,-6.026689038670938e+000,7.488706175635427e-001,
        1.010416869124489e+000},{5.933427241821190e+001,-5.821568909235316e+000,
        7.365748866372953e-001,1.011186473311012e+000},{5.622953202093046e+001,
        -5.624332795860875e+000,7.245172797819842e-001,1.011954905065573e+000},
        {5.329965683889058e+001,-5.434646641163655e+000,7.126921513657769e-001,
        1.012722148412655e+000},{5.053413008036412e+001,-5.252191899271087e+000,
        7.010940083901317e-001,1.013488187289570e+000},{4.792309187394095e+001,
        -5.076664589645531e+000,6.897175055906588e-001,1.014253005543466e+000},
        {4.545732719574220e+001,-4.907774732842085e+000,6.785574411182894e-001,
        1.015016586928279e+000},{4.312818391659056e+001,-4.745245470887149e+000,
        6.676087519562042e-001,1.015778915101634e+000},{4.092758873926038e+001,
        -4.588812680293274e+000,6.568665100095136e-001,1.016539973621682e+000},
        {3.884793008615984e+001,-4.438223961945115e+000,6.463259175911253e-001,
        1.017299745943874e+000},{3.688212100151130e+001,-4.293238562403930e+000,
        6.359823041079774e-001,1.018058215417688e+000},{3.502348648740307e+001,
        -4.153626360185827e+000,6.258311216044381e-001,1.018815365283285e+000},
        {3.326577803136620e+001,-4.019167610116154e+000,6.158679415223102e-001,
        1.019571178668104e+000},{3.160313640436182e+001,-3.889652370808637e+000,
        6.060884509889981e-001,1.020325638583392e+000},{3.003005307713898e+001,
        -3.764879973889153e+000,5.964884493327785e-001,1.021078727920680e+000},
        {2.854137434411961e+001,-3.644658724667432e+000,5.870638449339153e-001,
        1.021830429448176e+000},{2.713224638151363e+001,-3.528805289640701e+000,
        5.778106517458664e-001,1.022580725807109e+000},{2.579812528568391e+001,
        -3.417144473611440e+000,5.687249864435943e-001,1.023329599507988e+000},
        {2.453473414913067e+001,-3.309508692174914e+000,5.598030651918186e-001,
        1.024077032926797e+000},{2.333805810227199e+001,-3.205737695631187e+000,
        5.510412008791300e-001,1.024823008301128e+000},{2.220432885559139e+001,
        -3.105678219024390e+000,5.424358002555373e-001,1.025567507726222e+000},
        {2.112999429523282e+001,-3.009183576146176e+000,5.339833611149614e-001,
        1.026310513150946e+000},{2.011172854430874e+001,-2.916113494140037e+000,
        5.256804698481571e-001,1.027052006373695e+000},{1.914639375477926e+001,
        -2.826333658116357e+000,5.175237986301524e-001,1.027791969038206e+000},
        {1.823104421288958e+001,-2.739715546993399e+000,5.095101031537107e-001,
        1.028530382629299e+000},{1.736290349293186e+001,-2.656136094630625e+000,
        5.016362201009934e-001,1.029267228468528e+000},{1.653936831205726e+001,
        -2.575477526738492e+000,4.938990649439516e-001,1.030002487709758e+000},
        {1.575797811613206e+001,-2.497626987231605e+000,4.862956294907959e-001,
        1.030736141334639e+000},{1.501642262596952e+001,-2.422476435238042e+000,
        4.788229799338944e-001,1.031468170148003e+000},{1.431252592991174e+001,
        -2.349922366480642e+000,4.714782545940999e-001,1.032198554773166e+000},
        {1.364423636027999e+001,-2.279865602649950e+000,4.642586618963331e-001,
        1.032927275647125e+000},{1.300962339585762e+001,-2.212211125883548e+000,
        4.571614784290629e-001,1.033654313015678e+000},{1.240686782027495e+001,
        -2.146867870831208e+000,4.501840469791165e-001,1.034379646928422e+000},
        {1.183425342332221e+001,-2.083748539062776e+000,4.433237746672978e-001,
        1.035103257233662e+000},{1.129016412610612e+001,-2.022769454725691e+000,
        4.365781311814800e-001,1.035825123573211e+000},{1.077307541038712e+001,
        -1.963850383159112e+000,4.299446469854610e-001,1.036545225377079e+000},
        {1.028154947275094e+001,-1.906914383701821e+000,4.234209116354142e-001,
        1.037263541858046e+000},{9.814230022131259e+000,-1.851887664597415e+000,
        4.170045721339577e-001,1.037980052006132e+000},{9.369839696925903e+000,
        -1.798699456143624e+000,4.106933313435917e-001,1.038694734582934e+000},
        {8.947167622091373e+000,-1.747281824615215e+000,4.044849463620441e-001,
        1.039407568115843e+000},{8.545077467190927e+000,-1.697569639716146e+000,
        3.983772271819996e-001,1.040118530892150e+000},{8.162491034786111e+000,
        -1.649500353387555e+000,3.923680350312642e-001,1.040827600952992e+000},
        {7.798393309046508e+000,-1.603013962393644e+000,3.864552811298065e-001,
        1.041534756087189e+000},{7.451825003941011e+000,-1.558052859669292e+000,
        3.806369252096470e-001,1.042239973824938e+000},{7.121879549937058e+000,
        -1.514561735162216e+000,3.749109742091094e-001,1.042943231431347e+000},
        {6.807699199895982e+000,-1.472487475162612e+000,3.692754809886303e-001,
        1.043644505899842e+000},{6.508476315599162e+000,-1.431779096689505e+000,
        3.637285431064071e-001,1.044343773945410e+000},{6.223444600223672e+000,
        -1.392387605977197e+000,3.582683015002018e-001,1.045041011997687e+000},
        {5.951881226565523e+000,-1.354265956495707e+000,3.528929394082206e-001,
        1.045736196193881e+000},{5.693101078416663e+000,-1.317368936654040e+000,
        3.476006811465485e-001,1.046429302371536e+000},{5.446458886227909e+000,
        -1.281653127167136e+000,3.423897910577511e-001,1.047120306061104e+000},
        {5.211340506752048e+000,-1.247076770164139e+000,3.372585723155903e-001,
        1.047809182478361e+000},{4.987168450830138e+000,-1.213599765364470e+000,
        3.322053660151640e-001,1.048495906516614e+000},{4.773393379500752e+000,
        -1.181183539793155e+000,3.272285500026099e-001,1.049180452738738e+000},
        {4.569496847863383e+000,-1.149791027460064e+000,3.223265379911744e-001,
        1.049862795368995e+000},{4.374988004990743e+000,-1.119386587540072e+000,
        3.174977785277567e-001,1.050542908284660e+000},{4.189400888067502e+000,
        -1.089935937326779e+000,3.127407540491669e-001,1.051220765007437e+000},
        {4.012295649424565e+000,-1.061406120570848e+000,3.080539800181962e-001,
        1.051896338694638e+000},{3.843254239286654e+000,-1.033765424196656e+000,
        3.034360039600572e-001,1.052569602130159e+000},{3.681881374402221e+000,
        -1.006983350527110e+000,2.988854046579620e-001,1.053240527715198e+000},
        {3.527802653665643e+000,-9.810305583932155e-001,2.944007912737826e-001,
        1.053909087458743e+000},{3.380662761329736e+000,-9.558788092568029e-001,
        2.899808025158087e-001,1.054575252967808e+000},{3.240123783209261e+000,
        -9.315009216150985e-001,2.856241058570798e-001,1.055238995437398e+000},
        {3.105868201920377e+000,-9.078707625912555e-001,2.813293968109665e-001,
        1.055900285640210e+000},{2.977591609870003e+000,-8.849631421045409e-001,
        2.770953980214663e-001,1.056559093916054e+000},{2.855007736411922e+000,
        -8.627538388958096e-001,2.729208587048513e-001,1.057215390160977e+000},
        {2.737843340741328e+000,-8.412195136795313e-001,2.688045537828591e-001,
        1.057869143816096e+000},{2.625839966333147e+000,-8.203377040825038e-001,
        2.647452832788387e-001,1.058520323856107e+000},{2.518752537811653e+000,
        -8.000867793714089e-001,2.607418715874039e-001,1.059168898777473e+000},
        {2.416347515483972e+000,-7.804458970053758e-001,2.567931667932268e-001,
        1.059814836586282e+000},{2.318403819543128e+000,-7.613949896269223e-001,
        2.528980400707821e-001,1.060458104785751e+000},{2.224711437052068e+000,
        -7.429147243016000e-001,2.490553850107021e-001,1.061098670363362e+000},
        {2.135070864890457e+000,-7.249864743581408e-001,2.452641170068208e-001,
        1.061736499777632e+000},{2.049292370784272e+000,-7.075922907052119e-001,
        2.415231726533505e-001,1.062371558944488e+000},{1.967195951634708e+000,
        -6.907148805172072e-001,2.378315091641534e-001,1.063003813223237e+000},
        {1.888610625422974e+000,-6.743375783849550e-001,2.341881037825931e-001,
        1.063633227402109e+000},{1.813373338023230e+000,-6.584443161814407e-001,
        2.305919532083683e-001,1.064259765683374e+000},{1.741329942532738e+000,
        -6.430196157987128e-001,2.270420730859128e-001,1.064883391667998e+000},
        {1.672332880740151e+000,-6.280485445058859e-001,2.235374974033225e-001,
        1.065504068339818e+000},{1.606242962644326e+000,-6.135167194115672e-001,
        2.200772780372606e-001,1.066121758049242e+000},{1.542926476725079e+000,
        -5.994102568101398e-001,2.166604841494812e-001,1.066736422496424e+000},
        {1.482257663729330e+000,-5.857157876199568e-001,2.132862017855761e-001,
        1.067348022713911e+000},{1.424115512595617e+000,-5.724204016631274e-001,
        2.099535332621227e-001,1.067956519048742e+000},{1.368385956028459e+000,
        -5.595116632457267e-001,2.066615967928144e-001,1.068561871143958e+000},
        {1.314959655325564e+000,-5.469775676628228e-001,2.034095259190647e-001,
        1.069164037919527e+000},{1.263733008673720e+000,-5.348065427110748e-001,
        2.001964691070868e-001,1.069762977552636e+000},{1.214607187882344e+000,
        -5.229874224736636e-001,1.970215892474923e-001,1.070358647457329e+000},
        {1.167487900381954e+000,-5.115094337620333e-001,1.938840632171667e-001,
        1.070951004263476e+000},{1.122285845216134e+000,-5.003621898130956e-001,
        1.907830814535250e-001,1.071540003795025e+000},{1.078915247650273e+000,
        -4.895356599254621e-001,1.877178474670392e-001,1.072125601047531e+000},
        {1.037295122562504e+000,-4.790201767587073e-001,1.846875774806051e-001,
        1.072707750164894e+000},{9.973476732340229e-001,-4.688064029957253e-001,
        1.816914999294402e-001,1.073286404415327e+000},{9.589990505709063e-001,
        -4.588853343284500e-001,1.787288551054327e-001,1.073861516166452e+000},
        {9.221789716891475e-001,-4.492482827697643e-001,1.757988947129753e-001,
        1.074433036859547e+000},{8.868200204717667e-001,-4.398868591505740e-001,
        1.729008814488281e-001,1.075000916982876e+000},{8.528583447359696e-001,
        -4.307929744054440e-001,1.700340886366837e-001,1.075565106044062e+000},
        {8.202326838157281e-001,-4.219588172117957e-001,1.671977997847816e-001,
        1.076125552541462e+000},{7.888848153812587e-001,-4.133768531089824e-001,
        1.643913082231699e-001,1.076682203934512e+000},{7.587591016827582e-001,
        -4.050398098899249e-001,1.616139166886254e-001,1.077235006612980e+000},
        {7.298024187385580e-001,-3.969406696719444e-001,1.588649369407936e-001,
        1.077783905865066e+000},{7.019641615586063e-001,-3.890726619994999e-001,
        1.561436893787574e-001,1.078328845844344e+000},{6.751958155391025e-001,
        -3.814292509316639e-001,1.534495026395216e-001,1.078869769535422e+000},
        {6.494512832440340e-001,-3.740041339282753e-001,1.507817132366013e-001,
        1.079406618718322e+000},{6.246863366052458e-001,-3.667912267567835e-001,
        1.481396651445827e-001,1.079939333931487e+000},{6.008588763477613e-001,
        -3.597846624325521e-001,1.455227094421928e-001,1.080467854433345e+000},
        {5.779285217568081e-001,-3.529787788792315e-001,1.429302039043457e-001,
        1.080992118162387e+000},{5.558567917843585e-001,-3.463681168961781e-001,
        1.403615126355752e-001,1.081512061695666e+000},{5.346068604525098e-001,
        -3.399474109122525e-001,1.378160056691672e-001,1.082027620205633e+000},
        {5.141434781643980e-001,-3.337115829553734e-001,1.352930585791013e-001,
        1.082538727415259e+000},{4.944329639780074e-001,-3.276557382434219e-001,
        1.327920520940830e-001,1.083045315551323e+000},{4.754430791164752e-001,
        -3.217751584695526e-001,1.303123716960193e-001,1.083547315295785e+000},
        {4.571429700194347e-001,-3.160652967851284e-001,1.278534072210391e-001,
        1.084044655735171e+000},{4.395030793576999e-001,-3.105217725167348e-001,
        1.254145524556692e-001,1.084537264307814e+000},{4.224951347995459e-001,
        -3.051403671189442e-001,1.229952047280423e-001,1.085025066748905e+000},
        {4.060920172580015e-001,-2.999170184671716e-001,1.205947644878575e-001,
        1.085507987033182e+000},{3.902677687631728e-001,-2.948478175978236e-001,
        1.182126348866422e-001,1.085985947315169e+000},{3.749974640139346e-001,
        -2.899290035159611e-001,1.158482213427176e-001,1.086458867866821e+000},
        {3.602572392362872e-001,-2.851569605786520e-001,1.135009311044318e-001,
        1.086926667012439e+000},{3.460241836412211e-001,-2.805282138082644e-001,
        1.111701727955525e-001,1.087389261060693e+000},{3.322762639573303e-001,
        -2.760394252131759e-001,1.088553559545610e-001,1.087846564233622e+000},
        {3.189924082087265e-001,-2.716873926785463e-001,1.065558905672928e-001,
        1.088298488592417e+000},{3.061522734419424e-001,-2.674690435082296e-001,
        1.042711865658687e-001,1.088744943959822e+000},{2.937363571423171e-001,
        -2.633814348735849e-001,1.020006533438568e-001,1.089185837838947e+000},
        {2.817258998316861e-001,-2.594217496446171e-001,9.974369922720212e-002,
        1.089621075328317e+000},{2.701028054319830e-001,-2.555872936090732e-001,
        9.749973094036724e-002,1.090050559032902e+000},{2.588496724626022e-001,
        -2.518754945945531e-001,9.526815305771809e-002,1.090474188970921e+000},
        {2.479497198536963e-001,-2.482838997491669e-001,9.304836742418512e-002,
        1.090891862476159e+000},{2.373867619937749e-001,-2.448101740087793e-001,
        9.083977255919505e-002,1.091303474095537e+000},{2.271451341955907e-001,
        -2.414520978672889e-001,8.864176303197963e-002,1.091708915481636e+000},
        {2.172097526882940e-001,-2.382075679770417e-001,8.645372882164712e-002,
        1.092108075279883e+000},{2.075659648124981e-001,-2.350745935908722e-001,
        8.427505462681409e-002,1.092500839010061e+000},{1.981996108168476e-001,
        -2.320512978432888e-001,8.210511916873743e-002,1.092887088941785e+000},
        {1.890969390096326e-001,-2.291359160192762e-001,7.994329444160937e-002,
        1.093266703963582e+000},{1.802446007941124e-001,-2.263267957100681e-001,
        7.778894493527934e-002,1.093639559445137e+000},{1.716296024717335e-001,
        -2.236223964383276e-001,7.564142681292767e-002,1.094005527092300e+000},
        {1.632392977069316e-001,-2.210212903349189e-001,7.350008705079136e-002,
        1.094364474794345e+000},{1.550613159026258e-001,-2.185221618314115e-001,
        7.136426252241583e-002,1.094716266463003e+000},{1.470836025508062e-001,
        -2.161238099240935e-001,6.923327904352281e-002,1.095060761862684e+000},
        {1.392943026502691e-001,-2.138251474258300e-001,6.710645034366781e-002,
        1.095397816431321e+000},{1.316817983518666e-001,-2.116252040084782e-001,
        6.498307699545154e-002,1.095727281091176e+000},{1.242346587117034e-001,
        -2.095231275596812e-001,6.286244526583852e-002,1.096049002048916e+000},
        {1.169415784462329e-001,-2.075181858211773e-001,6.074382589610382e-002,
        1.096362820584195e+000},{1.097913955238220e-001,-2.056097701035541e-001,
        5.862647281078301e-002,1.096668572825930e+000},{1.027730154333125e-001,
        -2.037973975454059e-001,5.650962173221349e-002,1.096966089515387e+000},
        {9.587540256029346e-002,-2.020807152969548e-001,5.439248870826525e-002,
        1.097255195755098e+000},{8.908754193525671e-002,-2.004595045004713e-001,
        5.227426853327376e-002,1.097535710742557e+000},{8.239836637349100e-002,
        -1.989336843919031e-001,5.015413305815167e-002,1.097807447487560e+000},
        {7.579678506229054e-002,-1.975033192009564e-001,4.803122938748919e-002,
        1.098070212511922e+000},{6.927156268654561e-002,-1.961686223190508e-001,
        4.590467792438880e-002,1.098323805530231e+000},{6.281133833354630e-002,
        -1.949299647595855e-001,4.377357029036171e-002,1.098568019110113e+000},
        {5.640453232697693e-002,-1.937878816798458e-001,4.163696706650428e-002,
        1.098802638310406e+000},{5.003932121783335e-002,-1.927430817480175e-001,
        3.949389537115199e-002,1.099027440295432e+000},{4.370356344501013e-002,
        -1.917964562372977e-001,3.734334623333660e-002,1.099242193923410e+000},
        {3.738474704089313e-002,-1.909490901638774e-001,3.518427175977259e-002,
        1.099446659306848e+000},{3.106990814761928e-002,-1.902022738733920e-001,
        3.301558205824082e-002,1.099640587342539e+000},{2.471924771693251e-002,
        -1.895570588253832e-001,3.083614013868847e-002,1.099823719208536e+000},
        {1.834223327637784e-002,-1.890154314600311e-001,2.864476241935234e-002,
        1.099995785825217e+000},{1.195094886503533e-002,-1.885798454355235e-001,
        2.644021168354557e-002,1.100156507277238e+000},{5.557050709009414e-003,
        -1.882515929288725e-001,2.418461128139228e-002,1.100307943910574e+000},
        {-8.014493909795158e-004,-1.880402684286048e-001,2.194575815737601e-002,
        1.100445109478535e+000},{-7.135417654424650e-003,-1.879436446578345e-001,
        1.972726442004061e-002,1.100567996583830e+000},{-1.345870138684300e-002,
        -1.879591637675092e-001,1.752795451986745e-002,1.100676931096945e+000},
        {-1.978471856691031e-002,-1.880845063496110e-001,1.534670037602332e-002,
        1.100772233147846e+000},{-2.612655707280306e-002,-1.883175768416115e-001,
        1.318241876916896e-002,1.100854217210090e+000},{-3.249697575622967e-002,
        -1.886564925021107e-001,1.103406890701701e-002,1.100923192183922e+000},
        {-3.890850468817631e-002,-1.890995704946074e-001,8.900650115975411e-003,
        1.100979461478381e+000},{-4.537347157514723e-002,-1.896453182395342e-001,
        6.781199688611053e-003,1.101023323092393e+000},{-5.190403204992995e-002,
        -1.902924240651144e-001,4.674790850459827e-003,1.101055069694875e+000},
        {-5.851225277558175e-002,-1.910397473018965e-001,2.580530837908182e-003,
        1.101074988703860e+000},{-6.521011476274589e-002,-1.918863113150857e-001,
        4.975591027557807e-004,1.101083362364609e+000},{-7.200957075288722e-002,
        -1.928312955496475e-001,-1.574954392253073e-003,1.101080467826757e+000},
        {-7.892258128041750e-002,-1.938740289010325e-001,-3.637810776014087e-003,
        1.101066577220491e+000},{-8.596114095058548e-002,-1.950139836709728e-001,
        -5.691783782005860e-003,1.101041957731749e+000},{-9.313731870582566e-002,
        -1.962507697828389e-001,-7.737621177713153e-003,1.101006871676471e+000},
        {-1.004633132706661e-001,-1.975841292444321e-001,-9.776046115403617e-003,
        1.100961576573900e+000},{-1.079514189138674e-001,-1.990139329502044e-001,
        -1.180775839988235e-002,1.100906325218945e+000},{-1.156141501458894e-001,
        -2.005401741857532e-001,-1.383343570756720e-002,1.100841365753626e+000},
        {-1.234641865756744e-001,-2.021629669142985e-001,-1.585373471362041e-002,
        1.100766941737587e+000},{-1.315144632458761e-001,-2.038825407987732e-001,
        -1.786929218092619e-002,1.100683292217720e+000},{-1.397781622796490e-001,
        -2.056992389395121e-001,-1.988072597730302e-002,1.100590651796894e+000},
        {-1.482687849379858e-001,-2.076135142055186e-001,-2.188863604735403e-002,
        1.100489250701797e+000},{-1.570001127509399e-001,-2.096259281418626e-001,
        -2.389360532338351e-002,1.100379314849913e+000},{-1.659863131041873e-001,
        -2.117371469439204e-001,-2.589620060511024e-002,1.100261065915656e+000},
        {-1.752419465890530e-001,-2.139479403721047e-001,-2.789697337688882e-002,
        1.100134721395630e+000},{-1.847819278769801e-001,-2.162591809460440e-001,
        -2.989646059049550e-002,1.100000494673090e+000},{-1.946216794315628e-001,
        -2.186718402076742e-001,-3.189518541573153e-002,1.099858595081566e+000},
        {-2.047770670769773e-001,-2.211869893365289e-001,-3.389365793731571e-002,
        1.099709227967682e+000},{-2.152644567239538e-001,-2.238057975178256e-001,
        -3.589237582835234e-002,1.099552594753185e+000},{-2.261007643374610e-001,
        -2.265295306054332e-001,-3.789182498937845e-002,1.099388892996184e+000},
        {-2.373034676588316e-001,-2.293595508675275e-001,-3.989248015126330e-002,
        1.099218316451631e+000},{-2.488906597672881e-001,-2.322973162338434e-001,
        -4.189480545039329e-002,1.099041055131017e+000},{-2.608810484226545e-001,
        -2.353443803241083e-001,-4.389925497691962e-002,1.098857295361356e+000},
        {-2.732940302195583e-001,-2.385023915702908e-001,-4.590627329721378e-002,
        1.098667219843396e+000},{-2.861497020009324e-001,-2.417730936839753e-001,
        -4.791629594706479e-002,1.098471007709130e+000},{-2.994689199938831e-001,
        -2.451583253792444e-001,-4.992974990525140e-002,1.098268834578575e+000},
        {-3.132732751354347e-001,-2.486600214001266e-001,-5.194705404153135e-002,
        1.098060872615857e+000},{-3.275852638322766e-001,-2.522802108711590e-001,
        -5.396861955037104e-002,1.097847290584594e+000},{-3.424281663994858e-001,
        -2.560210205428296e-001,-5.599485034861269e-002,1.097628253902595e+000},
        {-3.578293520435974e-001,-2.598846367187872e-001,-5.802614356800304e-002,
        1.097403924695883e+000},{-3.737991995924480e-001,-2.638735869985462e-001,
        -6.006288915407318e-002,1.097174461852052e+000},{-3.903902600560969e-001,
        -2.679898530112919e-001,-6.210547303843708e-002,1.096940021072966e+000},
        {-4.076012547942460e-001,-2.722364457397745e-001,-6.415427156013318e-002,
        1.096700754925520e+000},{-4.254343891046640e-001,-2.766161117295213e-001,
        -6.620965819623846e-002,1.096456812898149e+000},{-4.438339027573641e-001,
        -2.811320490392464e-001,-6.827199959147826e-002,1.096208341444035e+000},
        {-4.644750403946706e-001,-2.857679946652489e-001,-7.034170236902584e-002,
        1.095955484037268e+000},{-4.820890817525319e-001,-2.906000672424869e-001,
        -7.241891749894044e-002,1.095698381226341e+000},{-5.047134822541359e-001,
        -2.955056304565424e-001,-7.450444780138031e-002,1.095437170699271e+000},
        {-5.258914498568529e-001,-3.006012937060756e-001,-7.659813906378293e-002,
        1.095171987136068e+000},{-5.484047930470472e-001,-3.058375854914676e-001,
        -7.870062238535235e-002,1.094902962737344e+000},{-5.718129216158286e-001,
        -3.112278431359212e-001,-8.081217584455191e-002,1.094630226742015e+000},
        {-5.961547440676940e-001,-3.167755376343922e-001,-8.293313841275786e-002,
        1.094353905753897e+000},{-6.214708520460160e-001,-3.224842528277391e-001,
        -8.506384586954169e-002,1.094074123729523e+000},{-6.478032148383646e-001,
        -3.283576921832907e-001,-8.720463098789563e-002,1.093791002023522e+000},
        {-6.751957491746247e-001,-3.343996727291274e-001,-8.935582375150214e-002,
        1.093504659433427e+000},{-7.036936171960371e-001,-3.406141369349701e-001,
        -9.151775149673061e-002,1.093215212243908e+000},{-7.333438920356818e-001,
        -3.470051435467684e-001,-9.369073911646579e-002,1.092922774270491e+000},
        {-7.649284588825603e-001,-3.535701423882779e-001,-9.587512294577692e-002,
        1.092627456902683e+000},{-7.987573127935487e-001,-3.603086226499994e-001,
        -9.807123530043556e-002,1.092329369146623e+000},{-8.351881293636163e-001,
        -3.672179068043334e-001,-1.002794318903687e-001,1.092028617667189e+000},
        {-8.746337064830027e-001,-3.750216293989062e-001,-1.027084493542587e-001,
        1.091696779574096e+000},{-9.182631668618914e-001,-3.831991324672869e-001,
        -1.051985063743867e-001,1.091355729081559e+000},{-9.598866647526484e-001,
        -3.918556861719648e-001,-1.077524800454063e-001,1.091005198961375e+000},
        {-1.010790497453898e+000,-4.008622937465624e-001,-1.103741544582843e-001,
        1.090644908830807e+000},{-1.061585597914184e+000,-4.104074244317262e-001,
        -1.130664113126074e-001,1.090274564104240e+000},{-1.116923652713534e+000,
        -4.204470439736384e-001,-1.158334219482580e-001,1.089893855365184e+000},
        {-1.176390470616413e+000,-4.310341925159665e-001,-1.186791465288392e-001,
        1.089502456776096e+000},{-1.240398358090701e+000,-4.422099547341248e-001,
        -1.216079485825098e-001,1.089100025144463e+000},{-1.309411351967095e+000,
        -4.540194728668653e-001,-1.246245298507227e-001,1.088686198529077e+000},
        {-1.383952478324663e+000,-4.665124525546056e-001,-1.277339645466649e-001,
        1.088260594774788e+000},{-1.464613539394650e+000,-4.797437255410850e-001,
        -1.309417379885211e-001,1.087822809897360e+000},{-1.552065595474018e+000,
        -4.937739146636258e-001,-1.342537901400978e-001,1.087372416299330e+000},
        {-1.647071854814870e+000,-5.086701932065426e-001,-1.376765649336416e-001,
        1.086908960794945e+000},{-1.750503179964703e+000,-5.245071629179311e-001,
        -1.412170662450014e-001,1.086431962418652e+000},{-1.863356315547510e+000,
        -5.413678789587019e-001,-1.448829215901497e-001,1.085940909987632e+000},
        {-1.986775922871999e+000,-5.593450423418901e-001,-1.486824548572708e-001,
        1.085435259383995e+000},{-2.122081131299789e+000,-5.785423947412177e-001,
        -1.526247696085506e-001,1.084914430516412e+000},{-2.270797351520379e+000,
        -5.990763602365653e-001,-1.567198447858746e-001,1.084377803914027e+000},
        {-2.434695501360245e+000,-6.210779709042096e-001,-1.609786450924524e-001,
        1.083824716897111e+000},{-2.615838531681118e+000,-6.446951619454530e-001,
        -1.654132486612294e-001,1.083254459258780e+000},{-2.816639044616160e+000,
        -6.700954812249659e-001,-1.700369953943099e-001,1.082666268379815e+000},
        {-3.039928700415489e+000,-6.974693316356091e-001,-1.748646598439750e-001,
        1.082059323683556e+000},{-3.292219758098840e+000,-7.270000140981027e-001,
        -1.799127335700266e-001,1.081432740319499e+000},{-3.564782476198684e+000,
        -7.591050350223508e-001,-1.851990623476152e-001,1.080785561941540e+000},
        {-3.884190359823099e+000,-7.937345882311215e-001,-1.907452448062669e-001,
        1.080116752418797e+000},{-4.237141139726640e+000,-8.315523945506937e-001,
        -1.965727692029269e-001,1.079425186076460e+000},{-4.639142492737927e+000,
        -8.727752413556356e-001,-2.027083906666977e-001,1.078709637232685e+000},
        {-5.097189675608282e+000,-9.178820437390601e-001,-2.091811202970346e-001,
        1.077968766554805e+000},{-5.621762464449057e+000,-9.673950144480338e-001,
        -2.160241562151455e-001,1.077201106424277e+000},{-6.225833712033967e+000,
        -1.021929051176963e+000,-2.232753772451849e-001,1.076405043117602e+000},
        {-6.925601260591495e+000,-1.082212356404202e+000,-2.309782180242463e-001,
        1.075578795840945e+000},{-7.741476361496349e+000,-1.149112657464135e+000,
        -2.391827511126749e-001,1.074720391772839e+000},{-8.699439370277643e+000,
        -1.223670757770951e+000,-2.479470365689759e-001,1.073827636152860e+000},
        {-9.832921391371407e+000,-1.307143891200575e+000,-2.573388201788544e-001,
        1.072898076168983e+000},{-1.118545570250340e+001,-1.401062230883758e+000,
        -2.674376916575652e-001,1.071928957010234e+000},{-1.281446878655493e+001,
        -1.507303306245227e+000,-2.783378567732671e-001,1.070917167920417e+000},
        {-1.479678827882319e+001,-1.628191020093895e+000,-2.901517399548284e-001,
        1.069859175350126e+000},{-1.724144136142261e+001,-1.766576297530559e+000,
        -3.030148579310907e-001,1.068750939259828e+000},{-2.027826987203854e+001,
        -1.926337376059677e+000,-3.170912838064992e-001,1.067587807127434e+000},
        {-2.413687940816858e+001,-2.111734868657410e+000,-3.325851366637468e-001,
        1.066364378021886e+000},{-2.909401840847157e+001,-2.329151580543732e+000,
        -3.497470819764231e-001,1.065074325623783e+000},{-3.559985600470116e+001,
        -2.586219259879967e+000,-3.688972788252130e-001,1.063710165062041e+000},
        {-4.432903871576617e+001,-2.893237376748189e+000,-3.904455236187271e-001,
        1.062262938236866e+000},{-5.635486800356907e+001,-3.263787309390394e+000,
        -4.149289589297027e-001,1.060721782952100e+000},{-7.345422356224562e+001,
        -3.715852360320928e+000,-4.430674062157222e-001,1.059073327378870e+000},
        {-9.872541030429800e+001,-4.272847713002282e+000,-4.758525332055549e-001,
        1.057300816644650e+000},{-1.379029789580371e+002,-4.963698528158174e+000,
        -5.146977811000596e-001,1.055382812700357e+000},{-2.025227956751322e+002,
        -5.816502032157165e+000,-5.617124713275824e-001,1.053291185212563e+000},
        {-3.066576906266529e+002,-6.965314926095712e+000,-6.198853650303311e-001,
        1.050987862948901e+000},{-4.830543755124683e+002,-8.666062419141326e+000,
        -6.938823513423141e-001,1.048419277617361e+000},{-8.084833331246175e+002,
        -1.148692234324379e+001,-7.910281397083958e-001,1.045506157577100e+000},
        {-1.468144450984898e+003,-1.270342041479051e+001,-8.932720264828298e-001,
        1.043022458452853e+000},{-2.960185006157666e+003,-1.204645827816411e+001,
        -1.037687543523871e+000,1.040192609451484e+000},{-6.394379648177180e+003,
        -1.133095662667407e+001,-1.255214139021270e+000,1.036731981255395e+000},
        {-1.421291626844065e+004,-2.176830415540717e+001,-1.565859480023533e+000,
        1.032664478961364e+000},{-3.188506981409266e+004,-4.472235675466877e+001,
        -1.957122092195666e+000,1.028823550217078e+000},{-7.717088076510136e+004,
        -4.157109709425348e+001,-2.425675063473610e+000,1.025629204891293e+000},
        {-1.893604841837793e+005,1.988107110128464e+001,-3.037933999829498e+000,
        1.022682315051265e+000},{-4.362759910617617e+005,4.356252894797460e+000,
        -3.857056802145624e+000,1.019493900338764e+000},{-9.667858531739716e+005,
        -7.110743222205122e+002,-5.068028151693111e+000,1.015606411778339e+000},
        {-1.926807175753026e+006,-1.308643373681819e+003,-6.100046763833379e+000,
        1.013498423615123e+000},{-4.430874958584904e+006,-5.255191972894967e+002,
        -6.892511697752738e+000,1.012521645013935e+000},{-1.306500915854772e+007,
        1.740498999891739e+003,-8.577603939805345e+000,1.010846737556340e+000},
        {-4.389793234302502e+007,9.560482174458750e+003,-1.148948797863325e+001,
        1.009039661353492e+000},{-1.453953316964447e+008,8.587054210867187e+003,
        -1.476464101007846e+001,1.006692766581286e+000},{-3.516933123906404e+008,
        -1.085943267171107e+004,-1.840303816166151e+001,1.005101578506159e+000},
        {-2.510574163087101e+012,1.191163343802633e+008,-1.412900529450008e+003,
        1.004074865378772e+000}};
    constant Real[Ninterval, 4] slcoef={{1.177557139507648e+010,-1.993514199606193e+006,
        4.143546065409241e+002,2.641402961120132e-001},{1.048671143722957e+010,
        -1.884478673305442e+006,4.037631012049168e+002,2.652511930832029e-001},
        {9.168562051007404e+009,-1.788981183928967e+006,3.950602310696419e+002,
        2.661829932674829e-001},{7.846446101028213e+009,-1.614583713308304e+006,
        3.761535139366466e+002,2.682996669625260e-001},{6.715017635832893e+009,
        -1.457222530950107e+006,3.581621886022840e+002,2.704246269918255e-001},
        {5.747015349679062e+009,-1.315240915328985e+006,3.410420212198932e+002,
        2.725579055981067e-001},{4.918630356754790e+009,-1.187122828234776e+006,
        3.247498175022562e+002,2.746996665285123e-001},{4.209783796072495e+009,
        -1.071515458129660e+006,3.092453129575851e+002,2.768499837872521e-001},
        {3.603174902826428e+009,-9.671924631452678e+005,2.944898874475471e+002,
        2.790089741555691e-001},{3.084079936755044e+009,-8.730521764425569e+005,
        2.804471553915772e+002,2.811767093063310e-001},{2.639848105537634e+009,
        -7.880971686153368e+005,2.670822304519017e+002,2.833533034650044e-001},
        {2.259641698967966e+009,-7.114290219738688e+005,2.543622233288261e+002,
        2.855388260072460e-001},{1.934270134269886e+009,-6.422381187091104e+005,
        2.422554107091234e+002,2.877334319246923e-001},{1.655784123271669e+009,
        -5.797918189723861e+005,2.307318702957838e+002,2.899372311407367e-001},
        {1.417436324893234e+009,-5.234328119503804e+005,2.197634071875102e+002,
        2.921502891166354e-001},{1.213429199043588e+009,-4.725651621534369e+005,
        2.093227855305521e+002,2.943727562457704e-001},{1.038821174264480e+009,
        -4.266538020807887e+005,1.993845312208418e+002,2.966046954288835e-001},
        {8.900554569418168e+008,-3.852391963057016e+005,1.899242490751680e+002,
        2.988462540463003e-001},{7.648023186829292e+008,-3.479479314856909e+005,
        1.809193670502903e+002,3.010975350565891e-001},{6.592177452001010e+008,
        -3.143877634345993e+005,1.723482399369443e+002,3.033586400558302e-001},
        {5.700843185859680e+008,-2.846663102712536e+005,1.643477796985073e+002,
        3.055842723398675e-001},{4.943633825796188e+008,-2.589969957748900e+005,
        1.571225846083740e+002,3.076990337830958e-001},{4.291125156131715e+008,
        -2.357953619216334e+005,1.502638626066520e+002,3.098084456029034e-001},
        {3.728306499579160e+008,-2.148103610406289e+005,1.437508020718366e+002,
        3.119125568514417e-001},{3.242364285177285e+008,-1.958176234450135e+005,
        1.375638868362061e+002,3.140114157267036e-001},{2.822412748713871e+008,
        -1.786169231686780e+005,1.316848160932519e+002,3.161050695947951e-001},
        {2.459125658184237e+008,-1.630289616337319e+005,1.260964138486158e+002,
        3.181935650115526e-001},{2.144580625278116e+008,-1.488936415091122e+005,
        1.207825640937267e+002,3.202769477435048e-001},{1.871966290478286e+008,
        -1.360673141338019e+005,1.157281282277565e+002,3.223552627882310e-001},
        {1.635488056210168e+008,-1.244215705088064e+005,1.109188923271442e+002,
        3.244285543941092e-001},{1.430161329214414e+008,-1.138410894667223e+005,
        1.063414954697406e+002,3.264968660794893e-001},{1.251717914268840e+008,
        -1.042224881444728e+005,1.019833809887122e+002,3.285602406513014e-001},
        {1.096508061352110e+008,-9.547306166403441e+004,9.783274285471715e+001,
        3.306187202231238e-001},{9.613753724667005e+007,-8.750933370030554e+004,
        9.387847130169364e+001,3.326723462327222e-001},{8.436265639394236e+007,
        -8.025648609043579e+004,9.011011773741680e+001,3.347211594590819e-001},
        {7.409313187822527e+007,-7.364708312272583e+004,8.651784263733413e+001,
        3.367652000389455e-001},{6.512895658412796e+007,-6.762051692091678e+004,
        8.309238335216898e+001,3.388045074828699e-001},{5.729728405538097e+007,
        -6.212215934894936e+004,7.982501352086291e+001,3.408391206908288e-001},
        {5.044953216127181e+007,-5.710284583154797e+004,7.670751215248156e+001,
        3.428690779673607e-001},{4.445647437035704e+007,-5.251814570452608e+004,
        7.373212777286675e+001,3.448944170362825e-001},{3.920767247485867e+007,
        -4.832812939512341e+004,7.089155600321682e+001,3.469151750549936e-001},
        {3.460643566473103e+007,-4.449659421205359e+004,6.817890214139165e+001,
        3.489313886283582e-001},{3.056970641837368e+007,-4.099094122891565e+004,
        6.558766506547076e+001,3.509430938222040e-001},{2.702540190216035e+007,
        -3.778168333466380e+004,6.311170749756870e+001,3.529503261764371e-001},
        {2.391081714254122e+007,-3.484213008611726e+004,6.074523461994335e+001,
        3.549531207177877e-001},{2.117170192432593e+007,-3.214816129623113e+004,
        5.848277505538282e+001,3.569515119721937e-001},{1.876094064229434e+007,
        -2.967793653594457e+004,5.631915951588184e+001,3.589455339768409e-001},
        {1.663741340545124e+007,-2.741164725010574e+004,5.424950232335298e+001,
        3.609352202918695e-001},{1.476547731295308e+007,-2.533136468686681e+004,
        5.226918630626200e+001,3.629206040117464e-001},{1.311405368894354e+007,
        -2.342082009135800e+004,5.037384498385280e+001,3.649017177763315e-001},
        {1.165604536024709e+007,-2.166524918697802e+004,4.855934824972481e+001,
        3.668785937816321e-001},{1.036780283368990e+007,-2.005124607418004e+004,
        4.682178849186924e+001,3.688512637902600e-001},{9.228723479638483e+006,
        -1.856664063058170e+004,4.515746777050035e+001,3.708197591416083e-001},
        {8.220767144960379e+006,-1.720036292993756e+004,4.356288478792973e+001,
        3.727841107617398e-001},{7.328189892577781e+006,-1.594235240875964e+004,
        4.203472422676561e+001,3.747443491730145e-001},{6.537204250437003e+006,
        -1.478345202257369e+004,4.056984541826727e+001,3.767005045034494e-001},
        {5.835726559790004e+006,-1.371532397872642e+004,3.916527248752735e+001,
        3.786526064958268e-001},{5.213185995368226e+006,-1.273037834190048e+004,
        3.781818514258747e+001,3.806006845165569e-001},{4.660312354353476e+006,
        -1.182169731669702e+004,3.652590940436652e+001,3.825447675643013e-001},
        {4.168939088305709e+006,-1.098296699999315e+004,3.528590920102089e+001,
        3.844848842783646e-001},{3.731941349696544e+006,-1.020843939792505e+004,
        3.409577949657835e+001,3.864210629468634e-001},{3.343018842151671e+006,
        -9.492857477753520e+003,3.295323749642467e+001,3.883533315146766e-001},
        {2.996638160477085e+006,-8.831424276104683e+003,3.185611695501934e+001,
        3.902817175911858e-001},{2.687950210708543e+006,-8.219762157299303e+003,
        3.080236148343732e+001,3.922062484578109e-001},{2.412652443194333e+006,
        -7.653860521818649e+003,2.979001765514563e+001,3.941269510753455e-001},
        {2.166972405327071e+006,-7.130058286584131e+003,2.881723052100683e+001,
        3.960438520911025e-001},{1.947576947792416e+006,-6.645003522979915e+003,
        2.788223738207444e+001,3.979569778458746e-001},{1.751525675665824e+006,
        -6.195628233643848e+003,2.698336301772617e+001,3.998663543807083e-001},
        {1.576215494282452e+006,-5.779120941281210e+003,2.611901481818039e+001,
        4.017720074435056e-001},{1.419353182727988e+006,-5.392908148824695e+003,
        2.528767861012635e+001,4.036739624954574e-001},{1.278906533893276e+006,
        -5.034629032900475e+003,2.448791404432028e+001,4.055722447173105e-001},
        {1.153074815308473e+006,-4.702117917310478e+003,2.371835083258324e+001,
        4.074668790154691e-001},{1.040267269572240e+006,-4.393389187391892e+003,
        2.297768513031833e+001,4.093578900279491e-001},{9.390721944414651e+005,
        -4.106619140813017e+003,2.226467576001038e+001,4.112453021301762e-001},
        {8.482361512114307e+005,-3.840132438338376e+003,2.157814101065838e+001,
        4.131291394406401e-001},{7.666490444341356e+005,-3.592390669372514e+003,
        2.091695561139572e+001,4.150094258264032e-001},{6.933244377674338e+005,
        -3.361979229162954e+003,2.028004761843898e+001,4.168861849084756e-001},
        {6.273833850441934e+005,-3.147596365453398e+003,1.966639566026135e+001,
        4.187594400670539e-001},{5.680493701729885e+005,-2.948046437224073e+003,
        1.907502654460529e+001,4.206292144466324e-001},{5.146259094288983e+005,
        -2.762226337105739e+003,1.850501230753378e+001,4.224955309609856e-001},
        {4.664966079472982e+005,-2.589122141751236e+003,1.795546841607669e+001,
        4.243584122980267e-001},{4.231115651009208e+005,-2.427799181763609e+003,
        1.742555118911682e+001,4.262178809245570e-001},{3.839792678848923e+005,
        -2.277395453181725e+003,1.691445579070118e+001,4.280739590908861e-001},
        {3.486632470541687e+005,-2.137117115184443e+003,1.642141441733220e+001,
        4.299266688353537e-001},{3.167723452866394e+005,-2.006231019071146e+003,
        1.594569419580369e+001,4.317760319887326e-001},{2.879581579606791e+005,
        -1.884061136618374e+003,1.548659563100448e+001,4.336220701785344e-001},
        {2.619091112658384e+005,-1.769983168287696e+003,1.504345081784956e+001,
        4.354648048332044e-001},{2.383466576671081e+005,-1.663420519322795e+003,
        1.461562190867013e+001,4.373042571862285e-001},{2.170211247057410e+005,
        -1.563840223729814e+003,1.420249960746107e+001,4.391404482801311e-001},
        {1.977102806012762e+005,-1.470750305289779e+003,1.380350185368774e+001,
        4.409733989703888e-001},{1.802132568331950e+005,-1.383694745078228e+003,
        1.341807226290494e+001,4.428031299292535e-001},{1.643517256222710e+005,
        -1.302252783281351e+003,1.304567919411233e+001,4.446296616494750e-001},
        {1.499647429474115e+005,-1.226034288211031e+003,1.268581423597655e+001,
        4.464530144479596e-001},{1.369083619764228e+005,-1.154678401042467e+003,
        1.233799128533460e+001,4.482732084693222e-001},{1.250530635446248e+005,
        -1.087850707548286e+003,1.200174537304730e+001,4.500902636893757e-001},
        {1.142828813183554e+005,-1.025241603778916e+003,1.167663171816983e+001,
        4.519041999185328e-001},{1.044932010702937e+005,-9.665638335328233e+002,
        1.136222467710369e+001,4.537150368051356e-001},{9.559024735983493e+004,
        -9.115512664941300e+002,1.105811692791990e+001,4.555227938387087e-001},
        {8.748948014204207e+004,-8.599568992252292e+002,1.076391852809859e+001,
        4.573274903531447e-001},{8.011488050377187e+004,-8.115515935776252e+002,
        1.047925614072886e+001,4.591291455298160e-001},{7.339789345132106e+004,
        -7.661225797978357e+002,1.020377222883108e+001,4.609277784006200e-001},
        {6.727691002196107e+004,-7.234723932600134e+002,9.937124346632666e+000,
        4.627234078509644e-001},{6.169614021722738e+004,-6.834173972226075e+002,
        9.678984382191800e+000,4.645160526226781e-001},{5.660547400068403e+004,
        -6.457871273196512e+002,9.429037972024533e+000,4.663057313168709e-001},
        {5.195953611750653e+004,-6.104229732107484e+002,9.186983791759216e+000,
        4.680924623967295e-001},{4.771745208001675e+004,-5.771775202529138e+002,
        8.952533011439000e+000,4.698762641902499e-001},{4.384220812640152e+004,
        -5.459135464020653e+002,8.725408685310237e+000,4.716571548929249e-001},
        {4.030038590987054e+004,-5.165033923275631e+002,8.505345242117434e+000,
        4.734351525703650e-001},{3.706177619104521e+004,-4.888282167622580e+002,
        8.292087953582172e+000,4.752102751608759e-001},{3.409901222107622e+004,
        -4.627773087875500e+002,8.085392439164183e+000,4.769825404779763e-001},
        {3.138732351663624e+004,-4.382475368783908e+002,7.885024214209901e+000,
        4.787519662128720e-001},{2.890427534083820e+004,-4.151427919551941e+002,
        7.690758243308068e+000,4.805185699368778e-001},{2.662955418230496e+004,
        -3.933734889327271e+002,7.502378519257654e+000,4.822823691037926e-001},
        {2.454471428578327e+004,-3.728560514675434e+002,7.319677653248337e+000,
        4.840433810522326e-001},{2.263303970197622e+004,-3.535125325278318e+002,
        7.142456508875918e+000,4.858016230079136e-001},{2.087936933258245e+004,
        -3.352701961397641e+002,6.970523831131070e+000,4.875571120858966e-001},
        {1.926989719907531e+004,-3.180611010588355e+002,6.803695893605354e+000,
        4.893098652927868e-001},{1.779213064394456e+004,-3.018218612541485e+002,
        6.641796195081590e+000,4.910598995288961e-001},{1.643469380853188e+004,
        -2.864932315962904e+002,6.484655115123119e+000,4.928072315903642e-001},
        {1.518723269686234e+004,-2.720198428014330e+002,6.332109630922232e+000,
        4.945518781712424e-001},{1.404034267449176e+004,-2.583499599306953e+002,
        6.184003039444280e+000,4.962938558655389e-001},{1.298547086145065e+004,
        -2.454352119567302e+002,6.040184677120072e+000,4.980331811692316e-001},
        {1.201480477719220e+004,-2.332303254901078e+002,5.900509656039089e+000,
        4.997698704822443e-001},{1.112125559868982e+004,-2.216929799079140e+002,
        5.764838638887057e+000,5.015039401103889e-001},{1.029834063001183e+004,
        -2.107835348750359e+002,5.633037579396170e+000,5.032354062672774e-001},
        {9.540169613654271e+003,-2.004649068816667e+002,5.504977520065665e+000,
        5.049642850761986e-001},{8.841350078353322e+003,-1.907023386990655e+002,
        5.380534358885717e+000,5.066905925719676e-001},{8.196974604965422e+003,
        -1.814632922354595e+002,5.259588665038832e+000,5.084143447027471e-001},
        {7.602559262208660e+003,-1.727172694039041e+002,5.142025470829316e+000,
        5.101355573318360e-001},{7.054006287042218e+003,-1.644356797777449e+002,
        5.027734090331723e+000,5.118542462394324e-001},{6.547574282638359e+003,
        -1.565917209939956e+002,4.916607944897258e+000,5.135704271243708e-001},
        {6.079842281410332e+003,-1.491602529370824e+002,4.808544390805874e+000,
        5.152841156058329e-001},{5.647681402804354e+003,-1.421176889479255e+002,
        4.703444558999890e+000,5.169953272250335e-001},{5.248227929512284e+003,
        -1.354418928357044e+002,4.601213200953995e+000,5.187040774468807e-001},
        {4.878866346015187e+003,-1.291120924929621e+002,4.501758543631354e+000,
        5.204103816616156e-001},{4.537191205039604e+003,-1.231087657275091e+002,
        4.404992140311703e+000,5.221142551864300e-001},{4.221010702237321e+003,
        -1.174135968361089e+002,4.310828751515844e+000,5.238157132670570e-001},
        {3.928309050855646e+003,-1.120093625136355e+002,4.219186199256487e+000,
        5.255147710793474e-001},{3.657237561904996e+003,-1.068798773450843e+002,
        4.129985254777306e+000,5.272114437308226e-001},{3.406108390579024e+003,
        -1.020099385885924e+002,4.043149522766261e+000,5.289057462622082e-001},
        {3.173362528937843e+003,-9.738523071542197e+001,3.958605315724437e+000,
        5.305976936489506e-001},{2.957575972851209e+003,-9.299230413876768e+001,
        3.876281564344415e+000,5.322873008027116e-001},{2.757441473645700e+003,
        -8.881850292721700e+001,3.796109702595772e+000,5.339745825728525e-001},
        {2.571752175640579e+003,-8.485190527654152e+001,3.718023568465873e+000,
        5.356595537478953e-001},{2.399405315832375e+003,-8.108130218799091e+001,
        3.641959321507089e+000,5.373422290569717e-001},{2.239383750765094e+003,
        -7.749613093565345e+001,3.567855339770726e+000,5.390226231712563e-001},
        {2.090753731341121e+003,-7.408644637791140e+001,3.495652141216298e+000,
        5.407007507053830e-001},{1.952653808168716e+003,-7.084287425064484e+001,
        3.425292296888851e+000,5.423766262188504e-001},{1.824293969495761e+003,
        -6.775658698526449e+001,3.356720357330965e+000,5.440502642174112e-001},
        {1.704945388258175e+003,-6.481925944163990e+001,3.289882770290317e+000,
        5.457216791544545e-001},{1.593935912714465e+003,-6.202304097497358e+001,
        3.224727811476121e+000,5.473908854323666e-001},{1.490648848056936e+003,
        -5.936053328755472e+001,3.161205517518115e+000,5.490578974038881e-001},
        {1.394512592254002e+003,-5.682474952754494e+001,3.099267612151868e+000,
        5.507227293734606e-001},{1.305002583866976e+003,-5.440910349376155e+001,
        3.038867451236471e+000,5.523853955985542e-001},{1.221633497165447e+003,
        -5.210737493440172e+001,2.979959954204727e+000,5.540459102909946e-001},
        {1.143958328479689e+003,-4.991369373166751e+001,2.922501549923314e+000,
        5.557042876182787e-001},{1.071563973096530e+003,-4.782251531429407e+001,
        2.866450117837696e+000,5.573605417048770e-001},{1.004069097487647e+003,
        -4.582860310204230e+001,2.811764935547721e+000,5.590146866335348e-001},
        {9.411214959043084e+002,-4.392700984466779e+001,2.758406626564467e+000,
        5.606667364465596e-001},{8.823958497130813e+002,-4.211306059866846e+001,
        2.706337110626942e+000,5.623167051471074e-001},{8.275910331590102e+002,
        -4.038233540368031e+001,2.655519555526163e+000,5.639646067004543e-001},
        {7.764290444119635e+002,-3.873065665643446e+001,2.605918332887885e+000,
        5.656104550352749e-001},{7.286523598314500e+002,-3.715407256916351e+001,
        2.557498972533741e+000,5.672542640448997e-001},{6.840231188009741e+002,
        -3.564884626586955e+001,2.510228121970509e+000,5.688960475885800e-001},
        {6.423204961199782e+002,-3.421144032546041e+001,2.464073504009842e+000,
        5.705358194927445e-001},{6.033409092767411e+002,-3.283850964957904e+001,
        2.419003880919390e+000,5.721735935522480e-001},{5.668947663597646e+002,
        -3.152688470052121e+001,2.374989013056672e+000,5.738093835316227e-001},
        {5.328072442146844e+002,-3.027356738128294e+001,2.331999627743732e+000,
        5.754432031663234e-001},{5.009158770478630e+002,-2.907571683947941e+001,
        2.290007380866240e+000,5.770750661639714e-001},{4.710701060225499e+002,
        -2.793064247095762e+001,2.248984825962424e+000,5.787049862055952e-001},
        {4.431303458782849e+002,-2.683579521467626e+001,2.208905382049609e+000,
        5.803329769468701e-001},{4.169669853608175e+002,-2.578875908229225e+001,
        2.169743302771505e+000,5.819590520193594e-001},{3.924599612327291e+002,
        -2.478724467824711e+001,2.131473647762967e+000,5.835832250317513e-001},
        {3.694974326826228e+002,-2.382908020411502e+001,2.094072253087125e+000,
        5.852055095710999e-001},{3.479758690185427e+002,-2.291220742271244e+001,
        2.057515706247509e+000,5.868259192040625e-001},{3.277990349520803e+002,
        -2.203467367031391e+001,2.021781318214516e+000,5.884444674781422e-001},
        {3.088773751747854e+002,-2.119462597004226e+001,1.986847098785308e+000,
        5.900611679229281e-001},{2.911276710946399e+002,-2.039030622074293e+001,
        1.952691733147482e+000,5.916760340513410e-001},{2.744727583811454e+002,
        -1.962004641525278e+001,1.919294558620836e+000,5.932890793608796e-001},
        {2.588404421844505e+002,-1.888226154495557e+001,1.886635540737936e+000,
        5.949003173348717e-001},{2.441640574222745e+002,-1.817544854701309e+001,
        1.854695254828505e+000,5.965097614437249e-001},{2.303811979773995e+002,
        -1.749817830600921e+001,1.823454861736828e+000,5.981174251461863e-001},
        {2.174338229345144e+002,-1.684909368569987e+001,1.792896090563822e+000,
        5.997233218906050e-001},{2.052680630074077e+002,-1.622690586536061e+001,
        1.763001219089102e+000,6.013274651161965e-001},{1.938335084437520e+002,
        -1.563038905829366e+001,1.733753053902124e+000,6.029298682543182e-001},
        {1.830833151646721e+002,-1.505837875682940e+001,1.705134914485336e+000,
        6.045305447297478e-001},{1.729738794162456e+002,-1.450976794132127e+001,
        1.677130615134082e+000,6.061295079619681e-001},{1.634643534138694e+002,
        -1.398350312812421e+001,1.649724447957303e+000,6.077267713664593e-001},
        {1.545168100337110e+002,-1.347858315714356e+001,1.622901168714866e+000,
        6.093223483560010e-001},{1.460958410201101e+002,-1.299405538735645e+001,
        1.596645980019152e+000,6.109162523419806e-001},{1.381683087466291e+002,
        -1.252901301082886e+001,1.570944516844422e+000,6.125084967357085e-001},
        {1.307034321865140e+002,-1.208259371162506e+001,1.545782833329511e+000,
        6.140990949497484e-001},{1.236723317608070e+002,-1.165397599514970e+001,
        1.521147387543556e+000,6.156880603992511e-001},{1.170481387221509e+002,
        -1.124237826774210e+001,1.497025029811643e+000,6.172754065033039e-001},
        {1.108056868876664e+002,-1.084705592255838e+001,1.473402988869848e+000,
        6.188611466862878e-001},{1.049215003603412e+002,-1.046729998779377e+001,
        1.450268860366462e+000,6.204452943792466e-001},{9.937360667485126e+001,
        -1.010243494098661e+001,1.427610594553690e+000,6.220278630212706e-001},
        {9.414149562320388e+001,-9.751817308176173e+000,1.405416485272351e+000,
        6.236088660608912e-001},{8.920594267310152e+001,-9.414833664957618e+000,
        1.383675158529162e+000,6.251883169574887e-001},{8.454903027300053e+001,
        -9.090899637706979e+000,1.362375562499242e+000,6.267662291827165e-001},
        {8.015389759910782e+001,-8.779457645122895e+000,1.341506956391433e+000,
        6.283426162219348e-001},{7.600486056876090e+001,-8.479976561864010e+000,
        1.321058901855560e+000,6.299174915756673e-001},{7.208717369456534e+001,
        -8.191949484083496e+000,1.301021252132937e+000,6.314908687610693e-001},
        {6.838705121588522e+001,-7.914893045725918e+000,1.281384143757086e+000,
        6.330627613134094e-001},{6.489158353825010e+001,-7.648346098298011e+000,
        1.262137987358314e+000,6.346331827875775e-001},{6.158865359007402e+001,
        -7.391868500456181e+000,1.243273459030718e+000,6.362021467596020e-001},
        {5.846693732764923e+001,-7.145040366143715e+000,1.224781492411206e+000,
        6.377696668281924e-001},{5.551578714608965e+001,-6.907460700958014e+000,
        1.206653270182385e+000,6.393357566162956e-001},{5.272524836667247e+001,
        -6.678746838311933e+000,1.188880216903054e+000,6.409004297726797e-001},
        {5.008596334489375e+001,-6.458533233599964e+000,1.171453991082903e+000,
        6.424636999735307e-001},{4.758916027537743e+001,-6.246470825439416e+000,
        1.154366478347685e+000,6.440255809240784e-001},{4.522661777454572e+001,
        -6.042226222837200e+000,1.137609784387375e+000,6.455860863602415e-001},
        {4.299059529145632e+001,-5.845480767898403e+000,1.121176228050880e+000,
        6.471452300502958e-001},{4.087385651641105e+001,-5.655930154963713e+000,
        1.105058335319868e+000,6.487030257965678e-001},{3.886958211331500e+001,
        -5.473283382598018e+000,1.089248832461124e+000,6.502594874371552e-001},
        {3.697137968566206e+001,-5.297262376818222e+000,1.073740640458812e+000,
        6.518146288476706e-001},{3.517323133258112e+001,-5.127601210969972e+000,
        1.058526868867246e+000,6.533684639430138e-001},{3.346950230781325e+001,
        -4.964045728469465e+000,1.043600810436168e+000,6.549210066791725e-001},
        {3.185487406683293e+001,-4.806352703624465e+000,1.028955935203351e+000,
        6.564722710550539e-001},{3.032435829488426e+001,-4.654289580618860e+000,
        1.014585885688922e+000,6.580222711143396e-001},{2.887326431964138e+001,
        -4.507633864545065e+000,1.000484471508354e+000,6.595710209473816e-001},
        {2.749717316692134e+001,-4.366172615618259e+000,9.866456644267092e-001,
        6.611185346931201e-001},{2.619193414367822e+001,-4.229702099346732e+000,
        9.730635937337092e-001,6.626648265410450e-001},{2.495363835111331e+001,
        -4.098027281300438e+000,9.597325414590835e-001,6.642099107331829e-001},
        {2.377860550726019e+001,-3.970961446183043e+000,9.466469379706444e-001,
        6.657538015661222e-001},{2.266337233016693e+001,-3.848325831387194e+000,
        9.338013576655492e-001,6.672965133930829e-001},{2.160467672777616e+001,
        -3.729949242177387e+000,9.211905147420358e-001,6.688380606260099e-001},
        {2.059944597797794e+001,-3.615667710660913e+000,9.088092591623421e-001,
        6.703784577377188e-001},{1.964478435281932e+001,-3.505324163030878e+000,
        8.966525727283551e-001,6.719177192640737e-001},{1.873796922977412e+001,
        -3.398768146844634e+000,8.847155653316714e-001,6.734558598062153e-001},
        {1.787642149968706e+001,-3.295855398505439e+000,8.729934710857658e-001,
        6.749928940328205e-001},{1.705772475648577e+001,-3.196447779163808e+000,
        8.614816451578189e-001,6.765288366824221e-001},{1.627958838837261e+001,
        -3.100412774885759e+000,8.501755598619032e-001,6.780637025657604e-001},
        {1.553985861020304e+001,-3.007623409690961e+000,8.390708017061733e-001,
        6.795975065681920e-001},{1.483650268463432e+001,-2.917957920404044e+000,
        8.281630679467027e-001,6.811302636521479e-001},{1.416760134746515e+001,
        -2.831299527564026e+000,8.174481635066645e-001,6.826619888596361e-001},
        {1.353134120238906e+001,-2.747536216213803e+000,8.069219979743360e-001,
        6.841926973148044e-001},{1.292601643446513e+001,-2.666560582542707e+000,
        7.965805827418926e-001,6.857224042265560e-001},{1.235001093430196e+001,
        -2.588269530043726e+000,7.864200279596690e-001,6.872511248912188e-001},
        {1.180180110648852e+001,-2.512564159266709e+000,7.764365399883577e-001,
        6.887788746952784e-001},{1.127994572214277e+001,-2.439349541127092e+000,
        7.666264186212466e-001,6.903056691181669e-001},{1.078308769186625e+001,
        -2.368534595338057e+000,7.569860545909910e-001,6.918315237351190e-001},
        {1.030993774691330e+001,-2.300031826875883e+000,7.475119268835549e-001,
        6.933564542200881e-001},{9.859284768878347e+000,-2.233757299471081e+000,
        7.382006005926595e-001,6.948804763487342e-001},{9.429977302790977e+000,
        -2.169630350046961e+000,7.290487242579775e-001,6.964036060014773e-001},
        {9.020930833273008e+000,-2.107573555178198e+000,7.200530278593177e-001,
        6.979258591666266e-001},{8.631118936097311e+000,-2.047512534366139e+000,
        7.112103204288415e-001,6.994472519435792e-001},{8.259568678315045e+000,
        -1.989375816183700e+000,7.025174879430843e-001,7.009678005461024e-001},
        {7.905362523492994e+000,-1.933094759596863e+000,6.939714913370646e-001,
        7.024875213056877e-001},{7.567629408573509e+000,-1.878603376629717e+000,
        6.855693643504452e-001,7.040064306749948e-001},{7.245546619771394e+000,
        -1.825838268287014e+000,6.773082117040159e-001,7.055245452313755e-001},
        {6.938335727792247e+000,-1.774738495351617e+000,6.691852071288535e-001,
        7.070418816804905e-001},{6.645258809195010e+000,-1.725245462939452e+000,
        6.611975915196259e-001,7.085584568600147e-001},{6.365614540873520e+000,
        -1.677302816738685e+000,6.533426711767790e-001,7.100742877434374e-001},
        {6.098745266050226e+000,-1.630856430792350e+000,6.456178162181659e-001,
        7.115893914439659e-001},{5.844020409205720e+000,-1.585854168116521e+000,
        6.380204585489425e-001,7.131037852185249e-001},{5.600848065869145e+000,
        -1.542245944546190e+000,6.305480906509974e-001,7.146174864718647e-001},
        {5.368663822551122e+000,-1.499983538515395e+000,6.231982636835136e-001,
        7.161305127607802e-001},{5.146934075674603e+000,-1.459020574408473e+000,
        6.159685861501743e-001,7.176428817984416e-001},{4.935153779849062e+000,
        -1.419312432471077e+000,6.088567223360871e-001,7.191546114588450e-001},
        {4.732841752485663e+000,-1.380816146638106e+000,6.018603908156497e-001,
        7.206657197813855e-001},{4.539543342955549e+000,-1.343490383791056e+000,
        5.949773631865258e-001,7.221762249755580e-001},{4.354826796805688e+000,
        -1.307295347831567e+000,5.882054626053450e-001,7.236861454257876e-001},
        {4.178282674581729e+000,-1.272192725811762e+000,5.815425625070392e-001,
        7.251954996964002e-001},{4.009521634668678e+000,-1.238145618364219e+000,
        5.749865853101563e-001,7.267043065367352e-001},{3.848175025968628e+000,
        -1.205118501925514e+000,5.685355012244482e-001,7.282125848864084e-001},
        {3.693892899386763e+000,-1.173077159790875e+000,5.621873269947402e-001,
        7.297203538807227e-001},{3.546341740891187e+000,-1.141988619090690e+000,
        5.559401247257912e-001,7.312276328562487e-001},{3.405206929436500e+000,
        -1.111821138378985e+000,5.497920008403084e-001,7.327344413565636e-001},
        {3.270187120186245e+000,-1.082544103575234e+000,5.437411048209569e-001,
        7.342407991381688e-001},{3.140998924757143e+000,-1.054128048587643e+000,
        5.377856283364672e-001,7.357467261765852e-001},{3.017369744506951e+000,
        -1.026544533480591e+000,5.319238039757309e-001,7.372522426726416e-001},
        {2.899044153352361e+000,-9.997661913653924e-001,5.261539045099664e-001,
        7.387573690589510e-001},{2.785775964091354e+000,-9.737665947672607e-001,
        5.204742416212094e-001,7.402621260065991e-001},{2.677333888058895e+000,
        -9.485203014378125e-001,5.148831652356617e-001,7.417665344320410e-001},
        {2.573496060829918e+000,-9.240027508565234e-001,5.093790623710802e-001,
        7.432706155042201e-001},{2.474052809499689e+000,-9.001902757330506e-001,
        5.039603564117439e-001,7.447743906519216e-001},{2.378804120443931e+000,
        -8.770600388487887e-001,4.986255061308111e-001,7.462778815713633e-001},
        {2.287559402475405e+000,-8.545900081840703e-001,4.933730048957201e-001,
        7.477811102340413e-001},{2.200138517682294e+000,-8.327589429822758e-001,
        4.882013798861766e-001,7.492840988948364e-001},{2.116368371443866e+000,
        -8.115463254255343e-001,4.831091911879579e-001,7.507868701004001e-001},
        {2.036086012815135e+000,-7.909323809234898e-001,4.780950311870275e-001,
        7.522894466978191e-001},{1.959134838570954e+000,-7.708980017762587e-001,
        4.731575236501228e-001,7.537918518435930e-001},{1.885366456932190e+000,
        -7.514247566493858e-001,4.682953231458762e-001,7.552941090129114e-001},
        {1.814639954656823e+000,-7.324948551533699e-001,4.635071142767641e-001,
        7.567962420092698e-001},{1.746820019907857e+000,-7.140911050589521e-001,
        4.587916109601810e-001,7.582982749744263e-001},{1.681779029320273e+000,
        -6.961969236875881e-001,4.541475558846255e-001,7.598002323987182e-001},
        {1.619394453544771e+000,-6.787962807595844e-001,4.495737197402506e-001,
        7.613021391317515e-001},{1.559549975604258e+000,-6.618737004185191e-001,
        4.450689006991003e-001,7.628040203934934e-001},{1.502134836632424e+000,
        -6.454142328694089e-001,4.406319237709913e-001,7.643059017857750e-001},
        {1.447043171573348e+000,-6.294034296210121e-001,4.362616402141224e-001,
        7.658078093042219e-001},{1.394174498370593e+000,-6.138273354867607e-001,
        4.319569270116660e-001,7.673097693506550e-001},{1.343432420370009e+000,
        -5.986724547846682e-001,4.277166862748373e-001,7.688118087459539e-001},
        {1.294725732732976e+000,-5.839257544439922e-001,4.235398447916798e-001,
        7.703139547434321e-001},{1.247966881438976e+000,-5.695746253865943e-001,
        4.194253534307958e-001,7.718162350427407e-001},{1.203072849158344e+000,
        -5.556068845041990e-001,4.153721867289367e-001,7.733186778043174e-001},
        {1.159963947754655e+000,-5.420107427847227e-001,4.113793423526519e-001,
        7.748213116644277e-001},{1.118564587734494e+000,-5.287748063807098e-001,
        4.074458407063869e-001,7.763241657508161e-001},{1.078802507769043e+000,
        -5.158880509921915e-001,4.035707244384177e-001,7.778272696990009e-001},
        {1.040608654311761e+000,-5.033398098623492e-001,3.997530580345837e-001,
        7.793306536692566e-001},{1.003917267676832e+000,-4.911197646737863e-001,
        3.959919274268831e-001,7.808343483642983e-001},{9.686655604482745e-001,
        -4.792179290087323e-001,3.922864395821423e-001,7.823383850477332e-001},
        {9.347935275729121e-001,-4.676246357897185e-001,3.886357221304772e-001,
        7.838427955633055e-001},{9.022439775911922e-001,-4.563305281577600e-001,
        3.850389230167903e-001,7.853476123549728e-001},{8.709622750416257e-001,
        -4.453265454505745e-001,3.814952101441460e-001,7.868528684878805e-001},
        {8.408962141922037e-001,-4.346039124857111e-001,3.780037710512866e-001,
        7.883585976702583e-001},{8.119960630426542e-001,-4.241541312368614e-001,
        3.745638126070998e-001,7.898648342763168e-001},{7.842141445487288e-001,
        -4.139689655197202e-001,3.711745606968078e-001,7.913716133701791e-001},
        {7.575051094416114e-001,-4.040404377634261e-001,3.678352599695338e-001,
        7.928789707309243e-001},{7.318255766054801e-001,-3.943608140101956e-001,
        3.645451735466376e-001,7.943869428787894e-001},{7.071339973871145e-001,
        -3.849225950336849e-001,3.613035827844493e-001,7.958955671026191e-001},
        {6.833909241888801e-001,-3.757185132023703e-001,3.581097870611176e-001,
        7.974048814886176e-001},{6.605584479088350e-001,-3.667415147704448e-001,
        3.549631035218736e-001,7.989149249504874e-001},{6.386004414563145e-001,
        -3.579847585634845e-001,3.518628669202130e-001,8.004257372610424e-001},
        {6.174824768960409e-001,-3.494416066345683e-001,3.488084294219762e-001,
        8.019373590853794e-001},{5.971715000221117e-001,-3.411056120245748e-001,
        3.457991604274862e-001,8.034498320157049e-001},{5.776360443240841e-001,
        -3.329705170046958e-001,3.428344464558457e-001,8.049631986079188e-001},
        {5.588460502815952e-001,-3.250302427624316e-001,3.399136909984816e-001,
        8.064775024200631e-001},{5.407727810343643e-001,-3.172788818833830e-001,
        3.370363144128132e-001,8.079927880527609e-001},{5.233887544226954e-001,
        -3.097106915065160e-001,3.342017538376066e-001,8.095091011917578e-001},
        {5.066677875548836e-001,-3.023200884505798e-001,3.314094631326712e-001,
        8.110264886527152e-001},{4.905848756317561e-001,-2.951016406887826e-001,
        3.286589128198704e-001,8.125449984283928e-001},{4.751160769385945e-001,
        -2.880500600179367e-001,3.259495900597049e-001,8.140646797383735e-001},
        {4.602386051186608e-001,-2.811601986672496e-001,3.232809986635589e-001,
        8.155855830815082e-001},{4.459307014087881e-001,-2.744270408946369e-001,
        3.206526591012421e-001,8.171077602912539e-001},{4.321715938551395e-001,
        -2.678456971393555e-001,3.180641085520652e-001,8.186312645941041e-001},
        {4.189415011741373e-001,-2.614113988398635e-001,3.155149009832065e-001,
        8.201561506713140e-001},{4.062214913409450e-001,-2.551194905970136e-001,
        3.130046072430969e-001,8.216824747241585e-001},{3.939936339725952e-001,
        -2.489654281954533e-001,3.105328152103881e-001,8.232102945429569e-001},
        {3.822408013278497e-001,-2.429447687817379e-001,3.080991299323931e-001,
        8.247396695801337e-001},{3.709466702963435e-001,-2.370531663389923e-001,
        3.057031738328623e-001,8.262706610276031e-001},{3.600957583030854e-001,
        -2.312863674323255e-001,3.033445869493500e-001,8.278033318987772e-001},
        {3.496733671825422e-001,-2.256402043990980e-001,3.010230271918857e-001,
        8.293377471155482e-001},{3.396655214813151e-001,-2.201105889016499e-001,
        2.987381706501068e-001,8.308739736005932e-001},{3.300589897857049e-001,
        -2.146935073828444e-001,2.964897119537793e-001,8.324120803754020e-001},
        {3.208412578073947e-001,-2.093850149119442e-001,2.942773646665175e-001,
        8.339521386644649e-001},{3.120005459911270e-001,-2.041812297929947e-001,
        2.921008617347819e-001,8.354942220060717e-001},{3.035256503638822e-001,
        -1.990783246823497e-001,2.899599559785713e-001,8.370384063702406e-001},
        {2.954061908395492e-001,-1.940725263380565e-001,2.878544206816350e-001,
        8.385847702843330e-001},{2.876323002050054e-001,-1.891601020496199e-001,
        2.857840501721114e-001,8.401333949669464e-001},{2.801948834019232e-001,
        -1.843373598135978e-001,2.837486605559522e-001,8.416843644707666e-001},
        {2.730854228772116e-001,-1.796006366227388e-001,2.817480904497046e-001,
        8.432377658350839e-001},{2.662960891242228e-001,-1.749462945024303e-001,
        2.797822018500715e-001,8.447936892487767e-001},{2.598196879188098e-001,
        -1.703707115781422e-001,2.778508810576263e-001,8.463522282246335e-001},
        {2.536496867746277e-001,-1.658702750316326e-001,2.759540397160137e-001,
        8.479134797859673e-001},{2.477802128823877e-001,-1.614413725921469e-001,
        2.740916159487959e-001,8.494775446665763e-001},{2.421839309050305e-001,
        -1.570799986898184e-001,2.722635741293099e-001,8.510445275252113e-001},
        {2.368786468237419e-001,-1.527827697979022e-001,2.704699099458725e-001,
        8.526145371758300e-001},{2.318809810687322e-001,-1.485463921802132e-001,
        2.687106490539978e-001,8.541876868350633e-001},{2.272033004004703e-001,
        -1.443013471384416e-001,2.669578014924510e-001,8.557900348291792e-001},
        {2.228720273934477e-001,-1.401715084130047e-001,2.652653339510075e-001,
        8.573725333555661e-001},{2.188737474564099e-001,-1.361583230500321e-001,
        2.636349618021100e-001,8.589321368338225e-001},{2.151938108428024e-001,
        -1.322546419048931e-001,2.620646877232015e-001,8.604692374815954e-001},
        {2.118188268906598e-001,-1.284537034390536e-001,2.605526072877775e-001,
        8.619842196559904e-001},{2.087366333201549e-001,-1.247491073246053e-001,
        2.590969039651040e-001,8.634774600465008e-001},{2.059361625352860e-001,
        -1.211347872081701e-001,2.576958444119279e-001,8.649493278615940e-001},
        {2.034074149378808e-001,-1.176049878458108e-001,2.563477740702578e-001,
        8.664001850093022e-001},{2.011413298783185e-001,-1.141542415902366e-001,
        2.550511130233508e-001,8.678303862720165e-001},{1.991298125068586e-001,
        -1.107773498429863e-001,2.538043521210758e-001,8.692402794757654e-001},
        {1.973655647896050e-001,-1.074693611653381e-001,2.526060493134096e-001,
        8.706302056542128e-001},{1.958421213759138e-001,-1.042255560507937e-001,
        2.514548262377977e-001,8.720004992075637e-001},{1.945537958776381e-001,
        -1.010414298773090e-001,2.503493649859753e-001,8.733514880566440e-001},
        {1.934955970749939e-001,-9.791267666147004e-002,2.492884050660330e-001,
        8.746834937923431e-001},{1.926632043856072e-001,-9.483517540616522e-002,
        2.482707405530666e-001,8.759968318205693e-001},{1.920530013650005e-001,
        -9.180497812140505e-002,2.472952174051379e-001,8.772918115029676e-001},
        {1.916619394589189e-001,-8.881829486636758e-002,2.463607309170215e-001,
        8.785687362935541e-001},{1.914875823983919e-001,-8.587148427990259e-002,
        2.454662233501901e-001,8.798279038713941e-001},{1.915280993815957e-001,
        -8.296104268947961e-002,2.446106816792321e-001,8.810696062695512e-001},
        {1.917821599981230e-001,-8.008359226919655e-002,2.437931354640896e-001,
        8.822941300004101e-001},{1.922489958278585e-001,-7.723587356759790e-002,
        2.430126548622808e-001,8.835017561775065e-001},{1.929283914742223e-001,
        -7.441473634943605e-002,2.422683487355767e-001,8.846927606340636e-001},
        {1.938205682251700e-001,-7.161712923792232e-002,2.415593628605291e-001,
        8.858674140382891e-001},{1.949263025484482e-001,-6.884009487087414e-002,
        2.408848782619473e-001,8.870259820056076e-001},{1.962468368843349e-001,
        -6.608076049330205e-002,2.402441096090453e-001,8.881687252078944e-001},
        {1.977839043493731e-001,-6.333633184166496e-002,2.396363037192911e-001,
        8.892958994798933e-001},{1.995397017281764e-001,-6.060408601603758e-002,
        2.390607381333165e-001,8.904077559228296e-001},{2.015168884164766e-001,
        -5.788136574944486e-002,2.385167197765595e-001,8.915045410054051e-001},
        {2.037186493235506e-001,-5.516557435579349e-002,2.380035836869622e-001,
        8.925864966622013e-001},{2.061485578928091e-001,-5.245416769018642e-002,
        2.375206918021687e-001,8.936538603896150e-001},{2.088107303179244e-001,
        -4.974465205292488e-002,2.370674318361935e-001,8.947068653393980e-001},
        {2.117096846999846e-001,-4.703457622106781e-002,2.366432161836148e-001,
        8.957457404098935e-001},{2.148505149907584e-001,-4.432153007089228e-002,
        2.362474809142938e-001,8.967707103350046e-001},{2.182386749730879e-001,
        -4.160313569771003e-002,2.358796847823731e-001,8.977819957710477e-001},
        {2.218802015852066e-001,-3.887704757707568e-002,2.355393083306903e-001,
        8.987798133814337e-001},{2.257816115052553e-001,-3.614094572355721e-002,
        2.352258530014959e-001,8.997643759193978e-001},{2.299498407093479e-001,
        -3.339253121132149e-002,2.349388403129885e-001,9.007358923086878e-001},
        {2.343924725771772e-001,-3.062952596424444e-002,2.346778110852589e-001,
        9.016945677223748e-001},{2.391175338601718e-001,-2.784966495255222e-002,
        2.344423246756947e-001,9.026406036597976e-001},{2.441335689704040e-001,
        -2.505069440041885e-002,2.342319582824293e-001,9.035741980217020e-001},
        {2.494466737102023e-001,-2.223033411770663e-002,2.340463061820594e-001,
        9.044955451836203e-001},{2.550861106065699e-001,-1.938660447233538e-002,
        2.338849799791759e-001,9.054048360675704e-001},{2.610094533269595e-001,
        -1.651647391820168e-002,2.337476039501077e-001,9.063022582120580e-001},
        {2.672873914645409e-001,-1.361879651128243e-002,2.336338247023430e-001,
        9.071879958403298e-001},{2.738106591896983e-001,-1.068971575200308e-002,
        2.335432928777375e-001,9.080622299280794e-001},{2.804606750369759e-001,
        -7.726659110718780e-003,2.334756804033219e-001,9.089251382668985e-001},
        {2.904290562079965e-001,-4.764098488806071e-003,2.334307556704802e-001,
        9.097768955293063e-001},{2.933750710558286e-001,-1.656982949129257e-003,
        2.334078134409505e-001,9.106176733264468e-001},{3.050168191487940e-001,
        1.350589639466686e-003,2.334074430077944e-001,9.114476402584719e-001},{
        3.126013688318755e-001,4.484047200702626e-003,2.334283798227455e-001,
        9.122669621103098e-001},{3.215543582266510e-001,7.641858728022285e-003,
        2.334709180402272e-001,9.130758015729857e-001},{3.309493854379925e-001,
        1.084606285102256e-002,2.335346788693272e-001,9.138743186727137e-001},{
        3.408036404253549e-001,1.409903898921036e-002,2.336194205790645e-001,
        9.146626706292474e-001},{3.511350954219710e-001,1.740319488595970e-002,
        2.337249122941095e-001,9.154410119512660e-001},{3.619625548115306e-001,
        2.076096799975756e-002,2.338509336517329e-001,9.162094944895526e-001},{
        3.733053046371622e-001,2.417483133717817e-002,2.339972744575906e-001,
        9.169682674889458e-001},{3.851835101117528e-001,2.764728816995566e-002,
        2.341637343834541e-001,9.177174776391662e-001},{3.976175439013757e-001,
        3.118088055196995e-002,2.343501226196413e-001,9.184572691244551e-001},{
        4.109386287917567e-001,3.477533291071943e-002,2.345562634056419e-001,
        9.191877836721225e-001},{4.252825118499027e-001,3.843116371032156e-002,
        2.347819891940276e-001,9.199091605999706e-001},{4.408049129756115e-001,
        4.214792375866371e-002,2.350271518933623e-001,9.206215368626223e-001},{
        4.576846245311496e-001,4.630547834114645e-002,2.353172753172934e-001,
        9.213904696290003e-001},{4.784513590715939e-001,5.060507038628476e-002,
        2.356363599220260e-001,9.221630514821407e-001},{4.920827258189274e-001,
        5.519541297814200e-002,2.359854289691031e-001,9.229393998641423e-001},{
        5.178937679266293e-001,5.981545467360165e-002,2.363668043436880e-001,
        9.237196381740548e-001},{5.391049374883102e-001,6.475414966613934e-002,
        2.367809391058319e-001,9.245038963244220e-001},{5.634449341225508e-001,
        6.989029053033601e-002,2.372302039790004e-001,9.252923108029000e-001},{
        5.897153325658239e-001,7.526860985601419e-002,2.377162421944522e-001,
        9.260850256994325e-001},{6.181112209433559e-001,8.090819466323959e-002,
        2.382410055571628e-001,9.268821929717398e-001},{6.488525677875635e-001,
        8.683004454631531e-002,2.388066021212003e-001,9.276839731306028e-001},{
        6.821878414375597e-001,9.305731296729698e-002,2.394153123100448e-001,
        9.284905359221661e-001},{7.183985201026177e-001,9.961558066647835e-002,
        2.400696071150384e-001,9.293020610812173e-001},{7.578044037403948e-001,
        1.065331716202092e-001,2.407721686690386e-001,9.301187391645777e-001},{
        8.007698251219902e-001,1.138415194678852e-001,2.415259135709149e-001,
        9.309407724751908e-001},{8.477112195704598e-001,1.215755901968623e-001,
        2.423340194130125e-001,9.317683760891560e-001},{8.991059063712774e-001,
        1.297743778800449e-001,2.431999550154734e-001,9.326017789999588e-001},{
        9.555029755126038e-001,1.384814779165823e-001,2.441275150268687e-001,
        9.334412253964867e-001},{1.017535937344632e+000,1.477457654552941e-001,
        2.451208595937071e-001,9.342869760943128e-001},{1.085938205408345e+000,
        1.576221875223210e-001,2.461845600471582e-001,9.351393101430466e-001},{
        1.161561582275224e+000,1.681727002303767e-001,2.473236516456673e-001,
        9.359985266367291e-001},{1.245398446129048e+000,1.794673774990541e-001,
        2.485436946915644e-001,9.368649467591372e-001},{1.338608148309784e+000,
        1.915857290298620e-001,2.498508455805677e-001,9.377389161019090e-001},{
        1.442548258110234e+000,2.046182699257000e-001,2.512519396760876e-001,
        9.386208073007041e-001},{1.563550207326141e+000,2.186179243163746e-001,
        2.527547076453380e-001,9.395110230435863e-001},{1.684329410181329e+000,
        2.339579695432694e-001,2.543669871107666e-001,9.404099995167338e-001},{
        1.840290137060555e+000,2.502660355294551e-001,2.561000525033712e-001,
        9.413182103660764e-001},{2.005174237802519e+000,2.682089305034622e-001,
        2.579624203753087e-001,9.422361716947373e-001},{2.195430692141073e+000,
        2.877169741014608e-001,2.599675919987584e-001,9.431644460877734e-001},{
        2.412904324653398e+000,3.090556749171306e-001,2.621289837025392e-001,
        9.441036504515273e-001},{2.662767304254523e+000,3.324773127469931e-001,
        2.644622565363322e-001,9.450544623460853e-001},{2.951438780835094e+000,
        3.582796665096927e-001,2.669853329547631e-001,9.460176287724212e-001},{
        3.286954018925421e+000,3.868162802973410e-001,2.697188268971239e-001,
        9.469939763450140e-001},{3.679465741376691e+000,4.185095197683239e-001,
        2.726865770992523e-001,9.479844234324657e-001},{4.141931236862925e+000,
        4.538673480408977e-001,2.759163138940035e-001,9.489899947466461e-001},{
        4.691069298400168e+000,4.935050283817702e-001,2.794405007063843e-001,
        9.500118390046373e-001},{5.348707073258958e+000,5.381735273260513e-001,
        2.832974063174888e-001,9.510512504832676e-001},{6.143705486256990e+000,
        5.887970106525733e-001,2.875324861260081e-001,9.521096955549476e-001},{
        7.114743725479455e+000,6.465229722160121e-001,2.922001819000289e-001,
        9.531888456688770e-001},{8.321324877449055e+000,7.127119364606617e-001,
        2.973664920699020e-001,9.542906187727378e-001},{9.814008057546337e+000,
        7.895125341007474e-001,3.031108408227720e-001,9.554172319331690e-001},{
        1.173472061857719e+001,8.786331494420789e-001,3.095347921261885e-001,
        9.565712690270144e-001},{1.420449343150175e+001,9.836535262794647e-001,
        3.167598605019126e-001,9.577557700959503e-001},{1.746385659351800e+001,
        1.108209112465122e+000,3.249454080118249e-001,9.589743460224295e-001},{
        2.185981459948901e+001,1.257510034299458e+000,3.342947309034364e-001,
        9.602313398961775e-001},{2.794948473262666e+001,1.438394626077943e+000,
        3.450759860826211e-001,9.615320435137206e-001},{3.665958868667153e+001,
        1.659932031051734e+000,3.576504808355101e-001,9.628830054950714e-001},{
        4.961877309657803e+001,1.933871190036903e+000,3.725190487198159e-001,
        9.642924773126242e-001},{6.984375504183272e+001,2.274822138787811e+000,
        3.903995922147242e-001,9.657710805637312e-001},{1.034774217208668e+002,
        2.696074492740470e+000,4.123731761320471e-001,9.673328436111374e-001},{
        1.581230920983324e+002,3.266020040491545e+000,4.399786317612097e-001,
        9.689968887258295e-001},{2.515136935955693e+002,4.116442075807741e+000,
        4.756363207390761e-001,9.707903327720178e-001},{4.255666011618887e+002,
        5.543864685060169e+000,5.231660521339230e-001,9.727536601397832e-001},{
        7.825530244524709e+002,6.095169952013788e+000,5.741651534308233e-001,
        9.743751414991224e-001},{1.601387467228535e+003,5.526394469524922e+000,
        6.475446574462375e-001,9.761711567563309e-001},{3.517379521473430e+003,
        4.655838112548601e+000,7.599439282112659e-001,9.783035737380645e-001},{
        7.962846678376361e+003,9.518793744286704e+000,9.225514220968945e-001,
        9.807363487766135e-001},{1.824488327643979e+004,2.078256392728106e+001,
        1.131128321260709e+000,9.829773592443036e-001},{4.540306810221719e+004,
        1.488976251891372e+001,1.387654000750968e+000,9.848111708264992e-001},{
        1.145958554994318e+005,-3.053821008062807e+001,1.732038158743400e+000,
        9.864872284392217e-001},{2.714454865411694e+005,-3.766348045575876e+001,
        2.199850765561659e+000,9.882925910565035e-001},{6.114567935601252e+005,
        3.983023186009633e+002,2.891002115453413e+000,9.904976309221367e-001},{
        1.241850100485509e+006,7.637348298339904e+002,3.505557353710815e+000,
        9.917024335783234e-001},{2.901091663911621e+006,2.287151249154257e+002,
        3.996356201581334e+000,9.922645331286384e-001},{8.629777329944847e+006,
        -1.301634709362246e+003,5.052771746981934e+000,9.932357014649955e-001},
        {2.912091392721209e+007,-6.531467250818030e+003,6.921517889213511e+000,
        9.942966215510268e-001},{9.412813865309173e+007,-5.286393541194419e+003,
        8.979056034617720e+000,9.957010756859428e-001},{2.036070618782550e+008,
        1.028469165095266e+004,1.130107943827922e+001,9.966743300764792e-001},{
        1.674526211291653e+012,-7.945254783461587e+007,9.414997405411956e+002,
        9.973127499065179e-001}};
    constant Real[Ninterval, 4] svcoef={{-1.167161242280822e+010,
        1.878696788040639e+006,-3.414627808635271e+002,1.257192752866231e+000},
        {-1.035354888344887e+010,1.770211704883063e+006,-3.314921184815092e+002,
        1.256278981521677e+000},{-9.010871046855169e+009,1.675234821593873e+006,
        -3.233186928839511e+002,1.255515159251215e+000},{-7.670087323896805e+009,
        1.503104694936961e+006,-3.056454829469166e+002,1.253788981093666e+000},
        {-6.528525227742667e+009,1.348617412883818e+006,-2.889263517656612e+002,
        1.252068489141656e+000},{-5.556819130397623e+009,1.209977756821469e+006,
        -2.731107664395464e+002,1.250353786912934e+000},{-4.729570822211771e+009,
        1.085555117462545e+006,-2.581498340050509e+002,1.248644873308041e+000},
        {-4.025383319196040e+009,9.738978630494837e+005,-2.439979849174128e+002,
        1.246941821048949e+000},{-3.425938223747980e+009,8.736974103745150e+005,
        -2.306117633794419e+002,1.245244670239726e+000},{-2.915696321437560e+009,
        7.837826255347068e+005,-2.179503198145804e+002,1.243553497923841e+000},
        {-2.481383208327286e+009,7.030988445381357e+005,-2.059747132443750e+002,
        1.241868349123961e+000},{-2.111686390084153e+009,6.307004543248878e+005,
        -1.946483220668824e+002,1.240189304980033e+000},{-1.797034775339657e+009,
        5.657386555897944e+005,-1.839360670319048e+002,1.238516382333624e+000},
        {-1.529214800743476e+009,5.074499659892993e+005,-1.738049564593241e+002,
        1.236849634718179e+000},{-1.301273763706718e+009,4.551518279503796e+005,
        -1.642239738649408e+002,1.235189150544434e+000},{-1.107273660839951e+009,
        4.082289549017351e+005,-1.551633835517684e+002,1.233534955827648e+000},
        {-9.421731741085697e+008,3.661311815312429e+005,-1.465954002475946e+002,
        1.231887143503433e+000},{-8.023146343545597e+008,3.283866390101237e+005,
        -1.384935880133614e+002,1.230245745364984e+000},{-6.852307594168044e+008,
        2.946092675025202e+005,-1.308334802778386e+002,1.228610827813656e+000},
        {-5.870901801301618e+008,2.644005082934081e+005,-1.235917413237229e+002,
        1.226982459618363e+000},{-5.047068181055782e+008,2.378107583024218e+005,
        -1.168778656810235e+002,1.225392995014713e+000},{-4.351080450261749e+008,
        2.149782115590958e+005,-1.108542675702452e+002,1.223894955882774e+000},
        {-3.754631816409877e+008,1.944610872742684e+005,-1.051729507319718e+002,
        1.222412562340188e+000},{-3.243003876591392e+008,1.760126494519494e+005,
        -9.981271620297964e+001,1.220945658781368e+000},{-2.803704024187839e+008,
        1.594135405147079e+005,-9.475377996554323e+001,1.219494091303989e+000},
        {-2.426161580886689e+008,1.444689114102572e+005,-8.997767687518686e+001,
        1.218057707682420e+000},{-2.101376500670390e+008,1.310052300243061e+005,
        -8.546716076385087e+001,1.216636357341712e+000},{-1.821729409586426e+008,
        1.188682298364962e+005,-8.120612512230242e+001,1.215229891332141e+000},
        {-1.580713395011833e+008,1.079202781593172e+005,-7.717951465716868e+001,
        1.213838162304302e+000},{-1.372810899764895e+008,9.803887891483332e+004,
        -7.337325952167046e+001,1.212461024484717e+000},{-1.193305568497935e+008,
        8.911463290966404e+004,-6.977419934441511e+001,1.211098333651978e+000},
        {-1.038177842631264e+008,8.104994158345387e+004,-6.637002475122108e+001,
        1.209749947113391e+000},{-9.040040036718562e+007,7.375769881825958e+004,
        -6.314921765813308e+001,1.208415723682116e+000},{-7.878443856624676e+007,
        6.715992689454205e+004,-6.010099316854539e+001,1.207095523654803e+000},
        {-6.871974414947894e+007,6.118702847513706e+004,-5.721525561719147e+001,
        1.205789208789701e+000},{-5.999133752771001e+007,5.577663404305128e+004,
        -5.448254540510249e+001,1.204496642285233e+000},{-5.241543869142986e+007,
        5.087295055300280e+004,-5.189400007463385e+001,1.203217688759031e+000},
        {-4.583415581126005e+007,4.642596046130997e+004,-4.944131149429202e+001,
        1.201952214227427e+000},{-4.011228675603470e+007,4.239086070618492e+004,
        -4.711669043018321e+001,1.200700086085366e+000},{-3.513311357163611e+007,
        3.872739999770453e+004,-4.491282933447061e+001,1.199461173086765e+000},
        {-3.079702502223688e+007,3.539954399663577e+004,-4.282287446858340e+001,
        1.198235345325283e+000},{-2.701759418906320e+007,3.237483582224888e+004,
        -4.084039003202591e+001,1.197022474215511e+000},{-2.372076973145581e+007,
        2.962417023636633e+004,-3.895933616247480e+001,1.195822432474547e+000},
        {-2.084264185672811e+007,2.712136254406240e+004,-3.717403962809318e+001,
        1.194635094103993e+000},{-1.832795661554030e+007,2.484284118361123e+004,
        -3.547917043105402e+001,1.193460334372309e+000},{-1.612910315484070e+007,
        2.276740549221483e+004,-3.386972055424017e+001,1.192298029797559e+000},
        {-1.420493817465342e+007,2.087595838808486e+004,-3.234098209159364e+001,
        1.191148058130523e+000},{-1.251978525903208e+007,1.915127628793518e+004,
        -3.088852777905769e+001,1.190010298338169e+000},{-1.104283839085355e+007,
        1.757784331955985e+004,-2.950819407825404e+001,1.188884630587475e+000},
        {-9.747385274891593e+006,1.614165584070271e+004,-2.819606332104048e+001,
        1.187770936229595e+000},{-8.610258724756623e+006,1.483007183595590e+004,
        -2.694844841479200e+001,1.186669097784365e+000},{-7.611347860356514e+006,
        1.363167257285838e+004,-2.576187830531837e+001,1.185578998925132e+000},
        {-6.733210449194347e+006,1.253614352179986e+004,-2.463308451072768e+001,
        1.184500524463906e+000},{-5.960664814163764e+006,1.153415408137276e+004,
        -2.355898800825970e+001,1.183433560336828e+000},{-5.280521597699627e+006,
        1.061726682066825e+004,-2.253668783797127e+001,1.182377993589938e+000},
        {-4.681293638655025e+006,9.777843148067454e+003,-2.156344973986173e+001,
        1.181333712365246e+000},{-4.152968837995382e+006,9.008964808911329e+003,
        -2.063669596087836e+001,1.180300605887091e+000},{-3.686828565114908e+006,
        8.304365766483923e+003,-1.975399574397403e+001,1.179278564448786e+000},
        {-3.275266327776558e+006,7.658365108421354e+003,-1.891305611231615e+001,
        1.178267479399534e+000},{-2.911625574521497e+006,7.065807076565250e+003,
        -1.811171341970251e+001,1.177267243131628e+000},{-2.590114661892789e+006,
        6.522019111917333e+003,-1.734792596167091e+001,1.176277749067896e+000},
        {-2.305650275370526e+006,6.022753490926198e+003,-1.661976587626541e+001,
        1.175298891649416e+000},{-2.053788951097264e+006,5.564153643271859e+003,
        -1.592541287535999e+001,1.174330566323474e+000},{-1.830650417503742e+006,
        5.142717130166380e+003,-1.526314768679637e+001,1.173372669531767e+000},
        {-1.632819252290972e+006,4.755254885285894e+003,-1.463134563215786e+001,
        1.172425098698841e+000},{-1.457310558157280e+006,4.398869159670537e+003,
        -1.402847159348952e+001,1.171487752220765e+000},{-1.301502456237975e+006,
        4.070921570400577e+003,-1.345307431038991e+001,1.170560529454023e+000},
        {-1.163093581080859e+006,3.769009894238661e+003,-1.290378157209061e+001,
        1.169643330704624e+000},{-1.040059054359292e+006,3.490944949502028e+003,
        -1.237929552902521e+001,1.168736057217427e+000},{-9.306220845951777e+005,
        3.234732704043220e+003,-1.187838848926460e+001,1.167838611165672e+000},
        {-8.332175097131218e+005,2.998554122300491e+003,-1.139989865622131e+001,
        1.166950895640710e+000},{-7.464663784985374e+005,2.780749557180561e+003,
        -1.094272640598105e+001,1.166072814641923e+000},{-6.691556891366435e+005,
        2.579804982448421e+003,-1.050583075721938e+001,1.165204273066841e+000},
        {-6.002151747908264e+005,2.394337509561513e+003,-1.008822589061445e+001,
        1.164345176701438e+000},{-5.387000166680566e+005,2.223083665065604e+003,
        -9.688978048092071e+000,1.163495432210602e+000},{-4.837771715710186e+005,
        2.064889150637393e+003,-9.307202614248977e+000,1.162654947128783e+000},
        {-4.347104808441157e+005,1.918698359847450e+003,-8.942061260376542e+000,
        1.161823629850803e+000},{-3.908482209910512e+005,1.783545349089750e+003,
        -8.592759344255985e+000,1.161001389622835e+000},{-3.516161249361212e+005,
        1.658547033549894e+003,-8.258543553706538e+000,1.160188136533529e+000},
        {-3.165035478016587e+005,1.542893819027835e+003,-7.938699394039895e+000,
        1.159383781505299e+000},{-2.850598559817247e+005,1.435844989118608e+003,
        -7.632549251081720e+000,1.158588236285744e+000},{-2.568853836992341e+005,
        1.336721560377161e+003,-7.339450190895453e+000,1.157801413439231e+000},
        {-2.316252113167582e+005,1.244900875868593e+003,-7.058792075603022e+000,
        1.157023226338597e+000},{-2.089652497780896e+005,1.159812303640403e+003,
        -6.789995822552769e+000,1.156253589156990e+000},{-1.886260028704987e+005,
        1.080931941447458e+003,-6.532511605482741e+000,1.155492416859840e+000},
        {-1.703595756576603e+005,1.007779146610457e+003,-6.285817340840077e+000,
        1.154739625196958e+000},{-1.539455303444279e+005,9.399125006097200e+002,
        -6.049417130211369e+000,1.153995130694738e+000},{-1.391878353597992e+005,
        8.769265149992824e+002,-5.822839859171091e+000,1.153258850648495e+000},
        {-1.259118679027340e+005,8.184484746241886e+002,-5.605637854535695e+000,
        1.152530703114902e+000},{-1.139626359191102e+005,7.641359827753867e+002,
        -5.397385660782585e+000,1.151810606904539e+000},{-1.032013550357087e+005,
        7.136737153582978e+002,-5.197678765965424e+000,1.151098481574539e+000},
        {-9.350496389204710e+004,6.667719731724156e+002,-5.006132610481427e+000,
        1.150394247421343e+000},{-8.476330492175093e+004,6.231638226625424e+002,
        -4.822381409307250e+000,1.149697825473546e+000},{-7.687824464670279e+004,
        5.826035987524953e+002,-4.646077237885241e+000,1.149009137484835e+000},
        {-6.976204933005408e+004,5.448649346498113e+002,-4.476889054980945e+000,
        1.148328105927014e+000},{-6.333647369305392e+004,5.097393221858990e+002,
        -4.314501843141601e+000,1.147654653983123e+000},{-5.753143008675712e+004,
        4.770344420945451e+002,-4.158615740492024e+000,1.146988705540629e+000},
        {-5.228434076819440e+004,4.465730200783362e+002,-4.008945287331126e+000,
        1.146330185184698e+000},{-4.753914508465970e+004,4.181914609969991e+002,
        -3.865218653140307e+000,1.145679018191555e+000},{-4.324567909424259e+004,
        3.917388090779465e+002,-3.727176949977069e+000,1.145035130521896e+000},
        {-3.935897394044224e+004,3.670756753534608e+002,-3.594573558074095e+000,
        1.144398448814387e+000},{-3.583878264355163e+004,3.440733666158342e+002,
        -3.467173508311998e+000,1.143768900379221e+000},{-3.264892946834709e+004,
        3.226129150306674e+002,-3.344752869211387e+000,1.143146413191748e+000},
        {-2.975703079636661e+004,3.025844320516610e+002,-3.227098213411754e+000,
        1.142530915886152e+000},{-2.713396553903700e+004,2.838862715090525e+002,
        -3.114006060655961e+000,1.141922337749209e+000},{-2.475361222892791e+004,
        2.664244520011594e+002,-3.005282394893281e+000,1.141320608714076e+000},
        {-2.259246929329500e+004,2.501119931930805e+002,-2.900742176144558e+000,
        1.140725659354155e+000},{-2.062942089795645e+004,2.348684065079063e+002,
        -2.800208902194028e+000,1.140137420877001e+000},{-1.884547713413705e+004,
        2.206191719071575e+002,-2.703514177914426e+000,1.139555825118279e+000},
        {-1.722353739702725e+004,2.072952590638357e+002,-2.610497311259647e+000,
        1.138980804535772e+000},{-1.574820565669981e+004,1.948327142632579e+002,
        -2.521004936730899e+000,1.138412292203431e+000},{-1.440561272630618e+004,
        1.831722652704424e+002,-2.434890653346931e+000,1.137850221805471e+000},
        {-1.318326353872169e+004,1.722589632456998e+002,-2.352014682990452e+000,
        1.137294527630510e+000},{-1.206988185328727e+004,1.620418365675164e+002,
        -2.272243543846235e+000,1.136745144565746e+000},{-1.105529962362607e+004,
        1.524736029253813e+002,-2.195449748531088e+000,1.136202008091175e+000},
        {-1.013034181716861e+004,1.435103830129309e+002,-2.121511510792387e+000,
        1.135665054273839e+000},{-9.286710899115280e+003,1.351114286113316e+002,
        -2.050312467770768e+000,1.135134219762123e+000},{-8.516925185585011e+003,
        1.272389163739304e+002,-1.981741426500199e+000,1.134609441780069e+000},
        {-7.814215167392292e+003,1.198576991982375e+002,-1.915692106619513e+000,
        1.134090658121731e+000},{-7.172456309463685e+003,1.129351140608649e+002,
        -1.852062910163217e+000,1.133577807145568e+000},{-6.586111850428207e+003,
        1.064408049999422e+002,-1.790756700400648e+000,1.133070827768850e+000},
        {-6.050171835345558e+003,1.003465460629108e+002,-1.731680587420741e+000,
        1.132569659462107e+000},{-5.560092621539761e+003,9.462607475690936e+001,
        -1.674745725978995e+000,1.132074242243597e+000},{-5.111765690517253e+003,
        8.925496645655235e+001,-1.619867130786789e+000,1.131584516673807e+000},
        {-4.701461004393561e+003,8.421047987386929e+001,-1.566963488558861e+000,
        1.131100423849972e+000},{-4.325801937265625e+003,7.947145063101340e+001,
        -1.515956992240450e+000,1.130621905400621e+000},{-3.981719970706350e+003,
        7.501816080096197e+001,-1.466773172300048e+000,1.130148903480148e+000},
        {-3.666433998378832e+003,7.083224791831155e+001,-1.419340747082342e+000,
        1.129681360763410e+000},{-3.377417860032481e+003,6.689659881427446e+001,
        -1.373591471646139e+000,1.129219220440331e+000},{-3.112376370352019e+003,
        6.319526122840436e+001,-1.329459999019620e+000,1.128762426210546e+000},
        {-2.869224586596547e+003,5.971336256002279e+001,-1.286883747719661e+000,
        1.128310922278051e+000},{-2.646066878698053e+003,5.643703113312434e+001,
        -1.245802774455418e+000,1.127864653345879e+000},{-2.441179052490817e+003,
        5.335332525583549e+001,-1.206159654087104e+000,1.127423564610798e+000},
        {-2.252992087969359e+003,5.045016740473830e+001,-1.167899365297260e+000,
        1.126987601758015e+000},{-2.080079180685374e+003,4.771628543389871e+001,
        -1.130969182338600e+000,1.126556710955913e+000},{-1.921138426792311e+003,
        4.514114975040469e+001,-1.095318569370784e+000,1.126130838850798e+000},
        {-1.774986715083261e+003,4.271493085367734e+001,-1.060899085833134e+000,
        1.125709932561658e+000},{-1.640543981075735e+003,4.042844155788508e+001,
        -1.027664288390328e+000,1.125293939674950e+000},{-1.516825450176648e+003,
        3.827309661545938e+001,-9.955696444190738e-001,1.124882808239393e+000},
        {-1.402934644797308e+003,3.624087344333366e+001,-9.645724472776511e-001,
        1.124476486760781e+000},{-1.298051190829407e+003,3.432426598985062e+001,
        -9.346317324287821e-001,1.124074924196815e+000},{-1.201427843555840e+003,
        3.251625738258812e+001,-9.057082044918685e-001,1.123678069951939e+000},
        {-1.112382332639507e+003,3.081028253305661e+001,-8.777641610741774e-001,
        1.123285873872205e+000},{-1.030289990482704e+003,2.920019517275006e+001,
        -8.507634226388910e-001,1.122898286240140e+000},{-9.545814037954651e+002,
        2.768024521664869e+001,-8.246712685981502e-001,1.122515257769640e+000},
        {-8.847352179903480e+002,2.624504692644900e+001,-7.994543708220493e-001,
        1.122136739600862e+000},{-8.202750157624278e+002,2.488955712219283e+001,
        -7.750807349200021e-001,1.121762683295148e+000},{-7.607643646864409e+002,
        2.360905024813576e+001,-7.515196415313357e-001,1.121393040829949e+000},
        {-7.058044555340915e+002,2.239909971536202e+001,-7.287415925975793e-001,
        1.121027764593767e+000},{-6.550297990234562e+002,2.125555560066715e+001,
        -7.067182574172425e-001,1.120666807381118e+000},{-6.081054766904550e+002,
        2.017452705997341e+001,-6.854224233914087e-001,1.120310122387493e+000},
        {-5.647251310415043e+002,1.915236652516444e+001,-6.648279487465394e-001,
        1.119957663204345e+000},{-5.246073073245650e+002,1.818565101191613e+001,
        -6.449097155478253e-001,1.119609383814090e+000},{-4.874944380246073e+002,
        1.727117028068883e+001,-6.256435880489638e-001,1.119265238585110e+000},
        {-4.531499690131564e+002,1.640591080457108e+001,-6.070063697166392e-001,
        1.118925182266775e+000},{-4.213569929980251e+002,1.558704419185258e+001,
        -5.889757645456558e-001,1.118589169984485e+000},{-3.919163181558395e+002,
        1.481191450974968e+001,-5.715303387652269e-001,1.118257157234713e+000},
        {-3.646450553664385e+002,1.407802747939932e+001,-5.546494850349343e-001,
        1.117929099880068e+000},{-3.393752203043368e+002,1.338304002382417e+001,
        -5.383133878866853e-001,1.117604954144370e+000},{-3.159524776279070e+002,
        1.272475057653111e+001,-5.225029907903754e-001,1.117284676607735e+000},
        {-2.942348741380071e+002,1.210108978046953e+001,-5.071999645835167e-001,
        1.116968224201675e+000},{-2.740919863183586e+002,1.151011260918757e+001,
        -4.923866777802942e-001,1.116655554204213e+000},{-2.554037558983814e+002,
        1.094998990086499e+001,-4.780461674068305e-001,1.116346624234999e+000},
        {-2.380598009202213e+002,1.041900155948028e+001,-4.641621119578042e-001,
        1.116041392250460e+000},{-2.219584008845426e+002,9.915529102386795e+000,
        -4.507188047600041e-001,1.115739816538935e+000},{-2.070060510539739e+002,
        9.438050073207766e+000,-4.377011294382324e-001,1.115441855715845e+000},
        {-1.931164504418314e+002,8.985131047005984e+000,-4.250945352192337e-001,
        1.115147468718868e+000},{-1.802102310100627e+002,8.555423116398927e+000,
        -4.128850148149304e-001,1.114856614803115e+000},{-1.682141656369273e+002,
        8.147655878814247e+000,-4.010590817995265e-001,1.114569253536338e+000},
        {-1.570607576689517e+002,7.760632934266394e+000,-3.896037500077707e-001,
        1.114285344794130e+000},{-1.466877631682851e+002,7.393227269003488e+000,
        -3.785065133766781e-001,1.114004848755154e+000},{-1.370377407366794e+002,
        7.044376929114794e+000,-3.677553266988977e-001,1.113727725896368e+000},
        {-1.280577195832078e+002,6.713081210827975e+000,-3.573385873661134e-001,
        1.113453936988272e+000},{-1.196987359562168e+002,6.398396598589270e+000,
        -3.472451175418697e-001,1.113183443090161e+000},{-1.119156299903978e+002,
        6.099433714827095e+000,-3.374641476858871e-001,1.112916205545393e+000},
        {-1.046666771658784e+002,5.815353767791457e+000,-3.279853001222415e-001,
        1.112652185976661e+000},{-9.791330185485612e+001,5.545365486858695e+000,
        -3.187985736676302e-001,1.112391346281281e+000},{-9.161985391952307e+001,
        5.288722384756864e+000,-3.098943289750698e-001,1.112133648626488e+000},
        {-8.575340530044392e+001,5.044720137245840e+000,-3.012632743602935e-001,
        1.111879055444745e+000},{-8.028343773174927e+001,4.812693734417916e+000,
        -2.928964520012951e-001,1.111627529429055e+000},{-7.518179322684912e+001,
        4.592015664927063e+000,-2.847852254065942e-001,1.111379033528286e+000},
        {-7.042236090351322e+001,4.382093167137382e+000,-2.769212664359781e-001,
        1.111133530942511e+000},{-6.598097748846658e+001,4.182366469691380e+000,
        -2.692965437566774e-001,1.110890985118343e+000},{-6.183529536801900e+001,
        3.992306887951382e+000,-2.619033113605164e-001,1.110651359744292e+000},
        {-5.796458338458645e+001,3.811414767059530e+000,-2.547340973966659e-001,
        1.110414618746117e+000},{-5.434965024181786e+001,3.639218005629175e+000,
        -2.477816939273175e-001,1.110180726282199e+000},{-5.097272117872193e+001,
        3.475270394432624e+000,-2.410391467313756e-001,1.109949646738908e+000},
        {-4.781728753969381e+001,3.319149959947196e+000,-2.344997455526618e-001,
        1.109721344725985e+000},{-4.486806590326451e+001,3.170457809715834e+000,
        -2.281570150977289e-001,1.109495785071926e+000},{-4.211087764798335e+001,
        3.028816655189627e+000,-2.220047059445052e-001,1.109272932819375e+000},
        {-3.953255089399676e+001,2.893869530061677e+000,-2.160367860342251e-001,
        1.109052753220513e+000},{-3.712088444697060e+001,2.765278795726399e+000,
        -2.102474326561080e-001,1.108835211732461e+000},{-3.486452988379367e+001,
        2.642724832352832e+000,-2.046310243774980e-001,1.108620274012686e+000},
        {-3.275296521562360e+001,2.525905196629955e+000,-1.991821337422336e-001,
        1.108407905914401e+000},{-3.077640612607013e+001,2.414533510698032e+000,
        -1.938955198666938e-001,1.108198073481974e+000},{-2.892576875467384e+001,
        2.308338647291225e+000,-1.887661216370296e-001,1.107990742946342e+000},
        {-2.719260655221808e+001,2.207063812446913e+000,-1.837890509715300e-001,
        1.107785880720415e+000},{-2.556907195833716e+001,2.110465784504171e+000,
        -1.789595864863502e-001,1.107583453394488e+000},{-2.404786193436341e+001,
        2.018314105057650e+000,-1.742731673035715e-001,1.107383427731652e+000},
        {-2.262219267228373e+001,1.930390438141688e+000,-1.697253872422143e-001,
        1.107185770663204e+000},{-2.128574048713125e+001,1.846487791138621e+000,
        -1.653119890350547e-001,1.106990449284039e+000},{-2.003263310347830e+001,
        1.766410019480312e+000,-1.610288590676970e-001,1.106797430848068e+000},
        {-1.885739666271851e+001,1.689971111419810e+000,-1.568720219860535e-001,
        1.106606682763607e+000},{-1.775493736745766e+001,1.616994694704592e+000,
        -1.528376357874969e-001,1.106418172588765e+000},{-1.672051102762514e+001,
        1.547313487069378e+000,-1.489219869625882e-001,1.106231868026832e+000},
        {-1.574969663925623e+001,1.480768795888941e+000,-1.451214858670679e-001,
        1.106047736921662e+000},{-1.483837797396761e+001,1.417210073731107e+000,
        -1.414326622958197e-001,1.105865747253029e+000},{-1.398271440313103e+001,
        1.356494434837758e+000,-1.378521611505417e-001,1.105685867131996e+000},
        {-1.317913026999323e+001,1.298486293574206e+000,-1.343767384064626e-001,
        1.105508064796260e+000},{-1.242428692388935e+001,1.243056912289198e+000,
        -1.310032570641007e-001,1.105332308605480e+000},{-1.171507278035640e+001,
        1.190084079716421e+000,-1.277286834334243e-001,1.105158567036609e+000},
        {-1.104858517393140e+001,1.139451742725932e+000,-1.245500834352500e-001,
        1.104986808679193e+000},{-1.042211251594205e+001,1.091049661445034e+000,
        -1.214646190752247e-001,1.104817002230662e+000},{-9.833127930109274e+000,
        1.044773141735465e+000,-1.184695451190952e-001,1.104649116491605e+000},
        {-9.279269222529393e+000,1.000522693449853e+000,-1.155622057650780e-001,
        1.104483120361017e+000},{-8.758331594475001e+000,9.582037846231296e-001,
        -1.127400315718840e-001,1.104318982831536e+000},{-8.268254945039644e+000,
        9.177265681872020e-001,-1.100005364272110e-001,1.104156672984648e+000},
        {-7.807115847858402e+000,8.790056460390960e-001,-1.073413146627254e-001,
        1.103996159985876e+000},{-7.373115629180458e+000,8.419598198523868e-001,
        -1.047600382440301e-001,1.103837413079935e+000},{-6.964572964185544e+000,
        8.065118808283763e-001,-1.022544541103427e-001,1.103680401585863e+000},
        {-6.579917319551989e+000,7.725884103231008e-001,-9.982238159976631e-002,
        1.103525094892129e+000},{-6.217678026064315e+000,7.401195591188906e-001,
        -9.746170992509612e-002,1.103371462451692e+000},{-5.876481003699939e+000,
        7.090388893243341e-001,-9.517039583419153e-002,1.103219473777050e+000},
        {-5.555039937632146e+000,6.792831791393206e-001,-9.294646126452588e-002,
        1.103069098435232e+000},{-5.252151337727452e+000,6.507922663341224e-001,
        -9.078799114828991e-002,1.102920306042765e+000},{-4.966688624137329e+000,
        6.235088884904741e-001,-8.869313127201903e-002,1.102773066260599e+000},
        {-4.697597099082865e+000,5.973785350753152e-001,-8.666008621865683e-002,
        1.102627348788986e+000},{-4.443889321006219e+000,5.723493085615286e-001,
        -8.468711739120274e-002,1.102483123362320e+000},{-4.204639802405735e+000,
        5.483717858473124e-001,-8.277254109567965e-002,1.102340359743926e+000},
        {-3.978982672410267e+000,5.253989052231248e-001,-8.091472672412192e-002,
        1.102199027720805e+000},{-3.766104946723917e+000,5.033858263846861e-001,
        -7.911209494828850e-002,1.102059097098311e+000},{-3.565246496739293e+000,
        4.822898463553391e-001,-7.736311607075418e-002,1.101920537694806e+000},
        {-3.375693166702355e+000,4.620702628019282e-001,-7.566630831640270e-002,
        1.101783319336218e+000},{-3.196776175731432e+000,4.426882955432985e-001,
        -7.402023630082621e-002,1.101647411850568e+000},{-3.027868289265530e+000,
        4.241069821558813e-001,-7.242350948267441e-002,1.101512785062427e+000},
        {-2.868380956603266e+000,4.062910862438896e-001,-7.087478069160028e-002,
        1.101379408787292e+000},{-2.717761648825286e+000,3.892070113306511e-001,
        -6.937274471398268e-002,1.101247252825911e+000},{-2.575492776805616e+000,
        3.728227297727842e-001,-6.791613694488873e-002,1.101116286958535e+000},
        {-2.441087575492705e+000,3.571076890125111e-001,-6.650373203673411e-002,
        1.100986480939071e+000},{-2.314089601003278e+000,3.420327522372873e-001,
        -6.513434266096387e-002,1.100857804489185e+000},{-2.194069980955622e+000,
        3.275701217828866e-001,-6.380681826769433e-002,1.100730227292302e+000},
        {-2.080626276127093e+000,3.136932793741042e-001,-6.252004391971047e-002,
        1.100603718987523e+000},{-1.973379870081554e+000,3.003769146973490e-001,
        -6.127293913386867e-002,1.100478249163457e+000},{-1.871975877273442e+000,
        2.875968805007567e-001,-6.006445681803470e-002,1.100353787351948e+000},
        {-1.776079761978281e+000,2.753301177489863e-001,-5.889358216906679e-002,
        1.100230303021708e+000},{-1.685377974351372e+000,2.635546224548870e-001,
        -5.775933170287378e-002,1.100107765571849e+000},{-1.599575248513736e+000,
        2.522493798833729e-001,-5.666075222975589e-002,1.099986144325295e+000},
        {-1.518393998763328e+000,2.413943236898121e-001,-5.559691992948053e-002,
        1.099865408522100e+000},{-1.441573373151687e+000,2.309702912325227e-001,
        -5.456693943451667e-002,1.099745527312619e+000},{-1.368867734589837e+000,
        2.209589757712106e-001,-5.356994293865919e-002,1.099626469750589e+000},
        {-1.300046167587472e+000,2.113428906117814e-001,-5.260508936047872e-002,
        1.099508204786056e+000},{-1.234891346467230e+000,2.021053268185756e-001,
        -5.167156351033650e-002,1.099390701258173e+000},{-1.173198705444031e+000,
        1.932303174866275e-001,-5.076857530908452e-002,1.099273927887873e+000},
        {-1.114775448009057e+000,1.847026001930233e-001,-4.989535901624339e-002,
        1.099157853270368e+000},{-1.059440641210220e+000,1.765075920716501e-001,
        -4.905117251505244e-002,1.099042445867529e+000},{-1.007023132646987e+000,
        1.686313435356952e-001,-4.823529656692645e-002,1.098927674000076e+000},
        {-9.573623681232882e-001,1.610605238473588e-001,-4.744703416850136e-002,
        1.098813505839624e+000},{-9.103067285419199e-001,1.537823810200982e-001,
        -4.668570986231731e-002,1.098699909400549e+000},{-8.657134181084795e-001,
        1.467847197346915e-001,-4.595066911465587e-002,1.098586852531666e+000},
        {-8.234480247181129e-001,1.400558758840660e-001,-4.524127770154400e-002,
        1.098474302907740e+000},{-7.833836306847527e-001,1.335846880004829e-001,
        -4.455692110940590e-002,1.098362228020779e+000},{-7.454007724787563e-001,
        1.273604788213846e-001,-4.389700397971351e-002,1.098250595171141e+000},
        {-7.093867102613078e-001,1.213730291305892e-001,-4.326094954621643e-002,
        1.098139371458416e+000},{-6.752351859000392e-001,1.156125586897596e-001,
        -4.264819911326340e-002,1.098028523772093e+000},{-6.428458916404382e-001,
        1.100697043849075e-001,-4.205821154126008e-002,1.097918018781999e+000},
        {-6.121243204484043e-001,1.047355035145177e-001,-4.149046276247566e-002,
        1.097807822928491e+000},{-5.829812077024473e-001,9.960137266115672e-002,
        -4.094444529841480e-002,1.097697902412399e+000},{-5.553323463516771e-001,
        9.465909211282406e-002,-4.041966781121276e-002,1.097588223184712e+000},
        {-5.290983018769104e-001,8.990078930542095e-002,-3.991565466360545e-002,
        1.097478750935989e+000},{-5.042039900286437e-001,8.531892107954550e-002,
        -3.943194549015325e-002,1.097369451085481e+000},{-4.805786848276957e-001,
        8.090626225535701e-002,-3.896809480286970e-002,1.097260288769965e+000},
        {-4.581553822544535e-001,7.665588629356712e-002,-3.852367158513845e-002,
        1.097151228832265e+000},{-4.368710839101541e-001,7.256115807618124e-002,
        -3.809825893429213e-002,1.097042235809448e+000},{-4.166659728273346e-001,
        6.861571312219809e-002,-3.769145367706548e-002,1.096933273920688e+000},
        {-3.974838071080961e-001,6.481345301685161e-002,-3.730286604710058e-002,
        1.096824307054777e+000},{-3.792712543399244e-001,6.114852713700537e-002,
        -3.693211933043777e-002,1.096715298757269e+000},{-3.619780828618504e-001,
        5.761532647168631e-002,-3.657884956265647e-002,1.096606212217247e+000},
        {-3.455566815276582e-001,5.420846842432888e-002,-3.624270520729187e-002,
        1.096497010253680e+000},{-3.299621094861046e-001,5.092278977953486e-002,
        -3.592334687380059e-002,1.096387655301374e+000},{-3.151519038052869e-001,
        4.775333582428087e-002,-3.562044703062108e-002,1.096278109396484e+000},
        {-3.010858568925735e-001,4.469535018894293e-002,-3.533368973476431e-002,
        1.096168334161571e+000},{-2.877260222305396e-001,4.174426753748317e-002,
        -3.506277037838072e-002,1.096058290790178e+000},{-2.750364404645829e-001,
        3.889570313316693e-002,-3.480739543898168e-002,1.095947940030928e+000},
        {-2.629831468064490e-001,3.614544648287300e-002,-3.456728225020585e-002,
        1.095837242171080e+000},{-2.515340199362101e-001,3.348945271938262e-002,
        -3.434215877564163e-002,1.095726157019559e+000},{-2.406586002995336e-001,
        3.092383411927447e-002,-3.413176339382135e-002,1.095614643889409e+000},
        {-2.303281947793209e-001,2.844485621163648e-002,-3.393584471062294e-002,
        1.095502661579664e+000},{-2.205155458031833e-001,2.604892674078030e-002,
        -3.375416134971540e-002,1.095390168356583e+000},{-2.111948886947761e-001,
        2.373259209892301e-002,-3.358648178896612e-002,1.095277121934247e+000},
        {-2.023418904624849e-001,2.149253081769280e-002,-3.343258418644718e-002,
        1.095163479454475e+000},{-1.939334528829362e-001,1.932554604167274e-002,
        -3.329225621812505e-002,1.095049197466017e+000},{-1.859477537233797e-001,
        1.722856136015816e-002,-3.316529493473407e-002,1.094934231903014e+000},
        {-1.783641264153182e-001,1.519861470134868e-002,-3.305150662158253e-002,
        1.094818538062666e+000},{-1.711630023223341e-001,1.323285303316979e-002,
        -3.295070667069486e-002,1.094702070582085e+000},{-1.643259022708403e-001,
        1.132852818633101e-002,-3.286271946617035e-002,1.094584783414292e+000},
        {-1.578352716519453e-001,9.482990227879400e-003,-3.278737827038020e-002,
        1.094466629803301e+000},{-1.516745199919222e-001,7.693684441660621e-003,
        -3.272452513343139e-002,1.094347562258269e+000},{-1.458279673702965e-001,
        5.958146760596810e-003,-3.267401080554415e-002,1.094227532526641e+000},
        {-1.402807290110952e-001,4.273998186553273e-003,-3.263569465492298e-002,
        1.094106491566266e+000},{-1.350187580684957e-001,2.638942378886687e-003,
        -3.260944461005679e-002,1.093984389516410e+000},{-1.300287214613593e-001,
        1.050760098283643e-003,-3.259513709707835e-002,1.093861175667613e+000},
        {-1.252980510881369e-001,-4.926930328170846e-004,-3.259265700107719e-002,
        1.093736798430343e+000},{-1.208148059513224e-001,-1.993491944687124e-003,
        -3.260189762661594e-002,1.093611205302381e+000},{-1.165677227796157e-001,
        -3.453644121755644e-003,-3.262276068118421e-002,1.093484342834852e+000},
        {-1.125461563667504e-001,-4.875093794032855e-003,-3.265515625962785e-002,
        1.093356156596868e+000},{-1.087399966215703e-001,-6.259725904413122e-003,
        -3.269900284369064e-002,1.093226591138662e+000},{-1.051397545722765e-001,
        -7.609367460085121e-003,-3.275422732128897e-002,1.093095589953180e+000},
        {-1.017363957762588e-001,-8.925793255991769e-003,-3.282076499971125e-002,
        1.092963095436013e+000},{-9.852144216178711e-002,-1.021072638057550e-002,
        -3.289855965570027e-002,1.092829048843598e+000},{-9.548686792267386e-002,
        -1.146584294409076e-002,-3.298756357594890e-002,1.092693390249574e+000},
        {-9.262510156753394e-002,-1.269277437900251e-002,-3.308773762526614e-002,
        1.092556058499214e+000},{-8.992900988612509e-002,-1.389311018260152e-002,
        -3.319905132538444e-002,1.092416991161816e+000},{-8.739188464906093e-002,
        -1.506840068008259e-002,-3.332148294678389e-002,1.092276124480920e+000},
        {-8.500738921456238e-002,-1.622016040192641e-002,-3.345501961458242e-002,
        1.092133393322250e+000},{-8.276959948001254e-002,-1.734986965842096e-002,
        -3.359965743818405e-002,1.091988731119247e+000},{-8.067292166344241e-002,
        -1.845897846985461e-002,-3.375540164665517e-002,1.091842069816039e+000},
        {-7.871214577495787e-002,-1.954890787713057e-002,-3.392226675377865e-002,
        1.091693339807705e+000},{-7.688236749343953e-002,-2.062105393477184e-002,
        -3.410027672821032e-002,1.091542469877672e+000},{-7.517903122777866e-002,
        -2.167678909232968e-002,-3.428946519791137e-002,1.091389387132079e+000},
        {-7.359788435365057e-002,-2.271746557145173e-002,-3.448987566368195e-002,
        1.091234016930905e+000},{-7.213496529807099e-002,-2.374441795105308e-002,
        -3.470156173993946e-002,1.091076282815684e+000},{-7.078664709747612e-002,
        -2.475896478998424e-002,-3.492458742242282e-002,1.090916106433582e+000},
        {-6.954953734834717e-002,-2.576241320349298e-002,-3.515902736727997e-002,
        1.090753407457601e+000},{-6.842055334357715e-002,-2.675605967578415e-002,
        -3.540496721654386e-002,1.090588103502687e+000},{-6.739689298150288e-002,
        -2.774119353806004e-002,-3.566250393471657e-002,1.090420110037451e+000},
        {-6.647599481840270e-002,-2.871910028240180e-002,-3.593174618253033e-002,
        1.090249340291247e+000},{-6.565559167808195e-002,-2.969106335868627e-002,
        -3.621281472572473e-002,1.090075705156262e+000},{-6.493365627398073e-002,
        -3.065836816359168e-002,-3.650584287130890e-002,1.089899113084334e+000},
        {-6.430842408472148e-002,-3.162230451330045e-002,-3.681097694769039e-002,
        1.089719469978098e+000},{-6.377841573206161e-002,-3.258416951694268e-002,
        -3.712837682203768e-002,1.089536679076100e+000},{-6.334237459730568e-002,
        -3.354527207676258e-002,-3.745821645677120e-002,1.089350640831460e+000},
        {-6.299931960292200e-002,-3.450693519565747e-002,-3.780068452222145e-002,
        1.089161252783616e+000},{-6.274855690363090e-002,-3.547049958158794e-002,
        -3.815598505196914e-002,1.088968409422674e+000},{-6.258962932227907e-002,
        -3.643732858924495e-002,-3.852433814992687e-002,1.088772002045827e+000},
        {-6.252237552594815e-002,-3.740881109502971e-002,-3.890598076615168e-002,
        1.088571918605265e+000},{-6.254690896242934e-002,-3.838636646260465e-002,
        -3.930116752711852e-002,1.088368043546958e+000},{-6.266364244831302e-002,
        -3.937144869619517e-002,-3.971017164197188e-002,1.088160257639610e+000},
        {-6.287328319117271e-002,-4.036555176939004e-002,-4.013328587796861e-002,
        1.087948437793056e+000},{-6.317686471529196e-002,-4.137021437944927e-002,
        -4.057082362458787e-002,1.087732456865278e+000},{-6.357574767711911e-002,
        -4.238702597030984e-002,-4.102312004137679e-002,1.087512183457172e+000},
        {-6.407164470783205e-002,-4.341763253645162e-002,-4.149053330906206e-002,
        1.087287481694067e+000},{-6.466664636574100e-002,-4.446374318746806e-002,
        -4.197344598438829e-002,1.087058210992956e+000},{-6.536322059434012e-002,
        -4.552713774389385e-002,-4.247226647187895e-002,1.086824225814272e+000},
        {-6.616428759721223e-002,-4.660967333451058e-002,-4.298743063263810e-002,
        1.086585375396910e+000},{-6.707319059880698e-002,-4.771329437422422e-002,
        -4.351940351974055e-002,1.086341503475118e+000},{-6.809379051719827e-002,
        -4.884004012133992e-002,-4.406868129064020e-002,1.086092447975686e+000},
        {-6.923558511367642e-002,-4.999196690374660e-002,-4.463579361515062e-002,
        1.085838040693730e+000},{-7.049988138972356e-002,-5.117136544992598e-002,
        -4.522130521822819e-002,1.085578106945194e+000},{-7.188620542131699e-002,
        -5.238072225909109e-002,-4.582581885465249e-002,1.085312465193973e+000},
        {-7.339274099366680e-002,-5.364413985831130e-002,-4.646040027521749e-002,
        1.085036412823779e+000},{-7.500954773269826e-002,-5.492497782325354e-002,
        -4.710632451399192e-002,1.084758207947855e+000},{-7.673673432833014e-002,
        -5.622189579867198e-002,-4.776212196116022e-002,1.084478467134268e+000},
        {-7.857550333131255e-002,-5.753625488563768e-002,-4.842767881855225e-002,
        1.084197220574224e+000},{-8.052734288370235e-002,-5.886938522147935e-002,
        -4.910289264837146e-002,1.083914499613667e+000},{-8.259407010993335e-002,
        -6.022258916344622e-002,-4.978767167516485e-002,1.083630336649792e+000},
        {-8.477775911831006e-002,-6.159714721340068e-002,-5.048193412171477e-002,
        1.083344765033191e+000},{-8.708080113955191e-002,-6.299432003883736e-002,
        -5.118560761903612e-002,1.083057818975364e+000},{-8.950584765384662e-002,
        -6.441535367085308e-002,-5.189862863655786e-002,1.082769533461264e+000},
        {-9.205583518148568e-002,-6.586148203903283e-002,-5.262094197327757e-002,
        1.082479944166658e+000},{-9.473397681422530e-002,-6.733393026815319e-002,
        -5.335250028030908e-002,1.082189087380031e+000},{-9.754375455528717e-002,
        -6.883391781405844e-002,-5.409326361800470e-002,1.081896999928780e+000},
        {-1.004889430537072e-001,-7.036266070476557e-002,-5.484319904975906e-002,
        1.081603719109501e+000},{-1.035735781946822e-001,-7.192137498268748e-002,
        -5.560228025918928e-002,1.081309282622144e+000},{-1.068019749773503e-001,
        -7.351127863515777e-002,-5.637048720388151e-002,1.081013728507841e+000},
        {-1.101787499902488e-001,-7.513359354342586e-002,-5.714780579175685e-002,
        1.080717095090215e+000},{-1.137088060108335e-001,-7.678954829834185e-002,
        -5.793422757552009e-002,1.080419420919993e+000},{-1.173973070410327e-001,
        -7.848038080842838e-002,-5.872974947289480e-002,1.080120744722770e+000},
        {-1.212497678441141e-001,-8.020733845529093e-002,-5.953437351668309e-002,
        1.079821105349743e+000},{-1.252719700472134e-001,-8.197168217757889e-002,
        -6.034810660246008e-002,1.079520541731282e+000},{-1.294700211546631e-001,
        -8.377468696961547e-002,-6.117096027413883e-002,1.079219092833192e+000},
        {-1.338503700750963e-001,-8.561764374303535e-002,-6.200295051492537e-002,
        1.078916797615539e+000},{-1.384197709577187e-001,-8.750186189508519e-002,
        -6.284409755180367e-002,1.078613694993897e+000},{-1.431853353658080e-001,
        -8.942867014032002e-002,-6.369442568095514e-002,1.078309823802917e+000},
        {-1.481545174104211e-001,-9.139941856567219e-002,-6.455396310036206e-002,
        1.078005222762096e+000},{-1.533351702300495e-001,-9.341547956575609e-002,
        -6.542274175644600e-002,1.077699930443627e+000},{-1.587354634820050e-001,
        -9.547825103285042e-002,-6.630079719598207e-002,1.077393985242266e+000},
        {-1.643640090876028e-001,-9.758915575387375e-002,-6.718816844083814e-002,
        1.077087425347061e+000},{-1.702298127665787e-001,-9.974964419697471e-002,
        -6.808489785802697e-002,1.076780288714918e+000},{-1.763422817767454e-001,
        -1.019611961271160e-001,-6.899103104367133e-002,1.076472613045863e+000},
        {-1.827112750381146e-001,-1.042253212629891e-001,-6.990661672048851e-002,
        1.076164435759950e+000},{-1.893470894923299e-001,-1.065435614567023e-001,
        -7.083170663269980e-002,1.075855793975729e+000},{-1.962605127165320e-001,
        -1.089174914651409e-001,-7.176635545593288e-002,1.075546724490185e+000},
        {-2.034627974654094e-001,-1.113487211960143e-001,-7.271062070759818e-002,
        1.075237263760114e+000},{-2.109657066826481e-001,-1.138388965833026e-001,
        -7.366456266798066e-002,1.074927447884822e+000},{-2.187815400532935e-001,
        -1.163897009783962e-001,-7.462824430457526e-002,1.074617312590122e+000},
        {-2.269231322486189e-001,-1.190028571417117e-001,-7.560173119833084e-002,
        1.074306893213548e+000},{-2.354038806028248e-001,-1.216801282391285e-001,
        -7.658509148189741e-002,1.073996224690738e+000},{-2.442378202565233e-001,
        -1.244233187393023e-001,-7.757839577778078e-002,1.073685341542923e+000},
        {-2.534395283451278e-001,-1.272342778387637e-001,-7.858171713389295e-002,
        1.073374277865470e+000},{-2.630263592208533e-001,-1.301148743711012e-001,
        -7.959513104281542e-002,1.073063067317448e+000},{-2.730051134964604e-001,
        -1.330671775579355e-001,-8.061871489472258e-002,1.072751743112126e+000},
        {-2.834065958432523e-001,-1.360929306822043e-001,-8.165254963474328e-002,
        1.072440338008417e+000},{-2.942333101794055e-001,-1.391944214222225e-001,
        -8.269671635638208e-002,1.072128884302168e+000},{-3.054697678952821e-001,
        -1.423740192943417e-001,-8.375129913345693e-002,1.071817413823248e+000},
        {-3.170567570317931e-001,-1.456342483062608e-001,-8.481638378906832e-002,
        1.071505957923588e+000},{-3.306168617540374e-001,-1.489587293359699e-001,
        -8.589210145617054e-002,1.071194547476514e+000},{-3.409850517367228e-001,
        -1.524212808452965e-001,-8.697834037358347e-002,1.070883212875128e+000},
        {-3.560258309587398e-001,-1.559011033901600e-001,-8.807563275717535e-002,
        1.070571984040678e+000},{-3.693952037952778e-001,-1.595118380297836e-001,
        -8.918357985816929e-002,1.070260890269993e+000},{-3.838111583549971e-001,
        -1.632041776149361e-001,-9.030255764252720e-002,1.069949960599530e+000},
        {-3.988287520315456e-001,-1.669904093902224e-001,-9.143260204604514e-002,
        1.069639223399451e+000},{-4.144733321913969e-001,-1.708730877160433e-001,
        -9.257381383873017e-002,1.069328706585730e+000},{-4.307713785387899e-001,
        -1.748548319916569e-001,-9.372629570383198e-002,1.069018437574774e+000},
        {-4.477502767932388e-001,-1.789383318342014e-001,-9.489015220206132e-002,
        1.068708443282907e+000},{-4.654387110151121e-001,-1.831263430257065e-001,
        -9.606548976685919e-002,1.068398750126322e+000},{-4.838661501934946e-001,
        -1.874216961724761e-001,-9.725241665146278e-002,1.068089384021467e+000},
        {-5.030632737861358e-001,-1.918272907282402e-001,-9.845104292529755e-002,
        1.067780370385895e+000},{-5.235374589086956e-001,-1.963417315274094e-001,
        -9.966148935023214e-002,1.067471734139486e+000},{-5.454914032389386e-001,
        -2.009649239097508e-001,-1.008838772519371e-001,1.067163499706100e+000},
        {-5.691589559314858e-001,-2.056953492856035e-001,-1.021183461925116e-001,
        1.066855691015596e+000},{-5.948100549339186e-001,-2.110255040137948e-001,
        -1.034822753625355e-001,1.066519576356437e+000},{-6.235735359755632e-001,
        -2.165957325688549e-001,-1.048868425206513e-001,1.066177762224400e+000},
        {-6.499081473123812e-001,-2.224933799811154e-001,-1.063338865224673e-001,
        1.065830074548712e+000},{-6.837787055262851e-001,-2.285973841168222e-001,
        -1.078260017738615e-001,1.065476330621825e+000},{-7.167680580575481e-001,
        -2.350681790211194e-001,-1.093649281364889e-001,1.065116338398494e+000},
        {-7.529421660388130e-001,-2.418587175888764e-001,-1.109534924500986e-001,
        1.064749896111096e+000},{-7.918478434536762e-001,-2.490076352352779e-001,
        -1.125942698775614e-001,1.064376791182773e+000},{-8.337579503056568e-001,
        -2.565420848384871e-001,-1.142901236298031e-001,1.063996799632633e+000},
        {-8.789796651735242e-001,-2.644919033636966e-001,-1.160441401751793e-001,
        1.063609685150805e+000},{-9.278592389976171e-001,-2.728899480510872e-001,
        -1.178596518948347e-001,1.063215198130870e+000},{-9.807885348650018e-001,
        -2.817724684979601e-001,-1.197402626436758e-001,1.062813074603089e+000},
        {-1.038211963449425e+000,-2.911795476170365e-001,-1.216898765582236e-001,
        1.062403035055771e+000},{-1.100635026079546e+000,-3.011556050874361e-001,
        -1.237127306959247e-001,1.061984783130254e+000},{-1.168634591893341e+000,
        -3.117499794663595e-001,-1.258134320829727e-001,1.061558004172562e+000},
        {-1.242871047312425e+000,-3.230176068616857e-001,-1.279969998819422e-001,
        1.061122363622202e+000},{-1.324102816333368e+000,-3.350198128649087e-001,
        -1.302689135412735e-001,1.060677505215274e+000},{-1.413204046652451e+000,
        -3.478252360881645e-001,-1.326351679601656e-001,1.060223048975250e+000},
        {-1.511185630627330e+000,-3.615109178443726e-001,-1.351023368667481e-001,
        1.059758588960120e+000},{-1.619221197038109e+000,-3.761635786122374e-001,
        -1.376776459309125e-001,1.059283690729083e+000},{-1.738677889702752e+000,
        -3.918811400429350e-001,-1.403690573333936e-001,1.058797888485215e+000},
        {-1.871154359990751e+000,-4.087745223058986e-001,-1.431853680336985e-001,
        1.058300681842389e+000},{-2.018526589606020e+000,-4.269697926301481e-001,
        -1.461363243040554e-001,1.057791532154715e+000},{-2.185501792184186e+000,
        -4.465841288025065e-001,-1.492328186957302e-001,1.057269858334624e+000},
        {-2.364687153396257e+000,-4.679154024903533e-001,-1.524865743220330e-001,
        1.056735032070606e+000},{-2.576475123351074e+000,-4.908877748574237e-001,
        -1.559120016473587e-001,1.056186372337097e+000},{-2.809603261630487e+000,
        -5.159839044005667e-001,-1.595231052389059e-001,1.055623138920609e+000},
        {-3.075454975098822e+000,-5.433260214541975e-001,-1.633376814220988e-001,
        1.055044525513794e+000},{-3.378476048700296e+000,-5.732358362636583e-001,
        -1.673748772676717e-001,1.054449650639562e+000},{-3.725624075390214e+000,
        -6.060595365408650e-001,-1.716566425727572e-001,1.053837547969356e+000},
        {-4.125513088548122e+000,-6.422048242798819e-001,-1.762080296688844e-001,
        1.053207154504926e+000},{-4.588900079051337e+000,-6.821546123391310e-001,
        -1.810577742248455e-001,1.052557296675667e+000},{-5.129342151488261e+000,
        -7.264844420275155e-001,-1.862390135536310e-001,1.051886673785578e+000},
        {-5.764097830251668e+000,-7.758847747289787e-001,-1.917901826032635e-001,
        1.051193838170567e+000},{-6.515378231730130e+000,-8.311897985680916e-001,
        -1.977561416081993e-001,1.050477171237241e+000},{-7.412109909279641e+000,
        -8.934149834663464e-001,-2.041896093864123e-001,1.049734854297595e+000},
        {-8.492455381030945e+000,-9.638065423607585e-001,-2.111530046471992e-001,
        1.048964832761054e+000},{-9.807474389689094e+000,-1.043907256650206e+000,
        -2.187208392607184e-001,1.048164771754150e+000},{-1.142992555561826e+001,
        -1.135606773901190e+000,-2.269829647144973e-001,1.047332000543470e+000},
        {-1.344511926099734e+001,-1.241495308018550e+000,-2.360481455742939e-001,
        1.046463442140266e+000},{-1.600738269476274e+001,-1.364375395477736e+000,
        -2.460518881297009e-001,1.045555523007033e+000},{-1.929939535516280e+001,
        -1.508513275807175e+000,-2.571603987700460e-001,1.044604055466647e+000},
        {-2.362120150582920e+001,-1.678967132778218e+000,-2.695862540141585e-001,
        1.043604082766197e+000},{-2.942152881801653e+001,-1.882583607807427e+000,
        -2.836015162163547e-001,1.042549669910840e+000},{-3.741453654687421e+001,
        -2.128389007332268e+000,-2.995629186888021e-001,1.041433617232253e+000},
        {-4.878270682458398e+001,-2.428336462205647e+000,-3.179486577792697e-001,
        1.040247057754742e+000},{-6.558832836460495e+001,-2.797988793419757e+000,
        -3.394177234686278e-001,1.038978876337398e+000},{-9.164855359795394e+001,
        -3.256574496899152e+000,-3.649096511422550e-001,1.037614844862927e+000},
        {-1.346442592691005e+002,-3.822745465072996e+000,-3.958270232324012e-001,
        1.036136285584020e+000},{-2.039488892785857e+002,-4.585663115601926e+000,
        -4.341576010582943e-001,1.034517909421716e+000},{-3.213729265046176e+002,
        -5.715603682655638e+000,-4.830053729894114e-001,1.032724118072463e+000},
        {-5.380530697149483e+002,-7.590740438263201e+000,-5.472440337555892e-001,
        1.030702209952531e+000},{-9.773668143802523e+002,-8.397564013673986e+000,
        -6.149721615017588e-001,1.028987687176493e+000},{-1.971206182132680e+003,
        -7.954972432593549e+000,-7.107673680064054e-001,1.027043503002403e+000},
        {-4.259063749453282e+003,-7.470160381920227e+000,-8.552169229520203e-001,
        1.024677777723123e+000},{-9.468420868233850e+003,-1.441169226818975e+001,
        -1.061676619743433e+000,1.021911421684383e+000},{-2.124426475615268e+004,
        -2.969103328338514e+001,-1.321932106107769e+000,1.019310988957590e+000},
        {-5.142304350768700e+004,-2.757198727294517e+001,-1.633808439690381e+000,
        1.017155605087379e+000},{-1.261916077251016e+005,1.340795831729274e+001,
        -2.041513938530926e+000,1.015172127346691e+000},{-2.907555625955585e+005,
        3.100216772602235e+000,-2.587089312710111e+000,1.013030579652139e+000},
        {-6.443400705406987e+005,-4.736727283746432e+002,-3.393782437455662e+000,
        1.010424690909639e+000},{-1.284212584824039e+006,-8.719164629810688e+002,
        -4.081415290704422e+000,1.009013628657760e+000},{-2.953254945900618e+006,
        -3.499079388487411e+002,-4.609510455745138e+000,1.008360191314845e+000},
        {-8.708278203444760e+006,1.160570409967432e+003,-5.732506388098228e+000,
        1.007240267626251e+000},{-2.925999835917269e+007,6.373124182370374e+003,
        -7.673217433665648e+000,1.006032670356375e+000},{-9.691364693490808e+007,
        5.724533606825865e+003,-9.856016988972671e+000,1.004465302443802e+000},
        {-2.344230326747042e+008,-7.237460849943119e+003,-1.228103670994250e+001,
        1.003403193772207e+000},{-1.674594981779917e+012,7.945262725742146e+007,
        -9.424323791757101e+002,1.002718092569686e+000}};

    record crit
      extends Modelica.Icons.Record;
      constant SI.Temperature TCRIT=374.18;
      constant SI.Pressure PCRIT=4056290.0;
      constant SI.Density DCRIT=508.0;

    end crit;

    record data
      constant SI.SpecificHeatCapacity R_s=81.4888564372;
      // 8.314471/0.102032
      constant SI.MolarMass MM=0.102032;
      extends crit;
      constant SI.SpecificEnthalpy HCRIT=389653;
      constant SI.SpecificEntropy SCRIT=1562.135;
      extends fcrit;
      extends triple;

    end data;

    record fcrit
      extends Modelica.Icons.Record;
      constant SI.Temperature FTCRIT=374.209;
      constant SI.Pressure FPCRIT=4059280.0;
      constant SI.Density FDCRIT=511.9;

    end fcrit;

    record Ideal
      extends Common.EOSIdealCoeff(nc=5, a={-1.019535e+0,9.047135e+0,-1.629789e+0,
            -9.723916e+0,-3.927170e+0});

    end Ideal;

    record ReferenceStates
      extends Modelica.Icons.Record;
      constant SI.SpecificEnthalpy h0=1.0;
      constant SI.SpecificEntropy s0=1.0;

    end ReferenceStates;

    record Residual
      extends Common.EOSResidualCoeff(
        nc=21,
        ns1=8,
        c={0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,1.0,1.0,2.0,2.0,2.0,2.0,2.0,2.0,
            3.0,3.0,3.0,4.0},
        d={2.0,1.0,3.0,6.0,6.0,1.0,1.0,2.0,5.0,2.0,2.0,4.0,1.0,4.0,1.0,2.0,4.0,
            1.0,5.0,3.0,10.0},
        t={-0.5,0.0,0.0,0.0,1.5,1.5,2.0,2.0,1.0,3.0,5.0,1.0,5.0,5.0,6.0,10.0,
            10.0,10.0,18.0,22.0,50.0},
        n={0.5586817000e-01,0.4982230000e+00,0.2458698000e-01,0.8570145000e-03,
            0.4788584000e-03,-0.1800808000e+01,0.2671641000e+00,-0.4781652000e-01,
            0.1423987000e-01,0.3324062000e+00,-0.7485907000e-02,
            0.1017263000e-03,-0.5184567000e+00,-0.8692288000e-01,
            0.2057144000e+00,-0.5000457000e-02,0.4603262000e-03,-0.3497836000e-02,
            0.6995038000e-02,-0.1452184000e-01,-0.1285458000e-03});

    end Residual;

    record triple
      extends Modelica.Icons.Record;
      constant SI.Temperature TTRIPLE=169.85;
      constant SI.Pressure PTRIPLE=389.563789;
      constant SI.Density DLTRIPLE=1591.107453;
      constant SI.Density DVTRIPLE=0.028172;

    end triple;

    record CoeffsThermalConductivity
      extends Modelica.Icons.Record;
      constant Real a_0=-1.05248e-2 "Empirical parameter, [W/(m K)]";
      constant Real a_1=8.00982e-5 "Empirical parameter, [W/(m K^2)]";
      constant Real b[4]={1.836526,5.126143,-1.436883,0.626144}
        "Empirical parameter, [-]";
      constant Real lambda_reducing=2.055e-3 "Reducing factor, [W/(m K)]";
      constant Real q_d=1.89202e9
        "Modified effective cutoff wave number, [1/m]";
      constant Real xi_0=1.94e-10 "Critical Amplitude, [m]";
      constant Real GAMMA=0.0496 "Amplitude, [-]";
      constant Real T_ref=561.411 "Arbitrary reference temperature, [K]";
      constant Real p_crit=4059.28 "Critical pressure, [kPa]";
      constant Real rho_crit=5.049886 "Critical density, [mol/L]";
      constant Real nu=0.63 "Universal exponent, [-]";
      constant Real gamma=1.239 "Universal exponent, [-]";
      constant Real R_0=1.03 "Universal amplitude, [-]";

    end CoeffsThermalConductivity;

    record CoeffsSurfaceTension
      extends Modelica.Icons.Record;
      constant Integer nterm=1;
      constant Real sigmak[nterm]={0.06016} "Empirical parameter";
      constant Real sigexp[nterm]={1.26} "Empirical parameter";

    end CoeffsSurfaceTension;
  end R134aData;
  annotation (Documentation(info="<html>
<p>
Calculation of fluid properties for Tetrafluoroethane (R134a) in the fluid region of 0.0039 bar (Triple pressure) to 700 bar and 169.85 Kelvin (Triple temperature) to 455 Kelvin.
</p>
<h4>Restriction</h4>
<p>
The functions provided by this package shall be used inside of the restricted limits according to the referenced literature.
</p>
<ul>
 <li>
      <strong> 0.0039 bar &le; p &le; 700 bar </strong>
 </li>
 <li>
      <strong> 169.85 Kelvin &le; T &le; 455 Kelvin  </strong>
 </li>
 <li>
      <strong> explicit for pressure and specific enthalpy </strong>
 </li>
</ul>

<p><strong>References</strong></p>
<dl><dt>Baehr, H.D. and Tillner-Roth, R.: </dt>
<dd><strong>Thermodynamic Properties of Environmentally Acceptable Refrigerants -
Equations of State and Tables for Ammonia, R22, R134a, R152a, and R123</strong>. Springer-Verlag, Berlin (Germany), 1994.</dd>
</dl>
<dl><dt>Klein, McLinden and Laesecke: </dt>
<dd><strong>An improved extended corresponding states method for estimation of viscosity of pure refrigerants and mixtures</strong>.
Int. J. Refrig., Vol. 20, No.3, pp. 208-217, 1997.</dd>
</dl>
<dl><dt>McLinden, Klein. and Perkins: </dt>
<dd><strong>An extended corresponding states model for the thermal conductivity
of refrigerants and refrigerant mixtures</strong>.
Int. J. Refrig., 23 (2000) 43-63.</dd>
</dl>
<dl><dt>Okada and Higashi: </dt>
<dd><strong>Surface tension correlation of HFC-134a and HCFC-123</strong>.
Proceedings of the Joint Meeting of IIR Commissions B1, B2, E1, and E2, Padua, Italy, pp. 541-548, 1994.</dd>
</dl>

<h4>Verification</h4>
<p>
The verification report for the development of this library is provided
<a href=\"modelica://Modelica/Resources/Documentation/Media/MoMoLib_VerificationResults_XRG.pdf\">here</a>.
</p>

<h4>Acknowledgment</h4>
<p>
This library was developed by XRG Simulation GmbH as part of the <a href=\"http://www.cleansky.eu/\">Clean Sky</a> JTI project (Project title: MoMoLib-Modelica Model Library Development for Media, Magnetic Systems and Wavelets; Project number: 296369; Theme: JTI-CS-2011-1-SGO-02-026: Modelica Model Library Development Part I). The partial financial support for the development of this library by the European Union is highly appreciated.
</p>

<p>
Some parts of this library refer to the ThermoFluid library developed at Lund University (<a href=\"http://thermofluid.sourceforge.net/\">http://thermofluid.sourceforge.net</a>).
</p>

<p>
Copyright &copy; 2013-2020, Modelica Association and contributors
</p>
</html>"));
end R134a;
