within Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces;
expandable connector SubControlBus
  "Sub-control bus that is adapted to the signals connected to it"
  extends Modelica.Icons.SignalSubBus;
  Real myRealSignal annotation (HideResult=false);
  Boolean myBooleanSignal annotation (HideResult=false);
  annotation (
    defaultComponentPrefixes="protected",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Rectangle(
                  extent={{-20,2},{22,-2}},
                  lineColor={255,204,51},
                  lineThickness=0.5)}),
    Documentation(info="<html>
<p>
This connector defines the \"expandable connector\" SubControlBus that
is used as sub-bus in the
<a href=\"modelica://Modelica.Blocks.Examples.BusUsage\">BusUsage</a> example.
Note, this is an expandable connector which has a \"default\" set of
signals (the input/output causalities of the signals are
determined from the connections to this bus).
</p>
</html>"));

end SubControlBus;
