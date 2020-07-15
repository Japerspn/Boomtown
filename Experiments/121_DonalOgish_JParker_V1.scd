/*
Ideas:
I. Aoifa's donal og style thing with the following:
---super free melody, that somehow plays the same thing back but slower and at the same pitch, lots of reverb.
---pitch detection that triggers joe's samples, or maybe new ones that sasha records, that play the harmony


What I need:

3 buffers
record synth
playback synth that plays back and different rates
can buffers be played at the same time that they are being recorded?

Pitch detection that triggers playback of samples, with record skipping synth.

*/

s.reboot;
(
~bufArraySmall = Array.fill(10, {|i| Buffer.alloc(s, s.sampleRate / 4, 1)});
~fftBuf = Buffer.alloc(s, 1024);
~bufArrayBig = Array.fill(10, {Buffer.alloc(s, s.sampleRate * 10, 1)});//10 second buffer
);

(
SynthDef(\recordBuf, {
	arg bufnum = 0, loop = 1, inbus = 0, outbus = 0;
	var sig;
	sig = RecordBuf.ar(SoundIn.ar(inbus), bufnum, loop: loop, doneAction: 2);
	Out.ar(outbus, sig)
}).add;

SynthDef(\playbackBuf, {
	arg bufnum = 0, rate = 1, outbus = 0, loop = 1, mix = 0.33, room = 0.5;
	var sig;
	sig = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum) * rate, loop: loop, doneAction: 2);
	sig = PitchShift.ar(sig, pitchRatio: rate.reciprocal);
	sig = FreeVerb.ar(sig, mix, room);
	Out.ar(outbus, sig);
}).add;

SynthDef(\pitchDetective,{ // \frequency between loFreq and hiFreq sends the trigger as an OSC message with an id of 0
	arg thresh = 1, id = 0, tarFreq = 80, loFreq = 500, hiFreq = 300, inFreq = 400;
	var chain, sig, freq, hasFreq, freqDif;
	sig = SoundIn.ar;
	//sig = SinOsc.ar(inFreq, mul: 0.5).lag(3);

	# freq, hasFreq = Tartini.kr(sig);
	//freq.poll;

	SendTrig.kr(
		(
			(freq > (tarFreq - 10)) * (freq < (tarFreq + 10))),
		id,
		freq
	); //here's where the id number gets set
}).add;
);

(
OSCFunc({ arg msg, time, addr, recvPort;
	if( msg[2] == 0, {// ID 0
		"works!".postln;
		~pitchDet0.free;
		t = Task({
			~rec0 = Synth(\record, [\bufnum: ~bufRay[0]]);

			0.25.wait;
			~freeze0 = Synth(\freeze, [\bufnum: ~bufRay[0]]);
		}).play
	});
});
);

(
t = Task({
	~recSynth = Synth(\recordBuf, [\bufnum: ~bufArrayBig[0]]);
	0.5.wait;
	~pbSynth1 = Synth(\playbackBuf, [\bufnum: ~bufArrayBig[0], \rate: 0.95, \mix: 0.6, \room: 0.75]);
	0.5.wait;
	~pbSynth2 = Synth(\playbackBuf, [\bufnum: ~bufArrayBig[0], \rate: 0.975, \mix: 0.45, \room: 0.6]);
	0.5.wait;
	~pbSynth3 = Synth(\playbackBuf, [\bufnum: ~bufArrayBig[0], \rate: 0.99]);
}).play;
)
