s.boot;//Record Skipping synth by setting
b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");
(
x = {
	arg t_skip = 0, skipDur = -0.5;
	var pos, resetPos;
	resetPos = LocalIn.kr(1).clip(0, BufFrames.kr(b));
	pos = Phasor.ar(t_skip, BufRateScale.kr(b), 0, BufFrames.kr(b), resetPos);
	LocalOut.kr(BufSampleRate.kr(b) * skipDur + pos);
	BufRd.ar(1, b, pos);
}.play
)
x.set(\t_skip, 1)
x.set(\skipDur, -0.2)

(
x = {//record skipping synth by dust.
	arg t_skip = 0, skipDur = -0.5;
	var pos, resetPos;
	resetPos = LocalIn.kr(1).clip(0, BufFrames.kr(b));
	pos = Phasor.ar(Dust.ar(1), BufRateScale.kr(b), 0, BufFrames.kr(b), resetPos);
	LocalOut.kr(BufSampleRate.kr(b) * skipDur + pos);
	BufRd.ar(1, b, pos);
}.play
)
x.set(\t_skip, 1)
x.set(\skipDur, -0.2)




(
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
)


Synth(\skipBuf, [\bufnum: b])

(
t = Task({
	~recSynth = Synth(\recordBuf, [\bufnum: ~bufArrayBig[0]]);
	~skipSynth1 = Synth(\skipBuf, [\bufnum: ~bufArrayBig[0], \skipDens: 0.5, \skipDur: -0.2]);
	~skipSynth2 = Synth(\skipBuf, [\bufnum: ~bufArrayBig[0], \skipDens: 0.5, \skipDur: -0.2]);
	~skipSynth3 = Synth(\skipBuf, [\bufnum: ~bufArrayBig[0], \skipDens: 0.5, \skipDur: -0.2]);

}).play;
)