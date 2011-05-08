/**
 * cvi_istack_lib.js 1.1 (10-Aug-2010) (c) by Christian Effenberger 
 * All Rights Reserved. Source: istack.netzgesta.de
 * Library supports: cvi_bevel.js|cvi_corner.js|cvi_curl.js|cvi_edge.js|
 * cvi_glossy.js|cvi_instant.js|cvi_reflex.js|cvi_slide.js|cvi_sphere.js|cvi_strip
 * Distributed under Netzgestade Non-commercial Software License Agreement.
 * This license permits free of charge use on non-commercial 
 * and private web sites only under special conditions. 
 * Read more at... http://www.netzgesta.de/cvi/LICENSE.html

 syntax:
	cvi_istack.defaultImagearray		= null;			//OBJ e.g. photos
	
		var photos = [
			{source: 'path/file.jpg'},	// required
			{source: 'path/file.jpg', 			 
			options: '{tilt:"r"}'}		// optional
		];
	
	cvi_istack.defaultMainwidth		= 128;	//INT 80-n (px width) 
	cvi_istack.defaultMainheight	= 128;	//INT 80-n (px height)
	cvi_istack.defaultPlayframes	= 20; 	//INT 1-100 equals frames to fade (* 30 milliseconds)
	cvi_istack.defaultPlaydelay		= 5000; //INT 1000-n equals milliseconds (1/1000)
	cvi_istack.defaultLoadtimeout	= 3000	//INT 1000-n equals milliseconds (1/1000)
	cvi_istack.defaultNoiefade		= false;//BOOLEAN IE's Alpha filter produces rough edges
	cvi_istack.defaultPlayscript	= ''; 	//STRING e.g. 'cvi_bevel'|'cvi_corner'|'cvi_curl'|'cvi_edge'|'cvi_glossy'|'cvi_instant'|'cvi_reflex'|'cvi_slide'|'cvi_sphere'|'cvi_strip'
	
	cvi_istack.add( object, options );
	cvi_istack.play( object );
	cvi_istack.pause( object );
	cvi_istack.remove( object );
FLT=cvi_istack.version;
STR=cvi_istack.released;
	
 *
**/
	
var cvi_istack = {version : 1.0, released : '2009-06-17 13:36:00',
	defaultImagearray : null, defaultMainwidth : 128, defaultMainheight : 128, defaultLoadtimeout : 3000, defaultPlaydelay : 5000, defaultPlayframes : 20, defaultPlayscript : '',	defaultNoiefade : false,
	add : function(obj,opts) {function getArg(a,t) {return (typeof opts[a]===t?opts[a]:obj.opts[a]);};
		function uniqueID() {var val=Date.parse(new Date())+Math.floor(Math.random()*100000000000); return val.toString(16);}
		if(obj&&obj.tagName.toUpperCase()=="DIV"&&!obj.active) {var temp=cvi_istack.E('canvas'); 
			obj.trident=document.all&&document.namespaces&&!window.opera&&(!document.documentMode||document.documentMode<9)?1:0; obj.notrans=obj.trident&&!window.XMLHttpRequest?1:0; obj.canvas=temp.getContext?1:0; if(obj.trident||obj.canvas) {
			var defopts={"imagearray":cvi_istack.defaultImagearray, "mainwidth":cvi_istack.defaultMainwidth, "mainheight":cvi_istack.defaultMainheight, "loadtimeout":cvi_istack.defaultLoadtimeout, "playframes":cvi_istack.defaultPlayframes, "playdelay":cvi_istack.defaultPlaydelay, "playscript":cvi_istack.defaultPlayscript, "noiefade":cvi_istack.defaultNoiefade};
				if(opts) {for(i in defopts){if(!opts[i]){opts[i]=defopts[i];}}}else{opts=defopts;} temp=(typeof opts['imagearray']==='object'?opts['imagearray']:new Array());
				if(temp.length&&temp.length>=1) {
					obj.photo=temp; temp=''; delete opts['imagearray']; obj.id=obj.id!='undefined'?obj.id:uniqueID(); obj.opts=opts;   
					obj.mainwidth=parseInt(Math.max(32,getArg('mainwidth','number'))); obj.mainheight=parseInt(Math.max(32,getArg('mainheight','number')));
					obj.loadtimeout=parseInt(Math.max(1000,getArg('loadtimeout','number'))); obj.playframes=parseInt(Math.max(1,Math.min(100,getArg('playframes','number'))));
					obj.playdelay=parseInt(Math.max(1000,getArg('playdelay','number')))+(obj.trident&&obj.noiefade?0:(obj.playframes*30));
					obj.noiefade=getArg('noiefade','boolean'); obj.playscript=getArg('playscript','string'); obj.pureimgs=(obj.playscript==''?true:false);
					if(!obj.pureimgs) {obj.playscript+='.add'; obj.active=eval('typeof '+obj.playscript+'=="function";');}else{obj.active=true;}
					if(obj.active) {obj.innerHTML=''; cvi_istack._preload(obj,0,0);}else {obj.active=false; cvi_istack.L('error','[exit] cvi_istack.add(): unsupported playscript'); }
				}else {cvi_istack.L('error','[exit] cvi_istack.add(): insufficient images'); }
			}else {cvi_istack.L('error','[exit] cvi_istack.add(): unsupported browser'); }
		} return false; 
	},
	_preload : function(obj,cnt,cur) {
		if(obj&&typeof(obj.active)==="boolean"&&obj.active) {var ele,img=null;if(obj.timer) {window.clearTimeout(obj.timer);}
			if(cnt<obj.photo.length) {obj.timer=window.setTimeout(function() {cnt++; cvi_istack._preload(obj,cnt,cur);},obj.loadtimeout);
				img=new Image();
				img.onabort=function() {cnt=obj.photo.length; cvi_istack._preload(obj,cnt,cur);};
				img.onerror=function() {cnt++; cvi_istack._preload(obj,cnt,cur);}; 
				img.onload=function() {if(img.width&&img.height&&img.width>=32&&img.height>=32) {
					obj.photo[cnt].loaded=true; ele=cvi_istack.E('img'); ele.id=obj.id+"_"+cur; ele.src=img.src; 
					ele.style.position='absolute'; ele.style.display='block'; ele.style.visibility='hidden';
					ele.width=obj.mainwidth; ele.height=obj.mainheight; ele.style.width=obj.mainwidth+'px'; ele.style.height=obj.mainheight+'px'; ele.style.left='0px'; ele.style.top='0px'; obj.appendChild(ele);
					if(!obj.pureimgs) {if(obj.photo[cnt].options&&obj.photo[cnt].options!='') {eval(obj.playscript+'(ele,'+obj.photo[cnt].options+');');}else {eval(obj.playscript+'(ele);');}}
					} window.clearTimeout(obj.timer); if(obj.trident) {img.onload=''; img=null;} cnt++; cur++; cvi_istack._preload(obj,cnt,cur);
				}; img.src=obj.photo[cnt].source;
			}else {for(var i=0; i<obj.photo.length; i++) {if(!obj.photo[i].loaded) {obj.photo.splice(i,1); i--;}} obj.curimg=0; obj.lstimg=0; cvi_istack.play(obj);}
		}else {cvi_istack.L('warn','cvi_istack._preload(): object does not exist'); }return false;
	},
	play : function(obj) {
		if(obj&&typeof(obj.active)==="boolean"&&obj.active) {var fo,fi,fade,ele=cvi_istack.G(obj.id+'_'+obj.curimg); 
			if(ele) {ele.style.visibility='visible';}
				if(obj.photo.length>1) {if(obj.timer) {window.clearInterval(obj.timer);} obj.timer=window.setInterval(function() {
					obj.curimg=(obj.curimg<(obj.photo.length-1)?obj.curimg+1:0); var q=0,p=100,c=0,t=obj.playframes,k=p/t; 
					fi=cvi_istack.G(obj.id+'_'+obj.curimg); fo=cvi_istack.G(obj.id+'_'+obj.lstimg);
					if(fi&&fo) {if(obj.trident&&obj.noiefade) {fo.style.visibility='hidden'; fi.style.visibility='visible'; obj.lstimg=obj.curimg;}else {
							if(obj.trident) {fo.style.filter="alpha(opacity=100)";}else{fo.style.opacity=1;} fo.style.visibility='visible'; 
							if(obj.trident) {fi.style.filter="alpha(opacity=0)";}else{fi.style.opacity=0;} fi.style.visibility='visible';
							if(fade) {window.clearInterval(fade);} fade=window.setInterval(function() {q+=k; 
								if(obj.trident) {fi.style.filter="alpha(opacity="+q+")";}else{fi.style.opacity=q/100;} p-=k; 
								if(obj.trident) {fo.style.filter="alpha(opacity="+p+")";}else{fo.style.opacity=p/100;} c++; if(c>t) {window.clearInterval(fade); 
								if(obj.trident) {fi.style.filter="alpha(opacity=100)";fi.style.filter="";fo.style.filter="alpha(opacity=0)";}else{fi.style.opacity=1;fo.style.opacity=0;}
								fo.style.visibility='hidden'; obj.lstimg=obj.curimg;} 
							},30);
						}
					}else {window.clearInterval(obj.timer);}
				},obj.playdelay);
			}
		}else {cvi_istack.L('warn','cvi_istack.play(): object does not exist');}return false;
	},
	pause : function(obj) {if(obj&&typeof(obj.active)==="boolean"&&obj.active) {if(obj.timer) {window.clearInterval(obj.timer);}}else {cvi_istack.L('warn','cvi_istack.pause(): object does not exist');}return false;},
	remove : function(obj) {if(obj&&typeof(obj.active)==="boolean"&&obj.active) {if(obj.timer) {window.clearInterval(obj.timer);} if(!obj.trident) {var ele=obj.getElementsByTagName('canvas'); for(var i=0; i<ele.length; i++) {obj.removeChild(ele[i]);}} obj.innerHTML=''; obj.active=false;}else {cvi_istack.L('warn','cvi_istack.remove(): object does not exist');}return false;},
	L : function(s,v) {s=s.toLowerCase()||'log'; if(window.console) {window.console[s](v);}else if(window.opera) {opera.postError(s+': '+v);}else {window.document.title=s+': '+v;}},
	G : function(v) {return(document.getElementById(v));},
	E : function(v) {return(document.createElement(v));},
	A : function(o,v) {o.appendChild(v);}
}
