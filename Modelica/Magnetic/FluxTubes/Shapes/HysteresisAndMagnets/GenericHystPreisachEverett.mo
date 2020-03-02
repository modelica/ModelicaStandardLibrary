within Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets;
model GenericHystPreisachEverett
  "Generic flux tube with ferromagnetic hysteresis based on the Preisach model and the Everett function [Ya89])"
  import Modelica.Constants.pi;

  parameter FluxTubes.Material.HysteresisEverettParameter.BaseData mat=
      FluxTubes.Material.HysteresisEverettParameter.BaseData()
    "Preisach Parameters"
    annotation (Dialog(group="Material"), choicesAllMatching=true);

  parameter Integer Count=100 "Length of history array" annotation(Dialog(group="Advanced"));
  parameter SI.MagneticFieldStrength eps=1e-5
    "Tolerance in Preisach history" annotation(Dialog(group="Advanced"));
  parameter SI.Time t1=1e-6 "Initialization time" annotation(Dialog(group="Advanced"));

  extends BaseClasses.GenericHysteresis(sigma=mat.sigma);

protected
  final parameter Real mu0=mat.K*Modelica.Constants.mu_0;

  SI.MagneticFluxDensity J "Polarisation";
  SI.MagneticFieldStrength hmax(start=0, min=0) "Maximum value of h";

  SI.MagneticFieldStrength alpha
    "Current alpha coordinate of Everett-Function everett(alpha,beta)";
  SI.MagneticFieldStrength beta
    "Current beta coordinate of Everett-Function everett(alpha,beta)";

  Boolean asc(start=true, fixed=true) "=asc without chatter";
  Boolean asc2 "Hstat is ascending der(Hstat)>0";
  Boolean delAsc(start=false)
    "Wipeout history vertex at ascending Hstat";
  Boolean delDesc(start=false)
    "Wipeout history vertex at descending Hstat";
  Boolean del(start=false) "delAsc or delDesc";
  Boolean init(start=false, fixed=true)
    "If init=1 then J runs on the initial magnetization curve";
  Boolean evInit(start=false) "Event init=0 -> init=1";
  Boolean evAsc(start=false) "Event asc=0 -> asc=1";
  Boolean evDesc(start=false) "Event asc=1 -> asc=0";

  SI.MagneticFieldStrength aSav[Count]
    "1xCount array of alpha history (vertices on Preisach Plane)";
  SI.MagneticFieldStrength bSav[Count]
    "1xCount array of beta history (vertices on Preisach Plane)";

  SI.MagneticFluxDensity E "Everett function";
  SI.MagneticFieldStrength H1 "Term for computing the Everett function";
  SI.MagneticFieldStrength H2 "Term for computing the Everett function";
  SI.MagneticFieldStrength H3 "Term for computing the Everett function";
  SI.MagneticFieldStrength H4 "Term for computing the Everett function";
  constant SI.MagneticFluxDensity unitT=1;

  Real v(start=0,  fixed=true, final unit="1");

  Boolean init2(start=false, fixed=true);
  Boolean init3;
  SI.MagneticFieldStrength x(start=0)
    "Variable for initialization of the Preisach model";
  discrete Real aSavI(start=0, fixed=true);
  discrete Real bSavI(start=0, fixed=true);
  discrete Real bI(start=0, fixed=true);
  discrete Real hmaxI(start=0, fixed=true);

initial equation
  J = 0.5*(FluxTubes.Utilities.everett(
          H,
          -mat.Hsat,
          mat,
          false)*(1 - MagRel) - FluxTubes.Utilities.everett(
          mat.Hsat,
          H,
          mat,
          false)*(1 + MagRel) + FluxTubes.Utilities.everett(
          mat.Hsat,
          -mat.Hsat,
          mat,
          false)*MagRel);
  J = FluxTubes.Utilities.initPreisach(
          x,
          H,
          mat);
  aSav=fill( mat.Hsat,Count);
  bSav=fill(-mat.Hsat,Count);
  beta=alpha;
  hmax=mat.Hsat;

equation
  init2 = time >= 1.5*t1;
  init3 = edge(init2);

  der(x) = 0;
  when init2 then
    hmaxI = abs(Hstat)+abs(x);
    if hmax<eps then
      aSavI = mat.Hsat;
      bSavI = -mat.Hsat;
    elseif asc and x<0 then
      aSavI = mat.Hsat;
      bSavI = -hmax;
    elseif asc and x>0 then
      aSavI = hmax;
      bSavI = alpha;
    elseif not asc and x<0 then
      aSavI = alpha;
      bSavI = -hmax;
    else
      aSavI = hmax;
      bSavI = -mat.Hsat;
    end if;
    bI = if asc then bSav[1] else aSav[1];
  end when;

  alpha = if Hstat<=-mat.Hsat then -mat.Hsat elseif Hstat>=mat.Hsat then mat.Hsat else Hstat;

  asc2 = der(Hstat)>0;
  der(v)= if (asc2 and v<1) then 0.5/t1 elseif (not asc2 and v>0) then -0.5/t1 else 0;
  asc = v>0.5;

  evAsc = (not pre(asc)) and asc;
  evDesc = pre(asc) and (not asc);

  der(beta) = if init then -der(alpha) else 0;

  delAsc = (alpha > pre(aSav[1]));
  delDesc = (alpha < pre(bSav[1]));
  del = delAsc or delDesc or evInit;

  init = (abs(alpha) >= pre(hmax)) and time>=2*t1;

  evInit = init and not pre(init);

  when init3 or (change(asc) and pre(init)) then
    hmax = if init3 then hmaxI else abs(Hstat);
  end when;

  //##### bSav #####
  when {init3, evAsc, del} then
    if init3 then
      bSav=cat(1,{bSavI},fill(-mat.Hsat,Count-1));
    elseif evAsc then
      bSav = if (alpha-eps)>pre(bSav[1]) then cat(1,{alpha},pre(bSav[1:end-1])) else pre(bSav);
    elseif del then
      bSav = cat(1,pre(bSav[2:end]),{-mat.Hsat});
    else
      bSav = pre(bSav);
    end if;
  end when;

  //##### REINIT aSav #####
  when {init3, evDesc, del} then
    if init3 then
      aSav=cat(1,{aSavI},fill(mat.Hsat,Count-1));
    elseif evDesc then
      aSav = if (alpha+eps)<pre(aSav[1]) then cat(1,{alpha},pre(aSav[1:end-1])) else pre(aSav);
    elseif del then
      aSav = cat(1,pre(aSav[2:end]),{mat.Hsat});
    else
      aSav = pre(aSav);
    end if;
  end when;

  // #### beta ####
  when {init3, change(asc), evInit, del} then
    reinit(beta, if init3 then bI elseif change(asc) then alpha elseif evInit then -alpha elseif asc then bSav[1] else aSav[1]);
  end when;

  H1= -beta-mat.Hc;
  H2= alpha-mat.Hc;
  H3= -alpha-mat.Hc;
  H4= beta-mat.Hc;

  E = unitT*
      ((mat.M*mat.r*(2/pi*atan(mat.q*H1)+1)+(2*mat.M*(1-mat.r))/(1+1/2*(exp(-mat.p1*H1)+exp(-mat.p2*H1))))*
      (mat.M*mat.r*(2/pi*atan(mat.q*H2)+1)+(2*mat.M*(1-mat.r))/(1+1/2*(exp(-mat.p1*H2)+exp(-mat.p2*H2))))-
      (mat.M*mat.r*(2/pi*atan(mat.q*H3)+1)+(2*mat.M*(1-mat.r))/(1+1/2*(exp(-mat.p1*H3)+exp(-mat.p2*H3))))*
      (mat.M*mat.r*(2/pi*atan(mat.q*H4)+1)+(2*mat.M*(1-mat.r))/(1+1/2*(exp(-mat.p1*H4)+exp(-mat.p2*H4)))));

  der(J) = (if init then 0.5 else 1) * der(E);
  B = J + mu0 * Hstat;

  annotation (defaultComponentName="core", Icon(graphics={Text(
          extent={{40,0},{40,-30}},
          textColor={255,128,0},
          textString="PE")}),
    Documentation(info="<html>
<p>
Flux tube element for modeling magnetic materials with ferromagnetic and dynamic hysteresis (eddy currents). The ferromagnetic hysteresis behavior is defined by the
<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis.Preisach\">Preisach hysteresis model</a>. The Shape of the limiting ferromagnetic hysteresis loop is specified by an analytical description of the Everett function. A library of predefined parameter sets can be found in <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HysteresisEverettParameter\">FluxTubes.Material.HysteresisEverettParameter</a>.
</p>

<p>
An overview over all available hysteresis and permanent magnet elements of the package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets\">HysteresisAndMagnets</a> can be found in <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis\">UsersGuide.Hysteresis</a>.
</p>

</html>"));
end GenericHystPreisachEverett;
