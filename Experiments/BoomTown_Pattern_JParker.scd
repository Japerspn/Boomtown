s.boot

Server.killAll
(
Buffer.freeAll;
~g3 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Samples/JDAM_Drone12 (G3)_JParker_V2.wav");
~beef3 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Samples/JDAM_Drone07 (Bb3)_JParker_V2.wav");
~c4 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Samples/JDAM_Drone04 (C4)_JParker_V2.wav");
~g4 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Samples/JDAM_Drone03 (G4)_JParker_V2.wav");
~a4one = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Samples/JDAM_Drone02 (A4)_JParker_V2.wav");
~a4two = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Samples/JDAM_Drone17 (A4)_JParker_V2.wav");
~c5 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Samples/JDAM_Drone09 (C5)_JParker_V2.wav");
~d5one = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Samples/JDAM_Drone01 (D5)_JParker_V2.wav");
~d5two = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Samples/JDAM_Drone16 (D5)_JParker_V2.wav");
~f5 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Samples/JDAM_Drone15 (F5)_JParker_V2.wav");
~fis5 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Samples/JDAM_Drone05 (F#5)_JParker_V2.wav");
~g5 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Samples/JDAM_Drone13 (G5)_JParker_V2.wav");
~a5 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Samples/JDAM_Drone06 (A5)_JParker_V2.wav");
~beef5 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Samples/JDAM_Drone10 (Bb5)_JParker_V2.wav");
~b5 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Samples/JDAM_Drone11 (B5)_JParker_V2.wav");
~d6 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Samples/JDAM_Drone08 (D6)_JParker_V2.wav");
~e6 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Samples/JDAM_Drone14 (E6)_JParker_V2.wav");

~all = [~g3, ~beef3, ~c4, ~g4, ~a4one, ~a4two, ~c5, ~d5one, ~d5two, ~f5, ~fis5, ~g5, ~a5, ~beef5, ~b5, ~d6, ~e6];
~gPent = [~g3, ~c4, ~g4, ~a4one, ~a4two, ~c5, ~d5one, ~d5two, ~g5, ~a5, ~d6];

~gAndD = [~g3, ~g4, ~d5one, ~d5two, ~g5, ~d6];
~gMaj = [~g3, ~c4, ~g4, ~a4one, ~a4two, ~c5, ~d5one, ~d5two, ~fis5, ~g5, ~a5, ~b5, ~d6, ~e6];
~gDom = [~g3, ~c4, ~g4, ~a4one, ~a4two, ~c5, ~d5one, ~d5two, ~f5, ~g5, ~a5, ~b5, ~d6, ~e6];
~gMin = [~g3, ~beef3, ~c4, ~g4, ~a4one, ~a4two, ~c5, ~d5one, ~d5two, ~f5, ~g5, ~a5, ~beef5, ~d6];
)
(
SynthDef(\joeSynthGate, {//setable w/ gate
	arg amp = 1, atk = 1, sus = 1, rel = 1, gate = 1, bufnum = 0, pan = 0, mix = 0.33, room = 0.5, damp = 0.5;
	var sig, env;

	env = EnvGen.kr(Env.asr(atk, sus, rel), gate, doneAction: 2);
	sig = PlayBuf.ar(2, bufnum, loop: 1);
	sig = Pan2.ar(sig, pan);
	sig = FreeVerb.ar(sig, mix, room, damp);
	sig = sig * amp * env;
	Out.ar(0, sig);
}).add;
);


(
a = Synth(\joeSynthSkip, [
	\bufnum: ~beef3,
	\atk: 5,
	\sus: 5,
	\rel: 5,
	\mix: 1,
	\skipDur, -1,
	\skipDens, 3
])
);


(
if(p.isPlaying, {p.stop});
p = Pbind(
	\instrument, \joeSynth,
	\bufnum, Pxrand(~gAndD, inf),
	\atk, 5,
	\sus, 5,
	\rel, 5,
	\dur, 3,
	\mix, 0.5,
	\room, 0.66
).play;
p.isPlaying;
)

(
if(p.isPlaying, {p.stop});
p = Pbind(
	\instrument, \joeSynthSkip,
	\bufnum, Pxrand(~gAndD, inf),
	\atk, 5,
	\sus, 5,
	\rel, 5,
	\dur, 1,
	\mix, 0.7,
	\room, 0,
	\skipDur, -0.5,
	\skipDens, 10
).play;
)

p.stop