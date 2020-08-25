(
Synth(\pizzDetective, [\thresh: 3]);

OSCdef(\pizzDet, { arg msg, time, addr, recvPort;

	"we heard a pizz!".postln;
	Synth(\bassPizz);
}, \tr);
);

OSCdef(\pizzDet).disable;







