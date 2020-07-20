SynthDef(\recordBuf, {// records into specified buffer
	arg bufnum = 0, loop = 1, inbus = 0, outbus = 0;
	var sig;
	sig = RecordBuf.ar(SoundIn.ar(inbus), bufnum, loop: loop, doneAction: 2);// if loop = 0, buffer does not repeat.
	Out.ar(outbus, sig)
}).add;
/*
~recordSynth = Synth(\recordBuf, [\bufnum: ~bufRay[0], \loop: 1]);

*/


SynthDef(\playbackBuf, {// plays specified buffer w/ reverb
	arg bufnum = 0, rate = 1, outbus = 0, loop = 1, mix = 0.33, room = 0.5;
	var sig;
	sig = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum) * rate, loop: loop, doneAction: 2);
	sig = PitchShift.ar(sig, pitchRatio: rate.reciprocal);
	sig = FreeVerb.ar(sig, mix, room);
	Out.ar(outbus, sig);
}).add;
/*


*/


SynthDef(\skipBuf, {//plays back a buffer with record skipping effect controlled by dust.
	arg skipDur = -0.5, bufnum, skipDens = 1, outbus = 0;
	var sig, pos, resetPos;
	resetPos = LocalIn.kr(1).clip(0, BufFrames.kr(bufnum));
	pos = Phasor.ar(Dust.ar(1), BufRateScale.kr(bufnum), 0, BufFrames.kr(bufnum), resetPos);
	LocalOut.kr(BufSampleRate.kr(bufnum) * skipDur + pos);
	sig = BufRd.ar(1, bufnum, pos);
	sig = FreeVerb.ar(sig);
	Out.ar(outbus, sig);
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


*/


SynthDef(\pitchDetective,{ // frequency between loFreq and hiFreq sends a trigger as an OSC message with an id of 0
	arg thresh = 1, id = 0, tarFreq = 80;
	var chain, sig, freq, hasFreq, freqDif;
	sig = SoundIn.ar;
	//sig = SinOsc.ar(inFreq, mul: 0.5).lag(3);

	# freq, hasFreq = Tartini.kr(sig);
	freq.poll;

	SendTrig.kr(
		(
			(freq > (tarFreq - 10)) * (freq < (tarFreq + 10))
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