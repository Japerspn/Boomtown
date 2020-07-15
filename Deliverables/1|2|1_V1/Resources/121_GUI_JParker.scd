
Window.closeAll;
w = Window("121 Sketch", Rect(
	left: Window.screenBounds.width/2-(580/2),
	top: Window.screenBounds.height/2-(310/2),
	width: 580,
	height: 310))
.front
.alwaysOnTop_(true)
.background_(Color.cyan(0.4, 1))
.onClose_({s.freeAll});


~pitchShiftButton = Button(w, Rect(40,250, 160, 40))
.states_([["Weird Pitch Shifter Thing", Color.green, Color.black],["Stop", Color.red, Color.black]])
.action_({|view|
	if(view.value == 1,
		{"It's on!".postln;
			~pitchSynth =
			Synth(\pitchShifter, [
				\inbus: 0,
				\outFreq: 43.midicps,
				//\delTime: rrand(0.0, 0.5)
				\delTime: 0
			], addAction: 'addToTail')

		}, {
			"It's off".postln;
			~pitchSynth.free
		}
)});

~layersButton = Button(w, Rect(240,250, 160, 40))
.states_([["Layers", Color.green, Color.black],["Stop", Color.red, Color.black]])
.action_({|view|
	if(view.value == 1,
		{"It's on!".postln;
			t = Task({
				~recSynth = Synth(\recordBuf, [\bufnum: ~bufArrayBig[0]]);
				3.wait;
				~pbSynth1 = Synth(\playbackBuf, [\bufnum: ~bufArrayBig[0], \rate: 0.8, \mix: 0.6, \room: 0.75]);
				~pbSynth2 = Synth(\playbackBuf, [\bufnum: ~bufArrayBig[0], \rate: 0.85, \mix: 0.45, \room: 0.6]);
				~pbSynth3 = Synth(\playbackBuf, [\bufnum: ~bufArrayBig[0], \rate: 0.95]);
			}).play;
		}, {
			"It's off".postln;
			~recSynth.free;
			~pbSynth1.free;
			~pbSynth2.free;
			~pbSynth3.free;
		}
)});


~skipSynthButton = Button(w, Rect(440, 250, 100, 40))
.states_([["Layers w/ skip", Color.green, Color.black],["Stop", Color.red, Color.black]])
.action_({|view|
	if(view.value == 1,
		{"It's on!".postln;
			t = Task({
				~recSynth = Synth(\recordBuf, [\bufnum: ~bufArrayBig[0]]);
				~skipSynth1 = Synth(\skipBuf, [\bufnum: ~bufArrayBig[0], \skipDens: 0.5, \skipDur: -0.2]);
				~skipSynth2 = Synth(\skipBuf, [\bufnum: ~bufArrayBig[0], \skipDens: 0.5, \skipDur: -0.2]);
				~skipSynth3 = Synth(\skipBuf, [\bufnum: ~bufArrayBig[0], \skipDens: 0.5, \skipDur: -0.2]);

			}).play;
		}, {
			"It's off".postln;
			~recSynth.free;
			~skipSynth1.free;
			~skipSynth2.free;
			~skipSynth3.free;
		}
)});


~recordButton = Button(w, Rect(240, 150, 100, 40))
.states_([["RECORD", Color.green, Color.black],["Stop", Color.red, Color.black]])
.action_({|view|
	if(view.value == 1,
		{"It's on!".postln;
			s.record;
		}, {
			s.stopRecording
		}
)})




