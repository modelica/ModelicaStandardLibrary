within Modelica.Electrical.Machines.Interfaces;
record PowerBalanceTransformer "Power balance of transformers"
  extends Modelica.Icons.Record;
  Modelica.SIunits.Power power1 "Primary power";
  Modelica.SIunits.Power power2 "Secondary power";
  Modelica.SIunits.Power lossPowerTotal=lossPower1 + lossPower2 +
      lossPowerCore "Total loss power";
  Modelica.SIunits.Power lossPower1 "Primary copper losses";
  Modelica.SIunits.Power lossPower2 "Secondary copper losses";
  Modelica.SIunits.Power lossPowerCore "Core losses";
  annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Power balance of transformers.
 </html>"));
end PowerBalanceTransformer;
