<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2" xmlns:app="urn:invoiceapp:extensions:v1" xmlns:ccts="urn:un:unece:uncefact:documentation:2" xmlns:clm54217="urn:un:unece:uncefact:codelist:specification:54217:2001" xmlns:clm5639="urn:un:unece:uncefact:codelist:specification:5639:1988" xmlns:clm66411="urn:un:unece:uncefact:codelist:specification:66411:2001" xmlns:clmIANAMIMEMediaType="urn:un:unece:uncefact:codelist:specification:IANAMIMEMediaType:2003" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:link="http://www.xbrl.org/2003/linkbase" xmlns:n1="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2" xmlns:qdt="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDatatypes-2" xmlns:udt="urn:un:unece:uncefact:data:specification:UnqualifiedDataTypesSchemaModule:2" xmlns:xbrldi="http://xbrl.org/2006/xbrldi" xmlns:xbrli="http://www.xbrl.org/2003/instance" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="cac cbc ext app ccts clm54217 clm5639 clm66411 clmIANAMIMEMediaType fn link n1 qdt udt xbrldi xbrli xdt xlink xs xsd xsi">
  <xsl:character-map name="a">
    <xsl:output-character character="" string="" />
    <xsl:output-character character="" string="" />
  </xsl:character-map>
  <xsl:decimal-format name="european" decimal-separator="," grouping-separator="." NaN="" />
  <xsl:output version="4.0" method="html" indent="no" encoding="UTF-8" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd" use-character-maps="a" />
  <xsl:param name="SV_OutputFormat" select="'HTML'" />
  <xsl:variable name="XML" select="/" />
  <xsl:template match="/">
    <html>
      <head>
        <title />

        <script type="text/javascript">
                   <![CDATA[var QRCode;!function(){function a(a){this.mode=c.MODE_8BIT_BYTE,this.data=a,this.parsedData=[];for(var b=[],d=0,e=this.data.length;e>d;d++){var f=this.data.charCodeAt(d);f>65536?(b[0]=240|(1835008&f)>>>18,b[1]=128|(258048&f)>>>12,b[2]=128|(4032&f)>>>6,b[3]=128|63&f):f>2048?(b[0]=224|(61440&f)>>>12,b[1]=128|(4032&f)>>>6,b[2]=128|63&f):f>128?(b[0]=192|(1984&f)>>>6,b[1]=128|63&f):b[0]=f,this.parsedData=this.parsedData.concat(b)}this.parsedData.length!=this.data.length&&(this.parsedData.unshift(191),this.parsedData.unshift(187),this.parsedData.unshift(239))}function b(a,b){this.typeNumber=a,this.errorCorrectLevel=b,this.modules=null,this.moduleCount=0,this.dataCache=null,this.dataList=[]}function i(a,b){if(void 0==a.length)throw new Error(a.length+"/"+b);for(var c=0;c<a.length&&0==a[c];)c++;this.num=new Array(a.length-c+b);for(var d=0;d<a.length-c;d++)this.num[d]=a[d+c]}function j(a,b){this.totalCount=a,this.dataCount=b}function k(){this.buffer=[],this.length=0}function m(){return"undefined"!=typeof CanvasRenderingContext2D}function n(){var a=!1,b=navigator.userAgent;return/android/i.test(b)&&(a=!0,aMat=b.toString().match(/android ([0-9]\.[0-9])/i),aMat&&aMat[1]&&(a=parseFloat(aMat[1]))),a}function r(a,b){for(var c=1,e=s(a),f=0,g=l.length;g>=f;f++){var h=0;switch(b){case d.L:h=l[f][0];break;case d.M:h=l[f][1];break;case d.Q:h=l[f][2];break;case d.H:h=l[f][3]}if(h>=e)break;c++}if(c>l.length)throw new Error("Too long data");return c}function s(a){var b=encodeURI(a).toString().replace(/\%[0-9a-fA-F]{2}/g,"a");return b.length+(b.length!=a?3:0)}a.prototype={getLength:function(){return this.parsedData.length},write:function(a){for(var b=0,c=this.parsedData.length;c>b;b++)a.put(this.parsedData[b],8)}},b.prototype={addData:function(b){var c=new a(b);this.dataList.push(c),this.dataCache=null},isDark:function(a,b){if(0>a||this.moduleCount<=a||0>b||this.moduleCount<=b)throw new Error(a+","+b);return this.modules[a][b]},getModuleCount:function(){return this.moduleCount},make:function(){this.makeImpl(!1,this.getBestMaskPattern())},makeImpl:function(a,c){this.moduleCount=4*this.typeNumber+17,this.modules=new Array(this.moduleCount);for(var d=0;d<this.moduleCount;d++){this.modules[d]=new Array(this.moduleCount);for(var e=0;e<this.moduleCount;e++)this.modules[d][e]=null}this.setupPositionProbePattern(0,0),this.setupPositionProbePattern(this.moduleCount-7,0),this.setupPositionProbePattern(0,this.moduleCount-7),this.setupPositionAdjustPattern(),this.setupTimingPattern(),this.setupTypeInfo(a,c),this.typeNumber>=7&&this.setupTypeNumber(a),null==this.dataCache&&(this.dataCache=b.createData(this.typeNumber,this.errorCorrectLevel,this.dataList)),this.mapData(this.dataCache,c)},setupPositionProbePattern:function(a,b){for(var c=-1;7>=c;c++)if(!(-1>=a+c||this.moduleCount<=a+c))for(var d=-1;7>=d;d++)-1>=b+d||this.moduleCount<=b+d||(this.modules[a+c][b+d]=c>=0&&6>=c&&(0==d||6==d)||d>=0&&6>=d&&(0==c||6==c)||c>=2&&4>=c&&d>=2&&4>=d?!0:!1)},getBestMaskPattern:function(){for(var a=0,b=0,c=0;8>c;c++){this.makeImpl(!0,c);var d=f.getLostPoint(this);(0==c||a>d)&&(a=d,b=c)}return b},createMovieClip:function(a,b,c){var d=a.createEmptyMovieClip(b,c),e=1;this.make();for(var f=0;f<this.modules.length;f++)for(var g=f*e,h=0;h<this.modules[f].length;h++){var i=h*e,j=this.modules[f][h];j&&(d.beginFill(0,100),d.moveTo(i,g),d.lineTo(i+e,g),d.lineTo(i+e,g+e),d.lineTo(i,g+e),d.endFill())}return d},setupTimingPattern:function(){for(var a=8;a<this.moduleCount-8;a++)null==this.modules[a][6]&&(this.modules[a][6]=0==a%2);for(var b=8;b<this.moduleCount-8;b++)null==this.modules[6][b]&&(this.modules[6][b]=0==b%2)},setupPositionAdjustPattern:function(){for(var a=f.getPatternPosition(this.typeNumber),b=0;b<a.length;b++)for(var c=0;c<a.length;c++){var d=a[b],e=a[c];if(null==this.modules[d][e])for(var g=-2;2>=g;g++)for(var h=-2;2>=h;h++)this.modules[d+g][e+h]=-2==g||2==g||-2==h||2==h||0==g&&0==h?!0:!1}},setupTypeNumber:function(a){for(var b=f.getBCHTypeNumber(this.typeNumber),c=0;18>c;c++){var d=!a&&1==(1&b>>c);this.modules[Math.floor(c/3)][c%3+this.moduleCount-8-3]=d}for(var c=0;18>c;c++){var d=!a&&1==(1&b>>c);this.modules[c%3+this.moduleCount-8-3][Math.floor(c/3)]=d}},setupTypeInfo:function(a,b){for(var c=this.errorCorrectLevel<<3|b,d=f.getBCHTypeInfo(c),e=0;15>e;e++){var g=!a&&1==(1&d>>e);6>e?this.modules[e][8]=g:8>e?this.modules[e+1][8]=g:this.modules[this.moduleCount-15+e][8]=g}for(var e=0;15>e;e++){var g=!a&&1==(1&d>>e);8>e?this.modules[8][this.moduleCount-e-1]=g:9>e?this.modules[8][15-e-1+1]=g:this.modules[8][15-e-1]=g}this.modules[this.moduleCount-8][8]=!a},mapData:function(a,b){for(var c=-1,d=this.moduleCount-1,e=7,g=0,h=this.moduleCount-1;h>0;h-=2)for(6==h&&h--;;){for(var i=0;2>i;i++)if(null==this.modules[d][h-i]){var j=!1;g<a.length&&(j=1==(1&a[g]>>>e));var k=f.getMask(b,d,h-i);k&&(j=!j),this.modules[d][h-i]=j,e--,-1==e&&(g++,e=7)}if(d+=c,0>d||this.moduleCount<=d){d-=c,c=-c;break}}}},b.PAD0=236,b.PAD1=17,b.createData=function(a,c,d){for(var e=j.getRSBlocks(a,c),g=new k,h=0;h<d.length;h++){var i=d[h];g.put(i.mode,4),g.put(i.getLength(),f.getLengthInBits(i.mode,a)),i.write(g)}for(var l=0,h=0;h<e.length;h++)l+=e[h].dataCount;if(g.getLengthInBits()>8*l)throw new Error("code length overflow. ("+g.getLengthInBits()+">"+8*l+")");for(g.getLengthInBits()+4<=8*l&&g.put(0,4);0!=g.getLengthInBits()%8;)g.putBit(!1);for(;;){if(g.getLengthInBits()>=8*l)break;if(g.put(b.PAD0,8),g.getLengthInBits()>=8*l)break;g.put(b.PAD1,8)}return b.createBytes(g,e)},b.createBytes=function(a,b){for(var c=0,d=0,e=0,g=new Array(b.length),h=new Array(b.length),j=0;j<b.length;j++){var k=b[j].dataCount,l=b[j].totalCount-k;d=Math.max(d,k),e=Math.max(e,l),g[j]=new Array(k);for(var m=0;m<g[j].length;m++)g[j][m]=255&a.buffer[m+c];c+=k;var n=f.getErrorCorrectPolynomial(l),o=new i(g[j],n.getLength()-1),p=o.mod(n);h[j]=new Array(n.getLength()-1);for(var m=0;m<h[j].length;m++){var q=m+p.getLength()-h[j].length;h[j][m]=q>=0?p.get(q):0}}for(var r=0,m=0;m<b.length;m++)r+=b[m].totalCount;for(var s=new Array(r),t=0,m=0;d>m;m++)for(var j=0;j<b.length;j++)m<g[j].length&&(s[t++]=g[j][m]);for(var m=0;e>m;m++)for(var j=0;j<b.length;j++)m<h[j].length&&(s[t++]=h[j][m]);return s};for(var c={MODE_NUMBER:1,MODE_ALPHA_NUM:2,MODE_8BIT_BYTE:4,MODE_KANJI:8},d={L:1,M:0,Q:3,H:2},e={PATTERN000:0,PATTERN001:1,PATTERN010:2,PATTERN011:3,PATTERN100:4,PATTERN101:5,PATTERN110:6,PATTERN111:7},f={PATTERN_POSITION_TABLE:[[],[6,18],[6,22],[6,26],[6,30],[6,34],[6,22,38],[6,24,42],[6,26,46],[6,28,50],[6,30,54],[6,32,58],[6,34,62],[6,26,46,66],[6,26,48,70],[6,26,50,74],[6,30,54,78],[6,30,56,82],[6,30,58,86],[6,34,62,90],[6,28,50,72,94],[6,26,50,74,98],[6,30,54,78,102],[6,28,54,80,106],[6,32,58,84,110],[6,30,58,86,114],[6,34,62,90,118],[6,26,50,74,98,122],[6,30,54,78,102,126],[6,26,52,78,104,130],[6,30,56,82,108,134],[6,34,60,86,112,138],[6,30,58,86,114,142],[6,34,62,90,118,146],[6,30,54,78,102,126,150],[6,24,50,76,102,128,154],[6,28,54,80,106,132,158],[6,32,58,84,110,136,162],[6,26,54,82,110,138,166],[6,30,58,86,114,142,170]],G15:1335,G18:7973,G15_MASK:21522,getBCHTypeInfo:function(a){for(var b=a<<10;f.getBCHDigit(b)-f.getBCHDigit(f.G15)>=0;)b^=f.G15<<f.getBCHDigit(b)-f.getBCHDigit(f.G15);return(a<<10|b)^f.G15_MASK},getBCHTypeNumber:function(a){for(var b=a<<12;f.getBCHDigit(b)-f.getBCHDigit(f.G18)>=0;)b^=f.G18<<f.getBCHDigit(b)-f.getBCHDigit(f.G18);return a<<12|b},getBCHDigit:function(a){for(var b=0;0!=a;)b++,a>>>=1;return b},getPatternPosition:function(a){return f.PATTERN_POSITION_TABLE[a-1]},getMask:function(a,b,c){switch(a){case e.PATTERN000:return 0==(b+c)%2;case e.PATTERN001:return 0==b%2;case e.PATTERN010:return 0==c%3;case e.PATTERN011:return 0==(b+c)%3;case e.PATTERN100:return 0==(Math.floor(b/2)+Math.floor(c/3))%2;case e.PATTERN101:return 0==b*c%2+b*c%3;case e.PATTERN110:return 0==(b*c%2+b*c%3)%2;case e.PATTERN111:return 0==(b*c%3+(b+c)%2)%2;default:throw new Error("bad maskPattern:"+a)}},getErrorCorrectPolynomial:function(a){for(var b=new i([1],0),c=0;a>c;c++)b=b.multiply(new i([1,g.gexp(c)],0));return b},getLengthInBits:function(a,b){if(b>=1&&10>b)switch(a){case c.MODE_NUMBER:return 10;case c.MODE_ALPHA_NUM:return 9;case c.MODE_8BIT_BYTE:return 8;case c.MODE_KANJI:return 8;default:throw new Error("mode:"+a)}else if(27>b)switch(a){case c.MODE_NUMBER:return 12;case c.MODE_ALPHA_NUM:return 11;case c.MODE_8BIT_BYTE:return 16;case c.MODE_KANJI:return 10;default:throw new Error("mode:"+a)}else{if(!(41>b))throw new Error("type:"+b);switch(a){case c.MODE_NUMBER:return 14;case c.MODE_ALPHA_NUM:return 13;case c.MODE_8BIT_BYTE:return 16;case c.MODE_KANJI:return 12;default:throw new Error("mode:"+a)}}},getLostPoint:function(a){for(var b=a.getModuleCount(),c=0,d=0;b>d;d++)for(var e=0;b>e;e++){for(var f=0,g=a.isDark(d,e),h=-1;1>=h;h++)if(!(0>d+h||d+h>=b))for(var i=-1;1>=i;i++)0>e+i||e+i>=b||(0!=h||0!=i)&&g==a.isDark(d+h,e+i)&&f++;f>5&&(c+=3+f-5)}for(var d=0;b-1>d;d++)for(var e=0;b-1>e;e++){var j=0;a.isDark(d,e)&&j++,a.isDark(d+1,e)&&j++,a.isDark(d,e+1)&&j++,a.isDark(d+1,e+1)&&j++,(0==j||4==j)&&(c+=3)}for(var d=0;b>d;d++)for(var e=0;b-6>e;e++)a.isDark(d,e)&&!a.isDark(d,e+1)&&a.isDark(d,e+2)&&a.isDark(d,e+3)&&a.isDark(d,e+4)&&!a.isDark(d,e+5)&&a.isDark(d,e+6)&&(c+=40);for(var e=0;b>e;e++)for(var d=0;b-6>d;d++)a.isDark(d,e)&&!a.isDark(d+1,e)&&a.isDark(d+2,e)&&a.isDark(d+3,e)&&a.isDark(d+4,e)&&!a.isDark(d+5,e)&&a.isDark(d+6,e)&&(c+=40);for(var k=0,e=0;b>e;e++)for(var d=0;b>d;d++)a.isDark(d,e)&&k++;var l=Math.abs(100*k/b/b-50)/5;return c+=10*l}},g={glog:function(a){if(1>a)throw new Error("glog("+a+")");return g.LOG_TABLE[a]},gexp:function(a){for(;0>a;)a+=255;for(;a>=256;)a-=255;return g.EXP_TABLE[a]},EXP_TABLE:new Array(256),LOG_TABLE:new Array(256)},h=0;8>h;h++)g.EXP_TABLE[h]=1<<h;for(var h=8;256>h;h++)g.EXP_TABLE[h]=g.EXP_TABLE[h-4]^g.EXP_TABLE[h-5]^g.EXP_TABLE[h-6]^g.EXP_TABLE[h-8];for(var h=0;255>h;h++)g.LOG_TABLE[g.EXP_TABLE[h]]=h;i.prototype={get:function(a){return this.num[a]},getLength:function(){return this.num.length},multiply:function(a){for(var b=new Array(this.getLength()+a.getLength()-1),c=0;c<this.getLength();c++)for(var d=0;d<a.getLength();d++)b[c+d]^=g.gexp(g.glog(this.get(c))+g.glog(a.get(d)));return new i(b,0)},mod:function(a){if(this.getLength()-a.getLength()<0)return this;for(var b=g.glog(this.get(0))-g.glog(a.get(0)),c=new Array(this.getLength()),d=0;d<this.getLength();d++)c[d]=this.get(d);for(var d=0;d<a.getLength();d++)c[d]^=g.gexp(g.glog(a.get(d))+b);return new i(c,0).mod(a)}},j.RS_BLOCK_TABLE=[[1,26,19],[1,26,16],[1,26,13],[1,26,9],[1,44,34],[1,44,28],[1,44,22],[1,44,16],[1,70,55],[1,70,44],[2,35,17],[2,35,13],[1,100,80],[2,50,32],[2,50,24],[4,25,9],[1,134,108],[2,67,43],[2,33,15,2,34,16],[2,33,11,2,34,12],[2,86,68],[4,43,27],[4,43,19],[4,43,15],[2,98,78],[4,49,31],[2,32,14,4,33,15],[4,39,13,1,40,14],[2,121,97],[2,60,38,2,61,39],[4,40,18,2,41,19],[4,40,14,2,41,15],[2,146,116],[3,58,36,2,59,37],[4,36,16,4,37,17],[4,36,12,4,37,13],[2,86,68,2,87,69],[4,69,43,1,70,44],[6,43,19,2,44,20],[6,43,15,2,44,16],[4,101,81],[1,80,50,4,81,51],[4,50,22,4,51,23],[3,36,12,8,37,13],[2,116,92,2,117,93],[6,58,36,2,59,37],[4,46,20,6,47,21],[7,42,14,4,43,15],[4,133,107],[8,59,37,1,60,38],[8,44,20,4,45,21],[12,33,11,4,34,12],[3,145,115,1,146,116],[4,64,40,5,65,41],[11,36,16,5,37,17],[11,36,12,5,37,13],[5,109,87,1,110,88],[5,65,41,5,66,42],[5,54,24,7,55,25],[11,36,12],[5,122,98,1,123,99],[7,73,45,3,74,46],[15,43,19,2,44,20],[3,45,15,13,46,16],[1,135,107,5,136,108],[10,74,46,1,75,47],[1,50,22,15,51,23],[2,42,14,17,43,15],[5,150,120,1,151,121],[9,69,43,4,70,44],[17,50,22,1,51,23],[2,42,14,19,43,15],[3,141,113,4,142,114],[3,70,44,11,71,45],[17,47,21,4,48,22],[9,39,13,16,40,14],[3,135,107,5,136,108],[3,67,41,13,68,42],[15,54,24,5,55,25],[15,43,15,10,44,16],[4,144,116,4,145,117],[17,68,42],[17,50,22,6,51,23],[19,46,16,6,47,17],[2,139,111,7,140,112],[17,74,46],[7,54,24,16,55,25],[34,37,13],[4,151,121,5,152,122],[4,75,47,14,76,48],[11,54,24,14,55,25],[16,45,15,14,46,16],[6,147,117,4,148,118],[6,73,45,14,74,46],[11,54,24,16,55,25],[30,46,16,2,47,17],[8,132,106,4,133,107],[8,75,47,13,76,48],[7,54,24,22,55,25],[22,45,15,13,46,16],[10,142,114,2,143,115],[19,74,46,4,75,47],[28,50,22,6,51,23],[33,46,16,4,47,17],[8,152,122,4,153,123],[22,73,45,3,74,46],[8,53,23,26,54,24],[12,45,15,28,46,16],[3,147,117,10,148,118],[3,73,45,23,74,46],[4,54,24,31,55,25],[11,45,15,31,46,16],[7,146,116,7,147,117],[21,73,45,7,74,46],[1,53,23,37,54,24],[19,45,15,26,46,16],[5,145,115,10,146,116],[19,75,47,10,76,48],[15,54,24,25,55,25],[23,45,15,25,46,16],[13,145,115,3,146,116],[2,74,46,29,75,47],[42,54,24,1,55,25],[23,45,15,28,46,16],[17,145,115],[10,74,46,23,75,47],[10,54,24,35,55,25],[19,45,15,35,46,16],[17,145,115,1,146,116],[14,74,46,21,75,47],[29,54,24,19,55,25],[11,45,15,46,46,16],[13,145,115,6,146,116],[14,74,46,23,75,47],[44,54,24,7,55,25],[59,46,16,1,47,17],[12,151,121,7,152,122],[12,75,47,26,76,48],[39,54,24,14,55,25],[22,45,15,41,46,16],[6,151,121,14,152,122],[6,75,47,34,76,48],[46,54,24,10,55,25],[2,45,15,64,46,16],[17,152,122,4,153,123],[29,74,46,14,75,47],[49,54,24,10,55,25],[24,45,15,46,46,16],[4,152,122,18,153,123],[13,74,46,32,75,47],[48,54,24,14,55,25],[42,45,15,32,46,16],[20,147,117,4,148,118],[40,75,47,7,76,48],[43,54,24,22,55,25],[10,45,15,67,46,16],[19,148,118,6,149,119],[18,75,47,31,76,48],[34,54,24,34,55,25],[20,45,15,61,46,16]],j.getRSBlocks=function(a,b){var c=j.getRsBlockTable(a,b);if(void 0==c)throw new Error("bad rs block @ typeNumber:"+a+"/errorCorrectLevel:"+b);for(var d=c.length/3,e=[],f=0;d>f;f++)for(var g=c[3*f+0],h=c[3*f+1],i=c[3*f+2],k=0;g>k;k++)e.push(new j(h,i));return e},j.getRsBlockTable=function(a,b){switch(b){case d.L:return j.RS_BLOCK_TABLE[4*(a-1)+0];case d.M:return j.RS_BLOCK_TABLE[4*(a-1)+1];case d.Q:return j.RS_BLOCK_TABLE[4*(a-1)+2];case d.H:return j.RS_BLOCK_TABLE[4*(a-1)+3];default:return void 0}},k.prototype={get:function(a){var b=Math.floor(a/8);return 1==(1&this.buffer[b]>>>7-a%8)},put:function(a,b){for(var c=0;b>c;c++)this.putBit(1==(1&a>>>b-c-1))},getLengthInBits:function(){return this.length},putBit:function(a){var b=Math.floor(this.length/8);this.buffer.length<=b&&this.buffer.push(0),a&&(this.buffer[b]|=128>>>this.length%8),this.length++}};var l=[[17,14,11,7],[32,26,20,14],[53,42,32,24],[78,62,46,34],[106,84,60,44],[134,106,74,58],[154,122,86,64],[192,152,108,84],[230,180,130,98],[271,213,151,119],[321,251,177,137],[367,287,203,155],[425,331,241,177],[458,362,258,194],[520,412,292,220],[586,450,322,250],[644,504,364,280],[718,560,394,310],[792,624,442,338],[858,666,482,382],[929,711,509,403],[1003,779,565,439],[1091,857,611,461],[1171,911,661,511],[1273,997,715,535],[1367,1059,751,593],[1465,1125,805,625],[1528,1190,868,658],[1628,1264,908,698],[1732,1370,982,742],[1840,1452,1030,790],[1952,1538,1112,842],[2068,1628,1168,898],[2188,1722,1228,958],[2303,1809,1283,983],[2431,1911,1351,1051],[2563,1989,1423,1093],[2699,2099,1499,1139],[2809,2213,1579,1219],[2953,2331,1663,1273]],o=function(){var a=function(a,b){this._el=a,this._htOption=b};return a.prototype.draw=function(a){function g(a,b){var c=document.createElementNS("http://www.w3.org/2000/svg",a);for(var d in b)b.hasOwnProperty(d)&&c.setAttribute(d,b[d]);return c}var b=this._htOption,c=this._el,d=a.getModuleCount();Math.floor(b.width/d),Math.floor(b.height/d),this.clear();var h=g("svg",{viewBox:"0 0 "+String(d)+" "+String(d),width:"100%",height:"100%",fill:b.colorLight});h.setAttributeNS("http://www.w3.org/2000/xmlns/","xmlns:xlink","http://www.w3.org/1999/xlink"),c.appendChild(h),h.appendChild(g("rect",{fill:b.colorDark,width:"1",height:"1",id:"template"}));for(var i=0;d>i;i++)for(var j=0;d>j;j++)if(a.isDark(i,j)){var k=g("use",{x:String(i),y:String(j)});k.setAttributeNS("http://www.w3.org/1999/xlink","href","#template"),h.appendChild(k)}},a.prototype.clear=function(){for(;this._el.hasChildNodes();)this._el.removeChild(this._el.lastChild)},a}(),p="svg"===document.documentElement.tagName.toLowerCase(),q=p?o:m()?function(){function a(){this._elImage.src=this._elCanvas.toDataURL("image/png"),this._elImage.style.display="block",this._elCanvas.style.display="none"}function d(a,b){var c=this;if(c._fFail=b,c._fSuccess=a,null===c._bSupportDataURI){var d=document.createElement("img"),e=function(){c._bSupportDataURI=!1,c._fFail&&_fFail.call(c)},f=function(){c._bSupportDataURI=!0,c._fSuccess&&c._fSuccess.call(c)};return d.onabort=e,d.onerror=e,d.onload=f,d.src="data:image/gif;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==",void 0}c._bSupportDataURI===!0&&c._fSuccess?c._fSuccess.call(c):c._bSupportDataURI===!1&&c._fFail&&c._fFail.call(c)}if(this._android&&this._android<=2.1){var b=1/window.devicePixelRatio,c=CanvasRenderingContext2D.prototype.drawImage;CanvasRenderingContext2D.prototype.drawImage=function(a,d,e,f,g,h,i,j){if("nodeName"in a&&/img/i.test(a.nodeName))for(var l=arguments.length-1;l>=1;l--)arguments[l]=arguments[l]*b;else"undefined"==typeof j&&(arguments[1]*=b,arguments[2]*=b,arguments[3]*=b,arguments[4]*=b);c.apply(this,arguments)}}var e=function(a,b){this._bIsPainted=!1,this._android=n(),this._htOption=b,this._elCanvas=document.createElement("canvas"),this._elCanvas.width=b.width,this._elCanvas.height=b.height,a.appendChild(this._elCanvas),this._el=a,this._oContext=this._elCanvas.getContext("2d"),this._bIsPainted=!1,this._elImage=document.createElement("img"),this._elImage.style.display="none",this._el.appendChild(this._elImage),this._bSupportDataURI=null};return e.prototype.draw=function(a){var b=this._elImage,c=this._oContext,d=this._htOption,e=a.getModuleCount(),f=d.width/e,g=d.height/e,h=Math.round(f),i=Math.round(g);b.style.display="none",this.clear();for(var j=0;e>j;j++)for(var k=0;e>k;k++){var l=a.isDark(j,k),m=k*f,n=j*g;c.strokeStyle=l?d.colorDark:d.colorLight,c.lineWidth=1,c.fillStyle=l?d.colorDark:d.colorLight,c.fillRect(m,n,f,g),c.strokeRect(Math.floor(m)+.5,Math.floor(n)+.5,h,i),c.strokeRect(Math.ceil(m)-.5,Math.ceil(n)-.5,h,i)}this._bIsPainted=!0},e.prototype.makeImage=function(){this._bIsPainted&&d.call(this,a)},e.prototype.isPainted=function(){return this._bIsPainted},e.prototype.clear=function(){this._oContext.clearRect(0,0,this._elCanvas.width,this._elCanvas.height),this._bIsPainted=!1},e.prototype.round=function(a){return a?Math.floor(1e3*a)/1e3:a},e}():function(){var a=function(a,b){this._el=a,this._htOption=b};return a.prototype.draw=function(a){for(var b=this._htOption,c=this._el,d=a.getModuleCount(),e=Math.floor(b.width/d),f=Math.floor(b.height/d),g=['<table style="border:0;border-collapse:collapse;">'],h=0;d>h;h++){g.push("<tr>");for(var i=0;d>i;i++)g.push('<td style="border:0;border-collapse:collapse;padding:0;margin:0;width:'+e+"px;height:"+f+"px;background-color:"+(a.isDark(h,i)?b.colorDark:b.colorLight)+';"></td>');g.push("</tr>")}g.push("</table>"),c.innerHTML=g.join("");var j=c.childNodes[0],k=(b.width-j.offsetWidth)/2,l=(b.height-j.offsetHeight)/2;k>0&&l>0&&(j.style.margin=l+"px "+k+"px")},a.prototype.clear=function(){this._el.innerHTML=""},a}();QRCode=function(a,b){if(this._htOption={width:256,height:256,typeNumber:4,colorDark:"#000000",colorLight:"#ffffff",correctLevel:d.H},"string"==typeof b&&(b={text:b}),b)for(var c in b)this._htOption[c]=b[c];"string"==typeof a&&(a=document.getElementById(a)),this._android=n(),this._el=a,this._oQRCode=null,this._oDrawing=new q(this._el,this._htOption),this._htOption.text&&this.makeCode(this._htOption.text)},QRCode.prototype.makeCode=function(a){this._oQRCode=new b(r(a,this._htOption.correctLevel),this._htOption.correctLevel),this._oQRCode.addData(a),this._oQRCode.make(),this._el.title=a,this._oDrawing.draw(this._oQRCode),this.makeImage()},QRCode.prototype.makeImage=function(){"function"==typeof this._oDrawing.makeImage&&(!this._android||this._android>=3)&&this._oDrawing.makeImage()},QRCode.prototype.clear=function(){this._oDrawing.clear()},QRCode.CorrectLevel=d}();]]>      
        </script>

        <style type="text/css">
                  body {
                  background-color: #FFFFFF;
                  font-family: 'Tahoma', "Times New Roman", Times, serif;
                  font-size: 11px;
                  color: black;
                  }
                  h1, h2 {
                  padding-bottom: 3px;
                  padding-top: 3px;
                  margin-bottom: 5px;
                  text-transform: uppercase;
                  font-family: Arial, Helvetica, sans-serif;
                  }
                  h1 {
                  font-size: 1.4em;
                  text-transform:none;
                  }
                  h2 {
                  font-size: 1em;
                  color: brown;
                  }
                  h3 {
                  font-size: 1em;
                  color: #333333;
                  text-align: justify;
                  margin: 0;
                  padding: 0;
                  }
                  h4 {
                  font-size: 1.1em;
                  font-style: bold;
                  font-family: Arial, Helvetica, sans-serif;
                  color: #000000;
                  margin: 0;
                  padding: 0;
                  }
                  #customername{            
                  font-size:13px;
                  color: #000000;
                  }
                  p, ul, ol {
                  margin-top: 1.5em;
                  }
                  ul, ol {
                  margin-left: 3em;
                  }
                  blockquote {
                  margin-left: 3em;
                  margin-right: 3em;
                  font-style: italic;
                  }
                  a {
                  text-decoration: none;
                  color: #70A300;
                  }
                  a:hover {
                  border: none;
                  color: #70A300;
                  }
                  #despatchTable {
                  border-collapse:collapse;
                  font-size:11px;
                  float:right;
                  border-color:gray;
                  }
                  #ettnTable {
                  border-collapse:collapse;
                  font-size:11px;
                  border-color:gray;
                  }
                  #customerPartyTable {
                  border-width: 0px;
                  border-spacing:;
                  border-style: inset;
                  border-color: gray;
                  border-collapse: collapse;
                  background-color:
                  }
                  #customerIDTable {
                  border-width: 2px;
                  border-spacing:;
                  border-style: inset;
                  border-color: gray;
                  border-collapse: collapse;
                  background-color:
                  }
                  #customerIDTableTd {
                  border-width: 2px;
                  border-spacing:;
                  border-style: inset;
                  border-color: gray;
                  border-collapse: collapse;
                  background-color:
                  }
                  #lineTable {
                  border-width:2px;
                  border-spacing:;
                  border-style: solid;
                  border-color: #000000;
                  border-collapse: collapse;
                  background-color:;
                  }
                  #lineTableTd {
                  border-width: 1px;
                  padding: 1px;
                  border-style: solid;
                  border-color: #000000 ;            
                  }
                  #lineTableTr {
                  border-width: 1px;
                  padding: 0px;
                  background-color: white;
                  border-color: #000000 ;
                  -moz-border-radius:;
                  }
                  #lineTableDummyTd {
                  border-width: 1px;
                  border-color:white;
                  padding: 1px;
                  border-style: inset;
                  border-color: black;
                  background-color: white;
                  }
                  #lineTableBudgetTd {
                  }
                  #notesTable {
                  border-width: 1px;
                  border-spacing:;
                  border-style: solid;
                  border-color: #000000;
                  border-collapse: collapse;
                  background-color:
                  }
                  #notesTableTd {
                  border-width: 0px;
                  border-spacing:;
                  border-style: inset;
                  border-color: black;
                  border-collapse: collapse;
                  background-color:
                  }
                  table {
                  border-spacing:0px;
                  }
                  #budgetContainerTable {
                  border-collapse:collapse;
                  border-width: 0px;
                  border-spacing: 0px;
                  border-style: inset;
                  border-color: black;
                  background-color:;
                  margin-top: 7px;
                  margin-bottom: 30px;
                  }
                  #budgetContainerTable td{
                  border-bottom: 1px solid #ddd;
                  }
                  td {
                  border-color:gray;
                  }
                  @media print{
                  i{
                  font-style: italic !important;
                  }
                  }
                  #bankingTable{
                  border-collapse:collapse;
                  border-width: 1px;
                  border-style: inset;
                  font-size:11px;
                  float:leftt;
                  border-color:#000000;
                  }
                  #bankingTable th{
                  float:leftt;
                  border-color:gray;
                  background-color:#000000;
                  color: white;
                  }
                  <xsl:if test="//n1:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/app:InvoiceAppExtension/app:Branding/app:FontFamily">
                  body, body * { font-family: "<xsl:value-of select="//n1:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/app:InvoiceAppExtension/app:Branding/app:FontFamily" />", Arial, Helvetica, sans-serif !important; }
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/app:InvoiceAppExtension/app:Branding/app:AccentColorHex">
                  #customername { color: <xsl:value-of select="//n1:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/app:InvoiceAppExtension/app:Branding/app:AccentColorHex" /> !important; }
                  </xsl:if>
               </style>
        <title>e-Fatura</title>
      </head>
      <body style="margin-left=0.6in; margin-right=0.6in; margin-top=0.79in; margin-bottom=0.79in">
        <xsl:for-each select="$XML">
          <table style="border-color:blue; " border="0" cellspacing="0px" width="800px" cellpadding="0px">
            <tbody>
              <tr valign="top">
                <td width="40%">
                  <br />
                  <xsl:choose>
                    <xsl:when test="//n1:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/app:InvoiceAppExtension/app:Branding/app:LogoBase64">
                      <img alt="" id="company_logo" name="company_logo">
                        <xsl:attribute name="src">
                          <xsl:value-of select="//n1:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/app:InvoiceAppExtension/app:Branding/app:LogoBase64" />
                        </xsl:attribute>
                      </img>
                    </xsl:when>
                    <xsl:otherwise>
                      <img alt="" id="company_logo" name="company_logo"  src="data:image/jpeg;base64,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" />
                    </xsl:otherwise>
                  </xsl:choose>
                  <br />
                  <br />
                  <table align="center" border="0" width="100%">
                    <tbody>
                      <tr align="left">
                        <xsl:for-each select="n1:Invoice/cac:AccountingSupplierParty/cac:Party">
                          <td align="left">
                            <xsl:if test="cac:PartyName">
                              <b id="customername">
                                <xsl:if test="cac:PartyName">
                                  <xsl:value-of select="cac:PartyName/cbc:Name" />
                                </xsl:if>
                              </b>
                            </xsl:if>
                          </td>
                        </xsl:for-each>
                      </tr>
                      <tr align="left">
                        <xsl:for-each select="n1:Invoice/cac:AccountingSupplierParty/cac:Party">
                          <td align="left">
                            <xsl:for-each select="cac:PostalAddress">
                              <xsl:for-each select="cbc:StreetName">
                                <xsl:apply-templates />
                                <xsl:text> </xsl:text>
                              </xsl:for-each>
                              <xsl:for-each select="cbc:BuildingName">
                                <xsl:apply-templates />
                              </xsl:for-each>
                              <br />
                              <xsl:for-each select="cbc:PostalZone">
                                <xsl:apply-templates />
                                <xsl:text> </xsl:text>
                              </xsl:for-each>
                              <xsl:for-each select="cbc:CitySubdivisionName">
                                <xsl:apply-templates />
                              </xsl:for-each>
                              <xsl:text>/ </xsl:text>
                              <xsl:for-each select="cbc:CityName">
                                <xsl:apply-templates />
                                <xsl:text> </xsl:text>
                              </xsl:for-each>
                              <xsl:text>/TÜRKİYE</xsl:text>
                            </xsl:for-each>
                          </td>
                        </xsl:for-each>
                      </tr>
                      <xsl:if test="//n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Telephone or //n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Telefax">
                        <tr align="left">
                          <xsl:for-each select="n1:Invoice/cac:AccountingSupplierParty/cac:Party">
                            <td align="left">
                              <xsl:for-each select="cac:Contact">
                                <xsl:if test="cbc:Telephone">
                                  <xsl:text>Tel: </xsl:text>
                                  <xsl:for-each select="cbc:Telephone">
                                    <xsl:apply-templates />
                                  </xsl:for-each>
                                </xsl:if>
                                <xsl:if test="cbc:Telefax">
                                  <xsl:text> Fax: </xsl:text>
                                  <xsl:for-each select="cbc:Telefax">
                                    <xsl:apply-templates />
                                  </xsl:for-each>
                                </xsl:if>
                                <xsl:text> </xsl:text>
                              </xsl:for-each>
                            </td>
                          </xsl:for-each>
                        </tr>
                      </xsl:if>
                      <xsl:for-each select="//n1:Invoice/cac:AccountingSupplierParty/cac:Party/cbc:WebsiteURI">
                        <tr align="left">
                          <td>
                            <xsl:text>Web Sitesi: </xsl:text>
                            <xsl:value-of select="." />
                          </td>
                        </tr>
                      </xsl:for-each>
                      <xsl:for-each select="//n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:ElectronicMail">
                        <tr align="left">
                          <td>
                            <xsl:text>E-Posta: </xsl:text>
                            <xsl:value-of select="." />
                          </td>
                        </tr>
                      </xsl:for-each>
                      <tr align="left">
                        <xsl:for-each select="n1:Invoice/cac:AccountingSupplierParty/cac:Party">
                          <td align="left">
                            <xsl:text>Vergi Dairesi: </xsl:text>
                            <xsl:for-each select="cac:PartyTaxScheme">
                              <xsl:for-each select="cac:TaxScheme">
                                <xsl:for-each select="cbc:Name">
                                  <xsl:apply-templates />
                                </xsl:for-each>
                              </xsl:for-each>
                              <xsl:text>  </xsl:text>
                            </xsl:for-each>
                          </td>
                        </xsl:for-each>
                      </tr>
                      <xsl:for-each select="//n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification">
                        <tr align="left">
                          <td>
                            <xsl:value-of select="cbc:ID/@schemeID" />
                            <xsl:text>: </xsl:text>
                            <xsl:value-of select="cbc:ID" />
                          </td>
                        </tr>
                      </xsl:for-each>
                      <xsl:if test="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:AgentParty">
                        <tr>
                          <td style="width:469px; " align="left">
                            <b>Şube Bilgileri</b>
                            <br />
                            <xsl:if test="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID[@schemeID='VKN']">
                              <xsl:if test="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:AgentParty/cac:PartyName">
                                <b>
                                  <xsl:value-of select="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:AgentParty/cac:PartyName/cbc:Name" />
                                </b>
                              </xsl:if>
                            </xsl:if>
                            <xsl:if test="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID[@schemeID='TCKN']">
                              <b>
                                <xsl:for-each select="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:AgentParty/cac:Person">
                                  <xsl:for-each select="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:AgentParty/cbc:FirstName">
                                    <xsl:apply-templates />
                                    <xsl:text>
                                    </xsl:text>
                                  </xsl:for-each>
                                  <xsl:for-each select="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:AgentParty/cbc:FamilyName">
                                    <xsl:apply-templates />
                                    <xsl:text>
                                    </xsl:text>
                                  </xsl:for-each>
                                </xsl:for-each>
                              </b>
                            </xsl:if>
                            <br />
                            <xsl:value-of select="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:AgentParty/cac:PostalAddress/cbc:StreetName" />
                            <br />
                            <xsl:value-of select="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:AgentParty/cac:PostalAddress/cbc:CitySubdivisionName" />
                                                  /
                                                  <xsl:value-of select="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:AgentParty/cac:PostalAddress/cbc:CityName" />
                                                  /
                                                  <xsl:value-of select="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:Name" /><br />

                                          Vergi Dairesi: 
                                          <xsl:value-of select="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:AgentParty/cac:PartyTaxScheme/cac:TaxScheme/cbc:Name" /><br /><xsl:for-each select="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:AgentParty/cac:PartyIdentification"><tr align="left"><td><xsl:value-of select="cbc:ID/@schemeID" /><xsl:text>: </xsl:text><xsl:value-of select="cbc:ID" /></td></tr></xsl:for-each></td>
                        </tr>
                      </xsl:if>
                    </tbody>
                  </table>
                </td>
                <td width="20%" align="center" valign="middle">
                  <img style="width:120px;" align="middle" alt="E-Fatura Logo" src="data:image/png;base64,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" />
                  <xsl:if test="//n1:Invoice/cbc:ProfileID = 'EARSIVFATURA'">
                    <h1 align="center">
                      <span style="font-weight:bold; ">
                        <xsl:text>e-Arşiv Fatura</xsl:text>
                      </span>
                    </h1>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cbc:ProfileID != 'EARSIVFATURA'">
                    <h1 align="center">
                      <span style="font-weight:bold; ">
                        <xsl:text>e-Fatura</xsl:text>
                      </span>
                      <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                        <span style="font-size:10px;font-style:italic;color:#808080;">
                          <br />
                          <xsl:text>e-Invoice</xsl:text>
                        </span>
                      </xsl:if>
                    </h1>
                  </xsl:if>
                </td>
                <td align="center" valign="middle" width="20%">
          
                  <img width="180" height="180" align="right"  id="qrkod" name="qrkod" src="{KAREKODGELECEK}"/>
                  
                  <div align="right" id="qrcode"/>
                  <div id="qrvalue"
                    style="visibility: hidden; height: 20px;width: 20px; ; display:none"
                    > {"vkntckn":"<xsl:value-of select="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID[@schemeID = 'TCKN' or @schemeID = 'VKN']"/>", "avkntckn":"<xsl:value-of select="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID[@schemeID = 'TCKN' or @schemeID = 'VKN']"/><xsl:text> </xsl:text>", "senaryo":"<xsl:value-of select="n1:Invoice/cbc:ProfileID"/>", "tip":"<xsl:value-of select="n1:Invoice/cbc:InvoiceTypeCode"/>", "tarih":"<xsl:value-of select="n1:Invoice/cbc:IssueDate"/>", "no":"<xsl:value-of select="n1:Invoice/cbc:ID"/>", "ettn":"<xsl:value-of select="n1:Invoice/cbc:UUID"/>", "parabirimi":"<xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode"/>", "malhizmettoplam":"<xsl:value-of select="n1:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount"/><xsl:for-each select="n1:Invoice/cac:TaxTotal/cac:TaxSubtotal[cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode = '0015']">"<xsl:text>, "kdvmatrah</xsl:text>(<xsl:value-of select="cbc:Percent"/>)":"<xsl:value-of select="cbc:TaxableAmount"/>"</xsl:for-each><xsl:for-each select="n1:Invoice/cac:TaxTotal/cac:TaxSubtotal[cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode = '0015']"><xsl:text>, "hesaplanankdv</xsl:text>(<xsl:value-of select="cbc:Percent"/>)":"<xsl:value-of select="cbc:TaxAmount"/>",</xsl:for-each>"vergidahil":"<xsl:value-of select="n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount"/>", "odenecek":"<xsl:value-of select="n1:Invoice/cac:LegalMonetaryTotal/cbc:PayableAmount"/>"}
                  </div>
                  <script type="text/javascript">                    
                    const element = document.getElementById("qrkod");
                    if(element.src.length >= 1000){
                        //qr mevcut
                    }
                    else{
                        var qrcode = new QRCode(document.getElementById("qrcode"), {
                          width : 180,
                          height : 180,
                          correctLevel : QRCode.CorrectLevel.H
                        });
                        function makeCode (msg) {   
                          var elText = document.getElementById("text");
                          qrcode.makeCode(msg);
                        }
                       makeCode(document.getElementById("qrvalue").innerHTML); 
                       element.parentNode.removeChild(element);
                    }
                  </script>
                </td>
              </tr>
              <tr style="height:90px; " valign="top">
                <td width="40%" align="right" valign="bottom">
                  <table id="customerPartyTable" align="left" border="0" style="margin-top:50px;" height="40%">
                    <tbody>

                      <xsl:if test="//n1:Invoice/cbc:ProfileID != 'IHRACAT'">
                        <tr style="height:35px; ">
                          <hr style="display: block;&#xD;&#xA;                                          height: 1px;&#xD;&#xA;                                          border: 0;&#xD;&#xA;                                          border-top: 1px solid #000000;&#xD;&#xA;                                          padding: 0; " />
                          <td>
                            <table align="center" border="0">
                              <tbody>
                                <tr>
                                  <xsl:for-each select="n1:Invoice/cac:AccountingCustomerParty/cac:Party">
                                    <td style="width:469px; " align="left">
                                      <span style="font-weight:bold;color:#000000; ">
                                        <xsl:text>Alıcı Bilgileri</xsl:text>
                                      </span>
                                      <!--  <i style="font-size:10px;font-style:italic !important;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                                                            <br/><xsl:text>Buyer Information</xsl:text>
                                                            </i> -->
                                    </td>
                                  </xsl:for-each>
                                </tr>
                                <tr>
                                  <xsl:choose>
                                    <xsl:when test="n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID[@schemeID='PARTYTYPE' and text()='TAXFREE']">
                                      <xsl:for-each select="n1:Invoice/cac:BuyerCustomerParty/cac:Party">
                                        <xsl:call-template name="Party_Title">
                                          <xsl:with-param name="PartyType">TAXFREE</xsl:with-param>
                                        </xsl:call-template>
                                      </xsl:for-each>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="n1:Invoice/cac:AccountingCustomerParty/cac:Party">
                                        <xsl:call-template name="Party_Title">
                                          <xsl:with-param name="PartyType">OTHER</xsl:with-param>
                                        </xsl:call-template>
                                      </xsl:for-each>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                </tr>
                                <xsl:choose>
                                  <xsl:when test="n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID[@schemeID='PARTYTYPE' and text()='TAXFREE']">
                                    <xsl:for-each select="n1:Invoice/cac:BuyerCustomerParty/cac:Party">
                                      <tr>
                                        <xsl:call-template name="Party_Adress">
                                          <xsl:with-param name="PartyType">TAXFREE</xsl:with-param>
                                        </xsl:call-template>
                                      </tr>
                                      <xsl:call-template name="Party_Other">
                                        <xsl:with-param name="PartyType">TAXFREE</xsl:with-param>
                                      </xsl:call-template>
                                    </xsl:for-each>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <xsl:for-each select="n1:Invoice/cac:AccountingCustomerParty/cac:Party">
                                      <tr>
                                        <xsl:call-template name="Party_Adress">
                                          <xsl:with-param name="PartyType">OTHER</xsl:with-param>
                                        </xsl:call-template>
                                      </tr>
                                      <xsl:call-template name="Party_Other">
                                        <xsl:with-param name="PartyType">OTHER</xsl:with-param>
                                      </xsl:call-template>
                                    </xsl:for-each>
                                  </xsl:otherwise>
                                </xsl:choose>

                                <xsl:if test="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:AgentParty">
                                  <tr>
                                    <td style="width:469px; " align="left">
                                      <b>Şube Bilgileri</b>
                                      <br />
                                      <xsl:if test="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID[@schemeID='VKN']">
                                        <xsl:if test="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PartyName">
                                          <b>
                                            <xsl:value-of select="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PartyName/cbc:Name" />
                                          </b>
                                        </xsl:if>
                                      </xsl:if>
                                      <xsl:if test="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID[@schemeID='TCKN']">
                                        <b>
                                          <xsl:for-each select="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:Person">
                                            <xsl:for-each select="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cbc:FirstName">
                                              <xsl:apply-templates />
                                              <xsl:text>
                                              </xsl:text>
                                            </xsl:for-each>
                                            <xsl:for-each select="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cbc:FamilyName">
                                              <xsl:apply-templates />
                                              <xsl:text>
                                              </xsl:text>
                                            </xsl:for-each>
                                          </xsl:for-each>
                                        </b>
                                      </xsl:if>
                                      <br />
                                      <xsl:value-of select="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cbc:StreetName" />
                                      <br />
                                      <xsl:value-of select="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cbc:CitySubdivisionName" />
                                                  /
                                                  <xsl:value-of select="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cbc:CityName" />
                                                  /
                                                  <xsl:value-of select="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:Name" /><br />

                                          Vergi Dairesi: 
                                          <xsl:value-of select="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PartyTaxScheme/cac:TaxScheme/cbc:Name" /><br /><xsl:for-each select="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification"><tr align="left"><td><xsl:value-of select="cbc:ID/@schemeID" /><xsl:text>: </xsl:text><xsl:value-of select="cbc:ID" /></td></tr></xsl:for-each></td>
                                  </tr>
                                </xsl:if>


                               <xsl:if test="n1:Invoice/cac:Delivery/cac:DeliveryAddress">
                                  <tr>
                                    <td style="width:469px; " align="left">
                                      <b>Teslimat Bilgileri</b>
                                      <br />        
                                      <xsl:value-of select="n1:Invoice/cac:Delivery/cbc:ID" />
                                      <br />
                                      <xsl:value-of select="n1:Invoice/cac:Delivery/cac:DeliveryAddress/cbc:StreetName" />
                                      <br />
                                      <xsl:value-of select="n1:Invoice/cac:Delivery/cac:DeliveryAddress/cbc:CitySubdivisionName" />
                                                  /
                                                  <xsl:value-of select="n1:Invoice/cac:Delivery/cac:DeliveryAddress/cbc:CityName" />
                                                  /
                                                  <xsl:value-of select="n1:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:Name" /><br />

                                   
                                      </td>
                                  </tr>
                                </xsl:if>


                              </tbody>
                            </table>
                            <hr style="display: block;&#xD;&#xA;                                             height: 1px;&#xD;&#xA;                                             border: 0;&#xD;&#xA;                                             border-top: 1px solid #000000;&#xD;&#xA;                                             padding: 0; " />
                          </td>
                        </tr>
                      </xsl:if>

                      <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                        <tr style="height:71px; ">
                          <td>
                            <hr style="display: block;&#xD;&#xA;                                             height: 1px;&#xD;&#xA;                                             border: 0;&#xD;&#xA;                                             border-top: 1px solid #000000;&#xD;&#xA;                                             padding: 0; " />
                            <table align="center" border="0">
                              <tbody>
                                <tr>
                                  <xsl:for-each select="n1:Invoice/cac:AccountingCustomerParty/cac:Party">
                                    <td style="width:469px; " align="left">
                                      <span style="font-weight:bold;color:#000000; ">
                                        <xsl:text>Alıcı Bilgileri</xsl:text>
                                      </span>
                                      <i style="font-size:10px;font-style:italic !important;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                                        <br />
                                        <xsl:text>Buyer Information</xsl:text>
                                      </i>
                                    </td>
                                  </xsl:for-each>
                                </tr>
                                <tr>
                                  <tr>
                                    <td style="width:469px" align="left">
                                      <span style="font-weight:bold; ">
                                        <xsl:text>
                                        </xsl:text>
                                      </span>
                                      <xsl:value-of select="//n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName" />
                                    </td>
                                  </tr>
                                </tr>
                                <tr>
                                  <td style="width:469px" align="left">
                                    <xsl:if test="//n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:StreetName !=''&#xD;&#xA;                                          and  //n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:StreetName !='-'">
                                      <xsl:value-of select="//n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:StreetName" />
                                      <br />
                                    </xsl:if>
                                    <xsl:if test="//n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:CitySubdivisionName !=''&#xD;&#xA;                                         and  //n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:CitySubdivisionName !='-'">
                                      <xsl:value-of select="//n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:CitySubdivisionName" />
                                      <xsl:text>/</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="//n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:CityName !=''&#xD;&#xA;                                  and  //n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:CitySubdivisionName !='-'">
                                      <xsl:value-of select="//n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:CityName" />
                                      <xsl:text>/</xsl:text>
                                    </xsl:if>
                                    <xsl:value-of select="//n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:Name" />
                                    <xsl:if test="//n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme/cbc:Name !=''&#xD;&#xA;                                   and  //n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme/cbc:Name !='-'">
                                      <br />Tax Office:<xsl:value-of select="//n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme/cbc:Name" /></xsl:if>
                                    <br />Company ID: <xsl:value-of select="//n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID" /></td>
                                </tr>
                                <tr>
                                  <td style="width:469px" align="left">
                                    <span style="font-weight:bold; ">
                                                          Consignee: <xsl:value-of select="(//n1:Invoice/cac:InvoiceLine/cac:Delivery/cbc:ID/node())[1]" /></span>
                                  </td>
                                </tr>
                                <tr>
                                  <td style="width:469px" align="left">
                                    <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cbc:StreetName !=''&#xD;&#xA;                            and //n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cbc:StreetName !='-' ">
                                      <xsl:value-of select="(//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cbc:StreetName/node())[1]" />
                                      <br />
                                    </xsl:if>
                                    <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cbc:CitySubdivisionName !=''&#xD;&#xA;                            and //n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cbc:CitySubdivisionName  !='-'">
                                      <xsl:value-of select="(//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cbc:CitySubdivisionName/node())[1]" />
                                      <xsl:text>/</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cbc:CityName !=''&#xD;&#xA;                           and //n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cbc:CityName !='-'">
                                      <xsl:value-of select="(//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cbc:CityName/node())[1]" />
                                      <xsl:text>/</xsl:text>
                                    </xsl:if>
                                    <xsl:value-of select="(//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:Name/node())[1]" />
                                  </td>
                                </tr>
                              </tbody>
                            </table>
                            <hr style="display: block;&#xD;&#xA;                                             height: 1px;&#xD;&#xA;                                             border: 0;&#xD;&#xA;                                             border-top: 1px solid #000000;&#xD;&#xA;                                             padding: 0; " />
                          </td>
                        </tr>
                      </xsl:if>


                    </tbody>
                  </table>
                  <br />
                </td>
                <xsl:if test="//n1:Invoice/cbc:ProfileID = 'EARSIVFATURA'">
                  <td width="20%" align="center">
                    <img alt="" style="padding-top:10px;" src="data:image/jpeg;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAACCAYAAACZgbYnAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAASSURBVBhXY9DXNHrJICkl+xIAC6ICrTP30AAAAAAASUVORK5CYII=" />
                  </td>
                </xsl:if>
                <td width="60%" align="center" valign="bottom" colspan="2">
                  <table border="0" height="13" id="despatchTable">
                    <tbody>
                      <tr>
                        <td style="width:105px;" align="left">
                          <span style="font-weight:bold;color:#000000; ">
                            <xsl:text>Özelleştirme No:</xsl:text>
                          </span>
                          <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                            <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                              <br />
                              <xsl:text>Customization Number</xsl:text>
                            </span>
                          </xsl:if>
                        </td>
                        <td style="width:110px;" align="left">
                          <xsl:for-each select="n1:Invoice/cbc:CustomizationID">
                            <xsl:apply-templates />
                          </xsl:for-each>
                        </td>
                      </tr>
                      <tr style="height:13px; ">
                        <td align="left">
                          <span style="font-weight:bold;color:#000000;  ">
                            <xsl:text>Senaryo:</xsl:text>
                          </span>
                          <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                            <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                              <br />
                              <xsl:text>Scenario</xsl:text>
                            </span>
                          </xsl:if>
                        </td>
                        <td align="left">
                          <xsl:for-each select="n1:Invoice/cbc:ProfileID">
                            <xsl:apply-templates />
                          </xsl:for-each>
                        </td>
                      </tr>
                      <tr style="height:13px; ">
                        <td align="left">
                          <span style="font-weight:bold;color:#000000;  ">
                            <xsl:text>Fatura Tipi:</xsl:text>
                          </span>
                          <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                            <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                              <br />
                              <xsl:text>Invoice Type</xsl:text>
                            </span>
                          </xsl:if>
                        </td>
                        <td align="left">
                          <xsl:for-each select="n1:Invoice/cbc:InvoiceTypeCode">
                            <xsl:apply-templates />
                          </xsl:for-each>
                        </td>
                      </tr>
                      <tr style="height:13px; ">
                        <td align="left">
                          <span style="font-weight:bold; color:#000000; ">
                            <xsl:text>Fatura No:</xsl:text>
                          </span>
                          <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                            <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                              <br />
                              <xsl:text>Invoice Number</xsl:text>
                            </span>
                          </xsl:if>
                        </td>
                        <td align="left">
                          <xsl:for-each select="n1:Invoice/cbc:ID">
                            <xsl:apply-templates />
                          </xsl:for-each>
                        </td>
                      </tr>
                      <tr style="height:13px; ">
                        <td align="left">
                          <span style="font-weight:bold; color:#000000; ">
                            <xsl:text>Fatura Tarihi:</xsl:text>
                          </span>
                          <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                            <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                              <br />
                              <xsl:text>Invoice Date</xsl:text>
                            </span>
                          </xsl:if>
                        </td>
                        <td align="left">
                          <xsl:for-each select="n1:Invoice/cbc:IssueDate">
                            <xsl:apply-templates select="." />
                          </xsl:for-each>
                        </td>
                      </tr>
                      <tr style="height:13px; ">
                        <td align="left">
                          <span style="font-weight:bold; color:#000000; ">
                            <xsl:text>Fatura Saati:</xsl:text>
                          </span>
                          <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                            <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                              <br />
                              <xsl:text>Invoice Time</xsl:text>
                            </span>
                          </xsl:if>
                        </td>
                        <td align="left">
                          <xsl:if test="//n1:Invoice/cbc:IssueTime != '' and //n1:Invoice/cbc:IssueTime != 'null'">
                            <xsl:for-each select="//n1:Invoice/cbc:IssueTime">
                              <xsl:value-of select="substring(.,1,8)" />
                            </xsl:for-each>
                          </xsl:if>
                        </td>
                      </tr>
                      <xsl:for-each select="n1:Invoice/cac:DespatchDocumentReference">
                        <tr style="height:13px; ">
                          <td align="left">
                            <span style="font-weight:bold; color:#000000; ">
                              <xsl:text>İrsaliye No:</xsl:text>
                            </span>
                            <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                              <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                                <br />
                                <xsl:text>Delivery Note</xsl:text>
                              </span>
                            </xsl:if>
                            <xsl:text> </xsl:text>
                          </td>
                          <td align="left">
                            <xsl:value-of select="cbc:ID" />
                          </td>
                        </tr>
                        <tr style="height:13px; ">
                          <td align="left">
                            <span style="font-weight:bold; color:#000000; ">
                              <xsl:text>İrsaliye Tarihi:</xsl:text>
                            </span>
                            <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                              <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                                <br />
                                <xsl:text>Delivery Note Date</xsl:text>
                              </span>
                            </xsl:if>
                          </td>
                          <td align="left">
                            <xsl:for-each select="cbc:IssueDate">
                              <xsl:apply-templates select="." />
                            </xsl:for-each>
                          </td>
                        </tr>
                      </xsl:for-each>
                      <xsl:if test="//n1:Invoice/cac:OrderReference">
                        <tr style="height:13px">
                          <td align="left">
                            <span style="font-weight:bold; color:#000000; ">
                              <xsl:text>Sipariş No:</xsl:text>
                            </span>
                            <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                              <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                                <br />
                                <xsl:text>Order Number</xsl:text>
                              </span>
                            </xsl:if>
                          </td>
                          <td align="left">
                            <xsl:for-each select="n1:Invoice/cac:OrderReference/cbc:ID">
                              <xsl:apply-templates />
                            </xsl:for-each>
                          </td>
                        </tr>
                      </xsl:if>
                      <xsl:if test="//n1:Invoice/cac:OrderReference/cbc:IssueDate">
                        <tr style="height:13px">
                          <td align="left">
                            <span style="font-weight:bold; color:#000000; ">
                              <xsl:text>Sipariş Tarihi:</xsl:text>
                            </span>
                            <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                              <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                                <br />
                                <xsl:text>Order Date</xsl:text>
                              </span>
                            </xsl:if>
                          </td>
                          <td align="left">
                            <xsl:for-each select="n1:Invoice/cac:OrderReference/cbc:IssueDate">
                              <xsl:apply-templates select="." />
                            </xsl:for-each>
                          </td>
                        </tr>
                      </xsl:if>
                      <xsl:if test="//n1:Invoice/cac:PaymentMeans">
                        <tr style="height:13px; ">
                          <td align="left">
                            <span style="font-weight:bold; color:#000000; ">
                              <xsl:text>Son Ödeme Tarihi:</xsl:text>
                            </span>
                            <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                              <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                                <br />
                                <xsl:text>Payment Due Date</xsl:text>
                              </span>
                            </xsl:if>
                          </td>
                          <td align="left">
                            <xsl:for-each select="n1:Invoice/cac:PaymentMeans">
                              <xsl:for-each select="cbc:PaymentDueDate">
                                <xsl:value-of select="substring(.,9,2)" />-<xsl:value-of select="substring(.,6,2)" />-<xsl:value-of select="substring(.,1,4)" /></xsl:for-each>
                            </xsl:for-each>
                          </td>
                        </tr>
                      </xsl:if>
                      <xsl:for-each select="n1:Invoice/cac:TaxRepresentativeParty/cac:PartyIdentification/cbc:ID[@schemeID='ARACIKURUMVKN']">
                        <tr>
                          <td style="width:105px;" align="left">
                            <span style="font-weight:bold;color:#000000;  ">
                              <xsl:text>Aracı Kurum VKN:</xsl:text>
                            </span>
                          </td>
                          <td style="width:110px;" align="left">
                            <xsl:value-of select="." />
                          </td>
                        </tr>
                        <tr>
                          <td style="width:105px;" align="left">
                            <span style="font-weight:bold;color:#000000;  ">
                              <xsl:text>Aracı Kurum Unvan:</xsl:text>
                            </span>
                          </td>
                          <td style="width:110px;" align="left">
                            <xsl:value-of select="../../cac:PartyName/cbc:Name" />
                          </td>
                        </tr>
                      </xsl:for-each>
                      <xsl:if test="contains(.,'#GTB_REFNO:')">
                        <tr style="height:13px; ">
                          <td align="left">
                            <span style="font-weight:bold; color:#000000; ">
                              <xsl:text>Gtb Refno:</xsl:text>
                            </span>
                            <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                              <br />
                              <xsl:text>Gtb Refno</xsl:text>
                            </span>
                          </td>
                          <td align="left">
                            <xsl:value-of select="substring-before(substring-after(.,'#GTB_REFNO:'),'~;')" />
                          </td>
                        </tr>
                      </xsl:if>
                      <xsl:if test="contains(.,'#GTB_GCB_TESCILNO:')">
                        <tr style="height:13px; ">
                          <td align="left">
                            <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                              <span style="font-weight:bold; color:#000000; ">
                                <xsl:text>Gtb Gcb Tescil No:</xsl:text>
                              </span>
                              <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                                <br />
                                <xsl:text>Gtb GcbRegistrationNo</xsl:text>
                              </span>
                            </xsl:if>
                          </td>
                          <td align="left">
                            <xsl:value-of select="substring-before(substring-after(.,'#GTB_GCB_TESCILNO:'),'~;')" />
                          </td>
                        </tr>
                      </xsl:if>
                      <xsl:if test="contains(.,'#GTB_FIILI_IHRACAT_TARIHI:')">
                        <tr style="height:13px; ">
                          <td align="left">
                            <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                              <span style="font-weight:bold; color:#000000; ">
                                <xsl:text>Gtb Fiili İhracat Tarihi:</xsl:text>
                              </span>
                              <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                                <br />
                                <xsl:text>Gtb ActualExportDate</xsl:text>
                              </span>
                            </xsl:if>
                          </td>
                          <td align="left">
                            <xsl:value-of select="substring-before(substring-after(.,'#GTB_FIILI_IHRACAT_TARIHI:'),'~;')" />
                          </td>
                        </tr>
                      </xsl:if>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr align="left">
                <table id="ettnTable">
                  <tr style="height:13px;">
                    <td align="left" valign="top">
                      <span style="font-weight:bold; color:#000000;">
                        <xsl:text>ETTN:</xsl:text>
                      </span>
                    </td>
                    <td align="left" width="240px">
                      <xsl:for-each select="n1:Invoice/cbc:UUID">
                        <xsl:apply-templates />
                      </xsl:for-each>
                    </td>
                  </tr>
                </table>
              </tr>
            </tbody>
          </table>
          <br />
          <div id="lineTableAligner">
            <span>
              <xsl:text> </xsl:text>
            </span>
          </div>
     
          <table border="1" id="lineTable" width="800px">
            <tbody>     
              <tr id="lineTableTr">
                <td id="lineTableTd" style="width:4%;background-color:#000000;color:#fff;">
                  <span style="font-weight:bold; font-size:9px; color:#fff;" align="center">
                    <xsl:text>S.N</xsl:text>
                    <br />
                  </span>
                  <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                    <span style="font-size:9px;font-style:italic;">
                      <xsl:text>Q.N</xsl:text>
                    </span>
                  </xsl:if>
                </td>
                <xsl:if test="//n1:Invoice//cac:InvoiceLine/cac:Item/cbc:BrandName != ''">
                  <td id="lineTableTd" style="background-color:#000000;color:#fff;" align="center">
                    <span style="font-weight:bold; font-size:9px;color:#fff;" align="center">
                      <xsl:text>Marka</xsl:text>
                      <br />
                    </span>
                    <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                      <span style="font-size:9px;font-style:italic;">
                        <xsl:text>Brand</xsl:text>
                      </span>
                    </xsl:if>
                  </td>
                </xsl:if>
                <xsl:if test="//n1:Invoice/cbc:ProfileID != 'IHRACAT'">
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Item/cac:SellersItemIdentification/cbc:ID != ''">
                    <td id="lineTableTd" style="background-color:#000000;color:#fff;">
                      <span style="font-weight:bold;font-size:9px; color:#fff;" align="center">
                        <xsl:text>Ürün Kodu </xsl:text>
                        <br />
                      </span>
                      <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                        <span style="font-size:9px;font-style:italic;">
                          <xsl:text>Seller Code</xsl:text>
                        </span>
                      </xsl:if>
                    </td>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Item/cac:BuyersItemIdentification/cbc:ID != ''">
                    <td id="lineTableTd" style="background-color:#000000;color:#fff;">
                      <span style="font-weight:bold; font-size:9px; color:#fff;" align="center">
                        <xsl:text>Alıcı Ü. Kodu </xsl:text>
                        <br />
                      </span>
                      <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                        <span style="font-size:9px;font-style:italic;">
                          <xsl:text>Buyer Code</xsl:text>
                        </span>
                      </xsl:if>
                    </td>
                  </xsl:if>
                </xsl:if>
                <td height="25" id="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                  <span style="font-weight:bold;font-size:9px; ">
                    <xsl:text>Mal/Hizmet</xsl:text>
                    <br />
                  </span>
                  <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                    <span style="font-size:9px;font-style:italic;">
                      <xsl:text>Product</xsl:text>
                    </span>
                  </xsl:if>
                </td>
                <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Item/cbc:Description != '' and //n1:Invoice/cbc:ProfileID != 'IHRACAT' ">
                  <td height="25" id="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                    <span style="font-weight:bold;font-size:9px; ">
                      <xsl:text>Açıklama</xsl:text>
                      <br />
                    </span>
                    <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                      <span style="font-size:9px;font-style:italic;">
                        <xsl:text>Description</xsl:text>
                      </span>
                    </xsl:if>
                  </td>
                </xsl:if>
                <xsl:if test="//n1:Invoice/cac:InvoiceLine/cbc:Note != '' and //n1:Invoice/cbc:ProfileID != 'IHRACAT' ">
                  <td height="25" id="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                    <span style="font-weight:bold;font-size:9px; ">
                      <xsl:text>Not</xsl:text>
                      <br />
                    </span>
                    <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                      <span style="font-size:9px;font-style:italic;">
                        <xsl:text>Note</xsl:text>
                      </span>
                    </xsl:if>
                  </td>
                </xsl:if>
                <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Item/cbc:ModelName != '' and //n1:Invoice/cbc:ProfileID != 'IHRACAT'">
                 <td height="25" class="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                   <span style="font-weight:bold;font-size:9px;">
                     <xsl:choose>
                       <xsl:when test="//n1:Invoice/cbc:ProfileID = 'YATIRIMTESVIK' or 
                                       //n1:Invoice/cbc:InvoiceTypeCode = 'YTBISTISNA' or 
                                       //n1:Invoice/cbc:InvoiceTypeCode = 'YTBSATIS' or 
                                       //n1:Invoice/cbc:InvoiceTypeCode = 'YTBIADE' or 
                                       //n1:Invoice/cbc:InvoiceTypeCode = 'YTBTEVKIFAT' or 
                                       //n1:Invoice/cbc:InvoiceTypeCode = 'YTBTEVKIFATIADE'">
                         <xsl:text>Makine Adı</xsl:text>
                       </xsl:when>
                       <xsl:otherwise>
                         <xsl:text>Model</xsl:text>
                       </xsl:otherwise>
                     </xsl:choose>
                     <br />
                   </span>

                   <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                     <span style="font-size:9px;font-style:italic;">
                       <xsl:text>Model Name</xsl:text>
                     </span>
                   </xsl:if>
                 </td>
               </xsl:if>
                <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Item/cac:OriginCountry/cbc:Name != ''">
                  <td height="25" id="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                    <span style="font-weight:bold;font-size:9px; ">
                      <xsl:text>Menşei </xsl:text>
                      <br />
                    </span>
                    <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                      <span style="font-size:9px;font-style:italic;">
                        <xsl:text>Origin Country</xsl:text>
                      </span>
                    </xsl:if>
                  </td>
                </xsl:if>
                <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cbc:NetWeightMeasure  != '0'">
                    <td id="lineTableTd" style="background-color:#000000;color:#fff;">
                      <span style="font-weight:bold;font-size:9px; color:#fff;" align="center">
                        <xsl:text>Net </xsl:text>
                        <br />
                      </span>
                      <span style="font-size:9px;font-style:italic;">
                        <xsl:text>Net</xsl:text>
                      </span>
                    </td>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cbc:GrossWeightMeasure != '0'">
                    <td id="lineTableTd" style="background-color:#000000;color:#fff;">
                      <span style="font-weight:bold; font-size:9px; color:#fff;" align="center">
                        <xsl:text>Brüt </xsl:text>
                        <br />
                      </span>
                      <span style="font-size:9px;font-style:italic;">
                        <xsl:text>Gross</xsl:text>
                      </span>
                    </td>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine//cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:Quantity != ''">
                    <td id="lineTableTd" style="background-color:#000000;color:#fff;" align="center">
                      <span style="font-weight:bold;font-size:9px;">
                        <xsl:text>Kap Adedi</xsl:text>
                        <br />
                      </span>
                      <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                        <span style="font-size:9px;font-style:italic;">
                          <xsl:text>N.of Boxes</xsl:text>
                        </span>
                      </xsl:if>
                    </td>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine//cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode != ''">
                    <td id="lineTableTd" style="background-color:#000000;color:#fff;" align="center">
                      <span style="font-weight:bold;font-size:9px;">
                        <xsl:text>Kap Cinsi</xsl:text>
                        <br />
                      </span>
                      <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                        <span style="font-size:9px;font-style:italic;">
                          <xsl:text>Packaging</xsl:text>
                        </span>
                      </xsl:if>
                    </td>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cbc:Note != ''">
                    <td height="25" id="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                      <span style="font-weight:bold;font-size:9px; ">
                        <xsl:text>Şale</xsl:text>
                        <br />
                      </span>
                      <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                        <span style="font-size:9px;font-style:italic;">
                          <xsl:text>Punnet</xsl:text>
                        </span>
                      </xsl:if>
                    </td>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Item/cbc:Description != ''">
                    <td id="lineTableTd" style="background-color:#000000;color:#fff;" align="center">
                      <span style="font-weight:bold;font-size:9px;">
                        <xsl:text>Palet</xsl:text>
                        <br />
                      </span>
                      <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                        <span style="font-size:9px;font-style:italic;">
                          <xsl:text>Pallet</xsl:text>
                        </span>
                      </xsl:if>
                    </td>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Item/cbc:ModelName != ''">
                    <td id="lineTableTd" style="background-color:#000000;color:#fff;" align="center">
                      <span style="font-weight:bold; font-size:9px;">
                        <xsl:text>Parti No</xsl:text>
                        <br />
                      </span>
                      <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                        <span style="font-size:9px;font-style:italic;">
                          <xsl:text>Part No</xsl:text>
                        </span>
                      </xsl:if>
                    </td>
                  </xsl:if>
                </xsl:if>
                <td id="lineTableTd" style="background-color:#000000;color:#fff;" align="center">
                  <span style="font-weight:bold;font-size:9px;">
                    <xsl:text> Miktar</xsl:text>
                    <br />
                  </span>
                  <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                    <span style="font-size:9px;font-style:italic;">
                      <xsl:text>Quantity</xsl:text>
                    </span>
                  </xsl:if>
                </td>
                <td id="lineTableTd" style="background-color:#000000;color:#fff;">
                  <span style="font-weight:bold; font-size:9px; color:#fff;" align="center">
                    <xsl:text>Birim</xsl:text>
                    <br />
                  </span>
                  <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                    <span style="font-size:9px;font-style:italic;">
                      <xsl:text>Unit</xsl:text>
                    </span>
                  </xsl:if>
                </td>
                <td id="lineTableTd" style="background-color:#000000;color:#fff;" align="center">
                  <span style="font-weight:bold;font-size:9px; ">
                    <xsl:text> Fiyat</xsl:text>
                    <br />
                  </span>
                  <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                    <span style="font-size:9px;font-style:italic;">
                      <xsl:text>Unit Price</xsl:text>
                    </span>
                  </xsl:if>
                </td>
                <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:AllowanceCharge/cbc:Amount != 0">
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:AllowanceCharge/cbc:AllowanceChargeReason != '' ">
                    <td id="lineTableTd" style="background-color:#000000;color:#fff;" align="center">
                      <span style="font-weight:bold; font-size:9px; ">
                        <xsl:text>İskonto Aciklaması</xsl:text>
                        <br />
                      </span>
                      <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                        <span style="font-size:9px;font-style:italic;">
                          <xsl:text>Discount Description</xsl:text>
                        </span>
                      </xsl:if>
                    </td>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:AllowanceCharge/cbc:MultiplierFactorNumeric != 0 ">
                    <td id="lineTableTd" style="background-color:#000000;color:#fff;" align="center">
                      <span style="font-weight:bold; font-size:9px; ">
                        <xsl:text>İskonto O.</xsl:text>
                        <br />
                      </span>
                      <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                        <span style="font-size:9px;font-style:italic;">
                          <xsl:text>Discount %</xsl:text>
                        </span>
                      </xsl:if>
                    </td>
                  </xsl:if>
                  <td id="lineTableTd" style="background-color:#000000;color:#fff;" align="center">
                    <span style="font-weight:bold;font-size:9px; ">
                      <xsl:text>İskonto T.</xsl:text>
                      <br />
                    </span>
                    <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                      <span style="font-size:9px;font-style:italic;">
                        <xsl:text>Discount A.</xsl:text>
                      </span>
                    </xsl:if>
                  </td>
                </xsl:if>

                <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cbc:TaxAmount != 0">
                  <td id="lineTableTd" style="background-color:#000000;color:#fff;" align="center">
                    <span style="font-weight:bold;font-size:9px; ">
                      <xsl:if test="//n1:Invoice/cbc:InvoiceTypeCode='TEVKIFATIADE'">
                         <xsl:text>İade Edilen Mal Oranı</xsl:text>
                      </xsl:if>
                      <xsl:if test="//n1:Invoice/cbc:InvoiceTypeCode!='TEVKIFATIADE'">
                         <xsl:text>KDV O.</xsl:text>
                      </xsl:if>
                      <br />
                    </span>
                    <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                      <span style="font-size:9px;font-style:italic;">
                        <xsl:text>VAT %</xsl:text>
                      </span>
                    </xsl:if>
                  </td>
                  <td id="lineTableTd" style="background-color:#000000;color:#fff;" align="center">
                    <span style="font-weight:bold;font-size:9px; ">
                      <xsl:text>KDV Tutarı</xsl:text>
                      <br />
                    </span>
                    <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                      <span style="font-size:9px;font-style:italic;">
                        <xsl:text>VAT Amount</xsl:text>
                      </span>
                    </xsl:if>
                  </td>
                </xsl:if>

                <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal[cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode!=0015] or //n1:Invoice/cac:InvoiceLine/cac:WithholdingTaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
                  <td id="lineTableTd" style="background-color:#000000;color:#fff;" align="center">
                    <span style="font-weight:bold;font-size:9px; ">
                      <xsl:text>Diğer Vergiler</xsl:text>
                      <br />
                    </span>
                    <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                      <span style="font-size:9px;font-style:italic;">
                        <xsl:text>Other Tax</xsl:text>
                      </span>
                    </xsl:if>
                  </td>
                </xsl:if>
        
         <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                  <td height="25" id="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                    <span style="font-weight:bold;font-size:9px; ">
                      <xsl:text>Gönd. Şekli</xsl:text>
                      <br />
                    </span>
                    <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                      <span style="font-size:9px;font-style:italic;">
                        <xsl:text>Sending Form</xsl:text>
                      </span>
                    </xsl:if>
                  </td>
                  <td height="25" id="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                    <span style="font-weight:bold;font-size:9px; ">
                      <xsl:text>Gtip No</xsl:text>
                      <br />
                    </span>
                    <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                      <span style="font-size:9px;font-style:italic;">
                        <xsl:text>Gtip No</xsl:text>
                      </span>
                    </xsl:if>
                  </td>
                  <td height="25" id="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                    <span style="font-weight:bold;font-size:9px;">
                      <xsl:text>Teslim Şartı</xsl:text>
                      <br />
                    </span>
                    <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                      <span style="font-size:9px;font-style:italic;">
                        <xsl:text>Delivery Cond.</xsl:text>
                      </span>
                    </xsl:if>
                  </td>
                </xsl:if>
                 
                <td height="25" id="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                  <span style="font-weight:bold;font-size:9px; ">
                      <xsl:if test="//n1:Invoice/cbc:InvoiceTypeCode='TEVKIFATIADE'">
                         <xsl:text>İadeye Konu İşlem Bedeli</xsl:text>
                      </xsl:if>
                      <xsl:if test="//n1:Invoice/cbc:InvoiceTypeCode!='TEVKIFATIADE'">
                         <xsl:text>Tutar</xsl:text>
                      </xsl:if>
                    <br />
                  </span>
                  <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                    <span style="font-size:9px;font-style:italic;">
                      <xsl:text>Amount</xsl:text>
                    </span>
                  </xsl:if>
                </td>

           <xsl:if test="//n1:Invoice/cbc:InvoiceTypeCode='TEVKIFATIADE'">
                <td height="25" id="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                  <span style="font-weight:bold;font-size:9px; ">
                     <xsl:text>Tevkifatsız KDV Tutarı</xsl:text>
                    <br />
                  </span>
                  <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                    <span style="font-size:9px;font-style:italic;">
                      <xsl:text>Taxable Amount</xsl:text>
                    </span>
                  </xsl:if>
                </td>
           </xsl:if>

             <xsl:if test="//n1:Invoice/cbc:ProfileID = 'YATIRIMTESVIK' or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBISTISNA' or  //n1:Invoice/cbc:InvoiceTypeCode = 'YTBSATIS' or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBIADE' or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBTEVKIFAT' or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBTEVKIFATIADE' ">
                <td height="25" id="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                    <span style="font-weight:bold;font-size:9px;">
                      <xsl:text>Harcama Tipi</xsl:text>
                    </span>
                  </td>
                  <xsl:if test="count(//n1:Invoice/cac:InvoiceLine/cac:Item/cac:CommodityClassification/cbc:ItemClassificationCode) ">
  
                <td height="25" id="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                      <span style="font-weight:bold;font-size:9px;">
                        <xsl:text>Makine Teçhizat Sıra No</xsl:text>
                      </span>
                    </td>
                <td height="25" id="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                    <span style="font-weight:bold;font-size:9px;">
                        <xsl:text>Makine Id</xsl:text>
                      </span>
                    </td>
                  </xsl:if>
                </xsl:if>

                 <xsl:for-each select="//cac:InvoiceLine/cac:Item/cac:AdditionalItemIdentification/cbc:ID/@schemeID[ . != 'BIRIM' and not(. = preceding::cbc:ID/@schemeID) ]">
                <td height="25" class="lineTableTd" bgcolor="#000000" style="color:#fff; font-weight:bold; font-size:9px; white-space: nowrap; width: 1%; padding: 0 10px;" align="center">
                    <span style="font-weight:bold;font-size:9px;">
                        <xsl:value-of select="."/>
                        <br/>
                    </span>
                    
                    <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                        <span style="font-size:9px;font-style:italic;">
                            <xsl:value-of select="."/>
                        </span>
                    </xsl:if>
                </td>
                </xsl:for-each>
                <xsl:for-each select="//n1:Invoice/cac:InvoiceLine/cac:Item/cac:AdditionalItemProperty/cbc:Name[not(. = preceding::cac:AdditionalItemProperty/cbc:Name)]">
                <td height="25" id="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                  <span style="font-weight:bold;font-size:9px;">
                    <xsl:value-of select="." />
                  </span>
                </td>
                </xsl:for-each>
              </tr>
        
        
              <xsl:for-each select="//n1:Invoice/cac:InvoiceLine">
                <tr id="lineTableTr">
                  <td id="lineTableTd" align="center">
                    <xsl:value-of select="./cbc:ID" />
                  </td>
                  <xsl:if test="//n1:Invoice//cac:InvoiceLine/cac:Item/cbc:BrandName != ''">
                    <td id="lineTableTd" align="center">
                      <xsl:value-of select="./cac:Item/cbc:BrandName" />
                    </td>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cbc:ProfileID != 'IHRACAT'">
                    <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Item/cac:SellersItemIdentification/cbc:ID != ''">
                      <td id="lineTableTd" align="center">
                        <xsl:value-of select="./cac:Item/cac:SellersItemIdentification/cbc:ID" />
                      </td>
                    </xsl:if>
                    <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Item/cac:BuyersItemIdentification/cbc:ID != ''">
                      <td id="lineTableTd" align="center">
                        <xsl:value-of select="./cac:Item/cac:BuyersItemIdentification/cbc:ID" />
                      </td>
                    </xsl:if>
                  </xsl:if>
                  <td id="lineTableTd" align="left">
                    <xsl:value-of select="./cac:Item/cbc:Name" />
                  </td>
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Item/cbc:Description != '' and //n1:Invoice/cbc:ProfileID != 'IHRACAT' ">
                    <td id="lineTableTd" align="left">
                      <xsl:value-of select="./cac:Item/cbc:Description" />
                    </td>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cbc:Note != '' and //n1:Invoice/cbc:ProfileID != 'IHRACAT' ">
                    <td id="lineTableTd" align="left">
                      <xsl:for-each select="./cbc:Note">
                        <xsl:value-of select="." />
                        <br />
                      </xsl:for-each>
                    </td>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Item/cbc:ModelName != '' and //n1:Invoice/cbc:ProfileID != 'IHRACAT' ">
                    <td id="lineTableTd" align="left">
                      <xsl:value-of select="./cac:Item/cbc:ModelName" />
                    </td>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Item/cac:OriginCountry/cbc:Name != ''">
                    <td id="lineTableTd" align="left">
                      <xsl:value-of select="./cac:Item/cac:OriginCountry/cbc:Name" />
                    </td>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                    <xsl:if test="//n1:Invoice/cac:InvoiceLine//cac:Delivery/cac:Shipment/cbc:NetWeightMeasure != '0'">
                      <td id="lineTableTd" align="center">
                        <xsl:value-of select="./cac:Delivery/cac:Shipment/cbc:NetWeightMeasure" />
                                     KG
                                 </td>
                    </xsl:if>
                    <xsl:if test="//n1:Invoice/cac:InvoiceLine//cac:Delivery/cac:Shipment/cbc:GrossWeightMeasure!= '0'">
                      <td id="lineTableTd" align="center">
                        <xsl:value-of select="./cac:Delivery/cac:Shipment/cbc:GrossWeightMeasure" />
                                     KG
                                 </td>
                    </xsl:if>
                    <xsl:if test="//n1:Invoice/cac:InvoiceLine//cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:Quantity != ''">
                      <td id="lineTableTd" align="center">
                        <xsl:value-of select="format-number(./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:Quantity, '###.###,####', 'european')" />
                      </td>
                    </xsl:if>
                    <xsl:if test="//n1:Invoice/cac:InvoiceLine//cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode != ''">
                      <td id="lineTableTd" align="center">
                        <xsl:choose>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = '4H'">
                            <xsl:text> P.Cases </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = '5H'">
                            <xsl:text> C.Boxes </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = '6H'">
                            <xsl:text> W.Cases </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'EC'">
                            <xsl:text> P.Bag </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'SA'">
                            <xsl:text> Sack </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'PJ'">
                            <xsl:text> Punnet </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = '8A'">
                            <xsl:text> Pallet </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'PX'">
                            <xsl:text> Pallet </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'DR'">
                            <xsl:text> Drum </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'BK'">
                            <xsl:text> Basket </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'TN'">
                            <xsl:text> Tin </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'CT'">
                            <xsl:text> Carton </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'BE'">
                            <xsl:text> Bundle </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'BG'">
                            <xsl:text> Bag </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'BH'">
                            <xsl:text> Bunch </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'BI'">
                            <xsl:text> Bin </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'BJ'">
                            <xsl:text> Bucket </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'BX'">
                            <xsl:text> Box </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'CB'">
                            <xsl:text> Crate,beer </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'CH'">
                            <xsl:text> Chest </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'CI'">
                            <xsl:text> Canister </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'CK'">
                            <xsl:text> Cask </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'CN'">
                            <xsl:text> Container </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'CR'">
                            <xsl:text> Crate </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'DK'">
                            <xsl:text> Crate,bulk,cardboard </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'DR'">
                            <xsl:text> Drum </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'FC&#xD;&#xA;                                       '">
                            <xsl:text> Crate,Fruit </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'JR'">
                            <xsl:text> Jar </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'LV'">
                            <xsl:text> Liftvan </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'NE'">
                            <xsl:text> Unpacked or Unpackaged </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'SU'">
                            <xsl:text> Suitcase </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'VG'">
                            <xsl:text> Bulk,gas </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode ='VL'">
                            <xsl:text> Bulk,liquid </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode ='VO'">
                            <xsl:text> Bulk,solid </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode ='BA'">
                            <xsl:text> Barrel </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode ='EC'">
                            <xsl:text> Bag,plastic </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode ='5H'">
                            <xsl:text> Bag,woven,plastic </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode ='6H'">
                            <xsl:text> Composite packaging , plastic receptacle </xsl:text>
                          </xsl:when>
              
                          <xsl:otherwise>
              <xsl:value-of select="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode" />
              <xsl:value-of select="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode/@name" />
                          </xsl:otherwise>
                        </xsl:choose>
                      </td>
                    </xsl:if>
                    <xsl:if test="//n1:Invoice/cac:InvoiceLine/cbc:Note != ''">
                      <td id="lineTableTd" align="center">
                        <xsl:value-of select="./cbc:Note" />
                      </td>
                    </xsl:if>
                    <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Item/cbc:Description != ''">
                      <td id="lineTableTd" align="center">
                        <xsl:value-of select="./cac:Item/cbc:Description" />
                      </td>
                    </xsl:if>
                    <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Item/cbc:ModelName != ''">
                      <td id="lineTableTd" align="center">
                        <xsl:value-of select="./cac:Item/cbc:ModelName" />
                      </td>
                    </xsl:if>
                  </xsl:if>
                  <td id="lineTableTd" align="center">
                    <xsl:value-of select="format-number(./cbc:InvoicedQuantity, '###.##0,########', 'european')" />
                  </td>
                  <td id="lineTableTd" align="center">
                    <xsl:if test="./cbc:InvoicedQuantity/@unitCode">
                      <xsl:for-each select="./cbc:InvoicedQuantity">
                        <xsl:text>
                        </xsl:text>
                        <xsl:choose>
                          <xsl:when test="@unitCode  = '26'">
                            <xsl:text>Ton</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'BX'">
                            <xsl:text>Kutu</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'LTR'">
                            <xsl:text>Lt</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'C62'">
                            <xsl:text>Adet</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'KGM'">
                            <xsl:text>Kg</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'KJO'">
                            <xsl:text>KJ</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'GRM'">
                            <xsl:text>Gram</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'MGM'">
                            <xsl:text>Mg</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'NT'">
                            <xsl:text>Net Ton</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'GT'">
                            <xsl:text>Gross Ton</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'MTR'">
                            <xsl:text>M</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'MMT'">
                            <xsl:text>Mm</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'KTM'">
                            <xsl:text>Km</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'MLT'">
                            <xsl:text>Ml</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'MMQ'">
                            <xsl:text>Mm3</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'CLT'">
                            <xsl:text>cl</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'CMK'">
                            <xsl:text>cm2</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'CMQ'">
                            <xsl:text>cm3</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'CMT'">
                            <xsl:text>cm</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'MTK'">
                            <xsl:text>m2</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'MTQ'">
                            <xsl:text>m3</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'DAY'">
                            <xsl:text> Gün</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'MON'">
                            <xsl:text> Ay</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'PA'">
                            <xsl:text> Paket</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'KWH'">
                            <xsl:text> KWH</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'ANN'">
                            <xsl:text> Yıl</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'HUR'">
                            <xsl:text> Saat</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'MIN'">
                            <xsl:text> Dakika</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'SEC'">
                            <xsl:text> Saniye</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'CCT'">
                            <xsl:text> Ton baş.taşıma kap.</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'D30'">
                            <xsl:text> Brüt kalori</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'D40'">
                            <xsl:text> 1000 lt</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'LPA'">
                            <xsl:text> saf alkol lt</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'B32'">
                            <xsl:text> kg.m2</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'NCL'">
                            <xsl:text> hücre adet</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'PR'">
                            <xsl:text> Çift</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'R9'">
                            <xsl:text> 1000 m3</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'SET'">
                            <xsl:text> Takım</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'T3'">
                            <xsl:text> 1000 adet</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'SA'">
                            <xsl:text> Çuval</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = '5H'">
                            <xsl:text> C.Boxes</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = '4H'">
                            <xsl:text> P.Cases</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'BFT'">
                            <xsl:text> W.Cases</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'EC'">
                            <xsl:text> P.Bag</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'PJ'">
                            <xsl:text> Punnet</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='BJ'">
                            <xsl:text> Kova</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='AFF'">
                            <xsl:text> afif birim fiyatı</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='AKQ'">
                            <xsl:text> atv birim fiyatı</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='AYR'">
                            <xsl:text> altın ayarı</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='B32'">
                            <xsl:text> kg-metre kare</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='BAS'">
                            <xsl:text> bas</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='C62'">
                            <xsl:text> adet</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='CCT'">
                            <xsl:text> ton başına taşıma kapasitesi</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='PR'">
                            <xsl:text> adet-çift</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='D30'">
                            <xsl:text> brüt kalori değeri</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='D40'">
                            <xsl:text> bin litre</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='GFI'">
                            <xsl:text> fıssıle izotop gramı</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='GMS'">
                            <xsl:text> gümüş</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='GRM'">
                            <xsl:text> gram</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='GT'">
                            <xsl:text> gross ton</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='H62'">
                            <xsl:text> yüz adet</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='K20'">
                            <xsl:text> kilogram potasyum oksit</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='K58'">
                            <xsl:text> kurutulmuş net ağırlıklı kilogramı</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='K62'">
                            <xsl:text> kilogram-adet</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KFO'">
                            <xsl:text> difosfor pentaoksit kilogramı</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KGM'">
                            <xsl:text> kilogram</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KH6'">
                            <xsl:text> kilogram-baş</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KHO'">
                            <xsl:text> hidrojen peroksit kilogramı</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KMA'">
                            <xsl:text> metil aminlerin kilogramı</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KNI'">
                            <xsl:text> azotun kilogramı</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KOH'">
                            <xsl:text> kilogram potasyum hidroksit</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KPH'">
                            <xsl:text> kg potasyum oksid</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KPR'">
                            <xsl:text> kilogram-çift</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KSD'">
                            <xsl:text> kuru ürün kilogramı %90</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KSH'">
                            <xsl:text> sodyum hidroksit kilogramı</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KUR'">
                            <xsl:text> uranyum kilogramı</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KWH'">
                            <xsl:text> kilowatt saat</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KWT'">
                            <xsl:text> kilowatt</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='LPA'">
                            <xsl:text> saf alkol litresi</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='LTR'">
                            <xsl:text> litre</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='MTK'">
                            <xsl:text> metre kare</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='MTQ'">
                            <xsl:text> metre küp</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='MTR'">
                            <xsl:text> metre</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='NCL'">
                            <xsl:text> hücre adedi</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='NCR'">
                            <xsl:text> karat</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='OMV'">
                            <xsl:text> otv maktu vergi</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='OTB'">
                            <xsl:text> otv birim fiyatı</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='R9'">
                            <xsl:text> bin metre küp</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='T3'">
                            <xsl:text> bin adet</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='TWH'">
                            <xsl:text> bin kilowatt saat</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='DRL'">
                            <xsl:text> rulo</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='26'">
                            <xsl:text> ton</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='SA'">
                            <xsl:text> çuval</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='C68'">
                            <xsl:text> punnet</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='4H'">
                            <xsl:text> p.cases</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='5H'">
                            <xsl:text> c.boxes</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='BFT'">
                            <xsl:text> w.cases</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='EC'">
                            <xsl:text> p.bag</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='SA'">
                            <xsl:text> sack</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='BX'">
                            <xsl:text> kutu</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='BO'">
                            <xsl:text> şişe</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='SL'">
                            <xsl:text> palet</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='SET'">
                            <xsl:text> takım</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='PA'">
                            <xsl:text> paket</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='CT'">
                            <xsl:text> karton</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='J57'">
                            <xsl:text> varil</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='JOU'">
                            <xsl:text> vardiya</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='MON'">
                            <xsl:text> ay</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='HUR'">
                            <xsl:text> saat</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='D62'">
                            <xsl:text> saniye</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='ANN'">
                            <xsl:text> yıl</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='DAY'">
                            <xsl:text> gün</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='CL'">
                            <xsl:text> bobin</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='E27'">
                            <xsl:text> doz</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='EA'">
                            <xsl:text> ea</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='PK'">
                            <xsl:text> koli</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='ST'">
                            <xsl:text> tbk</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='MGM'">
                            <xsl:text> mw</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KF'">
                            <xsl:text> Kilo Paket</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='DR'">
                            <xsl:text> bidon</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='1J'">
                            <xsl:text> ton mile</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='HAR'">
                            <xsl:text> hektar</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='LR'">
                            <xsl:text> tabaka</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='BJ'">
                            <xsl:text> kova</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='DPC'">
                            <xsl:text> düzine parça</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='DPR'">
                            <xsl:text> düzine çift</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KTM'">
                            <xsl:text> kilometre</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='MIN'">
                            <xsl:text> dakika</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='MAW'">
                            <xsl:text> megawatt</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='MWH'">
                            <xsl:text> megawatt saat</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='TL'">
                            <xsl:text> tl</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='WEE'">
                            <xsl:text> hafta</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='CMQ'">
                            <xsl:text> cm3</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='MMT'">
                            <xsl:text> mm</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='TC'">
                            <xsl:text> kamyon</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='CH'">
                            <xsl:text> konteynır</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='BG'">
                            <xsl:text> poşet</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='ACR'">
                            <xsl:text> dönüm</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='TNE'">
                            <xsl:text> ton</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='CR'">
                            <xsl:text> sandık</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='NIU'">
                            <xsl:text> adet</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='TN'">
                            <xsl:text> teneke</xsl:text>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:value-of select="@unitCode" />
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:for-each>
                    </xsl:if>
                  </td>
          
                  <td id="lineTableTd" align="center">
                    <xsl:value-of select="format-number(./cac:Price/cbc:PriceAmount, '###.##0,########', 'european')" />
                    <xsl:if test="./cac:Price/cbc:PriceAmount/@currencyID">
                      <xsl:text>
                      </xsl:text>
                      <xsl:if test="./cac:Price/cbc:PriceAmount/@currencyID = &quot;TRY&quot; or ./cac:Price/cbc:PriceAmount/@currencyID = &quot;TRY&quot;">
                        <xsl:text>TL</xsl:text>
                      </xsl:if>
                      <xsl:if test="./cac:Price/cbc:PriceAmount/@currencyID != &quot;TRY&quot; and ./cac:Price/cbc:PriceAmount/@currencyID != &quot;TRY&quot;">
                        <xsl:value-of select="./cac:Price/cbc:PriceAmount/@currencyID" />
                      </xsl:if>
                    </xsl:if>
                  </td>
          
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:AllowanceCharge/cbc:Amount != 0">
                    <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:AllowanceCharge/cbc:AllowanceChargeReason != '' ">
                      <td id="lineTableTd" align="center">
                        <xsl:for-each select="./cac:AllowanceCharge">
                          <xsl:value-of select="cbc:AllowanceChargeReason" />
                          <br />
                        </xsl:for-each>
                      </td>
                    </xsl:if>
                    <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:AllowanceCharge/cbc:MultiplierFactorNumeric != 0 ">
                      <td id="lineTableTd" align="center">
                        <xsl:for-each select="./cac:AllowanceCharge">
                          <xsl:if test="cbc:MultiplierFactorNumeric">
                            <xsl:text> %</xsl:text>
                            <xsl:value-of select="format-number(cbc:MultiplierFactorNumeric * 100, '###.##0,########', 'european')" />
                            <br />
                          </xsl:if>
                        </xsl:for-each>
                      </td>
                    </xsl:if>
                    <td id="lineTableTd" align="center">
                      <xsl:for-each select="./cac:AllowanceCharge">
                        <xsl:value-of select="format-number(cbc:Amount, '###.##0,00', 'european')" />
                        <br />
                      </xsl:for-each>
                    </td>
                  </xsl:if>
                 <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cbc:TaxAmount != 0 or (//n1:Invoice/cbc:ProfileID = 'YATIRIMTESVIK' and //n1:Invoice/cbc:InvoiceTypeCode = 'ISTISNA') or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBISTISNA'">
                  <td id="lineTableTd" align="center">
                    <xsl:choose>
                      <xsl:when test="(//n1:Invoice/cbc:ProfileID = 'YATIRIMTESVIK' and //n1:Invoice/cbc:InvoiceTypeCode = 'ISTISNA') or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBISTISNA'">
                        <xsl:text>%0,00</xsl:text>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:for-each select="./cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
                          <xsl:if test="cbc:TaxTypeCode='0015' ">
                            <xsl:if test="../../cbc:Percent">
                              <xsl:text> %</xsl:text>
                              <xsl:value-of select="format-number(../../cbc:Percent, '###.##0,00', 'european')" />
                            </xsl:if>
                          </xsl:if>
                        </xsl:for-each>
                      </xsl:otherwise>
                    </xsl:choose>
                  </td>
                  <td id="lineTableTd" align="center">
                    <xsl:choose>
                      <xsl:when test="(//n1:Invoice/cbc:ProfileID = 'YATIRIMTESVIK' and //n1:Invoice/cbc:InvoiceTypeCode = 'ISTISNA') or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBISTISNA'">
                        <xsl:text>0,00</xsl:text>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:for-each select="./cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
                          <xsl:if test="cbc:TaxTypeCode='0015' ">
                            <xsl:for-each select="../../cbc:TaxAmount">
                              <xsl:call-template name="Curr_Type" />
                            </xsl:for-each>
                          </xsl:if>
                        </xsl:for-each>
                      </xsl:otherwise>
                    </xsl:choose>
                  </td>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal[cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode!=0015] or //n1:Invoice/cac:InvoiceLine/cac:WithholdingTaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
                    <td id="lineTableTd" align="center">
                      <xsl:text> </xsl:text>
                      <xsl:for-each select="./cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
                        <xsl:if test="cbc:TaxTypeCode!='0015' ">
                          <xsl:text>
                          </xsl:text>
                          <xsl:value-of select="cbc:Name" />
                          <xsl:if test="../../cbc:Percent">
                            <xsl:text> (%</xsl:text>
                            <xsl:value-of select="format-number(../../cbc:Percent, '###.##0,00', 'european')" />
                            <xsl:text>)=</xsl:text>
                          </xsl:if>
                          <xsl:for-each select="../../cbc:TaxAmount">
                            <xsl:call-template name="Curr_Type" />
                          </xsl:for-each>
                        </xsl:if>
                      </xsl:for-each>
                      <xsl:for-each select="./cac:WithholdingTaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
                        <xsl:text>   KDV TEVKİFAT </xsl:text>
                        <xsl:if test="../../cbc:Percent">
                          <xsl:text> (%</xsl:text>
                          <xsl:value-of select="format-number(../../cbc:Percent, '###.##0,00', 'european')" />
                          <xsl:text>)=</xsl:text>
                        </xsl:if>
                        <xsl:for-each select="../../cbc:TaxAmount">
                          <xsl:call-template name="Curr_Type" />
                          <xsl:text>
                          </xsl:text>
                        </xsl:for-each>
                      </xsl:for-each>
                    </td>
                  </xsl:if>
          
           <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                    <td id="lineTableTd" align="center">
                      <xsl:choose>
                        <xsl:when test="./cac:Delivery/cac:Shipment/cac:ShipmentStage/cbc:TransportModeCode = '0'">
                          <xsl:text>Transport Mode Not Specified </xsl:text>
                        </xsl:when>
                        <xsl:when test="./cac:Delivery/cac:Shipment/cac:ShipmentStage/cbc:TransportModeCode = '1'">
                          <xsl:text>BY SHIP</xsl:text>
                        </xsl:when>
                        <xsl:when test="./cac:Delivery/cac:Shipment/cac:ShipmentStage/cbc:TransportModeCode = '2'">
                          <xsl:text>BY TRAIN</xsl:text>
                        </xsl:when>
                        <xsl:when test="./cac:Delivery/cac:Shipment/cac:ShipmentStage/cbc:TransportModeCode = '3'">
                          <xsl:text>BY TRUCK</xsl:text>
                        </xsl:when>
                        <xsl:when test="./cac:Delivery/cac:Shipment/cac:ShipmentStage/cbc:TransportModeCode = '4'">
                          <xsl:text>BY AIRPLANE</xsl:text>
                        </xsl:when>
                        <xsl:when test="./cac:Delivery/cac:Shipment/cac:ShipmentStage/cbc:TransportModeCode = '5'">
                          <xsl:text>Email</xsl:text>
                        </xsl:when>
                        <xsl:when test="./cac:Delivery/cac:Shipment/cac:ShipmentStage/cbc:TransportModeCode = '6'">
                          <xsl:text>Multiple Transportation</xsl:text>
                        </xsl:when>
                        <xsl:when test="./cac:Delivery/cac:Shipment/cac:ShipmentStage/cbc:TransportModeCode = '7'">
                          <xsl:text>Fixed Shipping</xsl:text>
                        </xsl:when>
                        <xsl:when test="./cac:Delivery/cac:Shipment/cac:ShipmentStage/cbc:TransportModeCode = '8'">
                          <xsl:text>Inland Water Transport</xsl:text>
                        </xsl:when>
                        <xsl:when test="./cac:Delivery/cac:Shipment/cac:ShipmentStage/cbc:TransportModeCode = '9'">
                          <xsl:text>Transport Mode Not Available</xsl:text>
                        </xsl:when>
                      </xsl:choose>
                    </td>
                    <td id="lineTableTd" align="center">
                      <xsl:value-of select="./cac:Delivery/cac:Shipment/cac:GoodsItem/cbc:RequiredCustomsID" />
                    </td>
                    <td id="lineTableTd" align="center">
                      <xsl:value-of select="./cac:Delivery/cac:DeliveryTerms/cbc:ID" />
                      <xsl:if test="./cac:Delivery/cac:DeliveryTerms/cbc:SpecialTerms !=''"> 
                      - <xsl:value-of select="./cac:Delivery/cac:DeliveryTerms/cbc:SpecialTerms" /></xsl:if>
                    </td>
                  </xsl:if>
   
          
                  <td id="lineTableTd" align="right">
                    <xsl:for-each select="cbc:LineExtensionAmount">
                      <xsl:call-template name="Curr_Type" />
                    </xsl:for-each>
                  </td>

                <xsl:if test="//n1:Invoice/cbc:InvoiceTypeCode='TEVKIFATIADE'">
                    <td id="lineTableTd" align="center">
                        <xsl:for-each select="./cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
                          <xsl:if test="cbc:TaxTypeCode='0015' ">
                            <xsl:text>
                            </xsl:text>
                            <xsl:for-each select="../../cbc:TaxableAmount">
                              <xsl:call-template name="Curr_Type" />
                            </xsl:for-each>
                          </xsl:if>
                        </xsl:for-each>
                      </td>
                 </xsl:if>


                  <xsl:if test="//n1:Invoice/cbc:ProfileID = 'YATIRIMTESVIK' or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBISTISNA' or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBSATIS' or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBIADE' or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBTEVKIFAT' or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBTEVKIFATIADE'">
                <td class="lineTableTd" align="left">
                  <xsl:text>&#160;</xsl:text>
                  <xsl:for-each
                    select="cac:Item/cac:CommodityClassification/cbc:ItemClassificationCode">           
                    <xsl:apply-templates/>
                    <xsl:text>&#160;-&#160;</xsl:text>
                    <xsl:choose>
                      <xsl:when test=". = '01'">
                        <xsl:text>Makine ve teçhizat teslimleri ile yazılım ve gayrimaddi hak satış ve kiralamaları</xsl:text>
                      </xsl:when>
                      <xsl:when test=". = '02'">
                        <xsl:text>İnşaat işlerine ilişkin mal teslimleri ve hizmet ifaları</xsl:text>
                      </xsl:when>
                      <xsl:when test=". = '03'">
                        <xsl:text>Arsa /Arazi Satışları</xsl:text>
                      </xsl:when>
                      <xsl:when test=". = '04'">
                        <xsl:text>Diğer harcamalar </xsl:text>
                      </xsl:when>
                    </xsl:choose>
                  </xsl:for-each>
                </td>
                <xsl:if test="count(//n1:Invoice/cac:InvoiceLine/cac:Item/cac:CommodityClassification/cbc:ItemClassificationCode) ">
                  <td class="lineTableTd" align="right">
                    <xsl:text>&#160;</xsl:text>
                    <xsl:for-each
                      select="cac:Item/cac:ItemInstance/cbc:ProductTraceID">
                      <xsl:text>&#160;</xsl:text>
                      <xsl:apply-templates/>
                    </xsl:for-each>
                  </td>
                  <td class="lineTableTd" align="right">
                    <xsl:text>&#160;</xsl:text>
                    <xsl:for-each
                      select="cac:Item/cac:ItemInstance/cbc:SerialID">
                      <xsl:text>&#160;</xsl:text>
                      <xsl:apply-templates/>
                    </xsl:for-each>
                  </td>
                </xsl:if>       
              </xsl:if>
              <xsl:variable name="line" select="."/>
              <xsl:for-each select="//cac:InvoiceLine/cac:Item/cac:AdditionalItemIdentification/cbc:ID/@schemeID[ . != 'BIRIM' and not(. = preceding::cbc:ID/@schemeID) ]">
                  <td class="lineTableTd" align="center" style="white-space: nowrap; width: 1%; padding: 0 10px;">
                      <xsl:choose>
                          <xsl:when test="//n1:Invoice/cbc:ProfileID = 'IDIS' and string(current()) = 'ETIKETNO'">
                              <xsl:for-each select="$line/cac:Item/cac:AdditionalItemIdentification/cbc:ID[@schemeID = 'ETIKETNO']">
                                  <xsl:value-of select="."/>
                                  <xsl:if test="position() != last()"><br/></xsl:if>
                              </xsl:for-each>
                          </xsl:when>
                          <xsl:otherwise>
                              <xsl:value-of select="($line/cac:Item/cac:AdditionalItemIdentification/cbc:ID[@schemeID = string(current())])[1]"/>
                          </xsl:otherwise>
                      </xsl:choose>
                  </td>
              </xsl:for-each>
              <xsl:for-each select="//n1:Invoice/cac:InvoiceLine/cac:Item/cac:AdditionalItemProperty/cbc:Name[not(. = preceding::cac:AdditionalItemProperty/cbc:Name)]">
                <xsl:variable name="customColumnName" select="." />
                <td id="lineTableTd" align="center">
                  <xsl:value-of select="$line/cac:Item/cac:AdditionalItemProperty[cbc:Name = $customColumnName]/cbc:Value" />
                </td>
              </xsl:for-each>
                </tr>
              </xsl:for-each>
            </tbody>
          </table>
        </xsl:for-each>
        <table id="budgetContainerTable" style="margin-left:320px;" width="480px">
          <xsl:for-each select="n1:Invoice/cac:TaxTotal/cac:TaxSubtotal">
            <xsl:if test="cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode = '4171'">
              <tr id="budgetContainerTr" align="right">
                <td id="budgetContainerDummyTd" />
                <td id="lineTableBudgetTd" align="right" width="210px">
                  <span style="font-weight:bold;color:#000000;">
                    <xsl:text>Teslim Bedeli</xsl:text>
                  </span>
                </td>
                <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                  <td id="lineTableBudgetTd" align="left" width="180px">
                    <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                      <xsl:text>  Delivery Price</xsl:text>
                    </span>
                  </td>
                </xsl:if>
                <td id="lineTableBudgetTd" style="width:90px; " align="right">
                  <xsl:for-each select="n1:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount">
                    <xsl:call-template name="Curr_Type" />
                  </xsl:for-each>
                </td>
              </tr>
            </xsl:if>
          </xsl:for-each>
          <tr id="budgetContainerTr" align="right">
            <td id="budgetContainerDummyTd" />
            <td id="lineTableBudgetTd" align="right" width="210px">
              <span style="font-weight:bold;color:#000000;">
                 <xsl:if test="//n1:Invoice/cbc:InvoiceTypeCode='TEVKIFATIADE'">
                       <xsl:text>İadeye Konu İşlem Bedeli Tutarı</xsl:text>
                 </xsl:if>
                 <xsl:if test="//n1:Invoice/cbc:InvoiceTypeCode!='TEVKIFATIADE'">
                       <xsl:text>Mal/Hizmet Toplam Tutarı</xsl:text>
                 </xsl:if>
              </span>
            </td>
            <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
              <td id="lineTableBudgetTd" align="left" width="180px">
                <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                  <xsl:text>  Goods/Service Total Amount</xsl:text>
                </span>
              </td>
            </xsl:if>
            <td id="lineTableBudgetTd" style="width:90px; " align="right">
              <xsl:for-each select="n1:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount">
                <xsl:call-template name="Curr_Type" />
              </xsl:for-each>
            </td>
          </tr>

          <xsl:if test="n1:Invoice/cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount !=0">
            <tr id="budgetContainerTr" align="right">
              <td id="budgetContainerDummyTd" />
              <td id="lineTableBudgetTd" align="right" width="210px">
                <span style="font-weight:bold;color:#000000;">
                  <xsl:text>Toplam İskonto</xsl:text>
                </span>
              </td>
              <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                <td id="lineTableBudgetTd" align="left" width="180px">
                  <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                    <xsl:text>  Total Discount</xsl:text>
                  </span>
                </td>
              </xsl:if>
              <td id="lineTableBudgetTd" style="width:90px; " align="right">
                <xsl:for-each select="n1:Invoice/cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount">
                  <xsl:call-template name="Curr_Type" />
                </xsl:for-each>
              </td>
            </tr>
          </xsl:if>
          <xsl:if test="not(//n1:Invoice/cbc:ProfileID = 'YATIRIMTESVIK' and //n1:Invoice/cbc:InvoiceTypeCode = 'ISTISNA') and //n1:Invoice/cbc:InvoiceTypeCode != 'YTBISTISNA'">
          <xsl:for-each select="n1:Invoice/cac:TaxTotal/cac:TaxSubtotal">
            <tr id="budgetContainerTr" align="right">
              <td id="budgetContainerDummyTd" />
              <td id="lineTableBudgetTd" width="210px" align="right">
                <span style="font-weight:bold;color:#000000; ">
                  <xsl:value-of select="cac:TaxCategory/cac:TaxScheme/cbc:Name" />
                  <xsl:text>(</xsl:text>
                  <xsl:value-of select="format-number(cbc:TaxableAmount, '###.##0,00', 'european')" />
                  <xsl:text> %</xsl:text>
                  <xsl:value-of select="cbc:Percent" />
                  <xsl:text>)</xsl:text>
                </span>
              </td>
              <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                <td id="lineTableBudgetTd" width="180px" align="left">
                  <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                    <xsl:text>  Tax Percent</xsl:text>
                    <xsl:text>(</xsl:text>
                    <xsl:value-of select="cbc:Percent" />
                    <xsl:text>%)</xsl:text>
                  </span>
                </td>
              </xsl:if>
              <td id="lineTableBudgetTd" style="width:90px; " align="right">
                <xsl:for-each select="cac:TaxCategory/cac:TaxScheme">
                  <xsl:text>
                  </xsl:text>
                  <xsl:value-of select="format-number(../../cbc:TaxAmount, '###.##0,00', 'european')" />
                  <xsl:if test="../../cbc:TaxAmount/@currencyID">
                    <xsl:text>
                    </xsl:text>
                    <xsl:if test="../../cbc:TaxAmount/@currencyID = 'TRL' or ../../cbc:TaxAmount/@currencyID = 'TRY'">
                      <xsl:text>TL</xsl:text>
                    </xsl:if>
                    <xsl:if test="../../cbc:TaxAmount/@currencyID != 'TRL' and ../../cbc:TaxAmount/@currencyID != 'TRY'">
                      <xsl:value-of select="../../cbc:TaxAmount/@currencyID" />
                    </xsl:if>
                  </xsl:if>
                </xsl:for-each>
              </td>
            </tr>
          </xsl:for-each>
           </xsl:if>
    <xsl:for-each select="n1:Invoice/cac:AllowanceCharge">
         <xsl:if test="cbc:Amount !=0 and cbc:AllowanceChargeReason !=''">
            <tr id="budgetContainerTr" align="right">
              <td id="budgetContainerDummyTd" />
              <td id="lineTableBudgetTd" width="210px" align="right">
                <span style="font-weight:bold;color:#000000; ">
                  <xsl:value-of select="cbc:AllowanceChargeReason" />
                  <xsl:text>(</xsl:text>
                  <xsl:value-of select="format-number(cbc:BaseAmount, '###.##0,00', 'european')" />
                  <xsl:text> %</xsl:text>
                  <xsl:value-of select="cbc:MultiplierFactorNumeric" />
                  <xsl:text>)</xsl:text>
                </span>
              </td>
              <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                <td id="lineTableBudgetTd" width="180px" align="left">
                  <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                    <xsl:text> Tax Percent</xsl:text>
                    <xsl:text>(</xsl:text>
                    <xsl:value-of select="cbc:MultiplierFactorNumeric" />
                    <xsl:text>%)</xsl:text>
                  </span>
                </td>
              </xsl:if>
              <td id="lineTableBudgetTd" style="width:90px; " align="right">
                    <xsl:text>
                    </xsl:text>
                    <xsl:value-of select="format-number(cbc:Amount, '###.##0,00', 'european')" />
                    <xsl:if test="cbc:Amount/@currencyID">
                      <xsl:text>
                      </xsl:text>
                      <xsl:if test="cbc:Amount/@currencyID = 'TRL' or cbc:Amount/@currencyID = 'TRY'">
                        <xsl:text>TL</xsl:text>
                      </xsl:if>
                      <xsl:if test="cbc:Amount/@currencyID != 'TRL' and cbc:Amount/@currencyID != 'TRY'">
                        <xsl:value-of select="cbc:Amount/@currencyID" />
                      </xsl:if>
                    </xsl:if>              
              </td>
            </tr>
       </xsl:if>
     </xsl:for-each>

          <xsl:for-each select="n1:Invoice/cac:TaxTotal/cac:TaxSubtotal">
            <xsl:if test="cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode = '4171'">
              <tr id="budgetContainerTr" align="right">
                <td id="budgetContainerDummyTd" />
                <td id="lineTableBudgetTd" align="right" width="210px">
                  <span style="font-weight:bold; color:#000000;">
                    <xsl:text>KDV Matrahı</xsl:text>
                  </span>
                </td>
                <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                  <td id="lineTableBudgetTd" align="left" width="180px">
                    <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                      <xsl:text>  VAT Basis</xsl:text>
                    </span>
                  </td>
                </xsl:if>
                <td id="lineTableBudgetTd" style="width:90px; " align="right">
                  <xsl:value-of select="format-number(sum(//n1:Invoice/cac:TaxTotal/cac:TaxSubtotal[cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode=0015]/cbc:TaxableAmount), '###.##0,00', 'european')" />
                  <xsl:if test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount/@currencyID">
                    <xsl:text>
                    </xsl:text>
                    <xsl:if test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount/@currencyID = 'TRL' or //n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount/@currencyID = 'TRY'">
                      <xsl:text>TL</xsl:text>
                    </xsl:if>
                    <xsl:if test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount/@currencyID != 'TRL' and //n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount/@currencyID != 'TRY'">
                      <xsl:value-of select="//n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount/@currencyID" />
                    </xsl:if>
                  </xsl:if>
                </td>
              </tr>
              <tr id="budgetContainerTr" align="right">
                <td id="budgetContainerDummyTd" />
                <td id="lineTableBudgetTd" align="right" width="210px">
                  <span style="font-weight:bold; color:#000000;">
                    <xsl:text>Tevkifat Dahil Toplam Tutar</xsl:text>
                  </span>
                </td>
                <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                  <td id="lineTableBudgetTd" align="left" width="180px">
                    <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                      <xsl:text>  Total Amount Including Withholding</xsl:text>
                    </span>
                  </td>
                </xsl:if>
                <td id="lineTableBudgetTd" style="width:90px; " align="right">
                  <xsl:for-each select="n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount">
                    <xsl:call-template name="Curr_Type" />
                  </xsl:for-each>
                </td>
              </tr>
              <tr id="budgetContainerTr" align="right">
                <td id="budgetContainerDummyTd" />
                <td id="lineTableBudgetTd" align="right" width="210px">
                  <span style="font-weight:bold; color:#000000;">
                    <xsl:text>Tevkifat Hariç Toplam Tutar</xsl:text>
                  </span>
                </td>
                <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                  <td id="lineTableBudgetTd" align="left" width="180px">
                    <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                      <xsl:text>  Total Amount Excluding Withholding</xsl:text>
                    </span>
                  </td>
                </xsl:if>
                <td id="lineTableBudgetTd" style="width:90px; " align="right">
                  <xsl:for-each select="n1:Invoice/cac:LegalMonetaryTotal/cbc:PayableAmount">
                    <xsl:call-template name="Curr_Type" />
                  </xsl:for-each>
                </td>
              </tr>
            </xsl:if>
          </xsl:for-each>
          <xsl:for-each select="n1:Invoice/cac:WithholdingTaxTotal/cac:TaxSubtotal">
            <tr id="budgetContainerTr" align="right">
              <td id="budgetContainerDummyTd" />
              <td id="lineTableBudgetTd" width="210px" align="right">
                <span style="font-weight:bold; color:#000000;">
                  <xsl:text>Hesaplanan KDV Tevkifat</xsl:text>
                  <xsl:text>(%</xsl:text>
                  <xsl:value-of select="cbc:Percent" />
                  <xsl:text>)</xsl:text>
                </span>
              </td>
              <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                <td id="lineTableBudgetTd" width="180px" align="left">
                  <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                    <xsl:text>  Reverse Charge Output VAT </xsl:text>
                    <xsl:text>(</xsl:text>
                    <xsl:value-of select="cbc:Percent" />
                    <xsl:text>%)</xsl:text>
                  </span>
                </td>
              </xsl:if>
              <td id="lineTableBudgetTd" style="width:90px; " align="right">
                <xsl:for-each select="cac:TaxCategory/cac:TaxScheme">
                  <xsl:text>
                  </xsl:text>
                  <xsl:value-of select="format-number(../../cbc:TaxAmount, '###.##0,00', 'european')" />
                  <xsl:if test="../../cbc:TaxAmount/@currencyID">
                    <xsl:text>
                    </xsl:text>
                    <xsl:if test="../../cbc:TaxAmount/@currencyID = 'TRL' or ../../cbc:TaxAmount/@currencyID = 'TRY'">
                      <xsl:text>TL</xsl:text>
                    </xsl:if>
                    <xsl:if test="../../cbc:TaxAmount/@currencyID != 'TRL' and ../../cbc:TaxAmount/@currencyID != 'TRY'">
                      <xsl:value-of select="../../cbc:TaxAmount/@currencyID" />
                    </xsl:if>
                  </xsl:if>
                </xsl:for-each>
              </td>
            </tr>
          </xsl:for-each>

          <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cbc:InsuranceValueAmount">
            <tr id="budgetContainerTr" align="right">
              <td id="budgetContainerDummyTd" />
              <td id="lineTableBudgetTd" width="210px" align="right">
                <span style="font-weight:bold; color:#000000;">
                  <xsl:text>Sigorta Tutarı</xsl:text>
                </span>
              </td>
              <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                <td id="lineTableBudgetTd" width="180px" align="left">
                  <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                    <xsl:text>  Insurance Total</xsl:text>
                  </span>
                </td>
              </xsl:if>
              <td id="lineTableBudgetTd" style="width:90px; " align="right">
                <xsl:value-of select="format-number(sum(//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cbc:InsuranceValueAmount), '###.##0,00', 'european')" />
                <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY'">
                  <xsl:text> TL</xsl:text>
                </xsl:if>
                <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY'">
                  <xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode" />
                </xsl:if>
              </td>
            </tr>
          </xsl:if>

          <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cbc:DeclaredForCarriageValueAmount">
            <tr id="budgetContainerTr" align="right">
              <td id="budgetContainerDummyTd" />
              <td id="lineTableBudgetTd" width="210px" align="right">
                <span style="font-weight:bold; color:#000000;">
                  <xsl:text>Navlun Tutarı</xsl:text>
                </span>
              </td>
              <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                <td id="lineTableBudgetTd" width="180px" align="left">
                  <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                    <xsl:text>  Freight Total</xsl:text>
                  </span>
                </td>
              </xsl:if>
              <td id="lineTableBudgetTd" style="width:90px; " align="right">
                <xsl:value-of select="format-number(sum(//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cbc:DeclaredForCarriageValueAmount), '###.##0,00', 'european')" />
                <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY'">
                  <xsl:text> TL</xsl:text>
                </xsl:if>
                <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY'">
                  <xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode" />
                </xsl:if>
              </td>
            </tr>
          </xsl:if>

          <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cbc:FreeOnBoardValueAmount">
            <tr id="budgetContainerTr" align="right">
              <td id="budgetContainerDummyTd" />
              <td id="lineTableBudgetTd" width="210px" align="right">
                <span style="font-weight:bold; color:#000000;">
                  <xsl:value-of select="substring-before(substring-after(.,'#AÇIKLAMA:'),'~;')" />
                </span>
              </td>
              <td id="lineTableBudgetTd" width="180px" align="left">
                <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                </span>
              </td>
              <td id="lineTableBudgetTd" style="width:90px; " align="right">
                <xsl:value-of select="format-number(sum(//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cbc:FreeOnBoardValueAmount), '###.##0,00', 'european')" />
                <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRL' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRY'">
                  <xsl:text> TL</xsl:text>
                </xsl:if>
                <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRL' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRY'">
                  <xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode" />
                </xsl:if>
              </td>
            </tr>
          </xsl:if>

          <!-- <xsl:if test="contains(.,'#NAVLUN:')">
                  <tr id="budgetContainerTr" align="right">
                     <td id="budgetContainerDummyTd"/>
                     <td id="lineTableBudgetTd" width="210px" align="right">
                        <span style="font-weight:bold; color:#000000;">
                           <xsl:text>Navlun Tutarı</xsl:text>
                        </span>
                     </td>
                     <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                        <td id="lineTableBudgetTd" width="180px" align="left">
                           <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                              <xsl:text>&#160;&#160;Freight Total</xsl:text>
                           </span>
                        </td>
                     </xsl:if>
                     <td id="lineTableBudgetTd" style="width:90px; " align="right">
                        <xsl:value-of select="substring-before(substring-after(.,'#NAVLUN:'),'~;')"/>
                        &#160;
                        <xsl:if test="n1:Invoice/cbc:DocumentCurrencyCode = 'TRL' or n1:Invoice/cbc:DocumentCurrencyCode = 'TRY'">
                           <xsl:text>TL</xsl:text>
                        </xsl:if>
                        <xsl:if test="n1:Invoice/cbc:DocumentCurrencyCode != 'TRL' and n1:Invoice/cbc:DocumentCurrencyCode != 'TRY'">
                           <xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode"/>
                        </xsl:if>
                     </td>
                  </tr>
               </xsl:if>-->
          <!-- <xsl:if test="contains(.,'#SIGORTA:')">
                  <tr id="budgetContainerTr" align="right">
                     <td id="budgetContainerDummyTd"/>
                     <td id="lineTableBudgetTd" width="210px" align="right">
                        <span style="font-weight:bold; color:#000000;">
                           <xsl:text>Sigorta Tutarı</xsl:text>
                        </span>
                     </td>
                     <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                        <td id="lineTableBudgetTd" width="180px" align="left">
                           <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                              <xsl:text>&#160;&#160;Insurance Total</xsl:text>
                           </span>
                        </td>
                     </xsl:if>
                     <td id="lineTableBudgetTd" style="width:90px; " align="right">
                        <xsl:value-of select="substring-before(substring-after(.,'#SIGORTA:'),'~;')"/>
                        &#160;
                        <xsl:if test="n1:Invoice/cbc:DocumentCurrencyCode = 'TRL' or n1:Invoice/cbc:DocumentCurrencyCode = 'TRY'">
                           <xsl:text>TL</xsl:text>
                        </xsl:if>
                        <xsl:if test="n1:Invoice/cbc:DocumentCurrencyCode != 'TRL' and n1:Invoice/cbc:DocumentCurrencyCode != 'TRY'">
                           <xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode"/>
                        </xsl:if>
                     </td>
                  </tr>
               </xsl:if> -->

          <xsl:if test="n1:Invoice/cac:LegalMonetaryTotal/cbc:ChargeTotalAmount !=0">
            <tr id="budgetContainerTr" align="right">
              <td id="budgetContainerDummyTd" />
              <td id="lineTableBudgetTd" align="right" width="210px">
                <span style="font-weight:bold;color:#000000;">
                  <xsl:text>Toplam Masraf</xsl:text>
                </span>
              </td>
              <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                <td id="lineTableBudgetTd" align="left" width="180px">
                  <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                    <xsl:text> Charge Total Amount</xsl:text>
                  </span>
                </td>
              </xsl:if>
              <td id="lineTableBudgetTd" style="width:90px; " align="right">
                <xsl:for-each select="n1:Invoice/cac:LegalMonetaryTotal/cbc:ChargeTotalAmount">
                  <xsl:call-template name="Curr_Type" />
                </xsl:for-each>
              </td>
            </tr>
          </xsl:if>

          <xsl:if test="//n1:Invoice/cbc:ProfileID != 'IHRACAT'">
            <tr id="budgetContainerTr" align="right">
              <td id="budgetContainerDummyTd" />
              <td id="lineTableBudgetTd" width="210px" align="right">
                <span style="font-weight:bold; color:#000000;">
                  <xsl:text>Vergiler Dahil Toplam Tutar</xsl:text>
                </span>
              </td>
              <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                <td id="lineTableBudgetTd" width="180px" align="left">
                  <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                    <xsl:text>  Total Amount Including Taxes</xsl:text>
                  </span>
                </td>
              </xsl:if>
              <td id="lineTableBudgetTd" style="width:90px; " align="right">
                <xsl:for-each select="n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount">
                  <xsl:call-template name="Curr_Type" />
                </xsl:for-each>
              </td>
            </tr>
            <tr id="budgetContainerTr" align="right">
              <td id="budgetContainerDummyTd" />
              <td id="lineTableBudgetTd" width="210px" align="right">
                <span style="font-weight:bold; color:#000000;">
                  <xsl:text>Ödenecek Tutar</xsl:text>
                </span>
              </td>
              <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                <td id="lineTableBudgetTd" width="180px" align="left">
                  <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                    <xsl:text>  Amount To Be Paid</xsl:text>
                  </span>
                </td>
              </xsl:if>
              <td id="lineTableBudgetTd" style="width:90px; " align="right">
                <xsl:for-each select="n1:Invoice/cac:LegalMonetaryTotal/cbc:PayableAmount">
                  <xsl:call-template name="Curr_Type" />
                </xsl:for-each>
              </td>
            </tr>
            <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
              <tr align="right">
                <td />
                <td id="lineTableBudgetTd" width="210px" align="right">
                  <span style="font-weight:bold; color:#000000;">
                    <xsl:text>Döviz Kuru</xsl:text>
                  </span>
                </td>
                <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                  <td id="lineTableBudgetTd" width="180px" align="left">
                    <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                      <xsl:text>  Exchange Rate</xsl:text>
                    </span>
                  </td>
                </xsl:if>
                <td id="lineTableBudgetTd" style="width:90px; " align="right">
                  <xsl:value-of select="format-number(//n1:Invoice/cac:PricingExchangeRate/cbc:CalculationRate, '###.##0,0000', 'european')" />
                  <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY'">
                    <xsl:text> TL</xsl:text>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY'">
                                  
                                 <xsl:value-of select="//n1:Invoice/cbc:DocumentCurrencyCode" /></xsl:if>
                </td>
              </tr>
              <tr align="right">
                <td />
                <td id="lineTableBudgetTd" align="right" width="210px">
                  <span style="font-weight:bold; color:#000000;">
                    <xsl:text>Mal Hizmet Toplam Tutarı(TL)</xsl:text>
                  </span>
                </td>
                <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                  <td id="lineTableBudgetTd" align="left" width="180px">
                    <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                      <xsl:text>  Goods/Service Total Amount(TL)</xsl:text>
                    </span>
                  </td>
                </xsl:if>
                <td id="lineTableBudgetTd" style="width:90px; " align="right">
                  <xsl:value-of select="format-number(//n1:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount * //n1:Invoice/cac:PricingExchangeRate/cbc:CalculationRate, '###.##0,00', 'european')" />
                  <xsl:text> TL</xsl:text>
                </td>
              </tr>
              <xsl:if test="n1:Invoice/cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount !=0">
                <tr id="budgetContainerTr" align="right">
                  <td id="budgetContainerDummyTd" />
                  <td id="lineTableBudgetTd" align="right" width="210px">
                    <span style="font-weight:bold;color:#000000;">
                      <xsl:text>Toplam İskonto (TL)</xsl:text>
                    </span>
                  </td>
                  <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                    <td id="lineTableBudgetTd" align="left" width="180px">
                      <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                        <xsl:text>  Total Discount (TL)</xsl:text>
                      </span>
                    </td>
                  </xsl:if>
                  <td id="lineTableBudgetTd" style="width:90px; " align="right">
                    <xsl:value-of select="format-number(//n1:Invoice/cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount * //n1:Invoice/cac:PricingExchangeRate/cbc:CalculationRate, '###.##0,00', 'european')" />
                    <xsl:text> TL</xsl:text>
                  </td>
                </tr>
              </xsl:if>
              <xsl:if test="not(//n1:Invoice/cbc:ProfileID = 'YATIRIMTESVIK' and //n1:Invoice/cbc:InvoiceTypeCode = 'ISTISNA') and //n1:Invoice/cbc:InvoiceTypeCode != 'YTBISTISNA'">
              <xsl:for-each select="n1:Invoice/cac:TaxTotal/cac:TaxSubtotal">
                <tr align="right">
                  <td />
                  <td id="lineTableBudgetTd" align="right" width="210px">
                    <span style="font-weight:bold; color:#000000;">
                      <xsl:text>Hesaplanan </xsl:text>
                      <xsl:value-of select="cac:TaxCategory/cac:TaxScheme/cbc:Name" />
                      <xsl:text>(%</xsl:text>
                      <xsl:value-of select="cbc:Percent" />
                      <xsl:text>) (TL)</xsl:text>
                    </span>
                  </td>
                  <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                    <td id="lineTableBudgetTd" align="left" width="180px">
                      <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                        <xsl:text>  Tax Percent</xsl:text>
                        <xsl:text>(</xsl:text>
                        <xsl:value-of select="cbc:Percent" />
                        <xsl:text>%) (TL)</xsl:text>
                      </span>
                    </td>
                  </xsl:if>
                  <td id="lineTableBudgetTd" style="width:90px; " align="right">
                    <span>
                      <xsl:value-of select="format-number(cbc:TaxAmount * //n1:Invoice/cac:PricingExchangeRate/cbc:CalculationRate, '###.##0,00', 'european')" />
                      <xsl:text> TL</xsl:text>
                    </span>
                  </td>
                </tr>
              </xsl:for-each>
              </xsl:if>
              <xsl:for-each select="n1:Invoice/cac:WithholdingTaxTotal/cac:TaxSubtotal">
                <tr id="budgetContainerTr" align="right">
                  <td id="budgetContainerDummyTd" />
                  <td id="lineTableBudgetTd" width="210px" align="right">
                    <span style="font-weight:bold; color:#000000;">
                      <xsl:text>Hesaplanan KDV Tevkifat </xsl:text>
                      <xsl:text>(%</xsl:text>
                      <xsl:value-of select="cbc:Percent" />
                      <xsl:text>) (TL)</xsl:text>
                    </span>
                  </td>
                  <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                    <td id="lineTableBudgetTd" width="180px" align="left">
                      <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                        <xsl:text>  Reverse Charge Output VAT </xsl:text>
                        <xsl:text>(</xsl:text>
                        <xsl:value-of select="cbc:Percent" />
                        <xsl:text>%)</xsl:text>
                      </span>
                    </td>
                  </xsl:if>
                  <td id="lineTableBudgetTd" style="width:90px; " align="right">
                    <xsl:for-each select="cac:TaxCategory/cac:TaxScheme">
                      <xsl:text>
                      </xsl:text>
                      <xsl:value-of select="format-number(../../cbc:TaxAmount   * //n1:Invoice/cac:PricingExchangeRate/cbc:CalculationRate , '###.##0,00', 'european')" />
                      <xsl:text> TL</xsl:text>
                    </xsl:for-each>
                  </td>
                </tr>
              </xsl:for-each>
            </xsl:if>
            <xsl:if test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount/@currencyID != 'TRL' and //n1:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount/@currencyID != 'TRY'">
              <tr id="budgetContainerTr" align="right">
                <td />
                <td id="lineTableBudgetTd" width="210px" align="right">
                  <span style="font-weight:bold; color:#000000;">
                    <xsl:text>Vergiler Dahil Toplam Tutar(TL)</xsl:text>
                  </span>
                </td>
                <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                  <td id="lineTableBudgetTd" width="180px" align="left">
                    <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                      <xsl:text>  Total Amount Including Taxes(TL)</xsl:text>
                    </span>
                  </td>
                </xsl:if>
                <td id="lineTableBudgetTd" style="width:90px; " align="right">
                  <xsl:value-of select="format-number(//n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount * //n1:Invoice/cac:PricingExchangeRate/cbc:CalculationRate, '###.##0,00', 'european')" />
                  <xsl:text> TL</xsl:text>
                </td>
              </tr>
              <tr align="right">
                <td />
                <td id="lineTableBudgetTd" width="210px" align="right">
                  <span style="font-weight:bold; color:#000000;">
                    <xsl:text>Ödenecek Tutar(TL)</xsl:text>
                  </span>
                </td>
                <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                  <td id="lineTableBudgetTd" width="180px" align="left">
                    <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                      <xsl:text>  Amount To Be Paid(TL)</xsl:text>
                    </span>
                  </td>
                </xsl:if>
                <td id="lineTableBudgetTd" style="width:90px; " align="right">
                  <xsl:value-of select="format-number(//n1:Invoice/cac:LegalMonetaryTotal/cbc:PayableAmount * //n1:Invoice/cac:PricingExchangeRate/cbc:CalculationRate, '###.##0,00', 'european')" />
                  <xsl:text> TL</xsl:text>
                </td>
              </tr>
            </xsl:if>
          </xsl:if>
          <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
            <tr id="budgetContainerTr" align="right">
              <td id="budgetContainerDummyTd" />
              <td id="lineTableBudgetTd" width="210px" align="right">
                <span style="font-weight:bold; color:#000000;">
                  <xsl:text>  Toplam Tutar</xsl:text>
                </span>
              </td>
              <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                <td id="lineTableBudgetTd" width="180px" align="left">
                  <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                    <xsl:text>  Total </xsl:text>
                    <xsl:value-of select="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryTerms/cbc:ID" />
                  </span>
                </td>
              </xsl:if>
              <td id="lineTableBudgetTd" style="width:90px; " align="right">
                <xsl:for-each select="n1:Invoice/cac:LegalMonetaryTotal/cbc:PayableAmount">
                  <xsl:call-template name="Curr_Type" />
                </xsl:for-each>
              </td>
            </tr>
          </xsl:if>
        </table>
        <xsl:if test="//n1:Invoice/cbc:InvoiceTypeCode = 'SGK'">
          <table border="1" width="250px" style="font-size: 10px; font-weight: bold">
            <tr>
              <td>İlave Fatura Tipi</td>
              <td>
                <xsl:value-of select="//n1:Invoice/cbc:AccountingCost" />
              </td>
            </tr>
            <xsl:for-each select="//n1:Invoice/cac:AdditionalDocumentReference">
              <xsl:if test="cbc:DocumentTypeCode = 'MUKELLEF_KODU'">
                <tr>
                  <td>
                    <xsl:value-of select="cbc:DocumentDescription" />
                  </td>
                  <td>
                    <xsl:value-of select="cbc:DocumentType" />
                  </td>
                </tr>
              </xsl:if>
            </xsl:for-each>
            <xsl:for-each select="//n1:Invoice/cac:AdditionalDocumentReference">
              <xsl:if test="cbc:DocumentTypeCode = 'MUKELLEF_ADI'">
                <tr>
                  <td>
                    <xsl:value-of select="cbc:DocumentDescription" />
                  </td>
                  <td>
                    <xsl:value-of select="cbc:DocumentType" />
                  </td>
                </tr>
              </xsl:if>
            </xsl:for-each>
            <xsl:for-each select="//n1:Invoice/cac:AdditionalDocumentReference">
              <xsl:if test="cbc:DocumentTypeCode = 'DOSYA_NO'">
                <tr>
                  <td>
                    <xsl:value-of select="cbc:DocumentDescription" />
                  </td>
                  <td>
                    <xsl:value-of select="cbc:DocumentType" />
                  </td>
                </tr>
              </xsl:if>
            </xsl:for-each>
            <xsl:if test="//n1:Invoice/cac:InvoicePeriod">
              <td colspan="2">
                     Dönem :  <xsl:value-of select="//n1:Invoice/cac:InvoicePeriod/cbc:StartDate" />  |  <xsl:value-of select="//n1:Invoice/cac:InvoicePeriod/cbc:EndDate" /></td>
            </xsl:if>
          </table>
        </xsl:if>
        <xsl:if test="//n1:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/app:InvoiceAppExtension/app:Branding/app:StampBase64">
          <table align="right" border="0" width="800px">
            <tr>
              <td align="right">
                <img alt="" style="max-width:140px;max-height:140px;">
                  <xsl:attribute name="src">
                    <xsl:value-of select="//n1:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/app:InvoiceAppExtension/app:Branding/app:StampBase64" />
                  </xsl:attribute>
                </img>
              </td>
            </tr>
          </table>
        </xsl:if>
        <table id="notesTable" width="800px" height="100">
          <tbody>
            <tr align="left">
              <td id="notesTableTd">
                <xsl:for-each select="//n1:Invoice/cac:TaxTotal/cac:TaxSubtotal">
                  <xsl:if test=" cac:TaxCategory/cbc:TaxExemptionReasonCode !='' ">
                    <b>      Vergi İstisna Muafiyet Sebebi: </b>
                    <xsl:value-of select="cac:TaxCategory/cbc:TaxExemptionReasonCode" />
                    <xsl:text>-</xsl:text>
                    <xsl:value-of select="cac:TaxCategory/cbc:TaxExemptionReason" />
                    <br />
                  </xsl:if>
                </xsl:for-each>
                <xsl:for-each select="//n1:Invoice/cac:WithholdingTaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
                  <b>      Tevkifat Sebebi: </b>
                  <xsl:value-of select="cbc:TaxTypeCode" />
                  <xsl:text>-</xsl:text>
                  <xsl:value-of select="cbc:Name" />
                  <br />
                </xsl:for-each>
                  <xsl:if test="//n1:Invoice/cbc:ProfileID = 'YATIRIMTESVIK' or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBISTISNA' or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBSATIS' or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBIADE' or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBTEVKIFAT' or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBTEVKIFATIADE'">
                  <b>      Yatırım Teşvik No: </b>
                  <xsl:value-of select="//n1:Invoice/cac:ContractDocumentReference/cbc:ID[@schemeID = 'YTBNO']"/>
                  <br/>
                   <b>      Yatırım Teşvik Tarihi: </b>
                  <xsl:value-of select="//n1:Invoice/cac:ContractDocumentReference[cbc:ID[@schemeID = 'YTBNO']]/cbc:IssueDate"/>
                  <br/>
                </xsl:if>
                <xsl:if test="//n1:Invoice/cac:PricingExchangeRate/cbc:CalculationRate !=0 and //n1:Invoice/cac:PricingExchangeRate/cbc:CalculationRate !=1">
                  <b>
                                   
                              <xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode" />
                              Döviz Kuru: 
                           </b>
                  <xsl:value-of select="format-number(//n1:Invoice/cac:PricingExchangeRate/cbc:CalculationRate, '###.##0,0000', 'european')" />
                  <br />
                </xsl:if>
                <b>
                </b>
                <xsl:for-each select="//n1:Invoice/cbc:Note">
                  <xsl:if test="not(contains(.,'#GTB_REFNO:'))">
                    <xsl:if test="not(contains(.,'#AÇIKLAMA:'))">
                      <xsl:if test="not(contains(.,'#NAVLUN:'))">
                        <xsl:if test="not(contains(.,'#SIGORTA:'))">
                          <xsl:if test=".">
                            <b>     </b>
                            <xsl:value-of select="." />
                            <br />
                          </xsl:if>
                        </xsl:if>
                      </xsl:if>
                    </xsl:if>
                  </xsl:if>
                </xsl:for-each>
                
                <xsl:if test="(//n1:Invoice/cac:PaymentMeans)[1]/cbc:InstructionNote">
                  <b>      Ödeme Notu: </b>
                  <xsl:value-of select="(//n1:Invoice/cac:PaymentMeans)[1]/cbc:InstructionNote" />
                  <br />
                </xsl:if>
                <xsl:if test="(//n1:Invoice/cac:PaymentMeans)[1]/cac:PayeeFinancialAccount/cbc:ID">
                  <b>      Ödeme İban: </b>
                  <xsl:value-of select="(//n1:Invoice/cac:PaymentMeans)[1]/cac:PayeeFinancialAccount/cbc:ID" />
                  <br />
                </xsl:if>
                <xsl:if test="(//n1:Invoice/cac:PaymentMeans)[1]/cac:PayeeFinancialAccount/cbc:PaymentNote">
                  <b>      Hesap Açıklaması: </b>
                  <xsl:value-of select="(//n1:Invoice/cac:PaymentMeans)[1]/cac:PayeeFinancialAccount/cbc:PaymentNote" />
                  <br />
                </xsl:if>
                <xsl:if test="count(//n1:Invoice/cac:PaymentMeans) &gt; 1">
                  <b>      Diğer Hesaplar: </b>
                  <xsl:for-each select="//n1:Invoice/cac:PaymentMeans[position() &gt; 1]">
                    <br />      <xsl:value-of select="cac:PayeeFinancialAccount/cbc:PaymentNote" /><xsl:text> - </xsl:text><xsl:value-of select="cac:PayeeFinancialAccount/cbc:ID" />
                  </xsl:for-each>
                  <br />
                </xsl:if>
                <xsl:if test="//n1:Invoice/cac:PaymentTerms/cbc:Note">
                  <b>      Ödeme Koşulu: </b>
                  <xsl:value-of select="//n1:Invoice/cac:PaymentTerms/cbc:Note" />
                  <br />
                </xsl:if>
        
               <!-- <xsl:if test="//n1:Invoice/cac:BillingReference/cac:InvoiceDocumentReference/cbc:ID">
                  <b>      İade Fatura No: </b>
                  <xsl:value-of select="//n1:Invoice/cac:BillingReference/cac:InvoiceDocumentReference/cbc:ID" />
                  <br />
                  <b>      İade Fatura Tarih: </b>
                  <xsl:value-of select="//n1:Invoice/cac:BillingReference/cac:InvoiceDocumentReference/cbc:IssueDate" />
                  <br />
                </xsl:if> -->
        
                <xsl:if test="//n1:Invoice/cac:AdditionalDocumentReference[cbc:ID='HideDespatchMessage']">
                  <xsl:for-each select="//n1:Invoice/cac:AdditionalDocumentReference">
                    <xsl:if test="cbc:ID = 'HideDespatchMessage' and cbc:DocumentType = 'false'">
                      <xsl:if test="not(//n1:Invoice/cac:DespatchDocumentReference/cbc:ID and //n1:Invoice/cac:DespatchDocumentReference/cbc:IssueDate)">
                        <tr align="left">
                          <td>
                            <b>      İrsaliye yerine geçer. </b>
                          </td>
                        </tr>
                      </xsl:if>
                    </xsl:if>
                  </xsl:for-each>
                </xsl:if>
                <xsl:if test="not(//n1:Invoice/cac:AdditionalDocumentReference[cbc:ID='HideDespatchMessage'])">
                  <xsl:if test="not(//n1:Invoice/cac:DespatchDocumentReference/cbc:ID and //n1:Invoice/cac:DespatchDocumentReference/cbc:IssueDate)">
                    <tr align="left">
                      <td>
                        <b>      İrsaliye yerine geçer. </b>
                      </td>
                    </tr>
                  </xsl:if>
                </xsl:if>
        <xsl:if test="//n1:Invoice/cac:BillingReference/cac:InvoiceDocumentReference/cbc:DocumentTypeCode[text() = 'İADE' or text() = 'IADE']">
          <table id="lineTable" width="800"> 
            <tbody>
              <tr align="left" class="lineTableTr">
                <td class="lineTableTd">
                  <span style="font-weight:bold; " align="center">İade Fatura No</span>
                </td>
                <td class="lineTableTd">
                  <span style="font-weight:bold; " align="center">İade İade Tarihi</span>
                </td>
              </tr>
              <xsl:for-each select="//n1:Invoice/cac:BillingReference/cac:InvoiceDocumentReference/cbc:DocumentTypeCode[text() = 'İADE' or text() = 'IADE']">
                <tr align="left" class="lineTableTr">
                  <td class="lineTableTd">
                    <xsl:value-of select="../cbc:ID"/>
                  </td>
                  <td class="lineTableTd"> 
                  <xsl:for-each select="../cbc:IssueDate">
                      <xsl:apply-templates select="."/>
                  </xsl:for-each>
                  </td>
                </tr>
              </xsl:for-each>
            </tbody>
          </table>
        </xsl:if>
                <xsl:if test="//n1:Invoice/cbc:ProfileID = 'EARSIVFATURA'">
                  <xsl:for-each select="//n1:Invoice/cac:AdditionalDocumentReference">
                    <xsl:if test="cbc:ID = 'IsInternetSale' and cbc:DocumentType = 'true'">
                      <table class="eArchiveDetailTable" id="lineTable" width="800" height="50" border="1px">
                        <tr align="center">
                          <td style="font-weight:bold; color:#000000;" colspan="2">
                            <b>DİĞER DETAY BİLGİLER</b>
                          </td>
                        </tr>
                        <tr>
                          <td style="font-weight:bold; color:#000000;"> <b>Web Sitesi:</b></td>
                          <td>                 
                                 <xsl:value-of select="//n1:Invoice/cac:AdditionalDocumentReference/cac:IssuerParty/cbc:WebsiteURI" /></td>
                        </tr>
                        <tr>
                          <td style="font-weight:bold; color:#000000;"> <b>Ödeme Şekli:</b></td>
                          <td>
                            <xsl:for-each select="//n1:Invoice/cac:PaymentMeans">
                              <xsl:if test="cbc:PaymentMeansCode = 1"> ODEMEARACISI</xsl:if>
                              <xsl:if test="cbc:PaymentMeansCode = 10"> KAPIDAODEME</xsl:if>
                              <xsl:if test="cbc:PaymentMeansCode = 30"> EFT/HAVALE</xsl:if>
                              <xsl:if test="cbc:PaymentMeansCode = 48"> KREDIKARTI/BANKAKARTI</xsl:if>
                              <xsl:if test="cbc:PaymentMeansCode = 97">
                                                 DIGER - 
                                                <xsl:value-of select="cbc:InstructionNote" /></xsl:if>
                            </xsl:for-each>
                          </td>
                        </tr>
                        <tr>
                          <td style="font-weight:bold; color:#000000;"> <b>Ödeme Tarihi:</b></td>
                          <td>
                            <xsl:for-each select="//n1:Invoice/cac:PaymentMeans/cbc:PaymentDueDate">
                                              
                                             <xsl:apply-templates select="." /></xsl:for-each>
                          </td>
                        </tr>
                        <xsl:if test="//n1:Invoice/cac:Delivery/cac:CarrierParty/cac:PartyIdentification/cbc:ID[@schemeID='TCKN']">
                          <tr>
                            <td style="font-weight:bold; color:#000000;"> <b>Gönderi Taşıyıcı TCKN:</b></td>
                            <td>
                                              
                                             <xsl:value-of select="//n1:Invoice/cac:Delivery/cac:CarrierParty/cac:PartyIdentification/cbc:ID[@schemeID='TCKN']" /></td>
                          </tr>
                          <tr>
                            <td style="font-weight:bold; color:#000000;"> <b>Gönderi Taşıyıcı Adı / Soyadı:</b></td>
                            <td>
                                              
                                             <xsl:value-of select="//n1:Invoice/cac:Delivery/cac:CarrierParty/cac:Person/cbc:FirstName" />
                                              
                                             <xsl:value-of select="//n1:Invoice/cac:Delivery/cac:CarrierParty/cac:Person/cbc:FamilyName" /></td>
                          </tr>
                        </xsl:if>
                        <xsl:if test="//n1:Invoice/cac:Delivery/cac:CarrierParty/cac:PartyIdentification/cbc:ID[@schemeID='VKN']">
                          <tr>
                            <td style="font-weight:bold; color:#000000;"> <b>Gönderi Taşıyıcı VKN:</b></td>
                            <td>
                                              
                                             <xsl:value-of select="//n1:Invoice/cac:Delivery/cac:CarrierParty/cac:PartyIdentification/cbc:ID[@schemeID='VKN']" /></td>
                          </tr>
                          <tr>
                            <td style="font-weight:bold; color:#000000;"> <b>Gönderi Taşıyıcı Ünvanı:</b></td>
                            <td>
                                              
                                             <xsl:value-of select="//n1:Invoice/cac:Delivery/cac:CarrierParty/cac:PartyName/cbc:Name" /></td>
                          </tr>
                        </xsl:if>
                        <tr>
                          <td style="font-weight:bold; color:#000000;"> <b>Gönderim / Hizmet İfa Tarihi:</b></td>
                          <td>
                            <xsl:for-each select="//n1:Invoice/cac:Delivery/cac:Despatch/cbc:ActualDespatchDate">
                                              
                                             <xsl:apply-templates select="." /></xsl:for-each>
                          </td>
                        </tr>
                      </table>
                    </xsl:if>
                  </xsl:for-each>
                  <table class="eArchiveTable" id="lineTable" width="800" height="50">
                    <tbody>
                      <tr align="left">
                        <td>
                          <b>   e-Arşiv İzni Kapsamında Üretilmiştir.</b>
                        </td>
                      </tr>
                      <xsl:for-each select="//n1:Invoice/cac:AdditionalDocumentReference">
                        <xsl:if test="cbc:ID = 'IsInternetSale' and cbc:DocumentType = 'true'">
                          <tr align="left">
                            <td>
                              <b>  Bu satış internet üzerinden yapılmıştır.</b>
                            </td>
                          </tr>
                        </xsl:if>
                      </xsl:for-each>
                      <xsl:for-each select="//n1:Invoice/cac:AdditionalDocumentReference">
                        <xsl:if test="cbc:ID = 'SendType' and cbc:DocumentType = 'ELEKTRONIK'">
                          <tr align="left">
                            <td>
                              <b>  e-Arşiv izni kapsamında elektronik ortamda iletilmiştir.</b>
                            </td>
                          </tr>
                        </xsl:if>
                      </xsl:for-each>
                    </tbody>
                  </table>
                  <xsl:for-each select="//n1:Invoice/cac:AdditionalDocumentReference">
                    <xsl:if test="cbc:ID = 'IsInternetSale' and cbc:DocumentType = 'true'">
                      <table class="eArchiveReturnTable" id="lineTable" width="800" height="50" border="1px">
                        <tbody>
                          <tr align="center">
                            <td style="font-weight:bold; color:#000000;">
                              <b>İADE BÖLÜMÜ</b>
                              <br />
                            </td>
                          </tr>
                          <tr align="left">
                            <td style="font-weight:bold; color:#000000;">
                              <b>      <u>İade Edenin;</u></b>
                              <br />
                              <b>      Adı Soyadı:</b>
                              <br />
                              <b>      Adresi:</b>
                              <br />
                              <b>      İmza:</b>
                              <br />
                            </td>
                          </tr>
                          <tr style="font-weight:bold; color:#000000;" align="left">
                            <td style="font-weight:bold; color:#000000;">
                              <table width="100%" align="center" border="1px">
                                <tbody>
                                  <tr style="font-weight:bold; color:#000000;" align="center" height="20">
                                    <td>
                                      <b>İade Edilen Malın Cinsi</b>
                                    </td>
                                    <td>
                                      <b>Miktar</b>
                                    </td>
                                    <td>
                                      <b>Birim Fiyat</b>
                                    </td>
                                    <td>
                                      <b>Tutar</b>
                                    </td>
                                  </tr>
                                  <tr align="center">
                                    <td> </td>
                                    <td> </td>
                                    <td> </td>
                                    <td> </td>
                                  </tr>
                                  <tr align="center">
                                    <td> </td>
                                    <td> </td>
                                    <td> </td>
                                    <td> </td>
                                  </tr>
                                </tbody>
                              </table>
                            </td>
                          </tr>
                        </tbody>
                      </table>
                    </xsl:if>
                  </xsl:for-each>
                </xsl:if>
                <table border="1" width="800px" id="bankingTable" style="font-size: 10px; font-weight: bold">
                  <caption style="text-align: left; padding: px"></caption>
          
                </table>
              </td>
            </tr>
          </tbody>
        </table>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="//cbc:IssueDate">
    <xsl:value-of select="substring(.,9,2)" />
      -
      <xsl:value-of select="substring(.,6,2)" />
      -
      <xsl:value-of select="substring(.,1,4)" /></xsl:template>
  <xsl:template match="//n1:Invoice">
    <tr id="lineTableTr">
      <td id="lineTableTd">
        <xsl:text> </xsl:text>
      </td>
      <td id="lineTableTd">
        <xsl:text> </xsl:text>
      </td>
      <td id="lineTableTd" align="right">
        <xsl:text> </xsl:text>
      </td>
      <td id="lineTableTd" align="right">
        <xsl:text> </xsl:text>
      </td>
      <td id="lineTableTd" align="right">
        <xsl:text> </xsl:text>
      </td>
      <td id="lineTableTd" align="right">
        <xsl:text> </xsl:text>
      </td>
      <td id="lineTableTd" align="right">
        <xsl:text> </xsl:text>
      </td>
      <td id="lineTableTd" align="right">
        <xsl:text> </xsl:text>
      </td>
      <td id="lineTableTd" align="right">
        <xsl:text> </xsl:text>
      </td>
      <td id="lineTableTd" align="right">
        <xsl:text> </xsl:text>
      </td>
    </tr>
  </xsl:template>
  <xsl:template name="Party_Title">
    <xsl:param name="PartyType" />
    <td style="width:469px; " align="left">
      <xsl:if test="cac:PartyIdentification/cbc:ID[@schemeID='VKN']">
        <xsl:if test="cac:PartyName">
          <b>
            <xsl:value-of select="cac:PartyName/cbc:Name" />
          </b>
        </xsl:if>
      </xsl:if>
      <xsl:if test="cac:PartyIdentification/cbc:ID[@schemeID='TCKN']">
        <b>
          <xsl:for-each select="cac:Person">
            <xsl:for-each select="cbc:FirstName">
              <xsl:apply-templates />
              <xsl:text> </xsl:text>
            </xsl:for-each>
            <xsl:for-each select="cbc:FamilyName">
              <xsl:apply-templates />
              <xsl:text> </xsl:text>
            </xsl:for-each>
          </xsl:for-each>
        </b>
      </xsl:if>
    </td>
  </xsl:template>
  <xsl:template name="Party_Adress">
    <xsl:param name="PartyType" />
    <td style="width:469px; " align="left">
      <xsl:for-each select="cac:PostalAddress">
        <xsl:for-each select="cbc:StreetName">
          <xsl:apply-templates />
          <xsl:text> </xsl:text>
        </xsl:for-each>
        <xsl:for-each select="cbc:BuildingName">
          <xsl:apply-templates />
        </xsl:for-each>
          <xsl:for-each select="cbc:BuildingNumber">
               <xsl:text> No:</xsl:text>
               <xsl:apply-templates/>
               <xsl:text>&#160;</xsl:text>
            </xsl:for-each>
            <br/>  
          <xsl:for-each select="cbc:Room">
               <xsl:text>Kapı No:</xsl:text>
               <xsl:apply-templates/>
               <xsl:text>&#160;</xsl:text>
            </xsl:for-each>
            <br/>  
        <xsl:for-each select="cbc:PostalZone">
          <xsl:apply-templates />
          <xsl:text> </xsl:text>
        </xsl:for-each>
        <xsl:if test="cbc:CitySubdivisionName !=''&#xD;&#xA;                  and  cbc:CitySubdivisionName !='-'">
          <xsl:for-each select="cbc:CitySubdivisionName">
            <xsl:apply-templates />
            <xsl:text>/ </xsl:text>
          </xsl:for-each>
        </xsl:if>
        <xsl:if test="cbc:CityName !=''&#xD;&#xA;                   and  cbc:CityName !='-'">
          <xsl:for-each select="cbc:CityName">
            <xsl:apply-templates />
            <xsl:text> </xsl:text>
          </xsl:for-each>
        </xsl:if>
        
          <br />
          <xsl:value-of select="cac:Country/cbc:Name" />
          <br />
     
      </xsl:for-each>
    </td>
  </xsl:template>
  <xsl:template name="Party_Other">
    <xsl:param name="PartyType" />
    <xsl:for-each select="cbc:WebsiteURI">
      <tr align="left">
        <td>
          <xsl:text>Web Sitesi: </xsl:text>
          <xsl:value-of select="." />
        </td>
      </tr>
    </xsl:for-each>
    <xsl:for-each select="cac:Contact/cbc:ElectronicMail">
      <tr align="left">
        <td>
          <xsl:text>E-Posta: </xsl:text>
          <xsl:value-of select="." />
        </td>
      </tr>
    </xsl:for-each>
    <xsl:for-each select="cac:Contact">
      <xsl:if test="cbc:Telephone or cbc:Telefax">
        <tr align="left">
          <td style="width:469px; " align="left">
            <xsl:for-each select="cbc:Telephone">
              <xsl:text>Tel: </xsl:text>
              <xsl:apply-templates />
            </xsl:for-each>
            <xsl:for-each select="cbc:Telefax">
              <xsl:text> Fax: </xsl:text>
              <xsl:apply-templates />
            </xsl:for-each>
            <xsl:text> </xsl:text>
          </td>
        </tr>
      </xsl:if>
    </xsl:for-each>
    <xsl:if test="$PartyType!='TAXFREE'">
      <xsl:for-each select="cac:PartyTaxScheme/cac:TaxScheme/cbc:Name">
        <tr align="left">
          <td>
            <xsl:text>Vergi Dairesi: </xsl:text>
            <xsl:apply-templates />
          </td>
        </tr>
      </xsl:for-each>
      <xsl:for-each select="cac:PartyIdentification">
        <tr align="left">
          <td>
            <xsl:value-of select="cbc:ID/@schemeID" />
            <xsl:text>: </xsl:text>
            <xsl:value-of select="cbc:ID" />
          </td>
        </tr>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>
  <xsl:template name="Curr_Type">
    <xsl:value-of select="format-number(., '###.##0,00', 'european')" />
    <xsl:if test="@currencyID">
      <xsl:text>
      </xsl:text>
      <xsl:choose>
        <xsl:when test="@currencyID = 'TRL' or @currencyID = 'TRY'">
          <xsl:text>TL</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@currencyID" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>