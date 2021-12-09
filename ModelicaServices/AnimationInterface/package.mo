within ModelicaServices;

package AnimationInterface
  extends Icons.Package;
  partial model PartialShape "Interface for 3D animation of elementary shapes"
    parameter Types.ShapeType shapeType="box"
      "Type of shape (box, sphere, cylinder, pipecylinder, cone, pipe, beam, gearwheel, spring, <external shape>)";
    input Frames.Orientation R=Frames.nullRotation()
      "Orientation object to rotate the world frame into the object frame" annotation(Dialog);
    input Types.Position r[3]={0,0,0}
      "Position vector from origin of world frame to origin of object frame, resolved in world frame" annotation(Dialog);
    input Types.Position r_shape[3]={0,0,0}
      "Position vector from origin of object frame to shape origin, resolved in object frame" annotation(Dialog);
    input Real lengthDirection[3](each final unit="1")={1,0,0}
      "Vector in length direction, resolved in object frame" annotation(Dialog);
    input Real widthDirection[3](each final unit="1")={0,1,0}
      "Vector in width direction, resolved in object frame" annotation(Dialog);
    input Types.Length length=0 "Length of visual object" annotation(Dialog);
    input Types.Length width=0 "Width of visual object" annotation(Dialog);
    input Types.Length height=0 "Height of visual object" annotation(Dialog);
    input Types.ShapeExtra extra=0.0
      "Additional size data for some of the shape types" annotation(Dialog);
    input Real color[3]={255,0,0} "Color of shape" annotation(Dialog(colorSelector=true));
    input Types.SpecularCoefficient specularCoefficient = 0.7
      "Reflection of ambient light (= 0: light is completely absorbed)" annotation(Dialog);

    annotation (
      Documentation(info="<html>
<p>
This model is documented at
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape\">Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape</a>.
</p>
</html>"));

  end PartialShape;

  partial model PartialVector "Interface for 3D animation of a vector quantity (force, torque etc)"
    input Frames.Orientation R=Frames.nullRotation()
      "Orientation object to rotate the world frame into the vector frame" annotation(Dialog);
    input Types.Position r[3]={0,0,0}
      "Position vector from origin of world frame to origin of vector frame, resolved in world frame" annotation(Dialog);
    input Real coordinates[3]={0,0,0}
      "Coordinates of the vector resolved in vector frame" annotation(Dialog);
    input Types.Color color=Types.Defaults.ArrowColor
      "Color of vector" annotation(Dialog(colorSelector=true));
    input Types.SpecularCoefficient specularCoefficient = 0.7
      "Material property describing the reflecting of ambient light (= 0 means, that light is completely absorbed)" annotation(Dialog);
    parameter Types.VectorQuantity quantity = Types.VectorQuantity.Force "Quantity of the coordinates";
    input Boolean headAtOrigin=false "= true, if the vector is pointing towards the origin of vector frame" annotation(Dialog);
    input Boolean twoHeadedArrow=false "= true, if the arrow has two heads after each other (pointing in the same direction)" annotation(Dialog);

    annotation (
      Documentation(info="<html>
<p>
This model is documented at
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Vector\">Modelica.Mechanics.MultiBody.Visualizers.Advanced.Vector</a>.
</p>
</html>"));
  end PartialVector;

  partial model PartialSurface "Interface for 3D animation of surfaces"
    input Frames.Orientation R=Frames.nullRotation()
      "Orientation object to rotate the world frame into the surface frame"
      annotation(Dialog(group="Surface frame"));
    input Types.Position r_0[3]={0,0,0}
      "Position vector from origin of world frame to origin of surface frame, resolved in world frame"
      annotation(Dialog(group="Surface frame"));

    parameter Integer nu=2 "Number of points in u-Dimension" annotation(Dialog(group="Surface properties"));
    parameter Integer nv=2 "Number of points in v-Dimension" annotation(Dialog(group="Surface properties"));
    replaceable function surfaceCharacteristic =
      Modelica.Mechanics.MultiBody.Interfaces.partialSurfaceCharacteristic
      "Function defining the surface characteristic"
      annotation(choicesAllMatching=true,Dialog(group="Surface properties"));

    parameter Boolean wireframe=false "= true: 3D model will be displayed without faces"
      annotation (Dialog(group="Material properties"),choices(checkBox=true));
    parameter Boolean multiColoredSurface=false "= true: Color is defined for each surface point"
      annotation(Dialog(group="Material properties"),choices(checkBox=true));
    input Real color[3]={255,0,0} "Color of surface" annotation(Dialog(colorSelector=true,group="Material properties", enable=not multiColoredSurface));
    input Types.SpecularCoefficient specularCoefficient = 0.7
      "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation(Dialog(group="Material properties"));
    input Real transparency=0 "Transparency of shape: 0 (= opaque) ... 1 (= fully transparent)"
      annotation(Dialog(group="Material properties"));

    annotation (Documentation(info="<html>
<p>
This model is documented at
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface\">Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface</a>.
</p>
</html>"));
  end PartialSurface;
  annotation(
    preferredView="info",
    version="4.0.0",
    Documentation(info="<html>
AnimationInterface contains the interfaces of elements used to create animations in Modelica.
These interfaces are used by the Modelica Standard Library and ModelicaServices to ensure that both contain
the expected interface.
In ModelicaServices.Animation, the actual implementation may be extended to add communication with a Modelica tool in
order to for example visualize the model on the fly.
</html>")
  );
end AnimationInterface;
