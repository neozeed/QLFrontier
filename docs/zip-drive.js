/* ZIP-to-drive adapter. No extraction reaches the host filesystem.
 * Supports stored/deflated classic ZIP, QDOS02 extra headers and XTcc payloads.
 * Limits are checked before allocation; CRC and sizes are checked before mounting. */
(function(root,factory){
  if(typeof module==='object'&&module.exports)module.exports=factory(require('./vendor/fflate.js'));
  else root.QLZip=factory(root.fflate);
})(typeof globalThis!=='undefined'?globalThis:this,function(fflate){
'use strict';
const MAX_ZIP=32*1024*1024,MAX_TOTAL=64*1024*1024,MAX_FILE=16*1024*1024,MAX_FILES=4096;
const table=new Uint32Array(256);
for(let n=0;n<256;n++){let c=n;for(let k=0;k<8;k++)c=c&1?0xedb88320^(c>>>1):c>>>1;table[n]=c>>>0}
function crc32(a){let c=0xffffffff;for(const b of a)c=table[(c^b)&255]^(c>>>8);return(c^0xffffffff)>>>0}
function cleanPath(name){
  if(!name||name.length>1024||/^[\/\\]|[\\\x00-\x1f\x7f:]/.test(name))throw Error('Unsafe ZIP path: '+name);
  const parts=name.replace(/\/$/,'').split('/');
  if(parts.some(p=>!p||p==='.'||p==='..'))throw Error('Unsafe ZIP path: '+name);
  return parts.join('/');
}
function qdosHeader(extra){
  const v=new DataView(extra.buffer,extra.byteOffset,extra.byteLength);
  for(let i=0;i<extra.length;){
    if(i+4>extra.length)throw Error('Truncated ZIP extra field');
    const tag=v.getUint16(i,true),n=v.getUint16(i+2,true);i+=4;
    if(i+n>extra.length)throw Error('Truncated ZIP extra field');
    if(tag===0xfb4a){
      if(n!==72||String.fromCharCode(...extra.subarray(i,i+8))!=='QDOS02\0\0')throw Error('Unsupported QDOS ZIP metadata');
      return extra.slice(i+8,i+72);
    }i+=n;
  }return null;
}
function parse(input){
  const a=input instanceof Uint8Array?input:new Uint8Array(input),v=new DataView(a.buffer,a.byteOffset,a.byteLength);
  const need=(p,n)=>{if(p<0||p+n>a.length)throw Error('Truncated ZIP')};
  const u16=p=>{need(p,2);return v.getUint16(p,true)},u32=p=>{need(p,4);return v.getUint32(p,true)};
  if(a.length>MAX_ZIP)throw Error('ZIP exceeds the 32 MiB compressed limit');
  let end=-1;
  for(let p=a.length-22;p>=Math.max(0,a.length-65557);p--)if(u32(p)===0x06054b50&&p+22+u16(p+20)===a.length){end=p;break}
  if(end<0)throw Error('Not a complete ZIP file');
  const count=u16(end+10),cdSize=u32(end+12),cd=u32(end+16);
  if(u16(end+4)||u16(end+6)||u16(end+8)!==count||count===65535||cd===0xffffffff||cdSize===0xffffffff)throw Error('Split and ZIP64 archives are not supported');
  if(count>MAX_FILES||cd+cdSize!==end)throw Error('Invalid or oversized ZIP directory');
  const decoder=new TextDecoder('utf-8',{fatal:true}),entries=[],seen=new Set();let pos=cd,total=0;
  for(let i=0;i<count;i++){
    need(pos,46);if(u32(pos)!==0x02014b50)throw Error('Invalid ZIP directory entry');
    const flags=u16(pos+8),method=u16(pos+10),crc=u32(pos+16),packed=u32(pos+20),size=u32(pos+24),nl=u16(pos+28),xl=u16(pos+30),cl=u16(pos+32),off=u32(pos+42),attr=u32(pos+38);
    if(flags&1||flags&64)throw Error('Encrypted ZIPs are not supported');
    if(method!==0&&method!==8)throw Error('Use ZIP store or deflate compression');
    if(u16(pos+34)||packed===0xffffffff||size===0xffffffff||off===0xffffffff)throw Error('Split and ZIP64 archives are not supported');
    need(pos+46,nl+xl+cl);const rawName=a.subarray(pos+46,pos+46+nl);
    if(!(flags&2048)&&rawName.some(b=>b>127))throw Error('Use UTF-8 or ASCII ZIP filenames');
    const name=decoder.decode(rawName),path=cleanPath(name),directory=name.endsWith('/');
    if(((attr>>>16)&0xf000)===0xa000)throw Error('Symbolic links are not supported');
    if(seen.has(path.toLowerCase()))throw Error('Duplicate filename (QL names ignore case): '+path);seen.add(path.toLowerCase());
    if(size>MAX_FILE||(total+=size)>MAX_TOTAL)throw Error('Unpacked ZIP exceeds the 16 MiB/file or 64 MiB/drive limit');
    const header=qdosHeader(a.subarray(pos+46+nl,pos+46+nl+xl));
    need(off,30);if(u32(off)!==0x04034b50||u16(off+8)!==method||u16(off+6)!==flags)throw Error('ZIP local/central header mismatch');
    const lnl=u16(off+26),lxl=u16(off+28),data=off+30+lnl+lxl;need(off+30,lnl+lxl);
    if(decoder.decode(a.subarray(off+30,off+30+lnl))!==name||data+packed>cd)throw Error('ZIP local filename/data mismatch');
    const localHeader=qdosHeader(a.subarray(off+30+lnl,data));
    if(header&&localHeader&&header.some((b,j)=>b!==localHeader[j]))throw Error('Conflicting QDOS headers');
    entries.push({path,directory,size,packed,method,crc,data,header:header||localHeader});pos+=46+nl+xl+cl;
  }
  if(pos!==end)throw Error('Invalid ZIP directory length');
  const files=new Map();
  for(const e of entries){
    if(e.directory){if(e.size)throw Error('Non-empty ZIP directory');continue}
    let out;
    if(e.method===0){if(e.size!==e.packed)throw Error('Stored size mismatch');out=a.slice(e.data,e.data+e.packed)}
    else{
      out=new Uint8Array(e.size);let used=0;
      const stream=new fflate.Inflate(chunk=>{if(used+chunk.length>e.size)throw Error('Inflated size exceeds ZIP header');out.set(chunk,used);used+=chunk.length});
      /* Small input pieces bound decoder scratch allocation even for hostile streams. */
      if(!e.packed)stream.push(new Uint8Array(),true);
      for(let n=0;n<e.packed;n+=1024)stream.push(a.subarray(e.data+n,e.data+Math.min(n+1024,e.packed)),n+1024>=e.packed);
      if(used!==e.size)throw Error('Inflated size mismatch');
    }
    if(crc32(out)!==e.crc)throw Error('ZIP CRC mismatch: '+e.path);
    files.set(e.path,{data:out,header:e.header});
  }
  /* Convert QDOS ZIP extra fields into the same sidecars native QLBox reads. */
  for(const [path,item] of [...files])if(item.header){
    const slash=path.lastIndexOf('/'),dir=slash<0?'':path.slice(0,slash+1),base=path.slice(slash+1);
    if(!/^[\x20-\x7e]{1,36}$/.test(base))throw Error('QDOS header has an unsupported filename');
    const hex=Array.from(new TextEncoder().encode(base.toLowerCase()),b=>b.toString(16).padStart(2,'0')).join('');
    const meta=dir+'.qlbox-meta/'+hex+'.hdr';
    if([...files.keys()].some(p=>p.toLowerCase()===meta.toLowerCase()))throw Error('Duplicate QDOS sidecar metadata');
    files.set(meta,{data:item.header});
  }
  let manifest={};
  if(files.has('qlbox.json')){
    manifest=JSON.parse(decoder.decode(files.get('qlbox.json').data));
    if(!manifest||typeof manifest!=='object'||Array.isArray(manifest))throw Error('qlbox.json must be an object');
  }
  return {files,manifest};
}
function executable(item){
  const d=item.data,n=d.length;
  return item.header?item.header[5]===1:n>=8&&d[n-8]===88&&d[n-7]===84&&d[n-6]===99&&d[n-5]===99;
}
function mount(FS,archive,base='/drive'){
  FS.mkdirTree(base);
  for(const [path,{data}] of archive.files){const dest=base+'/'+cleanPath(path),p=dest.lastIndexOf('/');FS.mkdirTree(dest.slice(0,p));FS.writeFile(dest,data)}
}
return {parse,mount,executable,cleanPath,crc32,MAX_ZIP};
});
