within Modelica.Mechanics.MultiBody.Types;
type RealColor =
             Modelica.Icons.TypeReal[3] (each min=0, each max=255)
  "RGB representation of color as Real type"
  annotation (
    Dialog(colorSelector=true),
    choices(
      choice={0,0,0} "{0,0,0}       \"black\"",
      choice={155,0,0} "{155,0,0}     \"dark red\"",
      choice={255,0,0} "{255,0,0 }    \"red\"",
      choice={255,65,65} "{255,65,65}   \"light red\"",
      choice={0,128,0} "{0,128,0}     \"dark green\"",
      choice={0,180,0} "{0,180,0}     \"green\"",
      choice={0,230,0} "{0,230,0}     \"light green\"",
      choice={0,0,200} "{0,0,200}     \"dark blue\"",
      choice={0,0,255} "{0,0,255}     \"blue\"",
      choice={0,128,255} "{0,128,255}   \"light blue\"",
      choice={255,255,0} "{255,255,0}   \"yellow\"",
      choice={255,0,255} "{255,0,255}   \"pink\"",
      choice={100,100,100} "{100,100,100} \"dark grey\"",
      choice={155,155,155} "{155,155,155} \"grey\"",
      choice={255,255,255} "{255,255,255} \"white\""),
  Documentation(info="<html>
<p>
Type <strong>RealColor</strong> is a Real vector with 3 elements,
{r, g, b}, and specifies the color of a shape.
{r,g,b} are the \"red\", \"green\" and \"blue\" color parts.
Note, r, g and b are given in the range 0&nbsp;&hellip;&nbsp;255.
</p>
</html>"));
