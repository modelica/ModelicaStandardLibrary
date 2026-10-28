within Modelica.Mechanics.MultiBody.Visualizers.Advanced;
function selectMeshFile
  "Return the file name of a mesh with an extension that is supported by the tool"
  input String fileNameBase "Base part of a mesh file name (e.g. modelica://ModelicaTest/Resources/Data/Meshes/GlassHurricane_yUP)";
  input String extensions[:]={"glb","stl"} "Formats provided for the mesh";
  output String fileName "File name of the mesh, using the first extension supported by the tool";
algorithm
  for ext in extensions loop
      if ModelicaServices.Animation.supportsMeshFormat(ext) then
         fileName := fileNameBase + "." + ext;
         return;
      end if;
  end for;
  Modelica.Utilities.Streams.print("... Mesh \"" + fileNameBase + "\" is not visualized because\nthe tool does not support one of the provided mesh formats");
end selectMeshFile;
