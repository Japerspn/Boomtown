
Window.closeAll;
w = Window("121 Sketch", Rect(
	left: Window.screenBounds.width/2-(580/2),
	top: Window.screenBounds.height/2-(310/2),
	width: 580,
	height: 310))
.front
.alwaysOnTop_(true)
.background_(Color.cyan(0.4, 1))
.onClose_({
	s.freeAll

});
// make an array of all start buttons

// make an array of all test buttons
////test dry, test wet, test drones
/* control visibility of buttons using this function:
[~buttonArray].do({|button|
	button.visible_("false")
});

*/
~startButtonA = Button(w, Rect(10, 10, 40, 40))//Letter A
.states_([["Letter A", Color.green, Color.black]])
.action_({
	"Letter A".postln;
	~outSynthSetup.value;
	//start G+D Pattern
	~patternPlayer = ~joePatternA.play;

	//start Listener
	~pitchDetAtoB = Synth(\pitchDetective, [
		\tarFreq: 220, //A3
		\id, 0
	]);
	//enable Listener OSC func
	OSCdef(\aToB).enable;


	~stopButton.visible_("true");
	~liveButton.visible_("false");

	~startButtonA.visible_("false");
	~startButtonB.visible_("false");
	~startButtonC.visible_("false");
});

~startButtonB = Button(w, Rect(60, 10, 40, 40))//Letter A
.states_([["Letter B", Color.green, Color.black]])
.action_({
	"Letter B".postln;
	~outSynthSetup.value;

	//start Letter B Pattern
	~patternPlayer = ~joePatternB.play;

	//start Delay
	~delay = Synth(\delay, [
		\inbus: 0,
		\outbus: 0,
		\del: 0.5,
		\rel: 10,
		\atk: 10,
		\mix: 0.5,
		\room: 0.9,
	]);

	//start Listener
	~pitchDetBtoC = Synth(\pitchDetective, [
		\tarFreq: 233, //B-flat 3
		\id, 0
	]);
	//enable Listener OSC func
	OSCdef(\bToC).enable;

	~stopButton.visible_("true");
	~liveButton.visible_("false");

	~startButtonA.visible_("false");
	~startButtonB.visible_("false");
	~startButtonC.visible_("false");
});

~startButtonC = Button(w, Rect(110, 10, 40, 40))//Letter A
.states_([["Letter C", Color.green, Color.black]])
.action_({
	"Letter C".postln;
	~outSynthSetup.value;


	//Start Letter C Pattern
	~patternPlayer = ~joePattern3.play;

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
	~liveButton.visible_("false");

	~startButtonA.visible_("false");
	~startButtonB.visible_("false");
	~startButtonC.visible_("false");


});

~stopButton = Button(w, Rect(10,100,40,40))//Stop Button
.states_([["STOP", Color.green, Color.black]])
.visible_("false")
.action_({
	s.freeAll;
	if(~patternPlayer.isPlaying, {~patternPlayer.stop});
	if(t.isPlaying, {t.stop});

	~stopButton.visible_("false");
	~liveButton.visible_("false");

	~startButtonA.visible_("true");
	~startButtonB.visible_("true");
	~startButtonC.visible_("true");

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
)});

~liveButton = Button(w, Rect(140, 150, 100, 40))
.states_([["Test Levels", Color.green, Color.black],["End Test", Color.red, Color.black]])
.action_({|view|
	if(view.value == 1,
		{
			"output Synths are on".postln;
			~outSynthSetup.value;

			~startButtonA.visible_("false");
			~startButtonB.visible_("false");
			~startButtonC.visible_("false");
			~recordButton.visible_("false");

		}, {
			"output Synths are off".postln;
			~outSynthSetup.value;
		}
)});


s.plotTree;


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
