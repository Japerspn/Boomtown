SynthDef(\recordBuf, {// records into specified buffer
	arg bufnum = 0, loop = 1, inbus = 0, outbus = 0, gate = 1, rel = 10, atk = 5;
	var sig, env;

	env = EnvGen.kr(Env.adsr(atk, 1, 1, rel), gate: gate, doneAction: 2);

	sig = RecordBuf.ar(SoundIn.ar(inbus), bufnum, loop: loop, doneAction: 2);// if loop = 0, buffer does not repeat.
	sig = sig * env;
	//Out.ar(outbus, sig)
}).add;
/*
~recordSynth = Synth(\recordBuf, [\bufnum: ~bufRay[0], \loop: 1]);
*/


SynthDef(\playbackBuf, {// plays specified buffer w/ reverb
	arg bufnum = 0, rate = 1, outbus = 0, loop = 1, mix = 0.33, room = 0.5, gate = 1, atk = 5, rel = 10;
	var sig, env;

	env = EnvGen.kr(Env.adsr(atk, 1, 1, rel), gate: gate, doneAction: 2);


	sig = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum) * rate, loop: loop, doneAction: 2);
	sig = PitchShift.ar(sig, pitchRatio: rate.reciprocal);
	sig = LPF.ar(sig, 3000);
	sig = HPF.ar(sig, 300);
	sig = FreeVerb.ar(sig, mix, room);
	sig = sig * env;

	Out.ar(~wetBus, sig * 2);
}).add;
/*
~pbSynth2 = Synth(\playbackBuf, [\bufnum: ~bufArrayBig[0], \rate: 0.85, \mix: 0.45, \room: 0.6]);
*/

SynthDef(\playbackBuf2Chan, {// plays specified buffer w/ reverb
	arg bufnum = 0, rate = 1, outbus = 0, loop = 1, mix = 0.33, room = 0.5, gate = 1, atk = 5, rel = 10, amp = 1;
	var sig, env;

	env = EnvGen.kr(Env.adsr(atk, 1, 1, rel), gate: gate, doneAction: 2);


	sig = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum) * rate, loop: loop, doneAction: 2);
	sig = PitchShift.ar(sig, pitchRatio: rate.reciprocal);
	sig = LPF.ar(sig, 3000);
	sig = HPF.ar(sig, 300);
	sig = FreeVerb.ar(sig, mix, room);
	sig = sig * env;

	Out.ar(outbus, sig * 2 * amp);
}).add;
/*
~pbSynth2 = Synth(\playbackBuf, [\bufnum: ~bufArrayBig[0], \rate: 0.85, \mix: 0.45, \room: 0.6]);
*/

SynthDef(\delay, {
	arg inbus = 0, outbus = 0, gate = 1, del = 3, rel = 3, atk = 3, mix = 0.33, room = 0.5, damp = 0.5, rq = 1;
	var sig, env;

	env = EnvGen.kr(Env.dadsr(del, atk, 1, 1, rel, 1), gate: gate, doneAction: 2);
	sig = DelayN.ar(SoundIn.ar(0), del, del);
	sig = LPF.ar(sig, 3000);
	sig = HPF.ar(sig, 300);
	sig = FreeVerb.ar(sig, mix, room, damp);
	sig = sig * env;

	Out.ar(~wetBus, sig * 2);
}).add;

/*
(
~delay = Synth(\delay, [
\inbus: 0,
\outbus: 0,
\del: 0.5,
\rel: 10,
\atk: 10,
\mix: 0.5,
\room: 0.9,
])
);

~delay.set(\gate, 0)
*/


SynthDef(\skipBuf, {//plays back a buffer with record skipping effect controlled by dust.
	arg skipDur = -0.5, bufnum, skipDens = 1, gate = 1, atk = 5, rel = 10;
	var sig, pos, resetPos, env;

	env = EnvGen.kr(Env.adsr(atk, 1, 1, rel), gate: gate, doneAction: 2);

	resetPos = LocalIn.kr(1).clip(0, BufFrames.kr(bufnum));
	pos = Phasor.ar(Dust.ar(1), BufRateScale.kr(bufnum), 0, BufFrames.kr(bufnum), resetPos);
	LocalOut.kr(BufSampleRate.kr(bufnum) * skipDur + pos);

	sig = BufRd.ar(1, bufnum, pos);
	sig = FreeVerb.ar(sig);
	sig = LPF.ar(sig, 3000);
	sig = HPF.ar(sig, 300);
	sig = sig * env;
	Out.ar(~wetBus, sig * 2);
}).add;
/*


*/


SynthDef(\joeSynth, {//Plays back buffer with an envelope and panning. Designed for use in a pattern
	arg amp = 1, atk = 1, sus = 1, rel = 1, bufnum = 0, pan = 0, mix = 0.33, room = 0.5, damp = 0.5, outbus = 0;
	var sig, env;

	env = EnvGen.kr(Env.new([0,1,1,0], [atk, sus, rel]), doneAction: 2);
	sig = PlayBuf.ar(2, bufnum, loop: 1);
	sig = Pan2.ar(sig, pan);
	sig = FreeVerb.ar(sig, mix, room, damp);
	sig = sig * amp * env;
	Out.ar(outbus, sig);

}).add;
/*
~joePattern = Pbind(
\instrument, \joeSynth,
\bufnum, Pxrand(~gAndD, inf),
\atk, 5,
\sus, 5,
\rel, 5,
\dur, 3,
\mix, 0.5,
\room, 0.66
);
*/


SynthDef(\joeSynthSkip, {//Plays back buffer with an envelope, panning, and record skip effect. Designed for use in a pattern
	arg skipDur = -0.5, bufnum, skipDens = 1, amp = 1, atk = 1, sus = 1, rel = 1, pan = 0, mix = 0.33, room = 0.5, damp = 0.5, outbus = 0;
	var sig, pos, resetPos, env;

	env = EnvGen.kr(Env.new([0,1,1,0], [atk, sus, rel]), doneAction: 2);

	resetPos = LocalIn.kr(2).clip(0, BufFrames.kr(bufnum));

	pos = Phasor.ar(Dust.ar(1), BufRateScale.kr(bufnum), 0, BufFrames.kr(bufnum), resetPos);

	LocalOut.kr(BufSampleRate.kr(bufnum) * skipDur + pos);

	sig = BufRd.ar(2, bufnum, pos);
	sig = sig * env * amp;
	sig = FreeVerb.ar(sig, );
	Out.ar(outbus, sig);
}).add;

/*
~joePatternSkip = Pbind(
\instrument, \joeSynthSkip,
\bufnum, Pxrand(~gAndD, inf),
\atk, 5,
\sus, 5,
\rel, 5,
\dur, 3,
\mix, 0.5,
\room, 0.66,
\skipDur, -0.5, // How far back the skip skips
\skipDens, 1, // How many skips per second

);

*/


SynthDef(\pitchDetective,{ // frequency between loFreq and hiFreq sends a trigger as an OSC message with an id of 0
	arg id = 0, tarFreq = 80;
	var sig, freq, hasFreq, freqDif;
	sig = SoundIn.ar;
	//sig = SinOsc.ar(inFreq, mul: 0.5).lag(3);

	# freq, hasFreq = Tartini.kr(sig);
	//hasFreq.poll;
	freq.poll;

	SendTrig.kr(
		(
			(freq > (tarFreq - 2)) * (freq < (tarFreq + 2))
		),
		id,
		freq
	); //here's where the id number gets set
}).add;
/*
~pitchDet = Synth(\pitchDetective, [
\tarFreq: 440,
\id, 0
]);

*/

SynthDef(\outSynth, {
	arg amp = 1, thresh = 0.9, inbus = 0, otherOut = 0;
	var sig;
	sig = In.ar(inbus);
	sig = Pan2.ar(sig, 0);
	sig = sig * amp;
/*	sig = Compander.ar(
		in: sig,
		control: sig,
		thresh: thresh,
		slopeBelow: 1,
		slopeAbove: 0.5,
		clampTime: 0.1,
		relaxTime: 0.1
	);*/
	Out.ar([0, otherOut], sig);
}).add;

SynthDef(\dryOutSynth, {
	arg amp = 1, thresh = 0.9, inbus = 0;
	var sig;
	sig = SoundIn.ar(inbus);
	sig = Pan2.ar(sig, 0);
	sig = sig * amp;
/*	sig = Compander.ar(
		in: sig,
		control: sig,
		thresh: thresh,
		slopeBelow: 1,
		slopeAbove: 0.5,
		clampTime: 0.1,
		relaxTime: 0.1
	);*/
	Out.ar([0, 2], sig);
}).add;
/*
(
~dryOut = Synth(\outSynth, [
\amp: 1,
\thresh: 0.9,
\inbus: 0,
]);
~wetOut = Synth(\outSynth, [
\amp: 1,
\thresh: 0.9,
\inbus: ~wetBus
]);
~droneOut = Synth(\outSynth, [
\amp: 1,
\thresh: 0.9,
\inbus: ~droneBus
]);
)
*/


~outSynthSetup = {
	if(~dryOut.isPlaying.not, {
		~dryOut = Synth(\dryOutSynth, [
			\amp: ~dryOutSlider.value * 2,
			\thresh: 0.9,
			\inbus: 0,
		]).register;

	}, {
		~dryOut.free;
	});

	if(~droneOut.isPlaying.not, {
		~droneOut = Synth(\outSynth, [
			\amp: ~droneOutSlider.value * 2,
			\thresh: 0.9,
			\inbus: ~droneBus,
			\otherOut: 6
		]).register;

	}, {
		~droneOut.free;
	});

	if(~wetOut.isPlaying.not, {
		~wetOut = Synth(\outSynth, [
			\amp: ~wetOutSlider.value * 2,
			\thresh: 0.9,
			\inbus: ~wetBus,
			\otherOut: 4
		]).register;

	}, {
		~wetOut.free;
	});
}
