~joePatternA = Pbind(
	\instrument, \joeSynth,
	\bufnum, Pxrand(~gAndD, inf),
	\atk, 5,
	\sus, 5,
	\rel, 5,
	\dur, 3,
	\mix, 0.5,
	\room, 0.66,
	\outbus, ~droneBus,
	\addAction, \addToHead
);

~letterAFunc = {
	"Letter A".postln;
	~currentLetter.string_("A");

	~patternPlayer = ~joePatternA.play;
};

~aToBListener = {	//start Listener
	{}.defer;
	~pitchDetAtoB = Synth(\pitchDetective, [
		\tarFreq: 220, //A3
		\id, 0
	]);
	//enable Listener OSC func
	OSCdef(\aToB).enable;

}




