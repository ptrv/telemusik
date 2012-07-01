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

    gagaku = PlayBuf.ar(2, buf, loop:1);
    mod1 = SinOsc.ar(m1);
    mod2 = SinOsc.ar(m2);
    filter1 = LPF.ar(gagaku, 6000);
    sigA = filter1 * mod1;
    filter2 = HPF.ar(sigA, 6000);
    sigB = filter2 * mod2;
    sigB = sigB * gain2;
    filter3 = LPF.ar(sigB, 5500);
    sigD = filter3 * gain3;
    sigC = sigA * gain1;
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
