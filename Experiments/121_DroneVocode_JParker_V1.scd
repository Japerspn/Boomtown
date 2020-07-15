Server.killAll
s.boot;
s.reboot;
s.plotTree


b = Buffer.read(s, "/Users/jamesparker/Dropbox/Recordings - Full/Aguas Distintas/Aguas - Nick M. - 1.wav")
c = Bus.audio(s, 1);
b.play


(
SynthDef(\playBuf, {
	arg outbus = 0;
	var sig;
	sig = PlayBuf.ar(2, b.bufnum);
	Out.ar(outbus, sig);
}).add;

SynthDef(\Vocoder, {
	arg pan = 0, freq = 200, cf = 1500, rq = 0.2, detune = 0.2, amp = 1, inbus = 0;
	var carSig, modSig, sig;

	//carSig = Saw.ar(freq * LFNoise1.kr(0.1, detune).midiratio);
	//carSig = Pulse.ar(freq);
	carSig = SinOsc.ar(freq);
	//carSig = Formant.ar(freq);
	carSig = BPF.ar(carSig, cf, rq);
	modSig = In.ar(inbus);
	//modSig = SoundIn.ar(0);
	sig = Vocoder.ar(carSig, modSig,56);
	sig = Pan2.ar(sig, pan);
	//sig = FreeVerb.ar(sig, 0.66, 0.75, 1);
	Out.ar(0, sig * amp);
}).add;

SynthDef(\pitchShifter, {
	arg amp = 1, outFreq = 200, inbus, delTime = 0;
	var sig, inFreq, hasFreq, ratio;

	sig = In.ar(inbus);

	# inFreq, hasFreq = Tartini.kr(sig, 0.5);
	//inFreq.poll;
	ratio = outFreq / inFreq;
	ratio = ratio.clip(0,1);
	ratio.poll;
	sig = PitchShift.ar(sig, pitchRatio: ratio);
	sig = DelayL.ar(sig, 1, delTime);
	sig = FreeVerb.ar(sig, 0.75, 0.75, 0.75);
	Out.ar(0, sig * amp)
}).add;
)

(
Synth(\playBuf, [\outbus: c]);

Synth(\Vocoder, [
	\inbus: c,
	\freq: 100,
	\cf: 100 * 2,
	\rq: 0.5
], addAction: 'addToTail');
)

(
Synth(\playBuf, [\outbus: c]);
[100, 200, 400, 800].do({|f|
	Synth(\Vocoder, [
		\inbus: c,
		\freq: f,
		\cf: f * 2,
		\rq: 0.5,
		\amp: 0.25
	], addAction: 'addToTail');
});
)

(
Synth(\playBuf, [\outbus: c]);
[31,43, 55].do({ |f|
	Synth(\pitchShifter, [
		\inbus: c,
		\outFreq: f.midicps,
		\delTime: rrand(0.0, 0.5)
	], addAction: 'addToTail')
})
)


~infreq = 700;
~outfreq = 200;

~ratio = ~outfreq/~infreq

~infreq*~ratio


