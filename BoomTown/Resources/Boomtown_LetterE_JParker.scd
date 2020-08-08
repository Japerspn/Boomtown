~joePatternE = Pbind(
	\instrument, \joeSynthSkip,
	\bufnum, Pxrand(~all, inf),
	\atk, 3,
	\sus, 2,
	\rel, 3,
	\dur, 1,
	\mix, 0.4,
	\room, 0.5,
	\amp, 0.1,
	\outbus, ~droneBus,
	\addAction, \addToHead
);

~joePatternELow = Pbind(
	\instrument, \joeSynth,
	\bufnum, Pxrand(~lowEnd, inf),
	\atk, 3,
	\sus, 1,
	\rel, 3,
	\dur, 2,
	\mix, 0.7,
	\room, 0.9,
	\amp, 0.1,
	\outbus, ~droneBus,
	\addAction, \addToHead
);



OSCdef(\dToE, { arg msg, time, addr, recvPort;

	//Free D to E detector synth
	~pitchDetDtoE.free;

	//Free Slow Chorus Synth
	~recSynth.set(\gate, 0);
	~pbSynth1.set(\gate, 0);
	~pbSynth2.set(\gate, 0);
	~pbSynth3.set(\gate, 0);

	//Stop Pattern
	~patternPlayer.stop;

	~letterEFunc.value;

	~eToFListener.value;

	// disable D to E OSCdef
	OSCdef(\dToE).disable;

}, \tr);

OSCdef(\dToE).disable;

~letterEFunc = {
	"Letter E".postln;
	{~currentLetter.string_("E")}.defer;

	//Start Letter E Pattern
	~patternPlayer1 = ~joePatternE.play;
	~patternPlayer2 = ~joePatternELow.play;

	//Start Delay
	~delay = Synth(\delay, [
		\inbus: 0,
		\outbus: ~wetBus,
		\del: 0.5,
		\rel: 10,
		\atk: 10,
		\mix: 0.5,
		\room: 0.9,
	]);
};

~eToFListener = {
	//Start E to F Listener
	~pitchDetEtoF = Synth(\pitchDetective, [
		\tarFreq: 196, //G 3
		\id, 0
	]);

	//Start E to F OSC def
	OSCdef(\eToF).enable;
};
















