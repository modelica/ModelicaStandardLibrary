within Modelica.Clocked;
package WorkInProgress "Models that are under developmend and test models"
  package Incubate "Stuff that might be adapted and used at some future time"
    package TrueTime
      "Communication block and external C interface of TrueTime simulators."
    extends Clocked.WorkInProgress.Icons.PackageNotReady;
      package ExternalC
        "Implementation of TrueTime kernel and network simulators in external C-code"
        class Kernel "External C interface of kernel simulator"
        extends ExternalObject;
        encapsulated function constructor
            "Initialize simulated real-time kernel"
            import
              Modelica.Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Kernel;
          input Integer policy "Scheduling policy";
          input Integer numberOfTasks "Number of tasks";
          output Kernel kernelHandle "Handle to kernel simulator object";
          external "C" kernelHandle = Kernel_Init(policy, numberOfTasks);
          annotation (Include="#include \"./Extras/C-Sources/TrueTime/kernel.c\"");
        end constructor;

        encapsulated function destructor "Terminate simulated real-time kernel"
            import
              Modelica.Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Kernel;
          input Kernel kernelHandle "Handle to kernel simulator object";
          external "C" Kernel_Terminate(kernelHandle);
        end destructor;

          encapsulated function runKernel "Run the kernel simulator instance"
            import
              Modelica.Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Kernel;
            input Kernel kernelHandle "Handle to kernel simulator object";
            input Real currTime "Current time";
            external "C" runKernel(kernelHandle, currTime);
          end runKernel;

          encapsulated function getNextHitKernel
            "Get next event time for kernel simulator"
            import
              Modelica.Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Kernel;
            input Kernel kernelHandle "Handle to kernel simulator object";
            input Real currTime "Current time";
            output Real nextT "Next event time";
            external "C" nextT = getNextHitKernel(kernelHandle, currTime);
          end getNextHitKernel;

          encapsulated function getSchedule "Get the real-time task schedule"
            import
              Modelica.Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Kernel;
            input Kernel kernelHandle "Handle to kernel simulator object";
            input Integer numberOfTasks "Number of tasks";
            input Real currTime "Current time";
            output Real schedule[numberOfTasks] "Task schedule";
            external "C" getSchedule(kernelHandle, schedule, numberOfTasks);
          end getSchedule;

          encapsulated function createTask
            "Create a real-time kernel task (called during initialization)"
            import
              Modelica.Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Kernel;
            input Kernel kernelHandle "Handle to kernel simulator object";
            input Integer taskID "Task ID";
            input String taskName "Task name";
            input Real period "Task period";
            input Integer priority "Task priority";
            input Real deadline "Task (relative) deadline";
            input Real offset "Task offset";
            output Integer errNo "To indicate success";
            external "C" errNo = createTask(kernelHandle, taskID, taskName, period, priority, deadline, offset);
          end createTask;

          encapsulated function createJob
            "Create task instance for controller calculation"
            import
              Modelica.Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Kernel;
            input Kernel kernelHandle "Handle to kernel simulator object";
            input String taskName "Task name";
            input Real executionTimeCalculate "Time to calculate outputs";
            input Real executionTimeUpdate "Time to update states";
            input Real currTime "Current time";
            output Integer errNo "To indicate success";
            external "C" errNo = createJob(kernelHandle, taskName, executionTimeCalculate, executionTimeUpdate, currTime);
          end createJob;

          encapsulated function createJobNw
            "Create task instance for controller calculation and network transmission"
            import
              Modelica.Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Kernel;
            import
              Modelica.Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Network;
            input Kernel kernelHandle "Handle to kernel simulator object";
            input String taskName "Task name";
            input Real executionTimeCalculate "Time to calculate outputs";
            input Real executionTimeUpdate "Time to update states";
            input Network networkHandle "Handle to network simulator object";
            input Integer frameDataSize "Size of frame data";
            input Integer frameID "Frame ID";
            input Integer framePriority "Frame priority";
            input Real currTime "Current time";
            output Integer errNo "To indicate success";
            external "C" errNo = createJobNw(kernelHandle, taskName, executionTimeCalculate, executionTimeUpdate,
                                            networkHandle, frameDataSize, frameID, framePriority, currTime);
          end createJobNw;

        encapsulated function setControl "Set computed control signal for task"
            import
              Modelica.Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Kernel;
            input Kernel kernelHandle "Handle to kernel simulator object";
            input String taskName "Task name";
            input Real u "Control signal";
            input Real currTime "Current time";
            output Integer errNo "To indicate success";
            external "C" errNo = setControl(kernelHandle, taskName, u, currTime);
        end setControl;

        encapsulated function analogOut "Output calculated control signal"
            import
              Modelica.Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Kernel;
            input Kernel kernelHandle "Handle to kernel simulator object";
            input String taskName "Task name";
            input Real currTime "Current time";
            input Real u "Dummy input for correct incidence";
            output Real data "Output data";
            external "C" data = analogOut(kernelHandle, taskName, currTime);
        end analogOut;
        end Kernel;

        class Network "External C interface of network simulator"
        extends ExternalObject;
        encapsulated function constructor "Initialize simulated network bus"
            import
              Modelica.Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Network;
          input Real params[:] "General parameter vector";
          input Real schedule[:] "Schedule for TDMA";
          input Real systemmatrix[:,:] "System matrix for TTCAN";
          input Real statschedule[:] "Static schedule for FlexRay";
          input Real dymschedule[:] "Dynamic schedule for FlexRay";
          output Network networkHandle "Handle to network simulator object";
          external "C" networkHandle = Network_Init(params, size(params,1), schedule, size(schedule,1),
                                             systemmatrix, size(systemmatrix,1), size(systemmatrix,2),
                                             statschedule, size(statschedule,1),
                                             dymschedule, size(dymschedule,1));
          annotation (Include="#include \"./Extras/C-Sources/TrueTime/network.c\"");
        end constructor;

        encapsulated function destructor "Terminate simulated network bus"
            import
              Modelica.Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Network;
          input Network networkHandle "Handle to network simulator object";
          external "C" Network_Terminate(networkHandle);
        end destructor;

          encapsulated function runNetwork "Run the network simulator instance"
            import
              Modelica.Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Network;
            input Network networkHandle "Handle to network simulator object";
            input Real currTime "Current time";
            external "C" runNetwork(networkHandle, currTime);
          end runNetwork;

          encapsulated function getNextHitNetwork
            "Get next event time for network simulator"
            import
              Modelica.Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Network;
            input Network networkHandle "Handle to network simulator object";
            input Real currTime "Current time";
            output Real nextT "Next event time";
            external "C" nextT = getNextHitNetwork(networkHandle, currTime);
          end getNextHitNetwork;

          encapsulated function getNwSchedule "Get the network schedule"
            import
              Modelica.Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Network;
            input Network networkHandle "Handle to network simulator object";
            input Integer numberOfFrames "Number of frames";
            input Real currTime "Current time";
            output Real transmissionSchedule[numberOfFrames];
            external "C" getNwSchedule(networkHandle, transmissionSchedule, numberOfFrames);
          end getNwSchedule;

          encapsulated function transmitFrame "Transmit a network frame"
            import
              Modelica.Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Network;
            input Network networkHandle "Handle to network simulator object";
            input Integer frameID "Frame identifier";
            input Real data "Frame data";
            input Integer frameSize "Frame size (bits)";
            input Integer framePriority "Frame priority";
            input Real currTime "Current time";
            output Integer errNo "To indicate success";
            external "C" errNo = transmitFrame(networkHandle, frameID, frameID, data, frameSize, framePriority, currTime);
          end transmitFrame;

        encapsulated function receiveFrame "Receive a network frame"
            import
              Modelica.Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Network;
            input Network networkHandle "Handle to network simulator object";
            input Integer frameID "Frame identifier";
            input Real currTime "Current time";
            input Real u "Dummy input for correct incidence";
            output Real data "Received data";
            external "C" data = receiveFrame(networkHandle, frameID, currTime);
        end receiveFrame;
        end Network;
      end ExternalC;

      type SchedulingPolicyEnum = enumeration(
          prioFP "Fixed-priority scheduling",
          prioRM "Rate-monotonic scheduling",
          prioDM "Deadline-monotonic scheduling",
          prioEDF "Earliest-deadline-first scheduling")
        "Enumeration to define scheduling policies";
      type MacPolicyEnum = enumeration(
          Ethernet,
          CAN,
          TDMA,
          TTCAN,
          FlexRay) "Enumeration to define Media Access Control policies";
      block ControllerTask "Truetime simulation: Controller task"
      extends Clocked.WorkInProgress.Icons.CommunicationIcon;
        parameter String taskName = "DefaultTask" "Task name" annotation (Dialog(group="Controller task parameters"));
        parameter Real executionTimeCalculate = 0.002
          "Execution time to calculate outputs"                                             annotation (Dialog(group="Controller task parameters"));
        parameter Real executionTimeUpdate = -1
          "Execution time to update states"                                       annotation (Dialog(group="Controller task parameters"));
        parameter Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Kernel kernelHandle
          "Handle to kernel simulator object"
          annotation (Dialog(group="Kernel simulator"));
        Modelica.Blocks.Interfaces.RealInput u
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.RealOutput y
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        Modelica.Blocks.Interfaces.BooleanInput trigger annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-120})));
      protected
        Real err;
        Real set_ctrl;
      equation
        when trigger then
          err =
            Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Kernel.createJob(
                  kernelHandle,
                  taskName,
                  executionTimeCalculate,
                  executionTimeUpdate,
                  time);
        end when;
        set_ctrl =
          Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Kernel.setControl(
                kernelHandle,
                taskName,
                u,
                time);
        y = Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Kernel.analogOut(
                kernelHandle,
                taskName,
                time,
                u);
          annotation (
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})),
          Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},
                  {100,100}}), graphics={
              Text(
                extent={{-96,-72},{94,-92}},
                lineColor={0,0,255},
                textString="Controller task"),
              Text(
                extent={{-80,88},{78,70}},
                lineColor={0,0,255},
                textString="TrueTime simulation"),
              Rectangle(
                extent={{-72,34},{-46,20}},
                lineColor={0,0,255},
                fillColor={175,175,175},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-46,8},{-22,-6}},
                lineColor={255,0,0},
                fillColor={175,175,175},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-22,34},{-4,20}},
                lineColor={0,0,255},
                fillColor={175,175,175},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-4,-18},{26,-32}},
                lineColor={0,0,255},
                fillColor={175,175,175},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{26,8},{48,-6}},
                lineColor={255,0,0},
                fillColor={175,175,175},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{48,34},{68,20}},
                lineColor={0,0,255},
                fillColor={175,175,175},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-46,20},{-46,8}},
                pattern=LinePattern.Dot),
              Line(
                points={{-22,20},{-22,8}},
                pattern=LinePattern.Dot),
              Line(
                points={{-4,18},{-4,-18}},
                pattern=LinePattern.Dot),
              Line(
                points={{26,-6},{26,-18}},
                pattern=LinePattern.Dot),
              Line(
                points={{48,20},{48,8}},
                pattern=LinePattern.Dot),
              Line(
                points={{-80,-40},{76,-40}}),
              Line(
                points={{-80,-38},{-80,-42}}),
              Line(
                points={{76,-38},{84,-40},{76,-42},{76,-38}})}));
      end ControllerTask;

      block TransmitReceive "TrueTime simulation: Transmit/Receive"
      extends Clocked.WorkInProgress.Icons.CommunicationIcon;
        parameter Integer frameDataSize = 32 "Frame size (bits)" annotation (Dialog(group="Transmission parameters"));
        parameter Integer frameID = 1 "Frame ID (1,...,numberOfFrames)" annotation (Dialog(group="Transmission parameters"));
        parameter Integer framePriority = frameID
          "Priority of frame (for CAN and TTCAN)"                                     annotation (Dialog(group="Transmission parameters"));
        parameter Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Network networkHandle
          "Handle to network simulator object"
          annotation (Dialog(group="Network simulator"));
        Modelica.Blocks.Interfaces.RealInput u
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.RealOutput y
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        Modelica.Blocks.Interfaces.BooleanInput trigger annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-120})));
      protected
        Real err;
      equation
        when trigger then
          err =
            Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Network.transmitFrame(
                  networkHandle,
                  frameID,
                  u,
                  frameDataSize,
                  framePriority,
                  time);
        end when;
        y =
          Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Network.receiveFrame(
                networkHandle,
                frameID,
                time,
                u);
      annotation (
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})),
          Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,100}}),
                               graphics={
              Text(
                extent={{-96,-72},{94,-92}},
                lineColor={0,0,255},
                textString="Transmit-Receive"),
              Line(
                points={{-72,-2},{68,-2}},
                color={0,0,255}),
              Line(
                points={{-42,-28},{-42,-2}},
                color={255,0,0}),
              Rectangle(extent={{-58,-28},{-26,-52}}, lineColor={255,0,0},
                fillPattern=FillPattern.Solid,
                fillColor={215,215,215}),
              Rectangle(extent={{10,-28},{42,-52}}, lineColor={0,0,255},
                fillPattern=FillPattern.Solid,
                fillColor={215,215,215}),
              Line(
                points={{26,-28},{26,-2}},
                color={0,0,255}),
              Rectangle(extent={{-24,48},{8,24}}, lineColor={255,0,0},
                fillPattern=FillPattern.Solid,
                fillColor={215,215,215}),
              Line(
                points={{-8,-2},{-8,24}},
                color={255,0,0}),
              Line(
                points={{-42,-2},{-8,-2}},
                color={255,0,0}),
              Text(
                extent={{-80,88},{78,70}},
                lineColor={0,0,255},
                textString="TrueTime simulation"),
              Line(
                points={{-8,24},{-10,16},{-6,16},{-8,24}},
                color={255,0,0}),
              Line(
                points={{-42,-2},{-44,-10},{-40,-10},{-42,-2}},
                color={255,0,0})}));
      end TransmitReceive;

      block ControllerNode
        "TrueTime simulation: Controller task with network interface"
      extends Clocked.WorkInProgress.Icons.CommunicationIcon;
        parameter String taskName = "DefaultTask" "Task name" annotation (Dialog(group="Controller task parameters"));
        parameter Real executionTimeCalculate = 0.002
          "Execution time to calculate outputs"                                             annotation (Dialog(group="Controller task parameters"));
        parameter Real executionTimeUpdate = -1
          "Execution time to update states"                                       annotation (Dialog(group="Controller task parameters"));
        parameter Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Kernel kernelHandle
          "Handle to kernel simulator object"
          annotation (Dialog(group="Kernel simulator"));
        parameter Integer frameDataSize = 32 "Frame size (bits)" annotation (Dialog(group="Transmission parameters"));
        parameter Integer frameID = 1 "Frame ID (1,...,numberOfFrames)" annotation (Dialog(group="Transmission parameters"));
        parameter Integer framePriority = frameID
          "Priority of frame (for CAN and TTCAN)"                                     annotation (Dialog(group="Transmission parameters"));
        parameter Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Network networkHandle
          "Handle to network simulator object"
          annotation (Dialog(group="Network simulator"));
        Modelica.Blocks.Interfaces.RealInput u
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.RealOutput y
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        Modelica.Blocks.Interfaces.BooleanInput trigger annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-120})));
      protected
        Real err;
        Real set_ctrl;
      equation
        when trigger then
          err =
            Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Kernel.createJobNw(
                  kernelHandle,
                  taskName,
                  executionTimeCalculate,
                  executionTimeUpdate,
                  networkHandle,
                  frameDataSize,
                  frameID,
                  framePriority,
                  time);
        end when;
        set_ctrl =
          Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Kernel.setControl(
                kernelHandle,
                taskName,
                u,
                time);
        y =
          Clocked.WorkInProgress.Incubate.TrueTime.ExternalC.Network.receiveFrame(
                networkHandle,
                frameID,
                time,
                u);
      annotation (
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})),
          Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},
                  {100,100}}), graphics={
              Text(
                extent={{-96,-72},{94,-92}},
                lineColor={0,0,255},
                textString="Controller node"),
              Text(
                extent={{-80,88},{78,70}},
                lineColor={0,0,255},
                textString="TrueTime simulation"),
              Rectangle(extent={{-28,48},{16,20}},lineColor={0,0,255},
                fillPattern=FillPattern.Solid,
                fillColor={215,215,215}),
              Line(
                points={{-70,-2},{70,-2}},
                color={0,0,255}),
              Line(
                points={{-40,-24},{-40,-2}},
                color={0,0,255}),
              Line(
                points={{-6,-2},{-6,20}},
                color={0,0,255}),
              Line(
                points={{28,-24},{28,-2}},
                color={0,0,255}),
              Rectangle(extent={{-60,-24},{-20,-52}},
                                                  lineColor={0,0,255},
                fillPattern=FillPattern.Solid,
                fillColor={215,215,215}),
              Rectangle(extent={{8,-24},{48,-52}},lineColor={0,0,255},
                fillPattern=FillPattern.Solid,
                fillColor={215,215,215}),
              Rectangle(
                extent={{-26,44},{-20,40}},
                lineColor={0,0,255},
                fillColor={175,175,175},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-20,36},{-14,32}},
                lineColor={255,0,0},
                fillColor={175,175,175},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-14,44},{-8,40}},
                lineColor={0,0,255},
                fillColor={175,175,175},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-8,28},{0,24}},
                lineColor={0,0,255},
                fillColor={175,175,175},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{0,36},{6,32}},
                lineColor={255,0,0},
                fillColor={175,175,175},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{6,44},{14,40}},
                lineColor={0,0,255},
                fillColor={175,175,175},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-20,40},{-20,36}},
                pattern=LinePattern.Dot),
              Line(
                points={{-14,40},{-14,36}},
                pattern=LinePattern.Dot),
              Line(
                points={{-8,40},{-8,28}},
                pattern=LinePattern.Dot),
              Line(
                points={{0,32},{0,28}},
                pattern=LinePattern.Dot),
              Line(
                points={{6,40},{6,36}},
                pattern=LinePattern.Dot)}));
      end ControllerNode;
    end TrueTime;

    package IntegerSignals
          block Limiter "Limit the range of a signal"
          extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;
            parameter Integer uMax(start=1) "Upper limits of input signals";
            parameter Integer uMin= -uMax "Lower limits of input signals";
            parameter Boolean limitsAtInit = true
          "= false, if limits are ignored during initializiation (i.e., y=u)";
            Modelica.Blocks.Interfaces.IntegerInput u
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
            Modelica.Blocks.Interfaces.IntegerOutput y
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
          equation
            assert(uMax >= uMin, "Limiter: Limits must be consistent. However, uMax (=" + String(uMax) +
                                 ") < uMin (=" + String(uMin) + ")");
            y = if u > uMax then uMax else if u < uMin then uMin else u;
            annotation (
              Documentation(info="
<HTML>
<p>
The Limiter block passes its input signal as output signal
as long as the input is within the specified upper and lower
limits. If this is not the case, the corresponding limits are passed
as output.
</p>
</HTML>
"),           Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics={
              Line(points={{0,-90},{0,68}}, color={192,192,192}),
              Polygon(
                points={{0,90},{-8,68},{8,68},{0,90}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-90,0},{68,0}}, color={192,192,192}),
              Polygon(
                points={{90,0},{68,-8},{68,8},{90,0}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,-70},{-50,-70},{50,70},{80,70}}),
              Text(
                extent={{-150,-150},{150,-110}},
                textString="uMax=%uMax"),
              Text(
                extent={{-150,150},{150,110}},
                textString="%name",
                lineColor={0,0,255})}),
              Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics={
              Line(points={{0,-60},{0,50}}, color={192,192,192}),
              Polygon(
                points={{0,60},{-5,50},{5,50},{0,60}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-60,0},{50,0}}, color={192,192,192}),
              Polygon(
                points={{60,0},{50,-5},{50,5},{60,0}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-50,-40},{-30,-40},{30,40},{50,40}}),
              Text(
                extent={{46,-6},{68,-18}},
                lineColor={128,128,128},
                textString="u"),
              Text(
                extent={{-30,70},{-5,50}},
                lineColor={128,128,128},
                textString="y"),
              Text(
                extent={{-58,-54},{-28,-42}},
                lineColor={128,128,128},
                textString="uMin"),
              Text(
                extent={{26,40},{66,56}},
                lineColor={128,128,128},
                textString="uMax")}));
          end Limiter;

      block ComputationalDelay
      extends Clocked.IntegerSignals.Interfaces.PartialClockedSISO;
        parameter Integer shiftCounter(min=0,max=resolution) = 0
          "(min=0, max=resolution), computational delay = interval()*shiftCounter/resolution"
                                                                                       annotation(Dialog(group="Computational delay in seconds = interval() * shiftCounter/resolution"));
        parameter Integer resolution(min=1) = 1
          "Time quantization resolution of sample interval" annotation(Dialog(group="Computational delay in seconds = interval() * shiftCounter/resolution"));
      protected
       Integer ubuf;
      equation
       assert(resolution >= shiftCounter, "The maximal computational delay has the length of one sample interval, however a larger value than that was set");
       ubuf = if shiftCounter == resolution then previous(u) else u;
       y = shiftSample(ubuf, shiftCounter, resolution);
        annotation (Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
                  -100},{100,100}})));
      end ComputationalDelay;

      block UniformNoise
        extends
          Clocked.WorkInProgress.Incubate.IntegerSignals.PartialIntegerNoise;
        parameter Integer noiseMin=-1 "Lower limit of noise band";
        parameter Integer noiseMax=1 "Upper limit of noise band";
        parameter Integer firstSeed[3](each min=0, each max=255) = {23,87,187}
          "Integer[3] defining random sequence; required element range: 0..255";
      protected
        Integer seedState[3] "State of seed" annotation(HideResult=true);
        Real noise "Noise in the range 0..1" annotation(HideResult=true);
      equation
        (noise,seedState) =
          Clocked.RealSignals.Sampler.Utilities.Internal.random(previous(
          seedState));
          y = u + noiseMin + integer((noiseMax - noiseMin)*noise + 0.5);
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})));
      end UniformNoise;

      block FractionalDelay
        "Delay clocked input signal for a fractional multiple of the sample period"
      extends Clocked.IntegerSignals.Interfaces.PartialClockedSISO;
        parameter Integer shift(min=0) = 0
          "Delay = interval() * shift/resolution";
        parameter Integer resolution(min=1) = 1
          "Time quantization resolution of sample interval";
        final parameter Integer n = div(shift,resolution);
      protected
        Integer u_buffer[n+1](each start=0)
          "The previous values of the inputs; u_last[1] = u, u_last[2] = previous(u_last[1]); u_last[3] = previous(u_last[2])";
        Boolean first(start=true) "Used to identify the first clock tick";
      equation
       first = false;
       u_buffer = if previous(first) then fill(u,n+1) else
         cat(1, {u}, previous(u_buffer[1:n]));
       y = shiftSample(u_buffer[n+1], shift, resolution);
        annotation (Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
                  -100},{100,100}})),
          Icon(graphics={
              Line(
                points={{-100,0},{-80,0},{-80,40},{-20,40},{-20,-40},{40,-40},{40,0},{
                    100,0}},
                color={215,215,215},
                pattern=LinePattern.Dot),
              Line(
                points={{-100,0},{-50,0},{-50,40},{10,40},{10,-40},{70,-40},{70,-0.3125},
                    {100,0}},
                pattern=LinePattern.Dot,
                color={255,128,0}),
              Text(
                extent={{4,-102},{4,-142}},
                textString="%shift/%resolution"),
              Ellipse(
                extent={{-90,50},{-70,30}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-30,-30},{-10,-50}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{30,10},{50,-10}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-60,50},{-40,30}},
                lineColor={255,128,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{0,-30},{20,-50}},
                lineColor={255,128,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{60,10},{80,-10}},
                lineColor={255,128,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid)}));
      end FractionalDelay;

      partial block PartialIntegerNoise
        "Interface for SISO blocks with Integer signals that add noise to the signal"
        extends Clocked.IntegerSignals.Interfaces.PartialClockedSISO;
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})));
      end PartialIntegerNoise;
    end IntegerSignals;

    package BooleanSignals
      block ComputationalDelay
      extends Clocked.BooleanSignals.Interfaces.PartialClockedSISO;
        parameter Integer shiftCounter(min=0,max=resolution) = 0
          "(min=0, max=resolution), computational delay = interval()*shiftCounter/resolution"
                                                                                       annotation(Dialog(group="Computational delay in seconds = interval() * shiftCounter/resolution"));
        parameter Integer resolution(min=1) = 1
          "Time quantization resolution of sample interval" annotation(Dialog(group="Computational delay in seconds = interval() * shiftCounter/resolution"));
      protected
       Boolean ubuf;
      equation
       assert(resolution >= shiftCounter, "The maximal computational delay has the length of one sample interval, however a larger value than that was set");
       ubuf = if shiftCounter == resolution then previous(u) else u;
       y = shiftSample(ubuf, shiftCounter, resolution);
        annotation (Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
                  -100},{100,100}})));
      end ComputationalDelay;

      block FractionalDelay
        "Delay clocked input signal for a fractional multiple of the sample period"
      extends Clocked.BooleanSignals.Interfaces.PartialClockedSISO;
        parameter Integer shift(min=0) = 0
          "Delay = interval() * shift/resolution";
        parameter Integer resolution(min=1) = 1
          "Time quantization resolution of sample interval";
        final parameter Integer n = div(shift,resolution);
      protected
        Boolean u_buffer[n+1](each start=false)
          "The previous values of the inputs; u_last[1] = u, u_last[2] = previous(u_last[1]); u_last[3] = previous(u_last[2])";
        Boolean first(start=true) "Used to identify the first clock tick";
      equation
       first = false;
       u_buffer = if previous(first) then fill(u,n+1) else
         cat(1, {u}, previous(u_buffer[1:n]));
       y = shiftSample(u_buffer[n+1], shift, resolution);
        annotation (Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
                  -100},{100,100}})),
          Icon(graphics={
              Line(
                points={{-100,0},{-80,0},{-80,40},{-20,40},{-20,-40},{40,-40},{40,0},{
                    100,0}},
                color={215,215,215},
                pattern=LinePattern.Dot),
              Line(
                points={{-100,0},{-50,0},{-50,40},{10,40},{10,-40},{70,-40},{70,-0.3125},
                    {100,0}},
                pattern=LinePattern.Dot,
                color={255,0,255}),
              Text(
                extent={{4,-102},{4,-142}},
                textString="%shift/%resolution"),
              Ellipse(
                extent={{-90,50},{-70,30}},
                lineColor={255,0,255},
                fillColor={255,0,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-30,-30},{-10,-50}},
                lineColor={255,0,255},
                fillColor={255,0,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{30,10},{50,-10}},
                lineColor={255,0,255},
                fillColor={255,0,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-60,50},{-40,30}},
                lineColor={255,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{0,-30},{20,-50}},
                lineColor={255,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{60,10},{80,-10}},
                lineColor={255,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid)}));
      end FractionalDelay;
    end BooleanSignals;

    package RealSignals
      block CommunicationDelaySpecifiedInSeconds
        "NOT VALID MODELICA 3.3! Might be nice to provide a block that allows to specify delay in seconds instead of indirectly as fractions of the current rate"
      extends Clocked.RealSignals.Interfaces.PartialClockedSISO;
      extends Clocked.WorkInProgress.Icons.BlockNotReady;
        parameter Modelica.SIunits.Time communicationDelayTime(min=0)=0
          "Time delay due to communication";
        /* Modelica 3.3 doesn't allow the following code since interval(..) has a non-parameter variability! */
      /* Statement as comment, in order that check does not produce an error
protected
  parameter Integer shiftSampleParam[2] = realDelay2shiftSampleParameters(communicationDelayTime, interval(u));
equation
  y = shiftSample(u, shiftSampleParam[1], shiftSampleParam[2]);
  */
      equation
        y = 0;
        annotation (Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
                  -100},{100,100}})));
      end CommunicationDelaySpecifiedInSeconds;

      function realDelay2shiftSampleParameters
        "Beta Warning: Function might be not robust for all kind of (seemingly) valid input"
        import Modelica.Utilities.Strings.*;
      input Real delay "Delay in seconds";
      input Real rate "Sample rate in seconds";
      output Integer param[2]
          "Arguments to shiftSample(..). param[1]: shiftCounter, param[2]: resolution";
      protected
        Integer index;
        Integer iDecPoint;
        Integer resolution;
        Integer shiftCounter;
        Real delayRateRatio = delay/rate;
        Real shift;
        String number = realString(delayRateRatio, 1, 10) "10 digits precision";
      algorithm
        // truncate all trailing zeros
        index := findLast(number, "0");
        while index == length(number) loop
          number := substring(number,1, length(number) -1);
          index := findLast(number, "0");
        end while;
        // Compute fitting resolution and shiftCounter
        iDecPoint :=findLast(number, ".");
        resolution := length(number) - iDecPoint;
        shift := delayRateRatio * 10^resolution;
        shiftCounter := integer(floor(shift + 0.5));
        param := {shiftCounter, resolution};
      end realDelay2shiftSampleParameters;
    end RealSignals;

    package Types
      type FIR_FilterType = enumeration(
          LowPass "Low pass filter",
          HighPass "High pass filter")
        "Enumeration defining the type of a FIR filter (high pass or low pass filter)"
          annotation (Evaluate=true, Documentation(info="<html>
</html>"));
      type FIR_Window = enumeration(
          Rectangle,
          Bartlett,
          Hann,
          Hamming,
          Blackman,
          Kaiser) "Enumeration defining the window type for a FIR filter"
          annotation (Evaluate=true, Documentation(info="<html>

</html>"));
    end Types;

    block PID "Discrete-time PID controller"
      extends Clocked.RealSignals.Interfaces.PartialClockedSISO;
      parameter Real k = 1 "Gain of PID controller";
      parameter Real Ti(min=Modelica.Constants.small) = 0.5
        "Time constant of integrator part";
      parameter Real Td(min=0) = 0.1 "Time constant of derivative part";
      parameter Real y_start=0 "Initial value of output"
        annotation (Dialog(group="Initialization"));
    protected
      Real u_pre(start=0);
      Real T = interval(u);
    equation
      when Clock() then
        u_pre = previous(u);
        y = previous(y) + k*( (1 + T/Ti + Td/T)*u - (1 + 2*Td/T)*u_pre + Td/T*previous(u_pre));
      end when;
      annotation (defaultComponentName="PI1",
           Icon(graphics={
            Polygon(
              points={{90,-82},{68,-74},{68,-90},{90,-82}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,-82},{82,-82}}, color={192,192,192}),
            Line(points={{-80,76},{-80,-92}}, color={192,192,192}),
            Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-80,-82},{-80,48},{-32,48},{-32,-10},{16,-10},{16,22},{64,22}},
              color={0,0,127},
              pattern=LinePattern.Dot),
            Text(
              extent={{-30,-4},{82,-58}},
              lineColor={192,192,192},
              textString="PID"),
            Ellipse(
              extent={{-39,-3},{-27,-15}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{9,28},{21,16}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{58,27},{70,15}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-87,55},{-75,43}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-140,-140},{140,-100}},
              textString="Ti=%Ti, Td=%Td"),
            Text(
              extent={{-140,60},{140,100}},
              textString="k=%k")}),
        Documentation(info="<html>
<p>
This block defines a text-book version of a discrete-time PID controller by the formula:
</p>
<pre>
// Transfer function form:
   G(z) = (b0*z^2 + b1*z + b2) / (z^2 - z);
   b0 = k*(1 + T/Ti + Td/T)
   b1 = -k*(1 + 2*Td/T)
   b2 = k*Td/T
</pre>
<p>
where k is the gain of the controller, Ti is the time constant of the integrative part, Td is the time constant of the derivative part, and T is the sample period.
</p>

<p>
This discrete-time form has been derived from the continuous-time
form of a PID controller by using the backward rectangular approximation (also called backward euler method or right-hand approximation) between the  s- and z- domain:
</p>
<pre>
   s = (z - 1)/(h*z)
</pre>
</html>"));
    end PID;

    model TestPIDController
      import Modelica_Synchronous =
             Modelica.Clocked;
     extends Modelica_Synchronous.WorkInProgress.Icons.OperatesOnlyPartially;
      Modelica_Synchronous.ClockSignals.Clocks.PeriodicRealClock
                               periodicRealClock(period=0.1)
        annotation (Placement(transformation(extent={{-36,-16},{-24,-4}})));
      Modelica_Synchronous.WorkInProgress.Incubate.PID
                               PI1
        annotation (Placement(transformation(extent={{28,0},{48,20}})));
      Modelica.Blocks.Sources.Step step(startTime=0.19)
        annotation (Placement(transformation(extent={{-82,0},{-62,20}})));
      Modelica_Synchronous.RealSignals.Sampler.SampleClocked        sample1
        annotation (Placement(transformation(extent={{-8,4},{4,16}})));
      Modelica_LinearSystems2.Controller.Sampler sampler(blockType=
            Modelica_LinearSystems2.Controller.Types.BlockTypeWithGlobalDefault.Discrete)
        annotation (Placement(transformation(extent={{-38,-60},{-18,-40}})));
      inner Modelica_LinearSystems2.Controller.SampleClock sampleClock(
        blockType=Modelica_LinearSystems2.Controller.Types.BlockType.Discrete,
        methodType=Modelica_LinearSystems2.Types.Method.ExplicitEuler,
        sampleTime=0.1)
        annotation (Placement(transformation(extent={{60,68},{80,88}})));
      Modelica_LinearSystems2.Controller.PID pID(
        Ti=0.5,
        Td=0.1,
        blockType=Modelica_LinearSystems2.Controller.Types.BlockTypeWithGlobalDefault.Discrete,
        pidRep=Modelica_LinearSystems2.Controller.Types.PID_representation.timeConstants,
        initType=Modelica_LinearSystems2.Controller.Types.InitWithGlobalDefault.NoInit,
        methodType=Modelica_LinearSystems2.Controller.Types.MethodWithGlobalDefault.ExplicitEuler,
        Nd=1) annotation (Placement(transformation(extent={{8,-60},{28,-40}})));
    equation
      connect(step.y, sample1.u) annotation (Line(
          points={{-61,10},{-9.2,10}},
          color={0,0,127}));
      connect(sample1.clock, periodicRealClock.y) annotation (Line(
          points={{-2,2.8},{-2,-10},{-23.4,-10}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sample1.y, PI1.u) annotation (Line(
          points={{4.6,10},{26,10}},
          color={0,0,127}));
      connect(sampler.u, step.y) annotation (Line(
          points={{-40,-50},{-48,-50},{-48,10},{-61,10}},
          color={0,0,127}));
      connect(sampler.y, pID.u) annotation (Line(
          points={{-17,-50},{6,-50}},
          color={0,0,127}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),
                          graphics={Text(
              extent={{-92,66},{96,18}},
              lineColor={0,0,255},
              textString="No direct comparison of PID blocks possible, since different discretization method used!
=> Hard to say whether clocked PID is \"correct\".")}));
    end TestPIDController;

    block FIRbyWindow
      "FIR filter defined by filter order, cut-off frequency and window-type"
      import Modelica_Synchronous =
             Modelica.Clocked;
      extends Modelica_Synchronous.RealSignals.Interfaces.PartialClockedSISO;
      parameter
        Modelica_Synchronous.WorkInProgress.Incubate.Types.FIR_FilterType
                                                      filterType=
          Modelica_Synchronous.WorkInProgress.Incubate.Types.FIR_FilterType.LowPass
        "Type of filter";
      parameter Integer order(min=1) = 2 "Order of filter";
      parameter Modelica.SIunits.Frequency f_cut=1 "Cut-off frequency";
      parameter Modelica_Synchronous.WorkInProgress.Incubate.Types.FIR_Window
                                                  window= Modelica_Synchronous.WorkInProgress.Incubate.Types.FIR_Window.Kaiser
        "Type of window";
      parameter Real beta=2.12 "Beta-Parameter for Kaiser-window"
          annotation(Dialog(enable = window == Modelica_Synchronous.Types.FIR_Window.Kaiser));
      final output Real a[order+1]=Modelica_Synchronous.WorkInProgress.Incubate.Internal.FIR_coefficients(
          filterType,
          order,
          f_cut,
          interval(u),
          window,
          beta);
      Modelica_Synchronous.RealSignals.Periodic.FIRbyCoefficients FIRbyCoefficients1(final a=a)
        annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
    equation
      connect(FIRbyCoefficients1.u, u)
                                      annotation (Line(
          points={{-22,0},{-120,0}},
          color={0,0,127}));
      connect(FIRbyCoefficients1.y, y)
                                      annotation (Line(
          points={{1,0},{110,0}},
          color={0,0,127}));
      annotation (defaultComponentName="FIR1",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
         Line(points={{-84,78},{-84,-90}}, color={192,192,192}),
        Polygon(points={{-84,90},{-92,68},{-76,68},{-84,90},{-84,90}}, lineColor={192,192,192}, fillColor={192,192,192},
                fillPattern =  FillPattern.Solid),
        Line(points={{-90,-82},{82,-82}}, color={192,192,192}),
        Polygon(points={{90,-82},{68,-74},{68,-90},{90,-82}}, lineColor={192,192,192}, fillColor={192,192,192},
                fillPattern = FillPattern.Solid),
        Line(points=[-84,30; -72,30; -52,28; -32,20; -26,16; -22,12; -18,6; -14,
                  -4; -4,-46; 0,-64; 2,-82], color={0,0,127}),
          Line(points=[2,-82; 4,-64; 8,-56; 12,-56; 16,-60; 18,-66; 20,-82], color={0,0,127}),
          Line(points=[20,-80; 20,-78; 20,-72; 22,-66; 24,-64; 28,-64; 32,-66; 34,
                  -70; 36,-78; 36,-82; 36,-74; 38,-68; 40,-66; 44,-66; 46,-68; 48,
                  -72; 50,-78; 50,-82; 50,-78; 52,-70; 54,-68; 58,-68; 62,-72; 64,
                  -76; 64,-78; 64,-80; 64,-82], color={0,0,127}),
          Rectangle(extent=[-84,-82; -18,4],
                lineColor={192,192,192}, fillColor={255,255,255},
                fillPattern=FillPattern.Backward),
            Text(
              extent={{-54,52},{100,14}},
              lineColor={192,192,192},
              textString="%order"),
            Text(
              extent={{-150,-110},{150,-150}},
              fillPattern=FillPattern.Solid,
              textString="f_cut=%f_cut"),
            Text(
              extent={{-32,92},{82,62}},
              lineColor={175,175,175},
              fillColor={255,255,255},
              fillPattern=FillPattern.Backward,
              textString="FIR")}),
        Documentation(info="<HTML>
<p>
This block computes the output y as a linear combination of the input u
and of its past values (= FIR filter):
</p>
<pre>
 y(i) = a[1]*u(i) + a[2]*u(i-1) + a[3]*u(i-2) + ...
</pre>
<p>
where y(i) and u(i) are the values of y and u at clock tick i and
a[:] are the filter coefficients. Contrary to block
<a href=\"modelica://Modelica_Synchronous.RealSignals.Periodic.FIRbyCoefficients\">FIRbyCoefficients</a>
this block computes the filter coefficients a[:] by design parameters
(filter order, cut-off frequency, filter window)
</p>
</HTML>
"));
    end FIRbyWindow;

    type SolverMethodSpecification =
                        String
      "Enumeration defining the integration method to solve differential equations in a clocked discretized continuous-time partition"
    annotation(choices(
       choice=" "
          "Do not use any solver (partition is forced to not contain differential equations)",
       choice="ExplicitEuler" "Explicit Euler method (order 1)",
       choice="ImplicitEuler" "Implicit Euler method (order 1)"));
    package Internal
      "Internal blocks and functions that are usually of no interest for the user"
      extends Modelica.Icons.InternalPackage;
      function FIR_coefficients
        "Calculates the FIR-filter coefficient vector from filter design parameters"
        import FilterType =
          Modelica.Clocked.WorkInProgress.Incubate.Types.FIR_FilterType;
        input Clocked.WorkInProgress.Incubate.Types.FIR_FilterType filterType=Clocked.WorkInProgress.Incubate.Types.FIR_FilterType.LowPass
          "Type of filter";
        input Integer order(min=1) = 2 "Order of filter";
        input Modelica.SIunits.Frequency f_cut=1 "Cut-off frequency";
        input Modelica.SIunits.Time Ts(min=0) "Sampling period";
        input Clocked.WorkInProgress.Incubate.Types.FIR_Window window=Clocked.WorkInProgress.Incubate.Types.FIR_Window.Rectangle
          "Type of window";
        input Real beta=2.12 "Beta-Parameter for Kaiser-window"
            annotation(Dialog(enable=window == Clocked.Types.Window.Kaiser));
        output Real a[order+1] "Filter coefficient vector";
      protected
        constant Real pi=Modelica.Constants.pi;
        Boolean isEven=mod(order,2)==0;
        Real Wc=2*pi*f_cut*Ts;
        Integer i;
        Real w[order + 1];
        Real k;
      algorithm
        assert(filterType == FilterType.LowPass or filterType == FilterType.HighPass and isEven,
               "High pass FIR filters must have an even order");
        assert(f_cut<=1/(2*Ts),"The cut-off frequency f_cut cannot be greater than half the sample frequency (Nyquist frequency),\n" +
                               "i.e. f_cut <= " + String(1/(2*Ts)) + " but is "+String(f_cut));
        w := FIR_window(
          order + 1,
          window,
          beta);
        for i in 1:order + 1 loop
           k := i - 1 - order/2;
           if i - 1 == order/2 then
              a[i] := if filterType == FilterType.LowPass then Wc*w[i]/pi else
                      w[i] - Wc*w[i]/pi;
           else
              a[i] := if filterType == FilterType.LowPass then sin(k*Wc)*
                      w[i]/(k*pi) else w[i]*(sin(k*pi) - sin(k*Wc))/(k*pi);
           end if;
        end for;
        // Scale coefficients, so that the sum is one
        a := a/sum(a);
        annotation (
          Documentation(info="<HTML>
<p>
The FIR-filter synthesis based on the window method. The coefficients are
calculated through a fourier series approximation of the desired amplitude
characteristic. Due to the fact that the Fourier series is truncated, there
will be discontinuities in the magnitude of the filter. Especial at the edge
of the filter the ripple is concentrated (Gibbs-effect). To counteract this,
the filter coefficients are convolved in the frequency domain with the spectrum
of a window function, thus smoothing the edge transitions at any discontinuity.
This convolution in the frequency domain is equivalent to multiplying the filter
coefficients with the window coefficients in the time domain.
</p>
<p>
The filter equation
<pre>
     y(k) = a0*u(k) + a1*u(k-1) + a2*u(k-2) + ... + an*u(k-n)
</pre>
implies that the function outputs n+1 coefficients for a n-th order filter. The
coefficients can be weightened with different kind of windows: Rectangle, Bartlett,
Hann, Hamming, Blackman, Kaiser <br>
The beta parameter is only needed by the Kaiser window.
</p>
</HTML>
"));
      end FIR_coefficients;

      function FIR_window
        "Calculation of n-point weighting window for FIR filter"
        import Window =
          Modelica.Clocked.WorkInProgress.Incubate.Types.FIR_Window;
        input Integer na "Number of points of weighting window vector";
        input Clocked.WorkInProgress.Incubate.Types.FIR_Window window=Window.Kaiser
          "Type of window";
        input Real beta=2.12 "Beta-Parameter for Kaiser-window";
        output Real a[na] "Weighting window vector a[na]";
      protected
        constant Real pi=Modelica.Constants.pi;
        Integer i=0;
        Real k;
      algorithm
        if window <> Window.Rectangle then
          for i in 1:na loop
            k := i - 1 - (na - 1)/2;
            if window == Window.Bartlett then
              a[i] := 1 - 2*abs(k)/(na - 1);
            elseif window == Window.Hann then
              a[i] := 0.5 + 0.5*cos(2*pi*k/(na - 1));
            elseif window == Window.Hamming then
              a[i] := 0.54 + 0.46*cos(2*pi*k/(na - 1));
            elseif window == Window.Blackman then
              a[i] := 0.42 + 0.5*cos(2*pi*k/(na - 1)) + 0.08*cos(4*pi*k/(na - 1));
            elseif window == Window.Kaiser then
              k := 2*beta*sqrt((i - 1)*(na - i))/(na - 1);
              a[i] := bessel0(k)/bessel0(beta);
            else
              Modelica.Utilities.Streams.error("window = " + String(window) + " not known");
            end if;
          end for;
        else
          a := ones(na);
        end if;
        annotation (
          Documentation(info="<HTML>
<p>
Weighting windows are used for digital filter design or spectrum estimation (e.g. DFT)
to increase the quality. In designing FIR-Filter the main role of windowing is to remove
non-ideal effects caused by the endless number of filter coefficients (Gibbs phenomenon).
Multiplying the coefficients with a window damps the coefficients at the beginning and at
the end.
</p>
<p>
The function outputs a L-point vector for a given kind of window. The parameter \"beta\" is
only needed by the Kaiser window. The types of windows are:
</p>
<OL>
<LI>Rectangle</LI>
<LI>Bartlett</LI>
<LI>Hann</LI>
<LI>Hamming</LI>
<LI>Blackman</LI>
<LI>Kaiser</LI>
</OL>
</HTML>
"));
      end FIR_window;

      function bessel0
        "Polynomial approximation of the zeroth order modified Bessel function"
        input Real x;
        output Real y;
      protected
        Real ax;
        Real a;
      algorithm
        ax := abs(x);
        if ax < 3.75 then
          a := (x/3.75)^2;
          y := 1 + a*(3.5156229 + a*(3.0899424 + a*(1.2067492 + a*(0.2659732 + a*
            (0.0360768 + a*0.0045813)))));
        else
          a := 3.75/ax;
          y := exp(ax)/sqrt(ax)*(0.39894228 + a*(0.01328592 + a*(0.00225319 + a*(
            -0.00157565 + a*(0.00916281 + a*(-0.02057706 + a*(0.02635537 + a*(-0.01647633
             + a*0.00392377))))))));
        end if;
        annotation (
          Documentation(info="<HTML>
<p>
Polynomial approximation of the zeroth order modified Bessel function.
The algorithm is taken from
</p>
<dl>
<dt>H. W. Press, S.A. Teukolsky, W. Vetterling:
<dd><b>Numerical Reciepes in C: The Art of Scientific Computing</b><br>
       Cambridge UP, 1988
</dl>
<p>
The function is used to calculate the Kaiser-window via
<i>calcWindow</i>.
</p>
<p><b>Release Notes:</b></p>
<ul>
<li><i>July 10, 2002</i>
       by Nico Walther<br>
       Realized.</li>
</ul>
</HTML>
"));
      end bessel0;
      annotation (Documentation(info="<html>
<p>
This package contains functions that are usually not directly be utilized
by a user.
</p>
</html>"));
    end Internal;
    annotation (preferredView="info", Documentation(info="<html>
</html>"));
  end Incubate;

  package Icons
    block DoesNotTranslate
      annotation (Icon(graphics={                   Text(
              extent={{-100,100},{100,-100}},
              lineColor={255,0,0},
              textString="!"),   Rectangle(extent={{-100,100},{100,-100}},
                                                                         lineColor=
                  {255,0,0})}));
    end DoesNotTranslate;

    block OperatesOnlyPartially
      annotation (Icon(graphics={Rectangle(extent={{-100,100},{100,-100}},
                                                                         lineColor=
                  {255,128,0}),                     Text(
              extent={{-100,100},{100,-100}},
              lineColor={255,128,0},
              textString="!")}));
    end OperatesOnlyPartially;

    partial package PackageNotReady
      annotation (Icon(graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={127,0,0},
              pattern=LinePattern.Dash,
              lineThickness=0.5)}));
    end PackageNotReady;

    partial block BlockNotReady
      annotation (Icon(graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={127,0,0},
              pattern=LinePattern.Dash,
              lineThickness=0.5)}));
    end BlockNotReady;

    partial block CommunicationIcon
      "Icon for a port block that communicates a signal"
      annotation (
           Icon(coordinateSystem(
                 preserveAspectRatio=true,
                 extent={{-100,-100},{100,100}},
                 initialScale=0.06), graphics={Rectangle(
              extent={{-100,-100},{100,100}},
              lineColor={0,0,127},
              fillColor={240,240,240},
              fillPattern=FillPattern.Solid,
              borderPattern=BorderPattern.Raised), Text(
              extent={{-150,110},{150,150}},
              lineColor={0,0,255},
              fillColor={85,85,255},
              fillPattern=FillPattern.Solid,
              textString="%name")}));
    end CommunicationIcon;
  end Icons;

  package Tests "Package that contains test"
    model TestFIR_1
      parameter Integer order=3;
      final parameter Real a[:]=fill(1/order,order);
      Clocked.RealSignals.Periodic.FIRbyCoefficients fIRbyCoefficients(a=a)
        annotation (Placement(transformation(extent={{-20,20},{0,40}})));
      Modelica.Blocks.Sources.Sine sine(freqHz=2,
        offset=0.1,
        startTime=0.1)
        annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
      Clocked.RealSignals.Sampler.SampleClocked sample1
        annotation (Placement(transformation(extent={{-44,24},{-32,36}})));
      Clocked.ClockSignals.Clocks.PeriodicRealClock periodicRealClock(period=
            0.01)
        annotation (Placement(transformation(extent={{-74,-14},{-62,-2}})));
    equation
      connect(sine.y, sample1.u) annotation (Line(
          points={{-59,30},{-45.2,30}},
          color={0,0,127}));
      connect(sample1.y, fIRbyCoefficients.u) annotation (Line(
          points={{-31.4,30},{-22,30}},
          color={0,0,127}));
      connect(periodicRealClock.y, sample1.clock) annotation (Line(
          points={{-61.4,-8},{-38,-8},{-38,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      annotation (experiment(StopTime=0.5));
    end TestFIR_1;

    model TestFIR
      extends Clocked.WorkInProgress.Icons.OperatesOnlyPartially;
      parameter Integer order=3;
      final parameter Real a[:]=fill(1/order,order);
      Clocked.RealSignals.Periodic.FIRbyCoefficients fIRbyCoefficients(a=a)
        annotation (Placement(transformation(extent={{-20,20},{0,40}})));
      Modelica.Blocks.Sources.Sine sine(freqHz=2,
        offset=0.1,
        startTime=0.1)
        annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
      Clocked.RealSignals.Sampler.SampleClocked sample1
        annotation (Placement(transformation(extent={{-44,24},{-32,36}})));
      Clocked.ClockSignals.Clocks.PeriodicRealClock periodicRealClock(period=
            0.01)
        annotation (Placement(transformation(extent={{-74,-14},{-62,-2}})));
      Modelica_LinearSystems2.Controller.FilterFIR filter(
        blockType=Modelica_LinearSystems2.Controller.Types.BlockTypeWithGlobalDefault.Discrete,
        specType=Modelica_LinearSystems2.Controller.Types.FIRspec.Coefficients,
        a=a,
        sampleFactor=1)
        annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
      inner Modelica_LinearSystems2.Controller.SampleClock sampleClock(blockType=
            Modelica_LinearSystems2.Controller.Types.BlockType.Discrete,
          sampleTime=0.01)
        annotation (Placement(transformation(extent={{40,-20},{60,0}})));
    equation
      connect(sine.y, sample1.u) annotation (Line(
          points={{-59,30},{-45.2,30}},
          color={0,0,127}));
      connect(sample1.y, fIRbyCoefficients.u) annotation (Line(
          points={{-31.4,30},{-22,30}},
          color={0,0,127}));
      connect(periodicRealClock.y, sample1.clock) annotation (Line(
          points={{-61.4,-8},{-38,-8},{-38,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sine.y, filter.u) annotation (Line(
          points={{-59,30},{-50,30},{-50,-30},{-22,-30}},
          color={0,0,127}));
      annotation (Diagram(graphics={Text(
              extent={{-94,88},{94,40}},
              lineColor={0,0,255},
              textString=
                  "Needs \"Evaluate Parameters\"=true in Translation settings in order to compile.")}),
          experiment(StopTime=0.5));
    end TestFIR;

    block TestFIR_Step
      extends Clocked.WorkInProgress.Icons.OperatesOnlyPartially;
      parameter Integer na=4;
      final parameter Real a[:]=fill(1/na,na);
      inner Modelica_LinearSystems2.Controller.SampleClock sampleClock(blockType=
            Modelica_LinearSystems2.Controller.Types.BlockType.Discrete, sampleTime=
           0.1)
        annotation (Placement(transformation(extent={{20,-34},{40,-14}})));
      Modelica_LinearSystems2.Controller.FilterFIR filter1(
        blockType=Modelica_LinearSystems2.Controller.Types.BlockTypeWithGlobalDefault.Discrete,
        specType=Modelica_LinearSystems2.Controller.Types.FIRspec.Coefficients,
        a=a,
        sampleFactor=1)
        annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
      Modelica.Blocks.Sources.Step step(startTime=0.4999, offset=0.5)
        annotation (Placement(transformation(extent={{-80,6},{-60,26}})));
      Clocked.RealSignals.Periodic.FIRbyCoefficients fIRbyCoefficients(a=a)
        annotation (Placement(transformation(extent={{-20,6},{0,26}})));
      Clocked.RealSignals.Sampler.SampleClocked sample1
        annotation (Placement(transformation(extent={{-44,10},{-32,22}})));
      Clocked.ClockSignals.Clocks.PeriodicRealClock periodicRealClock(period=
            0.1)
        annotation (Placement(transformation(extent={{-74,-40},{-62,-28}})));
      Modelica.Blocks.Sources.Step step1(                 offset=0.5, startTime=0.5)
        annotation (Placement(transformation(extent={{-80,-94},{-60,-74}})));
      Modelica_LinearSystems2.Controller.FilterFIR filter2(
        blockType=Modelica_LinearSystems2.Controller.Types.BlockTypeWithGlobalDefault.Discrete,
        specType=Modelica_LinearSystems2.Controller.Types.FIRspec.Coefficients,
        a=a,
        sampleFactor=1)
        annotation (Placement(transformation(extent={{-20,-94},{0,-74}})));
      Clocked.RealSignals.Periodic.MovingAverage movingAverage(n=na)
        annotation (Placement(transformation(extent={{-20,46},{0,66}})));
    equation
      connect(step.y,filter1. u) annotation (Line(
          points={{-59,16},{-52,16},{-52,-24},{-22,-24}},
          color={0,0,127}));
      connect(sample1.y,fIRbyCoefficients. u) annotation (Line(
          points={{-31.4,16},{-22,16}},
          color={0,0,127}));
      connect(periodicRealClock.y,sample1. clock) annotation (Line(
          points={{-61.4,-34},{-38,-34},{-38,8.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(step.y, sample1.u) annotation (Line(
          points={{-59,16},{-45.2,16}},
          color={0,0,127}));
      connect(step1.y, filter2.u) annotation (Line(
          points={{-59,-84},{-22,-84}},
          color={0,0,127}));
      connect(sample1.y, movingAverage.u) annotation (Line(
          points={{-31.4,16},{-30,16},{-30,56},{-22,56}},
          color={0,0,127}));
      annotation (Diagram(graphics={Text(
              extent={{-92,110},{96,62}},
              lineColor={0,0,255},
              textString=
                  "Needs \"Evaluate Parameters\"=true in Translation settings in order to compile.")}),
          experiment(StopTime=1.5));
    end TestFIR_Step;

    block TestFIR_Step2
      extends Clocked.WorkInProgress.Icons.OperatesOnlyPartially;
      inner Modelica_LinearSystems2.Controller.SampleClock sampleClock(blockType=
            Modelica_LinearSystems2.Controller.Types.BlockType.Discrete, sampleTime=
           0.1)
        annotation (Placement(transformation(extent={{20,0},{40,20}})));
      Modelica.Blocks.Sources.Step step(startTime=0.4999, offset=0.5)
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Clocked.RealSignals.Sampler.SampleClocked sample1
        annotation (Placement(transformation(extent={{-44,44},{-32,56}})));
      Clocked.ClockSignals.Clocks.PeriodicRealClock periodicRealClock(period=
            0.1)
        annotation (Placement(transformation(extent={{-62,-6},{-50,6}})));
      Modelica.Blocks.Sources.Step step1(                 offset=0.5, startTime=0.5)
        annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
      Modelica_LinearSystems2.Controller.FilterFIR filter2(
        blockType=Modelica_LinearSystems2.Controller.Types.BlockTypeWithGlobalDefault.Discrete,
        sampleFactor=1,
        specType=Modelica_LinearSystems2.Controller.Types.FIRspec.Window,
        f_cut=2,
        window=Modelica_LinearSystems2.Controller.Types.Window.Rectangle,
        order=3)
        annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
      Clocked.WorkInProgress.Incubate.FIRbyWindow FIR1(
        filterType=Clocked.WorkInProgress.Incubate.Types.FIR_FilterType.LowPass,

        f_cut=2,
        window=Clocked.WorkInProgress.Incubate.Types.FIR_Window.Rectangle,
        order=3)
        annotation (Placement(transformation(extent={{-20,40},{0,60}})));
    equation
      connect(periodicRealClock.y,sample1. clock) annotation (Line(
          points={{-49.4,0},{-38,0},{-38,42.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(step.y, sample1.u) annotation (Line(
          points={{-59,50},{-45.2,50}},
          color={0,0,127}));
      connect(step1.y, filter2.u) annotation (Line(
          points={{-59,-50},{-22,-50}},
          color={0,0,127}));
      connect(sample1.y, FIR1.u) annotation (Line(
          points={{-31.4,50},{-22,50}},
          color={0,0,127}));
      annotation (Diagram(graphics={Text(
              extent={{-94,106},{94,58}},
              lineColor={0,0,255},
              textString=
                  "Needs \"Evaluate Parameters\"=true in Translation settings in order to compile.")}),
          experiment(StopTime=1.5));
    end TestFIR_Step2;

    block TestFIR_Step2b
      extends Clocked.WorkInProgress.Icons.OperatesOnlyPartially;
      Modelica.Blocks.Sources.Step step(startTime=0.4999, offset=0.5)
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Clocked.RealSignals.Sampler.SampleClocked sample1
        annotation (Placement(transformation(extent={{-44,44},{-32,56}})));
      Clocked.ClockSignals.Clocks.PeriodicRealClock periodicRealClock(period=
            0.1)
        annotation (Placement(transformation(extent={{-62,-6},{-50,6}})));
      Clocked.WorkInProgress.Incubate.FIRbyWindow FIR1(
        filterType=Clocked.WorkInProgress.Incubate.Types.FIR_FilterType.LowPass,

        f_cut=2,
        window=Clocked.WorkInProgress.Incubate.Types.FIR_Window.Rectangle,
        order=3)
        annotation (Placement(transformation(extent={{-20,40},{0,60}})));
    equation
      connect(periodicRealClock.y,sample1. clock) annotation (Line(
          points={{-49.4,0},{-38,0},{-38,42.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(step.y, sample1.u) annotation (Line(
          points={{-59,50},{-45.2,50}},
          color={0,0,127}));
      connect(sample1.y, FIR1.u) annotation (Line(
          points={{-31.4,50},{-22,50}},
          color={0,0,127}));
      annotation (Diagram(graphics={Text(
              extent={{-90,106},{98,58}},
              lineColor={0,0,255},
              textString=
                  "Needs \"Evaluate Parameters\"=true in Translation settings in order to compile.")}),
          experiment(StopTime=1.5));
    end TestFIR_Step2b;

    model TestInterpolator
      Modelica.Blocks.Sources.Sine sine(freqHz=2,
        offset=0.1,
        startTime=0)
        annotation (Placement(transformation(extent={{-94,40},{-74,60}})));
      inner Modelica_LinearSystems2.Controller.SampleClock sampleClock(blockType=
            Modelica_LinearSystems2.Controller.Types.BlockType.Discrete,
          sampleTime=0.025)
        annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
      Clocked.RealSignals.Sampler.SampleClocked sample1
        annotation (Placement(transformation(extent={{-36,44},{-24,56}})));
      Clocked.ClockSignals.Clocks.PeriodicRealClock periodicRealClock(period=
            0.1)
        annotation (Placement(transformation(extent={{-50,-6},{-38,6}})));
      Modelica_LinearSystems2.Controller.Sampler sampler(sampleFactor=4)
        annotation (Placement(transformation(extent={{-42,-60},{-22,-40}})));
      Modelica_LinearSystems2.Controller.Interpolator ls_interpolator(
          inputSampleFactor=4, meanValueFilter=true)
        annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
      Clocked.RealSignals.Sampler.AssignClock assignClock1
        annotation (Placement(transformation(extent={{52,44},{64,56}})));
      Clocked.ClockSignals.Sampler.SuperSample superSample1(factor=4)
        annotation (Placement(transformation(extent={{6,-6},{18,6}})));
      Clocked.WorkInProgress.Interpolator interpolator1(
        factor=4,
        inferFactor=false,
        movingAverageFilter=false)
        annotation (Placement(transformation(extent={{2,44},{14,56}})));
      Clocked.WorkInProgress.Interpolator interpolator2(
        movingAverageFilter=true,
        factor=4,
        inferFactor=false)
        annotation (Placement(transformation(extent={{2,18},{14,30}})));
    equation
      connect(periodicRealClock.y,sample1. clock) annotation (Line(
          points={{-37.4,0},{-30,0},{-30,42.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sine.y, sample1.u) annotation (Line(
          points={{-73,50},{-37.2,50}},
          color={0,0,127}));
      connect(sampler.u, sine.y) annotation (Line(
          points={{-44,-50},{-73,-50},{-73,50}},
          color={0,0,127}));
      connect(sampler.y, ls_interpolator.u) annotation (Line(
          points={{-21,-50},{-2,-50}},
          color={0,0,127}));
      connect(superSample1.u, periodicRealClock.y) annotation (Line(
          points={{4.8,0},{-37.4,0}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(superSample1.y, assignClock1.clock) annotation (Line(
          points={{18.6,0},{58,0},{58,42.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sample1.y, interpolator1.u)
                                         annotation (Line(
          points={{-23.4,50},{0.8,50}},
          color={0,0,127}));
      connect(interpolator1.y, assignClock1.u)
                                              annotation (Line(
          points={{14.6,50},{50.8,50}},
          color={0,0,127}));
      connect(sample1.y, interpolator2.u) annotation (Line(
          points={{-23.4,50},{-12,50},{-12,24},{0.8,24}},
          color={0,0,127}));
      annotation (experiment(StopTime=0.6));
    end TestInterpolator;

    model TestUnitDelay
      Modelica.Blocks.Sources.Sine sine(freqHz=2,
        offset=0.1,
        startTime=0.15)
        annotation (Placement(transformation(extent={{-92,40},{-72,60}})));
      inner Modelica_LinearSystems2.Controller.SampleClock sampleClock(blockType=
            Modelica_LinearSystems2.Controller.Types.BlockType.Discrete,
          sampleTime=0.1)
        annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
      Clocked.RealSignals.Sampler.SampleClocked sample1
        annotation (Placement(transformation(extent={{-36,44},{-24,56}})));
      Clocked.ClockSignals.Clocks.PeriodicRealClock periodicRealClock(period=
            0.1)
        annotation (Placement(transformation(extent={{-50,-6},{-38,6}})));
      Modelica_LinearSystems2.Controller.Sampler sampler(sampleFactor=1)
        annotation (Placement(transformation(extent={{-42,-60},{-22,-40}})));
      Modelica_LinearSystems2.Controller.UnitDelay ls_unitDelay(blockType=
            Modelica_LinearSystems2.Controller.Types.BlockTypeWithGlobalDefault.Discrete)
        annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
      Clocked.RealSignals.NonPeriodic.UnitDelay UnitDelay1(y_start=0)
        annotation (Placement(transformation(extent={{0,40},{20,60}})));
    equation
      connect(periodicRealClock.y,sample1. clock) annotation (Line(
          points={{-37.4,0},{-30,0},{-30,42.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sine.y, sample1.u) annotation (Line(
          points={{-71,50},{-37.2,50}},
          color={0,0,127}));
      connect(sampler.u, sine.y) annotation (Line(
          points={{-44,-50},{-71,-50},{-71,50}},
          color={0,0,127}));
      connect(sampler.y, ls_unitDelay.u) annotation (Line(
          points={{-21,-50},{-2,-50}},
          color={0,0,127}));
      connect(sample1.y, UnitDelay1.u) annotation (Line(
          points={{-23.4,50},{-2,50}},
          color={0,0,127}));
      annotation (experiment(StopTime=1.2));
    end TestUnitDelay;

    model TestTransferFunction
      Modelica.Blocks.Sources.Sine sine(freqHz=2,
        offset=0.1,
        startTime=0)
        annotation (Placement(transformation(extent={{-92,40},{-72,60}})));
      Clocked.RealSignals.Sampler.SampleClocked sample1
        annotation (Placement(transformation(extent={{-18,44},{-6,56}})));
      Clocked.ClockSignals.Clocks.PeriodicRealClock periodicRealClock(period=
            0.1)
        annotation (Placement(transformation(extent={{-40,14},{-28,26}})));
      Modelica.Blocks.Discrete.Sampler sampler(samplePeriod=0.1)
        annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
      Modelica.Blocks.Discrete.TransferFunction transferFunction2(
        samplePeriod=0.1,
        a={1,0.5},
        b={0.1,0.2})
        annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
      Clocked.RealSignals.Periodic.TransferFunction transferFunction1(a={1,0.5},
          b={0.1,0.2})
        annotation (Placement(transformation(extent={{20,40},{40,60}})));
    equation
      connect(periodicRealClock.y,sample1. clock) annotation (Line(
          points={{-27.4,20},{-12,20},{-12,42.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sine.y, sample1.u) annotation (Line(
          points={{-71,50},{-19.2,50}},
          color={0,0,127}));
      connect(sampler.u, sine.y) annotation (Line(
          points={{-52,-30},{-64,-30},{-64,50},{-71,50}},
          color={0,0,127}));
      connect(sampler.y, transferFunction2.u)
                                             annotation (Line(
          points={{-29,-30},{-2,-30}},
          color={0,0,127}));
      connect(sample1.y, transferFunction1.u) annotation (Line(
          points={{-5.4,50},{18,50}},
          color={0,0,127}));
      annotation (experiment(StopTime=1.2));
    end TestTransferFunction;

    model TestStateSpace
      Modelica.Blocks.Sources.Sine sine(freqHz=2,
        offset=0.1,
        startTime=0)
        annotation (Placement(transformation(extent={{-92,40},{-72,60}})));
      Clocked.ClockSignals.Clocks.PeriodicRealClock periodicRealClock(period=
            0.1)
        annotation (Placement(transformation(extent={{-44,24},{-32,36}})));
      Clocked.RealSignals.Sampler.SampleClocked sample1
        annotation (Placement(transformation(extent={{-16,44},{-4,56}})));
      Modelica.Blocks.Discrete.StateSpace stateSpace2(
        samplePeriod=0.1,
        A=[1],
        B=[1],
        C=[1],
        D=[1],
        x(each start=0.0, each fixed=true))
               annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
      Modelica.Blocks.Discrete.Sampler sampler(samplePeriod=0.1)
        annotation (Placement(transformation(extent={{-44,-40},{-24,-20}})));
      Clocked.RealSignals.Periodic.StateSpace stateSpace1(
        A=[1],
        B=[1],
        C=[1],
        D=[1]) annotation (Placement(transformation(extent={{20,40},{40,60}})));
    equation
      connect(sine.y, sample1.u) annotation (Line(
          points={{-71,50},{-17.2,50}},
          color={0,0,127}));
      connect(periodicRealClock.y, sample1.clock) annotation (Line(
          points={{-31.4,30},{-10,30},{-10,42.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sampler.y,stateSpace2. u[1]) annotation (Line(
          points={{-23,-30},{-2,-30}},
          color={0,0,127}));
      connect(sampler.u, sine.y) annotation (Line(
          points={{-46,-30},{-62,-30},{-62,50},{-71,50}},
          color={0,0,127}));
      connect(sample1.y, stateSpace1.u[1])
                                          annotation (Line(
          points={{-3.4,50},{18,50}},
          color={0,0,127}));
      annotation (experiment(StopTime=1.2));
    end TestStateSpace;

    model TestRealSampler
      Modelica.Blocks.Sources.Sine sine1(
        freqHz=2,
        offset=0.1,
        startTime=0)
        annotation (Placement(transformation(extent={{-94,20},{-74,40}})));
      Modelica.Blocks.Sources.Sine sine2(
        offset=0.1,
        startTime=0,
        freqHz=3)
        annotation (Placement(transformation(extent={{-94,-20},{-74,0}})));
      Modelica.Blocks.Routing.Multiplex2 multiplex2_1
        annotation (Placement(transformation(extent={{-48,0},{-28,20}})));
      Clocked.ClockSignals.Clocks.PeriodicRealClock periodicClock1(period=0.1)
        annotation (Placement(transformation(extent={{-26,-36},{-14,-24}})));
      Clocked.RealSignals.Sampler.AssignClockVectorized assignClock1(n=2)
        annotation (Placement(transformation(extent={{10,4},{22,16}})));
      Modelica.Blocks.Math.Gain gain[2](k={2,3})
        annotation (Placement(transformation(extent={{40,0},{60,20}})));
      Clocked.RealSignals.Sampler.Sample sample1[2]
        annotation (Placement(transformation(extent={{-14,4},{-2,16}})));
      Clocked.RealSignals.Sampler.SampleVectorizedAndClocked sample2(n=2)
        annotation (Placement(transformation(extent={{-10,48},{2,60}})));
      Clocked.RealSignals.Sampler.SubSample subSample1[2](each inferFactor=
            false, each factor=3)
        annotation (Placement(transformation(extent={{14,48},{26,60}})));
    equation
      connect(sine1.y, multiplex2_1.u1[1]) annotation (Line(
          points={{-73,30},{-62,30},{-62,16},{-50,16}},
          color={0,0,127}));
      connect(sine2.y, multiplex2_1.u2[1]) annotation (Line(
          points={{-73,-10},{-62,-10},{-62,4},{-50,4}},
          color={0,0,127}));
      connect(periodicClock1.y, assignClock1.clock) annotation (Line(
          points={{-13.4,-30},{16,-30},{16,2.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(assignClock1.y, gain.u) annotation (Line(
          points={{22.6,10},{38,10}},
          color={0,0,127}));
      connect(multiplex2_1.y, sample1.u) annotation (Line(
          points={{-27,10},{-15.2,10}},
          color={0,0,127}));
      connect(sample1.y, assignClock1.u) annotation (Line(
          points={{-1.4,10},{4,10},{4,10},{8.8,10}},
          color={0,0,127}));
      connect(multiplex2_1.y, sample2.u) annotation (Line(
          points={{-27,10},{-24,10},{-24,54},{-11.2,54}},
          color={0,0,127}));
      connect(periodicClock1.y, sample2.clock) annotation (Line(
          points={{-13.4,-30},{2,-30},{2,38},{-4,38},{-4,46.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sample2.y, subSample1.u) annotation (Line(
          points={{2.6,54},{12.8,54}},
          color={0,0,127}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}})), experiment(StopTime=1.2));
    end TestRealSampler;

    model TestShiftSample
      Modelica.Blocks.Sources.Sine sine(freqHz=2,
        offset=0.1,
        startTime=0)
        annotation (Placement(transformation(extent={{-92,40},{-72,60}})));
      Clocked.ClockSignals.Clocks.PeriodicRealClock periodicRealClock(period=
            0.1)
        annotation (Placement(transformation(extent={{-84,-6},{-72,6}})));
      Clocked.RealSignals.Sampler.SampleClocked sample1
        annotation (Placement(transformation(extent={{-34,44},{-22,56}})));
      Clocked.RealSignals.Sampler.ShiftSample shiftSample1(shiftCounter=3,
          resolution=2)
        annotation (Placement(transformation(extent={{6,44},{18,56}})));
      Modelica.Blocks.Math.Add add
        annotation (Placement(transformation(extent={{40,20},{60,40}})));
      Clocked.RealSignals.Sampler.ShiftSample shiftSample2(shiftCounter=3,
          resolution=2)
        annotation (Placement(transformation(extent={{10,18},{22,30}})));
      Clocked.ClockSignals.Sampler.ShiftSample shiftSample3(shiftCounter=1,
          resolution=3)
        annotation (Placement(transformation(extent={{-54,-6},{-42,6}})));
    equation
      connect(sine.y, sample1.u) annotation (Line(
          points={{-71,50},{-35.2,50}},
          color={0,0,127}));
      connect(sample1.y, shiftSample1.u) annotation (Line(
          points={{-21.4,50},{4.8,50}},
          color={0,0,127}));
      connect(shiftSample1.y, add.u1) annotation (Line(
          points={{18.6,50},{28,50},{28,36},{38,36}},
          color={0,0,127}));
      connect(shiftSample2.y, add.u2) annotation (Line(
          points={{22.6,24},{38,24}},
          color={0,0,127}));
      connect(shiftSample2.u, sample1.y) annotation (Line(
          points={{8.8,24},{-6,24},{-6,50},{-21.4,50}},
          color={0,0,127}));
      connect(periodicRealClock.y, shiftSample3.u) annotation (Line(
          points={{-71.4,0},{-55.2,0}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(shiftSample3.y, sample1.clock) annotation (Line(
          points={{-41.4,0},{-28,0},{-28,42.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}})), experiment(StopTime=1.2));
    end TestShiftSample;

    model TestClockedRealToTrigger
      Modelica.Blocks.Sources.Sine sine(freqHz=2,
        offset=0.1,
        startTime=0)
        annotation (Placement(transformation(extent={{-92,20},{-72,40}})));
      Clocked.ClockSignals.Clocks.PeriodicRealClock periodicRealClock(period=
            0.1)
        annotation (Placement(transformation(extent={{-56,4},{-44,16}})));
      Clocked.RealSignals.Sampler.SampleClocked sample1
        annotation (Placement(transformation(extent={{-34,24},{-22,36}})));
      Clocked.RealSignals.Sampler.Utilities.AssignClockToTriggerHold ClockedRealToTrigger
        annotation (Placement(transformation(extent={{0,20},{20,40}})));
      Modelica.Blocks.Discrete.TriggeredSampler triggeredSampler
        annotation (Placement(transformation(extent={{40,60},{60,80}})));
    equation
      connect(sine.y, sample1.u) annotation (Line(
          points={{-71,30},{-35.2,30}},
          color={0,0,127}));
      connect(periodicRealClock.y, sample1.clock) annotation (Line(
          points={{-43.4,10},{-28,10},{-28,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sample1.y, ClockedRealToTrigger.u) annotation (Line(
          points={{-21.4,30},{-2,30}},
          color={0,0,127}));
      connect(triggeredSampler.u, sine.y) annotation (Line(
          points={{38,70},{-56,70},{-56,30},{-71,30}},
          color={0,0,127}));
      connect(ClockedRealToTrigger.y, triggeredSampler.trigger) annotation (Line(
          points={{21,30},{50,30},{50,58.2}},
          color={255,0,255}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}})),
        experiment(StopTime=1.2));
    end TestClockedRealToTrigger;

    model TestClockedBooleanToTrigger
      Clocked.ClockSignals.Clocks.PeriodicRealClock periodicRealClock(period=
            0.1)
        annotation (Placement(transformation(extent={{-56,4},{-44,16}})));
      Clocked.BooleanSignals.Sampler.SampleClocked sample1
        annotation (Placement(transformation(extent={{-34,24},{-22,36}})));
      Clocked.BooleanSignals.Sampler.Utilities.AssignClockToTriggerHold ClockedSignalToTrigger
        annotation (Placement(transformation(extent={{0,20},{20,40}})));
      Modelica.Blocks.Sources.BooleanPulse booleanPulse(period=0.2)
        annotation (Placement(transformation(extent={{-86,20},{-66,40}})));
      TriggeredBooleanSampler triggeredBooleanSampler
        annotation (Placement(transformation(extent={{34,56},{54,76}})));
    equation
      connect(periodicRealClock.y, sample1.clock) annotation (Line(
          points={{-43.4,10},{-28,10},{-28,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(booleanPulse.y, sample1.u) annotation (Line(
          points={{-65,30},{-35.2,30}},
          color={255,0,255}));
      connect(sample1.y, ClockedSignalToTrigger.u) annotation (Line(
          points={{-21.4,30},{-2,30}},
          color={255,0,255}));
      connect(ClockedSignalToTrigger.y, triggeredBooleanSampler.trigger)
        annotation (Line(
          points={{21,30},{44,30},{44,54.2}},
          color={255,0,255}));
      connect(booleanPulse.y, triggeredBooleanSampler.u) annotation (Line(
          points={{-65,30},{-54,30},{-54,66},{32,66}},
          color={255,0,255}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}})),
        experiment(StopTime=1.2));
    end TestClockedBooleanToTrigger;

    model TestClockedIntegerToTrigger
      Clocked.ClockSignals.Clocks.PeriodicRealClock periodicRealClock(period=
            0.1)
        annotation (Placement(transformation(extent={{-56,4},{-44,16}})));
      Clocked.IntegerSignals.Sampler.SampleClocked sample1
        annotation (Placement(transformation(extent={{-34,24},{-22,36}})));
      Clocked.IntegerSignals.Sampler.Utilities.AssignClockToTriggerHold ClockedSignalToTrigger
        annotation (Placement(transformation(extent={{0,20},{20,40}})));
      TriggeredIntegerSampler triggeredBooleanSampler
        annotation (Placement(transformation(extent={{34,56},{54,76}})));
      Modelica.Blocks.Sources.IntegerTable integerTable(table=[0,2; 0.2,3; 0.5,
            4; 0.9,-2; 1.1,5; 1.3,6])
        annotation (Placement(transformation(extent={{-88,20},{-68,40}})));
    equation
      connect(periodicRealClock.y, sample1.clock) annotation (Line(
          points={{-43.4,10},{-28,10},{-28,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(ClockedSignalToTrigger.y, triggeredBooleanSampler.trigger)
        annotation (Line(
          points={{21,30},{44,30},{44,54.2}},
          color={255,0,255}));
      connect(integerTable.y, sample1.u) annotation (Line(
          points={{-67,30},{-35.2,30}},
          color={255,127,0}));
      connect(integerTable.y, triggeredBooleanSampler.u) annotation (Line(
          points={{-67,30},{-52,30},{-52,66},{32,66}},
          color={255,127,0}));
      connect(sample1.y, ClockedSignalToTrigger.u) annotation (Line(
          points={{-21.4,30},{-2,30}},
          color={255,127,0}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}})),
        experiment(StopTime=1.2));
    end TestClockedIntegerToTrigger;

    model TestBackSample
      Modelica.Blocks.Sources.Sine sine(freqHz=2,
        offset=0.1,
        startTime=0)
        annotation (Placement(transformation(extent={{-92,40},{-72,60}})));
      Clocked.ClockSignals.Clocks.PeriodicRealClock periodicRealClock(period=
            0.1)
        annotation (Placement(transformation(extent={{-60,2},{-48,14}})));
      Clocked.RealSignals.Sampler.SampleClocked sample1
        annotation (Placement(transformation(extent={{-34,44},{-22,56}})));
      Clocked.RealSignals.Sampler.ShiftSample shiftSample1(resolution=2,
          shiftCounter=1)
        annotation (Placement(transformation(extent={{6,44},{18,56}})));
      Clocked.RealSignals.Sampler.BackSample backSample2(
        backCounter=1,
        resolution=2,
        y_start=0.1)
        annotation (Placement(transformation(extent={{34,44},{46,56}})));
      Modelica.Blocks.Math.Add add
        annotation (Placement(transformation(extent={{68,24},{88,44}})));
      Clocked.RealSignals.Sampler.BackSample backSample3(
        backCounter=1,
        y_start=0.3,
        resolution=2)
        annotation (Placement(transformation(extent={{34,10},{46,22}})));
    equation
      connect(sine.y, sample1.u) annotation (Line(
          points={{-71,50},{-35.2,50}},
          color={0,0,127}));
      connect(periodicRealClock.y, sample1.clock) annotation (Line(
          points={{-47.4,8},{-28,8},{-28,42.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sample1.y, shiftSample1.u) annotation (Line(
          points={{-21.4,50},{4.8,50}},
          color={0,0,127}));
      connect(backSample2.u, shiftSample1.y) annotation (Line(
          points={{32.8,50},{18.6,50}},
          color={0,0,127}));
      connect(backSample3.u, shiftSample1.y) annotation (Line(
          points={{32.8,16},{26,16},{26,50},{18.6,50}},
          color={0,0,127}));
      connect(backSample2.y, add.u1) annotation (Line(
          points={{46.6,50},{56,50},{56,40},{66,40}},
          color={0,0,127}));
      connect(backSample3.y, add.u2) annotation (Line(
          points={{46.6,16},{56,16},{56,28},{66,28}},
          color={0,0,127}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}})),
        experiment(StopTime=1.2));
    end TestBackSample;

    model TestClockedRealToSquare
      Modelica.Blocks.Sources.Sine sine(freqHz=2,
        offset=0.1,
        startTime=0)
        annotation (Placement(transformation(extent={{-92,40},{-72,60}})));
      Clocked.ClockSignals.Clocks.PeriodicRealClock periodicRealClock(period=
            0.1)
        annotation (Placement(transformation(extent={{-50,-6},{-38,6}})));
      Clocked.RealSignals.Sampler.SampleClocked sample1
        annotation (Placement(transformation(extent={{-34,44},{-22,56}})));
      Clocked.RealSignals.Sampler.Utilities.AssignClockToSquareWaveHold ClockedRealToSquare
        annotation (Placement(transformation(extent={{-4,40},{16,60}})));
    equation
      connect(sine.y, sample1.u) annotation (Line(
          points={{-71,50},{-35.2,50}},
          color={0,0,127}));
      connect(periodicRealClock.y, sample1.clock) annotation (Line(
          points={{-37.4,0},{-28,0},{-28,42.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sample1.y, ClockedRealToSquare.u) annotation (Line(
          points={{-21.4,50},{-6,50}},
          color={0,0,127}));
      annotation (experiment(StopTime=1.2));
    end TestClockedRealToSquare;

    model TestIntegerSamplerAndHolds
      Clocked.IntegerSignals.Sampler.AssignClock assignClock1
        annotation (Placement(transformation(extent={{-46,64},{-34,76}})));
      Clocked.ClockSignals.Clocks.PeriodicRealClock periodicRealClock(period=
            0.1)
        annotation (Placement(transformation(extent={{-88,-96},{-76,-84}})));
      Clocked.IntegerSignals.Sampler.Hold hold1
        annotation (Placement(transformation(extent={{-20,64},{-8,76}})));
      Modelica.Blocks.Sources.IntegerConstant integerConstant1(k=1)
        annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
      Clocked.IntegerSignals.Sampler.SampleClocked sample2
        annotation (Placement(transformation(extent={{-44,-16},{-32,-4}})));
      Clocked.IntegerSignals.Sampler.SampleVectorizedAndClocked sample1(n=3)
        annotation (Placement(transformation(extent={{-44,-54},{-32,-42}})));
      Modelica.Blocks.Sources.IntegerConstant integerConstant2[3](each k=1)
        annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
      Modelica.Blocks.Sources.IntegerConstant integerConstant3[3](each k=1)
        annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
      Clocked.IntegerSignals.Sampler.AssignClockVectorized assignClock2(n=3)
        annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
      Clocked.IntegerSignals.Sampler.SubSample subSample1(inferFactor=false,
          factor=2)
        annotation (Placement(transformation(extent={{-20,26},{-8,38}})));
      Clocked.IntegerSignals.Sampler.SuperSample superSample1(inferFactor=false,
          factor=2)
        annotation (Placement(transformation(extent={{12,26},{24,38}})));
      Clocked.IntegerSignals.Sampler.ShiftSample shiftSample1(shiftCounter=2,
          resolution=3)
        annotation (Placement(transformation(extent={{-16,-16},{-4,-4}})));
      Clocked.IntegerSignals.Sampler.BackSample backSample1(backCounter=2,
          resolution=3)
        annotation (Placement(transformation(extent={{8,-16},{20,-4}})));
      Modelica.Blocks.Sources.IntegerTable integerTable(table=[0,1; 0.2,3; 0.5,
            5; 0.9,2; 1.1,-1; 1.4,9])
        annotation (Placement(transformation(extent={{-98,60},{-78,80}})));
      Clocked.IntegerSignals.Sampler.Sample sample3
        annotation (Placement(transformation(extent={{-68,64},{-56,76}})));
      Clocked.IntegerSignals.Sampler.Utilities.UpSample upSample1(inferFactor=
            false, factor=2)
        annotation (Placement(transformation(extent={{36,106},{48,118}})));
      IntegerSignals.NonPeriodic.UnitDelay UnitDelay1(y_start=2)
        annotation (Placement(transformation(extent={{32,78},{52,98}})));
      IntegerSignals.NonPeriodic.FractionalDelay fractionalDelay(shift=2,
          resolution=3)
        annotation (Placement(transformation(extent={{34,46},{54,66}})));
      Clocked.IntegerSignals.Sampler.Utilities.AssignClockToSquareWaveHold ClockedSignalToSquare
        annotation (Placement(transformation(extent={{52,12},{72,32}})));
    equation
      connect(assignClock1.y, hold1.u) annotation (Line(
          points={{-33.4,70},{-21.2,70}},
          color={255,127,0}));
      connect(periodicRealClock.y, assignClock1.clock) annotation (Line(
          points={{-75.4,-90},{-28,-90},{-28,58},{-40,58},{-40,62.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sample2.u, integerConstant1.y) annotation (Line(
          points={{-45.2,-10},{-59,-10}},
          color={255,127,0}));
      connect(integerConstant2.y, sample1.u) annotation (Line(
          points={{-59,-50},{-52,-50},{-52,-48},{-45.2,-48}},
          color={255,127,0}));
      connect(periodicRealClock.y, sample1.clock) annotation (Line(
          points={{-75.4,-90},{-28,-90},{-28,-60},{-38,-60},{-38,-55.2}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sample2.clock, periodicRealClock.y) annotation (Line(
          points={{-38,-17.2},{-38,-24},{-28,-24},{-28,-90},{-75.4,-90}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(assignClock2.clock, periodicRealClock.y) annotation (Line(
          points={{-40,22.8},{-40,16},{-28,16},{-28,-90},{-75.4,-90}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(integerConstant3.y, assignClock2.u) annotation (Line(
          points={{-59,30},{-47.2,30}},
          color={255,127,0}));
      connect(subSample1.u, assignClock1.y) annotation (Line(
          points={{-21.2,32},{-26,32},{-26,70},{-33.4,70}},
          color={255,127,0}));
      connect(subSample1.y, superSample1.u) annotation (Line(
          points={{-7.4,32},{10.8,32}},
          color={255,127,0}));
      connect(sample2.y, shiftSample1.u) annotation (Line(
          points={{-31.4,-10},{-17.2,-10}},
          color={255,127,0}));
      connect(shiftSample1.y, backSample1.u) annotation (Line(
          points={{-3.4,-10},{6.8,-10}},
          color={255,127,0}));
      connect(integerTable.y, sample3.u) annotation (Line(
          points={{-77,70},{-69.2,70}},
          color={255,127,0}));
      connect(sample3.y, assignClock1.u) annotation (Line(
          points={{-55.4,70},{-47.2,70}},
          color={255,127,0}));
      connect(assignClock1.y, upSample1.u) annotation (Line(
          points={{-33.4,70},{-27.7,70},{-27.7,70},{-26,70},{-26,112},{34.8,112}},
          color={255,127,0}));
      connect(assignClock1.y, UnitDelay1.u) annotation (Line(
          points={{-33.4,70},{-26,70},{-26,88},{30,88}},
          color={255,127,0}));
      connect(fractionalDelay.u, assignClock1.y) annotation (Line(
          points={{32,56},{14,56},{14,88},{-26,88},{-26,70},{-33.4,70}},
          color={255,127,0}));
      connect(superSample1.y, ClockedSignalToSquare.u) annotation (Line(
          points={{24.6,32},{36,32},{36,22},{50,22}},
          color={255,127,0}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}})),
        experiment(StopTime=1.2));
    end TestIntegerSamplerAndHolds;

    model TestBooleanSamplerAndHolds
      Clocked.BooleanSignals.Sampler.AssignClock assignClock1
        annotation (Placement(transformation(extent={{-48,64},{-36,76}})));
      Clocked.ClockSignals.Clocks.PeriodicRealClock periodicRealClock(period=
            0.1)
        annotation (Placement(transformation(extent={{-88,-96},{-76,-84}})));
      Clocked.BooleanSignals.Sampler.Hold hold1
        annotation (Placement(transformation(extent={{-22,64},{-10,76}})));
      Clocked.BooleanSignals.Sampler.SampleClocked sample2
        annotation (Placement(transformation(extent={{-44,-16},{-32,-4}})));
      Clocked.BooleanSignals.Sampler.SampleVectorizedAndClocked sample1(n=3)
        annotation (Placement(transformation(extent={{-44,-54},{-32,-42}})));
      Clocked.BooleanSignals.Sampler.AssignClockVectorized assignClock2(n=3)
        annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
      Clocked.BooleanSignals.Sampler.SubSample subSample1(inferFactor=false,
          factor=2)
        annotation (Placement(transformation(extent={{-20,42},{-8,54}})));
      Clocked.BooleanSignals.Sampler.SuperSample superSample1(inferFactor=false,
          factor=2)
        annotation (Placement(transformation(extent={{12,42},{24,54}})));
      Clocked.BooleanSignals.Sampler.ShiftSample shiftSample1(shiftCounter=2,
          resolution=3)
        annotation (Placement(transformation(extent={{-16,-16},{-4,-4}})));
      Modelica.Blocks.Sources.BooleanPulse    booleanConstant(period=0.2)
        annotation (Placement(transformation(extent={{-96,60},{-76,80}})));
      Modelica.Blocks.Sources.BooleanConstant booleanConstant1[3]
        annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
      Modelica.Blocks.Sources.BooleanConstant booleanConstant2
        annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
      Modelica.Blocks.Sources.BooleanConstant booleanConstant3[3]
        annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
      Clocked.BooleanSignals.Sampler.Utilities.AssignClockToSquareWaveHold ClockedSignalToSquare
        annotation (Placement(transformation(extent={{20,-20},{40,0}})));
      Clocked.BooleanSignals.Sampler.Sample sample3
        annotation (Placement(transformation(extent={{-66,64},{-54,76}})));
      Clocked.BooleanSignals.Sampler.Utilities.UpSample upSample1(inferFactor=
            false, factor=2)
        annotation (Placement(transformation(extent={{16,88},{28,100}})));
      BooleanSignals.NonPeriodic.UnitDelay UnitDelay1
        annotation (Placement(transformation(extent={{52,88},{72,108}})));
      BooleanSignals.NonPeriodic.FractionalDelay fractionalDelay(shift=2,
          resolution=3)
        annotation (Placement(transformation(extent={{-14,100},{6,120}})));
      Clocked.BooleanSignals.Sampler.BackSample backSample1(backCounter=2,
          resolution=3)
        annotation (Placement(transformation(extent={{16,-44},{28,-32}})));
    equation
      connect(periodicRealClock.y, assignClock1.clock) annotation (Line(
          points={{-75.4,-90},{-28,-90},{-28,58},{-42,58},{-42,62.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(periodicRealClock.y, sample1.clock) annotation (Line(
          points={{-75.4,-90},{-28,-90},{-28,-60},{-38,-60},{-38,-55.2}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sample2.clock, periodicRealClock.y) annotation (Line(
          points={{-38,-17.2},{-38,-24},{-28,-24},{-28,-90},{-75.4,-90}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(assignClock2.clock, periodicRealClock.y) annotation (Line(
          points={{-40,22.8},{-40,16},{-28,16},{-28,-90},{-75.4,-90}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(assignClock2.u, booleanConstant1.y) annotation (Line(
          points={{-47.2,30},{-59,30}},
          color={255,0,255}));
      connect(sample2.u, booleanConstant2.y) annotation (Line(
          points={{-45.2,-10},{-59,-10}},
          color={255,0,255}));
      connect(sample1.u, booleanConstant3.y) annotation (Line(
          points={{-45.2,-48},{-52,-48},{-52,-50},{-59,-50}},
          color={255,0,255}));
      connect(shiftSample1.u, sample2.y) annotation (Line(
          points={{-17.2,-10},{-31.4,-10}},
          color={255,0,255}));
      connect(subSample1.u, assignClock1.y) annotation (Line(
          points={{-21.2,48},{-24,48},{-24,70},{-35.4,70}},
          color={255,0,255}));
      connect(hold1.u, assignClock1.y) annotation (Line(
          points={{-23.2,70},{-35.4,70}},
          color={255,0,255}));
      connect(superSample1.u, subSample1.y) annotation (Line(
          points={{10.8,48},{-7.4,48}},
          color={255,0,255}));
      connect(shiftSample1.y, ClockedSignalToSquare.u) annotation (Line(
          points={{-3.4,-10},{18,-10}},
          color={255,0,255}));
      connect(booleanConstant.y, sample3.u) annotation (Line(
          points={{-75,70},{-67.2,70}},
          color={255,0,255}));
      connect(sample3.y, assignClock1.u) annotation (Line(
          points={{-53.4,70},{-49.2,70}},
          color={255,0,255}));
      connect(assignClock1.y, upSample1.u) annotation (Line(
          points={{-35.4,70},{-26,70},{-26,94},{14.8,94}},
          color={255,0,255}));
      connect(upSample1.y, UnitDelay1.u) annotation (Line(
          points={{28.6,94},{32,94},{32,98},{50,98}},
          color={255,0,255}));
      connect(assignClock1.y, fractionalDelay.u) annotation (Line(
          points={{-35.4,70},{-26,70},{-26,110},{-16,110}},
          color={255,0,255}));
      connect(shiftSample1.y, backSample1.u) annotation (Line(
          points={{-3.4,-10},{0,-10},{0,-38},{14.8,-38}},
          color={255,0,255}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}})),
        experiment(StopTime=1.2));
    end TestBooleanSamplerAndHolds;

    model TestReplaceableSamplerHold
      "Using partial sample and hold blocks to allow redeclaration of blocks to simulated communication blocks"
     extends Modelica.Icons.Example;
      Modelica.Mechanics.Rotational.Components.Inertia load(J=10,
        phi(fixed=true, start=0),
        w(fixed=true, start=0))
        annotation (Placement(transformation(extent={{87,0},{107,20}})));
      Modelica.Mechanics.Rotational.Sensors.SpeedSensor speed       annotation (
         Placement(transformation(
            extent={{-10,-10},{6,6}},
            rotation=-90,
            origin={117,-15})));
      Modelica.Blocks.Sources.Ramp ramp(duration=2)
        annotation (Placement(transformation(extent={{-111,0},{-91,20}})));
      Modelica.Blocks.Math.Feedback feedback
        annotation (Placement(transformation(extent={{-43,0},{-23,20}})));
      Modelica.Mechanics.Rotational.Sources.Torque torque
        annotation (Placement(transformation(extent={{60,0},{80,20}})));
      Clocked.ClockSignals.Clocks.PeriodicRealClock periodicClock(period=0.1)
        annotation (Placement(transformation(extent={{-78,-72},{-58,-52}})));
      replaceable Clocked.RealSignals.Sampler.SampleWithADeffects sample2
        constrainedby Clocked.RealSignals.Interfaces.PartialSISOSampler(
        limited=true,
        quantized=true,
        yMax=10,
        bits=16)
        annotation (Placement(transformation(extent={{-68,4},{-56,16}})));
      replaceable Clocked.RealSignals.Sampler.HoldWithDAeffects hold1
        constrainedby Clocked.RealSignals.Interfaces.PartialSISOHold(
        computationalDelay=true,
        resolution=10,
        shiftCounter=2,
        limited=true,
        quantized=true,
        yMax=9.5,
        yMin=-9.5,
        bits=16) annotation (Placement(transformation(extent={{26,4},{38,16}})));
      replaceable Clocked.RealSignals.Sampler.SampleWithADeffects sample1
        constrainedby Clocked.RealSignals.Interfaces.PartialSISOSampler(noisy=
            true, noise(noiseMax=0.01))
        annotation (Placement(transformation(extent={{38,-36},{26,-24}})));
      Clocked.RealSignals.NonPeriodic.PI PI(
        x(fixed=true),
        T=0.1,
        k=110) annotation (Placement(transformation(extent={{-14,0},{6,20}})));
      Clocked.RealSignals.Sampler.AssignClock assignClock1
        annotation (Placement(transformation(extent={{8,-36},{-4,-24}})));
    equation
      connect(speed.flange, load.flange_b)       annotation (Line(
          points={{115,-5},{115,10},{107,10}}));
      connect(torque.flange, load.flange_a) annotation (Line(
          points={{80,10},{87,10}}));
      connect(ramp.y, sample2.u) annotation (Line(
          points={{-90,10},{-69.2,10}},
          color={0,0,127}));
      connect(sample2.y, feedback.u1) annotation (Line(
          points={{-55.4,10},{-41,10}},
          color={0,0,127}));
      connect(hold1.y, torque.tau) annotation (Line(
          points={{38.6,10},{58,10}},
          color={0,0,127}));
      connect(speed.w, sample1.u) annotation (Line(
          points={{115,-21.8},{115,-30},{39.2,-30}},
          color={0,0,127}));
      connect(feedback.y, PI.u) annotation (Line(
          points={{-24,10},{-16,10}},
          color={0,0,127}));
      connect(PI.y, hold1.u) annotation (Line(
          points={{7,10},{24.8,10}},
          color={0,0,127}));
      connect(sample1.y, assignClock1.u) annotation (Line(
          points={{25.4,-30},{9.2,-30}},
          color={0,0,127}));
      connect(assignClock1.y, feedback.u2) annotation (Line(
          points={{-4.6,-30},{-33,-30},{-33,2}},
          color={0,0,127}));
      connect(periodicClock.y, assignClock1.clock) annotation (Line(
          points={{-57,-62},{2,-62},{2,-37.2}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-140,-100},
                {140,100}},
            grid={2,2}), graphics={
            Text(
              extent={{-41,39},{9,33}},
              lineColor={255,0,0},
              textString="feedback controller"),
            Text(
              extent={{54,39},{104,33}},
              lineColor={255,0,0},
              textString="plant"),
            Rectangle(extent={{-120,40},{-80,-20}}, lineColor={255,0,0}),
            Text(
              extent={{-125,39},{-77,33}},
              lineColor={255,0,0},
              textString="reference"),
            Rectangle(extent={{-46,40},{14,-48}}, lineColor={255,0,0}),
            Rectangle(extent={{50,40},{132,-48}}, lineColor={255,0,0})}),
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2})),
        Documentation(info="<HTML>
</HTML>"),
        experiment(
          StopTime=5));
    end TestReplaceableSamplerHold;

    model TestSimulatedADC
      Modelica.Blocks.Sources.Sine sine(freqHz=2,
        offset=0.1,
        startTime=0)
        annotation (Placement(transformation(extent={{-92,40},{-72,60}})));
      Clocked.ClockSignals.Clocks.PeriodicRealClock periodicRealClock(period=
            0.1)
        annotation (Placement(transformation(extent={{-58,22},{-46,34}})));
      Clocked.RealSignals.Sampler.SampleWithADeffects sample1(
        noisy=true,
        limited=true,
        quantized=true,
        redeclare Clocked.RealSignals.Sampler.Utilities.Internal.UniformNoise
          noise)
        annotation (Placement(transformation(extent={{-44,44},{-32,56}})));
      Clocked.RealSignals.Sampler.AssignClock assignClock1
        annotation (Placement(transformation(extent={{-16,44},{-4,56}})));
      Clocked.RealSignals.Sampler.HoldWithDAeffects hold1(
        computationalDelay=true,
        shiftCounter=1,
        resolution=2,
        limited=true,
        quantized=true)
        annotation (Placement(transformation(extent={{10,44},{22,56}})));
      Clocked.RealSignals.Sampler.SampleWithADeffects sample2
        annotation (Placement(transformation(extent={{-44,68},{-32,80}})));
      Clocked.RealSignals.Sampler.AssignClock assignClock2
        annotation (Placement(transformation(extent={{-18,68},{-6,80}})));
    equation
      connect(sine.y, sample1.u) annotation (Line(
          points={{-71,50},{-45.2,50}},
          color={0,0,127}));
      connect(sample1.y, assignClock1.u) annotation (Line(
          points={{-31.4,50},{-17.2,50}},
          color={0,0,127}));
      connect(periodicRealClock.y, assignClock1.clock) annotation (Line(
          points={{-45.4,28},{-10,28},{-10,42.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(assignClock1.y, hold1.u) annotation (Line(
          points={{-3.4,50},{8.8,50}},
          color={0,0,127}));
      connect(sine.y, sample2.u) annotation (Line(
          points={{-71,50},{-52,50},{-52,74},{-45.2,74}},
          color={0,0,127}));
      connect(sample2.y, assignClock2.u) annotation (Line(
          points={{-31.4,74},{-19.2,74}},
          color={0,0,127}));
      connect(periodicRealClock.y, assignClock2.clock) annotation (Line(
          points={{-45.4,28},{44,28},{44,62},{-12,62},{-12,66.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}})), experiment(StopTime=1.2));
    end TestSimulatedADC;

    model TestCommunicationDelay
      Modelica.Blocks.Sources.Sine sine(freqHz=2,
        offset=0.1,
        startTime=0)
        annotation (Placement(transformation(extent={{-92,40},{-72,60}})));
      Clocked.ClockSignals.Clocks.PeriodicRealClock periodicRealClock(period=
            0.1)
        annotation (Placement(transformation(extent={{-66,18},{-54,30}})));
      Clocked.RealSignals.Sampler.SampleWithADeffects sample1
        annotation (Placement(transformation(extent={{-58,44},{-46,56}})));
      Clocked.RealSignals.Sampler.AssignClock assignClock1
        annotation (Placement(transformation(extent={{-30,44},{-18,56}})));
      Clocked.RealSignals.NonPeriodic.FractionalDelay fixedDelay(shift=3,
          resolution=2)
        annotation (Placement(transformation(extent={{-6,40},{14,60}})));
    equation
      connect(sine.y, sample1.u) annotation (Line(
          points={{-71,50},{-59.2,50}},
          color={0,0,127}));
      connect(sample1.y, assignClock1.u) annotation (Line(
          points={{-45.4,50},{-31.2,50}},
          color={0,0,127}));
      connect(periodicRealClock.y, assignClock1.clock) annotation (Line(
          points={{-53.4,24},{-24,24},{-24,42.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(assignClock1.y, fixedDelay.u) annotation (Line(
          points={{-17.4,50},{-8,50}},
          color={0,0,127}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}})), experiment(StopTime=1.2));
    end TestCommunicationDelay;

    model TestEventClockWithIntegrator
      Clocked.ClockSignals.Clocks.EventClock eventClock(useSolver=true,
          solverMethod="ExplicitEuler")
        annotation (Placement(transformation(extent={{-36,23},{-24,37}})));
      Modelica.Blocks.Sources.BooleanPulse booleanPulse(width=60, period=0.1)
        annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder(T=0.1, initType=Modelica.Blocks.Types.Init.InitialState)
        annotation (Placement(transformation(extent={{20,60},{40,80}})));
      Modelica.Blocks.Sources.Sine sine(freqHz=2)
        annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
      Clocked.RealSignals.Sampler.SampleClocked sample1
        annotation (Placement(transformation(extent={{-6,64},{6,76}})));
    equation
      connect(booleanPulse.y, eventClock.u) annotation (Line(
          points={{-59,30},{-37.2,30}},
          color={255,0,255}));
      connect(sine.y, sample1.u) annotation (Line(
          points={{-19,70},{-7.2,70}},
          color={0,0,127}));
      connect(sample1.y, firstOrder.u) annotation (Line(
          points={{6.6,70},{18,70}},
          color={0,0,127}));
      connect(eventClock.y, sample1.clock) annotation (Line(
          points={{-23.4,30},{0,30},{0,62.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}})), experiment(StopTime=1.2));
    end TestEventClockWithIntegrator;

    model TestExactClockWithIntegrator
      Modelica.Blocks.Continuous.FirstOrder firstOrder(
        initType=Modelica.Blocks.Types.Init.InitialState,
        y_start=0,
        T=1e-6)
        annotation (Placement(transformation(extent={{20,60},{40,80}})));
      Modelica.Blocks.Sources.Sine sine(freqHz=2e4)
        annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
      Clocked.RealSignals.Sampler.SampleClocked sample1
        annotation (Placement(transformation(extent={{-6,64},{6,76}})));
      Clocked.ClockSignals.Clocks.PeriodicExactClock periodicExactClock(
        useSolver=true,
        solverMethod="ExplicitEuler",
        resolution=Clocked.Types.Resolution.us,
        factor=2)
        annotation (Placement(transformation(extent={{-34,26},{-22,38}})));
    equation
      connect(sine.y, sample1.u) annotation (Line(
          points={{-19,70},{-7.2,70}},
          color={0,0,127}));
      connect(sample1.y, firstOrder.u) annotation (Line(
          points={{6.6,70},{18,70}},
          color={0,0,127}));
      connect(periodicExactClock.y, sample1.clock) annotation (Line(
          points={{-21.4,32},{0,32},{0,62.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})),
        experiment(StopTime=0.0001));
    end TestExactClockWithIntegrator;

    model TestSuperSampleClock
      parameter Integer factor=2 annotation(Evaluate=true);
      Clock c1;
      Clock c2;
    equation
      c1 = superSample(Clock(factor), 1000);
      c2 = superSample(Clock(factor), 1000*1000);
      annotation (experiment(StopTime=5e-005));
    end TestSuperSampleClock;

    block TriggeredBooleanSampler "Triggered sampling of continuous signals"
      extends Modelica.Blocks.Interfaces.DiscreteBlockIcon;
      parameter Boolean y_start=false "initial value of output signal";
      Modelica.Blocks.Interfaces.BooleanInput u
        "Connector with a Boolean input signal"             annotation (Placement(
            transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.BooleanOutput y
        "Connector with a Boolean output signal"             annotation (Placement(
            transformation(extent={{100,-10},{120,10}})));
      Modelica.Blocks.Interfaces.BooleanInput trigger annotation (Placement(
            transformation(
            origin={0,-118},
            extent={{-20,-20},{20,20}},
            rotation=90)));
    equation
      when trigger then
        y = u;
      end when;
    initial equation
      y = y_start;
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={
            Ellipse(
              extent={{-25,-10},{-45,10}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{45,-10},{25,10}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-100,0},{-45,0}}, color={0,0,127}),
            Line(points={{45,0},{100,0}}, color={0,0,127}),
            Line(points={{0,-100},{0,-26}}, color={255,0,255}),
            Line(points={{-35,0},{28,-48}}, color={0,0,127})}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Ellipse(
              extent={{-25,-10},{-45,10}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{45,-10},{25,10}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-100,0},{-45,0}}, color={0,0,255}),
            Line(points={{45,0},{100,0}}, color={0,0,255}),
            Line(points={{-35,0},{28,-48}}, color={0,0,255}),
            Line(points={{0,-100},{0,-26}}, color={255,0,255})}),
        Documentation(info="<HTML>
<p>
Samples the continuous input signal whenever the trigger input
signal is rising (i.e., trigger changes from <b>false</b> to
<b>true</b>) and provides the sampled input signal as output.
Before the first sampling, the output signal is equal to
the initial value defined via parameter <b>y0</b>.
</p>
</HTML>
"));
    end TriggeredBooleanSampler;

    block TriggeredIntegerSampler "Triggered sampling of continuous signals"
      extends Modelica.Blocks.Interfaces.DiscreteBlockIcon;
      parameter Integer y_start=0 "initial value of output signal";
      Modelica.Blocks.Interfaces.IntegerInput u
        "Connector with a Integer input signal"             annotation (Placement(
            transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.IntegerOutput y
        "Connector with a Integer output signal"             annotation (Placement(
            transformation(extent={{100,-10},{120,10}})));
      Modelica.Blocks.Interfaces.BooleanInput trigger annotation (Placement(
            transformation(
            origin={0,-118},
            extent={{-20,-20},{20,20}},
            rotation=90)));
    equation
      when trigger then
        y = u;
      end when;
    initial equation
      y = y_start;
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={
            Ellipse(
              extent={{-25,-10},{-45,10}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{45,-10},{25,10}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-100,0},{-45,0}}, color={0,0,127}),
            Line(points={{45,0},{100,0}}, color={0,0,127}),
            Line(points={{0,-100},{0,-26}}, color={255,0,255}),
            Line(points={{-35,0},{28,-48}}, color={0,0,127})}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Ellipse(
              extent={{-25,-10},{-45,10}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{45,-10},{25,10}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-100,0},{-45,0}}, color={0,0,255}),
            Line(points={{45,0},{100,0}}, color={0,0,255}),
            Line(points={{-35,0},{28,-48}}, color={0,0,255}),
            Line(points={{0,-100},{0,-26}}, color={255,0,255})}),
        Documentation(info="<HTML>
<p>
Samples the continuous input signal whenever the trigger input
signal is rising (i.e., trigger changes from <b>false</b> to
<b>true</b>) and provides the sampled input signal as output.
Before the first sampling, the output signal is equal to
the initial value defined via parameter <b>y0</b>.
</p>
</HTML>
"));
    end TriggeredIntegerSampler;

    model TestExactClockWithSolver
      Modelica.Blocks.Continuous.FirstOrder firstOrder(
        initType=Modelica.Blocks.Types.Init.InitialState,
        y_start=0,
        T=1)
        annotation (Placement(transformation(extent={{20,40},{40,60}})));
      Clocked.RealSignals.Sampler.SampleClocked sample1
        annotation (Placement(transformation(extent={{-6,56},{6,44}})));
      Clocked.ClockSignals.Clocks.PeriodicExactClock periodicExactClock(
        useSolver=true,
        resolution=Clocked.Types.Resolution.ms,
        factor=200,
        solverMethod="ImplicitEuler")
        annotation (Placement(transformation(extent={{-36,64},{-24,76}})));
      Modelica.Blocks.Sources.Step const(startTime=0.1)
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica_LinearSystems2.Controller.FirstOrder firstOrderCont(blockType=
            Modelica_LinearSystems2.Controller.Types.BlockTypeWithGlobalDefault.Continuous,
          initType=Modelica_LinearSystems2.Controller.Types.InitWithGlobalDefault.InitialState)
        annotation (Placement(transformation(extent={{20,0},{40,20}})));
      Modelica_LinearSystems2.Controller.FirstOrder firstOrderDiscretized(
          blockType=Modelica_LinearSystems2.Controller.Types.BlockTypeWithGlobalDefault.UseSampleClockOption)
        annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
      inner Modelica_LinearSystems2.Controller.SampleClock sampleClock(
        blockType=Modelica_LinearSystems2.Controller.Types.BlockType.Discrete,
        sampleTime=0.2,
        initType=Modelica_LinearSystems2.Controller.Types.Init.InitialState,
        methodType=Modelica_LinearSystems2.Types.Method.ImplicitEuler)
        annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
    equation
      connect(sample1.y, firstOrder.u) annotation (Line(
          points={{6.6,50},{18,50}},
          color={0,0,127}));
      connect(periodicExactClock.y, sample1.clock) annotation (Line(
          points={{-23.4,70},{0,70},{0,57.2}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(const.y, sample1.u) annotation (Line(
          points={{-59,50},{-7.2,50}},
          color={0,0,127}));
      connect(const.y, firstOrderCont.u) annotation (Line(
          points={{-59,50},{-40,50},{-40,10},{18,10}},
          color={0,0,127}));
      connect(const.y, firstOrderDiscretized.u) annotation (Line(
          points={{-59,50},{-40,50},{-40,-30},{18,-30}},
          color={0,0,127}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}})), experiment(StopTime=3));
    end TestExactClockWithSolver;

    package Effects "Examples demonstrating specific effects"
        extends Modelica.Icons.ExamplesPackage;
      model SuperSampling "Different ways to super sample a signal"
      extends Modelica.Icons.Example;
        parameter Integer factor=4 "Super sampling factor";
        Modelica.Blocks.Sources.Sine sine(freqHz=2,
          offset=0.1,
          startTime=0.0)
          annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
        Clocked.RealSignals.Sampler.SuperSample superSample1(inferFactor=false,
            factor=factor)
          annotation (Placement(transformation(extent={{24,34},{36,46}})));
        Clocked.RealSignals.Sampler.SampleClocked sample1
          annotation (Placement(transformation(extent={{-24,4},{-12,16}})));
        Clocked.ClockSignals.Clocks.PeriodicRealClock periodicRealClock(period=
              0.02)
          annotation (Placement(transformation(extent={{-54,-34},{-42,-22}})));
        Clocked.RealSignals.Sampler.Utilities.UpSample upSample1(inferFactor=
              false, factor=factor)
          annotation (Placement(transformation(extent={{22,4},{34,16}})));
        Clocked.RealSignals.Sampler.SuperSampleInterpolated superSampleIpo1(
            inferFactor=false, factor=factor)
          annotation (Placement(transformation(extent={{24,-26},{36,-14}})));
        Clocked.RealSignals.Periodic.MovingAverage movingAverage(n=factor)
          annotation (Placement(transformation(extent={{58,-30},{78,-10}})));
      equation
        connect(sine.y, sample1.u) annotation (Line(
            points={{-39,10},{-25.2,10}},
            color={0,0,127}));
        connect(periodicRealClock.y, sample1.clock) annotation (Line(
            points={{-41.4,-28},{-18,-28},{-18,2.8}},
            color={175,175,175},
            pattern=LinePattern.Dot,
            thickness=0.5));
        connect(sample1.y, superSample1.u) annotation (Line(
            points={{-11.4,10},{0,10},{0,40},{22.8,40}},
            color={0,0,127}));
        connect(sample1.y, upSample1.u)
                                       annotation (Line(
            points={{-11.4,10},{20.8,10}},
            color={0,0,127}));
        connect(sample1.y, superSampleIpo1.u)
                                           annotation (Line(
            points={{-11.4,10},{0,10},{0,-20},{22.8,-20}},
            color={0,0,127}));
        connect(superSampleIpo1.y, movingAverage.u) annotation (Line(
            points={{36.6,-20},{56,-20}},
            color={0,0,127}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})), experiment(StopTime=0.15));
      end SuperSampling;
    end Effects;
  end Tests;

  package ForDocumentation
    package RealSignals
    end RealSignals;

    model TheDifferentClocks
      Clocked.ClockSignals.Clocks.PeriodicRealClock periodicRealClock(period=
            0.01)
        annotation (Placement(transformation(extent={{-36,44},{-24,56}})));
      Clocked.ClockSignals.Clocks.PeriodicExactClock periodicExactClock(factor=10,
          resolution=Clocked.Types.Resolution.ms)
        annotation (Placement(transformation(extent={{-36,14},{-24,26}})));
      Clocked.ClockSignals.Clocks.EventClock eventClock
        annotation (Placement(transformation(extent={{-36,-16},{-24,-4}})));
      Modelica.Blocks.Sources.BooleanPulse booleanPulse(period=0.1)
        annotation (Placement(transformation(extent={{-96,-20},{-76,0}})));
      Clocked.ClockSignals.Interfaces.ClockOutput y1
        annotation (Placement(transformation(extent={{0,44},{12,56}})));
      Clocked.ClockSignals.Interfaces.ClockOutput y2
        annotation (Placement(transformation(extent={{0,14},{12,26}})));
      Clocked.ClockSignals.Interfaces.ClockOutput y3
        annotation (Placement(transformation(extent={{0,-16},{12,-4}})));
    equation
      connect(booleanPulse.y, eventClock.u) annotation (Line(
          points={{-75,-10},{-37.2,-10}},
          color={255,0,255}));
      connect(periodicRealClock.y, y1) annotation (Line(
          points={{-23.4,50},{6,50}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(periodicExactClock.y, y2) annotation (Line(
          points={{-23.4,20},{6,20}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(eventClock.y, y3) annotation (Line(
          points={{-23.4,-10},{6,-10}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}})), experiment(StopTime=1.2));
    end TheDifferentClocks;
  end ForDocumentation;

  block Interpolator
    "Super-sample the clocked Real input signal and provide it linearly interpolated and optionally filterd as clocked output signal"
    parameter Boolean inferFactor=true
      "= true, if super-sampling factor is inferred"  annotation(Evaluate=true, choices(checkBox=true));
    parameter Integer factor(min=1)=1
      "Super-sampling factor >= 1 (if inferFactor=false)"
                                                  annotation(Evaluate=true, Dialog(enable=not inferFactor));
    parameter Boolean movingAverageFilter = true
      "= true, linearly interpolated signal is filtered by moving average filter (current restriction: inferFactor and movingAverageFilter cannot be both true)"
      annotation(choices(checkBox=true));
    Modelica.Blocks.Interfaces.RealInput u
      "Connector of clocked, Real input signal"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealOutput y
      "Connector of clocked, Real output signal (clock of y is faster als clock of u)"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Clocked.RealSignals.Sampler.SuperSampleInterpolated superSampleIpo(final
        inferFactor=inferFactor, final factor=factor)
      annotation (Placement(transformation(extent={{-76,-6},{-64,6}})));
    Clocked.RealSignals.Periodic.MovingAverage movingAverage(final n=factor)
      if movingAverageFilter
      annotation (Placement(transformation(extent={{4,-10},{24,10}})));
  protected
    Modelica.Blocks.Interfaces.RealOutput y_aux if not movingAverageFilter
      "Dummy port, if no filtering desired"
      annotation (Placement(transformation(extent={{8,22},{28,42}})));
  equation
    assert(not (inferFactor and movingAverageFilter), "There is the current restriction that interFactor and movingAverageFilter\n"+
                                                      "cannot be both true");
    connect(u, superSampleIpo.u)  annotation (Line(
        points={{-120,0},{-77.2,0}},
        color={0,0,127}));
    connect(superSampleIpo.y, movingAverage.u)  annotation (Line(
        points={{-63.4,0},{2,0}},
        color={0,0,127}));
    connect(movingAverage.y, y) annotation (Line(
        points={{25,0},{110,0}},
        color={0,0,127}));
    connect(superSampleIpo.y, y_aux)  annotation (Line(
        points={{-63.4,0},{-16,0},{-16,32},{18,32}},
        color={0,0,127}));
    connect(y_aux, y) annotation (Line(
        points={{18,32},{40,32},{40,0},{110,0}},
        color={0,0,127}));
    annotation (Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2},
          initialScale=0.06),
          graphics={
          Rectangle(
            extent={{-88,86},{90,-72}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None),
          Line(
            points={{-100,0},{-80,0},{-80,-60},{0,-60},{0,80},{80,80},{80,0.078125},
                {100,0}},
            color={215,215,215},
            pattern=LinePattern.Dot),
          Text(
            extent={{-200,173},{200,108}},
            lineColor={0,0,255},
            textString="%name"), Line(points={{-100,0},{-40,-60},{-40,-60},{-40,-60},
                {0,12},{46,82},{46,82},{80,42},{100,0}},
                                   color={0,0,127},
            pattern=LinePattern.Dot),
          Ellipse(
            extent={{-55,-43},{-25,-73}},
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-83,-57},{-77,-63}},
            lineColor={0,0,127},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-3,83},{3,77}},
            lineColor={0,0,127},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{65,56},{95,26}},
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-16,26},{14,-4}},
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{32,96},{62,66}},
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{77,3},{83,-3}},
            lineColor={0,0,127},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid),
          Text(visible=not inferFactor,
            extent={{-200,-75},{200,-140}},
            textString="%factor"),
          Polygon(
            points={{25,0},{5,20},{5,10},{-25,10},{-25,-10},{5,-10},{5,-20},
                {25,0}},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid,
            lineColor={95,95,95},
            origin={-57,24},
            rotation=90)}),        Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-100,-100},{100,100}})));
  end Interpolator;
end WorkInProgress;
