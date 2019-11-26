within Modelica.Electrical.Polyphase.Examples.Utilities;
record PolyphaseRectifierData "Data record for polyphase rectifier"
  extends Icons.Record;
  import Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems;
  import Modelica.Math.isPowerOf2;
  parameter Integer m(final min=2)=6 "Number of phases";
  parameter Integer mSystems=numberOfSymmetricBaseSystems(m)
    "Number of base systems"
    annotation(Dialog(enable=false));
  parameter Integer mBasic=integer(m/mSystems)
    "Number of phases per base system"
    annotation(Dialog(enable=false));
  final parameter Integer kPolygon=max(1, integer((mBasic - 1)/2))
    "Alternative of largest polygon voltage";
  parameter Integer ParDesired(final min=1, final max=mSystems)=mSystems "Desired parallel subsystems";
  parameter Integer Par=if isPowerOf2(ParDesired) then ParDesired else mSystems "Parallel connected subsystems"
    annotation(Dialog(enable=false));
  parameter Integer Ser=integer(mSystems/Par) "Series connected subsystems"
    annotation(Dialog(enable=false));
  parameter Modelica.SIunits.Voltage VrmsY=100 "RMS voltage line to starpoint";
  parameter Modelica.SIunits.Frequency f=50 "Source frequency";
  parameter Modelica.SIunits.Resistance RLoad=2*Ser/Par "Load resistance";
  parameter Modelica.SIunits.Resistance RDC=1e-3 "DC resistance";
  parameter Modelica.SIunits.Inductance LDC=3e-3 "DC inductance";
  parameter Modelica.SIunits.Resistance RGnd=1e5 "Resistance to ground";
  annotation(defaultComponentPrefixes="parameter");
end PolyphaseRectifierData;
