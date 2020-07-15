Server.killAll
s.boot;
//Buffers and Busses and Such

(
~wetBus = Bus.audio(s, 2);
~bufRay = Array.fill(10, {|i| Buffer.alloc(s, s.sampleRate / 4, 1)});
~fftBuf = Buffer.alloc(s, 1024);
);
~bufRay[1]
//Synths
(
SynthDef(\record, {
	arg bufnum = 0;
	RecordBuf.ar(SoundIn.ar(0), bufnum, loop: 0, doneAction: 2);
}).add;

SynthDef(\dry, {
	arg amp = 1, thresh = 0.9;
	var sig;
	sig = SoundIn.ar;
	sig = Pan2.ar(sig, 0);
	sig = sig * amp;
	sig = Compander.ar(
		in: sig,
		control: sig,
		thresh: thresh,
		slopeBelow: 1,
		slopeAbove: 0.5,
		clampTime: 0.1,
		relaxTime: 0.1

	);
	Out.ar(0, sig);
}).add;

SynthDef(\wet, {
	arg amp = 1, thresh = 0.9;
	var sig;
	sig = In.ar(~wetBus, 2);
	sig = sig * amp;
	sig = Compander.ar(
		in: sig,
		control: sig,
		thresh: thresh,
		slopeBelow: 1,
		slopeAbove: 0.5,
		clampTime: 0.1,
		relaxTime: 0.1

	);
	Out.ar(0, sig);
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

SynthDef(\freeze, {
	arg bufnum = 0, gate = 1;
	var in, chain, env;

	env = EnvGen.kr(Env.asr(0.3,1, 1), gate, doneAction: 2);

	in = PlayBuf.ar(1, bufnum, 1, loop: 1);
	chain = FFT(~fftBuf, in);
	chain = PV_Freeze(chain, 1);
	Out.ar(~wetBus, IFFT(chain).dup * 0.5 * env);
}).add;

)


//End of Synths
//Beginning of THE MEAT
(
~wetOut = Synth(\wet, [\amp: 1, \thresh: 0.9]);
//~dryOut = Synth(\dry, [\amp: 1, \thresh: 0.9]);

~pitchDet = Synth(\pitchDetective, [
	\tarFreq: 329,
	//\inFreq: 400,
	\id, 0
]);

OSCFunc({ arg msg, time, addr, recvPort;
	if( msg[2] == 0, {// ID 0
		"works!".postln;
		//~pitchDet.free;
		t = Task({
			//~rec = Synth(\record, [\bufnum: ~bufRay[0]]);
			Synth(\record, [\bufnum: ~bufRay[0]]);

			0.25.wait;
			//~freeze = Synth(\freeze, [\bufnum: ~bufRay[0]]);
			Synth(\freeze, [\bufnum: ~bufRay[0]]);
		}).play
	});
}, \tr)
)

~pitchDet.set(\inFreq, 83);
~pitchDet.free;
~freeze.set(\gate, 1)



~dgba = [146, 196, 246, 329];

~pitchDets = Array.new(4);
~recs = Array.new(4);
~freezes = Array.new(4);
(
~wetOut = Synth(\wet, [\amp: 1, \thresh: 0.9]);
~dryOut = Synth(\dry, [\amp: 1, \thresh: 0.9]);

~dgba.do({//index takes items from the array, item gives 0-3
	|index, item|
	index.postln;
	~pitchDets.add(
		Synth(\pitchDetective, [\tarFreq: index, \id: item])
	);
	~recs.add(
		Synth(\record, [\bufnum: ~bufRay[item]])
	);
	~freezes.add(
		Synth(\freeze, [\bufnum: ~bufRay[item]]);
	);

	OSCFunc({ arg msg, time, addr, recvPort;
		if( msg[2] == 0, {// ID 0
			"works!".postln;
			b[item].free;
			t = Task({
				//~rec = Synth(\record, [\bufnum: ~bufRay[0]]);
				Synth(\record, [\bufnum: ~bufRay[0]]);

				0.25.wait;
				//~freeze = Synth(\freeze, [\bufnum: ~bufRay[0]]);
				Synth(\freeze, [\bufnum: ~bufRay[0]]);
			}).play
		});
	}, \tr)
});

~pitchDets[0]

)
s.plotTree
(
[3,7,8,9].do({|index, item|
	[index, item].postln;
})
)
