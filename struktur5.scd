// Circuit Struktur 5

(
SynthDef(\struktur5, { |out=0, lvl=1.0, buf=0|
    var snd;
    var sig;
    var osc1, osc2, osc3;
    var ringIn1, ringIn2;
    osc1 = SinOsc.ar(12000);
    osc2 = SinOsc.ar(11900);
    osc3 = SinOsc.ar(11800);

    ringIn1 = (osc1 + osc2 + osc3) / 3;
    // TODO change ringIn2 to real source
    ringIn2 = PlayBuf.ar(2, buf, loop:1);


    sig = ringIn1 * ringIn2;

    sig = sig * LFTri.ar(70);
    sig = sig * lvl;

    snd = LPF.ar(sig, 6000);
    Out.ar(out, snd);
}).send(s);
)

a = Synth(\struktur5);
