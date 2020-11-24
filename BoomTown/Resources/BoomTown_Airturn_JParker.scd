MIDIClient.init;

MIDIIn.connectAll;

MIDIClient.sources;

(
MIDIdef.cc(\rightPedal, {
	arg val;
	if(val == 127,
		{"right! down".postln},
		{"right! up".postln}
	)
}, ~rightChan).permanent_(true);
MIDIdef.cc(\leftPedal, {
	arg val;
	if(val == 127,
		{"left! down".postln},
		{"left! up".postln}
	)
}, ~leftChan).permanent_(true);
)

MIDIdef(\leftSet).enable;
MIDIdef(\rightSet).enable;


(
MIDIdef.cc(\leftSet, {arg val, num, chan, src;
	~leftChan = num;
	num.postln;
	MIDIdef(\leftSet).disable;
})
)

(
MIDIdef.cc(\rightSet, {arg val, num, chan, src;
	~rightChan = num;
	num.postln;
	MIDIdef(\rightSet).disable;
})
)
MIDIdef(\leftSet).enable;


~leftChan
~rightChan



(
Window.closeAll;
v = Window("pedal setup", Rect(100, 1000, 500, 300))
.front
.alwaysOnTop_(true)
.background_(Color.white);

m = PopUpMenu(w, Rect(10, 10, 180, 20));

m.items = [
 "right view", "right thinking", "right mindfulness", "right speech",
 "right action", "right diligence", "right concentration", "right livelihood"
];
)