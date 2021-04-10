local FaustSnips = {}

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

return FaustSnips
