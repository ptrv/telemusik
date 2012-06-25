
b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");
(
SynthDef(\gagakuschaltung, { |out=0, buf=0|
    var gagaku = PlayBuf.ar(1, buf, loop:1);
    var mod1 = SinOsc.ar(12000);
    var mod2 = SinOsc.ar(12000);
    var filter1 = LPF.ar(gagaku, 6000);
    var sigA = filter1 * mod1;
    var filter2 = HPF.ar(sigA, 6000);
    var sigB = filter2 * mod2;
    var filter3 = LPF.ar(sigB, 5500);

    var snd = sigA + sigB;
    Out.ar(out, snd);
}).send(s);
)

a = Synth(\gagakuschaltung, b);
