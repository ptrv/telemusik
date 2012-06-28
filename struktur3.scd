// Circuit Struktur 3

(
SynthDef(\struktur3, { arg out=0,
    lvl1=1.0,lvl2=1.0,lvl3=1.0,lvl4=1.0,lvl5=1.0;
    var snd;
    var osc1, osc2, osc3;
    var sigA, sigB;
    var ringIn1, ringIn2, ringOut;

    osc1 = SinOsc.ar(9500);
    osc2 = SinOsc.ar(11350);
    osc3 = SinOsc.ar(12000);

    sigA = (osc1 + osc2 + osc3) / 3;
    sigA = sigA * lvl4;

    ringIn1 = (osc1 * lvl1) + (osc2 * lvl2);
    ringIn1 = ringIn1 / 2;
    ringIn2 = osc3 * lvl3;

    ringOut = ringIn1 * ringIn2;

    sigB = ringOut * lvl5;
    snd = sigA + sigB;

    Out.ar(out, (snd * 0.5) ! 2);
}).send(s);
)

(
a = Synth(\struktur3);

w = Window.new;
c = Slider(w, Rect(20, 60, 20, 150))
.action_({
    a.set(\lvl1, c.value)
});
c.value = 1.0;
d = Slider(w, Rect(50, 60, 20, 150))
.action_({
    a.set(\lvl2, d.value)
});
d.value = 1.0;
e = Slider(w, Rect(80, 60, 20, 150))
.action_({
    a.set(\lvl3, e.value)
});
e.value = 1.0;
f = Slider(w, Rect(120, 60, 20, 150))
.action_({
    a.set(\lvl4, f.value)
});
f.value = 1.0;
g = Slider(w, Rect(150, 60, 20, 150))
.action_({
    a.set(\lvl5, g.value)
});
g.value = 1.0;

w.onClose = { a.free;};
w.front;
)
