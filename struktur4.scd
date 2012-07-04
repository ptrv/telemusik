// Struktur 4

// a
(

var numSinesGroups = [12, 12, 9, 6, 3];
var sineFreqs = Array.new;

numSinesGroups[0].do({arg i; sineFreqs = sineFreqs.add(11350 + (i*50))});
numSinesGroups[1].do({arg i; sineFreqs = sineFreqs.add(10200 + (i*100))});
numSinesGroups[2].do({arg i; sineFreqs = sineFreqs.add(9300 + (i*100))});
numSinesGroups[3].do({arg i; sineFreqs = sineFreqs.add(9700 + (i*100))});
numSinesGroups[4].do({arg i; sineFreqs = sineFreqs.add(8400 + (i*100))});

{
    var env = Env([0.9,0.9], [14]);
    var envgen = EnvGen.ar(env, doneAction: 2);
    Mix.fill(numSinesGroups.sum,
        {arg i; SinOsc.ar(sineFreqs[i], 0, numSinesGroups.sum.reciprocal*envgen)});
}.play;
)

// b
(
var numSines = 9;
{
    var env = Env([1,1], [14]);
    var envgen = EnvGen.ar(env, doneAction: 2);
    Mix.fill(
        numSines,
        {arg i; SinOsc.ar(7100 + (i*100), 0, numSines.reciprocal*envgen)});
}.play;
)

// c
(
var numSines = 9;
{
    var env = Env([1,1], [14]);
    var envgen = EnvGen.ar(env, doneAction: 2);
    Mix.fill(
        numSines,
        {arg i; SinOsc.ar(6100 + (i*100), 0, numSines.reciprocal*envgen)});
}.play;
)

(
SynthDef(\ringmod_s4_1, { |out=0, amp=1.0|
    var in = SoundIn.ar(0);
    var rmodlvls = Control.names(\rmodlvl).kr([18000, 12370, 7320, 7320]);
    var rmoddurs = Control.names(\rmoddur).kr([3, 3, 8]);
    var rmodenv = Env(rmodlvls, rmoddurs);
    var rmodenvgen = EnvGen.ar(rmodenv, doneAction: 2);
    var snd = in * SinOsc.kr(rmodenvgen);
    Out.ar(out, snd * amp);
}).send(s);
)

// d
(
a = Synth(\ringmod_s4_1,
    [
        \rmodlvl, [18000, 12370, 7320, 7320],
        \rmoddur, [3, 3, 8]
    ]
);
)

// e
(
a = Synth(\ringmod_s4_1,
    [
        \rmodlvl, [6480, 8900, 11085, 18000],
        \rmoddur, [5, 4, 5]
    ]
);
)