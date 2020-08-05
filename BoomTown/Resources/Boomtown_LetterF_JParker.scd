OSCdef(\eToF, { arg msg, time, addr, recvPort;


	//Free D to E detector synth
	~pitchDetEtoF.free;

	//Free Letter E Pattern
	~patternPlayer.stop;

	~letterFFunc.value;

	~fToGListener.value;

	// disable E to F OSCdef
	OSCdef(\eToF).disable;

}, \tr);

OSCdef(\eToF).disable;

~letterFFunc = {
	"Letter F".postln;
	{~currentLetter.string_("F")}.defer;
	//Start Slow Chorus w/ Skip
	t = Task({
		~recSynth = Synth(\recordBuf, [\bufnum: ~bufArrayBig[0]]);

		0.1.wait;

		~pbSynth1 = Synth(\skipBuf, [
			\bufnum: ~bufArrayBig[0],
			\outbus: ~wetBus,
			\skipDens: 1,
			\skipDur: -0.5]);

		0.3.wait;

		~pbSynth2 = Synth(\skipBuf, [
			\bufnum: ~bufArrayBig[0],
			\outbus: ~wetBus,
			\skipDens: 1.5,
			\skipDur: -0.3
		]);

		0.3.wait;

		~pbSynth3 = Synth(\skipBuf, [
			\bufnum: ~bufArrayBig[0],
			\outbus: ~wetBus,
			\skipDens: 2,
			\skipDur: -0.2
		]);
	}).play;

};

~fToGListener = {
	//Start F to G Listener
	~pitchDetFtoG = Synth(\pitchDetective, [
		\tarFreq: 220, //A 3
		\id, 0
	]);

	//Start F to G OSC def
	OSCdef(\fToG).enable;
};