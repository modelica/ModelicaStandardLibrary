package TestWater "Models to test IF97 water models in Modelica.Media" 
  model Test_ph_OnePhase 
    replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;
    parameter Real pmin=10e5;
    parameter Real pmax=12e5;
    parameter Real hmin=1e5;
    parameter Real hmax=3e5;
    Medium.BaseProperties medium(phase(start = 1));
    Medium.AbsolutePressure p;
    Medium.SpecificEnthalpy h;
    
    Real cp;
    Real cv;
    Real lambda;
    Real mu;
    Real drdp_h;
    Real drdh_p;
    Real Pr;
    Real s;
    Real k;
    Real h_iso;
    Real v;
    Real beta;
    Real kT;
    
  equation 
    p=pmin+time*(pmax-pmin);
    h=hmin+(1+sin(6.28*10*time))/2*(hmax-hmin);
    
    medium.p=p;
    medium.h=h;
    
    cp=Medium.heatCapacity_cp(medium.state);
    cv=Medium.heatCapacity_cv(medium.state);
    lambda=Medium.thermalConductivity(medium.state);
    mu=Medium.dynamicViscosity(medium.state);
    drdp_h=Medium.density_derp_h(medium.state);
    drdh_p=Medium.density_derh_p(medium.state);
    Pr=Medium.prandtlNumber(medium.state);
    s=Medium.specificEntropy(medium.state);
    k=Medium.isentropicExponent(medium.state);
    h_iso=Medium.isentropicEnthalpy(p-1e4,medium.state);
    v=Medium.velocityOfSound(medium.state);
    beta=Medium.isobaricExpansionCoefficient(medium.state);
    kT=Medium.isothermalCompressibility(medium.state);
    
  end Test_ph_OnePhase;
  
  model Test_ph_TwoPhase 
    replaceable package Medium = 
        Modelica.Media.Interfaces.PartialTwoPhaseMedium;
    parameter Real pmin=10e5;
    parameter Real pmax=100e5;
    parameter Real hmin=1e5;
    parameter Real hmax=3e6;
    constant Real pcrit=Medium.data.criticalPressure;
    
    Medium.BaseProperties medium;
    Medium.SaturationProperties sat;
    Medium.ThermodynamicState bubble_1;
    Medium.ThermodynamicState bubble_2;
    Medium.ThermodynamicState dew_1;
    Medium.ThermodynamicState dew_2;
    Medium.AbsolutePressure p;
    Medium.SpecificEnthalpy h;
    
    Real cp;
    Real cv;
    Real lambda;
    Real mu;
    Real drdp_h;
    Real drdh_p;
    Real Pr;
    Real s;
    Real k;
    Real h_iso;
    Real v;
    Real beta;
    Real kT;
    
    Real hl;
    Real hv;
    Real sl;
    Real sv;
    Real rhol;
    Real rhov;
    Real sigma;
    Real dhldp;
    Real dhvdp;
    Real drholdp;
    Real drhovdp;
    Real drldp_h_1;
    Real drldp_h_2;
    Real drvdp_h_1;
    Real drvdp_h_2;
    Real drldh_p_1;
    Real drldh_p_2;
    Real drvdh_p_1;
    Real drvdh_p_2;
    
    Real mul;
    Real muv;
    Real lambdal;
    Real lambdav;
    Real Pr_l;
    Real Pr_v;
    
  equation 
    p=pmin+time*(pmax-pmin);
    h=hmin+(1+sin(6.28*10*time))/2*(hmax-hmin);
    
    medium.p=p;
    medium.h=h;
    
    sat.psat=p;
    sat.Tsat=Medium.saturationTemperature(p);
    
    bubble_1=Medium.setBubbleState(sat,1);
    bubble_2=Medium.setBubbleState(sat,2);
    dew_1=Medium.setDewState(sat,1);
    dew_2=Medium.setDewState(sat,2);
    
    hl=if p<pcrit then Medium.bubbleEnthalpy(sat) else 0;
    hv=if p<pcrit then Medium.dewEnthalpy(sat) else 0;
    sl = if p<pcrit then Medium.bubbleEntropy(sat) else 0;
    sv = if p<pcrit then Medium.dewEntropy(sat) else 0;
    
    cp=if p<pcrit and (h>=hl and h<=hv) then 0 else Medium.heatCapacity_cp(medium.state);
    cv=Medium.heatCapacity_cv(medium.state);
    lambda=if p<pcrit and (h>=hl and h<=hv) then 0 else Medium.thermalConductivity(medium.state);
    mu=if p<pcrit and (h>=hl and h<=hv) then 0 else Medium.dynamicViscosity(medium.state);
    drdp_h=Medium.density_derp_h(medium.state);
    drdh_p=Medium.density_derh_p(medium.state);
    Pr=if p<pcrit and (h>=hl and h<=hv) then 0 else Medium.prandtlNumber(medium.state);
    s=Medium.specificEntropy(medium.state);
    k=if p<pcrit and (h>=hl and h<=hv) then 0 else Medium.isentropicExponent(medium.state);
    h_iso=Medium.isentropicEnthalpy(p-1e4,medium.state);
    v=if p<pcrit and (h>=hl and h<=hv) then 0 else Medium.velocityOfSound(medium.state);
    beta=if p<pcrit and (h>=hl and h<=hv) then 0 else Medium.isobaricExpansionCoefficient(medium.state);
    kT=if p<pcrit and (h>=hl and h<=hv) then 0 else Medium.isothermalCompressibility(medium.state);
    
    rhol=if p<pcrit then Medium.bubbleDensity(sat) else 0;
    rhov=if p<pcrit then Medium.dewDensity(sat) else 0;
    sigma= if p<pcrit then Medium.surfaceTension(sat) else 0;
    dhldp= if p<pcrit then Medium.dBubbleEnthalpy_dPressure(sat) else 0;
    dhvdp= if p<pcrit then Medium.dDewEnthalpy_dPressure(sat) else 0;
    drholdp= if p<pcrit then Medium.dBubbleDensity_dPressure(sat) else 0;
    drhovdp= if p<pcrit then Medium.dDewDensity_dPressure(sat) else 0;
    drldp_h_1= if p<pcrit then Medium.density_derp_h(bubble_1) else 0;
    drldp_h_2= if p<pcrit then Medium.density_derp_h(bubble_2) else 0;
    drvdp_h_1= if p<pcrit then Medium.density_derp_h(dew_1) else 0;
    drvdp_h_2= if p<pcrit then Medium.density_derp_h(dew_2) else 0;
    drldh_p_1= if p<pcrit then Medium.density_derh_p(bubble_1) else 0;
    drldh_p_2= if p<pcrit then Medium.density_derh_p(bubble_2) else 0;
    drvdh_p_1= if p<pcrit then Medium.density_derh_p(dew_1) else 0;
    drvdh_p_2= if p<pcrit then Medium.density_derh_p(dew_2) else 0;
    mul=if p<pcrit then Medium.dynamicViscosity(bubble_1) else 0;
    muv=if p<pcrit then Medium.dynamicViscosity(dew_1) else 0;
    lambdal=if p<pcrit then Medium.thermalConductivity(bubble_1) else 0;
    lambdav=if p<pcrit then Medium.thermalConductivity(dew_1) else 0;
    Pr_l=if p<pcrit then Medium.prandtlNumber(bubble_1) else 0;
    Pr_v=if p<pcrit then Medium.prandtlNumber(dew_1) else 0;
    
  end Test_ph_TwoPhase;
  
  model Test_pT 
    replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;
    parameter Real pmin=10e5;
    parameter Real pmax=12e5;
    parameter Real Tmin=333;
    parameter Real Tmax=353;
    Medium.BaseProperties medium;
    Medium.AbsolutePressure p(start = 1.0e5);
    Medium.Temperature T(start = 300.0);
    
    Real cp;
    Real cv;
    Real lambda;
    Real mu;
    Real Pr;
    Real s;
    Real k;
    Real h_iso;
    Real v;
    Real beta;
    Real kT;
    
  equation 
    p=pmin+time*(pmax-pmin);
    T=Tmin+(1+sin(6.28*10*time))/2*(Tmax-Tmin);
    
    medium.p=p;
    medium.T=T;
    
    cp=Medium.heatCapacity_cp(medium.state);
    cv=Medium.heatCapacity_cv(medium.state);
    lambda=Medium.thermalConductivity(medium.state);
    mu=Medium.dynamicViscosity(medium.state);
    Pr=Medium.prandtlNumber(medium.state);
    s=Medium.specificEntropy(medium.state);
    k=Medium.isentropicExponent(medium.state);
    h_iso=Medium.isentropicEnthalpy(p-1e4,medium.state);
    v=Medium.velocityOfSound(medium.state);
    beta=Medium.isobaricExpansionCoefficient(medium.state);
    kT=Medium.isothermalCompressibility(medium.state);
  end Test_pT;
  
  model Test_dT_OnePhase 
    replaceable package Medium = 
        Modelica.Media.Interfaces.PartialTwoPhaseMedium;
  //  parameter Boolean smoothModel=false;
    parameter Real dmin=1;
    parameter Real dmax=1.3;
    parameter Real Tmin=500;
    parameter Real Tmax=520;
    constant Real Tcrit=Medium.data.criticalTemperature;
    Medium.BaseProperties medium;
    Medium.SaturationProperties sat;
    Medium.ThermodynamicState bubble_1;
    Medium.ThermodynamicState bubble_2;
    Medium.ThermodynamicState dew_1;
    Medium.ThermodynamicState dew_2;
    Medium.Density d;
    Medium.Temperature T;
    
    Real cp;
    Real cv;
    Real lambda;
    Real mu;
    Real Pr;
    Real s;
    Real k;
    Real h_iso;
    Real v;
    Real beta;
    Real kT;
    
    Real hl;
    Real hv;
    Real rhol;
    Real rhov;
    Real sigma;
    
  equation 
    d=dmin+time*(dmax-dmin);
    T=Tmin+(1+sin(6.28*10*time))/2*(Tmax-Tmin);
    
    medium.d=d;
    medium.T=T;
    
    sat.psat=Medium.saturationPressure(T);
    sat.Tsat=T;
    
    bubble_1=Medium.setBubbleState(sat,1);
    bubble_2=Medium.setBubbleState(sat,2);
    dew_1=Medium.setDewState(sat,1);
    dew_2=Medium.setDewState(sat,2);
    
    hl=if T<Tcrit then Medium.bubbleEnthalpy(sat) else 0;
    hv=if T<Tcrit then Medium.dewEnthalpy(sat) else 0;
    
    rhol=if T<Tcrit then Medium.bubbleDensity(sat) else 0;
    rhov=if T<Tcrit then Medium.dewDensity(sat) else 0;
    
    sigma= if T<Tcrit then Medium.surfaceTension(sat) else 0;
    
    cp=Medium.heatCapacity_cp(medium.state);
    cv=Medium.heatCapacity_cv(medium.state);
    lambda=Medium.thermalConductivity(medium.state);
    mu=Medium.dynamicViscosity(medium.state);
    Pr=Medium.prandtlNumber(medium.state);
    s=Medium.specificEntropy(medium.state);
    k=Medium.isentropicExponent(medium.state);
    h_iso=Medium.isentropicEnthalpy(medium.p+1e3,medium.state);
    v=Medium.velocityOfSound(medium.state);
    beta=Medium.isobaricExpansionCoefficient(medium.state);
    kT=Medium.isothermalCompressibility(medium.state);
    
  end Test_dT_OnePhase;
  
  model Test_ph_TwoPhaseNoEvent 
    replaceable package Medium = 
        Modelica.Media.Interfaces.PartialTwoPhaseMedium;
    parameter Real pmin=10e5;
    parameter Real pmax=100e5;
    parameter Real hmin=1e5;
    parameter Real hmax=3e6;
    constant Real pcrit=Medium.data.criticalPressure;
    
    Medium.BaseProperties medium;
    Medium.SaturationProperties sat;
    Medium.ThermodynamicState bubble_1;
    Medium.ThermodynamicState bubble_2;
    Medium.ThermodynamicState dew_1;
    Medium.ThermodynamicState dew_2;
    Medium.AbsolutePressure p;
    Medium.SpecificEnthalpy h;
    
    Real cp;
    Real cv;
    Real lambda;
    Real mu;
    Real drdp_h;
    Real drdh_p;
    Real Pr;
    Real s;
    Real k;
    Real h_iso;
    Real v;
    Real beta;
    Real kT;
    
    Real hl;
    Real hv;
    Real sl;
    Real sv;
    Real rhol;
    Real rhov;
    Real sigma;
    Real dhldp;
    Real dhvdp;
    Real drholdp;
    Real drhovdp;
    Real drldp_h_1;
    Real drldp_h_2;
    Real drvdp_h_1;
    Real drvdp_h_2;
    Real drldh_p_1;
    Real drldh_p_2;
    Real drvdh_p_1;
    Real drvdh_p_2;
    
    Real mul;
    Real muv;
    Real lambdal;
    Real lambdav;
    Real Pr_l;
    Real Pr_v;
    
  equation 
    p=pmin+time*(pmax-pmin);
    h=hmin+(1+sin(6.28*10*time))/2*(hmax-hmin);
    
    medium.p=p;
    medium.h=h;
    
    sat.psat=p;
    sat.Tsat=Medium.saturationTemperature(p);
    
    bubble_1=Medium.setBubbleState(sat,1);
    bubble_2=Medium.setBubbleState(sat,2);
    dew_1=Medium.setDewState(sat,1);
    dew_2=Medium.setDewState(sat,2);
    
    hl=if p<pcrit then Medium.bubbleEnthalpy(sat) else 0;
    hv=if p<pcrit then Medium.dewEnthalpy(sat) else 0;
    sl = if p<pcrit then Medium.bubbleEntropy(sat) else 0;
    sv = if p<pcrit then Medium.dewEntropy(sat) else 0;
    
    cp=noEvent(if p<pcrit and (h>=hl and h<=hv) then 0 else Medium.heatCapacity_cp(medium.state));
    cv=Medium.heatCapacity_cv(medium.state);
    lambda=noEvent(if p<pcrit and (h>=hl and h<=hv) then 0 else Medium.thermalConductivity(medium.state));
    mu=noEvent(if p<pcrit and (h>=hl and h<=hv) then 0 else Medium.dynamicViscosity(medium.state));
    drdp_h=Medium.density_derp_h(medium.state);
    drdh_p=Medium.density_derh_p(medium.state);
    Pr=noEvent(if p<pcrit and (h>=hl and h<=hv) then 0 else Medium.prandtlNumber(medium.state));
    s=Medium.specificEntropy(medium.state);
    k=noEvent(if p<pcrit and (h>=hl and h<=hv) then 0 else Medium.isentropicExponent(medium.state));
    h_iso=Medium.isentropicEnthalpy(p,medium.state);
    v=noEvent(if p<pcrit and (h>=hl and h<=hv) then 0 else Medium.velocityOfSound(medium.state));
    beta=noEvent(if p<pcrit and (h>=hl and h<=hv) then 0 else Medium.isobaricExpansionCoefficient(medium.state));
    kT=noEvent(if p<pcrit and (h>=hl and h<=hv) then 0 else Medium.isothermalCompressibility(medium.state));
    
    rhol=if p<pcrit then Medium.bubbleDensity(sat) else 0;
    rhov=if p<pcrit then Medium.dewDensity(sat) else 0;
    sigma= if p<pcrit then Medium.surfaceTension(sat) else 0;
    dhldp= if p<pcrit then Medium.dBubbleEnthalpy_dPressure(sat) else 0;
    dhvdp= if p<pcrit then Medium.dDewEnthalpy_dPressure(sat) else 0;
    drholdp= if p<pcrit then Medium.dBubbleDensity_dPressure(sat) else 0;
    drhovdp= if p<pcrit then Medium.dDewDensity_dPressure(sat) else 0;
    drldp_h_1= if p<pcrit then Medium.density_derp_h(bubble_1) else 0;
    drldp_h_2= if p<pcrit then Medium.density_derp_h(bubble_2) else 0;
    drvdp_h_1= if p<pcrit then Medium.density_derp_h(dew_1) else 0;
    drvdp_h_2= if p<pcrit then Medium.density_derp_h(dew_2) else 0;
    drldh_p_1= if p<pcrit then Medium.density_derh_p(bubble_1) else 0;
    drldh_p_2= if p<pcrit then Medium.density_derh_p(bubble_2) else 0;
    drvdh_p_1= if p<pcrit then Medium.density_derh_p(dew_1) else 0;
    drvdh_p_2= if p<pcrit then Medium.density_derh_p(dew_2) else 0;
    mul=if p<pcrit then Medium.dynamicViscosity(bubble_1) else 0;
    muv=if p<pcrit then Medium.dynamicViscosity(dew_1) else 0;
    lambdal=if p<pcrit then Medium.thermalConductivity(bubble_1) else 0;
    lambdav=if p<pcrit then Medium.thermalConductivity(dew_1) else 0;
    Pr_l=if p<pcrit then Medium.prandtlNumber(bubble_1) else 0;
    Pr_v=if p<pcrit then Medium.prandtlNumber(dew_1) else 0;
    
  end Test_ph_TwoPhaseNoEvent;
  
  model Test_dT_TwoPhaseNoEvent 
    replaceable package Medium = 
        Modelica.Media.Interfaces.PartialTwoPhaseMedium;
    parameter Real dmin=1;
    parameter Real dmax=1.3;
    parameter Real Tmin=500;
    parameter Real Tmax=520;
    constant Real Tcrit=Medium.data.criticalTemperature;
    Medium.BaseProperties medium;
    Medium.SaturationProperties sat;
    Medium.ThermodynamicState bubble;
    Medium.ThermodynamicState dew;
    Medium.Density d;
    Medium.Temperature T;
    
    Real cp;
    Real cv;
    Real lambda;
    Real mu;
    Real Pr;
    Real s;
    Real k;
    Real h_iso;
    Real v;
    Real beta;
    Real kT;
    Real Pr_l;
    Real Pr_v;
    Real hl;
    Real hv;
    Real sl;
    Real sv;
    Real rhol;
    Real rhov;
    Real sigma;
    
  equation 
    d=dmin+time*(dmax-dmin);
    T=Tmin+(1+sin(6.28*10*time))/2*(Tmax-Tmin);
    
    medium.d=d;
    medium.T=T;
    
    cp=noEvent(if T<Tcrit and d<rhol and d>rhov then 0 else Medium.heatCapacity_cp(medium.state));
    cv=Medium.heatCapacity_cv(medium.state);
    lambda=noEvent(if T<Tcrit and d<rhol and d>rhov then 0 else Medium.thermalConductivity(medium.state));
    mu=noEvent(if T<Tcrit and d<rhol and d>rhov then 0 else Medium.dynamicViscosity(medium.state));
    Pr=noEvent(if T<Tcrit and d<rhol and d>rhov then 0 else Medium.prandtlNumber(medium.state));
    s=Medium.specificEntropy(medium.state);
    k=noEvent(if T<Tcrit and d<rhol and d>rhov then 0 else Medium.isentropicExponent(medium.state));
    h_iso=Medium.isentropicEnthalpy(medium.p+1e3,medium.state);
  //  v=noEvent(if medium.state.phase==2 then 0 else Medium.velocityOfSound(medium.state));
  //  v=noEvent(if T<Tcrit and d<rhol and d>rhov then 0 else Medium.velocityOfSound(medium.state));
    v=Medium.velocityOfSound(medium.state);
    beta=noEvent(if T<Tcrit and d<rhol and d>rhov then 0 else Medium.isobaricExpansionCoefficient(medium.state));
    kT=noEvent(if T<Tcrit and d<rhol and d>rhov then 0 else Medium.isothermalCompressibility(medium.state));
    
    sat.Tsat=T;
    sat.psat=Medium.saturationPressure(T);
    
    dew=Medium.setDewState(sat);
    bubble=Medium.setBubbleState(sat);
    
    hl = if T<Tcrit then Medium.bubbleEnthalpy(sat) else 0;
    hv = if T<Tcrit then Medium.dewEnthalpy(sat) else 0;
    sl = if T<Tcrit then Medium.bubbleEntropy(sat) else 0;
    sv = if T<Tcrit then Medium.dewEntropy(sat) else 0;
    
    rhol = if T<Tcrit then Medium.bubbleDensity(sat) else 0;
    rhov = if T<Tcrit then Medium.dewDensity(sat) else 0;
    sigma = if T<Tcrit then Medium.surfaceTension(sat) else 0;
    Pr_l = if T<Tcrit then Medium.prandtlNumber(bubble) else 0;
    Pr_v = if T<Tcrit then Medium.prandtlNumber(dew) else 0;
    
  end Test_dT_TwoPhaseNoEvent;
  
  model Test_All_ph 
    Test_ph_OnePhase Test_ph1(redeclare package Medium = 
          Modelica.Media.Water.StandardWater);
    Test_ph_OnePhase Test_ph2(redeclare package Medium = 
          Modelica.Media.Water.WaterIF97OnePhase_ph);
    Test_ph_OnePhase Test_ph3(redeclare package Medium = 
          Modelica.Media.Water.WaterIF97OnePhase_ph,
          hmin=2.9e6, hmax=3.0e6);
    Test_ph_OnePhase Test_ph4(redeclare package Medium = 
          Modelica.Media.Water.WaterIF97OnePhase_ph,
          pmin=240e5, pmax=260e5, hmin=2.9e6, hmax=3.0e6);
    Test_ph_TwoPhase Test_ph5(redeclare package Medium = 
          Modelica.Media.Water.StandardWater);
    Test_ph_TwoPhase Test_ph6(redeclare package Medium = 
          Modelica.Media.Water.WaterIF97_ph);
    Test_ph_TwoPhaseNoEvent Test_ph8(redeclare package Medium = 
          Modelica.Media.Water.WaterIF97_ph(smoothModel=true));
    Test_ph_TwoPhaseNoEvent Test_ph7(redeclare package Medium = 
          Modelica.Media.Water.StandardWater(smoothModel=true),
          pmin=10e5, pmax=300e5,
          hmin=1e5, hmax=3e6);
    
  end Test_All_ph;
  
  model Test_All_dT 
    Test_dT_OnePhase Test_dT1(redeclare package Medium = 
          Modelica.Media.Water.WaterIF97_dT(smoothModel=true, onePhase=true));
    Test_dT_OnePhase Test_dT2(redeclare package Medium = 
          Modelica.Media.Water.WaterIF97_dT(smoothModel=true, onePhase=true),
          Tmin=650, Tmax=700);
    Test_dT_TwoPhaseNoEvent Test_dT3(redeclare package Medium = 
          Modelica.Media.Water.WaterIF97_dT,
          dmin=1, dmax=750, Tmin=380, Tmax=660);
  end Test_All_dT;
  
  model Test_All_pT 
    Test_pT Test_pT1(redeclare package Medium = 
          Modelica.Media.Water.StandardWaterOnePhase);
    Test_pT Test_pT2(redeclare package Medium = 
          Modelica.Media.Water.WaterIF97_pT);
    Test_pT Test_pT3(redeclare package Medium = 
          Modelica.Media.Water.WaterIF97_pT,
          Tmin=470, Tmax=670);
    Test_pT Test_pT4(redeclare package Medium = 
          Modelica.Media.Water.WaterIF97_pT,
          Tmin=650, Tmax=700);
    Test_pT Test_pT5(redeclare package Medium = 
          Modelica.Media.Water.WaterIF97_pT,
          Tmin=430, Tmax=450);
  end Test_All_pT;
  annotation (Documentation(info="<html>
Test_All_ph tests different IF97 Water models with p,h as state variables.
<p>Test_All_dT tests different IF97 Water models with d,T as state variables.
<p>Test_All_pT tests different IF97 Water models with p,T as state variables.
<p>All models should be run for 1 second.
</html>"), uses(Modelica(version="2.2.1",  Media(         version="0.900"))));
end TestWater;
