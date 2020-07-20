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
	~joePattern1.stop;

	//Start Letter B Pattern
	~joePattern2 = Pbind(//Starts New Pattern
		\instrument, \joeSynth,
		\bufnum, Pxrand(~gPent, inf),
		\atk, 5,
		\sus, 5,
		\rel, 5,
		\dur, 3,
		\mix, 0.8,
		\room, 0.86
	).play;

	//Start B to C Listener
	~pitchDetBtoC = Synth(\pitchDetective, [
		\tarFreq: 349, //F4
		\id, 0
	]);

	//Start B to C OSC def
	OSCdef(\bToC).enable;

	// disable A to B OSCdef
	OSCdef(\aToB).disable;

}, \tr);

OSCdef(\aToB).disable
