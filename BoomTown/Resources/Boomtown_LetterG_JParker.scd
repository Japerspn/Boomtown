OSCdef(\fToG, { arg msg, time, addr, recvPort;

	//Free F to G detector synth
	~pitchDetFtoG.free;
	//Free Low G
	~lowG.set(\gate, 0);

	//Free Slow Chorus Synth
	~recSynth.set(\gate, 0);
	~pbSynth1.set(\gate, 0);
	~pbSynth2.set(\gate, 0);
	~pbSynth3.set(\gate, 0);

	~letterGFunc.value;

	// disable D to E OSCdef
	OSCdef(\eToF).disable;

}, \tr);

OSCdef(\eToF).disable;

~letterGFunc = {
	"Letter G".postln;
	{~currentLetter.string_("G")}.defer;
	//Start Delay
	~delay1 = Synth(\delay, [
		\inbus: 0,
		\outbus: ~wetBus,
		\del: 0.5,
		\rel: 10,
		\atk: 10,
		\mix: 0.5,
		\room: 0.9,
	]);

	//Start Delay
	~delay2 = Synth(\delay, [
		\inbus: 0,
		\outbus: ~wetBus,
		\del: 1,
		\rel: 10,
		\atk: 10,
		\mix: 0.6,
		\room: 0.9,
	]);

	//Start Delay
	~delay3 = Synth(\delay, [
		\inbus: 0,
		\outbus: ~wetBus,
		\del: 2,
		\rel: 10,
		\atk: 10,
		\mix: 0.7,
		\room: 0.9,
	]);

};
