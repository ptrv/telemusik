// Struktur 1

// Track 1
(
{
    var amp = 0.1;
    var env = Env([1,1, -1, -1], [13.5, 0.1, 7.4], \lin);
    var envgen = EnvGen.ar(env, doneAction: 2);
    var freqs = [
        envgen * 250 + 9000,
        envgen * 500 + 9000,
        envgen * 750 + 9000,
        envgen * 1000 + 9000,
        envgen * 1250 + 9000,
        envgen * 1500 + 9000,
        envgen * 1750 + 9000,
        envgen * 2000 + 9000,
        envgen * 2250 + 9000,
        envgen * 2500 + 9000
    ];
    Mix.new([
        SinOsc.ar(freqs[0], 0, amp),
        SinOsc.ar(freqs[1], 0, amp),
        SinOsc.ar(freqs[2], 0, amp),
        SinOsc.ar(freqs[3], 0, amp),
        SinOsc.ar(freqs[4], 0, amp),
        SinOsc.ar(freqs[5], 0, amp),
        SinOsc.ar(freqs[6], 0, amp),
        SinOsc.ar(freqs[7], 0, amp),
        SinOsc.ar(freqs[8], 0, amp),
        SinOsc.ar(freqs[9], 0, amp)
    ]);
}.play
);

// Track 2
(
{
    var amp = 1/8;
    var env = Env([1,1], [21]);
    var envgen = EnvGen.ar(env, doneAction: 2);
    var freqs = [
        envgen * 0 + 6000,
        envgen * 50 + 6000,
        envgen * 3000 + 6000,
        envgen * 3050 + 6000,
        envgen * 2500 + 6000,
        envgen * 2550 + 6000,
        envgen * 3500 + 6000,
        envgen * 3550 + 6000
    ];
    Mix.new([
        SinOsc.ar(freqs[0], 0, amp),
        SinOsc.ar(freqs[1], 0, amp),
        SinOsc.ar(freqs[2], 0, amp),
        SinOsc.ar(freqs[3], 0, amp),
        SinOsc.ar(freqs[4], 0, amp),
        SinOsc.ar(freqs[5], 0, amp),
        SinOsc.ar(freqs[6], 0, amp),
        SinOsc.ar(freqs[7], 0, amp)
    ]);
}.play;
);

// Track 3
(
{
    var amp = 1/6;
    var env1 = Env([1,0.5,1,0.8], [10, 4.5, 6.5]);
    var env2 = Env([1,0.8,1,1], [10, 4.5, 6.5]);
    var env3 = Env([1,1,0.6,0.6], [10, 4.5, 6.5]);
    var envgen1 = EnvGen.ar(env1, doneAction: 2);
    var envgen2 = EnvGen.ar(env2, doneAction: 2);
    var envgen3 = EnvGen.ar(env3, doneAction: 2);
    var ampenv = Env([0,0,1,1,0,0,1,1,0,0,1,1,0,0],
        [8, 0.01, 1.48, 0.01, 2.5,0.01, 1.98,0.01, 1,0.01, 1.58, 0.01, 4.4]);
    var ampgen = EnvGen.kr(ampenv);
    var freqs = [
        envgen1 * 1000 + 6000,
        envgen1 * 1020 + 6000,
        envgen2 * 2000 + 6000,
        envgen2 * 2020 + 6000,
        envgen3 * 3500 + 6000,
        envgen2 * 3520 + 6000
    ];
    Mix.new([
        SinOsc.ar(freqs[0], 0, amp) * ampgen,
        SinOsc.ar(freqs[1], 0, amp) * ampgen,
        SinOsc.ar(freqs[2], 0, amp) * ampgen,
        SinOsc.ar(freqs[3], 0, amp) * ampgen,
        SinOsc.ar(freqs[4], 0, amp) * ampgen,
        SinOsc.ar(freqs[5], 0, amp) * ampgen
    ]);
}.play;
);

// Track 4
(
{
    var amp = 1/4;
    var env = Env([0.3,0.3,-0.1,0.2,0.8,0.6], [8, 3, 3.5, 2, 4.5]);
    var envgen = EnvGen.ar(env, doneAction: 2);
    var ampenv = Env([0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0],
        [5.1, 0.01, 0.18, 0.01, 3.2, 0.01, 0.18, 0.01, 5.2, 0.01, 0.18, 0.01, 1.0, 0.01, 0.18,0.01, 2.5, 0.01, 0.18,0.01, 3.0]);
    var ampgen = EnvGen.kr(ampenv);
    var freqs = [
        envgen * 6000 + 6000,
        envgen * 6005 + 6000,
        envgen * 5900 + 6000,
        envgen * 5905 + 6000
    ];
    Mix.new([
        SinOsc.ar(freqs[0], 0, amp) * ampgen,
        SinOsc.ar(freqs[1], 0, amp) * ampgen,
        SinOsc.ar(freqs[2], 0, amp) * ampgen,
        SinOsc.ar(freqs[3], 0, amp) * ampgen
    ]);
}.play;
);

(
SynthDef(\ringmod_s1, { |out=0, freq=12000|
    var in = SoundIn.ar(0);
    var snd = in * SinOsc.ar(freq);
    Out.ar(out, snd);
}).send(s);

)

a = Synth(\ringmod_s1);