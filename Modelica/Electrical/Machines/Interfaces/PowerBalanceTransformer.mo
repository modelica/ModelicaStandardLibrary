within Modelica.Electrical.Machines.Interfaces;
record PowerBalanceTransformer "Power balance of transformers"
  extends Modelica.Icons.Record;
  SI.Power power1 "Primary power";
  SI.Power power2 "Secondary power";
  SI.Power lossPowerTotal=lossPower1 + lossPower2 +
      lossPowerCore "Total loss power";
  SI.Power lossPower1 "Primary copper losses";
  SI.Power lossPower2 "Secondary copper losses";
  SI.Power lossPowerCore "Core losses";
  annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Power balance of transformers.
 </html>"));
end PowerBalanceTransformer;
