//b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");

b = Buffer.read(s, "/home/peter/scwork/sub_repos/telemusik/snd/07_-_Seigaiha.wav");
b = Buffer.read(s, "/home/peter/scwork/sub_repos/telemusik/snd/12_-_Motomeko_No_Uta.wav");
b.query
(
SynthDef(\gagaku_schaltung, { arg out=0, buf=0, m1=12000, m2=12000,
    gain1=1.0, gain2=1.0, gain3=1.0, startpos=0;

    var gagaku, snd;
    var mod1, mod2;
    var filter1, filter2, filter3;
    var sigA, sigB, sigC, sigD;

    var ringenvlvl = Control.names(\rmenvlvl).kr([12000, 12000, 11950, 12000, 12000]);
    var ringenvdur = Control.names(\rmenvdur).kr([22.6, 4.4, 4.4, 2.6]);

    var ringenv = Env(ringenvlvl, ringenvdur);
    var ringenvgen = EnvGen.ar(ringenv, doneAction: 2);

    var ringbamplvl = Control.names(\ringbamplvl).kr([0, 0, 0.5, 0.5,0,0,0.5,0.5,0]);
    var ringbampdur = Control.names(\ringbampdur).kr([8,0.1,2.8,0.1,10, 0.1,10.3,2.6]);

    var ringbampenv = Env(ringbamplvl, ringbampdur);
    var ringbampenvgen = EnvGen.ar(ringbampenv, doneAction: 0);
    var ringblvl = ringbampenvgen;

    gagaku = PlayBuf.ar(2, buf, loop:1, startPos: startpos);
    mod1 = SinOsc.ar(m1);
    mod2 = SinOsc.ar(ringenvgen);
    filter1 = LPF.ar(gagaku, 6000);
    sigA = filter1 * mod1;
    filter2 = HPF.ar(sigA, 6000);
    sigB = filter2 * mod2;
    sigB = sigB * gain2;
    filter3 = LPF.ar(sigB, 5500);
    sigD = filter3 * ringblvl;
    sigC = sigA * (-10.dbamp);
    snd = sigC + sigD;
    Out.ar(out, snd*0.5);
}).send(s);
)

a = Synth(\gagaku_schaltung, [\buf, b, \startpos, 1000000]);



// --------- experiments ----------
a.set(\m1, 12000);
a.set(\m2, 12000);

b.postln;
b.numChannels


(
a = Synth(\gagaku_schaltung, [\buf, b, \startpos, 1000000]);

w = Window.new;
c = Slider(w, Rect(20, 60, 20, 150))
.action_({
    a.set(\gain1, c.value)
});
c.value = 1.0;
d = Slider(w, Rect(50, 60, 20, 150))
.action_({
    a.set(\gain2, d.value)
});
d.value = 1.0;
e = Slider(w, Rect(80, 60, 20, 150))
.action_({
    a.set(\gain3, e.value)
});
e.value = 1.0;
f = Slider(w, Rect(120, 60, 20, 150))
.action_({
    a.set(\m1, f.value*12000)
});
f.value = 12000.0;
g = Slider(w, Rect(150, 60, 20, 150))
.action_({
    a.set(\m2, g.value*100 + 11900)
});
g.value = 12000.0;

w.onClose = { a.free;};
w.front;
)
