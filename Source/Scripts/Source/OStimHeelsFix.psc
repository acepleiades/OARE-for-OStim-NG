Scriptname OStimHeelsFix extends Quest

osexintegrationmain ostim

float[] domtf
float[] subtf
float[] thirdtf

string skeleton = "NPC"

actor dom
actor sub
actor third

event oninit()
	ostim = OUtils.GetOStim()
	registerformodevent("ostim_start", "scenestart")
	registerformodevent("ostim_end", "sceneend")
	registerformodevent("ostim_thirdactor_join", "thirdjoin")
	registerformodevent("ostim_thirdactor_leave", "thirdleave")
	registerformodevent("ostim_scenechanged", "scenechange")
endevent

event scenestart(string eventname, string strarg, float numarg, form sender)
	dom = ostim.getdomactor()
	domtf = nioverride.getnodetransformposition(dom, false, ostim.isfemale(dom), skeleton, "internal")
	sub = ostim.getsubactor()
	subtf = nioverride.getnodetransformposition(sub, false, ostim.isfemale(sub), skeleton, "internal")
	third = ostim.getthirdactor()
	thirdtf = nioverride.getnodetransformposition(third, false, ostim.isfemale(third), skeleton, "internal")
	fixheels(dom)
	fixheels(sub)
	fixheels(third)
endevent

event thirdjoin(string eventname, string strarg, float numarg, form sender)
	third = ostim.getthirdactor()
	thirdtf = nioverride.getnodetransformposition(third, false, ostim.isfemale(third), skeleton, "internal")
	fixheels(third)
endevent

event scenechange(string eventname, string strarg, float numarg, form sender)
	fixheels(dom)
	fixheels(sub)
	fixheels(third)
endevent

event sceneend(string eventname, string strarg, float numarg, form sender)
	nioverride.addnodetransformposition(dom, false, ostim.isfemale(dom), skeleton, "internal", domtf)
	nioverride.updatenodetransform(dom, false, ostim.isfemale(dom), skeleton)
	nioverride.addnodetransformposition(sub, false, ostim.isfemale(sub), skeleton, "internal", subtf)
	nioverride.updatenodetransform(sub, false, ostim.isfemale(sub), skeleton)
	nioverride.addnodetransformposition(third, false, ostim.isfemale(third), skeleton, "internal", thirdtf)
	nioverride.updatenodetransform(third, false, ostim.isfemale(third), skeleton)
endevent

event thirdleave(string eventname, string strarg, float numarg, form sender)
	nioverride.addnodetransformposition(third, false, ostim.isfemale(third), skeleton, "internal", thirdtf)
	nioverride.updatenodetransform(third, false, ostim.isfemale(third), skeleton)
endevent

function fixheels(actor a)
	if nioverride.hasnodetransformposition(a, false, ostim.isfemale(a), skeleton, "internal") && (a != none)
		nioverride.removenodetransformposition(a, false, ostim.isfemale(a), skeleton, "internal")
		nioverride.updatenodetransform(a, false, ostim.isfemale(a), skeleton)
	endif
endfunction

OsexIntegrationMain property ostim auto
