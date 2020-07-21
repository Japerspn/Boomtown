OSCdef(\cToD, { arg msg, time, addr, recvPort;
	"Letter D".postln;

	//Free C to D detector synth
	~pitchDetCtoD.free;

	//Free Letter C Pattern
	~patternPlayer.stop;

	//Free Slow Chorus Synth
	~recSynth.set(\gate, 0);
	~pbSynth1.set(\gate, 0);
	~pbSynth2.set(\gate, 0);
	~pbSynth3.set(\gate, 0);

	//Start Slow Chorus
	t = Task({
		~recSynth = Synth(\recordBuf, [\bufnum: ~bufArrayBig[0]]);
		0.1.wait;
		~pbSynth1 = Synth(\playbackBuf, [\bufnum: ~bufArrayBig[0], \rate: 0.8, \mix: 0.6, \room: 0.75, \outbus, ~wetBus]);
		~pbSynth2 = Synth(\playbackBuf, [\bufnum: ~bufArrayBig[0], \rate: 0.85, \mix: 0.45, \room: 0.6, \outbus, ~wetBus]);
		~pbSynth3 = Synth(\playbackBuf, [\bufnum: ~bufArrayBig[0], \rate: 0.95, \outbus, ~wetBus]);
	}).play;

	//Start D to E Listener
	~pitchDetDtoE = Synth(\pitchDetective, [
		\tarFreq: 233, //Bb 3
		\id, 0
	]);

	//Start D to D OSC def
	OSCdef(\dToE).enable;

	// disable B to C OSCdef
	OSCdef(\cToD).disable;

}, \tr);

OSCdef(\cToD).disable

