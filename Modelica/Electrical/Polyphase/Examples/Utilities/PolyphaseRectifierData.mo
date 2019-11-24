within Modelica.Electrical.Polyphase.Examples.Utilities;
record PolyphaseRectifierData "Data record for polyphase rectifier"
  extends Icons.Record;
  import Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems;
  import Modelica.Electrical.Polyphase.Examples.Utilities.Connection;
  parameter Integer m(final min=2)=6 "Number of phases";
  parameter Integer mSystems=numberOfSymmetricBaseSystems(m)
    "Number of base systems"
    annotation(Dialog(enable=false));
  parameter Integer mBasic=integer(m/mSystems)
    "Number of phases per base system"
    annotation(Dialog(enable=false));
  final parameter Integer kPolygon=max(1, integer((mBasic - 1)/2))
    "Alternative of largest polygon voltage";
  parameter Connection connection=Connection.Series
    "Specify connection of subsystems in case of mSystems>1";
  parameter Modelica.SIunits.Voltage VrmsY=100 "RMS voltage line to starpoint";
  parameter Modelica.SIunits.Frequency f=50 "Source frequency";
  parameter Modelica.SIunits.Resistance RLoad=2*(if connection==Connection.Series then mSystems else 1/mSystems) "Load resistance";
  parameter Modelica.SIunits.Resistance RDC=1e-3 "DC resistance";
  parameter Modelica.SIunits.Inductance LDC=1e-5 "DC inductance";
  parameter Modelica.SIunits.Resistance RGnd=1e5 "Resistance to ground";
  annotation(defaultComponentPrefixes="parameter");
end PolyphaseRectifierData;
