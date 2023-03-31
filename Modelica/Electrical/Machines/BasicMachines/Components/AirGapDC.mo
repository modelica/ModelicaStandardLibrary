within Modelica.Electrical.Machines.BasicMachines.Components;
model AirGapDC "Airgap model of a DC machine"
  extends PartialAirGapDC;

  import Modelica.Constants.pi;
  import Modelica.Constants.eps;
  import Modelica.Constants.small;
  import Modelica.Math.atan;
  import Modelica.Units.SI;

  parameter Boolean considerSaturation=false "Consider saturation of excitation inductance"
    annotation (Dialog(tab="Inductance"), choices(checkBox=true));
  parameter SI.Inductance Le "Excitation inductance" annotation (Dialog(tab="Inductance", group="Linear",
      enable=not considerSaturation));
  parameter SI.Current Inom(start=1) "Nominal current" annotation(Dialog(tab="Inductance",
      groupImage="modelica://Modelica/Resources/Images/Electrical/Analog/Basic/SaturatingInductor_Lact_i_tight.png",
      group="Saturating",
      enable=considerSaturation));
  parameter SI.Inductance Lnom(start=1) "Nominal inductance at Nominal current" annotation (Dialog(tab="Inductance",
      group="Saturating",
      enable=considerSaturation));
  parameter SI.Inductance Lzer(start=2*Lnom) "Inductance near current=0" annotation (Dialog(tab="Inductance",
      group="Saturating",
      enable=considerSaturation));
  parameter SI.Inductance Linf(start=Lnom/2) "Inductance at large currents" annotation (Dialog(tab="Inductance",
      group="Saturating",
      enable=considerSaturation));

  SI.Inductance Lact(start=Lzer) "Present inductance";

protected
  parameter SI.Current Ipar(start=Inom/10, fixed=false);
initial equation
  (Lnom - Linf)/(Lzer - Linf)=Ipar/Inom*(pi/2 - atan(Ipar/Inom));
equation
  if considerSaturation then
    assert(Lzer > Lnom*(1 + eps), "Lzer (= " + String(Lzer) +
      ") has to be > Lnom (= " + String(Lnom) + ")");
    assert(Linf < Lnom*(1 - eps), "Linf (= " + String(Linf) +
      ") has to be < Lnom (= " + String(Lnom) + ")");
    Lact = Linf + (Lzer - Linf)*(if noEvent(abs(ie)/Ipar<small) then 1 else atan(ie/Ipar)/(ie/Ipar));
    // excitation flux: saturating with excitation current by atan function
    psi_e = Linf*ie + (Lzer - Linf)*Ipar*atan(ie/Ipar);
  else
    // excitation flux: linearly dependent on excitation current
    Lact = Le;
    psi_e = Le*ie;
  end if;
  annotation (
    defaultComponentName="airGap",
    Documentation(info="<html>
<h4>Linear correlation (considerSaturation=false)</h4>
<p>Linear model of the airgap (without saturation effects) of a DC machine, using only equations.</p><p>Induced excitation voltage is calculated from der(flux), where flux is defined by excitation inductance times excitation current.</p><p>Induced armature voltage is calculated from flux times angular velocity. </p>
<h4>With saturation (considerSaturation=true)</h4>
<p>The magnetic flux cannot rise infinitely with the excitation current.</p>
<p>For values above nominal current, the saturation mechanism from <a href=\"modelica://Modelica.Electrical.Analog.Basic.SaturatingInductor\">SaturatingInductor</a> is implemented.</p>
</html>"));
end AirGapDC;
