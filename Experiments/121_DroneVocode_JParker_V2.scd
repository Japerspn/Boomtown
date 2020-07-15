Server.killAll
s.boot;
s.reboot;
s.plotTree
ServerOptions.inDevices
s.options.inDevice
s.options.outDevi

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

SynthDef(\pitchShifter, {
	arg amp = 1, outFreq = 200, inbus, delTime = 0;
	var sig, inFreq, hasFreq, ratio;

	sig = In.ar(inbus);//when using a bus
	//sig = SoundIn.ar(inbus);//when using a microphone

	# inFreq, hasFreq = Tartini.kr(sig, 0.5);
	inFreq.poll;
	ratio = outFreq / inFreq;
	ratio = ratio.clip(0,1);
	sig = PitchShift.ar(sig, pitchRatio: ratio);
	sig = DelayL.ar(sig, 1, delTime);
	sig = FreeVerb.ar(sig, 0.75, 0.75, 0.75);
	Out.ar(0, sig * amp)
}).add;
)

(
Synth(\playBuf, [\outbus: c]);
[31,43, 55].do({ |f|
//[43].do({ |f|
	Synth(\pitchShifter, [
		\inbus: c,
		\outFreq: f.midicps,
		//\delTime: rrand(0.0, 0.5)
		\delTime: 0
	], addAction: 'addToTail')
})
)




