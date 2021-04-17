local FaustSnips = {}

FaustSnips["import"] = [[import("${1:stdfaust}.lib");]];

FaustSnips["example"] = [[import("stdfaust.lib");

normFreq = vslider("freq",0.1,0.0,1.0,0.1);
Q = vslider("Q",0.1,0.0,1.0,0.1);

process = _ : ve.korg35LPF(normFreq,Q) : _;]]

FaustSnips["hslider"] = {
	"hslider(",
	{ order=1, id="name", default="vol", is_input=true, transform=function(S) return "\"" .. S.v .. "\"" end},
	",",
	{ order=2, id="default", default="0.1", is_input=true },
	",",
	{ order=3, id="minimum", default="0.0", is_input=true },
	",",
	{ order=4, id="maximum", default="1.0", is_input=true },
	",",
	{ order=5, id="stepvalue", default="0.1", is_input=true },
	")"
};

FaustSnips["hsl"] = FaustSnips["hslider"];

FaustSnips["vslider"] = {
	"vslider(",
	{ order=1, id="name", default="vol", is_input=true, transform=function(S) return "\"" .. S.v .. "\"" end },
	",",
	{ order=2, id="default", default="0.1", is_input=true },
	",",
	{ order=3, id="minimum", default="0.0", is_input=true },
	",",
	{ order=4, id="maximum", default="1.0", is_input=true },
	",",
	{ order=5, id="stepvalue", default="0.1", is_input=true },
	")"
};

FaustSnips["vsl"] = FaustSnips["vslider"]
FaustSnips["sl"] = FaustSnips["vslider"]


-- delays
FaustSnips["sdelay"] = [[de.sdelay(${1:maxdelay},${2:interptime},${3:delaytime})]];
FaustSnips["fdelay"] = [[de.fdelay(${1:maxdelay},${2:delaytime})]];
FaustSnips["delay"] = [[de.delay(${1:maxdelay},${2:delaytime})]];
FaustSnips["fdelayltv"] = [[de.fdelayltv(${1:order},${2:maxdelay}, ${3:delay}, ${4:inputsignal})]];
FaustSnips["fdelaylti"] = [[de.fdelaylti(${1:order},${2:maxdelay}, ${3:delay}, ${4:inputsignal})]];

return FaustSnips
