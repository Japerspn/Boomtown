SynthDef(\pitchShifter, {
	arg amp = 1, outFreq = 200, inbus, delTime = 0;
	var sig, inFreq, hasFreq, ratio;

	//sig = In.ar(inbus);//when using a bus
	sig = SoundIn.ar(inbus);//when using a microphone

	# inFreq, hasFreq = Tartini.kr(sig, 0.5);
	inFreq.poll;
	ratio = outFreq / inFreq;
	ratio = ratio.clip(0,1);
	sig = PitchShift.ar(sig, pitchRatio: ratio);
	sig = DelayL.ar(sig, 1, delTime);
	sig = FreeVerb.ar(sig, 0.75, 0.75, 0.75);
	Out.ar(0, sig * amp)
}).add;


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



SynthDef(\skipBuf, {//record skipping synth by dust.
	arg skipDur = -0.5, bufnum, skipDens = 1;
	var sig, pos, resetPos;
	resetPos = LocalIn.kr(1).clip(0, BufFrames.kr(bufnum));
	pos = Phasor.ar(Dust.ar(1), BufRateScale.kr(bufnum), 0, BufFrames.kr(bufnum), resetPos);
	LocalOut.kr(BufSampleRate.kr(bufnum) * skipDur + pos);
	sig = BufRd.ar(1, bufnum, pos);
	sig = FreeVerb.ar(sig);
	Out.ar(0, sig);
}).add;
