(
s.waitForBoot({

	~bufArrayBig = Array.fill(10, {Buffer.alloc(s, s.sampleRate * 10, 1)});// Array of 10 10 second buffers
	~busArray1ch = Array.fill(10, {Bus.audio(s, 1)});// Array of ten one channel audio buses
	~busArray2ch = Array.fill(10, {Bus.audio(s, 2)});// Array of ten two channel audio buses

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




