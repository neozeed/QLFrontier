'use strict';
const $=id=>document.getElementById(id),canvas=$('canvas'),query=new URLSearchParams(location.search);
const defaults=Object.assign({zip:'',rom:'minerva',ram:1024,speed:8,timing:'fast',run:''},window.QLBOX_CONFIG||{});
let ready=false,started=false,ended=false,busy=false,archive=null,muted=false,selectedSpeed=8,loadId=0,driveRoot='',currentName='drive.zip',analyser=null,levels=null;
function log(s){$('log').textContent=($('log').textContent+String(s)+'\n').slice(-20000)}
function error(e){log(e);$('status').textContent=String(e.message||e);$('hint').textContent=String(e.message||e);if(!started)$('mount').open=true;refresh()}
function refresh(){ $('start').disabled=!ready||!archive||busy||started; $('start').textContent=busy?'Loading ZIP…':!ready?'Loading QLBox…':'Start QLBox'; }
function audioContext(){return Module.SDL2&&Module.SDL2.audioContext}
function option(parent,value,text){const o=document.createElement('option');o.value=value;o.textContent=text;parent.appendChild(o)}
function chooseSpeed(value){value=Number(value);if(!Number.isInteger(value)||value<1||value>64)throw Error('CPU speed must be 1–64');if(started&&!ended)value=Module._ql_web_set_speed(value);selectedSpeed=value;document.querySelectorAll('[data-speed]').forEach(b=>b.setAttribute('aria-pressed',String(Number(b.dataset.speed)===value)));}
function configuredValue(name,fallback){return query.has(name)?query.get(name):fallback}
function programs(preferred){
 const root=$('root').value,prefix=root?root+'/':'';$('program').replaceChildren();option($('program'),'','Boot BASIC / ZIP’s boot file');
 for(const [path,item]of archive.files){if(!path.startsWith(prefix))continue;const n=path.slice(prefix.length);if(n.includes('/')||n.length>36)continue;
 const meta=archive.files.get(prefix+'.qlbox-meta/'+Array.from(new TextEncoder().encode(n.toLowerCase()),b=>b.toString(16).padStart(2,'0')).join('')+'.hdr');
 if(QLZip.executable(item)||(meta&&meta.data[5]===1))option($('program'),n,n);
 }
 if(preferred){if(!Array.from($('program').options).some(o=>o.value===preferred))throw Error('Launch executable not found in selected drive folder: '+preferred);$('program').value=preferred}
}
function acceptZip(bytes,name,useDefaults){
 const next=QLZip.parse(bytes);const m=next.manifest;
 const cfg=Object.assign({},useDefaults?defaults:{rom:'minerva',ram:1024,speed:8,timing:'fast',run:''},m);
 for(const key of ['rom','ram','speed','timing','run','root'])if(query.has(key))cfg[key]=query.get(key);
 if(!['minerva','js'].includes(cfg.rom))throw Error('ROM must be minerva or js');
 if(!['fast','68008','ql'].includes(cfg.timing))throw Error('Timing must be fast, 68008 or ql');
 if(!Array.from($('ram').options).some(o=>Number(o.value)===Number(cfg.ram)))throw Error('Unsupported RAM preset');
 if(Number(cfg.ram)>640&&cfg.rom!=='minerva')throw Error('RAM above 640 KB requires Minerva');
 archive=next;currentName=name;$('root').replaceChildren();const folders=new Set(['']);
 for(const path of next.files.keys()){const split=path.split('/');split.pop();let p='';for(const part of split){p+=(p?'/':'')+part;if(!p.split('/').some(x=>x.startsWith('.')))folders.add(p)}}
 for(const path of [...folders].sort())option($('root'),path,path||'(ZIP root)');
 let root=cfg.root||'';
 if(!cfg.root&&cfg.run&&!next.files.has(cfg.run)){const matches=[...next.files.keys()].filter(p=>p.endsWith('/'+cfg.run));if(matches.length===1)root=matches[0].slice(0,-cfg.run.length-1)}
 if(!folders.has(root))throw Error('Drive folder not found: '+root);$('root').value=root;
 $('rom').value=cfg.rom;$('ram').value=String(cfg.ram);$('timing').value=cfg.timing;chooseSpeed(cfg.speed);programs(cfg.run||'');
 $('fileline').textContent=name+' · '+next.files.size+' files · '+(Array.from(next.files.values()).reduce((n,f)=>n+f.data.length,0)/1024).toFixed(0)+' KB unpacked';
 if(typeof cfg.title==='string')$('title').textContent=cfg.title;
 $('hint').textContent='Ready. Click to boot and enable browser audio.';$('status').textContent='ZIP ready · '+$('rom').selectedOptions[0].textContent+' · '+$('ram').selectedOptions[0].textContent;refresh();
}
async function readURL(url){
 const u=new URL(url,location.href);if(!['https:','http:'].includes(u.protocol))throw Error('ZIP URL must use HTTP or HTTPS');
 const r=await fetch(u.href,{credentials:'omit'});if(!r.ok)throw Error('ZIP download failed: HTTP '+r.status+' — '+u.href);
 if(Number(r.headers.get('Content-Length'))>QLZip.MAX_ZIP)throw Error('ZIP is larger than 32 MiB');
 const reader=r.body.getReader(),parts=[];let n=0;
 try{for(;;){const x=await reader.read();if(x.done)break;n+=x.value.length;if(n>QLZip.MAX_ZIP)throw Error('ZIP is larger than 32 MiB');parts.push(x.value)}}catch(e){await reader.cancel();throw e}
 const bytes=new Uint8Array(n);let p=0;for(const part of parts){bytes.set(part,p);p+=part.length}return bytes;
}
async function loadZip(source,isFile=false,useDefaults=false){
 if(started)return;const id=++loadId;busy=true;archive=null;refresh();$('status').textContent='Loading ZIP…';
 try{if(isFile&&source.size>QLZip.MAX_ZIP)throw Error('ZIP is larger than 32 MiB');const bytes=isFile?new Uint8Array(await source.arrayBuffer()):await readURL(source);if(id!==loadId)return;acceptZip(bytes,isFile?source.name:source,useDefaults)}catch(e){if(id===loadId){archive=null;error(e)}}finally{if(id===loadId){busy=false;refresh()}}
}
var Module={canvas,noInitialRun:true,print:log,printErr:log,onRuntimeInitialized(){ready=true;refresh()},onAbort(reason){ended=true;error('Emulator stopped: '+reason)},onExit(code){ended=true;$('status').textContent='Program ended ('+code+'). Download your drive before restarting.';$('sound').disabled=true;$('mouse').disabled=true}};
$('root').onchange=()=>{try{programs('')}catch(e){error(e)}};
$('file').onchange=()=>{if($('file').files[0])loadZip($('file').files[0],true)};
$('loadurl').onclick=()=>loadZip($('url').value);
document.querySelectorAll('[data-speed]').forEach(b=>b.onclick=()=>{try{chooseSpeed(b.dataset.speed);if(started)canvas.focus()}catch(e){error(e)}});
$('start').onclick=()=>{
 if(started||!ready||!archive||busy)return;
 try{
  const ram=Number($('ram').value),rom=$('rom').value;if(ram>640&&rom!=='minerva')throw Error('RAM above 640 KB requires Minerva');
  QLZip.mount(Module.FS,archive);driveRoot='/drive'+($('root').value?'/'+$('root').value:'');
  const args=['--no-config','--rom',rom,'--ram',String(ram),'--modem','off','--speed',String(selectedSpeed),'--timing',$('timing').value];
  if(ram>640)args.push('--no-qsound');
  if($('program').value)args.push('--run',driveRoot+'/'+$('program').value);else args.push('--mount',driveRoot);
  log('qlbox '+args.join(' '));started=true;$('overlay').hidden=true;$('mount').open=false;
  $('mount').querySelectorAll('input,select,button').forEach(e=>e.disabled=true);$('download').disabled=false;$('sound').disabled=false;
  canvas.focus();Module.callMain(args);const a=audioContext();if(a)a.resume().catch(error);
 }catch(e){if(e!=='unwind'){if(started)ended=true;error(e)}}
};
$('sound').onclick=async()=>{const a=audioContext();if(!a){error('Audio device unavailable');return}try{muted=!muted;await(muted?a.suspend():a.resume());$('sound').textContent=muted?'Enable sound':'Mute sound';$('sound').setAttribute('aria-pressed',String(muted));canvas.focus()}catch(e){error(e)}};
$('mouse').onclick=()=>{canvas.focus();Module._ql_web_toggle_mouse()};
$('fullscreen').onclick=()=>{const p=document.fullscreenElement?document.exitFullscreen():$('screen').requestFullscreen();if(p)p.catch(error)};
$('exitfull').onclick=()=>document.exitFullscreen();
$('restart').onclick=()=>{if(!started||confirm('Restart clears this browser drive. Download your drive ZIP first if you have saves to keep. Restart now?'))location.reload()};
$('download').onclick=()=>{
 try{const files=Object.create(null),FS=Module.FS;function walk(dir,prefix){for(const n of FS.readdir(dir)){if(n==='.'||n==='..')continue;const full=dir+'/'+n,path=prefix+n,stat=FS.stat(full);if(FS.isDir(stat.mode))walk(full,path+'/');else if(FS.isFile(stat.mode))files[path]=FS.readFile(full)}}walk('/drive','');
 files['qlbox.json']=new TextEncoder().encode(JSON.stringify({title:$('title').textContent,root:$('root').value,run:$('program').value,rom:$('rom').value,ram:Number($('ram').value),speed:selectedSpeed,timing:$('timing').value},null,2));
 const blob=new Blob([fflate.zipSync(files,{level:6})],{type:'application/zip'}),url=URL.createObjectURL(blob),a=document.createElement('a');a.href=url;a.download='qlbox-drive-with-saves.zip';a.click();setTimeout(()=>URL.revokeObjectURL(url),10000);
 }catch(e){error(e)}
};
canvas.addEventListener('contextmenu',e=>e.preventDefault());
let browserHadCapture=false;
document.addEventListener('pointerlockchange',()=>{const locked=document.pointerLockElement===canvas;if(browserHadCapture&&!locked&&started&&!ended&&Module._ql_web_mouse_captured())Module._ql_web_toggle_mouse();browserHadCapture=locked});
document.addEventListener('pointerlockerror',()=>{if(started&&!ended&&Module._ql_web_mouse_captured())Module._ql_web_toggle_mouse();log('Browser mouse capture was unavailable; try Capture mouse again.');});
let lastFrame=0,lastTime=performance.now();
setInterval(()=>{if(!started||ended)return;
 const now=performance.now(),frame=Module._ql_web_get_frame(),hz=(frame-lastFrame)*1000/(now-lastTime);lastFrame=frame;lastTime=now;
 const actual=Module._ql_web_get_speed();if(actual!==selectedSpeed)chooseSpeed(actual);
 $('mouse').disabled=!Module._ql_web_mouse_active()&&!Module._ql_web_mouse_captured();$('mouse').textContent=Module._ql_web_mouse_captured()?'Release mouse':'Capture mouse';
 const a=audioContext();let sound='No audio device';if(a){if(!analyser&&Module.SDL2.audio&&Module.SDL2.audio.scriptProcessorNode){analyser=a.createAnalyser();analyser.fftSize=256;levels=new Float32Array(256);const node=Module.SDL2.audio.scriptProcessorNode;node.disconnect();node.connect(analyser);analyser.connect(a.destination)}let peak=0;if(analyser){analyser.getFloatTimeDomainData(levels);for(const v of levels)peak=Math.max(peak,Math.abs(v))}sound=muted?'Muted':a.state==='running'?(peak>0.001?'Audio playing':'Audio ready'):'Audio suspended'}
 $('status').textContent=selectedSpeed+'× CPU · '+hz.toFixed(1)+' / 50 guest frames/s · frame '+frame+' · '+sound;
},1000);
const script=document.createElement('script');script.src='qlbox.js';script.onerror=()=>{ended=true;error('Could not load qlbox.js. Keep all release files together and serve over HTTP or HTTPS.')};document.body.appendChild(script);
const initial=query.get('zip')||defaults.zip;$('url').value=initial;if(initial)loadZip(initial,false,!query.has('zip'));refresh();
