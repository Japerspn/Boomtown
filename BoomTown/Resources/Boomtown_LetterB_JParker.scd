~joePatternB = Pbind(
	\instrument, \joeSynth,
	\bufnum, Pxrand(~gPent, inf),
	\atk, 5,
	\sus, 5,
	\rel, 5,
	\dur, 3,
	\mix, 0.8,
	\room, 0.86,
	\outbus, ~droneBus,
	\addAction, \addToHead
);

OSCdef(\aToB, { arg msg, time, addr, recvPort;

	//Free A to B detector synth
	~pitchDetAtoB.free;

	//Free Letter A Pattern
	~patternPlayer.stop;

	~letterBFunc.value;

	~bToCListener.value;

	// disable A to B OSCdef
	OSCdef(\aToB).disable;

}, \tr);

OSCdef(\aToB).disable;

~letterBFunc = {
	"Letter B".postln;
	{~currentLetter.string_("B")}.defer;

	//Start Letter B Pattern
	~patternPlayer = ~joePatternB.play;

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

~bToCListener = {
	//Start B to C Listener
	u = Task({
	~pitchDetBtoC = Synth(\pitchDetective, [
		\tarFreq: 233, //B-flat 3
		\id, 0
	]);
	}).play;
	//Start B to C OSC def
	OSCdef(\bToC).enable;

}











