(
s.waitForBoot({

	File(thisProcess.nowExecutingPath.dirname +/+ "Resources/121_Gui_JParker.scd", "r").readAllString.interpret;

	File(thisProcess.nowExecutingPath.dirname +/+ "Resources/121_Synths_JParker.scd", "r").readAllString.interpret;
});

if(s.serverRunning, {
	s.options.memSize_(2.pow(20));
	s.options.numOutputBusChannels_(4);
	s.reboot;
}, {s.options.memSize_(2.pow(20));
	s.options.numOutputBusChannels_(4);
	s.boot;


})

);



File(thisProcess.nowExecutingPath.dirname +/+ "121_Synths_JParker.scd", "r").readAllString.interpret;
thisProcess.nowExecutingPath.dirname



