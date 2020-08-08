~joePatternDLow = Pbind(
	\instrument, \joeSynth,
	\bufnum, Pxrand(~lowEnd, inf),
	\atk, 5,
	\sus, 5,
	\rel, 5,
	\dur, 7,
	\mix, 0.7,
	\room, 0.9,
	\amp, 0.25,
	\outbus, ~droneBus,
	\addAction, \addToHead
);

OSCdef(\cToD, { arg msg, time, addr, recvPort;


	//Free C to D detector synth
	~pitchDetCtoD.free;

	//Free Letter C Pattern
	~patternPlayer.stop;

	//Free Slow Chorus Synth
	~recSynth.set(\gate, 0);
	~pbSynth1.set(\gate, 0);
	~pbSynth2.set(\gate, 0);
	~pbSynth3.set(\gate, 0);

	~letterDFunc.value;

	~dToEListener.value;

	// disable B to C OSCdef
	OSCdef(\cToD).disable;

}, \tr);

OSCdef(\cToD).disable;

~letterDFunc = {
	"Letter D".postln;
	{~currentLetter.string_("D")}.defer;

	//Start Low Pattern
	~patternPlayer = ~joePatternDLow.play;

	//Start Slow Chorus
	t = Task({
		~recSynth = Synth(\recordBuf, [\bufnum: ~bufArrayBig[0]]);

		0.1.wait;

		~pbSynth1 = Synth(\playbackBuf, [
			\bufnum: ~bufArrayBig[0],
			\rate: 0.8,
			\mix: 0.75,
			\room: 0.85,
			\outbus: ~wetBus]);
		~pbSynth2 = Synth(\playbackBuf, [
			\bufnum: ~bufArrayBig[0],
			\rate: 0.85,
			\mix: 0.6,
			\room: 0.7,
			\outbus: ~wetBus]);
		~pbSynth3 = Synth(\playbackBuf, [
			\bufnum: ~bufArrayBig[0],
			\rate: 0.95,
			\mix: 0.45,
			\room: 0.6,
			\outbus: ~wetBus]);
	}).play;
};

~dToEListener = {
	//Start D to E Listener
	~pitchDetDtoE = Synth(\pitchDetective, [
		\tarFreq: 233, //Bb 3
		\id, 0
	]);

	//Start D to D OSC def
	OSCdef(\dToE).enable;
}

