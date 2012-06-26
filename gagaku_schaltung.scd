
//b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");

b = Buffer.read(s, "/home/peter/scwork/sub_repos/telemusik/snd/07_-_Seigaiha.wav");
(
SynthDef(\gagakuschaltung, { |out=0, buf=0, m1=12000, m2=12000, 
    gain1=1.0, gain2=1.0, gain3=1.0|

    var gagaku = PlayBuf.ar(2, buf, loop:1);
    var mod1 = SinOsc.ar(m1);
    var mod2 = SinOsc.ar(m2);
    var filter1 = LPF.ar(gagaku, 6000);
    var sigA = filter1 * mod1;
    var filter2 = HPF.ar(sigA, 6000);
    var sigB = filter2 * mod2 * gain2;
    var filter3 = LPF.ar(sigB, 5500);
    var sigD = filter3 * gain3;
    var sigC = sigA * gain1;
    var snd = sigC + sigD;
    Out.ar(out, snd*0.5);
}).send(s);
)

a = Synth(\gagakuschaltung, b);
a.set(\m1, 6000);
a.set(\m2, 1000);

(
w = Window.new.front;
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
)
