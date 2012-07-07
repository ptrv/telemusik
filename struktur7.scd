// Struktur 7

b = Buffer.read(s, "~/scwork/sub_repos/telemusik/snd/s67_1_2_3_4_full.wav".standardizePath);
b.play
b.free
(
SynthDef(\ringmods7, { |out=0, buf=0, amp=1|
    var snd;
    var in = PlayBuf.ar(1, buf);
    var rmodlvls = Control.names(\rmodlvls).kr([12000, 12000, 2000, 2000, 12000,12000]);
    var rmoddurs = Control.names(\rmoddurs).kr([13, 0.01, 0.68, 0.01, 13.3]);
    var rmodenv = Env(rmodlvls, rmoddurs);
    var rmodenvgen = EnvGen.ar(rmodenv, doneAction: 2);
    // var snd = in * SinOsc.kr(rmodenvgen);
    snd = in * SinOsc.ar(rmodenvgen);

    Out.ar(out, snd * amp)
}).send(s);
)

Synth(\ringmods7, [\buf, b, \amp, 3]);