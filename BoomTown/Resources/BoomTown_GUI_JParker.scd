
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

~startButtonA = Button(w, Rect(10, 10, 40, 40))//Letter A
.states_([["Letter A", Color.green, Color.black]])
.action_({
	"Letter A".postln;

	//start G+D Pattern
	~joePatternA.play;

	//start Listener
	~pitchDetAtoB = Synth(\pitchDetective, [
		\tarFreq: 220, //A3
		\id, 0
	]);
	//enable Listener OSC func
	OSCdef(\aToB).enable;


	~stopButton.visible_("true");

	~startButtonA.visible_("false");
	~startButtonB.visible_("false");
});

~startButtonB = Button(w, Rect(60, 10, 40, 40))//Letter A
.states_([["Letter B", Color.green, Color.black]])
.action_({
	"Letter B".postln;

	//start Letter B Pattern
	~joePatternB.play;

	//start Listener
	~pitchDetBtoC = Synth(\pitchDetective, [
		\tarFreq: 432, //A3
		\id, 0
	]);
	//enable Listener OSC func
	OSCdef(\bToC).enable;

	~stopButton.visible_("true");

	~startButtonA.visible_("false");
	~startButtonB.visible_("false");

});

~startButtonC = Button(w, Rect(110, 10, 40, 40))//Letter A
.states_([["Letter C", Color.green, Color.black],["Stop", Color.red, Color.black]])
.action_({
	"Letter C".postln;
	//Start Letter C Pattern
	~joePattern3.play;

	//Start Slow Chorus
	t = Task({
		~recSynth = Synth(\recordBuf, [\bufnum: ~bufArrayBig[0]]);
		1.wait;
		~pbSynth1 = Synth(\playbackBuf, [\bufnum: ~bufArrayBig[0], \rate: 0.8, \mix: 0.6, \room: 0.75]);
		0.3.wait;
		~pbSynth2 = Synth(\playbackBuf, [\bufnum: ~bufArrayBig[0], \rate: 0.85, \mix: 0.45, \room: 0.6]);
		0.3.wait;
		~pbSynth3 = Synth(\playbackBuf, [\bufnum: ~bufArrayBig[0], \rate: 0.95]);
	}).play;

	//Start C to D Listener
	~pitchDetCtoD = Synth(\pitchDetective, [
		\tarFreq: 233, //Bb 3
		\id, 0
	]);

	//Start C to D OSC def
	OSCdef(\cToD).enable;


	~stopButton.visible_("true");

	~startButtonA.visible_("false");
	~startButtonB.visible_("false");

});

~stopButton = Button(w, Rect(10,100,40,40))//Stop Button
.states([["STOP", Color.red],["STOP", Color.red]])
.action_({
	s.freeAll;
	if(~joePattern1.isPlaying, {~joePattern1.stop});
	if(~joePattern2.isPlaying, {~joePattern2.stop});

	~stopButton.visible_("false");

	~startButtonA.visible_("true");
	~startButtonB.visible_("true");
	~startButtonC.visible_("false");

	OSCdef(\aToB).disable;
	OSCdef(\bToC).disable;



});

~recordButton = Button(w, Rect(240, 150, 100, 40))
.states_([["RECORD", Color.green, Color.black],["Stop", Color.red, Color.black]])
.action_({|view|
	if(view.value == 1,
		{"It's on!".postln;
			s.record(thisProcess.nowExecutingPath.dirname.dirname +/+ "Recordings" +/+ "Rec" + Date.localtime + ".wav");
		}, {
			s.stopRecording
		}
)})















/*~pitchShiftButton = Button(w, Rect(40,250, 160, 40))
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
)});*/






