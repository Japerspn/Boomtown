~joePattern3 = Pbind(//Starts New Pattern
	\instrument, \joeSynth,
	\bufnum, Pxrand(~justG, inf),
	\atk, 5,
	\sus, 5,
	\rel, 5,
	\dur, 3,
	\mix, 0.4,
	\room, 0.5
);

OSCdef(\bToC, { arg msg, time, addr, recvPort;
	"Letter C".postln;

	//Free B to C detector synth
	~pitchDetBtoC.free;

	//Free Letter B Pattern
	~joePattern2.stop;

	//Start Letter C Pattern
	~joePattern3.play;

	//Start Slow Chorus
	t = Task({
		~recSynth = Synth(\recordBuf, [\bufnum: ~bufArrayBig[0]]);
		1.wait;
		~pbSynth1 = Synth(\playbackBuf, [\bufnum: ~bufArrayBig[0], \rate: 0.8, \mix: 0.6, \room: 0.75]);
		0.3.wait;
		~pbSynth2 = Synth(\playbackBuf, [\bufnum: ~bufArrayBig[0], \rate: 0.85, \mix: 0.45, \room: 0.6]);
		0.3.wait;
		~pbSynth3 = Synth(\playbackBuf, [\bufnum: ~bufArrayBig[0], \rate: 0.95]);
	}).play;

	//Start C to D Listener
	~pitchDetCtoD = Synth(\pitchDetective, [
		\tarFreq: 233, //Bb 3
		\id, 0
	]);

	//Start C to D OSC def
	OSCdef(\cToD).enable;

	// disable B to C OSCdef
	OSCdef(\bToC).disable;

}, \tr);

OSCdef(\bToC).disable