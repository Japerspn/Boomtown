~joePatternB = Pbind(//Starts New Pattern
	\instrument, \joeSynth,
	\bufnum, Pxrand(~gPent, inf),
	\atk, 5,
	\sus, 5,
	\rel, 5,
	\dur, 3,
	\mix, 0.8,
	\room, 0.86
);

OSCdef(\aToB, { arg msg, time, addr, recvPort;
	"Letter B".postln;
	//Free A to B detector synth
	~pitchDetAtoB.free;

	//Free Letter A Pattern
	~patternPlayer.stop;

	//Start Letter B Pattern
	~patternPlayer = ~joePatternB.play;

	//Start B to C Listener
	~pitchDetBtoC = Synth(\pitchDetective, [
		\tarFreq: 233, //B-flat 3
		\id, 0
	]);

	//Start B to C OSC def
	OSCdef(\bToC).enable;

	// disable A to B OSCdef
	OSCdef(\aToB).disable;

}, \tr);

OSCdef(\aToB).disable
